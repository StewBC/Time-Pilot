//-----------------------------------------------------------------------------
// mac.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

#include <Palettes.h>
#include <QDOffscreen.h>
#include <Quickdraw.h>
#include <Resources.h>
#include <Sound.h>

void macAnimatePalette();
void macBlitToScreen(Rect *srcCopyRect);
void macCleanup();
void macClearScreen();
void macFill(int16_t X, int16_t Y, int16_t W, int16_t H, uint16_t color);
void macHideMenuBar(void);
int16_t macInit();
void macSetPaletteFromResource(int16_t res_id);
int16_t macSetScale(int16_t scale);
int16_t macShowErrorDialog(const char* errorMessage);
void macShowMenuBar(void);
void macUpdate(WindowPtr screen);