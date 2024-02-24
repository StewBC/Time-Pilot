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
    int8_t A, X, Y;

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
                if(activeMinY[Y] - sortKeyValue <= 0) {
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
                int8_t X1 = X + 1;
                while(X1 < numSortedThingIDs) {
                    int8_t Y1 = sortedThingIDs[X1];
                    if(!(activeFlags[Y1] & ACTIVEFLAGS_ISDEAD)) {
                        if(activeMinY[Y1] > activeMaxY[Y]) {
                            break;  // The rest are also all lower so done with X
                        }
                        int8_t collides = 0;
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
}
