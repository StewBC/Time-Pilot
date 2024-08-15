//-----------------------------------------------------------------------------
// input.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "mac.h"
#include "globals.h"

#include "data.h"
#include "input.h"
#include "text.h"
#include "ui.h"

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

//-----------------------------------------------------------------------------
void inputCheckForJoy(int16_t startStickNum) {

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
#endif
    if(inputUsingJoystick >= 0) {
        sprintf(TEXT_CONTROLSN, "%d", inputUsingJoystick);
    }
}

//-----------------------------------------------------------------------------
void inputInGame() {
    if(!--readFrameStall) {
        readFrameStall = KEY_READ_RATE;

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
uint16_t inputReadJoystick() {
    uint16_t joyMask = 0;

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
#endif
    }

    return joyMask;
}

//-----------------------------------------------------------------------------
void inputKeyDown(unsigned char key) {

    if(key > 65) {
        key &= ~32;
    }

    if(key == '[') {
        keyMask |= INPUT_ROTATE_LEFT;
        return;
    }

    if(key == ']') {
        keyMask |= INPUT_ROTATE_RIGHT;
        return;
    }

    if(key == 28 | key == 'A') {        // 28 = cursort left
        keyMask |= INPUT_LEFT;
        return;
    }

    if(key == 29 | key == 'D') {        // 29 = cursort right
        keyMask |= INPUT_RIGHT;
        return;
    }

    if(key == 30 | key == 'W') {        // 30 = cursort up
        keyMask |= INPUT_UP;
        return;
    }

    if(key == 31 | key == 'S') {        // 31 = cursort down
        keyMask |= INPUT_DOWN;
        return;
    }

    if(key == '1' || key == ' ') {
        keyMask |= INPUT_FIRE;
        return;
    }

    if(key == '2') {
        keyMask |= INPUT_2P;
        return;
    }

    if(key == 'P') {
        keyMask |= INPUT_PAUSE;
        return;
    }

    if(key == 27) {
        keyMask |= INPUT_QUIT;          // 27 = ESC
    }
}

//-----------------------------------------------------------------------------
void inputKeyUp(unsigned char key) {

    if(key > 65) {
        key &= ~32;
    }

    if(key == '[') {
        keyMask &= ~INPUT_ROTATE_LEFT;
        return;
    }

    if(key == ']') {
        keyMask &= ~INPUT_ROTATE_RIGHT;
        return;
    }

    if(key == 28 | key == 'A') {        // 28 = cursort left
        keyMask &= ~INPUT_LEFT;
        return;
    }

    if(key == 29 | key == 'D') {        // 29 = cursort right
        keyMask &= ~INPUT_RIGHT;
        return;
    }

    if(key == 30 | key == 'W') {        // 30 = cursort up
        keyMask &= ~INPUT_UP;
        return;
    }

    if(key == 31 | key == 'S') {        // 31 = cursort down
        keyMask &= ~INPUT_DOWN;
        return;
    }

    if(key == '1' || key == ' ') {
        keyMask &= ~INPUT_FIRE;
        return;
    }

    if(key == '2') {
        keyMask &= ~INPUT_2P;
        return;
    }

    if(key == 'P') {
        keyMask &= ~INPUT_PAUSE;
        return;
    }

    if(key == 27) {
        keyMask &= ~INPUT_QUIT;
    }
}
