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

#include "input.h"
#include "resids.h"
#include "sprite.h"
#include "update.h"

#include "print.h"
#include "string.h"

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
void macBlitToScreen(Rect *srcCopyRect) {
    CGrafPtr oldPort;                   // the graf port that is in place when we are called
    GDHandle oldDevice;                 // the gdevice that is in place when we are called
    Rect destCopyRect;

    destCopyRect = *srcCopyRect;

    if(globalScale) {
        destCopyRect.top <<= globalScale;
        destCopyRect.left <<= globalScale;
        destCopyRect.right <<= globalScale;
        destCopyRect.bottom <<= globalScale;
    }

    OffsetRect(&destCopyRect, displayPoint.h, displayPoint.v);

    // save the current port and gdevice
    GetGWorld(&oldPort, &oldDevice);

    // set the drawing environment to the screen
    SetGWorld((CWindowPtr) screen, GetMainDevice());

    // make sure that the fore and back colors are correct to prevent colorize mode
    ForeColor(blackColor);
    BackColor(whiteColor);

    // Copy the screen's color table seed into the source pixmap.
    // This will minimize CopyBits' setup time.
    (*((*offScreenPixels)->pmTable))->ctSeed = (*((*((*(GetGDevice()))->gdPMap))->pmTable))->ctSeed;

    // copy the buffer to the screen
    CopyBits((BitMap *) (*offScreenPixels), &(screen->portBits), srcCopyRect, &destCopyRect, srcCopy, (RgnHandle) nil);

    // restore the current port and gdevice
    SetGWorld(oldPort, oldDevice);
}

//-----------------------------------------------------------------------------
void macCleanup() {
    if(screen) {
        SetGWorld((CWindowPtr) screen, GetMainDevice());
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

    // Create the off-screen rect at 320x200
    gameRect.left = gameRect.top = 0;
    gameRect.right = 320;
    gameRect.bottom = 240;
    // And set the scale to draw this rect as, at 1
    macSetScale(1);

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

    UnlockPixels(offScreenPixels);
    rawKey = 0;
    while(WaitNextEvent(everyEvent, &theEvent, 1L, (RgnHandle) nil) == true) {
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

    // Copy the off-screen to the screen
    if(0) {
        macBlitToScreen(&gameRect);
    } else {
        uint32_t rectCounter;           // a counter to scan all the rects
        Rect updateRect;                // the rect that needs to be updated
        // copy each of the update rects to the screen
        for(rectCounter = 0; rectCounter < getUpdateRectCount(); rectCounter++) {
            // get one of the update rects
            getUpdateRect(rectCounter, &updateRect);
            // copy the buffer to the screen
            macBlitToScreen(&updateRect);
        }
    }

    // Set offScreen as active and clear it
    SetGWorld(offScreen, NULL);
    LockPixels(offScreenPixels);
    spriteStartDraw(offScreenPixels);
}
