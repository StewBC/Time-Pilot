//-----------------------------------------------------------------------------
// text.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

// Using arrays for strings so that the compiler won't put the strings
// into read-only memory.
char TEXT_CONTROLSN[] = "0 ";
char TEXT_HIGHSCOREDISPLAY[] = "   65816";
char TEXT_HIGHSCORES[][9] = {
    "   65816",
    "    8086",
    "    6809",
    "    6502",
    "    4040"
};

char TEXT_INITIALS[][4] = {
    "K.O",
    "N.A",
    "M.I",
    "O.O",
    "Y.A"
};

char TEXT_P1SCORE[] = "        ";
char TEXT_P2SCORE[] = "        ";
char TEXT_PLAYER[] = "PLAYER 1";
char TEXT_STAGE[] = "STAGE 1";
const char *TEXT_1ST = "1ST";
const char *TEXT_1UP = "1-UP";
const char *TEXT_2ND = "2ND";
const char *TEXT_2UP = "2-UP";
const char *TEXT_3RD = "3RD";
const char *TEXT_4TH = "4TH";
const char *TEXT_5TH = "5TH";
const char *TEXT_BLANK = "        ";
const char *TEXT_BONUS1 = "1ST BONUS 10000 PTS.";
const char *TEXT_BONUS2 = "AND EVERY 50000 PTS.";
const char *TEXT_CONTROLSJ = "[J]OYSTICK -";
const char *TEXT_CONTROLSK = "KEYBOARD OR JOYSTICK";
const char *TEXT_CONTROLSNJ = "JOYSTICK NOT FOUND";
const char *TEXT_DEPOSIT = "PLEASE PRESS 1 OR 2";
const char *TEXT_ENTER_INITIALS = "INPUT YOUR INITIALS";
const char *TEXT_GAME_OVER = "GAME OVER";
const char *TEXT_HIGH = "HIGH SCORE";
const char *TEXT_J = "J";
const char *TEXT_KONAMI = "\x5E KONAMI 1982";
const char *TEXT_NUMBERBUFFER = "        ";
const char *TEXT_PAUSE = "PAUSED";
const char *TEXT_PERIOD0_1910 = "A.D. 1910";
const char *TEXT_PERIOD1_1940 = "A.D. 1940";
const char *TEXT_PERIOD2_1970 = "A.D. 1970";
const char *TEXT_PERIOD3_1982 = "A.D. 1982";
const char *TEXT_PERIOD4_2001 = "A.D. 2001";
const char *TEXT_PLAY = "PLAY";
const char *TEXT_RANKING = "SCORE RANKING TABLE";
const char *TEXT_READY = "READY";
const char *TEXT_SCORE00 = "00";
const char *TEXT_STEFAN = "STEFAN WESSELS 2024";
const char *TEXT_TRY_GAME = "AND TRY THIS GAME";
const char *TEXT_VERSION = "THIS VERSION BY";
