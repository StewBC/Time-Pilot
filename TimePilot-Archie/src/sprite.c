//
//      File: sprite.c
//
//      This file contains the routines to draw the sprites
//
//      2/19/95 -- Created by Mick
//      8/11/24 -- Marginally changed for TimePilot by Stefan Wessels
//

#include "archie.h"
#include "globals.h"

#include "resids.h"
#include "sprite.h"
#include "tpr.h"
#include "update.h"

#include <stdlib.h>
#include <string.h>

//-----------------------------------------------------------------------------
static void spriteCopyBytes(unsigned char *destPtr, const unsigned char *srcPtr, uint32_t count) {
    memcpy(destPtr, srcPtr, count);
}

//-----------------------------------------------------------------------------
static void spriteMaskTextBytes(unsigned char *destPtr, const unsigned char *srcPtr, uint32_t count, uint32_t color) {
    uint32_t i;

    for(i = 0; i < count; i++) {
        destPtr[i] = (unsigned char)(srcPtr[i] & (unsigned char)color);
    }
}

void spriteDispose(tSpriteInfo *spriteInfo) {
    if(spriteInfo) {
        free(spriteInfo);
    }
}

//-----------------------------------------------------------------------------
void spriteDraw(tSpriteInfo *spriteInfo, Point location) {
    Rect destRect;                      // where we want to draw the sprite

    // calculate the destination rect
    destRect = spriteInfo->spriteRect;
    destRect.left += location.h;
    destRect.right += location.h;
    destRect.top += location.v;
    destRect.bottom += location.v;

    // determine if the spite needs to be drawn at all
    if(destRect.top >= spriteClipRect.bottom
       || destRect.bottom <= spriteClipRect.top || destRect.left >= spriteClipRect.right || destRect.right <= spriteClipRect.left) {
        // no need to draw, goodbye
        return;
    }
    // determine if the sprite will be clipped
    if(destRect.top < spriteClipRect.top || destRect.bottom > spriteClipRect.bottom
       || destRect.left < spriteClipRect.left || destRect.right > spriteClipRect.right) {
        // handle the clipped case
        spriteDrawClipped(spriteInfo, &destRect);
    } else {
        // handle the unclipped case
        spriteDrawUnclipped(spriteInfo, &destRect);
    }
}

//-----------------------------------------------------------------------------
void spriteDrawClipped(tSpriteInfo *spriteInfo, Rect *inDestRect) {
    Rect clipRect;                      // the rect that defines the clipped shape
    Rect updateRect;                    // clipped rect in screen coordinates
    unsigned char *rowStart = 0;            // the pointer to the start of this row
    unsigned char *srcPtr = 0;              // the current position in the sprite data
    unsigned char *destPtr = 0;             // the current position in the destination pixmap
    uint32_t miscCounter;               // a counter for various purposes
    int32_t extraCounter;              // a counter for right clippling purposes ( how much extra was there? )
    uint32_t tokenOp;                   // the op code from the token
    uint32_t tokenData;                 // the data from the token
    unsigned char exitFlag;             // should we exit from the loop?
    int32_t yCount = 0;                    // how many lines down in the shape are we?
    int32_t xCount = 0;                    // where are we in this line?

    // create a clipped rect in the coordinates of the sprite
    clipRect.left = inDestRect->left < spriteClipRect.left ? spriteClipRect.left - inDestRect->left : 0;
    clipRect.right =
        inDestRect->right > spriteClipRect.right ? spriteClipRect.right - inDestRect->left : inDestRect->right - inDestRect->left;
    clipRect.top = inDestRect->top < spriteClipRect.top ? spriteClipRect.top - inDestRect->top : 0;
    clipRect.bottom =
        inDestRect->bottom > spriteClipRect.bottom ? spriteClipRect.bottom - inDestRect->top : inDestRect->bottom - inDestRect->top;

    updateRect.left = inDestRect->left + clipRect.left;
    updateRect.top = inDestRect->top + clipRect.top;
    updateRect.right = inDestRect->left + clipRect.right;
    updateRect.bottom = inDestRect->top + clipRect.bottom;
    addRectToUpdate(&updateRect);
    // set up the counters
    yCount = 0;

    /*
     * Anchor clipped drawing at the visible left edge. We keep xCount in
     * full sprite coordinates and only advance destPtr for the visible
     * portion of each run; otherwise negative left origins can walk the
     * destination pointer before the framebuffer.
     */
    rowStart = baseAddr + updateRect.top * rowBytes + updateRect.left;

    // The generated token stream is already in Archie-native layout.
    srcPtr = (unsigned char *)spriteInfo->spriteData;

    // loop until we are done
    exitFlag = false;
    while(!exitFlag) {
        // get a token
        uint32_t token = *((const uint32_t *)srcPtr);
        tokenOp = token >> 24;
        tokenData = token & 0x00ffffff;
        srcPtr += sizeof(uint32_t);

        // depending on the token
        switch (tokenOp) {
        case DRAW_PIXELS_TOKEN:
            miscCounter = tokenData;
            extraCounter = 0;

            // if we need to, clip to the left
            if(xCount < clipRect.left) {
                // if this run does not appear at all, don't draw it
                if((int32_t)miscCounter < clipRect.left - xCount) {
                    srcPtr += miscCounter;
                    srcPtr += ((tokenData & 3L) == 0) ? 0 : (4 - (tokenData & 3L));
                    xCount += miscCounter;
                    break;
                } else {
                    // if it does, skip to where we can draw
                    miscCounter -= clipRect.left - xCount;
                    srcPtr += clipRect.left - xCount;
                    xCount += clipRect.left - xCount;
                }
            }
            // if we need to, clip to the right
            if(xCount + (int32_t)miscCounter > clipRect.right) {
                // if this run does not appear at all, skip it
                if(xCount > clipRect.right) {
                    srcPtr += miscCounter;
                    srcPtr += ((tokenData & 3L) == 0) ? 0 : (4 - (tokenData & 3L));
                    xCount += miscCounter;
                    break;
                } else {
                    // if it does, setup to draw what we can
                    extraCounter = miscCounter;
                    miscCounter -= (xCount + miscCounter) - clipRect.right;
                    extraCounter -= miscCounter;
                }
            }
            // adjust xCount for the run
            xCount += miscCounter;
            spriteCopyBytes(destPtr, srcPtr, miscCounter);
            destPtr += miscCounter;
            srcPtr += miscCounter;
            // adjust for right clipping
            srcPtr += extraCounter;
            xCount += extraCounter;

            // adjust for the padding
            srcPtr += ((tokenData & 3L) == 0) ? 0 : (4 - (tokenData & 3L));
            break;

        case SKIP_PIXELS_TOKEN:
            if(xCount < clipRect.right) {
                int32_t visibleStart = xCount > clipRect.left ? xCount : clipRect.left;
                int32_t visibleEnd = xCount + (int32_t)tokenData;
                if(visibleEnd > clipRect.right) {
                    visibleEnd = clipRect.right;
                }
                if(visibleEnd > visibleStart) {
                    destPtr += (uint32_t)(visibleEnd - visibleStart);
                }
            }
            xCount += tokenData;
            break;

        case LINE_START_TOKEN:
            // if this line is above the clip rect, skip to the next line
            if(yCount < clipRect.top) {
                srcPtr += tokenData;
            } else {
                // set up the destination pointer only for visible rows
                destPtr = rowStart;
                rowStart += rowBytes;
            }

            // move the yCounter
            yCount++;

            // reset the xCounter
            xCount = 0;

            // if we have hit the bottom clip, exit the loop
            if(yCount > clipRect.bottom) {
                exitFlag = true;
            }
            break;

        case END_SHAPE_TOKEN:
            // signal a loop exit
            exitFlag = true;
            break;

        default:
            // we should never get here
            // Debugger();
            break;
        }
    }
}

//-----------------------------------------------------------------------------
void spriteDrawUnclipped(tSpriteInfo *spriteInfo, Rect *inDestRect) {
    unsigned char *rowStart = 0;            // the pointer to the start of this row
    unsigned char *srcPtr = 0;              // the current position in the sprite data
    unsigned char *destPtr = 0;             // the current position in the destination pixmap
    uint32_t miscCounter;               // a counter for various purposes
    uint32_t tokenOp;                   // the op code from the token
    uint32_t tokenData;                 // the data from the token
    unsigned char exitFlag;             // should we exit from the loop?

    addRectToUpdate(inDestRect);

    // determine characteristics about the pixmap
    rowStart = baseAddr + inDestRect->top * rowBytes + inDestRect->left;

    srcPtr = (unsigned char *)spriteInfo->spriteData;

    // loop until we are done
    exitFlag = false;
    while(!exitFlag) {
        // get a token
        uint32_t token = *((const uint32_t *)srcPtr);
        tokenOp = token >> 24;
        tokenData = token & 0x00ffffff;
        srcPtr += sizeof(uint32_t);

        // depending on the token
        switch (tokenOp) {
        case DRAW_PIXELS_TOKEN:
            miscCounter = tokenData;
            spriteCopyBytes(destPtr, srcPtr, miscCounter);
            destPtr += miscCounter;
            srcPtr += miscCounter;
            // adjust for the padding
            srcPtr += ((tokenData & 3L) == 0) ? 0 : (4 - (tokenData & 3L));
            break;

        case SKIP_PIXELS_TOKEN:
            destPtr += tokenData;
            break;

        case LINE_START_TOKEN:
            // set up the destination pointer
            destPtr = rowStart;
            rowStart += rowBytes;
            break;

        case END_SHAPE_TOKEN:
            // signal a loop exit
            exitFlag = true;
            break;

        default:
            // we should never get here
            // Debugger();
            break;
        }
    }
}

//-----------------------------------------------------------------------------
tSpriteInfo *spriteLoad(signed short resID) {
    const uint32_t *spriteData;
    tSpriteInfo *newSprite = 0;             // the new sprite data
    uint32_t spriteIndex;

    if(resID < RID_LETTER_32) {
        return 0;
    }

    spriteIndex = (uint32_t)(resID - RID_LETTER_32);
    if(spriteIndex >= tprSpriteCount) {
        return 0;
    }

    spriteData = tprSpriteData[spriteIndex];
    if(!spriteData) {
        return 0;
    }

    newSprite = (tSpriteInfo *)malloc(sizeof(tSpriteInfo));
    if(!newSprite) {
        return 0;
    }

    newSprite->spriteData = spriteData;
    newSprite->spriteRect.top = (int32_t)tprSpriteRects[spriteIndex][0];
    newSprite->spriteRect.left = (int32_t)tprSpriteRects[spriteIndex][1];
    newSprite->spriteRect.bottom = (int32_t)tprSpriteRects[spriteIndex][2];
    newSprite->spriteRect.right = (int32_t)tprSpriteRects[spriteIndex][3];

    return newSprite;
}

//-----------------------------------------------------------------------------
void spriteSetClipRect(Rect *drawRect) {
    // set the clip region to be the passed in rect
    spriteClipRect = *drawRect;
}

//-----------------------------------------------------------------------------
void spriteShowTextUnclipped(tSpriteInfo *spriteInfo, Rect *inDestRect, uint32_t color) {
    unsigned char *rowStart = 0;            // the pointer to the start of this row
    unsigned char *srcPtr = 0;              // the current position in the sprite data
    unsigned char *destPtr = 0;             // the current position in the destination pixmap
    uint32_t miscCounter;               // a counter for various purposes
    uint32_t tokenOp;                   // the op code from the token
    uint32_t tokenData;                 // the data from the token
    unsigned char exitFlag;             // should we exit from the loop?

    // determine characteristics about the pixmap
    rowStart = baseAddr + inDestRect->top * rowBytes + inDestRect->left;

    srcPtr = (unsigned char *)spriteInfo->spriteData;

    // loop until we are done
    exitFlag = false;
    while(!exitFlag) {
        // get a token
        uint32_t token = *((const uint32_t *)srcPtr);
        tokenOp = token >> 24;
        tokenData = token & 0x00ffffff;
        srcPtr += sizeof(uint32_t);

        // depending on the token
        switch (tokenOp) {
        case DRAW_PIXELS_TOKEN:
            miscCounter = tokenData;
            spriteMaskTextBytes(destPtr, srcPtr, miscCounter, color);
            destPtr += miscCounter;
            srcPtr += miscCounter;
            // adjust for the padding
            srcPtr += ((tokenData & 3L) == 0) ? 0 : (4 - (tokenData & 3L));
            break;

        case SKIP_PIXELS_TOKEN:
            destPtr += tokenData;
            break;

        case LINE_START_TOKEN:
            // set up the destination pointer
            destPtr = rowStart;
            rowStart += rowBytes;
            break;

        case END_SHAPE_TOKEN:
            // signal a loop exit
            exitFlag = true;
            break;

        default:
            // we should never get here
            // Debugger();
            break;
        }
    }
}

//-----------------------------------------------------------------------------
// void spriteStartDraw(PixMapHandle destPixMap) {
//     // get info from the pix map
//     baseAddr = (unsigned char *) GetPixBaseAddr(destPixMap);
//     rowBytes = (*destPixMap)->rowBytes & 0x3fff;
// }
