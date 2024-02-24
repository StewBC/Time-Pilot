//-----------------------------------------------------------------------------
// main.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include <stdint.h>
#include "globals.h"

#include "audio.h"
#include "data.h"
#include "game.h"
#include "main.h"
#include "screen.h"
#include "text.h"
#include "ui.h"

#include <cx16.h>
#include <stdlib.h>

//-----------------------------------------------------------------------------
int main(int argc, char** argcv) {
    if(mainInit()) {
        mainLoop();
        mainCleanup();
    }
    screenCleanup();
    cx16_k_i2c_write_byte(0x42, 2, 0);
    return 0;
}

//-----------------------------------------------------------------------------
void mainCleanup() {
    // Audio again before data
    audioCleanup();
    dataCleanup();
}

//-----------------------------------------------------------------------------
int8_t mainInit() {

    // VERA & screen
    screenInit();
    globalsInit();
    audioInit();    // Audio before data
    if(!dataInit()) {
        // If the graphics didn't load the game can't run
        return 0;
    }
    uiInit();
    // Sprites and layers back on
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
