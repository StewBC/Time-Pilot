//-----------------------------------------------------------------------------
// print.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "mac.h"
#include "globals.h"

#include "data.h"
#include "print.h"
#include "sprite.h"
#include "update.h"

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

//-----------------------------------------------------------------------------
void printXY(int16_t X, int16_t Y, uint16_t flags, uint16_t color, const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    Rect textRect;
    char *c = printBuffer;

    uint16_t length = vsnprintf(printBuffer, SCOL, fmt, args);

    if(flags) {
        if(flags & PF_CENTRE_X) {
            X += (SCOL / 2) - (length / 2);
        }
        if(flags & PF_CENTRE_Y) {
            Y += SROW / 2;
        }
        if(flags & PF_RIGHT) {
            X += SCOL - length;
        }
    }
    va_end(args);

    // Find the rectangle that encloses all text
    textRect.top = Y * SROWH;
    textRect.left = X * SCOLW;
    textRect.bottom = Y * SROWH + SCOLW;
    textRect.right = (X + length) * SCOLW;
    addRectToUpdate(&textRect);

    // Render the text as sprites
    while(*c) {
        spriteShowTextUnclipped(spritePtrs[(*c - ' ') & 127], &textRect, printColorLut[color & 0x0f]);
        textRect.left += SCOLW;
        c++;
    }
}

//-----------------------------------------------------------------------------
void debugLog(const char *fmt, ...) {
    static int dbgy = 0;
    static int dbcntr = 0;
    va_list args;
    va_start(args, fmt);
    static char dbgBuf[SCOL + 1];

    uint16_t length = vsnprintf(printBuffer, SCOL, fmt, args);
    length = snprintf(dbgBuf, SCOL, "%d %s", dbcntr++, printBuffer);

    macFill(0, dbgy * SROWH, length * SCOLW, SROWH, TP_COLOR_SKY0 + activeSky);
    printXY(0, dbgy, 0, TP_COLOR_CYAN, (char *) dbgBuf);

    if(++dbgy == SROW) {
        dbgy = 0;
    }
    va_end(args);
}
