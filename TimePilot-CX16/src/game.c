//-----------------------------------------------------------------------------
// game.c
// Part of Time Pilot, the 1982 arcade game remake for the Commander X16
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include <stdint.h>
#include "globals.h"

#include "ai.h"
#include "audio.h"
#include "data.h"
#include "draw.h"
#include "erase.h"
#include "game.h"
#include "input.h"
#include "print.h"
#include "screen.h"
#include "text.h"
#include "things.h"
#include "ui.h"

#ifdef RECORD_REPLAY 
#include <cbm.h>
#include <stdio.h>
#endif
#include <cx16.h>

//-----------------------------------------------------------------------------
// Check
void gameAddBonus(int8_t X, int8_t A) {
    gameAddScoreInternal(bonusScores[A]);
    spawnX = activeMinX[X] - 16;
    spawnY = activeMinY[X];
    X = thingsAdd(LAYER_SCORES);
    activeFrame[X] = A;
    activeTimer[X] = 60;
}

//-----------------------------------------------------------------------------
// Check
void gameAddScore() {
    if(scoreTimer >= SCORE_MULT_TIMER) {
        enemyScore = 1;
    }
    scoreTimer = 0;
    gameAddScoreInternal(enemyScore);
    enemyScore++;
}

//-----------------------------------------------------------------------------
// Check
void gameAddScoreInternal(int8_t A) {
    playerScore += A;
    if(playerScore > highScoresDisplay) {
        highScoresDisplay = playerScore;
        uiShowHighScore();
    }
    gameScoreCheckExtra(A);
    if(activePlayer) {
        uiShowP2Score();
    } else {
        uiShowP1Score();
    }
}

//-----------------------------------------------------------------------------
// Check
void gameInit() {
    int8_t i;

    audioPlaySource(AUDIO_GAME_START);

    // Init some variables, incl. the player structures
    globalsGameInit();

    // Set up a player
    gameRestorePlayer();

    // P2 area
    screenClearSection(1, PLAYFIELDW, 7, 12, 2, TP_COLOR_EXTRA);
    // P1 Score area
    screenClearSection(1, PLAYFIELDW, 5, 9, 1, TP_COLOR_EXTRA);
    if(numberOfPlayers) {
        uiShowP2Playing();
    }
}

//-----------------------------------------------------------------------------
// Check
int8_t gameNextPlayer() {
    uint8_t gameOver = 0;
    if(--playerLives < 0) {
        uiGameOver();
        gameOver++;
    }
    if(numberOfPlayersAlive) {
        gameSavePlayer();
        activePlayer ^= 1;
        gameRestorePlayer();
    }
    if(gameOver) {
        if(--numberOfPlayersAlive) {
            return 0;
        }
    }
    return 1;
}

//-----------------------------------------------------------------------------
// Check
void gamePostFrame() {

    if(prePlayTimer) {
        if(--prePlayTimer == 0) {
            uiErasePreGameLabels();
        } else {
            uiShowPreGameLabels();
        }
    } else {
        aiSpawnTimer++;
        aiEndFrame();
    }

    thingsSortAndCollide();
    drawIndex = 0;
    invPlayerAngle = playerAngle ^ (32/2); // 32/2 not-16-bit

    waitvsync();
}

//-----------------------------------------------------------------------------
// Check - I think.
void gameProcessThings() {
    int8_t X, Y;

    while(drawIndex < numSortedThingIDs) {
        X = sortedThingIDs[drawIndex];
        if(!(activeFlags[X] & ACTIVEFLAGS_REMOVE)) {
            drawThing(X);
            aiThing(X);
        } else {
            eraseSprite(X);
            activeFlags[X] = 0;
            sortedThingIDs[drawIndex] = -1;
        }
        drawIndex++;
    }
}

//-----------------------------------------------------------------------------
// Check
void gameRestorePlayer() {
    playerLives = playersLives[activePlayer];
    playerScore = playersScore[activePlayer];
    playerExtraLife = playersExtraLife[activePlayer];
    playerNextExtraLife = playersNextExtraLife[activePlayer];
    activeStage = playersActiveStage[activePlayer];
    enemiesKilled = playersEnemiesKilled[activePlayer];
    levelBossHealth = playersLevelBossHealth[activePlayer];
    stageIntroState = playersStageIntroState[activePlayer];
}

//-----------------------------------------------------------------------------
// Check
void gameSavePlayer()
{
    playersLives[activePlayer] = playerLives;
    playersScore[activePlayer] = playerScore;
    playersExtraLife[activePlayer] = playerExtraLife;
    playersNextExtraLife[activePlayer] = playerNextExtraLife;
    playersActiveStage[activePlayer] = activeStage;
    playersEnemiesKilled[activePlayer] = enemiesKilled;
    playersLevelBossHealth[activePlayer] = levelBossHealth;
    playersStageIntroState[activePlayer] = stageIntroState;
}

//-----------------------------------------------------------------------------
// Check
void gameScoreCheckExtra(int8_t score) {
    playerExtraLife += score;
    if(playerExtraLife >= playerNextExtraLife) {
        audioPlaySource(AUDIO_EXTRA_LIFE);
        playerExtraLife -= playerNextExtraLife;
        playerNextExtraLife = 500;
        playerLives++;
        uiShowPlayerShips();
    }
}

//-----------------------------------------------------------------------------
// Check
void gameStageInit() {
    int8_t x;

#ifdef RECORD_REPLAY
    static int8_t replayCount = 0;
    if(!demoRecordMode) {
        demoRecordMode++;
        demoAttractLength = 0;
    } else if(demoRecordMode == 1) {
        int8_t h;
        char fileName[15];
        sprintf(fileName,"replay%03d.bin", replayCount++);
        cbm_k_setlfs(0, 8, 1);
        cbm_k_setnam(fileName);
        h = cbm_k_open();
        cbm_k_save(demoAttractBuffer, demoAttractBuffer+demoAttractLength);
        cbm_k_close(h);
        demoRecordMode = 0;
        demoAttractMode = 1;
    }
#endif

#ifdef RECORD_REPLAY
    if(demoAttractMode || demoRecordMode) {
        stageIntroState = 0;
#else
    if(demoAttractMode) {
#endif
        activeStage = TIME_PERIOD1_1940;
        randomSeed = -1;
    }

    eraseSpriteRange(MAX_OBJECTS);
    if(activeStage != activeSky) {
        screenWipeToSkyColor(activeStage);
        if(activeStage && !(exitGameMask & EXIT_PLAYER_DIED) && !demoAttractMode) {
            audioPlaySource(AUDIO_NEXT_LEVEL);
        }
    } else {
        screenClearSection(0, 0, 0, PLAYFIELDW, PLAYFIELDH, TP_COLOR_SKY);
    }
    // Hide the logo also
    eraseSprite(UI_SPR_LOGO);
    eraseSprite(UI_SPR_LOGO+1);

    // Init the variables
    globalsStageInit();

    // 1st time stageIntroState == 0, re-intro to stage (after death) stageIntroState <> 0
    if(stageIntroState == 0) {
        levelBossHealth = LEVELBOSS_HEALTH;
        prePlayTimer = STAGE_ANNOUNCE_TIMER;
        parachuteTimer = STAGE_ANNOUNCE_TIMER + PARACHUTE_TIMER;
        enemiesKilled = 0;
        if(activeStage == TIME_PERIOD1_1940) {
            bomberTimer = STAGE_ANNOUNCE_TIMER + BOMBER_TIMER;
        }
    }

    // Overwrite the values for demo mode
#ifdef RECORD_REPLAY
    if(stageIntroState || demoAttractMode || demoRecordMode) {
#else
    if(stageIntroState || demoAttractMode) {
#endif
        prePlayTimer = PLAYER_ANNOUNCE_TIMER;
        parachuteTimer = PLAYER_ANNOUNCE_TIMER + PARACHUTE_TIMER;
        if(activeStage == TIME_PERIOD1_1940) {
            bomberTimer = PLAYER_ANNOUNCE_TIMER + BOMBER_TIMER;
        }
    }

    // Update the screen
    uiShowStageIcon();
    uiShowPlayerShips();
    uiShowStageProgress();

    // Update level specific items
    switch(activeStage) {
        case TIME_PERIOD0_1910:
            sprite_draw[LAYER_ENEMY] = drawEnemyP0P1P3;
            layerHeight[LAYER_ENEMY] = 16;
            sprite_draw[LAYER_LEVELBOSS] = drawLevelBossP0P1P2P3;
            layerHeight[LAYER_LEVELBOSS] = 16;
        break;
        case TIME_PERIOD1_1940:
            sprite_draw[LAYER_ENEMY] = drawEnemyP0P1P3;
            layerHeight[LAYER_ENEMY] = 16;
            sprite_draw[LAYER_LEVELBOSS] = drawLevelBossP0P1P2P3;
            layerHeight[LAYER_LEVELBOSS] = 9;
        break;
        case TIME_PERIOD2_1970:
            sprite_draw[LAYER_ENEMY] = drawEnemyP2;
            layerHeight[LAYER_ENEMY] = 9;
            sprite_draw[LAYER_LEVELBOSS] = drawLevelBossP0P1P2P3;
            layerHeight[LAYER_LEVELBOSS] = 13;
        break;
        case TIME_PERIOD3_1982:
            sprite_draw[LAYER_ENEMY] = drawEnemyP0P1P3;
            layerHeight[LAYER_ENEMY] = 16;
            sprite_draw[LAYER_LEVELBOSS] = drawLevelBossP0P1P2P3;
            layerHeight[LAYER_LEVELBOSS] = 13;
        break;
        case TIME_PERIOD4_2001:
            sprite_draw[LAYER_ENEMY] = drawEnemyP4;
            layerHeight[LAYER_ENEMY] = 8;
            sprite_draw[LAYER_LEVELBOSS] = drawLevelBossP4;
            layerHeight[LAYER_LEVELBOSS] = 16;
        break;
    }

    // Spawn clouds (or asteroids) & player
    for(x = NUM_SPAWN_LAYERS-1; x >= 0; x--) {
        spawnX = spawnMinX[x];
        spawnY = spawnMinY[x];
        if(activeStage != TIME_PERIOD4_2001) {
            thingsAdd(spawnLayer[x]);
        } else {
            thingsAdd(spawnSpaceLayer[x]);
        }
    }

    // Do a pass over the spaned things to sort them (player is not sorted so it can be in pos 0)
    thingsSortAndCollide();
}

//-----------------------------------------------------------------------------
void gameStart() {
    gameInit();
    while(!(exitGameMask & EXIT_USER_QUIT)) {
        gameStageInit();
        while(1) {
            frameCounter++;
            gameProcessThings();
            gamePostFrame();

            if(playerExitTimer >= 0 && !(exitGameMask & EXIT_USER_QUIT)) {
                // Bit of a hack to delay starting the sound by 1 second
                if(playerExitTimer == 60 && (exitGameMask & EXIT_STAGE_CLEAR) && !(exitGameMask & EXIT_PLAYER_DIED)) {
                    audioPlaySource(AUDIO_TIMEWARP);
                }
                continue;
            }

            // Stop in-game looping audio at this point
            eraseSpriteRange(MAX_OBJECTS);
            audioStopSource(stageBossAudio[activeStage]);
            audioStopSource(AUDIO_ROCKET_FLY);

            if(exitGameMask & EXIT_USER_QUIT || demoAttractMode) {
                exitGameMask |= EXIT_USER_QUIT;
                break;
            }

            // screenClearSection(0, 0, 0, PLAYFIELDW, PLAYFIELDH, TP_COLOR_BLACK);
            if(exitGameMask & EXIT_STAGE_CLEAR) {
                if(!(exitGameMask & EXIT_PLAYER_DIED)) {
                    screenTimeWarp();
                }
                if(++activeStage >= NUM_PERIODS) {
                    activeStage = TIME_PERIOD0_1910;
                }
            }

            if(exitGameMask & EXIT_PLAYER_DIED) {
                if(!gameNextPlayer()) {
                    // Just exit the while loop since it's game over
                    exitGameMask |= EXIT_USER_QUIT;
                }
            }
            break;
        }
    }
    // There may be labels up if user quits
    screenClearSection(1, 0, 0, PLAYFIELDW, PLAYFIELDH, TP_COLOR_BLACK);
    eraseSpriteRange(MAX_OBJECTS);
    // Swipe with blocking black to cover logo sprite
    screenWipe(TP_COLOR_EXTRA);
    // Now erase the logo sprite
    eraseSprite(UI_SPR_LOGO);
    eraseSprite(UI_SPR_LOGO+1);
    // Then clear to background (non-blocking) black
    screenClearSection(0, 0, 0, PLAYFIELDW, PLAYFIELDH, TP_COLOR_BLACK);
}
