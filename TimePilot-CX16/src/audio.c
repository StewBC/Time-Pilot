//-----------------------------------------------------------------------------
// audio.c
// Part of Time Pilot, the 1982 arcade game remake for the Commander X16
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.


#include <stdint.h>
#include "globals.h"

#include "audio.h"

//-----------------------------------------------------------------------------
void audioCleanup() {
    audioIsInit = 0;
}

//-----------------------------------------------------------------------------
void audioConfigSource(int8_t source, int8_t flag, int8_t state) {
    if(audioSourceHandles[source]) {
    }
}

//-----------------------------------------------------------------------------
void audioInit() {
    audioIsInit = 1;
}

//-----------------------------------------------------------------------------
int8_t audioIsSourcePlaying(int8_t source) {
    if(audioSourceHandles[source]) {
    }
    return 0;
}

//-----------------------------------------------------------------------------
void audioPlaySource(int8_t source) {
    // It works to send a 0 sample but it feels wrong
    if(audioSourceHandles[source]) {
    }
}

//-----------------------------------------------------------------------------
void audioStopSource(int8_t source) {
    // It works to send a 0 sample but it feels wrong
    if(audioSourceHandles[source]) {
    }
}
