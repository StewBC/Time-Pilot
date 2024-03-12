//-----------------------------------------------------------------------------
// things.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

uint16_t thingsAdd(uint16_t Y);
void thingsSortAndCollide();
void thingsSortOverlapByLayer(int16_t start, int16_t end);
