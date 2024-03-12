//-----------------------------------------------------------------------------
// things.c
// Part of Time Pilot, the 1982 arcade game remake for the Commander X16
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include <stdint.h>
#include "globals.h"

#include "collide.h"
#include "data.h"
#include "things.h"

#include <cx16.h>

//-----------------------------------------------------------------------------
// Y is the layer and global spawnX and spawnY are the coords
uint8_t thingsAdd(uint8_t Y) {
    // Search, without overflow protection, in the range set aside for the layer
    // for a place for the new object
    uint8_t spriteSize;
    int8_t X = layerToThingTable[Y];
    while(activeFlags[X]) {
        X--;
    }

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
    activeFrame[X]    = 0;
    activeExtra[X]    = 0;

    VERA.address_hi = VERA_INC_1 | 1;
    VERA.address = VERA_SPRITES_BASE + (X * 8);
    
    if(Y == LAYER_ENEMY) {
        VERA.data0 = spriteVRAMEnemies_lo[activeStage];
        VERA.data0 = spriteVRAMEnemies_hi[activeStage];
        spriteSize = activeStage == TIME_PERIOD4_2001 ? (1 << 4) : ((1 << 6) | (1 << 4)) ;
    } else if(Y == LAYER_LEVELBOSS) {
        VERA.data0 = spriteVRAMBosses_lo[activeStage];
        VERA.data0 = spriteVRAMBosses_hi[activeStage];
        spriteSize = ((1 << 6) | (2 << 4));
    } else {
        VERA.data0 = spriteVRAMAddress_lo[Y];
        VERA.data0 = spriteVRAMAddress_hi[Y];
        spriteSize = spriteSizeByLayer[Y];
    }
    VERA.data0 = spawnX & 0xff;
    VERA.data0 = spawnX >> 8;
    VERA.data0 = spawnY & 0xff;
    VERA.data0 = spawnY >> 8;
    VERA.data0 = 0b00001000;
    VERA.data0 = spriteSize | 1;
    sortedThingIDs[numSortedThingIDs] = X;
    numSortedThingIDs++;
    
    return X;
}

//-----------------------------------------------------------------------------
void thingsSortAndCollide() {
    int8_t i, j, key, other, deadCount;

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
        if(activeCollides[key] && !(activeFlags[key] & ACTIVEFLAGS_ISDEAD)) {
            for(j = i + 1; j < numSortedThingIDs; j++) {
                other = sortedThingIDs[j];
                if(!(activeFlags[other] & ACTIVEFLAGS_ISDEAD)) {
                    if(activeMinY[other] > activeMaxY[key]) {
                        break;
                    }
                    if(activeColsig[other] & activeCollides[key]) {
                        int8_t collides = 0;
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
}
