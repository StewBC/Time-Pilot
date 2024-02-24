//-----------------------------------------------------------------------------
// print.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

enum PRINT_FLAGS {
    PF_NONE       = 0,
    PF_CENTRE_X   = 0b001,
    PF_CENTRE_Y   = 0b010,
    PF_CENTRE     = PF_CENTRE_X | PF_CENTRE_Y,
    PF_RIGHT      = 0b100,
};

void printRectXY(int16_t X, int16_t Y, uint16_t flags, TPixel color, int16_t w);
void printXY(int16_t X, int16_t Y, uint16_t flags, TPixel color, const char *fmt, ...);
