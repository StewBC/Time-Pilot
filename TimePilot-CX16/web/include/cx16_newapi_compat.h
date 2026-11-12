//-----------------------------------------------------------------------------
// cx16_newapi_compat.h
// Web-only bridge between Time Pilot's older llvm-mos CX16 code and the current
// cx16.h API.
//
// Newer SDKs renamed the bank switch to RAM_BANK, stopped exposing the banked
// RAM window as RAM_BANK_RAM, and changed cx16_k_joystick_get() from returning
// an unsigned long bitmask to returning a JoyState struct.  Compile the CX16
// port with `-include cx16_newapi_compat.h` to keep the original game sources
// readable and unchanged for older SDK builds.
//-----------------------------------------------------------------------------
#pragma once

#include <cx16.h>
#include <stdint.h>

#ifdef RAM_BANK
#ifndef RAM_RAM_BANK
#define RAM_RAM_BANK RAM_BANK
#endif
#endif

#ifndef RAM_BANK_RAM
// The 8 KiB window into banked RAM on the Commander X16.
#define RAM_BANK_RAM ((volatile unsigned char *)0xA000)
#endif

// JoyState::detached was added with the struct return.  The old callers only
// need a 32-bit value where the high half says "no joystick" and the low 16
// bits are the active-low button mask.
static unsigned long tp_cx16_joy_legacy(unsigned char joystick_num) {
    JoyState state = cx16_k_joystick_get(joystick_num);
    // The old API returned 0xFFFF when no joystick was present.  Returning 0
    // here makes uiInit()'s "wait until the joystick is released" loop spin
    // forever in the browser (the emulator has no SNES-port hardware).
    if (state.detached) return 0xFFFFUL;
    return 0x10000UL | (unsigned long)state.data;
}

#define cx16_k_joystick_get(n) tp_cx16_joy_legacy(n)
