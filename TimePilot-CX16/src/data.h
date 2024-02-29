//-----------------------------------------------------------------------------
// data.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

typedef void (*jumpFunction)(int8_t X);
typedef void (*collideJumpFunction)(uint8_t colID0, uint8_t colID1);

extern jumpFunction sprite_draw[LAYER_NUM_LAYERS];
extern jumpFunction sprite_draw_dead[LAYER_NUM_LAYERS];
extern jumpFunction ai_handler[LAYER_NUM_LAYERS];
extern collideJumpFunction collision_handler[LAYER_NUM_LAYERS];

extern uint8_t          layerCollides[LAYER_NUM_LAYERS];
extern uint8_t          layerColsig[LAYER_NUM_LAYERS];
extern uint16_t         layerFlags[LAYER_NUM_LAYERS];
extern uint8_t          layerHeight[LAYER_NUM_LAYERS];
extern uint8_t          layerWidth[LAYER_NUM_LAYERS];

#define NUM_SPAWN_LAYERS    9
extern const int8_t     spawnLayer[NUM_SPAWN_LAYERS];
extern const int16_t    spawnMinX[NUM_SPAWN_LAYERS];
extern const int16_t    spawnMinY[NUM_SPAWN_LAYERS];
extern const int8_t     spawnSpaceLayer[NUM_SPAWN_LAYERS];

extern const int16_t    launchPosX[];
extern const int16_t    launchPosY[];
extern const int8_t     rays[32][32];
extern const uint8_t    velXfrac[32*VELOCITY_NUMBERS];
extern const int8_t     velXwhole[32*VELOCITY_NUMBERS];
extern const uint8_t    velYfrac[32*VELOCITY_NUMBERS];
extern const int8_t     velYwhole[32*VELOCITY_NUMBERS];

extern const int8_t     bonusScores[NUM_SCORES];
extern const int8_t     bossAnimFrames[4];
extern const uint16_t   colorPalette[16];
extern const uint16_t   colorPaletteProps[3];
extern const uint16_t   colorPaletteSky[5];
extern const uint8_t    explode_16x16_hold_table[4];
extern const uint8_t    explode_32x16_hold_table[4];
extern const int8_t     heliFrameMap[];
extern const uint8_t    highScoreColorIndex[5];
extern const uint8_t    highScoreInitialsY[5];
extern const int16_t    horizontalDirectionTable[];
extern const int8_t     horizontalLaunchRayTable[];
extern const int8_t     layerToThingTable[];
extern const int8_t     parachute_sprite_table[6];
extern const int8_t     playerJoyAngles[16];
extern const int8_t     spriteSizeByLayer[];
extern const int8_t     spriteSizeByMisc[];
extern const uint8_t    spriteVRAMAddress_hi[];
extern const uint8_t    spriteVRAMAddress_lo[];
extern const uint8_t    spriteVRAMBosses_hi[];
extern const uint8_t    spriteVRAMBosses_lo[];
extern const uint8_t    spriteVRAMEnemies_hi[];
extern const uint8_t    spriteVRAMEnemies_lo[];
extern const uint8_t    spriteVRAMExplosions_hi[];
extern const uint8_t    spriteVRAMExplosions_lo[];
extern const uint8_t    spriteVRAMMisc_hi[];
extern const uint8_t    spriteVRAMMisc_lo[];
extern const int8_t     stageBossAudio[5];
extern const uint8_t    stageLabelColor[3];
extern const char**     stageLabelText[5];
extern const int8_t     timeWarpDrawScript[];

typedef struct _tagAudioData {
    uint8_t     start_bank;
    uint16_t    start_address;
    uint8_t     end_bank;
    uint16_t    end_address;
    uint8_t     loops;
} AudioData;
extern AudioData audioData[NUM_AUDIO_SOURCES];

extern uint8_t demoAttractBuffer[DEMO_ATTRACT_LENGTH];

void dataCleanup();
int8_t dataInit();
