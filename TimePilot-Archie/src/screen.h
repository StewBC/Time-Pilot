//-----------------------------------------------------------------------------
// screen.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

void screenClearSection(uint32_t X, uint32_t Y, uint32_t W, uint32_t H, uint32_t color);
uint32_t screenClips(int32_t X);
void screenDrawLine(int32_t x0, int32_t y0, int32_t x1, int32_t y1);
void screenSetColPixel(int32_t x0, int32_t y0);
void screenSetPalette();
void screenTimeWarp();
void screenWipe();
void screenWipeToStageSky(uint32_t stage);
