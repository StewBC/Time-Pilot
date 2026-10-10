//-----------------------------------------------------------------------------
// game.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

void gameAddBonus(int32_t X, int32_t A);
void gameAddScore();
void gameAddScoreInternal(int32_t A);
void gameInit();
int32_t gameNextPlayer();
void gamePostFrame();
void gameProcessThings();
void gameRestorePlayer();
void gameSavePlayer();
void gameScoreCheckExtra(int32_t score);
void gameStageInit();
void gameStart();
