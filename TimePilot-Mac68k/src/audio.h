//-----------------------------------------------------------------------------
// audio.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

void audioCallback(SndChannelPtr theChan, SndCommand *theCmd);
void audioCleanup();
void audioInit();
int16_t audioIsSourcePlaying(int16_t source);
void audioPlaySource(int16_t source);
void audioStopSource(int16_t source);
