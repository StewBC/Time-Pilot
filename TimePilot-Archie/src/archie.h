//-----------------------------------------------------------------------------
// archie.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

#include <stdbool.h>
#include <stdint.h>

#define UNUSED(x) ((void)(x))

typedef struct {
    int32_t top;
    int32_t left;
    int32_t bottom;
    int32_t right;
} Rect;

typedef struct {
    int32_t v;
    int32_t h;
} Point;

typedef int* WindowPtr;
typedef const uint32_t *Handle;

void archieAnimatePalette();
void archieBeginPlayfieldFrame(void);
void archieTransitionFill(const Rect *rect, uint32_t color);
void archieBlitToScreen(Rect *srcCopyRect);
void archieCleanup();
void archieClearScreen();
void archieFill(int32_t X, int32_t Y, int32_t W, int32_t H, uint32_t color);
void archieHideMenuBar(void);
int32_t archieInit();
uint8_t archieMapColor(uint32_t logicalColor);
uint32_t archieRepeatColor(uint32_t logicalColor);
unsigned char *archieScreenAddress(void);
void archieSetPaletteFromResource(int32_t res_id);
int32_t archieSetScale(int32_t scale);
int32_t archieShowErrorDialog(const char* errorMessage);
void archieShowMenuBar(void);
int32_t archieTrackDynamicRect(const Rect *rect);
void archieUpdate(WindowPtr screen);
