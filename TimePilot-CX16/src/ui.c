//-----------------------------------------------------------------------------
// ui.c
// Part of Time Pilot, the 1982 arcade game remake for the Commander X16
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include <stdint.h>
#include "globals.h"

#include "audio.h"
#include "data.h"
#include "draw.h"
#include "erase.h"
#include "game.h"
#include "input.h"
#include "print.h"
#include "screen.h"
#include "text.h"
#include "ui.h"

#include <cbm.h>
#include <cx16.h>
#include <stdio.h>
#include <string.h>

//-----------------------------------------------------------------------------
void uiErasePreGameLabels() {
    printXY(1, 10, MID_SCREENY-3, 0, TP_COLOR_BLACK, TEXT_PLAYER);
    if(!stageIntroState) {
        printXY(1, 10, MID_SCREENY+2, 0, TP_COLOR_BLACK, *stageLabelText[activeStage]);
        printXY(1, 10, MID_SCREENY+6, 0, TP_COLOR_BLACK, TEXT_STAGE);
        stageIntroState = 1;
    } else {
        printXY(1, 11, MID_SCREENY+2, 0, TP_COLOR_BLACK, TEXT_READY);
    }
}

//-----------------------------------------------------------------------------
void uiGameOver() {
    int8_t x;

    eraseSpriteRange(MAX_OBJECTS);
    printXY(0, 10, MID_SCREENY-3, 0, TP_COLOR_WHITE | (TP_COLOR_SKY << 4), TEXT_PLAYER);
    printXY(0, 10, MID_SCREENY+2, 0, TP_COLOR_RED | (TP_COLOR_SKY << 4), TEXT_GAME_OVER);
    uiTimer = UI_GAME_OVER_TIMER;
    while(--uiTimer) {
        // Make sure Game Over is on-screen for at least 1 second
        if(uiTimer < UI_GAME_OVER_TIMER-60) {
            inputInUI();
            if(inputMask & ~(INPUT_MASK_MOVEMENT | INPUT_ROTATE_LEFT | INPUT_ROTATE_RIGHT)) {
                break;
            }
        }
        audioServiceAudio();
        waitvsync();
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
        x = (int8_t)HIGHSCORE_ENTRY_TIME;
        screenWipe(TP_COLOR_BLACK);
        uiShowCommonLabels();
        uiShowHighScoreTable();
        printXY(0, 5, 0, 0, TP_COLOR_BLUE, TEXT_ENTER_INITIALS);
        uiLetterIndex = 0;
        uiTimer = 0;
        uiLetter = 'A';
        uiInitialsColor = TP_COLOR_WHITE;
        while(cbm_k_getin()) {;}
        while(x && uiLetterIndex < 3) {
            while(uiTimer--) {
                audioServiceAudio();
                waitvsync();
                // Check for direct keyboard entry of initials
                int8_t key = cbm_k_getin();
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
                printXY(0, 20+uiLetterIndex, highScoreInitialsY[uiInsertRow], 0, uiInitialsColor, &TEXT_INITIALS[uiInsertRow][uiLetterIndex]);
            }
            if(uiTimer < 0) {
                uiTimer = UI_COLORCYCLE_TIMER;
                uiInitialsColor = (TP_COLOR_WHITE ^ uiInitialsColor) | 0x1;
                x--;
            }
            printXY(0, 20, highScoreInitialsY[uiInsertRow], 0, highScoreColorIndex[uiInsertRow], TEXT_INITIALS[uiInsertRow]);
        }
        audioStopSource(AUDIO_HIGHSCORE);
    }
}

//-----------------------------------------------------------------------------
void uiInit() {
    // Clear the keyboard and keyboard-joystick
    while(cbm_k_getin()) {;}
    while((cx16_k_joystick_get(0) & 0xFFFF) != 0xFFFF) {;}

    printXY(1, 29, 1, 0, TP_COLOR_RED   | (TP_COLOR_EXTRA << 4), TEXT_HIGH);
    printXY(1, 35, 4, 0, TP_COLOR_RED   | (TP_COLOR_EXTRA << 4), TEXT_1UP);
    printXY(1, 31, 2, 0, TP_COLOR_WHITE | (TP_COLOR_EXTRA << 4), TEXT_HIGHSCORES[0]);
    printXY(1, 37, 5, 0, TP_COLOR_WHITE | (TP_COLOR_EXTRA << 4), TEXT_SCORE00);
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
int8_t uiMain() {
    uint8_t uiIterations = 0;
    uiState = 0;
    if(demoAttractMode) {
        playerScore = demoAttractScore;
        if(playerScore) {
            uiShowP1Score();
        } else {
            screenClearSection(1, PLAYFIELDW, 5, 9, 1, TP_COLOR_EXTRA);
        }
        demoAttractMode = 0;
    }
    uiShowCommonLabels();
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
                    demoAttractScore = playerScore;
                    demoAttractMode = 1;
                    return uiPlay(0);
                }
                screenClearSection(0, 5, 6, 20, 11, TP_COLOR_BLACK);
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
            if(inputMask & INPUT_SCAN) {
                uiIterations = 0;
                uiJoyScan();
            }
            audioServiceAudio();
            waitvsync();
        }
    }
    return 1;
}

//-----------------------------------------------------------------------------
void uiPause() {
    printXY(1, 11, 8, 0, TP_COLOR_RED, TEXT_PAUSE);
    while(1) {
        audioServiceAudio();
        waitvsync();
        inputInUI();
        if(inputMaskDebounced & (INPUT_PAUSE | INPUT_QUIT)) {
            break;
        }
    }
    printXY(1, 11, 8, 0, TP_COLOR_BLACK, TEXT_PAUSE);
}

//-----------------------------------------------------------------------------
int8_t uiPlay(uint8_t numPlayers) {
    numberOfPlayers = numPlayers;
    numberOfPlayersAlive = numPlayers;
    return 1;
}

//-----------------------------------------------------------------------------
void uiShowCommonLabels() {
    drawShowSprite(UI_SPR_LOGO, 0b00000100);
    drawShowSprite(UI_SPR_LOGO+1, 0b00000100);
    printXY(0, 8, 19, 0, TP_COLOR_WHITE,TEXT_KONAMI);
    printXY(0, 7, 22, 0, TP_COLOR_BLUE ,TEXT_VERSION);
    printXY(0, 5, 24, 0, TP_COLOR_BLUE ,TEXT_STEFAN);
}

//-----------------------------------------------------------------------------
void uiShowHighScore() {
    // Overwrite the whole score to clear the 658[16].
    sprintf(TEXT_HIGHSCOREDISPLAY, "%6d00", highScoresDisplay);
    printXY(1, 31, 2, 0, TP_COLOR_WHITE | (TP_COLOR_EXTRA << 4), TEXT_HIGHSCOREDISPLAY);
}

//-----------------------------------------------------------------------------
void uiShowHighScoreTable() {
    printXY(0, 5 , 6 , 0, TP_COLOR_MAGENTA       , TEXT_RANKING);
    printXY(0, 5 , 8 , 0, highScoreColorIndex[0] , TEXT_1ST);
    printXY(0, 9 , 8 , 0, highScoreColorIndex[0] , TEXT_HIGHSCORES[0]);
    printXY(0, 20, 8 , 0, highScoreColorIndex[0] , TEXT_INITIALS[0]);
    printXY(0, 5 , 10, 0, highScoreColorIndex[1] , TEXT_2ND);
    printXY(0, 9 , 10, 0, highScoreColorIndex[1] , TEXT_HIGHSCORES[1]);
    printXY(0, 20, 10, 0, highScoreColorIndex[1] , TEXT_INITIALS[1]);
    printXY(0, 5 , 12, 0, highScoreColorIndex[2] , TEXT_3RD);
    printXY(0, 9 , 12, 0, highScoreColorIndex[2] , TEXT_HIGHSCORES[2]);
    printXY(0, 20, 12, 0, highScoreColorIndex[2] , TEXT_INITIALS[2]);
    printXY(0, 5 , 14, 0, highScoreColorIndex[3] , TEXT_4TH);
    printXY(0, 9 , 14, 0, highScoreColorIndex[3] , TEXT_HIGHSCORES[3]);
    printXY(0, 20, 14, 0, highScoreColorIndex[3] , TEXT_INITIALS[3]);
    printXY(0, 5 , 16, 0, highScoreColorIndex[4] , TEXT_5TH);
    printXY(0, 9 , 16, 0, highScoreColorIndex[4] , TEXT_HIGHSCORES[4]);
    printXY(0, 20, 16, 0, highScoreColorIndex[4] , TEXT_INITIALS[4]);
}

//-----------------------------------------------------------------------------
void uiShowP1Score() {
    screenClearSection(1, 30, 5, 7, 1, TP_COLOR_EXTRA);
    sprintf(TEXT_P1SCORE, "%7d0", playerScore);
    printXY(1, 30, 5, 0, TP_COLOR_WHITE | (TP_COLOR_EXTRA << 4), TEXT_P1SCORE);
}

//-----------------------------------------------------------------------------
void uiShowP2Playing() {
    printXY(1, 35, 7 , 0, TP_COLOR_RED  | (TP_COLOR_EXTRA << 4), TEXT_2UP);
    screenClearSection(1, PLAYFIELDW, 8, 9, 1, TP_COLOR_EXTRA);
    printXY(1, 37, 8 , 0, TP_COLOR_WHITE| (TP_COLOR_EXTRA << 4), TEXT_SCORE00);
}

//-----------------------------------------------------------------------------
void uiShowP2Score() {
    sprintf(TEXT_P2SCORE, "%7d0", playerScore);
    printXY(1, 30, 8, 0, TP_COLOR_WHITE| (TP_COLOR_EXTRA << 4), TEXT_P2SCORE);
}

//-----------------------------------------------------------------------------
void uiShowPlayerShips() {
    int8_t x, y;
    y = playerLives < 6 ? playerLives : 6;
    for(x = 0; x < y; x++) {
        drawShowSprite(UI_SPR_EXTRA_LIVES+x, 0b00001100);
    }
    for(x = y; x < 6; x++) {
        eraseSprite(UI_SPR_EXTRA_LIVES+x);
    }
}

//-----------------------------------------------------------------------------
void uiShowPreGameLabels() {
    // This simply does nothing, as does *((char*)TEXT_PLAYER) = '1' for example?  What am I missing?
    // TEXT_PLAYER[7] = '1'+activePlayer;
    // TEXT_STAGE[6] = '1'+activeStage;
    sprintf(TEXT_PLAYER, "PLAYER %c", '1'+activePlayer);
    sprintf(TEXT_STAGE,"STAGE %d", activeStage+1);
    if(!demoAttractMode) {
        printXY(1, 10, MID_SCREENY-3, 0, TP_COLOR_WHITE, TEXT_PLAYER);
    }
    if(!stageIntroState) {
        if(--introColorTimer < 0) {
            introColorTimer = INTRO_COLOR_CYCLE_TIME;
            if(--introColorOffset < 0) {
                introColorOffset = 2;
            }
        }
        printXY(1, 10, MID_SCREENY+2, 0, stageLabelColor[introColorOffset], *stageLabelText[activeStage]);
        printXY(1, 10, MID_SCREENY+6, 0, TP_COLOR_WHITE, TEXT_STAGE);
    } else {
        printXY(1, 11, MID_SCREENY+2, 0, TP_COLOR_WHITE, TEXT_READY);
    }
}

//-----------------------------------------------------------------------------
void uiShowStageIcon() {
    int8_t x, y;
    for(x = 0; x <= activeStage; x++) {
        drawShowSprite(UI_SPR_STAGE_INDEX+x, 0b00001100);
    }
    for(x = activeStage + 1; x < NUM_UI_SPR_STAGE_INDEX; x++) {
        eraseSprite(UI_SPR_STAGE_INDEX+x);
    }
}

//-----------------------------------------------------------------------------
void uiShowStageProgress() {
    uint8_t y, progress;
    uint16_t src;
    uint16_t dest = ((spriteVRAMMisc_hi[UI_LAYER_BLANK1-LAYER_NUM_LAYERS] << 8) + spriteVRAMMisc_lo[UI_LAYER_BLANK1-LAYER_NUM_LAYERS]) << 5;

    if(activeStage != 4) {
        src = ((spriteVRAMMisc_hi[0] << 8) + spriteVRAMMisc_lo[0]) << 5;
    } else {
        src = ((spriteVRAMEnemies_hi[4] << 8) + spriteVRAMEnemies_lo[4]) << 5;
    }

    VERA.address_hi = VERA_INC_8 | 1;
    VERA.control |= 1;
    VERA.address_hi = VERA_INC_32 | 1;
    VERA.address = dest;
    VERA.control &= 0b11111110;

    for(progress = 0; progress < 48; progress++) {
        if(progress == 32) {
            dest += 0x100;
        }
        VERA.control |= 1;
        VERA.address = dest + (progress & 31);
        VERA.control &= 0b11111110;
        VERA.address = src + (progress & 7);
        if(progress < enemiesKilled) {
            for(y=0; y<8; y++) {
                VERA.data1 = 0;
            }
        } else {
            for(y=0; y<8; y++) {
                VERA.data1 = VERA.data0;
            }
        }
    }
}

//-----------------------------------------------------------------------------
void uiShowTitle() {
    printXY(0, 12,  0, 0, TP_COLOR_CYAN, TEXT_PLAY);
    printXY(0,  5,  6, 0, TP_COLOR_CYAN, TEXT_DEPOSIT);
    printXY(0,  5, 14, 0, TP_COLOR_CYAN, TEXT_BONUS1);
    printXY(0,  5, 16, 0, TP_COLOR_CYAN, TEXT_BONUS2);
    printXY(0,  6,  8, 0, TP_COLOR_RED , TEXT_TRY_GAME);
    printXY(0,  5, 10, 0, TP_COLOR_YELLOW, TEXT_CONTROLSK);
    printXY(0,  8, 12, 0, TP_COLOR_YELLOW, TEXT_CONTROLSJ);
    printXY(0, 21, 12, 0, TP_COLOR_GREEN, TEXT_CONTROLSN);
    printXY(0,  9, 12, 0, TP_COLOR_GREEN, TEXT_J);
}

//-----------------------------------------------------------------------------
void uiUpdateStageProgress() {
    uint8_t y;
    if(enemiesKilled < 49) {
        int8_t progress = enemiesKilled - 1;
        uint16_t dest = ((spriteVRAMMisc_hi[UI_LAYER_BLANK1-LAYER_NUM_LAYERS] << 8) + spriteVRAMMisc_lo[UI_LAYER_BLANK1-LAYER_NUM_LAYERS]) << 5;
        if(progress >= 32) {
            dest += 0x100;
        }
        dest += (progress & 31);

        VERA.address_hi = VERA_INC_32 | 1;
        VERA.address = dest;
        for(y=0; y<8; y++) {
            VERA.data0 = 0;
        }
    }
}
