//-----------------------------------------------------------------------------
// screen.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "tigr.h"
#include "globals.h"

#include "data.h"
#include "draw.h"
#include <erase.h>
#include "screen.h"

#include <stdlib.h>

//-----------------------------------------------------------------------------
// The coordinates are in cols and rows (so 40x25 as I write this)
void screenClearSection(uint16_t X, uint16_t Y, uint16_t W, uint16_t H, TPixel color) {
    tigrFill(screen, SCOLW*X, SROWH*Y, SCOLW*W, SROWH*H, color);
}

//-----------------------------------------------------------------------------
uint16_t screenClips(int16_t X) {
    int16_t A, Y;
    uint16_t clipsMask;

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
void screenDrawLine(int16_t x0, int16_t y0, int16_t x1, int16_t y1) {
    int16_t dx, dy, sx, sy, err, e2;
    dx = abs(x1-x0);
    sx = x0 < x1 ? 1 : -1;
    dy = -abs(y1-y0);
    sy = y0 < y1 ? 1 : -1;
    err = dx + dy;
    while (1) {
        screenSetColPixel(x0, y0);
        if (x0 == x1 && y0 == y1)
            break;
        e2 = 2*err;
        if (e2 >= dy) {
            err += dy;
            x0 += sx;
        }
        if (e2 <= dx) {
            err += dx;
            y0 += sy;
        }
    }
    tigrUpdate(screen);
}

//-----------------------------------------------------------------------------
void screenSetColPixel(int16_t x0, int16_t y0) {
    screenClearSection(x0, y0, 1, 1, drawBackgroundColor);
}

//-----------------------------------------------------------------------------
void screenSetPalette() {
    int16_t i;

    for(i=0; i<16; i++) {
        colors[i] = tigrRGB((colorPalette[i] >> 16) & 0xff, (colorPalette[i] >> 8) & 0xff, colorPalette[i] & 0xff);
    }

    for(i=0; i<5; i++) {
        skyColors[i] = tigrRGB((colorPaletteSky[i] >> 16) & 0xff, (colorPaletteSky[i] >> 8) & 0xff, colorPaletteSky[i] & 0xff);
    }
    
}

//-----------------------------------------------------------------------------
void screenTimeWarp() {
    int16_t x, l, f, i = 0;
    x = timeWarpDrawScript[0];
    do {
        while(x >= 0) {
            i++;
            l = timeWarpDrawScript[i];
            i++;
            f = timeWarpDrawScript[i];
            i++;
            while(l) {
                draw16x16TimeWarpAtX(f, timeWarpDrawX[x]);
                l--;
                x++;
            }
            x = timeWarpDrawScript[i];
        }
        drawPlayer(0);
        tigrUpdate(screen);
        tigrUpdate(screen);

        for(x = 0; x < 13; x++) {
            erase16x16TimeWarpAt(timeWarpDrawX[x]);
        }
        tigrUpdate(screen);
        tigrUpdate(screen);

        i++;
        x = timeWarpDrawScript[i];
    } while(x >= 0);

    eraseThing(0);
}

//-----------------------------------------------------------------------------
void screenWipe() {
    int16_t counter;

    counter = PLAYFIELDW/2-1;
    while(counter >= 0) {
        screenDrawLine(PLAYFIELDW/2-1, PLAYFIELDH/2, counter--, 0);
    }

    counter = 1;
    while(counter < PLAYFIELDH) {
        screenDrawLine(PLAYFIELDW/2-1, PLAYFIELDH/2, 0, counter++);
    }

    counter = 1;
    while(counter < PLAYFIELDW/2) {
        screenDrawLine(PLAYFIELDW/2-1, PLAYFIELDH/2, counter++, PLAYFIELDH-1);
    }

    counter = PLAYFIELDW/2;
    while(counter < PLAYFIELDW) {
        screenDrawLine(PLAYFIELDW/2, PLAYFIELDH/2, counter++, PLAYFIELDH-1);
    }

    counter = PLAYFIELDH-2;
    while(counter >= 0) {
        screenDrawLine(PLAYFIELDW/2, PLAYFIELDH/2, PLAYFIELDW-1, counter--);
    }

    counter = PLAYFIELDW-2;
    while(counter > 13) {
        screenDrawLine(PLAYFIELDW/2, PLAYFIELDH/2, counter--, 0);
    }
}

//-----------------------------------------------------------------------------
void screenWipeToStageSky(uint16_t stage) {
    drawBackgroundColor = colors[TP_COLOR_SKY] = skyColors[stage];
    screenWipe();
    activeSky = stage;
}
