//-----------------------------------------------------------------------------
// main.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "archie.h"
#include "globals.h"

#include "audio.h"
#include "data.h"
#include "game.h"
#include "main.h"
#include "screen.h"
#include "text.h"
#include "ui.h"

#include <stdlib.h>
#include <string.h>

static int32_t mainSilent;

//-----------------------------------------------------------------------------
int main(int argc, char **argcv) {
    int i;
    for(i = 1; i < argc; i++) {
        if(!strcmp(argcv[i], "--silent")) mainSilent = 1;
    }
    if(mainInit()) {
        mainLoop();
    }
    mainCleanup();
    return 0;
}

//-----------------------------------------------------------------------------
void mainCleanup() {
    audioCleanup();
    dataCleanup();
    archieCleanup();
}

//-----------------------------------------------------------------------------
int32_t mainInit() {
    screenSetPalette();
    if(!archieInit()) {
        return 0;
    }

    globalsInit();
    if(!mainSilent) audioInit();
    if(!dataInit()) {
        archieShowErrorDialog("Unable to load sprite data");
        return 0;
    }
    uiInit();
    return 1;
}

//-----------------------------------------------------------------------------
void mainLoop() {
    while(!global_quit) {
        if(!uiMain()) {
            break;
        }
        gameStart();
    }
}
