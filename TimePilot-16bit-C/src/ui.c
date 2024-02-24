//-----------------------------------------------------------------------------
// ui.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "tigr.h"
#include "globals.h"

#include "audio.h"
#include "data.h"
#include "game.h"
#include "input.h"
#include "print.h"
#include "screen.h"
#include "text.h"
#include "ui.h"

#include <stdio.h>
#include <string.h>

//-----------------------------------------------------------------------------
void uiErasePreGameLabels() {
    printXY(10, 10, 0, colors[TP_COLOR_SKY], TEXT_PLAYER);
    if(!stageIntroState) {
        printXY(10, 15, 0, colors[TP_COLOR_SKY], *stageLabelText[activeStage]);
        printXY(10, 18, 0, colors[TP_COLOR_SKY], TEXT_STAGE);
        stageIntroState = 1;
    } else {
        printXY(11, 15, 0, colors[TP_COLOR_SKY], TEXT_READY);
    }
}

//-----------------------------------------------------------------------------
void uiGameOver() {
    int16_t x;

    printXY(10, 10, 0, colors[TP_COLOR_WHITE], TEXT_PLAYER);
    printXY(10, 13, 0, colors[TP_COLOR_RED], TEXT_GAME_OVER);
    uiTimer = UI_GAME_OVER_TIMER;
    while(--uiTimer) {
        // Make sure Game Over is on-screen for at least 1 second
        if(uiTimer < UI_GAME_OVER_TIMER-60) {
            inputInUI();
            if(inputMask & ~(INPUT_MASK_MOVEMENT | INPUT_ROTATE_LEFT | INPUT_ROTATE_RIGHT)) {
                break;
            }
        }
        tigrUpdate(screen);
    }
    x = 4;
    while (x >= 0 && playerScore >= highScore[x]){
        --x;
    }
    if(x < 4) {
        audioPlaySource(AUDIO_HIGHSCORE);
        uiInsertRow = ++x;
        x = 4;
        while(x > uiInsertRow) {
            x--;
            strcpy(TEXT_HIGHSCORES[x+1], TEXT_HIGHSCORES[x]);
            strcpy(TEXT_INITIALS[x+1], TEXT_INITIALS[x]);
            highScore[x+1] = highScore[x];
        }
        highScore[x] = playerScore;
        sprintf(TEXT_HIGHSCORES[x], "%6d00", playerScore);
        strcpy(TEXT_INITIALS[x], "A  ");
        x = HIGHSCORE_ENTRY_TIME;
        drawBackgroundColor = colors[TP_COLOR_BLACK];
        screenWipe();
        uiShowCommonLabels();
        uiShowHighScoreTable();
        printXY(5, 0, 0, colors[TP_COLOR_BLUE], TEXT_ENTER_INITIALS);
        uiLetterIndex = 0;
        uiTimer = 0;
        uiLetter = 'A';
        uiInitialsColor = TP_COLOR_WHITE;
        tigrReadChar(screen); // Clear the kbd buffer
        while(x && uiLetterIndex < 3) {
            while(uiTimer--) {
                tigrUpdate(screen);
                // Check for direct keyboard entry of initials
                int16_t key = tigrReadChar(screen);
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
                inputInUI();
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
                printRectXY(20+uiLetterIndex, highScoreInitialsY[uiInsertRow], 0, colors[TP_COLOR_BLACK], 1);
                printXY(20+uiLetterIndex, highScoreInitialsY[uiInsertRow], 0, colors[uiInitialsColor], &TEXT_INITIALS[uiInsertRow][uiLetterIndex]);
            }
            if(uiTimer < 0) {
                uiTimer = UI_COLORCYCLE_TIMER;
                uiInitialsColor = (TP_COLOR_WHITE ^ uiInitialsColor) | 0x1;
                x--;
            }
            printRectXY(20, highScoreInitialsY[uiInsertRow], 0, colors[TP_COLOR_BLACK], 3);
            printXY(20, highScoreInitialsY[uiInsertRow], 0, colors[highScoreColorIndex[uiInsertRow]], TEXT_INITIALS[uiInsertRow]);
        }
        audioStopSource(AUDIO_HIGHSCORE);
    }
}

//-----------------------------------------------------------------------------
void uiInit() {
    // Check for joystick
    inputCheckForJoy(0);

    // Normal code resumes
    tigrClear(screen, colors[TP_COLOR_BLACK]);
    printXY(29, 1, 0, colors[TP_COLOR_RED]  , TEXT_HIGH);
    printXY(35, 4, 0, colors[TP_COLOR_RED]  , TEXT_1UP);
    printXY(31, 2, 0, colors[TP_COLOR_WHITE], TEXT_HIGHSCORES[0]);
    printXY(37, 5, 0, colors[TP_COLOR_WHITE], TEXT_SCORE00);
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
int16_t uiMain() {
    int16_t key;
    uint16_t uiIterations = 0;
    uiState = 0;
    if(demoAttractMode) {
        playerScore = demoAttractScore;
        if(playerScore) {
            uiShowP1Score();
        } else {
            tigrFill(screen, PLAYFIELDW*8, 5*8, 9*8, 1*8, colors[TP_COLOR_BLACK]);
        }
        demoAttractMode = 0;
    }
    uiShowCommonLabels();
    tigrReadChar(screen); // clear KBD - probably doesn't do much in "C" code
    inputMask = 0;
    while(1) {
        uiTimer = UI_STATE_TIMER;
        if(uiState) {
            uiShowHighScoreTable();
        } else {
            uiShowTitle();
        }
        while(1) {
            if(--uiTimer < 0) {
                if(++uiIterations == 6) {
                    demoAttractScore = playersScore[0];
                    demoAttractMode = 1;
                    return uiPlay(0);
                }
                tigrFill(screen, 5*8, 6*8, 20*8, 11*8, colors[TP_COLOR_BLACK]);
                uiState ^= 1;
                break;
            }
            inputInUI();
            if(inputMask & INPUT_QUIT) {
                return 0;
            }
            if(inputMask & (INPUT_FIRE | INPUT_PAUSE)) {
                return uiPlay(0);
            }
            if(inputMask & INPUT_2P) {
                return uiPlay(1);
            }
            // A direct scan of the keyboard to see the J key
            if((tigrReadChar(screen) & 0x5F) == 'J') {
                uiJoyScan();
            }
            tigrUpdate(screen);
        }
    }
    return 1;
}

//-----------------------------------------------------------------------------
void uiPause() {
    int16_t key;

    printXY(11, 8, 0, colors[TP_COLOR_RED], TEXT_PAUSE);
    while(1) {
        tigrUpdate(screen);
        inputInUI();
        if(inputMaskDebounced & (INPUT_PAUSE | INPUT_QUIT)) {
            break;
        }
    }
    printXY(11, 8, 0, drawBackgroundColor, TEXT_PAUSE);
}

//-----------------------------------------------------------------------------
int16_t uiPlay(uint16_t numPlayers) {
    numberOfPlayers = numPlayers;
    numberOfPlayersAlive = numPlayers;
    activePlayer = 0;
    return 1;
}

//-----------------------------------------------------------------------------
void uiShowCommonLabels() {
    tigrBlit(screen, logoSprites, 6*SCOLW, 2*SROWH, 0, 0, logoSprites->w, logoSprites->h);
    printXY(8, 19, 0, colors[TP_COLOR_WHITE],TEXT_KONAMI);
    printXY(7, 22, 0, colors[TP_COLOR_BLUE] ,TEXT_VERSION);
    printXY(5, 24, 0, colors[TP_COLOR_BLUE] ,TEXT_STEFAN);
}

//-----------------------------------------------------------------------------
void uiShowHighScore() {
    // Overwrite the whole score to clear the 658[16].
    printRectXY(31, 2, 0, colors[TP_COLOR_BLACK], 8);
    sprintf(TEXT_HIGHSCOREDISPLAY, "%6d00", highScoresDisplay);
    printXY(31, 2, 0, colors[TP_COLOR_WHITE], TEXT_HIGHSCOREDISPLAY);
}

//-----------------------------------------------------------------------------
void uiShowHighScoreTable() {
    printXY(5 , 6 , 0, colors[TP_COLOR_MAGENTA]       , TEXT_RANKING);
    printXY(5 , 8 , 0, colors[highScoreColorIndex[0]] , TEXT_1ST);
    printXY(9 , 8 , 0, colors[highScoreColorIndex[0]] , TEXT_HIGHSCORES[0]);
    printXY(20, 8 , 0, colors[highScoreColorIndex[0]] , TEXT_INITIALS[0]);
    printXY(5 , 10, 0, colors[highScoreColorIndex[1]] , TEXT_2ND);
    printXY(9 , 10, 0, colors[highScoreColorIndex[1]] , TEXT_HIGHSCORES[1]);
    printXY(20, 10, 0, colors[highScoreColorIndex[1]] , TEXT_INITIALS[1]);
    printXY(5 , 12, 0, colors[highScoreColorIndex[2]] , TEXT_3RD);
    printXY(9 , 12, 0, colors[highScoreColorIndex[2]] , TEXT_HIGHSCORES[2]);
    printXY(20, 12, 0, colors[highScoreColorIndex[2]] , TEXT_INITIALS[2]);
    printXY(5 , 14, 0, colors[highScoreColorIndex[3]] , TEXT_4TH);
    printXY(9 , 14, 0, colors[highScoreColorIndex[3]] , TEXT_HIGHSCORES[3]);
    printXY(20, 14, 0, colors[highScoreColorIndex[3]] , TEXT_INITIALS[3]);
    printXY(5 , 16, 0, colors[highScoreColorIndex[4]] , TEXT_5TH);
    printXY(9 , 16, 0, colors[highScoreColorIndex[4]] , TEXT_HIGHSCORES[4]);
    printXY(20, 16, 0, colors[highScoreColorIndex[4]] , TEXT_INITIALS[4]);
}

//-----------------------------------------------------------------------------
void uiShowP1Score() {
    printRectXY(30, 5, 0, colors[TP_COLOR_BLACK], 7);
    sprintf(TEXT_P1SCORE, "%7d0", playerScore);
    printXY(30, 5, 0, colors[TP_COLOR_WHITE], TEXT_P1SCORE);
}

//-----------------------------------------------------------------------------
void uiShowP2Playing() {
    printXY(35, 7 , 0, colors[TP_COLOR_RED]  , TEXT_2UP);
    printRectXY(28, 8, 0, colors[TP_COLOR_BLACK], 9);
    printXY(37, 8 , 0, colors[TP_COLOR_WHITE], TEXT_SCORE00);
}

//-----------------------------------------------------------------------------
void uiShowP2Score() {
    printRectXY(30, 8, 0, colors[TP_COLOR_BLACK], 7);
    sprintf(TEXT_P2SCORE, "%7d0", playerScore);
    printXY(30, 8, 0, colors[TP_COLOR_WHITE], TEXT_P2SCORE);
}

//-----------------------------------------------------------------------------
void uiShowPlayerShips() {
    int16_t x;
    screenClearSection(PLAYFIELDW, 19, SCOL-PLAYFIELDW, 2, colors[TP_COLOR_BLACK]);
    for(x = playerLives; x > 0; x--) {
        tigrBlit(screen, playerSprites,
        (SCOL-(x*2))*SCOLW,
        19 * SROWH,
        PLAYER_FRAME_UP * 16, 0,
        16, 16);
    }
}

//-----------------------------------------------------------------------------
void uiShowPreGameLabels() {
    sprintf(TEXT_PLAYER, "PLAYER %c", '1'+activePlayer);
    sprintf(TEXT_STAGE,"STAGE %d", activeStage+1);
    if(!demoAttractMode) {
        printXY(10, 10, 0, colors[TP_COLOR_WHITE], TEXT_PLAYER);
    }
    if(!stageIntroState) {
        if(--introColorTimer < 0) {
            introColorTimer = INTRO_COLOR_CYCLE_TIME;
            if(--introColorOffset < 0) {
                introColorOffset = 2;
            }
        }
        printXY(10, 15, 0, colors[stageLabelColor[introColorOffset]], *stageLabelText[activeStage]);
        printXY(10, 18, 0, colors[TP_COLOR_WHITE], TEXT_STAGE);
    } else {
        printXY(11, 15, 0, colors[TP_COLOR_WHITE], TEXT_READY);
    }
}

//-----------------------------------------------------------------------------
void uiShowStageIcon() {
    int16_t x;
    screenClearSection(PLAYFIELDW,16,SCOL-1,1,colors[TP_COLOR_BLACK]);
    for(x = activeStage + 1 ; x > 0 ; x-- ) {
        tigrBlit(screen, stageSprites, SCREENW - (x*SCOLW), 16*SROWH, 0, 0, stageSprites->w, stageSprites->h);
    }
}

//-----------------------------------------------------------------------------
void uiShowStageProgress() {
    int16_t x;
    for(x = NUM_PROGRESS_PLANES; x > 0; x--) {
        tigrBlit(screen, progressSprites,
        (SCOL-(x*2))*SCOLW, 24 * SROWH,
        0, 0, 16, 8);
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

    printXY(12,  0, 0, colors[TP_COLOR_CYAN]  , TEXT_PLAY);
    printXY( 5,  6, 0, colors[TP_COLOR_CYAN]  , TEXT_DEPOSIT);
    printXY( 5, 14, 0, colors[TP_COLOR_CYAN]  , TEXT_BONUS1);
    printXY( 5, 16, 0, colors[TP_COLOR_CYAN]  , TEXT_BONUS2);
    printXY( 6,  8, 0, colors[TP_COLOR_RED]   , TEXT_TRY_GAME);
    printXY( 5, 10, 0, colors[TP_COLOR_YELLOW], TEXT_CONTROLSK);
    if(inputUsingJoystick < 0) {
        printXY( 6, 12, 0, colors[TP_COLOR_ORANGE], TEXT_CONTROLSNJ);
    } else {
        printXY( 8, 12, 0, colors[TP_COLOR_YELLOW], TEXT_CONTROLSJ);
        printXY(21, 12, 0, colors[TP_COLOR_GREEN] , TEXT_CONTROLSN);
        printXY( 9, 12, 0, colors[TP_COLOR_GREEN] , TEXT_J);
    }
}

//-----------------------------------------------------------------------------
void uiUpdateStageProgress() {
    int16_t clearSection = enemiesKilled;
    if(clearSection > ENEMIES_TO_KILL_TO_CLEAR) {
        clearSection = ENEMIES_TO_KILL_TO_CLEAR;
    }
    tigrFill(screen,
    PLAYFIELDW * SCOLW, 24 * SROWH,
    ((SCOL-PLAYFIELDW)*SCOLW)*clearSection/ENEMIES_TO_KILL_TO_CLEAR, SROWH,
    colors[TP_COLOR_BLACK]);
}
