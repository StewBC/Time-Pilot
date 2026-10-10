//-----------------------------------------------------------------------------
// erase.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "archie.h"
#include "globals.h"

#include "data.h"
#include "erase.h"
#include "update.h"

//-----------------------------------------------------------------------------
void eraseThing(int32_t X) {
    Rect thingRect;

    thingRect.top = activeOldY[X];
    thingRect.bottom = thingRect.top + activeHeight[X];
    thingRect.left = activeOldX[X];
    thingRect.right = thingRect.left + activeWidth[X];

    if(thingRect.left < spriteClipRect.left) {
        thingRect.left = spriteClipRect.left;
    } else if(thingRect.right > spriteClipRect.right) {
        thingRect.right = spriteClipRect.right;
    }
    if(thingRect.top < spriteClipRect.top) {
        thingRect.top = spriteClipRect.top;
    }
    if(thingRect.bottom > spriteClipRect.bottom) {
        thingRect.bottom = spriteClipRect.bottom;
    }

    archieFill(thingRect.left,
               thingRect.top,
               thingRect.right - thingRect.left,
               thingRect.bottom - thingRect.top,
               TP_COLOR_SKY0 + activeSky);
    addRectToUpdate(&thingRect);
}
