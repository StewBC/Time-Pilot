//-----------------------------------------------------------------------------
// game.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "tigr.h"
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
#include <stdio.h>
#endif
//#define SHOW_FPS
#ifdef SHOW_FPS
uint16_t fps = 0;
#endif

//-----------------------------------------------------------------------------
// Check
void gameAddBonus(int16_t X, int16_t A) {
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
void gameAddScoreInternal(int16_t A) {
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
    int16_t i;

    audioPlaySource(AUDIO_GAME_START);

    // Init some variables, incl. the player structures
    globalsGameInit();

    // Set up a player
    gameRestorePlayer();

    // Clear P1 Score area
    printRectXY(28, 5, 0, colors[TP_COLOR_BLACK], 9);
    if(numberOfPlayers) {
        uiShowP2Playing();
    } else {
        // Clear P2 area
        screenClearSection(28, 7, 12, 2, colors[TP_COLOR_BLACK]);
    }
}

//-----------------------------------------------------------------------------
// Check
int16_t gameNextPlayer() {
    gameOver = 0;
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
    eraseIndex = 0;
    invPlayerAngle = playerAngle ^ (32/2); // 32/2 not-16-bit

    #ifdef SHOW_FPS
        printXY(0, 0, PF_RIGHT, colors[TP_COLOR_BLACK], "%d", fps);
        fps = (uint16_t)(1.0 / tigrTime());
        printXY(0, 0, PF_RIGHT, colors[TP_COLOR_CYAN], "%d", fps);
    #endif

    tigrUpdate(screen);
}

//-----------------------------------------------------------------------------
// Check - I think.
void gameProcessThings() {
    int16_t X, Y;

    while(eraseIndex < numEraseThingIDs) {
        X = eraseThingIDs[eraseIndex];
        if((activeFlags[X] & ACTIVEFLAGS_CLIPMASK) == ACTIVEFLAGS_CLIPMASK) {
            activeFlags[X] |= ACTIVEFLAGS_ERASED; // If not on-screen, mark as erased
        } else {
            if(activeOldY[X] + activeHeight[X] >= scanLine) { // If still "below" scanline, stop
                break;
            }
            eraseThing(X);
        }
        eraseIndex++;
    }

    while(drawIndex < numSortedThingIDs) {
        X = sortedThingIDs[drawIndex];
        if(activeMaxY[X] >= scanLine) {
            break;
        }
        if(!(activeFlags[X] & ACTIVEFLAGS_ERASED)) {
            break;
        }
        if(!(activeFlags[X] & ACTIVEFLAGS_REMOVE)) {
            drawThing(X);
            aiThing(X);
        } else {
            activeFlags[X] = 0;
            insertThings = X;
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
void gameScoreCheckExtra(int16_t score) {
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
    int16_t x;

#ifdef RECORD_REPLAY
    static int8_t replayCount = 0;
    if(!demoRecordMode) {
        demoRecordMode++;
        demoAttractLength = 0;
    } else if(demoRecordMode == 1) {
        FILE* h;
        char fileName[15];
        sprintf(fileName,"replay%03d.bin", replayCount++);
        if(h = fopen(fileName, "wb")) {
            fwrite(demoAttractBuffer, 1, demoAttractLength, h);
            fclose(h);
        }
        demoRecordMode = 0;
        demoAttractMode = 1;
    }
    stageIntroState = 0;
    if(1) {
#else
    if(demoAttractMode) {
#endif
        activeStage = TIME_PERIOD1_1940;
        randomSeed = -1;
    }

    if(activeStage != activeSky) {
        screenWipeToStageSky(activeStage);
        if(activeStage && !(exitGameMask & EXIT_PLAYER_DIED) && !demoAttractMode) {
            audioPlaySource(AUDIO_NEXT_LEVEL);
        }
    } else {
        drawBackgroundColor = colors[TP_COLOR_SKY];
        screenClearSection(0, 0, PLAYFIELDW, PLAYFIELDH, drawBackgroundColor);
    }

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
            sprite_draw[LAYER_ENEMY] = drawEnemyP0P1;
            sprite_partial_draw[LAYER_ENEMY] = drawEnemyP0P1Part;
            layerHeight[LAYER_ENEMY] = 16;
            sprite_draw[LAYER_LEVELBOSS] = drawLevelBossP0P3;
            sprite_partial_draw[LAYER_LEVELBOSS] = drawLevelBossP0P3Part;
            layerHeight[LAYER_LEVELBOSS] = 16;
        break;
        case TIME_PERIOD1_1940:
            sprite_draw[LAYER_ENEMY] = drawEnemyP0P1;
            sprite_partial_draw[LAYER_ENEMY] = drawEnemyP0P1Part;
            layerHeight[LAYER_ENEMY] = 16;
            sprite_draw[LAYER_LEVELBOSS] = drawLevelBossP1P2;
            sprite_partial_draw[LAYER_LEVELBOSS] = drawLevelBossP1P2Part;
            layerHeight[LAYER_LEVELBOSS] = 9;
        break;
        case TIME_PERIOD2_1970:
            sprite_draw[LAYER_ENEMY] = drawEnemyP2;
            sprite_partial_draw[LAYER_ENEMY] = drawEnemyP2Part;
            layerHeight[LAYER_ENEMY] = 9;
            sprite_draw[LAYER_LEVELBOSS] = drawLevelBossP1P2;
            sprite_partial_draw[LAYER_LEVELBOSS] = drawLevelBossP1P2Part;
            layerHeight[LAYER_LEVELBOSS] = 13;
        break;
        case TIME_PERIOD3_1982:
            sprite_draw[LAYER_ENEMY] = drawEnemyP3;
            sprite_partial_draw[LAYER_ENEMY] = drawEnemyP3Part;
            layerHeight[LAYER_ENEMY] = 16;
            sprite_draw[LAYER_LEVELBOSS] = drawLevelBossP0P3;
            sprite_partial_draw[LAYER_LEVELBOSS] = drawLevelBossP0P3Part;
            layerHeight[LAYER_LEVELBOSS] = 13;
        break;
        case TIME_PERIOD4_2001:
            sprite_draw[LAYER_ENEMY] = drawEnemyP4;
            sprite_partial_draw[LAYER_ENEMY] = drawEnemyP4Part;
            layerHeight[LAYER_ENEMY] = 8;
            sprite_draw[LAYER_LEVELBOSS] = drawLevelBossP4;
            sprite_partial_draw[LAYER_LEVELBOSS] = drawLevelBossP4Part;
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

#ifdef SHOW_FPS
    tigrTime(); // "set" so dt is accurate for the game loop
#endif
}

//-----------------------------------------------------------------------------
void gameStart() {
    uint16_t rasterLine = 0;
    gameInit();
    while(!(exitGameMask & EXIT_USER_QUIT)) {
        gameStageInit();
        while(1) {
            scanLine = 0x7dff;
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
            audioStopSource(stageBossAudio[activeStage]);
            audioStopSource(AUDIO_ROCKET_FLY);

            if(exitGameMask & EXIT_USER_QUIT || demoAttractMode) {
                exitGameMask |= EXIT_USER_QUIT;
                break;
            }

            screenClearSection(0, 0, PLAYFIELDW, PLAYFIELDH, drawBackgroundColor);
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
    drawBackgroundColor = colors[TP_COLOR_BLACK];
    screenClearSection(PLAYFIELDW, SROW-9, SCOL-PLAYFIELDW, 9, drawBackgroundColor);
    screenWipe();
}


