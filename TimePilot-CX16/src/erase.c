//-----------------------------------------------------------------------------
// erase.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include <stdint.h>
#include "globals.h"

#include "data.h"
#include "erase.h"

#include <cx16.h>

//-----------------------------------------------------------------------------
void eraseSpriteRange(uint8_t rangeEnd) {
    uint16_t i;
    VERA.address_hi = VERA_INC_8 | 1;
    VERA.address = VERA_SPRITES_BASE + 6;
    for(i = 0; i < rangeEnd; i++) {
        VERA.data0 = 0;
    }
}

//-----------------------------------------------------------------------------
void eraseSprite(int8_t X)
{
    VERA.address_hi = VERA_INC_1 | 1;
    VERA.address = VERA_SPRITES_BASE + (X * 8) + 6;
    VERA.data0 = 0;
}
