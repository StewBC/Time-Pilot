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
    numEraseThingIDs = numSortedThingIDs;

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
                        int16_t collides = 0, swap = 0;
                        if(other == 0) {
                            other = key;
                            key = 0;
                            swap = 1;
                        }
                        if(!key) {
                            if(activeLayer[other] == LAYER_ENEMY) {
                                if (activeMinX[other]+2 < PLAYER_X+11 && activeMaxX[other]-2 > PLAYER_X+5 && activeMinY[other]+2 < PLAYER_Y+11 && activeMaxY[other]-2 > PLAYER_Y+5) {
                                    collides = 1;
                                }
                            } else {
                                if(activeMinX[other] < PLAYER_X+11 && activeMaxX[other] > PLAYER_X+5 && activeMinY[other] < PLAYER_Y+11 && activeMaxY[other] > PLAYER_Y+5) {
                                    collides = 1;
                                }
                            }
                        } else if(activeMinX[other] <= activeMaxX[key]) {
                            if(activeMaxX[other] >= activeMinX[key]) {
                                collides = 1;
                            }
                        }
                        if(swap) {
                            key = other;
                            other = 0;
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
        int maxY = activeMaxY[sortedThingIDs[i]];
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
                eraseThingIDs[k + 1] = sortedThingIDs[k];
                k--;
            }
            sortedThingIDs[k + 1] = key;
            eraseThingIDs[k + 1] = key;
        }
        // Make the last thing in the group to be erased, the 1st.  That way
        // it blocks erasing the group till all in the group can be erased, and thus redrawn
        // This means nothing in this version but is needed for the Apple IIgs chasing the beam
        if(i < j-1) {
            int16_t endErase = eraseThingIDs[j-1];
            eraseThingIDs[j-1] = eraseThingIDs[i];
            eraseThingIDs[i] = endErase;
        }
        i = j;
    }
}
