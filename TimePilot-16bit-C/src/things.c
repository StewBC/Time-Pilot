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
    int16_t i, j, key, other, deadCount;

    // Sort for activeMinY and remove dead things
    deadCount = sortedThingIDs[0] < 0 ? 1 : 0;
    for (i = 1; i < numSortedThingIDs; ++i) {
        key = sortedThingIDs[i];
        if (key == -1) {
            deadCount++;
            continue;
        }
        j = i - 1;
        while(j >= 0 && (sortedThingIDs[j] < 0 || activeMinY[key] < activeMinY[sortedThingIDs[j]])) {
            sortedThingIDs[j + 1] = sortedThingIDs[j];
            j--;
        }
        sortedThingIDs[j + 1] = key;
    }
    numSortedThingIDs -= deadCount; // Update the count of live objects

    for(i = 0; i < numSortedThingIDs; i++) {
        key = sortedThingIDs[i];
        eraseThingIDs[i] = key;
        if(activeCollides[key] && !(activeFlags[key] & ACTIVEFLAGS_ISDEAD)) {
            for(j = i + 1; j < numSortedThingIDs; j++) {
                other = sortedThingIDs[j];
                if(!(activeFlags[other] & ACTIVEFLAGS_ISDEAD)) {
                    if(activeMinY[other] > activeMaxY[key]) {
                        break;
                    }
                    if(activeColsig[other] & activeCollides[key]) {
                        int16_t collides = 0;
                        // If the player is involved in a collision, make the collision box a lot tighter, more forgiving
                        if(activeLayer[other] == LAYER_PLAYER) {
                            if(activeMinX[key] < PLAYER_X+11 && activeMaxX[key] > PLAYER_X+5 && activeMinY[key] < PLAYER_Y+11 && activeMaxY[key] > PLAYER_Y+5) {
                                collides = 1;
                            }
                        } else if(activeLayer[key] == LAYER_PLAYER) {
                            if(activeMinX[other] < PLAYER_X+11 && activeMaxX[other] > PLAYER_X+5 && activeMinY[other] < PLAYER_Y+11 && activeMaxY[other] > PLAYER_Y+5) {
                                collides = 1;
                            }
                        } else if(activeMinX[other] <= activeMaxX[key]) {
                            if(activeMaxX[other] >= activeMinX[key]) {
                                collides = 1;
                            }
                        }
                        if(collides) {
                            collideThings(key, other);
                            collideThings(other, key);
                            break;
                        }
                    }
                }
            }
        }
    }

    // Identify overlapping sprites, considering Y only
    i = 0;
    while(i < numSortedThingIDs) {
        key = sortedThingIDs[i];
        int maxY = activeMaxY[key];
        for(j = i + 1; j < numSortedThingIDs; j++) {
            other = sortedThingIDs[j];
            if(maxY >= activeMinY[other]) {
                // Grow the overlap area by the included sprite, if needed
                if(maxY < activeMaxY[other]) {
                    maxY = activeMaxY[other];
                }
            }
            else {
                break;
            }
        }
        // Sort the overlapping sprites by layer
        for (int16_t start = i + 1; start < j; ++start) {
            int16_t key = sortedThingIDs[start];
            int16_t value = activeLayer[key];
            int16_t k = start - 1;
            while(k >= i && (value < activeLayer[sortedThingIDs[k]])) {
                sortedThingIDs[k + 1] = sortedThingIDs[k];
                k--;
            }
            sortedThingIDs[k + 1] = key;
        }
        // Start again past the overlapping region
        i = j;
    }
}
