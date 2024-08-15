//-----------------------------------------------------------------------------
// ui.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

void uiErasePreGameLabels();
void uiGameOver();
void uiInit();                          // Only in "C" version returns a value
void uiJoyScan();
int16_t uiMain();
void uiPause();
int16_t uiPlay(uint16_t numPlayers);
void uiShowCommonLabels();
void uiShowHighScore();
void uiShowHighScoreTable();
void uiShowP1Score();
void uiShowP2Playing();
void uiShowP2Score();
void uiShowPlayerShips();
void uiShowPreGameLabels();
void uiShowStageIcon();
void uiShowStageProgress();
void uiShowTitle();
void uiUpdateStageProgress();
