//-----------------------------------------------------------------------------
// erase.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "tigr.h"
#include "globals.h"

#include "data.h"
#include "erase.h"

//-----------------------------------------------------------------------------
void erase16x16TimeWarpAt(int16_t x) {
    tigrFill(screen, x, PLAYER_Y, 16, 16, drawBackgroundColor);
}

//-----------------------------------------------------------------------------
void eraseThing(int16_t X)
{
    // The erase rectangle is based on the previous position, which can be
    // outside the playfield just after a wrap.  Clip the previous rectangle
    // itself rather than trusting the flags calculated from the current
    // position, otherwise a cloud wrapping at the right edge paints its old
    // sky-coloured rectangle into the score panel.
    int16_t x = activeOldX[X];
    int16_t y = activeOldY[X];
    int16_t w = activeWidth[X];
    int16_t h = activeHeight[X];

    int16_t L = x < 0 ? -x : 0;
    int16_t T = y < 0 ? -y : 0;
    int16_t R = x + w > SCREEN_PLAYAREA_RIGHT ? x + w - SCREEN_PLAYAREA_RIGHT : 0;
    int16_t B = y + h > SCREEN_PLAYAREA_BOTTOM ? y + h - SCREEN_PLAYAREA_BOTTOM : 0;

    if(w - L - R > 0 && h - T - B > 0) {
        tigrFill(screen,
            x + L, y + T,
            w - L - R, h - T - B,
            colors[TP_COLOR_SKY]);
    }
    activeFlags[X] |= ACTIVEFLAGS_ERASED;
}
