//-----------------------------------------------------------------------------
// screen.c
// Part of Time Pilot, the 1982 arcade game remake for the Commander X16
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include <stdint.h>
#include "globals.h"

#include "audio.h"
#include "data.h"
#include "draw.h"
#include "erase.h"
#include "screen.h"

#include <cx16.h>
#include <stdlib.h>

//-----------------------------------------------------------------------------
void screenCleanup() {
    uint8_t Y, X;
    VERA.address_hi = VERA_INC_1 | 1;

    for(Y = 0; Y < 30; Y++) {
        VERA.address = VERA_LAYER1 + Y * 256;
        for(X = 0; X < SCOL; X++) {
            VERA.data0 = 32; // SPACE
            VERA.data0 = TP_COLOR_WHITE | (TP_COLOR_DARK_BLUE << 4);
        }
    }
    // Make sure all sprites turned off
    eraseSpriteRange(128);
    VERA.display.video |= 0b00100000;
    VERA.display.video &= 0b10101111;
}

//-----------------------------------------------------------------------------
// The coordinates are in cols and rows (so 30 as I write this)
void screenClearSection(uint8_t layer, uint8_t X, uint8_t Y, uint8_t W, uint8_t H, uint8_t color) {
    int16_t a = Y * 256 + X * 2;
    a += layer ? VERA_LAYER1 : VERA_LAYER0;
    VERA.address_hi = VERA_INC_1 | 1;

    for(Y = 0; Y < H; Y++) {
        VERA.address = a;
        for(X = 0; X < W; X++) {
            VERA.data0 = 160;
            VERA.data0 = color;
        }
        a += 256;
    }
}

//-----------------------------------------------------------------------------
uint16_t screenClips(int8_t X) {
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
void screenDrawLine(uint8_t x0, uint8_t y0, uint8_t x1, uint8_t y1, uint8_t color) {
    int8_t dx, dy, sx, sy, err, e2;
    dx = abs(x1-x0);
    sx = x0 < x1 ? 1 : -1;
    dy = -abs(y1-y0);
    sy = y0 < y1 ? 1 : -1;
    err = dx + dy;
    while (1) {
        VERA.address = VERA_LAYER0 + y0*256 + x0*2;
        VERA.data0 = 160;
        VERA.data0 = color;
        // screenSetColPixel(x0, y0);
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
    audioServiceAudio();
    waitvsync();
}

//-----------------------------------------------------------------------------
void screenInit() {
    // Sprites and layers off
    VERA.display.video &= 0b1000111;
    videomode(VIDEOMODE_40x30);
    VERA.layer0.config = VERA.layer1.config = 96;
    VERA.layer0.tilebase = VERA.layer1.tilebase = 248;
    VERA.layer0.mapbase = 128;
    VERA.layer1.mapbase = 216;
    screenSetPalette();
    // Clear layers 0
    screenClearSection(0, 0, 0, SCOL, SROW, TP_COLOR_BLACK);
    // Clear layers 1, masking the right-hand side
    screenClearSection(1, 0, 0, PLAYFIELDW, PLAYFIELDH, TP_COLOR_BLACK);
    screenClearSection(1, PLAYFIELDW, 0, SCOL-PLAYFIELDW, PLAYFIELDH, TP_COLOR_EXTRA);
    // Make sure all sprites turned off
    eraseSpriteRange(128);
    VERA.display.video |= 0b01110000;
}

//-----------------------------------------------------------------------------
void screenSetPalette() {
    int8_t i;

    VERA.address = VERA_COLOR_PALETTE;
    VERA.address_hi = VERA_INC_1 | 1;
    for(i=0; i<32; i++) {
        VERA.data0 = colorPalette[i&15] & 0xff; 
        VERA.data0 = colorPalette[i&15] >> 8;
    }
}

//-----------------------------------------------------------------------------
void screenTimeWarp() {
    int8_t x, l, f;
    int16_t i = 0;
    VERA.address_hi = VERA_INC_1 | 1;
    x = timeWarpDrawScript[0];
    do {
        while(x >= 0) {
            i++;
            l = timeWarpDrawScript[i];
            i++;
            f = timeWarpDrawScript[i];
            i++;
            while(l) {
                VERA.address = VERA_LAYER0 + 256 * ((PLAYFIELDH/2)-1) + x*2;
                VERA.data0 = f;
                VERA.data0 = TP_COLOR_WHITE | (TP_COLOR_SKY << 4);
                VERA.address = VERA_LAYER0 + 256 * ((PLAYFIELDH/2)) + x*2;
                VERA.data0 = f+5;
                VERA.data0 = TP_COLOR_WHITE | (TP_COLOR_SKY << 4);
                l--;
                x++;
            }
            x = timeWarpDrawScript[i];
        }
        // Player sprite ON
        drawShowSprite(layerToThingTable[LAYER_PLAYER], 0b00001000);
        // 2 frames
        audioServiceAudio();
        waitvsync();
        audioServiceAudio();
        waitvsync();

        // Player sprite OFF
        eraseSprite(layerToThingTable[LAYER_PLAYER]);
        screenClearSection(0, 0, (PLAYFIELDH/2)-1, PLAYFIELDW, 2, TP_COLOR_SKY);
        // 2 frames
        audioServiceAudio();
        waitvsync();
        audioServiceAudio();
        waitvsync();

        i++;
        x = timeWarpDrawScript[i];
    } while(x >= 0);
}

//-----------------------------------------------------------------------------
void screenWipe(uint8_t color) {
    int8_t counter;

    VERA.address_hi = VERA_INC_1 | 1;

    counter = PLAYFIELDW/2-1;
    while(counter >= 0) {
        screenDrawLine(PLAYFIELDW/2-1, PLAYFIELDH/2, counter--, 0, color);
    }

    counter = 1;
    while(counter < PLAYFIELDH) {
        screenDrawLine(PLAYFIELDW/2-1, PLAYFIELDH/2, 0, counter++, color);
    }

    counter = 1;
    while(counter < PLAYFIELDW/2) {
        screenDrawLine(PLAYFIELDW/2-1, PLAYFIELDH/2, counter++, PLAYFIELDH-1, color);
    }

    counter = PLAYFIELDW/2;
    while(counter < PLAYFIELDW) {
        screenDrawLine(PLAYFIELDW/2, PLAYFIELDH/2, counter++, PLAYFIELDH-1, color);
    }

    counter = PLAYFIELDH-2;
    while(counter >= 0) {
        screenDrawLine(PLAYFIELDW/2, PLAYFIELDH/2, PLAYFIELDW-1, counter--, color);
    }

    counter = PLAYFIELDW-2;
    while(counter > 13) {
        screenDrawLine(PLAYFIELDW/2, PLAYFIELDH/2, counter--, 0, color);
    }
}

//-----------------------------------------------------------------------------
void screenWipeToSkyColor(uint8_t skyColor) {
    // Sky is changing from one color to another
    // Create a "fake" new sky using TP_COLOR_DARK_YELLOW
    VERA.address = VERA_COLOR_PALETTE + TP_COLOR_DARK_YELLOW*2;
    VERA.address_hi = VERA_INC_1 | 1;
    VERA.data0 = colorPaletteSky[skyColor];
    VERA.data0 = colorPaletteSky[skyColor] >> 8;
    // Fill with that - now the old sky is not visible
    screenWipe(TP_COLOR_DARK_YELLOW); // TP_COLOR_SKY-1;
    // Now set YELLOW back to yellow and the sky to the new sky
    VERA.address = VERA_COLOR_PALETTE + TP_COLOR_DARK_YELLOW*2;
    VERA.address_hi = VERA_INC_1 | 1;
    VERA.data0 = colorPalette[TP_COLOR_DARK_YELLOW];
    VERA.data0 = colorPalette[TP_COLOR_DARK_YELLOW] >> 8;
    VERA.data0 = colorPaletteSky[skyColor];
    VERA.data0 = colorPaletteSky[skyColor] >> 8;
    // And clear the sceen to the SKY color
    screenClearSection(0,0,0,PLAYFIELDW,PLAYFIELDH,TP_COLOR_SKY);
    // Set the sky color in the sprites palette as well
    VERA.address = (VERA_COLOR_PALETTE+32)+(2*TP_COLOR_SKY);
    if(activeStage != TIME_PERIOD4_2001) {
        VERA.data0 = colorPaletteSky[skyColor];
        VERA.data0 = colorPaletteSky[skyColor] >> 8;
    } else {
        VERA.data0 = colorPalette[TP_COLOR_CYAN];
        VERA.data0 = colorPalette[TP_COLOR_CYAN] >> 8;
    }

    activeSky = skyColor;
}
