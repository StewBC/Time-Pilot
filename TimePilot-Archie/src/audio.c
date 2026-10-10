//-----------------------------------------------------------------------------
// audio.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "archie.h"
#include "globals.h"
#include "resids.h"

#include "audio.h"
#include "audio_data.h"

#include <kernel.h>
#include <oslib/osmodule.h>
#include <oslib/sound.h>
#include <stdint.h>
#include <stdio.h>
#include <swis.h>

#define THSOUND_REMOVE_SAMPLE      0x4B781
#define THSOUND_GET_POLL_WORD      0x4B784
#define THSOUND_INSTALL_LINEAR     0x4B785

#define AUDIO_NONE                 (-1)
#define AUDIO_MAX_CHANNELS         4
#define AUDIO_LOOP_RESTART_FRAMES  10U // I prefer 0.2 s repeat at native 50 Hz.
#define AUDIO_SAMPLE_PERIOD_US     80 // 12.5 kHz output for 5.512 kHz source PCM.
#define AUDIO_SOURCE_COUNT         (AUDIO_WAVE_START + 1)
// Preserve sample speed at 80 us: 0x1700 + 4096*log2(80/48).
#define AUDIO_PLAYBACK_PITCH       0x22CBU
#define AUDIO_BASE_PITCH           0x2000U
#define AUDIO_STOP_PITCH           0x4000U
#define AUDIO_DEFAULT_DURATION     0x00FFU
#define AUDIO_CLEANUP_SPIN_LIMIT   200000U
#define AUDIO_AMP_LOUD             0x017FU
#define AUDIO_AMP_MEDIUM           0x0168U
#define AUDIO_AMP_SOFT             0x0140U
#define AUDIO_AMP_TUNE             0x017FU

typedef struct {
    uint16_t amplitude;
    uint8_t preferredChannel;
    uint8_t loops;
    uint8_t forcePreferred;
    uint8_t singleInstance;
} tAudioCue;

typedef struct {
    int32_t source;
    uint32_t endFrame;
    uint8_t loops;
} tAudioChannelState;

typedef struct {
    int8_t *rmaData;
    uint32_t rmaBytes;
    int handle;
    int voiceSlot;
    volatile int *pollWord;
} tAudioSampleState;

static const tAudioCue audioCues[AUDIO_SOURCE_COUNT] = {
    {AUDIO_AMP_LOUD,   2, 0, 0, 0}, // BIG_EXPLOSION
    {AUDIO_AMP_MEDIUM, 2, 0, 0, 0}, // BOMB
    {AUDIO_AMP_TUNE,   1, 1, 1, 1}, // BOSSL0
    {AUDIO_AMP_TUNE,   1, 1, 1, 1}, // BOSSL1
    {AUDIO_AMP_TUNE,   1, 1, 1, 1}, // BOSSL2
    {AUDIO_AMP_TUNE,   1, 1, 1, 1}, // BOSSL3
    {AUDIO_AMP_MEDIUM, 2, 0, 0, 0}, // COINDROP
    {AUDIO_AMP_LOUD,   3, 0, 0, 0}, // ENEMY_EXPLODE
    {AUDIO_AMP_MEDIUM, 3, 0, 0, 0}, // ENEMY_SHOOT
    {AUDIO_AMP_LOUD,   3, 0, 0, 0}, // EXTRA_LIFE
    {AUDIO_AMP_TUNE,   1, 0, 1, 1}, // GAME_START
    {AUDIO_AMP_TUNE,   1, 0, 1, 1}, // HIGHSCORE
    {AUDIO_AMP_TUNE,   2, 0, 1, 1}, // NEXT_LEVEL
    {AUDIO_AMP_LOUD,   2, 0, 0, 0}, // PICKUP
    {0x0130U,          4, 0, 1, 1}, // PLAYER_SHOOT: quiet, dedicated channel
    {AUDIO_AMP_TUNE,   1, 1, 1, 1}, // ROCKET_FLY
    {AUDIO_AMP_LOUD,   3, 0, 0, 0}, // ROCKET_LAUNCH
    {AUDIO_AMP_TUNE,   1, 0, 1, 1}, // TIMEWARP
    {AUDIO_AMP_LOUD,   3, 0, 0, 0}, // WAPON_EXPLODE
    {AUDIO_AMP_TUNE,   2, 0, 1, 1}, // WAVE_START
};

static tAudioChannelState audioChannels[AUDIO_MAX_CHANNELS];
static tAudioSampleState audioSamples[AUDIO_SOURCE_COUNT];
static uint32_t audioNextOneShotChannel;
static uint32_t audioRocketRetrigger;
static sound_state audioPreviousSpeaker = sound_STATE_READ;
static sound_state audioPreviousEnable = sound_STATE_READ;
static uint32_t audioEnvironmentChanged;
static _kernel_swi_regs audioPreviousConfig;
static uint32_t audioConfigChanged;
static int audioPreviousVolume;
static uint32_t audioVolumeChanged;

static uint32_t audioPriority(int32_t source) {
    if(source == AUDIO_BIG_EXPLOSION) return 3;
    if(source == AUDIO_ENEMY_EXPLODE || source == AUDIO_WAPON_EXPLODE ||
       source == AUDIO_EXTRA_LIFE) return 2;
    return 1;
}

//-----------------------------------------------------------------------------
static void audioResetChannel(uint32_t channelIndex) {
    audioChannels[channelIndex].source = AUDIO_NONE;
    audioChannels[channelIndex].endFrame = 0;
    audioChannels[channelIndex].loops = 0;
}

//-----------------------------------------------------------------------------
static int8_t *audioCopyToRma(const tpaAudioSample *sample, uint32_t *sizeOut) {
    uint32_t paddedSize;
    uint32_t i;
    int8_t *buffer;

    paddedSize = (sample->length + 3U) & ~3U;
    if(xosmodule_alloc((int)paddedSize, (void **)&buffer) || !buffer) {
        return 0;
    }

    for(i = 0; i < sample->length; i++) {
        buffer[i] = sample->data[i];
    }
    for(; i < paddedSize; i++) {
        buffer[i] = 0;
    }

    *sizeOut = paddedSize;
    return buffer;
}

//-----------------------------------------------------------------------------
static _kernel_oserror *audioTHSoundInstallLinear(const int8_t *data, uint32_t size,
                                                  int requestedSlot, int *handleOut,
                                                  int *voiceSlotOut) {
    _kernel_swi_regs regs;

    regs.r[0] = (int)data;
    regs.r[1] = (int)size;
    regs.r[2] = requestedSlot;
    {
        _kernel_oserror *error = _kernel_swi(THSOUND_INSTALL_LINEAR, &regs, &regs);
        if(error) {
            return error;
        }
    }

    *handleOut = regs.r[0];
    *voiceSlotOut = regs.r[1];
    return 0;
}

//-----------------------------------------------------------------------------
static _kernel_oserror *audioTHSoundGetPollWord(int handle, volatile int **pollWordOut) {
    _kernel_swi_regs regs;

    regs.r[0] = handle;
    {
        _kernel_oserror *error = _kernel_swi(THSOUND_GET_POLL_WORD, &regs, &regs);
        if(error) {
            return error;
        }
    }

    *pollWordOut = (volatile int *)regs.r[1];
    return 0;
}

//-----------------------------------------------------------------------------
static _kernel_oserror *audioTHSoundRemoveSample(int handle) {
    _kernel_swi_regs regs;

    regs.r[0] = handle;
    return _kernel_swi(THSOUND_REMOVE_SAMPLE, &regs, &regs);
}

//-----------------------------------------------------------------------------
static uint32_t audioChannelForSource(int32_t source) {
    uint32_t i;

    for(i = 0; i < AUDIO_MAX_CHANNELS; i++) {
        if(audioChannels[i].source == source) {
            return i;
        }
    }

    return UINT32_MAX;
}

//-----------------------------------------------------------------------------
static void audioWaitForSampleStop(int32_t source) {
    uint32_t spin;
    volatile int *pollWord;

    if(source < 0 || source >= AUDIO_SOURCE_COUNT) {
        return;
    }

    pollWord = audioSamples[source].pollWord;
    if(!pollWord) {
        return;
    }

    for(spin = 0; spin < AUDIO_CLEANUP_SPIN_LIMIT; spin++) {
        if(*pollWord != 0) {
            break;
        }
    }
}

//-----------------------------------------------------------------------------
static void audioStopChannel(uint32_t channelIndex) {
    sound_control((int)channelIndex + 1, 0, AUDIO_STOP_PITCH, 1);
    // Samples stay installed during play; attaching the replacement detaches
    // the previous voice. Completion waits are only needed before release.
    audioResetChannel(channelIndex);
}

//-----------------------------------------------------------------------------
static void audioExpireFinishedVoices(void) {
    uint32_t i;

    for(i = 0; i < AUDIO_MAX_CHANNELS; i++) {
        int32_t source;

        source = audioChannels[i].source;
        if(source != AUDIO_NONE && !audioChannels[i].loops && audioSamples[source].pollWord && *audioSamples[source].pollWord != 0) {
            audioStopChannel(i);
        }
    }
}

//-----------------------------------------------------------------------------
static void audioReleaseSamples(void) {
    uint32_t i;

    for(i = 0; i < AUDIO_SOURCE_COUNT; i++) {
        if(audioSamples[i].handle) {
            if(audioTHSoundRemoveSample(audioSamples[i].handle)) {
                // Removal can invalidate the descriptor even on error. Never
                // retry that handle or read its poll word; retain sample storage
                // conservatively because a voice may still reference it.
                audioSamples[i].handle = 0;
                audioSamples[i].pollWord = 0;
                audioSamples[i].rmaData = 0;
                audioSamples[i].rmaBytes = 0;
                audioSamples[i].voiceSlot = 0;
                continue;
            }
        }
        if(audioSamples[i].rmaData) {
            xosmodule_free(audioSamples[i].rmaData);
        }
        audioSamples[i].rmaData = 0;
        audioSamples[i].rmaBytes = 0;
        audioSamples[i].handle = 0;
        audioSamples[i].voiceSlot = 0;
        audioSamples[i].pollWord = 0;
    }
}

//-----------------------------------------------------------------------------
void audioCleanup() {
    uint32_t i;
    sound_state speakerStateOut = sound_STATE_READ;
    sound_state soundStateOut = sound_STATE_READ;

    if(audioIsInit) {
        for(i = 0; i < AUDIO_MAX_CHANNELS; i++) {
            audioStopChannel(i);
        }
    }

    for(i = 0; i < AUDIO_SOURCE_COUNT; i++) {
        if(audioSamples[i].handle) audioWaitForSampleStop((int32_t)i);
    }
    audioReleaseSamples();
    if(audioVolumeChanged) {
        int ignored;
        xsound_volume(audioPreviousVolume, &ignored);
        audioVolumeChanged = 0;
    }
    if(audioConfigChanged) {
        _kernel_swi_regs regs = audioPreviousConfig;
        _kernel_swi(Sound_Configure, &regs, &regs);
        audioConfigChanged = 0;
    }
    if(audioEnvironmentChanged) {
        xsound_enable(audioPreviousEnable, &soundStateOut);
        xsound_speaker(audioPreviousSpeaker, &speakerStateOut);
        audioEnvironmentChanged = 0;
    }
    audioIsInit = 0;
}

//-----------------------------------------------------------------------------
void audioInit() {
    uint32_t i;
    os_error *soundError;
    sound_state speakerStateOut = sound_STATE_READ;
    sound_state soundStateOut = sound_STATE_READ;

    for(i = 0; i < AUDIO_MAX_CHANNELS; i++) {
        audioResetChannel(i);
    }
    for(i = 0; i < AUDIO_SOURCE_COUNT; i++) {
        _kernel_oserror *error;

        audioSamples[i].rmaData = audioCopyToRma(&tpaAudioSamples[i], &audioSamples[i].rmaBytes);
        if(!audioSamples[i].rmaData) {
            audioReleaseSamples();
            return;
        }

        error = audioTHSoundInstallLinear(audioSamples[i].rmaData, audioSamples[i].rmaBytes, 0,
                                          &audioSamples[i].handle, &audioSamples[i].voiceSlot);
        if(error) {
            audioReleaseSamples();
            return;
        }

        error = audioTHSoundGetPollWord(audioSamples[i].handle, &audioSamples[i].pollWord);
        if(error) {
            audioReleaseSamples();
            return;
        }

        if(audioSamples[i].pollWord) {
            *audioSamples[i].pollWord = 1;
        }
    }

    audioNextOneShotChannel = 0;
    audioRocketRetrigger = 0;
    audio_channel = 0;
    audioIsInit = 0;

    if(xsound_speaker(sound_STATE_READ, &audioPreviousSpeaker) ||
       xsound_enable(sound_STATE_READ, &audioPreviousEnable)) {
        audioReleaseSamples();
        return;
    }
    audioEnvironmentChanged = 1;
    soundError = xsound_speaker(sound_STATE_ON, &speakerStateOut);
    if(soundError) {
        audioCleanup();
        return;
    }

    soundError = xsound_enable(sound_STATE_ON, &soundStateOut);
    if(soundError) {
        audioCleanup();
        return;
    }

    {
        _kernel_swi_regs regs;
        regs.r[0] = AUDIO_MAX_CHANNELS;
        regs.r[2] = AUDIO_SAMPLE_PERIOD_US;
        regs.r[1] = regs.r[3] = regs.r[4] = 0;
        if(_kernel_swi(Sound_Configure, &regs, &regs)) {
            audioCleanup();
            return;
        }
        audioPreviousConfig = regs;
        audioConfigChanged = 1;
    }

    {
        int ignored, volume;
        if(!xsound_volume(0, &audioPreviousVolume)) {
            volume = audioPreviousVolume + 16;
            if(volume > 127) volume = 127;
            if(!xsound_volume(volume, &ignored)) audioVolumeChanged = 1;
        }
    }

    for(i = 0; i < AUDIO_MAX_CHANNELS; i++) {
        sound_stereo((int)i + 1, ((int)i * 7) - 24);
    }

    audioIsInit = 1;
}

//-----------------------------------------------------------------------------
int32_t audioIsSourcePlaying(int32_t source) {
    audioExpireFinishedVoices();
    return audioChannelForSource(source) != UINT32_MAX;
}

// Direct THSound restart: attach/reset the selected voice, then gate it on.
// No preceding Sound_Control stop or completion-poll wait for loop repeats.
static void audioStartNative(int32_t source, uint32_t channelIndex) {
    const tAudioCue *cue = &audioCues[source];
    const tAudioSampleState *sampleState = &audioSamples[source];
    os_error *soundError;
    int attachChannelOut = 0, attachVoiceOut = 0;
    if(!sampleState->handle) return;
    soundError = xsound_attach_voice((int)channelIndex + 1, sampleState->voiceSlot,
                                     &attachChannelOut, &attachVoiceOut);
    if(soundError) {
        if(sampleState->pollWord) {
            *sampleState->pollWord = 1;
        }
        return;
    }

    if(sampleState->pollWord) *sampleState->pollWord = 0;
    soundError = xsound_control((int)channelIndex + 1, cue->amplitude,
                                (int)AUDIO_PLAYBACK_PITCH, AUDIO_DEFAULT_DURATION);
    if(soundError) {
        if(sampleState->pollWord) {
            *sampleState->pollWord = 1;
        }
        return;
    }

    audioChannels[channelIndex].source = source;
    audioChannels[channelIndex].loops = cue->loops;
    audioChannels[channelIndex].endFrame = cue->loops ? frameCounter + AUDIO_LOOP_RESTART_FRAMES : frameCounter + 1;
}

void audioRocketLaunched(void) { audioRocketRetrigger = 1; }

void audioUpdateCombatLoop(int32_t bossSource, uint32_t rockets) {
    int32_t target = AUDIO_NONE;
    if(bossSource >= AUDIO_BOSSL0 && bossSource <= AUDIO_BOSSL3) target = bossSource;
    else if(rockets) target = AUDIO_ROCKET_FLY;
    if(!audioIsInit) { audioRocketRetrigger = 0; return; }
    if(target == AUDIO_NONE) {
        if(audioChannels[0].loops) audioStopChannel(0);
    } else if(audioChannels[0].source != target ||
              (target == AUDIO_ROCKET_FLY && audioRocketRetrigger) ||
              (int32_t)(frameCounter - audioChannels[0].endFrame) >= 0) {
        audioStartNative(target, 0);
    }
    audioRocketRetrigger = 0;
}

//-----------------------------------------------------------------------------
void audioPlaySource(int32_t source) {
    uint32_t channelIndex;
    const tAudioCue *cue;
    const tAudioSampleState *sampleState;
    if(!audioIsInit || source < 0 || source >= AUDIO_SOURCE_COUNT) {
        return;
    }

    audioExpireFinishedVoices();
    cue = &audioCues[source];
    sampleState = &audioSamples[source];
    if(!sampleState->handle) {
        return;
    }

    if(cue->loops) {
        // Gameplay owns rocket retriggers and boss priority through the service.
        if(source == AUDIO_ROCKET_FLY && audioChannels[0].source >= AUDIO_BOSSL0 &&
           audioChannels[0].source <= AUDIO_BOSSL3) return;
        if(audioChannels[0].source != source) audioStartNative(source, 0);
        return;
    }

    if(cue->singleInstance && audioChannelForSource(source) != UINT32_MAX) {
        return;
    }

    {
        uint32_t previousChannel = audioChannelForSource(source);
        if(previousChannel != UINT32_MAX) {
            if(source == AUDIO_BIG_EXPLOSION || source == AUDIO_ENEMY_EXPLODE ||
               source == AUDIO_WAPON_EXPLODE) {
                // Restart in place: never attach this single sample voice to
                // another channel while its previous instance remains attached.
                audioStartNative(source, previousChannel);
                return;
            }
            audioStopChannel(previousChannel);
        }
    }

    if(cue->forcePreferred) {
        channelIndex = cue->preferredChannel - 1;
        if(audioChannels[channelIndex].source == source) {
            return;
        }
        audioStopChannel(channelIndex);
    } else {
        // Reserve channel 1 for music/loops and channel 4 for player fire.
        // Use idle effect channels first; weak effects cannot cut explosions.
        uint32_t other;
        channelIndex = 1U + (audioNextOneShotChannel % 2U);
        audioNextOneShotChannel++;
        other = channelIndex == 1U ? 2U : 1U;
        if(audioChannels[other].source == AUDIO_NONE ||
           (audioChannels[channelIndex].source != AUDIO_NONE &&
            audioPriority(audioChannels[other].source) < audioPriority(audioChannels[channelIndex].source)))
            channelIndex = other;
        if(audioChannels[channelIndex].source != AUDIO_NONE &&
           audioPriority(audioChannels[channelIndex].source) > audioPriority(source)) return;
        audioStopChannel(channelIndex);
    }

    audioStartNative(source, channelIndex);
}

//-----------------------------------------------------------------------------
void audioStopSource(int32_t source) {
    uint32_t channelIndex;

    channelIndex = audioChannelForSource(source);
    if(channelIndex != UINT32_MAX) {
        audioStopChannel(channelIndex);
    }
}
