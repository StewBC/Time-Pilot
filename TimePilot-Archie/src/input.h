//-----------------------------------------------------------------------------
// input.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

void inputCheckForJoy(int32_t startStickNum);
void inputInGame();
void inputInUI();
uint32_t inputReadJoystick();
