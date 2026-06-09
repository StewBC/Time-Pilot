//-----------------------------------------------------------------------------
// mac.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include <Dialogs.h>
#include <Events.h>
#include <Fonts.h>
#include <Gestalt.h>
#include <LowMem.h>
#include <MacTypes.h>
#include <Memory.h>
#include <Menus.h>
#include <Resources.h>
#include <Traps.h>
#include <Types.h>
#include <Windows.h>

#include "mac.h"
#include "globals.h"

#include "audio.h"
#include "input.h"
#include "resids.h"
#include "sprite.h"
#include "update.h"

#include "print.h"
#include "string.h"

static GWorldPtr sScaledOffScreen;
static PixMapHandle sScaledOffScreenPixels;
static Rect sScaledGameRect;
static uint16_t sDoublePixelTable[256];
static uint32_t sDoublePixelPairTable[65536];

static void macBlit2xAlignedPairsAsm(unsigned char *srcRow,
                                     unsigned char *destRow0,
                                     uint32_t srcRowBytes,
                                     uint32_t destRowBytes,
                                     uint32_t width,
                                     uint32_t height);

//-----------------------------------------------------------------------------
void macAnimatePalette() {
    // This does not work (and is not correct but if it doesn't work, it doesn't matter)
    if(frameCounter & 4) {
        AnimateEntry(screen, 13, &colors[15+activeStage]);
        AnimateEntry(screen, 14, &colors[16+activeStage]);
    } else {
        AnimateEntry(screen, 13, &colors[16+activeStage]);
        AnimateEntry(screen, 14, &colors[15+activeStage]);
    }
}

//-----------------------------------------------------------------------------
static void macCopyBytes(unsigned char *destPtr, unsigned char *srcPtr, uint32_t byteCount) {
    while(byteCount >= sizeof(uint32_t)) {
        *((uint32_t *) destPtr) = *((uint32_t *) srcPtr);
        destPtr += sizeof(uint32_t);
        srcPtr += sizeof(uint32_t);
        byteCount -= sizeof(uint32_t);
    }

    if(byteCount >= sizeof(uint16_t)) {
        *((uint16_t *) destPtr) = *((uint16_t *) srcPtr);
        destPtr += sizeof(uint16_t);
        srcPtr += sizeof(uint16_t);
        byteCount -= sizeof(uint16_t);
    }

    if(byteCount) {
        *destPtr = *srcPtr;
    }
}

//-----------------------------------------------------------------------------
// Copy an 8-bit indexed source image into an 8-bit indexed destination image
// while scaling it by 2x in both directions.
//
// Example:
//
// Source:
//   A B C
//   D E F
//
// Destination:
//   A A B B C C
//   A A B B C C
//   D D E E F F
//   D D E E F F
//
// There are two main execution paths:
//   1. Unaligned destination path
//      Used when the destination address is not 16-bit aligned.
//      Expands pixels one at a time.
//
//   2. Aligned destination path
//      Used when the destination address is 16-bit aligned.
//      Uses lookup tables to expand 2 pixels at once for better speed.
//
// The source and destination must both be 8-bit indexed pixmaps.
//-----------------------------------------------------------------------------
static int16_t macBlit2xIndexedToPixmap(Rect *srcCopyRect, PixMapHandle destPixels, Rect *destCopyRect)
{
    unsigned char *srcBase;
    unsigned char *destBase;
    unsigned char *srcRow;
    unsigned char *destRow0;
    unsigned char *destRow1;
    unsigned char *srcPtr;
    unsigned char *destPtr0;
    unsigned char *destPtr1;
    uint32_t srcRowBytes;
    uint32_t destRowBytes;
    uint32_t width;
    uint32_t height;
    uint32_t xCounter;
    uint32_t yCounter;
    unsigned char pixel;

    if(!destPixels || (*offScreenPixels)->pixelSize != 8 || (*destPixels)->pixelSize != 8) {
        return 0;
    }

    srcBase = (unsigned char *)GetPixBaseAddr(offScreenPixels);
    destBase = (unsigned char *)GetPixBaseAddr(destPixels);

    if(!srcBase || !destBase) {
        return 0;
    }

    srcRowBytes = (*offScreenPixels)->rowBytes & 0x3fff;
    destRowBytes = (*destPixels)->rowBytes & 0x3fff;

    width = srcCopyRect->right - srcCopyRect->left;
    height = srcCopyRect->bottom - srcCopyRect->top;

    srcRow = srcBase +
        (srcCopyRect->top - (*offScreenPixels)->bounds.top) * srcRowBytes +
        (srcCopyRect->left - (*offScreenPixels)->bounds.left);

    destRow0 = destBase +
        (destCopyRect->top - (*destPixels)->bounds.top) * destRowBytes +
        (destCopyRect->left - (*destPixels)->bounds.left);

    if(((uint32_t)destRow0) & 1) {
        // Slow-safe path.  If destRow0 is odd-aligned, do not use 16-bit or 32-bit destination
        // stores. Write bytes only.
        for(yCounter = 0; yCounter < height; yCounter++) {
            srcPtr = srcRow;
            destPtr0 = destRow0;
            destPtr1 = destRow0 + destRowBytes;

            for(xCounter = 0; xCounter < width; xCounter++) {
                pixel = *srcPtr++;

                *destPtr0++ = pixel;
                *destPtr0++ = pixel;

                *destPtr1++ = pixel;
                *destPtr1++ = pixel;
            }

            srcRow += srcRowBytes;
            destRow0 += destRowBytes << 1;
        }
    } else {
        // Fast path. Destination is 16-bit aligned, so 16-bit and 32-bit stores are safe.
        for(yCounter = 0; yCounter < height; yCounter++) {
            srcPtr = srcRow;
            destRow1 = destRow0 + destRowBytes;
            destPtr0 = destRow0;
            destPtr1 = destRow1;
            xCounter = width;

            // Fastest subpath.  If source is also 16-bit aligned, read two source pixels at once.
            // Source:
            //   A B
            // Table output:
            //   A A B B
            // Write the expanded 32-bit value to both destination rows.
            if(!(((uint32_t)srcPtr) & 1)) {
                macBlit2xAlignedPairsAsm(srcRow, destRow0, srcRowBytes, destRowBytes, width, height);
                return 1;
            } else {
                // Source is unaligned. Destination is aligned, so use 16-bit destination
                // stores, but source must be read one byte at a time.
                while(xCounter) {
                    uint16_t expandedPixel;

                    pixel = *srcPtr++;
                    expandedPixel = sDoublePixelTable[pixel];

                    *((uint16_t *)destPtr0) = expandedPixel;
                    *((uint16_t *)destPtr1) = expandedPixel;

                    destPtr0 += sizeof(uint16_t);
                    destPtr1 += sizeof(uint16_t);
                    xCounter--;
                }
            }

            srcRow += srcRowBytes;
            destRow0 += destRowBytes << 1;
        }
    }

    return 1;
}

//-----------------------------------------------------------------------------
static int16_t macBlit2xIndexedToScaledGWorld(Rect *srcCopyRect, Rect *scaledSrcRect) {
    int16_t result;

    *scaledSrcRect = *srcCopyRect;
    scaledSrcRect->top <<= 1;
    scaledSrcRect->left <<= 1;
    scaledSrcRect->right <<= 1;
    scaledSrcRect->bottom <<= 1;
    result = macBlit2xIndexedToPixmap(srcCopyRect, sScaledOffScreenPixels, scaledSrcRect);
    return result;
}

//-----------------------------------------------------------------------------
static void macBlit2xAlignedPairsAsm(unsigned char *srcRow,
                                     unsigned char *destRow0,
                                     uint32_t srcRowBytes,
                                     uint32_t destRowBytes,
                                     uint32_t width,
                                     uint32_t height) {
    uint32_t pairCount;
    uint32_t yCounter;

    pairCount = width >> 1;
    for(yCounter = 0; yCounter < height; yCounter++) {
        unsigned char *srcPtr;
        unsigned char *destPtr0;
        unsigned char *destPtr1;

        srcPtr = srcRow;
        destPtr0 = destRow0;
        destPtr1 = destRow0 + destRowBytes;

        if(pairCount) {
            uint32_t loopCounter;

            loopCounter = pairCount - 1;
            __asm__ volatile(
                "1:\n\t"
                "moveq #0,%%d0\n\t"
                "move.w (%[src])+,%/d0\n\t"
                "lsl.l #2,%/d0\n\t"
                "move.l (%[table],%/d0.l),%/d1\n\t"
                "move.l %/d1,(%[dst0])+\n\t"
                "move.l %/d1,(%[dst1])+\n\t"
                "dbra %[count],1b"
                : [src] "+a" (srcPtr),
                  [dst0] "+a" (destPtr0),
                  [dst1] "+a" (destPtr1),
                  [count] "+d" (loopCounter)
                : [table] "a" (sDoublePixelPairTable)
                : "d0", "d1", "memory");
        }

        if(width & 1) {
            uint16_t expandedPixel;

            expandedPixel = sDoublePixelTable[*srcPtr];
            *((uint16_t *)destPtr0) = expandedPixel;
            *((uint16_t *)destPtr1) = expandedPixel;
        }

        srcRow += srcRowBytes;
        destRow0 += destRowBytes << 1;
    }
}

//-----------------------------------------------------------------------------
static void macBlitToPreparedScreen(Rect *srcCopyRect) {
    Rect destCopyRect;
    Rect scaledSrcRect;

    destCopyRect = *srcCopyRect;

    if(globalScale) {
        destCopyRect.top <<= globalScale;
        destCopyRect.left <<= globalScale;
        destCopyRect.right <<= globalScale;
        destCopyRect.bottom <<= globalScale;
    }

    OffsetRect(&destCopyRect, displayPoint.h, displayPoint.v);

    if(globalScale && macBlit2xIndexedToScaledGWorld(srcCopyRect, &scaledSrcRect)) {
        CopyBits((BitMap *) (*sScaledOffScreenPixels), &(screen->portBits), &scaledSrcRect, &destCopyRect, srcCopy, (RgnHandle) nil);
    } else {
        // copy the buffer to the screen
        CopyBits((BitMap *) (*offScreenPixels), &(screen->portBits), srcCopyRect, &destCopyRect, srcCopy, (RgnHandle) nil);
    }
}

//-----------------------------------------------------------------------------
static void macBeginScreenBlits(CGrafPtr *outOldPort, GDHandle *outOldDevice) {
    // save the current port and gdevice
    GetGWorld(outOldPort, outOldDevice);

    // set the drawing environment to the screen
    SetGWorld((CWindowPtr) screen, GetMainDevice());

    // make sure that the fore and back colors are correct to prevent colorize mode
    ForeColor(blackColor);
    BackColor(whiteColor);

    // Copy the screen's color table seed into the source pixmap.
    // This will minimize CopyBits' setup time.
    long ctSeed = (*((*((*(GetGDevice()))->gdPMap))->pmTable))->ctSeed;
    (*((*offScreenPixels)->pmTable))->ctSeed = ctSeed;
    if(sScaledOffScreenPixels) {
        (*((*sScaledOffScreenPixels)->pmTable))->ctSeed = ctSeed;
    }
}

//-----------------------------------------------------------------------------
static void macEndScreenBlits(CGrafPtr oldPort, GDHandle oldDevice) {
    // restore the current port and gdevice
    SetGWorld(oldPort, oldDevice);
}

//-----------------------------------------------------------------------------
void macBlitToScreen(Rect *srcCopyRect) {
    CGrafPtr oldPort;                   // the graf port that is in place when we are called
    GDHandle oldDevice;                 // the gdevice that is in place when we are called

    LockPixels(offScreenPixels);
    if(sScaledOffScreenPixels) {
        LockPixels(sScaledOffScreenPixels);
    }

    macBeginScreenBlits(&oldPort, &oldDevice);
    macBlitToPreparedScreen(srcCopyRect);
    macEndScreenBlits(oldPort, oldDevice);
}

//-----------------------------------------------------------------------------
void macCleanup() {
    if(screen) {
        SetGWorld((CWindowPtr) screen, GetMainDevice());
        if(sScaledOffScreenPixels) {
            UnlockPixels(sScaledOffScreenPixels);
        }
        if(sScaledOffScreen) {
            DisposeGWorld(sScaledOffScreen);
        }
        UnlockPixels(offScreenPixels);
        DisposeGWorld(offScreen);
        // show the menu bar again
        macShowMenuBar();
        // hide and delete the window
        HideWindow(screen);
        DisposePalette(macPalette);
        ShowCursor();
        DisposeWindow(screen);
    }
}

//-----------------------------------------------------------------------------
void macClearScreen() {
    CGrafPtr oldPort;                   // the graf port that is in place when we are called
    GDHandle oldDevice;                 // the gdevice that is in place when we are called
    // save the current port and gdevice
    GetGWorld(&oldPort, &oldDevice);

    // set the drawing environment to the screen
    SetGWorld((CWindowPtr) screen, GetMainDevice());

    // make sure that the fore and back colors are correct to prevent colorize mode
    ForeColor(blackColor);
    BackColor(whiteColor);

    PaintRect(&screenRect);

    // restore the current port and gdevice
    SetGWorld(oldPort, oldDevice);
}

//-----------------------------------------------------------------------------
void macFill(int16_t X, int16_t Y, int16_t W, int16_t H, uint16_t color) {
    Rect fillRect = { Y, X, Y + H, X + W };
    RGBForeColor(&colors[color]);
    PaintRect(&fillRect);
    addRectToUpdate(&fillRect);
}

//-----------------------------------------------------------------------------
void macFillNoUpdate(int16_t X, int16_t Y, int16_t W, int16_t H, uint16_t color) {
    Rect fillRect = { Y, X, Y + H, X + W };
    RGBForeColor(&colors[color]);
    PaintRect(&fillRect);
}

//-----------------------------------------------------------------------------
void macHideMenuBar(void) {
    GDHandle mainScreen;                // the information on the main screen
    Rect mainScreenRect;                // the rect that bounds the menu barRgn
    RgnHandle mainScreenRgn;            // the region of the menu bar

    // record the menu bar height
    macMenuBarHeight = GetMBarHeight();

    // set the menu bar to no height
    LMSetMBarHeight(0);

    // save the original gray regions (so we can restore it later)
    macOriginalGrayRgn = NewRgn();
    CopyRgn(GetGrayRgn(), macOriginalGrayRgn);

    // make sure that the entire main screen is available (no menu bars or corners)
    mainScreenRgn = NewRgn();
    mainScreen = GetMainDevice();
    mainScreenRect = ((*mainScreen)->gdRect);
    RectRgn(mainScreenRgn, &mainScreenRect);
    UnionRgn(macOriginalGrayRgn, mainScreenRgn, GetGrayRgn());

    // draw the desktop
    PaintOne((WindowRef) nil, macOriginalGrayRgn);
}

//-----------------------------------------------------------------------------
int16_t macInit() {
    TrapType trType;
    uint32_t response;
    uint16_t tableCounter;

    // Init toolboxes
    InitGraf(&(qd.thePort));
    InitFonts();
    InitWindows();
    InitMenus();
    TEInit();
    InitDialogs((ProcPtr) nil);
    InitCursor();

    // See if _Gestalt is implemented
    if(NGetTrapAddress(_Gestalt, OSTrap) == GetToolboxTrapAddress(_Unimplemented)){
        return macShowErrorDialog("\pGestalt not implemented.  OS not compatible.  Need System 7.0.0 at least.");
    }

    // See what version is running and if not at least 7.0.0, quit
    // This might work on 604+, I don't know
    if(noErr != Gestalt(gestaltSystemVersion, &response) || response < 0x700) {
        return macShowErrorDialog("\pOS not compatible.  Need System 7.0.0 at least.");
    }

    // get the enitre heap
    MaxApplZone();

    for(tableCounter = 0; tableCounter < 256; tableCounter++) {
        sDoublePixelTable[tableCounter] = (tableCounter << 8) | tableCounter;
    }
    for(response = 0; response < 65536; response++) {
        uint32_t leftPixel = (response >> 8) & 0xff;
        uint32_t rightPixel = response & 0xff;
        sDoublePixelPairTable[response] =
            (leftPixel << 24) | (leftPixel << 16) | (rightPixel << 8) | rightPixel;
    }

    // Install our custom palette
    macSetPaletteFromResource(RID_CLUT0);
    macHideMenuBar();
    screenRect = qd.thePort->portRect;
    screen = NewCWindow(NULL,           // Heap storage
                        &screenRect,    // Use the rect of the port
                        "Time Pilot",   // Title
                        true,           // Visible
                        noGrowDocProc,  // Pre-Appearance movable window with no size box or zoom box
                        (WindowRef) - 1L, // Window in front of all others
                        false,          // close box does not exist
                        1               // reference counter
        );

    // Create the off-screen rect at the logical game size
    gameRect.left = gameRect.top = 0;
    gameRect.right = SCREENW;
    gameRect.bottom = SCREENH;
    // Prefer 2x when the display can fit it, but fall back to 1x on smaller screens.
    if(!macSetScale(2)) {
        macSetScale(1);
    }

    // Create an off screen (back) buffer the size of the screen buffer
    if(0 != NewGWorld(&offScreen,       // Handle
                      0,                // Use greatest pixel depth
                      &gameRect,        // Rect
                      NULL,             // Color Talke
                      NULL,             // ?
                      keepLocal         // ?
       )) {
        return 0;
    }
    offScreenPixels = GetGWorldPixMap(offScreen);

    sScaledGameRect.left = sScaledGameRect.top = 0;
    sScaledGameRect.right = gameRect.right << 1;
    sScaledGameRect.bottom = gameRect.bottom << 1;
    if(0 == NewGWorld(&sScaledOffScreen,
                      0,
                      &sScaledGameRect,
                      NULL,
                      NULL,
                      keepLocal)) {
        sScaledOffScreenPixels = GetGWorldPixMap(sScaledOffScreen);
        LockPixels(sScaledOffScreenPixels);
    }

    if(!(screen && offScreen && offScreenPixels)) {
        return 0;
    }
    // Set the background color to black
    RGBBackColor(&colors[TP_COLOR_BLACK]);

    // Clear the screen to black
    ShowWindow(screen);
    SetPort(screen);
    PaintRect(&screenRect);

    // Clear the offscreeen to black
    SetGWorld(offScreen, NULL);
    LockPixels(offScreenPixels);
    spriteStartDraw(offScreenPixels);
    PaintRect(&gameRect);

    if(sScaledOffScreen) {
        SetGWorld(sScaledOffScreen, NULL);
        PaintRect(&sScaledGameRect);
        SetGWorld(offScreen, NULL);
    }

    // Get KeyUp events
    SetEventMask(everyEvent | keyUpMask);
    keyMask = 0;

    // The game sprites always clip to the play area (in gameRect space, ie 0,0..w,h)
    spriteClipRect.top = spriteClipRect.left = 0;
    spriteClipRect.right = SCREEN_PLAYAREA_RIGHT;
    spriteClipRect.bottom = SCREEN_PLAYAREA_BOTTOM;

    // The mouse cursor is hidden
    HideCursor();

    return 1;
}

//-----------------------------------------------------------------------------
void macSetPaletteFromResource(int16_t res_id) {
    CTabHandle macColorTable;
    macColorTable = GetCTable(res_id);
    if(macColorTable) {
        macPalette = NewPalette((*macColorTable)->ctSize, macColorTable, pmExplicit + pmTolerant, 0);
        SetPalette((WindowPtr) - 1L, macPalette, false);
    }
}

//-----------------------------------------------------------------------------
int16_t macSetScale(int16_t scale) {
    if((gameRect.right * scale) <= (screenRect.right - screenRect.left) &&
       (gameRect.bottom * scale) <= (screenRect.bottom - screenRect.top)) {
        globalScale = scale - 1;
        displayPoint.h = ((screenRect.right - screenRect.left) - (gameRect.right * scale)) / 2;
        displayPoint.v = ((screenRect.bottom - screenRect.top) - (gameRect.bottom * scale)) / 2;
        return 1;
    } else {
        return 0;
    }
}

//-----------------------------------------------------------------------------
// Function to display an error dialog
int16_t macShowErrorDialog(const char* errorMessage) {
    DialogPtr dlog;
    short itemType;
    Handle itemHandle;
    Rect itemRect;
    // char pErrorMessage[SCOL+1];
    
    // Load the dialog resource with ID 128
    dlog = GetNewDialog(128, nil, (WindowPtr)-1);
    
    if (dlog != NULL) {
        // strcpy(&(pErrorMessage[1]), errorMessage);
        // pErrorMessage[0] = strlen(errorMessage);
        // Set the text of the second item in the dialog
        SysBeep(10);
        GetDialogItem(dlog, 2, &itemType, &itemHandle, &itemRect);
        SetDialogItemText(itemHandle, errorMessage);
        
        // Display the dialog and wait for user interaction
        ModalDialog(NULL, &itemType);
        
        // Dispose of the dialog after use
        DisposeDialog(dlog);
    }
    return 0;
}

//-----------------------------------------------------------------------------
void macShowMenuBar(void) {
    // set the menu bar to its normal height
    LMSetMBarHeight(macMenuBarHeight);

    // restore the original gray region
    SectRgn(macOriginalGrayRgn, GetGrayRgn(), GetGrayRgn());

    // draw the menu bar
    DrawMenuBar();
}

//-----------------------------------------------------------------------------
void macUpdate(WindowPtr screen) {
    EventRecord theEvent;               // a place to put an event
    CGrafPtr oldPort;                   // the graf port that is in place when we are called
    GDHandle oldDevice;                 // the gdevice that is in place when we are called

    audioUpdate();

    UnlockPixels(offScreenPixels);
    rawKey = 0;
    while(WaitNextEvent(everyEvent, &theEvent, 0L, (RgnHandle) nil) == true) {
        switch (theEvent.what) {
        case keyDown:
            rawKey = (theEvent.message & charCodeMask);
            // check to see if the user has hit cmd-q (to signal a quit)
            if((theEvent.modifiers & cmdKey)
               && ((theEvent.message & charCodeMask) == 'q')) {
                keyMask |= INPUT_QUIT;
            } else {
                inputKeyDown((theEvent.message & charCodeMask));
            }
            break;
        case keyUp:
            inputKeyUp((theEvent.message & charCodeMask));
            break;
        case updateEvt:
            BeginUpdate(screen);
            EndUpdate(screen);
        default:
            break;
        }
    }

    static int32_t displayCounter = 0;
    if(rawKey == 45) {                  // - (minus)
        if(macSetScale(1)) {
            macClearScreen();
            addRectToUpdate(&gameRect);
        }
    } else if(rawKey == 61 || rawKey == 43) { // = and +
        if(macSetScale(2)) {
            clearUpdate();
            addRectToUpdate(&gameRect);
        }
    }

    LockPixels(offScreenPixels);
    if(sScaledOffScreenPixels) {
        LockPixels(sScaledOffScreenPixels);
    }

    macBeginScreenBlits(&oldPort, &oldDevice);

    // Copy the off-screen to the screen
    if(0) {
        macBlitToPreparedScreen(&gameRect);
    } else {
        uint32_t rectCounter;           // a counter to scan all the rects
        Rect updateRect;                // the rect that needs to be updated

        // copy each of the update rects to the screen
        for(rectCounter = 0; rectCounter < getUpdateRectCount(); rectCounter++) {
            // get one of the update rects
            getUpdateRect(rectCounter, &updateRect);
            // copy the buffer to the screen
            macBlitToPreparedScreen(&updateRect);
        }
    }

    macEndScreenBlits(oldPort, oldDevice);

    // Set offScreen as active and clear it
    SetGWorld(offScreen, NULL);
    spriteStartDraw(offScreenPixels);
}
