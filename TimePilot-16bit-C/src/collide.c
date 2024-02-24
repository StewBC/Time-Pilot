//-----------------------------------------------------------------------------
// collide.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "tigr.h"
#include "globals.h"

#include "audio.h"
#include "collide.h"
#include "data.h"
#include "game.h"
#include "ui.h"

//-----------------------------------------------------------------------------
void collideBomber(uint16_t colID0, uint16_t colID1) {
    bomberHealth--;
    if(!bomberHealth || activeLayer[colID1] == LAYER_PLAYER) {
        audioPlaySource(AUDIO_ENEMY_EXPLODE);
        bomberTimer = BOMBER_TIMER;
        gameAddBonus(colID0, SCORE_1500);
        collideThingExplode(colID0);
        activeWidth[colID0] = 32;
        activeHeight[colID0] = 16;
    } else {
        gameAddScore();
    }
}

//-----------------------------------------------------------------------------
void collideEnemy(uint16_t colID0, uint16_t colID1) {
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
    activeHeight[colID0] = 16;
    numberOfEnemies--;
    enemiesKilled++;
    uiUpdateStageProgress();
}

//-----------------------------------------------------------------------------
void collideEnemyBoomerang(uint16_t colID0, uint16_t colID1) {
    int16_t X = activeFlags[colID0] & ACTIVEFLAGS_ENEMYMASK;
    gameAddScore();
    collideThingExplode(colID0);
    activeWidth[colID0] = activeHeight[colID0] = 11;
    enemyWeapon[X] = 128;
    numberOfTracked--;
}

//-----------------------------------------------------------------------------
void collideEnemyRockets(uint16_t colID0, uint16_t colID1) {
    int16_t X = activeFlags[colID0] & ACTIVEFLAGS_ENEMYMASK;
    audioPlaySource(AUDIO_WAPON_EXPLODE);
    gameAddScore();
    collideThingExplode(colID0);
    activeWidth[colID0] = activeHeight[colID0] = 16;
    enemyWeapon[X] = 128;
    numberOfTracked--;
    if(!(--numberOfRockets)) {
        audioStopSource(AUDIO_ROCKET_FLY);
    }
}

//-----------------------------------------------------------------------------
void collideEnemySpaceBullets(uint16_t colID0, uint16_t colID1) {
    int16_t X = activeFlags[colID0] & ACTIVEFLAGS_ENEMYMASK;
    gameAddScore();
    collideThingExplode(colID0);
    activeWidth[colID0] = activeHeight[colID0] = 13;
    enemyWeapon[X] = 128;
}

//-----------------------------------------------------------------------------
void collideLevelBoss(uint16_t colID0, uint16_t colID1) {
    int16_t X;
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
        activeHeight[colID0] = 16;
        for(X = 1; X < MAX_OBJECTS; X++)
        {
            if(!(activeFlags[X] & ACTIVEFLAGS_ISDEAD)) {
                if(activeLayer[X] >= LAYER_ENEMY_BULLETS && activeLayer[X] < LAYER_LEVELBOSS) {
                    // Just remove the parachute
                    if(activeLayer[X] == LAYER_PARACHUTE) {
                        activeLayer[X] |= ACTIVEFLAGS_REMOVE;
                    } else {
                        // But explode everything else
                        if(activeLayer[X] == LAYER_BOMBER) {
                            activeWidth[X] = 32;
                        } else {
                            activeWidth[X] = 16;
                        }
                        collideThingExplode(X);
                        activeHeight[X] = 16;
                    }
                }
            }
        }
    } else {
        gameAddScore();
    }
}

//-----------------------------------------------------------------------------
void collideParachute(uint16_t colID0, uint16_t colID1) {
    audioPlaySource(AUDIO_PICKUP);
    activeFlags[colID0] |= ACTIVEFLAGS_REMOVE;
    parachuteTimer = PARACHUTE_TIMER;
    gameAddBonus(colID0, parachuteScore);
    if(parachuteScore < SCORE_5000) {
        parachuteScore++;
    }
}

//-----------------------------------------------------------------------------
void collidePlayer(uint16_t colID0, uint16_t colID1) {
    if(activeLayer[colID1] == LAYER_PARACHUTE) {
        return;
    }
    audioPlaySource(AUDIO_BIG_EXPLOSION);
    activeWidth[colID0] = 32;               // This works for "C" version
    activeHeight[colID0] = 16;
    exitGameMask |= EXIT_PLAYER_DIED;
    playerExitTimer++;
    bulletTimer = 0;
    collideThingExplode(colID0);
}

//-----------------------------------------------------------------------------
void collideRemove(uint16_t colID0, uint16_t colID1) {
    activeFlags[colID0] |= ACTIVEFLAGS_REMOVE;
}

//-----------------------------------------------------------------------------
void collideRts(uint16_t colID0, uint16_t colID1) {

}

//-----------------------------------------------------------------------------
void collideThingExplode(uint16_t colID0) {
    activeTimer[colID0] = EXPLOSION_HOLD_TIMER;
    activeFrame[colID0] = EXPLOSION_FRAMES - 1;
    activeFlags[colID0] |= ACTIVEFLAGS_ISDEAD;
}

//-----------------------------------------------------------------------------
void collideThings(uint16_t colID0, uint16_t colID1) {
    collision_handler[activeLayer[colID0]](colID0, colID1);
}
