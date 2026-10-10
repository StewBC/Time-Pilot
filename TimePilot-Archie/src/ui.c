//-----------------------------------------------------------------------------
// ui.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "archie.h"
#include "globals.h"

#include "audio.h"
#include "data.h"
#include "game.h"
#include "input.h"
#include "print.h"
#include "screen.h"
#include "resids.h"
#include "sprite.h"
#include "text.h"
#include "ui.h"
#include "update.h"

#include <stdio.h>
#include <string.h>
#include <kernel.h>
#include <swis.h>

static int32_t uiReadTime(uint32_t *time) {
    _kernel_swi_regs regs;
    if(_kernel_swi(OS_ReadMonotonicTime, &regs, &regs)) return 0;
    *time = (uint32_t)regs.r[0];
    return 1;
}

//-----------------------------------------------------------------------------
void uiErasePreGameLabels() {
    screenClearSection(10, 12, 8, 1, TP_COLOR_SKY0 + activeSky);
    if(!stageIntroState) {
        screenClearSection(10, 17, 9, 1, TP_COLOR_SKY0 + activeSky);
        screenClearSection(10, 20, 7, 1, TP_COLOR_SKY0 + activeSky);
        stageIntroState = 1;
    } else {
        screenClearSection(11, 17, 5, 1, TP_COLOR_SKY0 + activeSky);
    }
}

//-----------------------------------------------------------------------------
void uiGameOver() {
    int32_t x;

    printXY(10, 13, 0, TP_COLOR_WHITE, TEXT_PLAYER);
    printXY(10, 16, 0, TP_COLOR_RED, TEXT_GAME_OVER);
    uiTimer = UI_GAME_OVER_TIMER;
    while(--uiTimer) {
        // Make sure Game Over is on-screen for at least 1 second
        if(uiTimer < UI_GAME_OVER_TIMER - 60) {
            inputInUI();
            if(inputMask & ~(INPUT_MASK_MOVEMENT | INPUT_ROTATE_LEFT | INPUT_ROTATE_RIGHT)) {
                break;
            }
        }
        archieUpdate(0);
    }
    x = 4;
    while(x >= 0 && playerScore >= highScore[x]) {
        --x;
    }
    if(x < 4) {
        audioPlaySource(AUDIO_HIGHSCORE);
        uiInsertRow = ++x;
        x = 4;
        while(x > (int32_t)uiInsertRow) {
            x--;
            strcpy(TEXT_HIGHSCORES[x + 1], TEXT_HIGHSCORES[x]);
            strcpy(TEXT_INITIALS[x + 1], TEXT_INITIALS[x]);
            highScore[x + 1] = highScore[x];
        }
        highScore[x] = playerScore;
        sprintf(TEXT_HIGHSCORES[x], "%6lu00", playerScore);
        strcpy(TEXT_INITIALS[x], "A  ");
        x = HIGHSCORE_ENTRY_TIME;
        drawBackgroundColor = TP_COLOR_BLACK;
        screenWipe();
        uiShowCommonLabels();
        uiShowHighScoreTable();
        printXY(5, 0, 0, TP_COLOR_BLUE, TEXT_ENTER_INITIALS);
        uiLetterIndex = 0;
        uiTimer = 0;
        uiLetter = 'A';
        uiInitialsColor = TP_COLOR_WHITE;
        keyMask = 0;
        while(x && uiLetterIndex < 3) {
            while(uiTimer--) {
                // Service completion every UI frame, not once per blink cycle.
                if(!audioIsSourcePlaying(AUDIO_HIGHSCORE)) {
                    audioPlaySource(AUDIO_HIGHSCORE);
                }
                archieUpdate(0);
                inputInUI();
                if(inputMask & INPUT_QUIT) {
                    audioStopSource(AUDIO_HIGHSCORE);
                    exitGameMask |= EXIT_USER_QUIT;
                    global_quit = 1;
                    return;
                }
                // Check for direct keyboard entry of initials
                int32_t key = rawKey;
                if(key) {
                    if(key != '.') {
                        key &= 0x5F;
                    }
                    if(key == '.' || (key >= 'A' && key <= 'Z')) {
                        uiLetter = key;
                        TEXT_INITIALS[uiInsertRow][uiLetterIndex] = uiLetter;
                        if(++uiLetterIndex < 3) {
                            // Set next initial to same
                            TEXT_INITIALS[uiInsertRow][uiLetterIndex] = uiLetter;
                        }
                        break;
                    }
                }
                if(inputMaskRepeat) {
                    if(inputMaskDebounced & INPUT_FIRE) {
                        if(++uiLetterIndex < 3) {
                            // Set next initial to same
                            TEXT_INITIALS[uiInsertRow][uiLetterIndex] = uiLetter;
                        }
                        break;
                    }

                    if(inputMaskRepeat & (INPUT_LEFT | INPUT_ROTATE_LEFT)) {
                        uiLetter--;
                        if(uiLetter < '.') {
                            uiLetter = 'Z';
                        } else if(uiLetter < 'A') {
                            uiLetter = '.';
                        }
                    }
                    if(inputMaskRepeat & (INPUT_RIGHT | INPUT_ROTATE_RIGHT)) {
                        uiLetter++;
                        if(uiLetter < 'A') {
                            uiLetter = 'A';
                        } else if(uiLetter > 'Z') {
                            uiLetter = '.';
                        }
                    }
                    TEXT_INITIALS[uiInsertRow][uiLetterIndex] = uiLetter;
                }
                screenClearSection(20 + uiLetterIndex, highScoreInitialsY[uiInsertRow], 1, 1, TP_COLOR_BLACK);
                printXY(20 + uiLetterIndex, highScoreInitialsY[uiInsertRow], 0, uiInitialsColor,
                        &TEXT_INITIALS[uiInsertRow][uiLetterIndex]);
            }
            if(uiTimer < 0) {
                uiTimer = UI_COLORCYCLE_TIMER;
                uiInitialsColor = (TP_COLOR_WHITE ^ uiInitialsColor) | 0x1;
                x--;
            }
            screenClearSection(20, highScoreInitialsY[uiInsertRow], 3, 1, TP_COLOR_BLACK);
            printXY(20, highScoreInitialsY[uiInsertRow], 0, highScoreColorIndex[uiInsertRow], TEXT_INITIALS[uiInsertRow]);
        }
        archieUpdate(0);
        clearUpdate();
        audioStopSource(AUDIO_HIGHSCORE);
    }
}

//-----------------------------------------------------------------------------
void uiInit() {
    // Check for joystick
    inputCheckForJoy(0);

    // Normal code resumes
    screenClearSection(0, 0, SCOL, SROW, TP_COLOR_BLACK);
    printXY(29, 3, 0, TP_COLOR_RED, TEXT_HIGH);
    printXY(35, 6, 0, TP_COLOR_RED, TEXT_1UP);
    printXY(31, 4, 0, TP_COLOR_WHITE, TEXT_HIGHSCORES[0]);
    printXY(37, 7, 0, TP_COLOR_WHITE, TEXT_SCORE00);
    uiShowP2Playing();
    audioPlaySource(AUDIO_COINDROP);
}

//-----------------------------------------------------------------------------
void uiJoyScan() {
    inputCheckForJoy(inputUsingJoystick + 1);
    uiTimer = 0;
    uiState = 1;
}

//-----------------------------------------------------------------------------
int32_t uiMain() {
    int32_t key;
    uint32_t uiIterations = 0;
    UNUSED(key);
    uiState = 0;
    if(demoAttractMode) {
        playerScore = demoAttractScore;
        if(playerScore) {
            uiShowP1Score();
        } else {
            // archieFill(PLAYFIELDW*SCOLW, 5*SROWH, 9*SCOLW, 1*SROWH, TP_COLOR_BLACK);
            screenClearSection(PLAYFIELDW, 5, 9, 1, TP_COLOR_BLACK);
        }
        demoAttractMode = 0;
    }
    uiShowCommonLabels();
    keyMask = 0;
    inputMask = 0;
    while(1) {
        uint32_t screenStart = 0;
        int32_t hasClock;
        uiTimer = UI_STATE_TIMER;
        if(uiState) {
            uiShowHighScoreTable();
        } else {
            uiShowTitle();
        }
        // Present once, then discard completed damage before waiting.
        archieUpdate(0);
        clearUpdate();
        hasClock = uiReadTime(&screenStart);
        while(1) {
            uint32_t now;
            int32_t expired = uiTimer == 0; // Joystick scan requests a refresh.
            if(hasClock) {
                if(uiReadTime(&now)) {
                    expired |= now - screenStart >= UI_STATE_INTERVAL_CS;
                } else {
                    hasClock = 0;
                }
            }
            if(!hasClock) expired |= --uiTimer < 0;
            if(expired) {
                if(++uiIterations == 6) {
                    demoAttractScore = playersScore[0];
                    demoAttractMode = 1;
                    return uiPlay(0);
                }
                // archieFill(5*SCOLW, 6*SROWH, 20*SCOLW, 11*SROWH, TP_COLOR_BLACK);
                screenClearSection(5, 6, 20, 11, TP_COLOR_BLACK);
                uiState ^= 1;
                break;
            }
            inputInUI();
            if(global_quit || (inputMask & INPUT_QUIT)) {
                return 0;
            }
            if(inputMask & (INPUT_FIRE | INPUT_PAUSE)) {
                return uiPlay(0);
            }
            if(inputMask & INPUT_2P) {
                return uiPlay(1);
            }
            // A direct scan of the keyboard to see the J key
            if(rawKey == 'j') {
                uiJoyScan();
            }
            archieUpdate(0);
            clearUpdate();
        }
    }
    return 1;
}

//-----------------------------------------------------------------------------
void uiPause() {
    int32_t key;
    UNUSED(key);

    printXY(11, 10, 0, TP_COLOR_RED, TEXT_PAUSE);
    while(1) {
        archieUpdate(0);
        clearUpdate();
        inputInUI();
        if(global_quit || (inputMaskDebounced & (INPUT_PAUSE | INPUT_QUIT))) {
            break;
        }
    }
    screenClearSection(11, 10, 6, 1, drawBackgroundColor);
}

//-----------------------------------------------------------------------------
int32_t uiPlay(uint32_t numPlayers) {
    numberOfPlayers = numPlayers;
    numberOfPlayersAlive = numPlayers;
    activePlayer = 0;
    keyMask = 0;
    return 1;
}

//-----------------------------------------------------------------------------
void uiShowCommonLabels() {

    screenClearSection(PLAYFIELDW, 0, SCOL-PLAYFIELDW, 2, TP_COLOR_BLACK);
    spritePos.v = 2 * SROWH;
    spritePos.h = 4 * SCOLW;
    spriteDraw(spritePtrs[SID_TIMEPILOT], spritePos);

    printXY(8, 19, 0, TP_COLOR_WHITE, TEXT_KONAMI);
    printXY(7, 22, 0, TP_COLOR_BLUE, TEXT_VERSION);
    printXY(5, 24, 0, TP_COLOR_BLUE, TEXT_STEFAN);
}

//-----------------------------------------------------------------------------
void uiShowHighScore() {
    // Clear the whole 658[16] score.
    screenClearSection(32, 4, 8, 1, TP_COLOR_BLACK);
    sprintf(TEXT_HIGHSCOREDISPLAY, "%6lu00", highScoresDisplay);
    printXY(31, 4, 0, TP_COLOR_WHITE, TEXT_HIGHSCOREDISPLAY);
}

//-----------------------------------------------------------------------------
void uiShowHighScoreTable() {
    printXY(5, 6, 0, TP_COLOR_MAGENTA, TEXT_RANKING);
    printXY(5, 8, 0, highScoreColorIndex[0], TEXT_1ST);
    printXY(9, 8, 0, highScoreColorIndex[0], TEXT_HIGHSCORES[0]);
    printXY(20, 8, 0, highScoreColorIndex[0], TEXT_INITIALS[0]);
    printXY(5, 10, 0, highScoreColorIndex[1], TEXT_2ND);
    printXY(9, 10, 0, highScoreColorIndex[1], TEXT_HIGHSCORES[1]);
    printXY(20, 10, 0, highScoreColorIndex[1], TEXT_INITIALS[1]);
    printXY(5, 12, 0, highScoreColorIndex[2], TEXT_3RD);
    printXY(9, 12, 0, highScoreColorIndex[2], TEXT_HIGHSCORES[2]);
    printXY(20, 12, 0, highScoreColorIndex[2], TEXT_INITIALS[2]);
    printXY(5, 14, 0, highScoreColorIndex[3], TEXT_4TH);
    printXY(9, 14, 0, highScoreColorIndex[3], TEXT_HIGHSCORES[3]);
    printXY(20, 14, 0, highScoreColorIndex[3], TEXT_INITIALS[3]);
    printXY(5, 16, 0, highScoreColorIndex[4], TEXT_5TH);
    printXY(9, 16, 0, highScoreColorIndex[4], TEXT_HIGHSCORES[4]);
    printXY(20, 16, 0, highScoreColorIndex[4], TEXT_INITIALS[4]);
}

//-----------------------------------------------------------------------------
void uiShowP1Score() {
    screenClearSection(30, 7, 7, 1, TP_COLOR_BLACK);
    sprintf(TEXT_P1SCORE, "%7lu0", playerScore);
    printXY(30, 7, 0, TP_COLOR_WHITE, TEXT_P1SCORE);
}

//-----------------------------------------------------------------------------
void uiShowP2Playing() {
    printXY(35, 9, 0, TP_COLOR_RED, TEXT_2UP);
    screenClearSection(28, 10, 9, 1, TP_COLOR_BLACK);
    printXY(37, 10, 0, TP_COLOR_WHITE, TEXT_SCORE00);
}

//-----------------------------------------------------------------------------
void uiShowP2Score() {
    screenClearSection(30, 10, 7, 1, TP_COLOR_BLACK);
    sprintf(TEXT_P2SCORE, "%7lu0", playerScore);
    printXY(30, 10, 0, TP_COLOR_WHITE, TEXT_P2SCORE);
}

//-----------------------------------------------------------------------------
void uiShowPlayerShips() {
    int32_t x;
    Rect shipRect;
    screenClearSection(PLAYFIELDW, 19, SCOL - PLAYFIELDW, 2, TP_COLOR_BLACK);
    for(x = playerLives; x > 0; x--) {
        shipRect = spritePtrs[SID_PLAYER0 + PLAYER_FRAME_UP]->spriteRect;
        shipRect.left += (SCOL - (x * 2)) * SCOLW;
        shipRect.right += (SCOL - (x * 2)) * SCOLW;
        shipRect.top += 19 * SROWH;
        shipRect.bottom += 19 * SROWH;
        spriteDrawUnclipped(spritePtrs[SID_PLAYER24], &shipRect);
    }
}

//-----------------------------------------------------------------------------
void uiShowPreGameLabels() {
    Rect tpsRect = { 0, 28 * SCOLW, spritePtrs[SID_TPSMALL]->spriteRect.bottom, 28 * SCOLW + spritePtrs[SID_TPSMALL]->spriteRect.right };
    spriteDrawUnclipped(spritePtrs[SID_TPSMALL], &tpsRect);
    sprintf(TEXT_PLAYER, "PLAYER %c", (char)('1' + activePlayer));
    sprintf(TEXT_STAGE, "STAGE %lu", activeStage + 1);
    if(!demoAttractMode) {
        printXY(10, 12, 0, TP_COLOR_WHITE, TEXT_PLAYER);
    }
    if(!stageIntroState) {
        if(--introColorTimer < 0) {
            introColorTimer = INTRO_COLOR_CYCLE_TIME;
            if(--introColorOffset < 0) {
                introColorOffset = 2;
            }
        }
        printXY(10, 17, 0, stageLabelColor[introColorOffset], *stageLabelText[activeStage]);
        printXY(10, 20, 0, TP_COLOR_WHITE, TEXT_STAGE);
    } else {
        printXY(11, 17, 0, TP_COLOR_WHITE, TEXT_READY);
    }
}

//-----------------------------------------------------------------------------
void uiShowStageIcon() {
    int32_t x;
    Rect iconRect;
    // -1 is 1 short but there's always at least 1 stage icon
    screenClearSection(PLAYFIELDW, 16, SCOL - PLAYFIELDW - 1, 1, TP_COLOR_BLACK);
    for(x = activeStage + 1; x > 0; x--) {
        iconRect = spritePtrs[SID_STAGE]->spriteRect;
        iconRect.left += SCREENW - (x * SCOLW);
        iconRect.right += SCREENW - (x * SCOLW);
        iconRect.top += 16 * SROWH;
        iconRect.bottom += 16 * SROWH;
        spriteDrawUnclipped(spritePtrs[SID_STAGE], &iconRect);
    }
}

//-----------------------------------------------------------------------------
void uiShowStageProgress() {
    int32_t x;
    Rect progressRect;
    for(x = NUM_PROGRESS_PLANES; x > 0; x--) {
        if(activeStage != TIME_PERIOD4_2001) {
            progressRect = spritePtrs[SID_PROGRESS]->spriteRect;
            progressRect.left += (SCOL - (x * 2)) * SCOLW;
            progressRect.right += (SCOL - (x * 2)) * SCOLW;
            progressRect.top += SCREENH - SROWH;
            progressRect.bottom += SCREENH - SROWH;
            spriteDrawUnclipped(spritePtrs[SID_PROGRESS], &progressRect);
        } else {
            progressRect = spritePtrs[SID_L4ENEMY0]->spriteRect;
            progressRect.left += (SCOL - (x * 2)) * SCOLW;
            progressRect.right += (SCOL - (x * 2)) * SCOLW;
            progressRect.top += SCREENH - SROWH;
            progressRect.bottom += SCREENH - SROWH;
            spriteDrawUnclipped(spritePtrs[SID_L4ENEMY0], &progressRect);
        }
    }
    if(enemiesKilled) {
        uiUpdateStageProgress();
    }
}

//-----------------------------------------------------------------------------
void uiShowTitle() {
    // See if one is connected where there were none
    if(inputUsingJoystick < 0) {
        inputCheckForJoy(0);
    } else {
        // Or check that what was there is still there
        inputCheckForJoy(inputUsingJoystick);
    }

    printXY(12, 0, 0, TP_COLOR_CYAN, TEXT_PLAY);
    printXY(5, 6, 0, TP_COLOR_CYAN, TEXT_DEPOSIT);
    printXY(5, 14, 0, TP_COLOR_CYAN, TEXT_BONUS1);
    printXY(5, 16, 0, TP_COLOR_CYAN, TEXT_BONUS2);
    printXY(6, 8, 0, TP_COLOR_RED, TEXT_TRY_GAME);
    printXY(5, 10, 0, TP_COLOR_YELLOW, TEXT_CONTROLSK);
    if(inputUsingJoystick < 0) {
        printXY(6, 12, 0, TP_COLOR_ORANGE, TEXT_CONTROLSNJ);
    } else {
        printXY(8, 12, 0, TP_COLOR_YELLOW, TEXT_CONTROLSJ);
        printXY(21, 12, 0, TP_COLOR_GREEN, TEXT_CONTROLSN);
        printXY(9, 12, 0, TP_COLOR_GREEN, TEXT_J);
    }
}

//-----------------------------------------------------------------------------
void uiUpdateStageProgress() {
    int32_t clearSection = enemiesKilled;
    if(clearSection > ENEMIES_TO_KILL_TO_CLEAR) {
        clearSection = ENEMIES_TO_KILL_TO_CLEAR;
    }
    archieFill(PLAYFIELDW * SCOLW, SCREENH - SROWH,
            ((SCOL - PLAYFIELDW) * SCOLW) * clearSection / ENEMIES_TO_KILL_TO_CLEAR, SROWH, TP_COLOR_BLACK);
}
