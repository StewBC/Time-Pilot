//
//      File: update.c
//
//      This file contains routines to manage the update from the offscreen to the screen.
//
//      2/19/95 -- Created by Mick
//      8/11/24 -- Marginally changed for TimePilot by Stefan Wessels
//

// include files

#include "mac.h"
#include "globals.h"

#include "update.h"

// defines for this file

#define kMaxRects            30         // the maximum number of update rects
#define kInitialRects        30         // the initial number of update rects

static int sNumUpdateRects = kInitialRects; // the number of update rects
static Rect sUpdateRects[kMaxRects];    // the rects that needs to be udpated
static uint32_t sUpdateRectCount;       // how many update rects are there

//-----------------------------------------------------------------------------
void clearUpdate(void) {
    // note that there are no update rects
    sUpdateRectCount = 0;
}

//-----------------------------------------------------------------------------
void addRectToUpdate(Rect *inUpdateRect) {
    Rect newRect;                       // the rect we are adding
    uint32_t indexCounter;              // a counter to scan the rect array
    unsigned char xTouch;               // do the rects intersect horizontally
    unsigned char yTouch;               // do the rects intersect vertically
    uint32_t bestIndex;                 // the index of our best canidate rect
    uint32_t bestArea;                  // the area of our best canidate rect
    uint32_t scratchArea;               // a temp area for calculations
    Rect scratchRect;                   // a temp rect for calculations
    Rect bestRect;                      // the best rect so far

    // adjust the rect to 32 bit bounds
    newRect = *inUpdateRect;
    adjustRect(&newRect);

    // scan the list and see if the rect touches any of the rects there
    for(indexCounter = 0; indexCounter < sUpdateRectCount; indexCounter++) {
        // do the rects touch?

        // check horizontally
        if(newRect.left < sUpdateRects[indexCounter].left) {
            if(newRect.right >= sUpdateRects[indexCounter].left) {
                xTouch = 1;
            } else {
                xTouch = 0;
            }
        } else {
            if(sUpdateRects[indexCounter].right >= newRect.left) {
                xTouch = 1;
            } else {
                xTouch = 0;
            }
        }

        // check vertically
        if(newRect.top < sUpdateRects[indexCounter].top) {
            if(newRect.bottom >= sUpdateRects[indexCounter].top) {
                yTouch = 1;
            } else {
                yTouch = 0;
            }
        } else {
            if(sUpdateRects[indexCounter].bottom >= newRect.top) {
                yTouch = 1;
            } else {
                yTouch = 0;
            }
        }

        // if the rects do touch,
        if(yTouch && xTouch) {
            // join the rects into new rect
            newRect.left = (newRect.left < sUpdateRects[indexCounter].left) ? newRect.left : sUpdateRects[indexCounter].left;
            newRect.top = (newRect.top < sUpdateRects[indexCounter].top) ? newRect.top : sUpdateRects[indexCounter].top;
            newRect.right = (newRect.right > sUpdateRects[indexCounter].right) ? newRect.right : sUpdateRects[indexCounter].right;
            newRect.bottom = (newRect.bottom > sUpdateRects[indexCounter].bottom) ? newRect.bottom : sUpdateRects[indexCounter].bottom;

            // remove the rect from the list
            sUpdateRectCount -= 1;
            for(; indexCounter < sUpdateRectCount; indexCounter++) {
                // shift the next rects down
                sUpdateRects[indexCounter] = sUpdateRects[indexCounter + 1];
            }

            // call this routine with the new, joined rect
            addRectToUpdate(&newRect);

            // we are done
            return;
        }
    }

    // if there is room, add this rect to the list
    if(sUpdateRectCount < sNumUpdateRects) {
        sUpdateRects[sUpdateRectCount] = newRect;
        sUpdateRectCount++;
    } else {
        // otherwise find the rect where the union is the smallest delta
        bestIndex = 0;
        bestArea = 0xFFFFFFFF;          // a very big area
        for(indexCounter = 0; indexCounter < sUpdateRectCount; indexCounter++) {
            // create the unified rect
            scratchRect.left = (newRect.left < sUpdateRects[indexCounter].left) ? newRect.left : sUpdateRects[indexCounter].left;
            scratchRect.top = (newRect.top < sUpdateRects[indexCounter].top) ? newRect.top : sUpdateRects[indexCounter].top;
            scratchRect.right = (newRect.right > sUpdateRects[indexCounter].right) ? newRect.right : sUpdateRects[indexCounter].right;
            scratchRect.bottom = (newRect.bottom > sUpdateRects[indexCounter].bottom) ? newRect.bottom : sUpdateRects[indexCounter].bottom;

            // determine how much this will grow the rect
            scratchArea =
                (scratchRect.right -
                 scratchRect.left) * (scratchRect.bottom -
                                      scratchRect.top) -
                (sUpdateRects[indexCounter].right -
                 sUpdateRects[indexCounter].left) * (sUpdateRects[indexCounter].bottom - sUpdateRects[indexCounter].top);

            // if this area is smaller than the best so far, keep it
            if(scratchArea < bestArea) {
                bestArea = scratchArea;
                bestIndex = indexCounter;
                bestRect = scratchRect;
            }
        }

        // save our best canidate
        sUpdateRects[bestIndex] = bestRect;
    }
}


//-----------------------------------------------------------------------------
uint32_t getUpdateRectCount(void) {
    return sUpdateRectCount;
}


//-----------------------------------------------------------------------------
void getUpdateRect(uint32_t inRectIndex, Rect *outUpdateRect) {
    // return the correct rect
    *outUpdateRect = sUpdateRects[inRectIndex];
}

//-----------------------------------------------------------------------------
void increaseUpdateRects(void) {
    // make sure that we are not already at the maximum
    if(sNumUpdateRects == kMaxRects) {
        return;
    }

    // increase the number
    sNumUpdateRects++;
}

//-----------------------------------------------------------------------------
void decreaseUpdateRects(void) {
    // make sure that we are not already at the minumum
    if(sNumUpdateRects == 1) {
        return;
    }

    // increase the number
    sNumUpdateRects--;
}

//-----------------------------------------------------------------------------
void adjustRect(Rect *ioRect) {
    // expand the rect so its horizontal sides are on 32 bit bounds
    ioRect->left = ioRect->left & 0xfffC;
    ioRect->right = (ioRect->right + 3) & 0xfffC;
}
