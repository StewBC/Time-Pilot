//-----------------------------------------------------------------------------
// print.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include <stdint.h>
#include "globals.h"

#include "print.h"

#include <cx16.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

//-----------------------------------------------------------------------------
void printXY(uint8_t layer, uint8_t X, uint8_t Y, uint16_t flags, uint8_t color, const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);

    uint8_t length = vsnprintf(printBuffer, SCOL, fmt, args);
    char* c;
    
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
    VERA.address = 256*Y + 2*X;
    if(layer) {
        VERA.address += VERA_LAYER1;
    } else {
        VERA.address += VERA_LAYER0;
    }
    VERA.address_hi = VERA_INC_1 | 1;
    c = printBuffer;
    while(*c) {
        VERA.data0 = *c++;
        VERA.data0 = color;
    }
}
