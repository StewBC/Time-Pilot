//-----------------------------------------------------------------------------
// things.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "tigr.h"
#include "globals.h"

#include "collide.h"
#include "data.h"
#include "things.h"

//-----------------------------------------------------------------------------
// Y is the layer and global spawnX and spawnY are the coords
uint16_t thingsAdd(uint16_t Y) {
    int16_t X = insertThings;
    while(activeFlags[X]) {
        if(--X < 0) {
            X = MAX_OBJECTS-1;
        }
    }
    insertThings      = X;

    activeLayer[X]    = Y;
    activeFlags[X]    = layerFlags[Y];
    activeWidth[X]    = layerWidth[Y];
    activeHeight[X]   = layerHeight[Y];
    activeMinX[X]     = spawnX;
    activeOldX[X]     = spawnX;
    activeMaxX[X]     = spawnX+layerWidth[Y];
    activeMinY[X]     = spawnY;
    activeOldY[X]     = spawnY;
    activeMaxY[X]     = spawnY+layerHeight[Y];
    activeColsig[X]   = layerColsig[Y];
    activeCollides[X] = layerCollides[Y];
    activeBMPIdx[X]   = layerBMPIndex[Y];
    activeFrame[X]    = 0;
    activeExtra[X]    = 0;

    if(activeLayer[X] == LAYER_ENEMY || activeLayer[X] == LAYER_LEVELBOSS) {
        activeBMPIdx[X] += activeStage;
    }

    sortedThingIDs[numSortedThingIDs] = X;
    numSortedThingIDs++;
    return X;
}

//-----------------------------------------------------------------------------
void thingsSortAndCollide() {
    int16_t A, X, Y;

    reduce = X = 0;
    if(sortedThingIDs[0] < 0) {
        reduce++;
    }
    while(++X < numSortedThingIDs) {
        Y = sortedThingIDs[X];
        if(Y < 0) {
            reduce++;
            continue;
        }
        sortKey = Y;
        sortKeyValue = activeMinY[Y];

        Y = X;
        while(--Y >= 0) {
            A = sortedThingIDs[Y];
            if(A >= 0) {
                index0 = Y;
                Y = A;
                A = activeMinY[Y];
                A -= sortKeyValue;
                if(A <= 0) {
                    Y = index0;
                    break;
                }
                A = Y;
                Y = index0;
            }

            sortedThingIDs[Y+1] = A;
        }

        Y++;
        sortedThingIDs[Y] = sortKey;
    }
    numSortedThingIDs -= reduce;

    // Collision Checks
    X = 0;
    while(X < numSortedThingIDs) {
        Y = sortedThingIDs[X];
        if(activeCollides[Y]) {
            if(!(activeFlags[Y] & ACTIVEFLAGS_ISDEAD)) {
                int16_t X1 = X + 1;
                while(X1 < numSortedThingIDs) {
                    int16_t Y1 = sortedThingIDs[X1];
                    if(!(activeFlags[Y1] & ACTIVEFLAGS_ISDEAD)) {
                        if(activeMinY[Y1] > activeMaxY[Y]) {
                            break;  // The rest are also all lower so done with X
                        }
                        int16_t collides = 0;
                        if(activeColsig[Y1] & activeCollides[Y]) {
                            // If the player is involved in a collision, make the collision box a lot tighter, more forgiving
                            if(activeLayer[Y1] == LAYER_PLAYER) {
                                if(activeMinX[Y] < PLAYER_X+11 && activeMaxX[Y] > PLAYER_X+5 && activeMinY[Y] < PLAYER_Y+11 && activeMaxY[Y] > PLAYER_Y+5) {
                                    collides = 1;
                                }
                            } else if(activeLayer[Y] == LAYER_PLAYER) {
                                if(activeMinX[Y1] < PLAYER_X+11 && activeMaxX[Y1] > PLAYER_X+5 && activeMinY[Y1] < PLAYER_Y+11 && activeMaxY[Y1] > PLAYER_Y+5) {
                                    collides = 1;
                                }
                            } else if(activeMinX[Y1] <= activeMaxX[Y]) {
                                if(activeMaxX[Y1] >= activeMinX[Y]) {
                                    collides = 1;
                                }
                            }
                            if(collides) {
                                collideThings(Y, Y1);
                                collideThings(Y1, Y);
                                break;
                            }
                        }
                    }
                    X1++;
                }
            }
        }
        X++;
    }

    endIndex = 0;
    do {
        X = endIndex;
        Y = X + 1;
        if(Y >= numSortedThingIDs) {
            break;
        }
        startIndex = X;
        endIndex = Y;
        index0 = activeMaxY[sortedThingIDs[X]]; // index0 = X.max
        do {
            eraseThingIDs[Y] = sortedThingIDs[Y];
            if(activeMinY[sortedThingIDs[Y]] >= index0) { // if Y.min >= X.max then no overlap
                break;
            }
            // Don't worry about the X - to test and update the possible X overlaps would require a
            // Growing cube or more accurately a smart bounding box which will take longer to maintain
            // than just assuming there's an X overlap.  At least for now.
            // Overlaps
            if(activeMaxY[sortedThingIDs[Y]] > index0) { // if Y.max > X.max then X.max = Y.max (kinda)
                index0 = activeMaxY[sortedThingIDs[Y]];
            }
            endIndex = ++Y;
        } while(Y < numSortedThingIDs);
        thingsSortOverlapByLayer();
        X = startIndex;
        Y = endIndex;
        // Reverse the order of the EraseIDs
        while(X < Y) {
            eraseThingIDs[X] = sortedThingIDs[--Y];
            eraseThingIDs[Y] = sortedThingIDs[X++];
        }
    } while(1);
}

//-----------------------------------------------------------------------------
void thingsSortOverlapByLayer() {
    int16_t A, X, Y;

    X = startIndex;
    while(++X < endIndex) {
        Y = sortedThingIDs[X];
        sortKey = Y;
        sortKeyValue = activeLayer[Y];
        Y = X - 1;
        while(Y >= 0 && Y >= startIndex && activeLayer[sortedThingIDs[Y]] >= sortKeyValue) {
            A = sortedThingIDs[Y];
            sortedThingIDs[Y+1] = A;
            Y--;
        }
        Y++;
        sortedThingIDs[Y] = sortKey;
    }
}
