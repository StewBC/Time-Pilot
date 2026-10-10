//-----------------------------------------------------------------------------
// data.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

typedef void (*jumpFunction)(int32_t X);
typedef void (*collideJumpFunction)(uint32_t colID0, uint32_t colID1);

extern jumpFunction sprite_draw[LAYER_NUM_LAYERS];
extern jumpFunction sprite_draw_dead[LAYER_NUM_LAYERS];
extern jumpFunction sprite_partial_draw[LAYER_NUM_LAYERS];
extern jumpFunction ai_handler[LAYER_NUM_LAYERS];
extern collideJumpFunction collision_handler[LAYER_NUM_LAYERS];

extern uint32_t layerCollides[LAYER_NUM_LAYERS];
extern uint32_t layerColsig[LAYER_NUM_LAYERS];
extern uint32_t layerFlags[LAYER_NUM_LAYERS];
extern uint32_t layerHeight[LAYER_NUM_LAYERS];
extern uint32_t layerWidth[LAYER_NUM_LAYERS];

#define NUM_SPAWN_LAYERS    9
extern const int32_t spawnLayer[NUM_SPAWN_LAYERS];
extern const int32_t spawnMinX[NUM_SPAWN_LAYERS];
extern const int32_t spawnMinY[NUM_SPAWN_LAYERS];
extern const int32_t spawnSpaceLayer[NUM_SPAWN_LAYERS];

extern const int32_t launchPosX[];
extern const int32_t launchPosY[];
extern const int32_t rays[32][32];
extern const int32_t velX[32 * VELOCITY_NUMBERS];
extern const int32_t velY[32 * VELOCITY_NUMBERS];

extern const int32_t bonusScores[NUM_SCORES];
extern const int32_t bossAnimFrames[4];
extern const uint32_t printColorLut[16];
extern const uint32_t explode_16x16_hold_table[4];
extern const uint32_t explode_32x16_hold_table[4];
extern const int32_t enemyStageStart[NUM_PERIODS];
extern const int32_t heliFrameMap[];
extern const uint32_t highScoreColorIndex[5];
extern const uint32_t highScoreInitialsY[5];
extern const uint32_t horizontalDirectionTable[];
extern const int32_t horizontalLaunchRayTable[];
extern const int32_t parachute_sprite_table[6];
extern const int32_t playerJoyAngles[16];
extern const int32_t stageBossAudio[5];
extern const uint32_t stageLabelColor[3];
extern const char **stageLabelText[5];
extern const int32_t timeWarpDrawScript[];
extern const int32_t timeWarpDrawX[13];

void dataCleanup();
int32_t dataInit();
