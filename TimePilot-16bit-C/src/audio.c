//-----------------------------------------------------------------------------
// audio.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "tigr.h"
#include "globals.h"

#include "audio.h"

//-----------------------------------------------------------------------------
void audioCleanup() {
    audioIsInit = 0;
    alutExit();
}

//-----------------------------------------------------------------------------
void audioConfigSource(int16_t source, int16_t flag, int16_t state) {
    if(audioSourceHandles[source]) {
        alSourcei(audioSourceHandles[source], flag , state);
    }
}

//-----------------------------------------------------------------------------
void audioInit() {
    alutInit(0, 0);
    if (alGetError() != AL_NO_ERROR) {
        alutExit();
        return;
    }

    audioIsInit = 1;
}

//-----------------------------------------------------------------------------
int16_t audioIsSourcePlaying(int16_t source) {
    ALuint state = AL_STOPPED;
    if(audioSourceHandles[source]) {
        alGetSourcei(audioSourceHandles[source], AL_SOURCE_STATE, &state);
    }
    return state == AL_PLAYING;
}

//-----------------------------------------------------------------------------
void audioPlaySource(int16_t source) {
    // It works to send a 0 sample but it feels wrong
    if(audioSourceHandles[source]) {
        alSourcePlay(audioSourceHandles[source]);
    }
}

//-----------------------------------------------------------------------------
void audioStopSource(int16_t source) {
    // It works to send a 0 sample but it feels wrong
    if(audioSourceHandles[source]) {
        alSourceStop(audioSourceHandles[source]);
    }
}
