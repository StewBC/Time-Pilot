//-----------------------------------------------------------------------------
// ai.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "mac.h"
#include "globals.h"

#include "ai.h"
#include "audio.h"
#include "data.h"
#include "input.h"
#include "resids.h"
#include "things.h"

//-----------------------------------------------------------------------------
// Y is offset to velocity values to use (the angle, offset by the "speed" needed), X is active thing
void aiAddVelocity(int16_t X, int16_t Y) {
    uint16_t c;

    c = activeXVelFrac[X] + velXfrac[Y];
    if(c < activeXVelFrac[X]) {
        activeMinX[X]++;
    }
    activeMinX[X] += velXwhole[Y];
    activeMaxX[X] = activeMinX[X] + activeWidth[X];
    activeXVelFrac[X] = c;

    c = activeYVelFrac[X] + velYfrac[Y];
    if(c < activeYVelFrac[X]) {
        activeMinY[X]++;
    }
    activeMinY[X] += velYwhole[Y];
    activeMaxY[X] = activeMinY[X] + activeHeight[X];
    activeYVelFrac[X] = c;
}

//-----------------------------------------------------------------------------
void aiBomber(int16_t X) {
    aiHorizontalFlyer(X);
    if(activeFlags[X] & ACTIVEFLAGS_REMOVE) {
        bomberTimer = BOMBER_TIMER;
    } else if(!(frameCounter & 3) && bomberHealth < BOMBER_HEALTH) {
        if(--activeFrame[X] < 0) {
            activeFrame[X] = bossAnimFrames[bomberHealth];
        }
    }
}

//-----------------------------------------------------------------------------
void aiChkWrap(int16_t X) {
    if(activeMinX[X] + WRAP_SIZE < 0) {
        activeMaxX[X] += WRAP_SIZE + SCREEN_PLAYAREA_RIGHT;
        activeMinX[X] = activeMaxX[X] - activeWidth[X];
        activeFlags[X] |= ACTIVEFLAGS_CLIPMASK;
    } else if(WRAP_SIZE + SCREEN_PLAYAREA_RIGHT - activeMaxX[X] < 0) {
        activeMinX[X] = -WRAP_SIZE;
        activeMaxX[X] = activeMinX[X] + activeWidth[X];
        activeFlags[X] |= ACTIVEFLAGS_CLIPMASK;
    }

    if(activeMinY[X] + WRAP_SIZE < 0) {
        activeMaxY[X] = WRAP_SIZE + SCREEN_PLAYAREA_BOTTOM;
        activeMinY[X] = activeMaxY[X] - activeHeight[X];
        activeFlags[X] |= ACTIVEFLAGS_CLIPMASK;
    } else if(WRAP_SIZE + SCREEN_PLAYAREA_BOTTOM - activeMaxY[X] < 0) {
        activeMinY[X] = -WRAP_SIZE;
        activeMaxY[X] = activeMinY[X] + activeHeight[X];
        activeFlags[X] |= ACTIVEFLAGS_CLIPMASK;
    }
}

//-----------------------------------------------------------------------------
void aiClouds0(int16_t X) {
    aiAddVelocity(X, invPlayerAngle + VELOCITY_050);
    aiChkWrap(X);
}

//-----------------------------------------------------------------------------
void aiClouds1(int16_t X) {
    aiAddVelocity(X, invPlayerAngle + VELOCITY_075);
    aiChkWrap(X);
}

//-----------------------------------------------------------------------------
void aiClouds2(int16_t X) {
    aiAddVelocity(X, invPlayerAngle + VELOCITY_119);
    aiChkWrap(X);
}

//-----------------------------------------------------------------------------
void aiEndFrame() {

    // Player Exit
    if(playerExitTimer != 0) {
        if(++playerExitTimer > PLAYER_DIED_TIMER) {
            playerExitTimer = -1;
            return;
        }
    }
    // Boss Exit
    if(levelBossHealth <= 0) {
        return;
    }

    scoreTimer++;

    // Spawn a BOSS?
    if(enemiesKilled > ENEMIES_TO_KILL_TO_CLEAR) {
        if(levelBossHealth && !audioIsSourcePlaying(stageBossAudio[activeStage])) {
            audioPlaySource(stageBossAudio[activeStage]);
        }
        if(levelBossTimer >= 0) {
            if(--levelBossTimer < 0) {
                int16_t X = horizontalLaunchRayTable[playerAngle];
                int16_t horizontalDir = horizontalDirectionTable[X];
                if(!horizontalDir) {
                    spawnX = SCREEN_PLAYAREA_RIGHT;
                } else {
                    spawnX = -32;
                }
                spawnY = launchPosY[X];
                spawnY += ((aiRandom() & 3) - 2) << 4;
                activeFlags[thingsAdd(LAYER_LEVELBOSS)] |= horizontalDir;
            }
        }
    } else {
        if(TIME_PERIOD4_2001 != activeStage) {
            // Spawn a Parachute?
            if(parachuteTimer >= 0) {
                if(--parachuteTimer == 0) {
                    int16_t X = playerAngle + ((aiRandom() & 3) - 2) & 31;
                    parachuteTimer--;
                    spawnX = launchPosX[X];
                    spawnY = launchPosY[X];
                    thingsAdd(LAYER_PARACHUTE);
                }
            }
            // Spawn a bomber (bomberTimer only on Level 2)
            if(bomberTimer > 0) {
                if(--bomberTimer == 0) {
                    int16_t X = horizontalLaunchRayTable[playerAngle];
                    int16_t horizontalDir = horizontalDirectionTable[X];
                    if(!horizontalDir) {
                        spawnX = SCREEN_PLAYAREA_RIGHT;
                    } else {
                        spawnX = -32;
                    }
                    spawnY = launchPosY[X];
                    spawnY += ((aiRandom() & 3) - 2) << 4;
                    bomberHealth = BOMBER_HEALTH;
                    activeFlags[thingsAdd(LAYER_BOMBER)] |= horizontalDir;
                }
            }
        }
    }

    // Spawn a Bullet?
    if(bulletTimer) {
        if(!(bulletTimer & 7)) {
            spawnX = PLAYER_X + 6;
            spawnY = PLAYER_Y + 8;
            // Bullets use the extra for direction
            activeHeading[thingsAdd(LAYER_PLAYER_BULLETS)] = playerAngle;
            audioPlaySource(AUDIO_PLAYER_SHOOT);
        }
        bulletTimer--;
    }

    if(TIME_PERIOD4_2001 != activeStage) {
        // Check to see if a wave needs to spawn
        if(aiSpawnTimer >= ENEMY_SPAWN_WAVE_TIMER) {
            if(aiSpawnTimer == ENEMY_SPAWN_WAVE_TIMER) {
                // If the life has lasted this long, up the difficulty a little
                if(frameCounter >= 1500) {
                    numberOfAIFollowersMax = 3;
                    numberOfTrackedMax = 3;
                }
                waveSpawnL = waveSpawnR = playerAngle;
                waveSpawnNumber = ACTIVEFLAGS_ENEMYMASK - numberOfEnemies;
                if(waveSpawnNumber < 3) {
                    aiSpawnTimer = 0;
                    return;
                }
                if(waveSpawnNumber > 5) {
                    waveSpawnNumber = 5;
                } else if(waveSpawnNumber == 4) {
                    waveSpawnL = (waveSpawnL - 1) & 31;
                    waveSpawnR = (waveSpawnR + 1) & 31;
                }
                numberOfWaveEnemies = waveSpawnNumber;
                waveSpawnDir = invPlayerAngle;
                waveSpawnDuration = ENEMY_WAVE_ENTRY_TIMER + (aiRandom() & 15);
                waveSpawnIndex = ACTIVEFLAGS_ENEMYMASK;
                audioPlaySource(AUDIO_WAVE_START);
                // Waves spawn 4x as fast as normal enemies
            } else if(!(aiSpawnTimer & (ENEMY_SPAWN_TIMER >> 1))) {
                aiSpawnWave();
            }
        } else if(!(aiSpawnTimer & ENEMY_SPAWN_TIMER) && !playerExitTimer) {
            if(aiSpawnTimer < ENEMY_RECALL_TIMER) {
                if(numberOfEnemies < 8) {
                    aiSpawnEnemy();
                }
            } else if(aiSpawnTimer == ENEMY_RECALL_TIMER) {
                aiRecallEnemies();
            }
        }
    } else {
        if(!(aiSpawnTimer & ENEMY_SPAWN_TIMER) && !playerExitTimer && numberOfEnemies < 8) {
            aiSpawnEnemy();
        }
    }
}

//-----------------------------------------------------------------------------
void aiEnemy(int16_t X) {
    int16_t eID = aiSpawnTimer & 7;
    // Move by player "thrust"
    aiAddVelocity(X, invPlayerAngle + VELOCITY_119);
    // Is the time right to think
    if(enemyID[eID] == X) {
        int16_t current, target, x, y, calculated = 0;

        if(activeFlags[X] & ACTIVEFLAGS_AI_WAVE) {
            //  See if the time for change has come
            if(!(--activeTimer[X])) {
                // If the enemy already had an action
                if(activeFlags[X] & (ACTIVEFLAGS_AI_FLEE | ACTIVEFLAGS_AI_FOLLOW)) {
                    // It's time to disband the wave
                    activeFlags[X] &= ~ACTIVEFLAGS_AI_WAVE;
                    // NOTE: The flee and follow states have no timer set
                } else {
                    // It's time to give the wave enemies an action and a duration
                    if(numberOfAIFollowers < numberOfAIFollowersMax) {
                        numberOfAIFollowers++;
                        activeFlags[X] |= ACTIVEFLAGS_AI_FOLLOW;
                    } else {
                        activeFlags[X] |= ACTIVEFLAGS_AI_FLEE;
                        // Prevent a fleeing enemy from shooting (unless it has shot but mostly this works)
                        // and no big deal if it doesn't
                        enemyWeapon[eID] = 2 * MAX_OBJECTS + 1;
                    }
                    activeTimer[X] = ENEMY_WAVE_ACTIVE_TIMER;
                }
            }
        } else {
            // Patrol enemy - time to change direction
            if(!(--activeTimer[X])) {
                // Yes - pick a new heading and how long to hold that for
                enemyHeading[eID] = aiRandom() & 31;
                activeTimer[X] = ENEMY_STEADY_MIN_TIME + enemyHeading[eID];
            }
        }

        if(activeFlags[X] & (ACTIVEFLAGS_AI_FOLLOW | ACTIVEFLAGS_AI_FLEE)) {
            // Get the X and Y and look up the beam it should ride
            x = (activeMinX[X] >> 4) & 31;
            y = (activeMinY[X] >> 4) & 31;
            target = rays[y][x];
            calculated++;

            if(activeFlags[X] & ACTIVEFLAGS_AI_FLEE) {
                target ^= (32 / 2);
            }
            enemyHeading[eID] = target;
        }
        // move current to heading clockwise or anti-clockwise on shortest path if needed
        current = activeFrame[X];
        if(current != enemyHeading[eID]) {
            int16_t A = (enemyHeading[eID] - current) & 31;
            // A >= 16 anti clock
            if(A & 16) {
                current--;
            } else {
                current++;
            }
            activeFrame[X] = current & 31;
        }
        // Is shooting a possibility?
        if(enemyWeapon[eID] == 2 * MAX_OBJECTS && !(exitGameMask & EXIT_PLAYER_DIED)) {
            if(!calculated) {
                x = (activeMinX[X] >> 4) & 31;
                y = (activeMinY[X] >> 4) & 31;
                target = rays[y][x];
            }
            // Is the player in sights
            if(target == activeFrame[X]) {
                int16_t A = (target - playerAngle) & 31;
                if(A >= 30 || A < 2) {
                    spawnX = activeMinX[X] + 8;
                    spawnY = activeMinY[X] + 4;
                    if(activeStage == TIME_PERIOD4_2001) {
                        enemyWeapon[eID] = thingsAdd(LAYER_ENEMY_SPACEBULLETS);
                    } else {
                        enemyWeapon[eID] = thingsAdd(LAYER_ENEMY_BULLETS);
                    }
                    activeEID[enemyWeapon[eID]] = eID;
                    // Use extra for the direction
                    activeHeading[enemyWeapon[eID]] = activeFrame[X];
                    audioPlaySource(AUDIO_ENEMY_SHOOT);
                }
            } else if(activeStage != TIME_PERIOD1_1940 && numberOfTracked < numberOfTrackedMax) {
#define WEAPON_BORDER 4*8
                if(!activeStage) {
                    // In Period0, Launch a bomb?
                    if((!launchSide && activeMinX[X] < WEAPON_BORDER) || (launchSide && activeMinX[X] >= PLAYFIELDW * 8 - WEAPON_BORDER)) {
                        // Bombs only launch when enemy is in one of the wedges
                        if((target < 2 || target == 31) || (target >= 15 && target <= 17)) {
                            spawnX = activeMinX[X] + 8;
                            spawnY = activeMinY[X] + 4;
                            enemyWeapon[eID] = thingsAdd(LAYER_ENEMY_BOMBS);
                            if(!launchSide) {
                                activeFrame[enemyWeapon[eID]] = 29;
                                activeFlags[enemyWeapon[eID]] |= ACTIVEFLAGS_DIR_RIGHT;
                            } else {
                                activeFrame[enemyWeapon[eID]] = 19;
                            }
                            activeEID[enemyWeapon[eID]] = eID;
                            numberOfTracked++;
                            launchSide ^= 1;
                            audioPlaySource(AUDIO_BOMB);
                        }
                    }
                    // In Periods 2, 3 or 4, Launch a missile?
                } else if((!launchSide && (activeMinY[X] < WEAPON_BORDER || activeMinX[X] < WEAPON_BORDER)) ||
                          launchSide && (activeMinY[X] >= PLAYFIELDH * 8 - WEAPON_BORDER
                                         || activeMinX[X] >= PLAYFIELDW * 8 - WEAPON_BORDER)) {
                    spawnX = activeMinX[X] + 8;
                    spawnY = activeMinY[X] + 4;
                    audioPlaySource(AUDIO_ROCKET_LAUNCH);
                    if(activeStage == TIME_PERIOD4_2001) {
                        enemyWeapon[eID] = thingsAdd(LAYER_ENEMY_BOOMERANG);
                    } else {
                        audioPlaySource(AUDIO_ROCKET_FLY);
                        numberOfRockets++;
                        enemyWeapon[eID] = thingsAdd(LAYER_ENEMY_ROCKETS);
                    }
                    activeEID[enemyWeapon[eID]] = eID;
                    activeHeading[enemyWeapon[eID]] = activeFrame[X];
                    numberOfTracked++;
                    launchSide ^= 1;
                }
            }
        }
    }
    // Now add the velocity of the AI "thrust"
    if(activeStage < TIME_PERIOD3_1982) {
        aiAddVelocity(X, activeFrame[X] + VELOCITY_100);
    } else {
        aiAddVelocity(X, activeFrame[X] + VELOCITY_119);
    }
    aiNonWrapping(X);
}

//-----------------------------------------------------------------------------
void aiEnemyBombs(int16_t X) {
    aiAddVelocity(X, invPlayerAngle + VELOCITY_119);
    if(activeFlags[X] & ACTIVEFLAGS_DIR_RIGHT) {
        if(activeFrame[X] != 6) {
            if(!(frameCounter & 3)) {
                activeFrame[X] = (activeFrame[X] + 1) & 31;
            }
            aiAddVelocity(X, activeFrame[X] + VELOCITY_150);
        } else {
            aiAddVelocity(X, activeFrame[X] + VELOCITY_200);
        }
    } else {
        if(activeFrame[X] != 10) {
            if(!(frameCounter & 3)) {
                activeFrame[X]--;
            }
            aiAddVelocity(X, activeFrame[X] + VELOCITY_150);
        } else {
            aiAddVelocity(X, activeFrame[X] + VELOCITY_200);
        }
    }
    aiNonWrapping(X);
}

//-----------------------------------------------------------------------------
void aiEnemyBoomerang(int16_t X) {
    // if(!levelBossHealth) {
    //     activeFlags[X] |= ACTIVEFLAGS_REMOVE;
    //     return;
    // }

    if(!(frameCounter & 15)) {
        if(activeMinX[X] < (PLAYFIELDW / 2 + 8) * 8 && activeMinX[X] > (PLAYFIELDW / 2 - 8) * 8 &&
           activeMinY[X] < (PLAYFIELDH / 2 + 8) * 8 && activeMinY[X] > (PLAYFIELDH / 2 - 8) * 8) {
            activeHeading[X] = aiTurnOnRay(X) & 31;
        }
    }
    aiAddVelocity(X, invPlayerAngle + VELOCITY_119);
    aiAddVelocity(X, activeHeading[X] + VELOCITY_200);
    if(!(frameCounter & 1)) {
        activeFrame[X] = (activeFrame[X] + 1) & 7;
    }
    aiNonWrapping(X);
}

//-----------------------------------------------------------------------------
void aiEnemyBullets(int16_t X) {
    aiAddVelocity(X, invPlayerAngle + VELOCITY_119);
    aiAddVelocity(X, activeHeading[X] + VELOCITY_200); // Direction in Extra
    aiNonWrapping(X);
}

//-----------------------------------------------------------------------------
void aiEnemyRockets(int16_t X) {
    aiAddVelocity(X, invPlayerAngle + VELOCITY_119);
    if(!(frameCounter & 15)) {
        activeHeading[X] = aiTurnOnRay(X) & 31;
        activeFrame[X] = activeHeading[X] >> 1;
    }
    aiAddVelocity(X, activeHeading[X] + VELOCITY_150);
    aiNonWrapping(X);
}

//-----------------------------------------------------------------------------
void aiEnemySpaceBullets(int16_t X) {
    aiAddVelocity(X, invPlayerAngle + VELOCITY_119);
    aiAddVelocity(X, activeHeading[X] + VELOCITY_200); // Direction in extra
    if(!(frameCounter & 3)) {
        activeFrame[X] = (activeFrame[X] + 1) & 3;
    }
    aiNonWrapping(X);
}

//-----------------------------------------------------------------------------
void aiExplodeThing(int16_t X) {
    if(--activeTimer[X] < 0) {
        if(--activeFrame[X] < 0) {
            activeFlags[X] |= ACTIVEFLAGS_REMOVE;
        } else {
            if(activeWidth[X] <= 16) {
                activeTimer[X] = explode_16x16_hold_table[activeFrame[X]];
            } else {
                activeTimer[X] = explode_32x16_hold_table[activeFrame[X]];
            }
        }
    }
    aiAddVelocity(X, invPlayerAngle + VELOCITY_119);
    aiNonWrapping(X);
}

//-----------------------------------------------------------------------------
void aiHorizontalFlyer(int16_t X) {
    aiAddVelocity(X, invPlayerAngle + VELOCITY_119);
    if(activeFlags[X] & ACTIVEFLAGS_DIR_RIGHT) {
        aiAddVelocity(X, VELOCITY_100);
    } else {
        aiAddVelocity(X, VELOCITY_100 + 16);
    }
    aiNonWrapping(X);
    if(!(frameCounter & 31)) {
        if(numberOfTracked < numberOfTrackedMax) {
            int16_t A, heading = aiRandom() & 15;
            spawnX = activeMinX[X] + 8;
            spawnY = activeMinY[X] + 4;
            if(spawnX > PLAYFIELDW * 8 / 2) {
                heading += 8;
            } else {
                heading -= 8;
                heading &= 31;
            }
            if(activeStage == TIME_PERIOD4_2001) {
                A = thingsAdd(LAYER_ENEMY_SPACEBULLETS);
            } else {
                A = thingsAdd(LAYER_ENEMY_BULLETS);
            }
            activeHeading[A] = heading; // Direction in extra
            activeFlags[A] |= ACTIVEFLAGS_TRACKED;
            numberOfTracked++;
        }
    }
}

//-----------------------------------------------------------------------------
// Boss frames are:
// 0 - right no damage; 3 - right full damage;
// 4 - left  no damage; 7 - left  full damage
void aiLevelBoss(int16_t X) {
    aiHorizontalFlyer(X);
    if(activeFlags[X] & ACTIVEFLAGS_REMOVE) {
        levelBossTimer = LEVELBOSS_TIMER;
    } else if(activeStage < TIME_PERIOD4_2001) {
        // Bosses have 4 frames in each direction for periods 0..3
        if(!(frameCounter & 3) && levelBossHealth < LEVELBOSS_HEALTH) {
            if(--activeFrame[X] < 0) {
                activeFrame[X] = bossAnimFrames[levelBossHealth >> 1];
            }
        }
    } else if(!(frameCounter & 3)) {
        // Period 4 boss has only 2 frames
        activeFrame[X] ^= 1;
    }
}

//-----------------------------------------------------------------------------
void aiNonWrapping(int16_t X) {
    if((activeFlags[X] & ACTIVEFLAGS_CLIPMASK) == ACTIVEFLAGS_CLIPMASK) {
        if(activeLayer[X] == LAYER_PLAYER_BULLETS) {
            activeFlags[X] |= ACTIVEFLAGS_REMOVE;
            return;
        } else if(activeLayer[X] == LAYER_ENEMY_BULLETS || activeLayer[X] == LAYER_ENEMY_SPACEBULLETS) {
            activeFlags[X] |= ACTIVEFLAGS_REMOVE;
            if(activeFlags[X] & ACTIVEFLAGS_TRACKED) {
                // Horizontal flyer bullet
                numberOfTracked--;
            } else {
                // Actual enemy bullet
                enemyWeapon[activeEID[X]] = 2 * MAX_OBJECTS;
            }
            return;
        }

        if(++activeOffScreen[X] == ACTIVEOFFSCREEN_COUNT) {
            activeFlags[X] |= ACTIVEFLAGS_REMOVE;
            if(activeLayer[X] == LAYER_ENEMY) {
                numberOfEnemies--;
                enemyID[activeEID[X]] = 2 * MAX_OBJECTS;
                if(activeFlags[X] & ACTIVEFLAGS_AI_FOLLOW) {
                    numberOfAIFollowers--;
                }
                // Might still not be able to shoot
            } else if(activeLayer[X] >= LAYER_ENEMY_BOMBS && activeLayer[X] < LAYER_ENEMY_BOOMERANG + 1) {
                enemyWeapon[activeEID[X]] = 2 * MAX_OBJECTS;
                numberOfTracked--;
                if(numberOfRockets && !(--numberOfRockets)) {
                    audioStopSource(AUDIO_ROCKET_FLY);
                }
            }
        }
    } else {
        activeOffScreen[X] = 0;
    }
}

//-----------------------------------------------------------------------------
void aiParachute(int16_t X) {
    if(!(frameCounter & 15)) {
        if(--activeExtra[X] < 0) {
            activeExtra[X] = 5;
        }
        activeFrame[X] = parachute_sprite_table[activeExtra[X]];
    }
    aiAddVelocity(X, invPlayerAngle + VELOCITY_119);
    aiNonWrapping(X);
    if(activeFlags[X] & ACTIVEFLAGS_REMOVE) {
        parachuteTimer = PARACHUTE_TIMER;
        parachuteScore = 0;
    }
}

//-----------------------------------------------------------------------------
void aiPlayer(int16_t X) {
    inputInGame();
}

//-----------------------------------------------------------------------------
void aiPlayerBullets(int16_t X) {
    // direction for bullets in extra
    aiAddVelocity(X, activeHeading[X] + VELOCITY_400);
    aiNonWrapping(X);
}

//-----------------------------------------------------------------------------
// The rendom number is only 8-bits
int16_t aiRandom() {
    int16_t A = randomSeed << 1;
    if(randomSeed & 0x80) {
        A ^= 0x1d;
    }
    randomSeed = (A & 0xFF);
    return randomSeed;
}

//-----------------------------------------------------------------------------
void aiRecallEnemies() {
    int16_t index;
    for(index = ACTIVEFLAGS_ENEMYMASK; index >= 0; index--) {
        if(enemyID[index] < 2 * MAX_OBJECTS) {
            activeFlags[enemyID[index]] |= ACTIVEFLAGS_AI_FLEE;
        }
    }
}

//-----------------------------------------------------------------------------
void aiRts(int16_t X) {

}

//-----------------------------------------------------------------------------
void aiScores(int16_t X) {
    if(--activeTimer[X]) {
        aiAddVelocity(X, invPlayerAngle + VELOCITY_119);
        aiNonWrapping(X);
    } else {
        activeFlags[X] |= ACTIVEFLAGS_REMOVE;
    }
}

//-----------------------------------------------------------------------------
void aiSpawnEnemy() {
    int16_t Y, X;
    for(Y = ACTIVEFLAGS_ENEMYMASK; Y >= 0; Y--) {
        if(enemyID[Y] == 2 * MAX_OBJECTS) {
            int16_t A = (((aiRandom() & 7) - 4) + playerAngle) & 31;
            spawnX = launchPosX[A];
            spawnY = launchPosY[A];
            enemyID[Y] = thingsAdd(LAYER_ENEMY);
            activeEID[enemyID[Y]] = Y;
            enemyHeading[Y] = invPlayerAngle;
            activeFrame[enemyID[Y]] = invPlayerAngle;
            activeTimer[enemyID[Y]] = ENEMY_STEADY_MIN_TIME + (aiRandom() & 31);
            if((aiRandom() & 64) && numberOfAIFollowers < numberOfAIFollowersMax) {
                activeFlags[enemyID[Y]] |= ACTIVEFLAGS_AI_FOLLOW;
                numberOfAIFollowers++;
            }
            numberOfEnemies++;
            break;
        }
    }
}

//-----------------------------------------------------------------------------
void aiSpawnWave() {
    int16_t X = waveSpawnIndex;
    spawnX = launchPosX[waveSpawnL];
    spawnY = launchPosY[waveSpawnL];
    while(1) {
        if(enemyID[X] == 2 * MAX_OBJECTS) {
            enemyID[X] = thingsAdd(LAYER_ENEMY);
            activeEID[enemyID[X]] = X;
            enemyHeading[X] = waveSpawnDir;
            activeFrame[enemyID[X]] = waveSpawnDir;
            activeFlags[enemyID[X]] = ACTIVEFLAGS_AI_WAVE;
            activeTimer[enemyID[X]] = waveSpawnDuration;
            numberOfEnemies++;
            if(!(--waveSpawnNumber & 1)) {
                break;
            }
            spawnX = launchPosX[waveSpawnR];
            spawnY = launchPosY[waveSpawnR];
        }
        X--;
    };
    X--;
    waveSpawnIndex = X;
    if(waveSpawnNumber) {
        waveSpawnL = (waveSpawnL - 1) & 31;
        waveSpawnR = (waveSpawnR + 1) & 31;
    } else {
        aiSpawnTimer = 0;
    }
}

//-----------------------------------------------------------------------------
void aiThing(int16_t X) {
    activeOldX[X] = activeMinX[X];
    activeOldY[X] = activeMinY[X];
    if(activeFlags[X] & ACTIVEFLAGS_ISDEAD) {
        aiExplodeThing(X);
    } else {
        ai_handler[activeLayer[X]] (X);
    }
}

//-----------------------------------------------------------------------------
uint16_t aiTurnOnRay(uint16_t X) {
    int16_t target, x, y;
    uint16_t current;

    // Get the X and Y and look up the beam it should ride
    x = (activeMinX[X] >> 4) & 31;
    y = (activeMinY[X] >> 4) & 31;
    target = rays[y][x];
    current = activeHeading[X];
    // move current to target clockwise or anti-clockwise on shortest path
    if(current != target) {
        int16_t A = (target - current) & 31;
        // A >= 16 anti clock
        if(A & 16) {
            // single step
            current--;
            // Distance 8+ away, double step
            if(!(A & 8)) {
                current -= 2;
            }
        } else {
            // a < 16, clockwise
            current++;
            // more than 8 away, double step
            if(A & 8) {
                current += 2;
            }
        }
    }
    return current;
}
