//-----------------------------------------------------------------------------
// input.c
// Part of Time Pilot, the 1982 arcade game remake for the Commander X16
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include <stdint.h>
#include "globals.h"

#include "data.h"
#include "input.h"
#include "text.h"
#include "ui.h"

#include <cbm.h>
#include <cx16.h>
#include <stdio.h>

#ifdef RECORD_REPLAY
#include "print.h"
#endif

//-----------------------------------------------------------------------------
void inputCheckForJoy(int8_t stickNum) {
    inputUsingJoystick = 0;

    for(; stickNum < 4; stickNum++)
    {
        if(!(cx16_k_joystick_get(stickNum) & 0xFFFF0000)) {
            inputUsingJoystick = stickNum;
            break;
        }
    }
    sprintf(TEXT_CONTROLSN, "%d", inputUsingJoystick);
}

//-----------------------------------------------------------------------------
void inputInGame() {
    uint16_t kbdMask;

    if(!--readFrameStall) {
        readFrameStall = KEY_READ_RATE;

        kbdMask = inputReadKeyboard();
        inputMask = kbdMask | inputReadJoystick();
#ifdef RECORD_REPLAY
        if(demoRecordMode) {
            demoAttractBuffer[demoAttractLength++] = inputMask & 0xff;
            if(demoAttractLength == sizeof(demoAttractBuffer)) {
                inputMask = INPUT_QUIT;
            }
            printXY(1,0,0,0,TP_COLOR_YELLOW, "%d", demoAttractLength);
        } else
#endif        
        {
            if(demoAttractMode) {
                if(inputMask) {
                    inputMask = INPUT_QUIT;
                } else {
                    inputMask = demoAttractBuffer[demoAttractIndex++];
                    if(demoAttractIndex == demoAttractLength) {
                        inputMask = INPUT_QUIT;
                    }
                }
            }
        }
        inputMaskDebounced = (inputMask ^ inputMaskPrev) & inputMask;
        inputMaskPrev = inputMask;

        if(inputMask & INPUT_MASK_MOVEMENT) {
            int16_t desiredPlayerAngle = playerJoyAngles[inputMask & 15];

            if(desiredPlayerAngle >= 0 && desiredPlayerAngle != playerAngle) {
                desiredPlayerAngle = (desiredPlayerAngle - playerAngle) & 31;
                if(desiredPlayerAngle & 16) {
                    inputMask |= INPUT_ROTATE_LEFT;
                } else {
                    inputMask |= INPUT_ROTATE_RIGHT;
                }
            }
        }

        if(inputMask & INPUT_ROTATE_LEFT) {
            playerAngle = (playerAngle - 1) & 31;
        }

        if(inputMask & INPUT_ROTATE_RIGHT) {
            playerAngle = (playerAngle + 1) & 31;
        }

        // fire on kbd is not debounced because that just sucks
        if(kbdMask & INPUT_FIRE || inputMaskDebounced & INPUT_FIRE) {
            if(!bulletTimer) {
                bulletTimer = PLAYER_BULLET_FIRE_TIMER;
            }
        }

        if(inputMaskDebounced & INPUT_PAUSE) {
            uiPause();
        }

        if(inputMask & INPUT_QUIT) {
            exitGameMask |= EXIT_USER_QUIT;
        }
    }
}

//-----------------------------------------------------------------------------
// This has auto-repeat on the debounced directtion keys
void inputInUI() {
    inputMask = inputReadKeyboard() | inputReadJoystick();

    // This is 1-shot
    inputMaskDebounced = (inputMask ^ inputMaskPrev) & inputMask;
    // This is an auto-repeat mask
    inputMaskRepeat = inputMask;

    if(inputMask & inputMaskPrev) {
        if(inputRepeatRate) {
            inputMaskRepeat &= ~inputMaskPrev;
            inputRepeatRate--;
        } else {
            inputRepeatRate = INPUT_REPEAT_RATE;
        }
    } else {
        inputRepeatRate = INPUT_REPEAT_RATE;
    }

    // This is used to 1-shot and auto-repeat the input
    inputMaskPrev = inputMask;
}

//-----------------------------------------------------------------------------
uint16_t inputReadJoystick() {
    uint16_t joyMask = 0;
    uint16_t joy = cx16_k_joystick_get(inputUsingJoystick) ^ 0xFFFF;

    joyMask |= joy & TP_GAMEPAD_LEFT ? INPUT_LEFT : 0;
    joyMask |= joy & TP_GAMEPAD_RIGHT ? INPUT_RIGHT : 0;
    joyMask |= joy & TP_GAMEPAD_UP ? INPUT_UP : 0;
    joyMask |= joy & TP_GAMEPAD_DOWN ? INPUT_DOWN : 0;
    joyMask |= joy & TP_GAMEPAD_START ? INPUT_PAUSE : 0;
    joyMask |= joy & TP_GAMEPAD_BACK ? INPUT_QUIT : 0;
    joyMask |= joy & (TP_GAMEPAD_A | TP_GAMEPAD_B) ? INPUT_FIRE : 0;
    joyMask |= joy & (TP_GAMEPAD_X | TP_GAMEPAD_Y) ? INPUT_2P : 0;

    return joyMask;
}

//-----------------------------------------------------------------------------
uint16_t inputReadKeyboard() {
    int16_t keyMask = 0;

    int8_t key = cbm_k_getin();
    if(key) {
        if(key == '1' || key == ' ') {
            keyMask |= INPUT_FIRE;
        }

        if(key == '2') {
            keyMask |= INPUT_2P;
        }

        if(key == 27) {
            keyMask |= INPUT_QUIT;
        }

        key &= 0x5F;

        if(key == 'P') {
            keyMask |= INPUT_PAUSE;
        }

        if(key == 'J') {
            keyMask |= INPUT_SCAN;
        }

    }

    return keyMask;
}
