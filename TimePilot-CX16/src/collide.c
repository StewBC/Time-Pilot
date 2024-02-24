//-----------------------------------------------------------------------------
// collide.c
// Part of Time Pilot, the 1982 arcade game remake for the Commander X16
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include <stdint.h>
#include "globals.h"

#include "audio.h"
#include "collide.h"
#include "data.h"
#include "draw.h"
#include "erase.h"
#include "game.h"
#include "ui.h"

//-----------------------------------------------------------------------------
void collideBomber(uint8_t colID0, uint8_t colID1) {
    bomberHealth--;
    if(!bomberHealth || activeLayer[colID1] == LAYER_PLAYER) {
        audioPlaySource(AUDIO_ENEMY_EXPLODE);
        bomberTimer = BOMBER_TIMER;
        gameAddBonus(colID0, SCORE_1500);
        collideThingExplode(colID0);
    } else {
        gameAddScore();
    }
}

//-----------------------------------------------------------------------------
void collideEnemy(uint8_t colID0, uint8_t colID1) {
    audioPlaySource(AUDIO_ENEMY_EXPLODE);
    if(activeFlags[colID0] & ACTIVEFLAGS_AI_WAVE) {
        if(!(--numberOfWaveEnemies)) {
            gameAddBonus(colID0, SCORE_2000);
        }
    }

    if(activeFlags[colID0] & ACTIVEFLAGS_AI_FOLLOW) {
        numberOfAIFollowers--;
    }

    enemyID[activeFlags[colID0] & ACTIVEFLAGS_ENEMYMASK] = 128;
    gameAddScore();
    collideThingExplode(colID0);
    drawSetSpriteSize(colID0, ENCODE_SIZE(16,16));
    numberOfEnemies--;
    enemiesKilled++;
    uiUpdateStageProgress();
}

//-----------------------------------------------------------------------------
void collideEnemyBoomerang(uint8_t colID0, uint8_t colID1) {
    int8_t X = activeFlags[colID0] & ACTIVEFLAGS_ENEMYMASK;
    gameAddScore();
    collideThingExplode(colID0);
    drawSetSpriteSize(colID0, ENCODE_SIZE(16,16));
    enemyWeapon[X] = 128;
    numberOfTracked--;
}

//-----------------------------------------------------------------------------
void collideEnemyRockets(uint8_t colID0, uint8_t colID1) {
    int8_t X = activeFlags[colID0] & ACTIVEFLAGS_ENEMYMASK;
    audioPlaySource(AUDIO_WAPON_EXPLODE);
    gameAddScore();
    collideThingExplode(colID0);
    drawSetSpriteSize(colID0, ENCODE_SIZE(16,16));
    enemyWeapon[X] = 128;
    numberOfTracked--;
    if(!(--numberOfRockets)) {
        audioStopSource(AUDIO_ROCKET_FLY);
    }
}

//-----------------------------------------------------------------------------
void collideEnemySpaceBullets(uint8_t colID0, uint8_t colID1) {
    int8_t X = activeFlags[colID0] & ACTIVEFLAGS_ENEMYMASK;
    gameAddScore();
    collideThingExplode(colID0);
    drawSetSpriteSize(colID0, ENCODE_SIZE(16,16));
    enemyWeapon[X] = 128;
}

//-----------------------------------------------------------------------------
void collideLevelBoss(uint8_t colID0, uint8_t colID1) {
    int8_t x;
    levelBossHealth--;
    if(!levelBossHealth || activeLayer[colID1] == LAYER_PLAYER) {
        levelBossHealth = 0; // Prevent audio from starting again
        audioStopSource(stageBossAudio[activeStage]);
        audioStopSource(AUDIO_ROCKET_FLY);
        audioPlaySource(AUDIO_BIG_EXPLOSION);
        gameAddBonus(colID0, SCORE_3000);
        stageIntroState = 0;
        exitGameMask |= EXIT_STAGE_CLEAR;
        playerExitTimer++;
        collideThingExplode(colID0);
        for(x = ACTIVEFLAGS_ENEMYMASK; x >= 0; x--) {
            if(enemyID[x] < 128) {
                collideThingExplode(enemyID[x]);
                drawSetSpriteSize(enemyID[x], ENCODE_SIZE(16,16));
            }
            if(enemyWeapon[x] < 128) {
                if(activeLayer[enemyWeapon[x]] >= LAYER_ENEMY_BOMBS && activeLayer[enemyWeapon[x]] < LAYER_ENEMY_BOOMERANG + 1) {
                    collideThingExplode(enemyWeapon[x]);
                    drawSetSpriteSize(enemyWeapon[x], ENCODE_SIZE(16,16));
                }
            }
        }
        // Kill active parachute as well
        if(activeFlags[layerToThingTable[LAYER_PARACHUTE]] < 128) {
            activeFlags[layerToThingTable[LAYER_PARACHUTE]] |= ACTIVEFLAGS_REMOVE;
            eraseSprite(layerToThingTable[LAYER_PARACHUTE]);
        }
        // Also kill the bomber if it is active
        if(activeFlags[layerToThingTable[LAYER_BOMBER]] < 128) {
            collideThingExplode(layerToThingTable[LAYER_BOMBER]);
            drawSetSpriteSize(layerToThingTable[LAYER_BOMBER], ENCODE_SIZE(32,16));
        }
    } else {
        gameAddScore();
    }
}

//-----------------------------------------------------------------------------
void collideParachute(uint8_t colID0, uint8_t colID1) {
    audioPlaySource(AUDIO_PICKUP);
    activeFlags[colID0] |= ACTIVEFLAGS_REMOVE;
    parachuteTimer = PARACHUTE_TIMER;
    gameAddBonus(colID0, parachuteScore);
    if(parachuteScore < SCORE_5000) {
        parachuteScore++;
    }
}

//-----------------------------------------------------------------------------
void collidePlayer(uint8_t colID0, uint8_t colID1) {
    if(activeLayer[colID1] == LAYER_PARACHUTE) {
        return;
    }
    audioPlaySource(AUDIO_BIG_EXPLOSION);
    drawSetSpriteSize(colID0, ENCODE_SIZE(32,16));
    exitGameMask |= EXIT_PLAYER_DIED;
    playerExitTimer++;
    bulletTimer = 0;
    collideThingExplode(colID0);
}

//-----------------------------------------------------------------------------
void collideRemove(uint8_t colID0, uint8_t colID1) {
    activeFlags[colID0] |= ACTIVEFLAGS_REMOVE;
}

//-----------------------------------------------------------------------------
void collideRts(uint8_t colID0, uint8_t colID1) {

}

//-----------------------------------------------------------------------------
void collideThingExplode(uint8_t colID0) {
    activeTimer[colID0] = EXPLOSION_HOLD_TIMER;
    activeFrame[colID0] = EXPLOSION_FRAMES - 1;
    activeFlags[colID0] |= ACTIVEFLAGS_ISDEAD;
}

//-----------------------------------------------------------------------------
void collideThings(uint8_t colID0, uint8_t colID1) {
    collision_handler[activeLayer[colID0]](colID0, colID1);
}
