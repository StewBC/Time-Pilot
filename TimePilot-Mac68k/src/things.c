//-----------------------------------------------------------------------------
// things.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "mac.h"
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
            X = MAX_OBJECTS - 1;
        }
    }
    insertThings = X;

    activeLayer[X] = Y;
    activeFlags[X] = layerFlags[Y];
    activeWidth[X] = layerWidth[Y];
    activeHeight[X] = layerHeight[Y];
    activeMinX[X] = spawnX;
    activeOldX[X] = spawnX;
    activeMaxX[X] = spawnX + layerWidth[Y];
    activeMinY[X] = spawnY;
    activeOldY[X] = spawnY;
    activeMaxY[X] = spawnY + layerHeight[Y];
    activeColsig[X] = layerColsig[Y];
    activeCollides[X] = layerCollides[Y];
    activeFrame[X] = 0;
    activeExtra[X] = 0;

    sortedThingIDs[numSortedThingIDs] = X;
    numSortedThingIDs++;
    return X;
}

//-----------------------------------------------------------------------------
void thingsSortAndCollide() {
    int16_t i, j, key, other, deadCount;

    // Sort for activeLayer and remove dead things
    deadCount = sortedThingIDs[0] < 0 ? 1 : 0;
    for(i = 1; i < numSortedThingIDs; ++i) {
        key = sortedThingIDs[i];
        if(key == -1) {
            deadCount++;
            continue;
        }
        j = i - 1;
        while(j >= 0 && (sortedThingIDs[j] < 0 || activeLayer[key] < activeLayer[sortedThingIDs[j]])) {
            sortedThingIDs[j + 1] = sortedThingIDs[j];
            j--;
        }
        sortedThingIDs[j + 1] = key;
    }
    numSortedThingIDs -= deadCount;     // Update the count of live objects

    // Do collision detection
    for(i = 0; i < numSortedThingIDs; i++) {
        key = sortedThingIDs[i];
        // See if this thing wants to do collisions
        if(activeCollides[key] && !(activeFlags[key] & ACTIVEFLAGS_ISDEAD)) {
            // Check all the remaining things
            for(j = i + 1; j < numSortedThingIDs; j++) {
                other = sortedThingIDs[j];
                if(!(activeFlags[other] & ACTIVEFLAGS_ISDEAD)) {
                    // Can these two things collide
                    if(activeColsig[other] & activeCollides[key]) {
                        int16_t collides = 0, swap = 0;
                        // 0 is the player, so if other is the player, "pretend" key is player
                        if(other == 0) {
                            other = key;
                            key = 0;
                            swap = 1;
                        }
                        // !key means the player is in a collision
                        if(!key) {
                            if(activeLayer[other] == LAYER_ENEMY) {
                                if(activeMinX[other] + 2 < PLAYER_X + 11 && activeMaxX[other] - 2 > PLAYER_X + 5
                                   && activeMinY[other] + 2 < PLAYER_Y + 11 && activeMaxY[other] - 2 > PLAYER_Y + 5) {
                                    collides = 1;
                                }
                            } else {
                                if(activeMinX[other] < PLAYER_X + 11 && activeMaxX[other] > PLAYER_X + 5
                                   && activeMinY[other] < PLAYER_Y + 11 && activeMaxY[other] > PLAYER_Y + 5) {
                                    collides = 1;
                                }
                            }
                        } else if(activeMinY[other] <= activeMaxY[key] &&
                                  activeMaxY[other] >= activeMinY[key] &&
                                  activeMinX[other] <= activeMaxX[key] && activeMaxX[other] >= activeMinX[key]) {
                            collides = 1;
                        }
                        // Stop "pretending" key is player if, in reality, other was player
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
}
