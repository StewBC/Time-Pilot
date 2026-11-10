//-----------------------------------------------------------------------------
// AL/alut.h
// Minimal OpenAL/ALUT compatibility surface for the Time Pilot WebAssembly port.
//
// The desktop build links OpenAL Soft + freealut.  A browser has neither, so
// TimePilot-web provides this header and a Web Audio implementation of exactly
// the calls that TimePilot-16bit-C uses.  Keeping the ABI names identical
// means src/audio.c and src/data.c compile unmodified.
//-----------------------------------------------------------------------------
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

typedef unsigned int ALuint;
typedef int ALint;
typedef int ALenum;

#define AL_NO_ERROR             0
#define AL_BUFFER               0x1001
#define AL_LOOPING              0x1007
#define AL_SOURCE_STATE         0x1010
#define AL_STOPPED              0x1011
#define AL_PLAYING              0x1012
#define AL_TRUE                 1
#define AL_FALSE                0

void  alutInit(int *argc, char **argv);
void  alutExit(void);
ALuint alutCreateBufferFromFile(const char *fileName);

ALenum alGetError(void);

void alGenSources(ALint n, ALuint *sources);
void alDeleteSources(ALint n, const ALuint *sources);
void alSourcei(ALuint source, ALenum param, ALint value);
void alGetSourcei(ALuint source, ALenum param, ALuint *value);
void alSourcePlay(ALuint source);
void alSourceStop(ALuint source);

void alDeleteBuffers(ALint n, const ALuint *buffers);

#ifdef __cplusplus
}
#endif
