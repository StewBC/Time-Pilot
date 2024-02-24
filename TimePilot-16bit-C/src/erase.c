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
    if(!(activeFlags[X] & ACTIVEFLAGS_CLIPMASK)) {
        tigrFill(screen,
            activeOldX[X] , activeOldY[X]  ,
            activeWidth[X], activeHeight[X],
            colors[TP_COLOR_SKY]);
    } else if ((activeFlags[X] & ACTIVEFLAGS_CLIPMASK) != ACTIVEFLAGS_CLIPMASK) {
        int16_t T, B, L, R;
        T = activeFlags[X] & ACTIVEFLAGS_CLIPTY ? -activeOldY[X] : 0;
        B = activeFlags[X] & ACTIVEFLAGS_CLIPBY ? activeOldY[X] + activeHeight[X] - SCREEN_PLAYAREA_BOTTOM : 0;
        L = activeFlags[X] & ACTIVEFLAGS_CLIPLX ? -activeOldX[X] : 0;
        R = activeFlags[X] & ACTIVEFLAGS_CLIPRX ? activeOldX[X] + activeWidth[X] - SCREEN_PLAYAREA_RIGHT : 0;

        tigrFill(screen,
            activeOldX[X]  + L    , activeOldY[X]   + T    ,
            activeWidth[X] - L - R, activeHeight[X] - T - B,
            colors[TP_COLOR_SKY]);
    }
    activeFlags[X] |= ACTIVEFLAGS_ERASED;
}
