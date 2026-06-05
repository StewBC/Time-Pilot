//-----------------------------------------------------------------------------
// erase.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "mac.h"
#include "globals.h"

#include "data.h"
#include "erase.h"
#include "update.h"

//-----------------------------------------------------------------------------
void eraseThing(int16_t X) {
    Rect thingRect;
    uint32_t fillColor;
    uint32_t width;
    uint32_t height;
    uint32_t yCounter;
    unsigned char *destRow;

    thingRect.top = activeMinY[X];
    thingRect.bottom = thingRect.top + activeHeight[X];
    thingRect.left = activeMinX[X];
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

    fillColor = drawBackgroundColor;
    width = thingRect.right - thingRect.left;
    height = thingRect.bottom - thingRect.top;
    destRow = baseAddr + thingRect.top * rowBytes + thingRect.left;
    for(yCounter = 0; yCounter < height; yCounter++) {
        unsigned char *destPtr;
        uint32_t xCounter;

        destPtr = destRow;
        xCounter = width;
        while(xCounter >= sizeof(uint32_t)) {
            *((uint32_t *)destPtr) = (fillColor << 24) | (fillColor << 16) | (fillColor << 8) | fillColor;
            destPtr += sizeof(uint32_t);
            xCounter -= sizeof(uint32_t);
        }
        while(xCounter) {
            *destPtr++ = fillColor;
            xCounter--;
        }
        destRow += rowBytes;
    }
    addRectToUpdate(&thingRect);
}
