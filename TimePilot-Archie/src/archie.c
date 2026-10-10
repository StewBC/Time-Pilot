//-----------------------------------------------------------------------------
// archie.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "archie.h"
#include "globals.h"

#include "data.h"
#include "input.h"
#include "print.h"
#include "sprite.h"
#include "update.h"

#include <archie/SWI.h>
#include <archie/video.h>

#include <kernel.h>
#include <swis.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define ARCHIE_SCREEN_MODE 13
#define ARCHIE_SHADOW_SCREEN_MODE (128 + ARCHIE_SCREEN_MODE)
#define ARCHIE_PREALLOC_SCREEN_MODE 15
#define ARCHIE_ROW_BYTES 320
#define ARCHIE_SCREEN_BYTES (ARCHIE_ROW_BYTES * SCREENH)
#define ARCHIE_BANK_1 1
#define ARCHIE_BANK_2 2
#define ARCHIE_VD_SCREEN_START 148
#define ARCHIE_VD_DISPLAY_START 149
#define ARCHIE_VD_SCREEN_SIZE 150

static uint32_t archieInitDone;
static int32_t archiePreviousMode = -1;
static int32_t archiePreviousPointer = -1;
static uint32_t archieCleanupRegistered;
static uint32_t archieUseBankedBuffers;
static uint32_t archieWriteBank;
static uint32_t archieDisplayBank;
static uint32_t archieBankStride;
static uint32_t archieWriteBufferIndex;
static uint32_t archieDisplayBufferIndex;
static uint32_t archieCapturePlayfieldRects;
static uint32_t archieLastScreenStart;
static uint32_t archieLastDisplayStart;
static unsigned char *archieBankAddr[2];
#define ARCHIE_DAMAGE_MAX 128
static Rect archieDamage[2][ARCHIE_DAMAGE_MAX];
static uint32_t archieDamageCount[2];
static uint32_t archieDamageValid[2];
static uint32_t archieDamageSky[2];
static const uint8_t archieColorLut[TP_NUM_COLORS] = {
    0,                                  // BLACK
    255,                                // WHITE
    21,                                 // RED
    233,                                // CYAN
    156,                                // MAGENTA
    96,                                 // GREEN
    169,                                // BLUE
    118,                                // YELLOW
    85,                                 // ORANGE
    208,                                // GRAY
    16,                                 // RED (DARK)
    69,                                 // GREEN (DARK)
    116,                                // YELLOW (DARK)
    32,                                 // Prop0
    5,                                  // Prop1
    9,                                  // TIME_PERIOD0_1910
    41,                                 // TIME_PERIOD1_1940
    42,                                 // TIME_PERIOD2_1970: lighter teal RGB 226666
    13,                                 // TIME_PERIOD3_1982
    0,                                  // TIME_PERIOD4_2001
};

//-----------------------------------------------------------------------------
static uint32_t archieReadVduVariable(int32_t variable) {
    int32_t variableList[2];
    int32_t value = 0;

    variableList[0] = variable;
    variableList[1] = -1;

    _kernel_swi_regs regs;
    regs.r[0] = (int)variableList;
    regs.r[1] = (int)&value;
    if(_kernel_swi(OS_ReadVduVariables, &regs, &regs)) {
        return 0;
    }

    return (uint32_t)value;
}

//-----------------------------------------------------------------------------
static void archieSetModeRaw(uint32_t mode) {
    _kernel_oswrch(22);
    _kernel_oswrch((int)mode);
}

//-----------------------------------------------------------------------------
static int32_t archieSelectWriteBank(uint32_t bank) {
    _kernel_swi_regs regs;

    regs.r[0] = OSByte_WriteVDUBank;
    regs.r[1] = (int)bank;
    regs.r[2] = 0;
    if(_kernel_swi(OS_Byte, &regs, &regs)) {
        return 0;
    }
    archieWriteBank = bank;
    return 1;
}

//-----------------------------------------------------------------------------
static int32_t archieSelectDisplayBank(uint32_t bank) {
    _kernel_swi_regs regs;

    regs.r[0] = OSByte_WriteDisplayBank;
    regs.r[1] = (int)bank;
    regs.r[2] = 0;
    if(_kernel_swi(OS_Byte, &regs, &regs)) {
        return 0;
    }
    archieDisplayBank = bank;
    return 1;
}

//-----------------------------------------------------------------------------
static void archieRefreshScreenPointers(void) {
    if(archieUseBankedBuffers && archieWriteBank >= ARCHIE_BANK_1 && archieWriteBank <= ARCHIE_BANK_2) {
        baseAddr = archieBankAddr[archieWriteBank - ARCHIE_BANK_1];
    } else {
        baseAddr = (unsigned char *)archieReadVduVariable(ARCHIE_VD_SCREEN_START);
    }
}

//-----------------------------------------------------------------------------
static unsigned char *archieDisplayAddress(void) {
    if(archieUseBankedBuffers && archieDisplayBank >= ARCHIE_BANK_1 && archieDisplayBank <= ARCHIE_BANK_2) {
        return archieBankAddr[archieDisplayBank - ARCHIE_BANK_1];
    }
    return (unsigned char *)archieReadVduVariable(ARCHIE_VD_DISPLAY_START);
}

//-----------------------------------------------------------------------------
static void archieCopyRectBetweenBanks(const Rect *copyRect, const unsigned char *srcBase, unsigned char *destBase) {
    int32_t top;
    int32_t left;
    int32_t right;
    int32_t bottom;
    int32_t y;
    size_t width;

    if(!srcBase || !destBase) {
        return;
    }

    left = copyRect->left < 0 ? 0 : copyRect->left;
    top = copyRect->top < 0 ? 0 : copyRect->top;
    right = copyRect->right > SCREENW ? SCREENW : copyRect->right;
    bottom = copyRect->bottom > SCREENH ? SCREENH : copyRect->bottom;

    if(left >= right || top >= bottom) {
        return;
    }

    width = (size_t)(right - left);
    for(y = top; y < bottom; y++) {
        memcpy(destBase + y * rowBytes + left, srcBase + y * rowBytes + left, width);
    }
}

//-----------------------------------------------------------------------------
static void archieFillRectDirect(const Rect *fillRect, uint32_t color) {
    int32_t row;
    uint32_t pixel = archieRepeatColor(color);

    if(!baseAddr || fillRect->left >= fillRect->right || fillRect->top >= fillRect->bottom) {
        return;
    }
    // The full playfield has aligned edges and a 320-byte stride. SDK memset
    // writes bytes; use aligned word stores for the measured clear bottleneck.
    for(row = fillRect->top; row < fillRect->bottom; row++) {
        uint32_t *dest = (uint32_t *)(baseAddr + row * rowBytes + fillRect->left);
        uint32_t words = (uint32_t)(fillRect->right - fillRect->left) / 4U;
        while(words >= 8U) {
            dest[0] = pixel; dest[1] = pixel; dest[2] = pixel; dest[3] = pixel;
            dest[4] = pixel; dest[5] = pixel; dest[6] = pixel; dest[7] = pixel;
            dest += 8;
            words -= 8;
        }
        while(words--) *dest++ = pixel;
    }
}

//-----------------------------------------------------------------------------
void archieAnimatePalette(void) {
}

// Wipe cells have aligned edges. Overdraw both banks without update merging
// or bank copying; the caller paces groups of lines at VSync.
void archieTransitionFill(const Rect *rect, uint32_t color) {
    unsigned char *saved = baseAddr;
    if(archieUseBankedBuffers) {
        baseAddr = archieBankAddr[0];
        archieFillRectDirect(rect, color);
        baseAddr = archieBankAddr[1];
        archieFillRectDirect(rect, color);
        baseAddr = saved;
    } else {
        archieFillRectDirect(rect, color);
    }
    archieDamageValid[0] = archieDamageValid[1] = 0;
}

//-----------------------------------------------------------------------------
void archieBeginPlayfieldFrame(void) {
    Rect playfieldRect;

    playfieldRect.left = 0;
    playfieldRect.top = 0;
    playfieldRect.right = SCREEN_PLAYAREA_RIGHT;
    playfieldRect.bottom = SCREEN_PLAYAREA_BOTTOM;

    if(archieUseBankedBuffers) {
        uint32_t bank = archieWriteBufferIndex;
        uint32_t i;
        if(!archieDamageValid[bank] || archieDamageSky[bank] != (uint32_t)activeSky) {
            archieFillRectDirect(&playfieldRect, TP_COLOR_SKY0 + activeSky);
        } else {
            for(i = 0; i < archieDamageCount[bank]; i++) {
                archieFillRectDirect(&archieDamage[bank][i], TP_COLOR_SKY0 + activeSky);
            }
        }
        archieDamageCount[bank] = 0;
        archieDamageValid[bank] = 1;
        archieDamageSky[bank] = (uint32_t)activeSky;
    } else
    {
        archieFillRectDirect(&playfieldRect, TP_COLOR_SKY0 + activeSky);
    }
    archieCapturePlayfieldRects = archieUseBankedBuffers;
}

//-----------------------------------------------------------------------------
void archieBlitToScreen(Rect *srcCopyRect) {
    if(archieUseBankedBuffers) {
        unsigned char *displayAddr = archieDisplayAddress();
        archieCopyRectBetweenBanks(srcCopyRect, displayAddr, baseAddr);
    } else {
        UNUSED(srcCopyRect);
        v_waitForVSync();
    }
}

//-----------------------------------------------------------------------------
void archieCleanup() {
    if(!archieInitDone) {
        return;
    }

    if(archieUseBankedBuffers) {
        archieSelectDisplayBank(ARCHIE_BANK_1);
        archieSelectWriteBank(ARCHIE_BANK_1);
        archieRefreshScreenPointers();
    }

    if(archiePreviousMode >= 0 && archiePreviousMode < 256) {
        archieSetModeRaw((uint32_t)archiePreviousMode);
    }
    if(archiePreviousPointer >= 0) {
        _kernel_swi_regs regs;
        regs.r[0] = 106;
        regs.r[1] = archiePreviousPointer;
        regs.r[2] = 0;
        _kernel_swi(OS_Byte, &regs, &regs);
        archiePreviousPointer = -1;
    }
    _kernel_osbyte(21, 0, 0); // Discard gameplay characters queued for the CLI.
    _kernel_osbyte(124, 0, 0); // Clear Escape condition before returning to the OS.

    baseAddr = 0;
    rowBytes = 0;
    archieDamageValid[0] = archieDamageValid[1] = 0;
    archieDamageCount[0] = archieDamageCount[1] = 0;
    archieUseBankedBuffers = 0;
    archieCapturePlayfieldRects = 0;
    archieBankStride = 0;
    archieBankAddr[0] = 0;
    archieBankAddr[1] = 0;
    archieInitDone = 0;
}

//-----------------------------------------------------------------------------
void archieClearScreen() {
    if(baseAddr) {
        memset(baseAddr, archieMapColor(TP_COLOR_BLACK), ARCHIE_ROW_BYTES * SCREENH);
    }
}

//-----------------------------------------------------------------------------
void archieFill(int32_t X, int32_t Y, int32_t W, int32_t H, uint32_t color) {
    Rect fillRect;
    int32_t xEnd;
    int32_t yEnd;
    int32_t row;
    int mappedColor;

    if(!baseAddr || W <= 0 || H <= 0) {
        return;
    }

    if(X < 0) {
        W += X;
        X = 0;
    }
    if(Y < 0) {
        H += Y;
        Y = 0;
    }

    xEnd = X + W;
    yEnd = Y + H;

    if(xEnd > SCREENW) {
        xEnd = SCREENW;
    }
    if(yEnd > SCREENH) {
        yEnd = SCREENH;
    }
    if(X >= xEnd || Y >= yEnd) {
        return;
    }

    fillRect.left = X;
    fillRect.top = Y;
    fillRect.right = xEnd;
    fillRect.bottom = yEnd;
    mappedColor = (int)archieMapColor(color);
    for(row = Y; row < yEnd; row++) {
        memset(baseAddr + row * rowBytes + X, mappedColor, (size_t)(xEnd - X));
    }
    addRectToUpdate(&fillRect);
}

//-----------------------------------------------------------------------------
void archieHideMenuBar(void) {
}

//-----------------------------------------------------------------------------
int32_t archieInit() {
    uint32_t screenAreaSize;

    _kernel_swi_regs modeRegs;
    modeRegs.r[0] = 135;
    modeRegs.r[1] = 0;
    modeRegs.r[2] = 0;
    if(!_kernel_swi(OS_Byte, &modeRegs, &modeRegs)) {
        archiePreviousMode = modeRegs.r[2];
    }
    modeRegs.r[0] = 106;
    modeRegs.r[1] = 0; // Hide the mouse pointer; preserve its previous selection.
    modeRegs.r[2] = 0;
    if(!_kernel_swi(OS_Byte, &modeRegs, &modeRegs)) {
        archiePreviousPointer = modeRegs.r[1];
    }
    archieInitDone = 1; // Allow cleanup on partial initialization.
    archieSetModeRaw(ARCHIE_PREALLOC_SCREEN_MODE);
    archieSetModeRaw(ARCHIE_SCREEN_MODE);
    v_disableTextCursor();
    _kernel_oswrch(20);
    v_setBorderColour(0x000000U);

    rowBytes = ARCHIE_ROW_BYTES;
    globalScale = 1;
    archieDamageValid[0] = archieDamageValid[1] = 0;
    archieDamageCount[0] = archieDamageCount[1] = 0;
    archieUseBankedBuffers = 0;
    archieCapturePlayfieldRects = 0;
    archieBankStride = 0;
    archieDisplayBank = ARCHIE_BANK_1;
    archieWriteBank = ARCHIE_BANK_2;
    archieDisplayBufferIndex = 0;
    archieWriteBufferIndex = 1;
    archieBankAddr[0] = 0;
    archieBankAddr[1] = 0;

    archieSetModeRaw(ARCHIE_SHADOW_SCREEN_MODE);
    archieSelectDisplayBank(ARCHIE_BANK_1);
    archieSelectWriteBank(ARCHIE_BANK_2);
    archieRefreshScreenPointers();
    if(!baseAddr) {
        archieCleanup();
        return 0;
    }

    displayPoint.h = 0;
    displayPoint.v = 0;

    screenRect.top = 0;
    screenRect.left = 0;
    screenRect.bottom = SCREENH;
    screenRect.right = SCREENW;

    gameRect = screenRect;
    spriteClipRect.top = 0;
    spriteClipRect.left = 0;
    spriteClipRect.bottom = SCREEN_PLAYAREA_BOTTOM;
    spriteClipRect.right = SCREEN_PLAYAREA_RIGHT;

    screenAreaSize = archieReadVduVariable(ARCHIE_VD_SCREEN_SIZE);
    if(screenAreaSize >= (ARCHIE_SCREEN_BYTES * 2U)) {
        unsigned char *displayAddr;

        archieBankStride = screenAreaSize / 2U;
        displayAddr = (unsigned char *)archieReadVduVariable(ARCHIE_VD_DISPLAY_START);

        // Verify bank 1 through the VDU driver rather than guessing legacy addresses.
        if(!archieSelectWriteBank(ARCHIE_BANK_1)) {
            displayAddr = 0;
        } else {
            unsigned char *bank1 = (unsigned char *)archieReadVduVariable(ARCHIE_VD_SCREEN_START);
            if(bank1 != displayAddr) {
                displayAddr = 0;
            }
        }
        archieSelectWriteBank(ARCHIE_BANK_2);

        archieBankAddr[0] = displayAddr;
        archieBankAddr[1] = baseAddr;
        archieUseBankedBuffers = archieBankAddr[0] != 0 && archieBankAddr[1] != 0 &&
            ((uintptr_t)archieBankAddr[0] + ARCHIE_SCREEN_BYTES <= (uintptr_t)archieBankAddr[1] ||
             (uintptr_t)archieBankAddr[1] + ARCHIE_SCREEN_BYTES <= (uintptr_t)archieBankAddr[0]);
        if(!archieUseBankedBuffers) {
            archieBankStride = 0;
            archieBankAddr[0] = 0;
            archieBankAddr[1] = 0;
            archieSelectDisplayBank(ARCHIE_BANK_1);
            archieSelectWriteBank(ARCHIE_BANK_1);
            archieRefreshScreenPointers();
        } else {
            archieRefreshScreenPointers();
            archieClearScreen();
            archieSelectDisplayBank(ARCHIE_BANK_1);
            archieSelectWriteBank(ARCHIE_BANK_2);
            archieRefreshScreenPointers();
        }
    }

    if(!archieUseBankedBuffers) {
        // Also undo shadow/bank 2 selection when the screen area is too small.
        archieSetModeRaw(ARCHIE_SCREEN_MODE);
        archieSelectDisplayBank(ARCHIE_BANK_1);
        archieSelectWriteBank(ARCHIE_BANK_1);
        archieRefreshScreenPointers();
        if(!baseAddr) {
            archieShowErrorDialog("No usable screen buffer");
            archieCleanup();
            return 0;
        }
        archieClearScreen();
    }

    // Shadow/fallback mode changes above reset the VDU cursor state.
    v_disableTextCursor();
    archieInitDone = 1;
    if(!archieCleanupRegistered) {
        atexit(archieCleanup);
        archieCleanupRegistered = 1;
    }

    return 1;
}

//-----------------------------------------------------------------------------
unsigned char *archieScreenAddress(void) {
    return (unsigned char *)v_getScreenAddress();
}

//-----------------------------------------------------------------------------
uint8_t archieMapColor(uint32_t logicalColor) {
    if(logicalColor < TP_NUM_COLORS) {
        return archieColorLut[logicalColor];
    }
    return (uint8_t)(logicalColor & 0xff);
}

//-----------------------------------------------------------------------------
uint32_t archieRepeatColor(uint32_t logicalColor) {
    uint32_t byte = archieMapColor(logicalColor);
    return byte | (byte << 8) | (byte << 16) | (byte << 24);
}

//-----------------------------------------------------------------------------
void archieSetPaletteFromResource(int32_t res_id) {
    UNUSED(res_id);
    _kernel_oswrch(20);
}

//-----------------------------------------------------------------------------
int32_t archieSetScale(int32_t scale) {
    globalScale = scale;
    return 1;
}

//-----------------------------------------------------------------------------
int32_t archieTrackDynamicRect(const Rect *rect) {
    if(archieCapturePlayfieldRects &&
       rect->left >= 0 &&
       rect->top >= 0 &&
       rect->right <= SCREEN_PLAYAREA_RIGHT &&
       rect->bottom <= SCREEN_PLAYAREA_BOTTOM) {
        uint32_t bank = archieWriteBufferIndex;
        uint32_t count = archieDamageCount[bank];
        if(count < ARCHIE_DAMAGE_MAX) {
            archieDamage[bank][count] = *rect;
            archieDamageCount[bank]++;
        } else {
            // Preserve all damage on overflow; never drop an older sprite bound.
            archieDamage[bank][0] = (Rect){0, 0, SCREEN_PLAYAREA_BOTTOM, SCREEN_PLAYAREA_RIGHT};
            archieDamageCount[bank] = 1;
        }
        return 1;
    }
    if(rect->left < SCREEN_PLAYAREA_RIGHT && rect->top < SCREEN_PLAYAREA_BOTTOM) {
        // UI/transition writes and copies can replace the scene in either bank.
        archieDamageValid[0] = archieDamageValid[1] = 0;
    }
    return 0;
}

//-----------------------------------------------------------------------------
// Function to display an error dialog
int32_t archieShowErrorDialog(const char* errorMessage) {
    fprintf(stderr, "Time Pilot: %s\n", errorMessage);
    return 0;
}

//-----------------------------------------------------------------------------
void archieShowMenuBar(void) {
}

//-----------------------------------------------------------------------------
void archieUpdate(WindowPtr screen) {
    UNUSED(screen);
    if(archieUseBankedBuffers) {
        _kernel_swi_regs regs;
        uint32_t updateCount = getUpdateRectCount();
        unsigned char *newWriteAddr;
        unsigned char *displayAddr;
        uint32_t oldDisplayBufferIndex;
        uint32_t oldWriteBufferIndex;
        uint32_t requestedDisplayBank;
        uint32_t returnedHiddenBank;
        uint32_t index;

        v_waitForVSync();
        oldDisplayBufferIndex = archieDisplayBufferIndex;
        oldWriteBufferIndex = archieWriteBufferIndex;

        requestedDisplayBank = archieWriteBank;
        regs.r[0] = OSByte_WriteDisplayBank;
        regs.r[1] = (int)requestedDisplayBank;
        regs.r[2] = 0;
        if(_kernel_swi(OS_Byte, &regs, &regs)) {
            archieShowErrorDialog("Display bank switch failed");
            global_quit = 1;
            exitGameMask |= EXIT_USER_QUIT;
            return;
        }
        archieDisplayBank = requestedDisplayBank;
        // The other bank is known; do not trust unchecked SWI output as an index.
        returnedHiddenBank = requestedDisplayBank == ARCHIE_BANK_1 ? ARCHIE_BANK_2 : ARCHIE_BANK_1;

        regs.r[0] = OSByte_WriteVDUBank;
        regs.r[1] = (int)returnedHiddenBank;
        regs.r[2] = 0;
        if(_kernel_swi(OS_Byte, &regs, &regs)) {
            archieShowErrorDialog("Write bank switch failed");
            global_quit = 1;
            exitGameMask |= EXIT_USER_QUIT;
            return;
        }
        archieWriteBank = returnedHiddenBank;

        archieDisplayBufferIndex = oldWriteBufferIndex;
        archieWriteBufferIndex = oldDisplayBufferIndex;
        archieRefreshScreenPointers();
        archieLastScreenStart = (uint32_t)baseAddr;
        newWriteAddr = baseAddr;
        displayAddr = archieDisplayAddress();
        archieLastDisplayStart = (uint32_t)displayAddr;

        for(index = 0; index < updateCount; index++) {
            Rect updateRect;
            getUpdateRect(index, &updateRect);
            archieCopyRectBetweenBanks(&updateRect, displayAddr, newWriteAddr);
        }
    } else {
        v_waitForVSync();
        archieLastScreenStart = (uint32_t)baseAddr;
        archieLastDisplayStart = (uint32_t)archieDisplayAddress();
    }
    archieCapturePlayfieldRects = 0;
}
