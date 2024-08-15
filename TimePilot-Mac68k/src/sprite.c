//
//      File: sprite.c
//
//      This file contains the routines to draw the sprites
//
//      2/19/95 -- Created by Mick
//      8/11/24 -- Marginally changed for TimePilot by Stefan Wessels
//

#include "mac.h"
#include "globals.h"

#include "sprite.h"
#include "update.h"

//-----------------------------------------------------------------------------
void spriteDispose(tSpriteInfo *spriteInfo) {
    // dump the sprite resource
    ReleaseResource(spriteInfo->spriteData);

    // free the structure
    DisposePtr((Ptr) spriteInfo);
}

//-----------------------------------------------------------------------------
void spriteDraw(tSpriteInfo *spriteInfo, Point location) {
    Rect destRect;                      // where we want to draw the sprite

    // calculate the destination rect
    destRect = spriteInfo->spriteRect;
    OffsetRect(&destRect, location.h, location.v);

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
    unsigned char *rowStart;            // the pointer to the start of this row
    unsigned char *srcPtr;              // the current position in the sprite data
    unsigned char *destPtr;             // the current position in the destination pixmap
    uint32_t miscCounter;               // a counter for various purposes
    uint32_t extraCounter;              // a counter for right clippling purposes ( how much extra was there? )
    uint32_t tokenOp;                   // the op code from the token
    uint32_t tokenData;                 // the data from the token
    unsigned char exitFlag;             // should we exit from the loop?
    uint32_t yCount;                    // how many lines down in the shape are we?
    uint32_t xCount;                    // where are we in this line?

    // create a clipped rect in the coordinates of the sprite
    clipRect.left = inDestRect->left < spriteClipRect.left ? spriteClipRect.left - inDestRect->left : 0;
    clipRect.right =
        inDestRect->right > spriteClipRect.right ? spriteClipRect.right - inDestRect->left : inDestRect->right - inDestRect->left;
    clipRect.top = inDestRect->top < spriteClipRect.top ? spriteClipRect.top - inDestRect->top : 0;
    clipRect.bottom =
        inDestRect->bottom > spriteClipRect.bottom ? spriteClipRect.bottom - inDestRect->top : inDestRect->bottom - inDestRect->top;

    addRectToUpdate(&clipRect);
    // set up the counters
    yCount = 0;

    // determine characteristics about the pixmap
    rowStart = baseAddr + inDestRect->top * rowBytes + inDestRect->left;

    // move to the right place in the shape ( just past the size rect )
    srcPtr = (unsigned char *) ((*(spriteInfo->spriteData)) + sizeof(Rect));

    // loop until we are done
    exitFlag = false;
    while(!exitFlag) {
        // get a token
        tokenOp = (*((uint32_t *) srcPtr)) >> 24;
        tokenData = (*((uint32_t *) srcPtr)) & 0x00ffffff;
        srcPtr += sizeof(uint32_t);

        // depending on the token
        switch (tokenOp) {
        case DRAW_PIXELS_TOKEN:
            miscCounter = tokenData;
            extraCounter = 0;

            // if we need to, clip to the left
            if(xCount < clipRect.left) {
                // if this run does not appear at all, don't draw it
                if(miscCounter < clipRect.left - xCount) {
                    destPtr += miscCounter;
                    srcPtr += miscCounter;
                    srcPtr += ((tokenData & 3L) == 0) ? 0 : (4 - (tokenData & 3L));
                    xCount += miscCounter;
                    break;
                } else {
                    // if it does, skip to where we can draw
                    miscCounter -= clipRect.left - xCount;
                    destPtr += clipRect.left - xCount;
                    srcPtr += clipRect.left - xCount;
                    xCount += clipRect.left - xCount;
                }
            }
            // if we need to, clip to the right
            if(xCount + miscCounter > clipRect.right) {
                // if this run does not appear at all, skip it
                if(xCount > clipRect.right) {
                    destPtr += miscCounter;
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

            // move data in the biggest chunks we can find
#ifdef powerc
            // move in doubles while we can
            while(miscCounter >= sizeof(double)) {
                *((double *) destPtr) = *((double *) srcPtr);
                destPtr += sizeof(double);
                srcPtr += sizeof(double);
                miscCounter -= sizeof(double);
            }

            // move a long if we can
            if(miscCounter >= sizeof(uint32_t)) {
                *((uint32_t *) destPtr) = *((uint32_t *) srcPtr);
                destPtr += sizeof(uint32_t);
                srcPtr += sizeof(uint32_t);
                miscCounter -= sizeof(uint32_t);
            }
#else
            // move in longs while we can
            while(miscCounter >= sizeof(uint32_t)) {
                *((uint32_t *) destPtr) = *((uint32_t *) srcPtr);
                destPtr += sizeof(uint32_t);
                srcPtr += sizeof(uint32_t);
                miscCounter -= sizeof(uint32_t);
            }
#endif

            // move a short if we can
            if(miscCounter >= sizeof(unsigned short)) {
                *((unsigned short *) destPtr) = *((unsigned short *) srcPtr);
                destPtr += sizeof(unsigned short);
                srcPtr += sizeof(unsigned short);
                miscCounter -= sizeof(unsigned short);
            }
            // move a char if we can
            if(miscCounter >= sizeof(unsigned char)) {
                *((unsigned char *) destPtr) = *((unsigned char *) srcPtr);
                destPtr += sizeof(unsigned char);
                srcPtr += sizeof(unsigned char);
                miscCounter -= sizeof(unsigned char);
            }
            // adjust for right clipping
            destPtr += extraCounter;
            srcPtr += extraCounter;
            xCount += extraCounter;

            // adjust for the padding
            srcPtr += ((tokenData & 3L) == 0) ? 0 : (4 - (tokenData & 3L));
            break;

        case SKIP_PIXELS_TOKEN:
            destPtr += tokenData;
            xCount += tokenData;
            break;

        case LINE_START_TOKEN:
            // if this line is above the clip rect, skip to the next line
            if(yCount < clipRect.top) {
                srcPtr += tokenData;
            }
            // set up the destination pointer
            destPtr = rowStart;
            rowStart += rowBytes;

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
            Debugger();
            break;
        }
    }
}

//-----------------------------------------------------------------------------
void spriteDrawUnclipped(tSpriteInfo *spriteInfo, Rect *inDestRect) {
    unsigned char *rowStart;            // the pointer to the start of this row
    unsigned char *srcPtr;              // the current position in the sprite data
    unsigned char *destPtr;             // the current position in the destination pixmap
    uint32_t miscCounter;               // a counter for various purposes
    uint32_t tokenOp;                   // the op code from the token
    uint32_t tokenData;                 // the data from the token
    unsigned char exitFlag;             // should we exit from the loop?

    addRectToUpdate(inDestRect);

    // determine characteristics about the pixmap
    rowStart = baseAddr + inDestRect->top * rowBytes + inDestRect->left;

    // move to the right place in the shape ( just past the size rect )
    srcPtr = (unsigned char *) ((*(spriteInfo->spriteData)) + sizeof(Rect));

    // loop until we are done
    exitFlag = false;
    while(!exitFlag) {
        // get a token
        tokenOp = (*((uint32_t *) srcPtr)) >> 24;
        tokenData = (*((uint32_t *) srcPtr)) & 0x00ffffff;
        srcPtr += sizeof(uint32_t);

        // depending on the token
        switch (tokenOp) {
        case DRAW_PIXELS_TOKEN:
            miscCounter = tokenData;

            // move data in the biggest chunks we can find
#ifdef powerc
            // move in doubles while we can
            while(miscCounter >= sizeof(double)) {
                *((double *) destPtr) = *((double *) srcPtr);
                destPtr += sizeof(double);
                srcPtr += sizeof(double);
                miscCounter -= sizeof(double);
            }

            // move a long if we can
            if(miscCounter >= sizeof(uint32_t)) {
                *((uint32_t *) destPtr) = *((uint32_t *) srcPtr);
                destPtr += sizeof(uint32_t);
                srcPtr += sizeof(uint32_t);
                miscCounter -= sizeof(uint32_t);
            }
#else
            // move in longs while we can
            while(miscCounter >= sizeof(uint32_t)) {
                *((uint32_t *) destPtr) = *((uint32_t *) srcPtr);
                destPtr += sizeof(uint32_t);
                srcPtr += sizeof(uint32_t);
                miscCounter -= sizeof(uint32_t);
            }
#endif

            // move a short if we can
            if(miscCounter >= sizeof(unsigned short)) {
                *((unsigned short *) destPtr) = *((unsigned short *) srcPtr);
                destPtr += sizeof(unsigned short);
                srcPtr += sizeof(unsigned short);
                miscCounter -= sizeof(unsigned short);
            }
            // move a char if we can
            if(miscCounter >= sizeof(unsigned char)) {
                *((unsigned char *) destPtr) = *((unsigned char *) srcPtr);
                destPtr += sizeof(unsigned char);
                srcPtr += sizeof(unsigned char);
                miscCounter -= sizeof(unsigned char);
            }
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
            Debugger();
            break;
        }
    }
}

//-----------------------------------------------------------------------------
tSpriteInfo *spriteLoad(signed short resID) {
    tSpriteInfo *newSprite;             // the new sprite data

    // create the sprite info record
    newSprite = (tSpriteInfo *) NewPtr(sizeof(tSpriteInfo));

    // load the sprite
    newSprite->spriteData = GetResource(SPRITE_RESOURCE_TYPE, resID);
    HNoPurge(newSprite->spriteData);
    if(newSprite->spriteData == (Handle) nil) {
        // if it did not load, drop into the debugger -- real programs would have error checking
        Debugger();
    }
    // copy its bounds rect
    newSprite->spriteRect = **((Rect **) (newSprite->spriteData));

    // return the new sprite!
    return newSprite;
}

//-----------------------------------------------------------------------------
void spriteSetClipRect(Rect *drawRect) {
    // set the clip region to be the passed in rect
    spriteClipRect = *drawRect;
}

//-----------------------------------------------------------------------------
void spriteShowTextUnclipped(tSpriteInfo *spriteInfo, Rect *inDestRect, uint32_t color) {
    unsigned char *rowStart;            // the pointer to the start of this row
    unsigned char *srcPtr;              // the current position in the sprite data
    unsigned char *destPtr;             // the current position in the destination pixmap
    uint32_t miscCounter;               // a counter for various purposes
    uint32_t tokenOp;                   // the op code from the token
    uint32_t tokenData;                 // the data from the token
    unsigned char exitFlag;             // should we exit from the loop?

    // determine characteristics about the pixmap
    rowStart = baseAddr + inDestRect->top * rowBytes + inDestRect->left;

    // move to the right place in the shape ( just past the size rect )
    srcPtr = (unsigned char *) ((*(spriteInfo->spriteData)) + sizeof(Rect));

    // loop until we are done
    exitFlag = false;
    while(!exitFlag) {
        // get a token
        tokenOp = (*((uint32_t *) srcPtr)) >> 24;
        tokenData = (*((uint32_t *) srcPtr)) & 0x00ffffff;
        srcPtr += sizeof(uint32_t);

        // depending on the token
        switch (tokenOp) {
        case DRAW_PIXELS_TOKEN:
            miscCounter = tokenData;

            // move data in the biggest chunks we can find
#ifdef powerc
            // move in doubles while we can
            while(miscCounter >= sizeof(double)) {
                *((double *) destPtr) = *((double *) srcPtr);
                destPtr += sizeof(double);
                srcPtr += sizeof(double);
                miscCounter -= sizeof(double);
            }

            // move a long if we can
            if(miscCounter >= sizeof(uint32_t)) {
                *((uint32_t *) destPtr) = *((uint32_t *) srcPtr);
                destPtr += sizeof(uint32_t);
                srcPtr += sizeof(uint32_t);
                miscCounter -= sizeof(uint32_t);
            }
#else
            // move in longs while we can
            while(miscCounter >= sizeof(uint32_t)) {
                // *((uint32_t *) destPtr) = *((uint32_t *) srcPtr);
                *((uint32_t *) destPtr) = *((uint32_t *) srcPtr);
                *((uint32_t *) destPtr) &= (uint32_t) color;
                destPtr += sizeof(uint32_t);
                srcPtr += sizeof(uint32_t);
                miscCounter -= sizeof(uint32_t);
            }
#endif

            // move a short if we can
            if(miscCounter >= sizeof(unsigned short)) {
                // *((unsigned short *) destPtr) = *((unsigned short *) srcPtr);
                *((unsigned short *) destPtr) = *((unsigned short *) srcPtr);
                *((unsigned short *) destPtr) &= (unsigned short) color;
                destPtr += sizeof(unsigned short);
                srcPtr += sizeof(unsigned short);
                miscCounter -= sizeof(unsigned short);
            }
            // move a char if we can
            if(miscCounter >= sizeof(unsigned char)) {
                // *((unsigned char *) destPtr) = *((unsigned char *) srcPtr);
                *((unsigned char *) destPtr) = *((unsigned char *) srcPtr) & color;
                destPtr += sizeof(unsigned char);
                srcPtr += sizeof(unsigned char);
                miscCounter -= sizeof(unsigned char);
            }
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
            Debugger();
            break;
        }
    }
}

//-----------------------------------------------------------------------------
void spriteStartDraw(PixMapHandle destPixMap) {
    // get info from the pix map
    baseAddr = (unsigned char *) GetPixBaseAddr(destPixMap);
    rowBytes = (*destPixMap)->rowBytes & 0x3fff;
}
