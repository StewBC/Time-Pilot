//-----------------------------------------------------------------------------
// audio.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

void audioCleanup();
void audioInit();
int8_t audioIsSourcePlaying(int8_t source);
void audioPlaySource(int8_t source);
void audioServiceAudio();
void audioStopSource(int8_t source);
