//-----------------------------------------------------------------------------
// screen.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "archie.h"
#include "globals.h"

#include "data.h"
#include "draw.h"
#include "erase.h"
#include "print.h"
#include "screen.h"
#include "update.h"
#include <archie/video.h>
#include <kernel.h>
#include <swis.h>

#include <stdlib.h>

static uint32_t screenWipeLines;
static uint32_t screenWipeStart;
static int32_t screenWipeHasClock;
#define SCREEN_WIPE_CS 150U
#define SCREEN_WIPE_LINE_COUNT (2U * (PLAYFIELDW + PLAYFIELDH - 2U))

static int32_t screenReadTime(uint32_t *time) {
    _kernel_swi_regs regs;
    if(_kernel_swi(OS_ReadMonotonicTime, &regs, &regs)) return 0;
    *time = (uint32_t)regs.r[0];
    return 1;
}

static void screenTransitionUpdate(void) {
    archieUpdate(0);
    clearUpdate();
}

//-----------------------------------------------------------------------------
// The coordinates are in cols and rows (so 40x25 as I write this)
void screenClearSection(uint32_t X, uint32_t Y, uint32_t W, uint32_t H, uint32_t color) {
    archieFill(X * SCOLW, Y * SROWH, W * SCOLW, H * SROWH, color);
}

//-----------------------------------------------------------------------------
uint32_t screenClips(int32_t X) {
    int32_t A, Y;
    uint32_t clipsMask;

    UNUSED(Y);
    UNUSED(A);

    clipsMask = 0;
    if(activeMinY[X] < 0) {
        if(activeMaxY[X] < 0) {
            return ACTIVEFLAGS_CLIPMASK; // off-screen at top
        }
        clipsMask = ACTIVEFLAGS_CLIPTY; // top clip
    }

    if(activeMaxY[X] > SCREEN_PLAYAREA_BOTTOM) {
        if(activeMinY[X] >= SCREEN_PLAYAREA_BOTTOM) {
            return ACTIVEFLAGS_CLIPMASK; // off screen at bottom
        }
        clipsMask = ACTIVEFLAGS_CLIPBY; // bottom clip
    }

    if(activeMinX[X] < 0) {
        if(activeMaxX[X] < 0) {
            return ACTIVEFLAGS_CLIPMASK; // off screen on left
        }
        return clipsMask | ACTIVEFLAGS_CLIPLX; // left clip
    }

    if(activeMaxX[X] > SCREEN_PLAYAREA_RIGHT) {
        if(activeMinX[X] >= SCREEN_PLAYAREA_RIGHT) {
            return ACTIVEFLAGS_CLIPMASK;
        }
        return clipsMask | ACTIVEFLAGS_CLIPRX; // right clip
    }

    return clipsMask;
}

//-----------------------------------------------------------------------------
void screenDrawLine(int32_t x0, int32_t y0, int32_t x1, int32_t y1) {
    int32_t dx, dy, sx, sy, err, e2;
    dx = abs(x1 - x0);
    sx = x0 < x1 ? 1 : -1;
    dy = -abs(y1 - y0);
    sy = y0 < y1 ? 1 : -1;
    err = dx + dy;
    while(1) {
        screenSetColPixel(x0, y0);
        if(x0 == x1 && y0 == y1)
            break;
        e2 = 2 * err;
        if(e2 >= dy) {
            err += dy;
            x0 += sx;
        }
        if(e2 <= dx) {
            err += dx;
            y0 += sy;
        }
    }
    ++screenWipeLines;
    if(screenWipeHasClock) {
        uint32_t now;
        uint32_t deadline = screenWipeLines * SCREEN_WIPE_CS / SCREEN_WIPE_LINE_COUNT;
        while(screenReadTime(&now) && now - screenWipeStart < deadline) {
            v_waitForVSync();
        }
    } else if(screenWipeLines * 75U / SCREEN_WIPE_LINE_COUNT !=
              (screenWipeLines - 1U) * 75U / SCREEN_WIPE_LINE_COUNT) {
        v_waitForVSync();
    }
}

//-----------------------------------------------------------------------------
void screenSetColPixel(int32_t x0, int32_t y0) {
    Rect cell = {y0 * SROWH, x0 * SCOLW, (y0 + 1) * SROWH, (x0 + 1) * SCOLW};
    archieTransitionFill(&cell, drawBackgroundColor);
}

//-----------------------------------------------------------------------------
void screenSetPalette() {
    // Mode 13 colors are fixed, so there is no runtime palette to populate.
}

//-----------------------------------------------------------------------------
void screenTimeWarp() {
    int32_t x, l, f, i = 0;
    screenTransitionUpdate();

    x = timeWarpDrawScript[0];
    do {
        while(x >= 0) {
            i++;
            l = timeWarpDrawScript[i];
            i++;
            f = timeWarpDrawScript[i];
            i++;
            while(l) {
                char t = 32 + 64 + f;
                char t1 = t;
                char b = t + 5;
                char b1 = b;

                if(f == 3) {
                    t1++;
                    b1++;
                }
                printXY(timeWarpDrawX[x], (PLAYER_Y / SROWH), 0, TP_COLOR_WHITE, "%c%c", t, t1);
                printXY(timeWarpDrawX[x], (PLAYER_Y / SROWH) + 1, 0, TP_COLOR_WHITE, "%c%c", b, b1);
                l--;
                x++;
            }
            x = timeWarpDrawScript[i];
        }
        drawThing(0);
        screenTransitionUpdate();

        for(x = 0; x < 13; x++) {
            screenClearSection(timeWarpDrawX[x], (PLAYER_Y / SROWH), 2, 2, drawBackgroundColor);
        }
        screenTransitionUpdate();

        i++;
        x = timeWarpDrawScript[i];
    } while(x >= 0);

    eraseThing(0);
    screenTransitionUpdate();
}

//-----------------------------------------------------------------------------
void screenWipe() {
    int32_t counter;
    // Synchronize outstanding UI writes before switching to direct overdraw.
    screenTransitionUpdate();
    screenWipeLines = 0;
    screenWipeHasClock = screenReadTime(&screenWipeStart);

    counter = PLAYFIELDW / 2 - 1;
    while(counter >= 0) {
        screenDrawLine(PLAYFIELDW / 2 - 1, PLAYFIELDH / 2, counter--, 0);
    }

    counter = 1;
    while(counter < PLAYFIELDH) {
        screenDrawLine(PLAYFIELDW / 2 - 1, PLAYFIELDH / 2, 0, counter++);
    }

    counter = 1;
    while(counter < PLAYFIELDW / 2) {
        screenDrawLine(PLAYFIELDW / 2 - 1, PLAYFIELDH / 2, counter++, PLAYFIELDH - 1);
    }

    counter = PLAYFIELDW / 2;
    while(counter < PLAYFIELDW) {
        screenDrawLine(PLAYFIELDW / 2, PLAYFIELDH / 2, counter++, PLAYFIELDH - 1);
    }

    counter = PLAYFIELDH - 2;
    while(counter >= 0) {
        screenDrawLine(PLAYFIELDW / 2, PLAYFIELDH / 2, PLAYFIELDW - 1, counter--);
    }

    counter = PLAYFIELDW - 2;
    while(counter > 13) {
        screenDrawLine(PLAYFIELDW / 2, PLAYFIELDH / 2, counter--, 0);
    }
    clearUpdate();
}

//-----------------------------------------------------------------------------
void screenWipeToStageSky(uint32_t stage) {
    drawBackgroundColor = TP_COLOR_SKY0 + stage;
    screenWipe();
    activeSky = stage;
}
