//-----------------------------------------------------------------------------
// audio.c
// Part of Time Pilot, the 1982 arcade game remake for the Commander X16
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.


#include <stdint.h>
#include "globals.h"

#include "audio.h"
#include "data.h"

#include <cx16.h>

// I have no idea why I need to do this.  Without this, there's
// noise when the buffer is stuffed in audioServiceAudio but not
// empty, on the last sample loaded.  I must be missing something...
int8_t silence = 0;

//-----------------------------------------------------------------------------
void audioCleanup() {
    VERA.audio.rate = 0;
    VERA.audio.control = 128;
    audioIsPlaying = -1;
    audioLoopingSample = -1;
    audioIsInit = 0;
}

//-----------------------------------------------------------------------------
void audioInit() {
    VERA.audio.rate = 0;
    VERA.audio.control = 128;
    audioIsInit = 1;
}

//-----------------------------------------------------------------------------
int8_t audioIsSourcePlaying(int8_t source) {
    return source == audioIsPlaying || source == audioLoopingSample;
}

//-----------------------------------------------------------------------------
void audioPlaySource(int8_t source) {
    // Don't play unimplemented samples or a lower priority sound
    if(source >= NUM_AUDIO_SOURCES || source < audioIsPlaying) {
        return;
    }

    // Time Warp (always the last sample loaded...) needs to be cut off
    // or there will ne noise
    if(source == AUDIO_TIMEWARP) {
        silence = 1;
    }

    // Reset PCM and prep for getting data (volume 15)
    VERA.audio.rate = 0;
    VERA.audio.control = 0b10001111;
    if(audioData[source].loops && source > audioLoopingSample) {
        audioLoopingSample = source;
    }

    audioIndex = audioData[source].start_address;
    audioEndBank = audioData[source].end_bank;
    audioEndAddress = audioData[source].end_address;
    RAM_RAM_BANK = audioCurrentBank = audioData[source].start_bank;
    audioIsPlaying = source;
    // Stuff the buffer with data from the requested sample
    audioServiceAudio();
    // Start the playback
    VERA.audio.rate = 32;
}

//-----------------------------------------------------------------------------
void audioServiceAudio() {
    uint16_t range;
    if(audioIsPlaying >= 0) {
fill:
        // How much data can be stuffed
        range = audioEndAddress - audioIndex;
        if(audioCurrentBank != audioEndBank)
            range += 8192;
        // While not full, add data
        while(range && !(VERA.audio.control & 0b10000000)) {
            VERA.audio.data = RAM_BANK_RAM[audioIndex];
            if(++audioIndex == 8192) {
                RAM_RAM_BANK = ++audioCurrentBank;
                audioIndex = 0;
            }
            range--;
        }
        // if done with stuffing this sound
        if(!range) {
            if(silence) {
                VERA.audio.control = 0x80;
                silence = 0;
            }
            // Make sure the sample playes out
            if(VERA.audio.control & 0b01000000) {
                // If it was a looping sample, start the loop again immidiately
                if(audioLoopingSample == audioIsPlaying) {
                    audioIndex = audioData[audioIsPlaying].start_address;
                    audioEndBank = audioData[audioIsPlaying].end_bank;
                    RAM_RAM_BANK = audioCurrentBank = audioData[audioIsPlaying].start_bank;
                    goto fill;
                } else {
                    // Otherwise go silent
                    VERA.audio.control = 128;
                    VERA.audio.rate = 0;
                    audioIsPlaying = -1;
                }
            }
        }
    } else if(audioLoopingSample >= 0) {
        audioPlaySource(audioLoopingSample);
    }
}

//-----------------------------------------------------------------------------
void audioStopSource(int8_t source) {
    // Stop the source if it's currently playing
    if(audioIsPlaying == source) {
        VERA.audio.control = 128;
        VERA.audio.rate = 0;
        audioIsPlaying = -1;
    }
    // If the looping source is to be stopped, remove it
    if(audioLoopingSample == source) {
        audioLoopingSample = -1;
    }
}
