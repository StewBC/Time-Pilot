//-----------------------------------------------------------------------------
// screen.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

void screenClearSection(uint16_t X, uint16_t Y, uint16_t W, uint16_t H, TPixel color);
uint16_t screenClips(int16_t X);
void screenDrawLine(int16_t x0, int16_t y0, int16_t x1, int16_t y1);
void screenSetColPixel(int16_t x0, int16_t y0);
void screenSetPalette();
void screenTimeWarp();
void screenWipe();
void screenWipeToSkyColor(uint16_t pal);
