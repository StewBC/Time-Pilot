//-----------------------------------------------------------------------------
// data.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

typedef void (*jumpFunction)(int16_t X);
typedef void (*collideJumpFunction)(uint16_t colID0, uint16_t colID1);

extern jumpFunction sprite_draw[LAYER_NUM_LAYERS];
extern jumpFunction sprite_draw_dead[LAYER_NUM_LAYERS];
extern jumpFunction sprite_partial_draw[LAYER_NUM_LAYERS];
extern jumpFunction ai_handler[LAYER_NUM_LAYERS];
extern collideJumpFunction collision_handler[LAYER_NUM_LAYERS];

extern uint16_t layerCollides[LAYER_NUM_LAYERS];
extern uint16_t layerColsig[LAYER_NUM_LAYERS];
extern uint16_t layerFlags[LAYER_NUM_LAYERS];
extern uint16_t layerHeight[LAYER_NUM_LAYERS];
extern uint16_t layerWidth[LAYER_NUM_LAYERS];

#define NUM_SPAWN_LAYERS    9
extern const int16_t spawnLayer[NUM_SPAWN_LAYERS];
extern const int16_t spawnMinX[NUM_SPAWN_LAYERS];
extern const int16_t spawnMinY[NUM_SPAWN_LAYERS];
extern const int16_t spawnSpaceLayer[NUM_SPAWN_LAYERS];

extern const int16_t launchPosX[];
extern const int16_t launchPosY[];
extern const int16_t rays[32][32];
extern const uint16_t velXfrac[32 * VELOCITY_NUMBERS];
extern const uint16_t velXwhole[32 * VELOCITY_NUMBERS];
extern const uint16_t velYfrac[32 * VELOCITY_NUMBERS];
extern const uint16_t velYwhole[32 * VELOCITY_NUMBERS];

extern const int16_t bonusScores[NUM_SCORES];
extern const int16_t bossAnimFrames[4];
extern const uint32_t printColorLut[16];
extern const uint32_t colorPalette[TP_NUM_COLORS];
extern const uint16_t explode_16x16_hold_table[4];
extern const uint16_t explode_32x16_hold_table[4];
extern const int16_t enemyStageStart[NUM_PERIODS];
extern const int16_t heliFrameMap[];
extern const uint16_t highScoreColorIndex[5];
extern const uint16_t highScoreInitialsY[5];
extern const uint16_t horizontalDirectionTable[];
extern const int16_t horizontalLaunchRayTable[];
extern const int16_t parachute_sprite_table[6];
extern const int16_t playerJoyAngles[16];
extern const int16_t stageBossAudio[5];
extern const uint16_t stageLabelColor[3];
extern const char **stageLabelText[5];
extern const int16_t timeWarpDrawScript[];
extern const int16_t timeWarpDrawX[13];

void dataCleanup();
int16_t dataInit();
