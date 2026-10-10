//-----------------------------------------------------------------------------
// audio.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

// void audioCallback(SndChannelPtr theChan, SndCommand *theCmd);
void audioCleanup();
void audioInit();
int32_t audioIsSourcePlaying(int32_t source);
void audioPlaySource(int32_t source);
void audioStopSource(int32_t source);

// bossSource is a boss cue or -1; service once per gameplay frame.
void audioUpdateCombatLoop(int32_t bossSource, uint32_t rockets);
void audioRocketLaunched(void);
