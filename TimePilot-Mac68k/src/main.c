//-----------------------------------------------------------------------------
// main.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "mac.h"
#include "globals.h"

#include "audio.h"
#include "data.h"
#include "game.h"
#include "main.h"
#include "screen.h"
#include "text.h"
#include "ui.h"

#include <stdlib.h>

//-----------------------------------------------------------------------------
int main(int argc, char **argcv) {
    if(mainInit()) {
        mainLoop();
        mainCleanup();
    }
    return 0;
}

//-----------------------------------------------------------------------------
void mainCleanup() {
    audioCleanup();
    dataCleanup();
    macCleanup();
}

//-----------------------------------------------------------------------------
int16_t mainInit() {
    screenSetPalette();
    if(!macInit()) {
        return 0;
    }

    globalsInit();
    audioInit();
    if(!dataInit()) {
        return 0;
    }
    uiInit();
    return 1;
}

//-----------------------------------------------------------------------------
void mainLoop() {
    while(1) {
        if(!uiMain()) {
            break;
        }
        gameStart();
    }
}
