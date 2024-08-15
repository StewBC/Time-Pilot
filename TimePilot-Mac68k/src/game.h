//-----------------------------------------------------------------------------
// game.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

void gameAddBonus(int16_t X, int16_t A);
void gameAddScore();
void gameAddScoreInternal(int16_t A);
void gameInit();
int16_t gameNextPlayer();
void gamePostFrame();
void gameProcessThings();
void gameRestorePlayer();
void gameSavePlayer();
void gameScoreCheckExtra(int16_t score);
void gameStageInit();
void gameStart();
