//-----------------------------------------------------------------------------
// input.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

void inputCheckForJoy(int16_t startStickNum);
void inputInGame();
void inputInUI();
uint16_t inputReadJoystick();
uint16_t inputReadKeyboard();