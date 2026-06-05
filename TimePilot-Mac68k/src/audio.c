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

static void audioReleaseSourceIfIdle(int16_t source);

static const int16_t sAudioResourceIDs[AUDIO_WAVE_START + 1] = {
    RAU_BIG_EXPLOSION,
    RAU_BOMB,
    RAU_BOSSL0,
    RAU_BOSSL1,
    RAU_BOSSL2,
    RAU_BOSSL3,
    RAU_COINDROP,
    RAU_ENEMY_EXPLODE,
    RAU_ENEMY_SHOOT,
    RAU_EXTRA_LIFE,
    RAU_GAME_START,
    RAU_HIGHSCORE,
    RAU_NEXT_LEVEL,
    RAU_PICKUP,
    RAU_PLAYER_SHOOT,
    RAU_ROCKET_FLY,
    RAU_ROCKET_LAUNCH,
    RAU_TIMEWARP,
    RAU_WAPON_EXPLODE,
    RAU_WAVE_START
};

//-----------------------------------------------------------------------------
// None of this is how it's supposed to be but I could not for the life of
// me get theCmd->param[1|2] of theChan->userInfo to be correct.  It's as 
// though the pointers are all wrong. Obviously something I don't understand
// but since this works with no A5 World issues, it is now how it is.
void audioCallback(SndChannelPtr theChan, SndCommand *theCmd) {
    SCStatus status;
    int16_t i;
    for(i=0; i < AUDIO_CHANNELS; i++) {
        if(audioSourceChannels[i] && audioSourceChannels[i]->userInfo >= 0) {
            SndChannelStatus(audioSourceChannels[i], sizeof(SCStatus), &status);
            if(!status.scChannelBusy) {
                int16_t source = audioSourceChannels[i]->userInfo;
                if(source == AUDIO_ROCKET_FLY && numberOfRockets && audioSourceHandles[source]) {
                    SndCommand soundCommand;

                    SndPlay(audioSourceChannels[i], (SndListHandle)audioSourceHandles[source], TRUE);
                    soundCommand.cmd = callBackCmd;
                    soundCommand.param1 = 0;
                    soundCommand.param2 = 0;
                    SndDoCommand(audioSourceChannels[i], &soundCommand, FALSE);
                    continue;
                }
                audioSourceChannels[i]->userInfo = -1;
                audioReleaseSourceIfIdle(source);
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
static Handle audioLoadSource(int16_t source) {
    if(source < 0 || source > AUDIO_WAVE_START) {
        return 0;
    }
    if(!audioSourceHandles[source]) {
        audioSourceHandles[source] = GetResource('snd ', sAudioResourceIDs[source]);
    }
    return audioSourceHandles[source];
}

//-----------------------------------------------------------------------------
static void audioReleaseSourceIfIdle(int16_t source) {
    int16_t i;

    if(source < 0 || source > AUDIO_WAVE_START || !audioSourceHandles[source]) {
        return;
    }
    for(i = 0; i < AUDIO_CHANNELS; i++) {
        if(audioSourceChannels[i] && audioSourceChannels[i]->userInfo == source) {
            return;
        }
    }
    ReleaseResource(audioSourceHandles[source]);
    audioSourceHandles[source] = 0;
}

//-----------------------------------------------------------------------------
static int16_t audioIsBossSource(int16_t source) {
    return source >= AUDIO_BOSSL0 && source <= AUDIO_BOSSL3;
}

//-----------------------------------------------------------------------------
static int16_t audioIsSingleInstanceSource(int16_t source) {
    return audioIsBossSource(source) ||
           source == AUDIO_GAME_START ||
           source == AUDIO_HIGHSCORE ||
           source == AUDIO_PLAYER_SHOOT ||
           source == AUDIO_ROCKET_FLY;
}

//-----------------------------------------------------------------------------
int16_t audioIsSourcePlaying(int16_t source) {
    int16_t i;

    for(i=0; i < AUDIO_CHANNELS; i++) {
        if(audioSourceChannels[i] && audioSourceChannels[i]->userInfo == source) {
            return 1;
        }
    }
    return 0;
}

//-----------------------------------------------------------------------------
void audioPlaySource(int16_t source) {
    Handle sourceHandle;

    if(source < 0 || source > AUDIO_WAVE_START) {
        return;
    }
    sourceHandle = audioLoadSource(source);
    if(sourceHandle) {
        SndCommand soundCommand;
        int16_t channel = (audio_channel + 1) % AUDIO_CHANNELS;
        int16_t channelsChecked = 0;

        if(audioIsSingleInstanceSource(source) && audioIsSourcePlaying(source)) {
            return;
        }

        while(channelsChecked < AUDIO_CHANNELS) {
            if(audioSourceChannels[channel] && audioSourceChannels[channel]->userInfo < 0) {
                audio_channel = channel;
                audioSourceChannels[channel]->userInfo = source;
                SndPlay(audioSourceChannels[channel], (SndListHandle)sourceHandle, TRUE);

                soundCommand.cmd = callBackCmd;
                soundCommand.param1 = 0;
                soundCommand.param2 = 0;
                SndDoCommand(audioSourceChannels[channel], &soundCommand, FALSE);
                return;
            }
            channel = (channel + 1) % AUDIO_CHANNELS;
            channelsChecked++;
        }
    }
}

//-----------------------------------------------------------------------------
void audioStopSource(int16_t source) {
    int16_t i;

    for(i=0; i < AUDIO_CHANNELS; i++) {
        if(audioSourceChannels[i] && audioSourceChannels[i]->userInfo == source) {
            SndCommand soundCommand;
            soundCommand.cmd = quietCmd;
            soundCommand.param1 = 0;
            soundCommand.param2 = 0;
            SndDoImmediate(audioSourceChannels[i], &soundCommand);
            audioSourceChannels[i]->userInfo = -1;
            audioReleaseSourceIfIdle(source);
            break;
        }
    }
}
