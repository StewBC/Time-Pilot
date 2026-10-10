//-----------------------------------------------------------------------------
// input.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "archie.h"
#include "globals.h"

#include "data.h"
#include "input.h"
#include "text.h"
#include "ui.h"

#include <archie/keyboard.h>
#include <kernel.h>
#include <swis.h>

#include <stdio.h>

#ifdef RECORD_REPLAY
#include "print.h"
#include "screen.h"
#endif

#ifdef WIN32
#include <math.h>
#include <windows.h>
#include <xinput.h>
XINPUT_STATE state;
#define INPUT_THRESHOLD 0.5f
#endif

#define ARCHIE_JOYSTICK_READ 0x43F40
#define ARCHIE_JOYSTICK_DEADZONE 32

//-----------------------------------------------------------------------------
static uint32_t inputReadKeyboard(void) {
#ifdef WIN32
    return keyMask;
#else
    uint32_t mask = 0;

    if(k_checkKeypress(KEY_LEFT) || k_checkKeypress(KEY_A)) {
        mask |= INPUT_LEFT;
    }
    if(k_checkKeypress(KEY_RIGHT) || k_checkKeypress(KEY_D)) {
        mask |= INPUT_RIGHT;
    }
    if(k_checkKeypress(KEY_UP) || k_checkKeypress(KEY_W)) {
        mask |= INPUT_UP;
    }
    if(k_checkKeypress(KEY_DOWN) || k_checkKeypress(KEY_S)) {
        mask |= INPUT_DOWN;
    }
    if(k_checkKeypress(KEY_SQUAREBRACKETSTART)) {
        mask |= INPUT_ROTATE_LEFT;
    }
    if(k_checkKeypress(KEY_SQUAREBRACKETEND)) {
        mask |= INPUT_ROTATE_RIGHT;
    }
    if(k_checkKeypress(KEY_SPACE) || k_checkKeypress(KEY_1)) {
        mask |= INPUT_FIRE;
    }
    if(k_checkKeypress(KEY_2)) {
        mask |= INPUT_2P;
    }
    if(k_checkKeypress(KEY_P)) {
        mask |= INPUT_PAUSE;
    }
    if(k_checkKeypress(KEY_ESC)) {
        mask |= INPUT_QUIT;
    }

    return mask;
#endif
}

// Poll physical keys on rising edges; this works without a desktop event loop.
static void inputReadCharacters(void) {
    static const uint8_t keys[] = {
        KEY_A, KEY_B, KEY_C, KEY_D, KEY_E, KEY_F, KEY_G, KEY_H, KEY_I,
        KEY_J, KEY_K, KEY_L, KEY_M, KEY_N, KEY_O, KEY_P, KEY_Q, KEY_R,
        KEY_S, KEY_T, KEY_U, KEY_V, KEY_W, KEY_X, KEY_Y, KEY_Z, KEY_PERIOD
    };
    static uint32_t previous;
    uint32_t held = 0;
    uint32_t i;

    rawKey = 0;
    for(i = 0; i < sizeof(keys) / sizeof(keys[0]); i++) {
        uint32_t bit = 1U << i;
        if(k_checkKeypress(keys[i])) {
            held |= bit;
            if(!(previous & bit) && !rawKey) {
                rawKey = i == 26 ? '.' : 'a' + (int32_t)i;
            }
        }
    }
    previous = held;
}

//-----------------------------------------------------------------------------
void inputCheckForJoy(int32_t startStickNum) {

#ifdef WIN32
    inputUsingJoystick = -1;

    for(DWORD i = startStickNum; i < XUSER_MAX_COUNT; i++) {
        // XINPUT_STATE state;
        ZeroMemory(&state, sizeof(XINPUT_STATE));

        if(XInputGetState(i, &state) == ERROR_SUCCESS) {
            inputUsingJoystick = i;
            break;
        }
    }
#else
    _kernel_oserror *error;
    _kernel_swi_regs regs;

    inputUsingJoystick = -1;
    regs.r[0] = startStickNum;
    error = _kernel_swi(ARCHIE_JOYSTICK_READ, &regs, &regs);
    if(!error) {
        inputUsingJoystick = startStickNum;
    }
#endif
    if(inputUsingJoystick >= 0) {
        sprintf(TEXT_CONTROLSN, "%ld", inputUsingJoystick);
    }
}

//-----------------------------------------------------------------------------
void inputInGame() {
    if(!--readFrameStall) {
        readFrameStall = KEY_READ_RATE;

        keyMask = inputReadKeyboard();
        inputMask = keyMask | inputReadJoystick();
#ifdef RECORD_REPLAY
        if(demoRecordMode) {
            demoAttractBuffer[demoAttractLength++] = inputMask & 0xff;
            if(demoAttractLength == sizeof(demoAttractBuffer)) {
                inputMask = INPUT_QUIT;
            }
            screenClearSection(0, 0, 5, 1, TP_COLOR_SKY1);
            printXY(0, 0, 0, TP_COLOR_YELLOW, "%d", demoAttractLength);
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
            uint32_t angle = inputMask & 15;
            if(angle) {
                uint32_t desiredPlayerAngle = playerJoyAngles[angle];

                // if(desiredPlayerAngle >= 0 && desiredPlayerAngle != playerAngle) {
                if(desiredPlayerAngle != playerAngle) {
                    desiredPlayerAngle = (desiredPlayerAngle - playerAngle) & 31;
                    if(desiredPlayerAngle & 16) {
                        inputMask |= INPUT_ROTATE_LEFT;
                    } else {
                        inputMask |= INPUT_ROTATE_RIGHT;
                    }
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
        if(keyMask & INPUT_FIRE || inputMaskDebounced & INPUT_FIRE) {
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
    inputReadCharacters();
    keyMask = inputReadKeyboard();
    inputMask = keyMask | inputReadJoystick();
    // debugLog("%ld", inputMask);

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
uint32_t inputReadJoystick() {
    uint32_t joyMask = 0;

    if(inputUsingJoystick >= 0) {
#if WIN32
        if(XInputGetState(inputUsingJoystick, &state) == ERROR_SUCCESS) {
            float tlX = state.Gamepad.sThumbLX;
            float tlY = state.Gamepad.sThumbLY;

            // normalized controller direction
            float nX = tlX / 32767.0f;
            float nY = tlY / 32767.0f;

            // range controller is pushed
            float r = sqrt(nX * nX + nY * nY);

            // does the controller trigger motion
            if(r > INPUT_THRESHOLD) {
                // far enough on any axis, mark that axis
                if(nX > INPUT_THRESHOLD) {
                    joyMask |= INPUT_RIGHT;
                } else if(nX < -INPUT_THRESHOLD) {
                    joyMask |= INPUT_LEFT;
                }

                if(nY > INPUT_THRESHOLD) {
                    joyMask |= INPUT_UP;
                } else if(nY < -INPUT_THRESHOLD) {
                    joyMask |= INPUT_DOWN;
                }
            }

            joyMask |= state.Gamepad.wButtons & (XINPUT_GAMEPAD_A | XINPUT_GAMEPAD_B) ? INPUT_FIRE : 0;
            joyMask |= state.Gamepad.wButtons & (XINPUT_GAMEPAD_X | XINPUT_GAMEPAD_Y) ? INPUT_2P : 0;
            joyMask |= state.Gamepad.wButtons & (XINPUT_GAMEPAD_START) ? INPUT_PAUSE : 0;
            joyMask |= state.Gamepad.wButtons & (XINPUT_GAMEPAD_BACK) ? INPUT_QUIT : 0;
        }
#else
        _kernel_oserror *error;
        _kernel_swi_regs regs;
        int32_t axisY;
        int32_t axisX;
        uint32_t buttons;

        regs.r[0] = inputUsingJoystick;
        error = _kernel_swi(ARCHIE_JOYSTICK_READ, &regs, &regs);
        if(error) {
            inputUsingJoystick = -1;
            return 0;
        }

        axisY = (int8_t)(regs.r[0] & 0xff);
        axisX = (int8_t)((regs.r[0] >> 8) & 0xff);
        buttons = (uint32_t)((regs.r[0] >> 16) & 0xff);

        if(axisX <= -ARCHIE_JOYSTICK_DEADZONE) {
            joyMask |= INPUT_LEFT;
        } else if(axisX >= ARCHIE_JOYSTICK_DEADZONE) {
            joyMask |= INPUT_RIGHT;
        }

        if(axisY <= -ARCHIE_JOYSTICK_DEADZONE) {
            joyMask |= INPUT_DOWN;
        } else if(axisY >= ARCHIE_JOYSTICK_DEADZONE) {
            joyMask |= INPUT_UP;
        }

        if(buttons & 0x01) {
            joyMask |= INPUT_FIRE;
        }
        if(buttons & 0x02) {
            joyMask |= INPUT_2P;
        }
#endif
    }

    return joyMask;
}
