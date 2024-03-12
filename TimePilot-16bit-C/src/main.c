//-----------------------------------------------------------------------------
// main.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "tigr.h"
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
int main(int argc, char** argcv) {
    if(mainInit()) {
        mainLoop();
        mainCleanup();
    }
    return 0;
}

//-----------------------------------------------------------------------------
void mainCleanup() {
    // Audio again before data
    audioCleanup();
    dataCleanup();
    tigrFree(screen);
}

//-----------------------------------------------------------------------------
int16_t mainInit() {
    screen = tigrWindow(SCREENW, SCREENH, "TIME PILOT", 0);
    if(!screen) {
        return 0;
    }
    screenSetPalette();
    tigrClear(screen, colors[TP_COLOR_BLACK]);
    tigrUpdate(screen);

    globalsInit();
    // Audio before data
    audioInit();
    if(!dataInit()) {
        // If the graphics didn't load the game can't run
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
