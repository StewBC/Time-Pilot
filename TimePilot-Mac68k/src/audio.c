//-----------------------------------------------------------------------------
// audio.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "mac.h"
#include "globals.h"

#include "audio.h"
#include "resids.h"

//-----------------------------------------------------------------------------
// None of this is how it's supposed to be but I could not for the life of
// me get theCmd->param[1|2] of theChan->userInfo to be correct.  It's as 
// though the pointers are all wrong. Obviously something I don't understand
// but since this works with no A5 World issues, it is now how it is.
void audioCallback(SndChannelPtr theChan, SndCommand *theCmd) {
    SCStatus status;
    int16_t i;
    for(i=0; i < AUDIO_CHANNELS; i++) {
        if(audioSourceChannels[i]->userInfo >= 0) {
            SndChannelStatus(audioSourceChannels[i], sizeof(SCStatus), &status);
            if(!status.scChannelBusy) {
                audioSourceChannels[i]->userInfo = -1;
            }
        }
    }
}

//-----------------------------------------------------------------------------
void audioCleanup() {
    audioIsInit = 0;
}

//-----------------------------------------------------------------------------
void audioInit() {
    audioIsInit = 1;
    audio_channel = 0;
}

//-----------------------------------------------------------------------------
int16_t audioIsSourcePlaying(int16_t source) {
    if(audioIsInit) {
        int16_t i;
        for(i=0; i < AUDIO_CHANNELS; i++) {
            if(audioSourceChannels[i]->userInfo == source) {
                return 1;
            }
        }
    }
    return 0;
}

//-----------------------------------------------------------------------------
void audioPlaySource(int16_t source) {
    if(audioInit) {
        long offset;
        SndCommand soundCommand;
        int16_t channel = (audio_channel + 1) % AUDIO_CHANNELS;
        while(channel != audio_channel) {
            if(audioSourceChannels[channel]->userInfo < 0) {
                audioSourceChannels[channel]->userInfo = source;
                SndPlay(audioSourceChannels[channel], (SndListHandle)audioSourceHandles[source], TRUE);

                soundCommand.cmd = callBackCmd;
                soundCommand.param1 = 0;
                soundCommand.param2 = 0;
                SndDoCommand(audioSourceChannels[channel], &soundCommand, FALSE);
                return;
            }
            channel = (channel + 1) % AUDIO_CHANNELS;
        }
    }
}

//-----------------------------------------------------------------------------
void audioStopSource(int16_t source) {
    if(audioIsInit) {
        int16_t i;
        for(i=0; i < AUDIO_CHANNELS; i++) {
            if(audioSourceChannels[i]->userInfo == source) {
                SndCommand soundCommand;
                soundCommand.cmd = quietCmd;
                soundCommand.param1 = 0;
                soundCommand.param2 = 0;
                SndDoImmediate(audioSourceChannels[i], &soundCommand);
                break;
            }
        }
    }
}
