//-----------------------------------------------------------------------------
// print.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "tigr.h"
#include "globals.h"

#include "print.h"

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

//-----------------------------------------------------------------------------
void printRectXY(int16_t X, int16_t Y, uint16_t flags, TPixel color, int16_t w) {
    if(flags) {
        if(flags & PF_CENTRE_X) {
            X += (SCOL / 2) - (w / 2);
        }
        if(flags & PF_CENTRE_Y) {
            Y += SROW / 2;
        }
        if(flags & PF_RIGHT) {
            X += SCOL - w;
        }
    }
    tigrFill(screen, X * SCOLW, Y * SROWH, w * font->glyphs->w, font->glyphs->h, color);
}

//-----------------------------------------------------------------------------
void printXY(int16_t X, int16_t Y, uint16_t flags, TPixel color, const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);

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
    tigrPrint(screen, font, X * SCOLW, Y * SROWH, color, printBuffer);
}
