//-----------------------------------------------------------------------------
// game.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "archie.h"
#include "globals.h"

#include "ai.h"
#include "audio.h"
#include "data.h"
#include "draw.h"
#include "erase.h"
#include "game.h"
#include "input.h"
#include "resids.h"
#include "screen.h"
#include "text.h"
#include "things.h"
#include "ui.h"
#include "update.h"

#ifdef RECORD_REPLAY
#include <stdio.h>
#endif
//#define SHOW_FPS
#ifdef SHOW_FPS
uint32_t fps = 0;
#endif

//-----------------------------------------------------------------------------
// Check
void gameAddBonus(int32_t X, int32_t A) {
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
void gameAddScoreInternal(int32_t A) {
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
    int32_t i;
    UNUSED(i);

    audioStopSource(AUDIO_COINDROP);
    audioStopSource(AUDIO_HIGHSCORE);
    audioPlaySource(AUDIO_GAME_START);

    // Init some variables, incl. the player structures
    globalsGameInit();

    // Set up a player
    gameRestorePlayer();

    // Clear P1 Score area
    screenClearSection(28, 7, 9, 1, TP_COLOR_BLACK);
    if(numberOfPlayers) {
        uiShowP2Playing();
    } else {
        // Clear P2 area
        screenClearSection(28, 9, 12, 2, TP_COLOR_BLACK);
    }
}

//-----------------------------------------------------------------------------
// Check
int32_t gameNextPlayer() {
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

// Eligibility reserves the loop channel, but does not mean a boss has spawned.
// aiEndFrame sets the timer negative only when it creates the boss; it resets
// the timer when the boss leaves the playfield for its next pass.
static void gameUpdateCombatAudio(void) {
    int32_t bossSource = -1;
    uint32_t rockets = 0;
    if(!prePlayTimer && !exitGameMask) {
        uint32_t bossEligible = levelBossHealth > 0 && enemiesKilled > ENEMIES_TO_KILL_TO_CLEAR;
        if(bossEligible && levelBossTimer < 0) bossSource = stageBossAudio[activeStage];
        if(!bossEligible && numberOfRockets &&
           (activeStage == TIME_PERIOD2_1970 || activeStage == TIME_PERIOD3_1982)) {
            uint32_t i;
            // Reject a stale counter: only live rocket objects own flight audio.
            for(i=0;i<numSortedThingIDs;i++) {
                int32_t id=sortedThingIDs[i];
                if(id >= 0 && activeLayer[id] == LAYER_ENEMY_ROCKETS &&
                   (activeFlags[id] & ACTIVEFLAGS_INUSE) &&
                   !(activeFlags[id] & (ACTIVEFLAGS_ISDEAD | ACTIVEFLAGS_REMOVE))) rockets++;
            }
        }
    }
    audioUpdateCombatLoop(bossSource, rockets);
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
    gameUpdateCombatAudio();
    invPlayerAngle = playerAngle ^ (32 / 2); // 32/2 not-16-bit



    if(activeStage < TIME_PERIOD3_1982 && !(frameCounter & 3)) {
        archieAnimatePalette();
    }

    // Sync to screen
    archieUpdate(0);

    // Reset all the update rects
    clearUpdate();
}

//-----------------------------------------------------------------------------
// Check - I think.
void gameProcessThings() {
    int32_t X, Y;
    uint32_t index = 0;
    UNUSED(Y);

    archieBeginPlayfieldFrame();

    // draw Everything
    index = 0;
    while(index < numSortedThingIDs) {
        X = sortedThingIDs[index];
        aiThing(X);
        if(!(activeFlags[X] & ACTIVEFLAGS_REMOVE)) {
            drawThing(X);
        } else {
            activeFlags[X] = 0;
            insertThings = X;
            sortedThingIDs[index] = -1;
        }
        index++;
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
void gameSavePlayer() {
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
void gameScoreCheckExtra(int32_t score) {
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
    int32_t x;

#ifdef RECORD_REPLAY
    static int32_t replayCount = 0;
    if(!demoRecordMode) {
        demoRecordMode++;
        demoAttractLength = 0;
    } else if(demoRecordMode == 1) {
        FILE *h;
        char fileName[64];
        // RISC OS uses dots as directory separators, not file extensions.
        sprintf(fileName, "<TimePilot$Dir>.Replay%03ld", (long)replayCount++);
        h = fopen(fileName, "wb");
        if(h) {
            size_t written = fwrite(demoAttractBuffer, 1, demoAttractLength, h);
            int failed = written != (size_t)demoAttractLength || ferror(h);
            if(fclose(h) != 0) failed = 1;
            if(failed) {
                fprintf(stderr, "Unable to finish saving demo: %s\n", fileName);
            }
        } else {
            fprintf(stderr, "Unable to open demo for saving: %s\n", fileName);
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
        drawBackgroundColor = TP_COLOR_SKY0 + activeStage;
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

    // Spawn clouds (or asteroids) & player
    for(x = NUM_SPAWN_LAYERS - 1; x >= 0; x--) {
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
    // SQW - Something for the Mac here
#endif
}

//-----------------------------------------------------------------------------
void gameStart() {
    uint32_t rasterLine = 0;
    UNUSED(rasterLine);
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
                    audioStopSource(AUDIO_GAME_START);
                    audioPlaySource(AUDIO_TIMEWARP);
                }
                continue;
            }
            // Stop in-game looping audio at this point
            audioStopSource(AUDIO_GAME_START);
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
    drawBackgroundColor = TP_COLOR_BLACK;
    screenClearSection(PLAYFIELDW, SROW - 9, SCOL - PLAYFIELDW, 9, drawBackgroundColor);
    screenWipe();
}
