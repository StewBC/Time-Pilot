//-----------------------------------------------------------------------------
// screen.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

void screenCleanup();
void screenClearSection(uint8_t layer, uint8_t X, uint8_t Y, uint8_t W, uint8_t H, uint8_t color);
uint16_t screenClips(int8_t X);
void screenDrawLine(uint8_t X0, uint8_t y0, uint8_t X1, uint8_t y1, uint8_t color);
void screenInit();
void screenSetPalette();
void screenTimeWarp();
void screenWipe(uint8_t color);
void screenWipeToSkyColor(uint8_t pal);
