//-----------------------------------------------------------------------------
// data.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "tigr.h"
#include "globals.h"

#include "ai.h"
#include "audio.h"
#include "collide.h"
#include "data.h"
#include "draw.h"
#include "print.h"
#include "text.h"

#include <stdio.h>

//-----------------------------------------------------------------------------
// Graphics
Tigr* cloud0Sprites;
Tigr* cloud1Sprites;
Tigr* cloud2Sprites;
Tigr* explosionSprites;
Tigr* fontSprites;
Tigr* l0BossSprites;
Tigr* l0EnemySprites;
Tigr* l1BomberSprites;
Tigr* l1BossSprites;
Tigr* l1EnemySprites;
Tigr* l2BossSprites;
Tigr* l2EnemySprites;
Tigr* l3BossSprites;
Tigr* l3EnemySprites;
Tigr* l4BossSprites;
Tigr* l4EnemySprites;
Tigr* logoSprites;
Tigr* numberSprites;
Tigr* parachuteSprites;
Tigr* playerBulletSprites;
Tigr* playerSprites;
Tigr* progressSprites;
Tigr* stageSprites;
Tigr* explSmallSprites;
Tigr* rocketSprites;
Tigr* bombSprites;
Tigr* explWepSprites;
Tigr* timeWarpSprites;
Tigr* astro0Sprites;
Tigr* astro1Sprites;
Tigr* astro2Sprites;
Tigr* spaceBulletSprites;
Tigr* spaceBulletExplodeSprites;
Tigr* boomerangSprites;
Tigr* boomerangExplodeSprites;

const char* spriteFileNames[] = {
    "cloud0",
    "cloud1",
    "cloud2",
    "player",
    "pbullet",
    "parachute",
    "l0enemy",
    "l1enemy",
    "l2enemy",
    "l3enemy",
    "l4enemy",
    "l0boss",
    "l1boss",
    "l2boss",
    "l3boss",
    "l4boss",
    "l1bomber",
    "expl32x16",
    "progress",
    "number",
    "stage",
    "font",
    "logo",
    "expl16x16",
    "rocket",
    "bomb",
    "expl_wep16x16",
    "timewarp",
    "astro0",
    "astro1",
    "astro2",
    "sbullet",
    "expl_sblt13x13",
    "boomerang",
    "expl_boom11x11",
};
static const uint16_t numSpriteFiles = sizeof(spriteFileNames) / sizeof(spriteFileNames[0]);

Tigr** spritePtrs[] = {
    &cloud0Sprites,             // 0
    &cloud1Sprites,             // 1
    &cloud2Sprites,             // 2
    &playerSprites,             // 3
    &playerBulletSprites,       // 4
    &parachuteSprites,          // 5
    &l0EnemySprites,            // 6
    &l1EnemySprites,            // 7
    &l2EnemySprites,            // 8
    &l3EnemySprites,            // 9
    &l4EnemySprites,            // 10
    &l0BossSprites,             // 11
    &l1BossSprites,             // 12
    &l2BossSprites,             // 13
    &l3BossSprites,             // 14
    &l4BossSprites,             // 15
    &l1BomberSprites,           // 16
    &explosionSprites,          // 17
    &progressSprites,           // 18
    &numberSprites,             // 19
    &stageSprites,              // 20
    &fontSprites,               // 21
    &logoSprites,               // 22
    &explSmallSprites,          // 23
    &rocketSprites,             // 24
    &bombSprites,               // 25
    &explWepSprites,            // 26
    &timeWarpSprites,           // 27
    &astro0Sprites,             // 28
    &astro1Sprites,             // 29
    &astro2Sprites,             // 30
    &spaceBulletSprites,        // 31
    &spaceBulletExplodeSprites, // 32
    &boomerangSprites,          // 33
    &boomerangExplodeSprites,   // 34
};
static const uint16_t numSpritePtrs = sizeof(spritePtrs) / sizeof(spritePtrs[0]);

//-----------------------------------------------------------------------------
// Audio
const char* audioSourceFileNames[NUM_AUDIO_SOURCES] = {
    "big_explosion",            // AUDIO_BIG_EXPLOSION
    "bomb",                     // AUDIO_BOMB
    "booomerang",               // AUDIO_BOOOMERANG
    "bossl0",                   // AUDIO_BOSS_L0
    "bossl1",                   // AUDIO_BOSS_L1
    "bossl2",                   // AUDIO_BOSS_L2
    "bossl3",                   // AUDIO_BOSS_L3
    "bossl4",                   // AUDIO_BOSS_L4
    "coindrop",                 // AUDIO_COINDROP
    "enemy_explode",            // AUDIO_ENEMY_EXPLODE
    "enemy_shoot",              // AUDIO_ENEMY_SHOOT
    "enemy_shoot_space",        // AUDIO_ENEMY_SHOOT_SPACE
    "extra_life",               // AUDIO_EXTRA_LIFE
    "game_start",               // AUDIO_GAME_START
    "highscore",                // AUDIO_HIGHSCORE
    "next_level",               // AUDIO_NEXT_LEVEL
    "pickup",                   // AUDIO_PICKUP
    "player_shoot",             // AUDIO_PLAYER_SHOOT
    "rocket_fly",               // AUDIO_ROCKET_FLY
    "rocket_launch",            // AUDIO_ROCKET_LAUNCH
    "stage_clear",              // AUDIO_STAGE_CLEAR
    "timewarp",                 // AUDIO_TIMEWARP
    "wapon_explode",            // AUDIO_WAPON_EXPLODE
    "wave_start",               // AUDIO_WAVE_START
};

//-----------------------------------------------------------------------------
// Each layer has an entry
jumpFunction sprite_draw[] =  {
    drawClouds0,                // LAYER_CLOUDS0
    drawAstros0,                // LAYER_ASTROS0
    drawClouds1,                // LAYER_CLOUDS1
    drawAstros1,                // LAYER_ASTROS1
    drawEnemyBullets,           // LAYER_ENEMY_BULLETS
    drawEnemySpaceBullets,      // LAYER_ENEMY_SPACEBULLETS
    drawEnemyBombs,             // LAYER_ENEMY_BOMBS
    drawEnemyRockets,           // LAYER_ENEMY_ROCKETS
    drawEnemyBoomerang,         // LAYER_ENEMY_BOOMERANG
    drawEnemyP0P1,              // LAYER_ENEMY
    drawPlayerBullets,          // LAYER_PLAYER_BULLETS
    drawParachute,              // LAYER_PARACHUTE
    drawLevelBossP1P2,          // LAYER_BOMBER
    drawLevelBossP0P3,          // LAYER_LEVELBOSS
    drawRts,                    // LAYER_WARP
    drawPlayer,                 // LAYER_PLAYER
    drawClouds2,                // LAYER_CLOUDS2
    drawAstros2,                // LAYER_ASTROS2
    drawScores,                 // LAYER_SCORES
};

jumpFunction sprite_partial_draw[] = {
    drawClouds0Part,            // LAYER_CLOUDS0
    drawAstros0Part,            // LAYER_ASTROS0
    drawClouds1Part,            // LAYER_CLOUDS1
    drawAstros1Part,            // LAYER_ASTROS1
    drawRts,                    // LAYER_ENEMY_BULLETS
    drawRts,                    // LAYER_ENEMY_SPACEBULLETS
    drawRts,                    // LAYER_ENEMY_BOMBS
    drawEnemyRocketsPart,       // LAYER_ENEMY_ROCKETS
    drawEnemyBoomerangPart,     // LAYER_ENEMY_BOOMERANG
    drawEnemyP0P1Part,          // LAYER_ENEMY
    drawRts,                    // LAYER_PLAYER_BULLETS
    drawParachutePart,          // LAYER_PARACHUTE
    drawLevelBossP1P2Part,      // LAYER_BOMBER
    drawLevelBossP0P3Part,      // LAYER_LEVELBOSS
    drawRts,                    // LAYER_WARP
    drawRts,                    // LAYER_PLAYER
    drawClouds2Part,            // LAYER_CLOUDS2
    drawAstros2Part,            // LAYER_ASTROS2
    drawRts,                    // LAYER_SCORES
};

jumpFunction sprite_draw_dead[] = {
    drawRts,                    // LAYER_CLOUDS0
    drawRts,                    // LAYER_ASTROS0
    drawRts,                    // LAYER_CLOUDS1
    drawRts,                    // LAYER_ASTROS1
    drawRts,                    // LAYER_ENEMY_BULLETS
    draw13x13Expl_sblt,         // LAYER_ENEMY_SPACEBULLETS
    draw16x16Expl_wep,          // LAYER_ENEMY_BOMBS
    draw16x16Expl_wep,          // LAYER_ENEMY_ROCKETS
    draw11x11Expl_boom,         // LAYER_ENEMY_BOOMERANG
    draw16x16Explosion,         // LAYER_ENEMY
    drawRts,                    // LAYER_PLAYER_BULLETS
    drawRts,                    // LAYER_PARACHUTE
    draw32x16Explosion,         // LAYER_BOMBER
    draw32x16Explosion,         // LAYER_LEVELBOSS
    drawRts,                    // LAYER_WARP
    draw32x16Explosion,         // LAYER_PLAYER
    drawRts,                    // LAYER_CLOUDS2
    drawRts,                    // LAYER_ASTROS2
    drawRts,                    // LAYER_SCORES
};

jumpFunction ai_handler[] = {
    aiClouds0,                  // LAYER_CLOUDS0
    aiClouds0,                  // LAYER_ASTROS0
    aiClouds1,                  // LAYER_CLOUDS1
    aiClouds1,                  // LAYER_ASTROS1
    aiEnemyBullets,             // LAYER_ENEMY_BULLETS
    aiEnemySpaceBullets,        // LAYER_ENEMY_SPACEBULLETS
    aiEnemyBombs,               // LAYER_ENEMY_BOMBS
    aiEnemyRockets,             // LAYER_ENEMY_ROCKETS
    aiEnemyBoomerang,           // LAYER_ENEMY_BOOMERANG
    aiEnemy,                    // LAYER_ENEMY
    aiPlayerBullets,            // LAYER_PLAYER_BULLETS
    aiParachute,                // LAYER_PARACHUTE
    aiBomber,                   // LAYER_BOMBER
    aiLevelBoss,                // LAYER_LEVELBOSS
    drawRts,                    // LAYER_WARP
    aiPlayer,                   // LAYER_PLAYER
    aiClouds2,                  // LAYER_CLOUDS2
    aiClouds2,                  // LAYER_ASTROS2
    aiScores,                   // LAYER_SCORES
};

collideJumpFunction collision_handler[] = {
    collideRts,                 // LAYER_CLOUDS0
    collideRts,                 // LAYER_ASTROS0
    collideRts,                 // LAYER_CLOUDS1
    collideRts,                 // LAYER_ASTROS1
    collideRemove,              // LAYER_ENEMY_BULLETS
    collideEnemySpaceBullets,   // LAYER_ENEMY_SPACEBULLETS
    collideEnemyRockets,        // LAYER_ENEMY_BOMBS
    collideEnemyRockets,        // LAYER_ENEMY_ROCKETS
    collideEnemyBoomerang,      // LAYER_ENEMY_BOOMERANG
    collideEnemy,               // LAYER_ENEMY
    collideRemove,              // LAYER_PLAYER_BULLETS
    collideParachute,           // LAYER_PARACHUTE
    collideBomber,              // LAYER_BOMBER
    collideLevelBoss,           // LAYER_LEVELBOSS
    collideRts,                 // LAYER_WARP
    collidePlayer,              // LAYER_PLAYER
    collideRts,                 // LAYER_CLOUDS2
    collideRts,                 // LAYER_ASTROS2
    collideRts,                 // LAYER_SCORES
};

uint16_t layerBMPIndex[LAYER_NUM_LAYERS] = {
    0,                          // LAYER_CLOUDS0
    28,                         // LAYER_ASTROS0
    1,                          // LAYER_CLOUDS1
    29,                         // LAYER_ASTROS1
    4,                          // LAYER_ENEMY_BULLETS
    31,                         // LAYER_ENEMY_SPACEBULLETS
    25,                         // LAYER_ENEMY_BOMBS
    24,                         // LAYER_ENEMY_ROCKETS
    33,                         // LAYER_ENEMY_BOOMERANG
    6,                          // LAYER_ENEMY
    4,                          // LAYER_PLAYER_BULLETS
    5,                          // LAYER_PARACHUTE
    16,                         // LAYER_BOMBER
    11,                         // LAYER_LEVELBOSS
    0,                          // LAYER_WARP
    3,                          // LAYER_PLAYER
    2,                          // LAYER_CLOUDS2
    30,                         // LAYER_ASTROS2
    19,                         // LAYER_SCORES
};

uint16_t layerCollides[LAYER_NUM_LAYERS] = {
    COLLIDE_NONE,                                                                      // LAYER_CLOUDS0
    COLLIDE_NONE,                                                                      // LAYER_ASTROS0
    COLLIDE_NONE,                                                                      // LAYER_CLOUDS1
    COLLIDE_NONE,                                                                      // LAYER_ASTROS1
    COLLIDE_PLAYER,                                                                    // LAYER_ENEMY_BULLETS
    COLLIDE_PLAYER_BULLETS | COLLIDE_PLAYER,                                           // LAYER_ENEMY_SPACEBULLETS
    COLLIDE_PLAYER_BULLETS | COLLIDE_PLAYER,                                           // LAYER_ENEMY_BOMBS
    COLLIDE_PLAYER_BULLETS | COLLIDE_PLAYER,                                           // LAYER_ENEMY_ROCKETS
    COLLIDE_PLAYER_BULLETS | COLLIDE_PLAYER,                                           // LAYER_ENEMY_BOOMERANG
    COLLIDE_PLAYER_BULLETS | COLLIDE_PLAYER,                                           // LAYER_ENEMY
    COLLIDE_ENEMY | COLLIDE_ENEMY_ROCKETS,                                             // LAYER_PLAYER_BULLETS
    COLLIDE_PLAYER,                                                                    // LAYER_PARACHUTE
    COLLIDE_PLAYER_BULLETS | COLLIDE_PLAYER,                                           // LAYER_BOMBER
    COLLIDE_PLAYER_BULLETS | COLLIDE_PLAYER,                                           // LAYER_LEVELBOSS
    COLLIDE_NONE,                                                                      // LAYER_WARP
    COLLIDE_ENEMY | COLLIDE_ENEMY_BULLETS | COLLIDE_ENEMY_ROCKETS | COLLIDE_PARACHUTE, // LAYER_PLAYER
    COLLIDE_NONE,                                                                      // LAYER_CLOUDS2
    COLLIDE_NONE,                                                                      // LAYER_ASTROS2
    COLLIDE_NONE,                                                                      // LAYER_SCORES
};

uint16_t layerColsig[LAYER_NUM_LAYERS] = {
    COLLIDE_NONE,               // LAYER_CLOUDS0
    COLLIDE_NONE,               // LAYER_ASTROS0
    COLLIDE_NONE,               // LAYER_CLOUDS1
    COLLIDE_NONE,               // LAYER_ASTROS1
    COLLIDE_ENEMY_BULLETS,      // LAYER_ENEMY_BULLETS
    COLLIDE_ENEMY_BULLETS,      // LAYER_ENEMY_SPACEBULLETS
    COLLIDE_ENEMY,              // LAYER_ENEMY_BOMBS
    COLLIDE_ENEMY,              // LAYER_ENEMY_ROCKETS
    COLLIDE_ENEMY,              // LAYER_ENEMY_BOOMERANG
    COLLIDE_ENEMY,              // LAYER_ENEMY
    COLLIDE_PLAYER_BULLETS,     // LAYER_PLAYER_BULLETS
    COLLIDE_PARACHUTE,          // LAYER_PARACHUTE
    COLLIDE_ENEMY,              // LAYER_BOMBER
    COLLIDE_ENEMY,              // LAYER_LEVELBOSS
    COLLIDE_NONE,               // LAYER_WARP
    COLLIDE_PLAYER,             // LAYER_PLAYER
    COLLIDE_NONE,               // LAYER_CLOUDS2
    COLLIDE_NONE,               // LAYER_ASTROS2
    COLLIDE_NONE,               // LAYER_SCORES
};

uint16_t layerFlags[LAYER_NUM_LAYERS] = {
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_WRAPS,                      // LAYER_CLOUDS0
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_WRAPS,                      // LAYER_ASTROS0
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_WRAPS,                      // LAYER_CLOUDS1
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_WRAPS,                      // LAYER_ASTROS1
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_NONE,                       // LAYER_ENEMY_BULLETS
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_NONE,                       // LAYER_ENEMY_SPACEBULLETS
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_NONE,                       // LAYER_ENEMY_BOMBS
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_NONE,                       // LAYER_ENEMY_ROCKETS
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_NONE,                       // LAYER_ENEMY_BOOMERANG
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_NONE,                       // LAYER_ENEMY
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_NONE,                       // LAYER_PLAYER_BULLETS
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_NONE,                       // LAYER_PARACHUTE
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_NONE,                       // LAYER_BOMBER
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_NONE,                       // LAYER_LEVELBOSS
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_NONE,                       // LAYER_WARP
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_NONE,                       // LAYER_PLAYER
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_WRAPS,                      // LAYER_CLOUDS2
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_WRAPS,                      // LAYER_ASTROS2
    ACTIVEFLAGS_INUSE | ACTIVEFLAGS_CLIPMASK | ACTIVEFLAGS_WRAPS,                      // LAYER_SCORES
};

uint16_t layerHeight[LAYER_NUM_LAYERS] = {
    9,                          // LAYER_CLOUDS0
    12,                         // LAYER_ASTROS0
    14,                         // LAYER_CLOUDS1
    15,                         // LAYER_ASTROS1
    2,                          // LAYER_ENEMY_BULLETS
    7,                          // LAYER_ENEMY_SPACEBULLETS
    3,                          // LAYER_ENEMY_BOMBS
    9,                          // LAYER_ENEMY_ROCKETS
    6,                          // LAYER_ENEMY_BOOMERANG
    16,                         // LAYER_ENEMY
    2,                          // LAYER_PLAYER_BULLETS
    16,                         // LAYER_PARACHUTE
    9,                          // LAYER_BOMBER
    16,                         // LAYER_LEVELBOSS
    16,                         // LAYER_WARP
    16,                         // LAYER_PLAYER
    16,                         // LAYER_CLOUDS2
    14,                         // LAYER_ASTROS2
    16,                         // LAYER_SCORES
};

uint16_t layerWidth[LAYER_NUM_LAYERS] = {
    16,                         // LAYER_CLOUDS0
    14,                         // LAYER_ASTROS0
    30,                         // LAYER_CLOUDS1
    14,                         // LAYER_ASTROS1
    2,                          // LAYER_ENEMY_BULLETS
    7,                          // LAYER_ENEMY_SPACEBULLETS
    6,                          // LAYER_ENEMY_BOMBS
    9,                          // LAYER_ENEMY_ROCKETS
    6,                          // LAYER_ENEMY_BOOMERANG
    16,                         // LAYER_ENEMY
    2,                          // LAYER_PLAYER_BULLETS
    16,                         // LAYER_PARACHUTE
    28,                         // LAYER_BOMBER
    32,                         // LAYER_LEVELBOSS
    16,                         // LAYER_WARP
    16,                         // LAYER_PLAYER
    46,                         // LAYER_CLOUDS2
    27,                         // LAYER_ASTROS2
    16,                         // LAYER_SCORES
};

//-----------------------------------------------------------------------------
const int16_t spawnLayer[NUM_SPAWN_LAYERS] = {
    LAYER_CLOUDS0,
    LAYER_CLOUDS1,
    LAYER_CLOUDS2,
    LAYER_CLOUDS1,
    LAYER_CLOUDS0,
    LAYER_CLOUDS1,
    LAYER_CLOUDS2,
    LAYER_CLOUDS1,
    LAYER_PLAYER,
};

const int16_t spawnMinX[NUM_SPAWN_LAYERS] = {
    128,                        // LAYER_CLOUDS0
    -8,                         // LAYER_CLOUDS1
    160,                        // LAYER_CLOUDS2
    32,                         // LAYER_CLOUDS1
    0,                          // LAYER_CLOUDS0
    112,                        // LAYER_CLOUDS1
    32,                         // LAYER_CLOUDS2
    160,                        // LAYER_CLOUDS1
    PLAYER_X,                   // LAYER_PLAYER
};

const int16_t spawnMinY[NUM_SPAWN_LAYERS] = {
    188,                        // LAYER_CLOUDS0
    184,                        // LAYER_CLOUDS1
    168,                        // LAYER_CLOUDS2
    120,                        // LAYER_CLOUDS1
    60,                         // LAYER_CLOUDS0
    56,                         // LAYER_CLOUDS1
    40,                         // LAYER_CLOUDS2
    -8,                         // LAYER_CLOUDS1
    PLAYER_Y,                   // LAYER_PLAYER
};

const int16_t spawnSpaceLayer[NUM_SPAWN_LAYERS] = {
    LAYER_ASTROS0,
    LAYER_ASTROS1,
    LAYER_ASTROS2,
    LAYER_ASTROS1,
    LAYER_ASTROS0,
    LAYER_ASTROS1,
    LAYER_ASTROS2,
    LAYER_ASTROS1,
    LAYER_PLAYER,
};

//-----------------------------------------------------------------------------
// -16 .. 224 around the sceeen at 11.25 degree angles - offset by -8 when not -16 or 224
const int16_t launchPosX[] = {
    0x00E0,0x00E0,0x00E0,0x00E0,0x00E0,0x00C6,0x00A9,0x0089,
    0x0068,0x0047,0x0027,0x000A,0xFFF0,0xFFF0,0xFFF0,0xFFF0,
    0xFFF0,0xFFF0,0xFFF0,0xFFF0,0xFFF0,0x000A,0x0027,0x0047,
    0x0068,0x0089,0x00A9,0x00C6,0x00E0,0x00E0,0x00E0,0x00E0,
};

// -16 .. 192 around the sceeen at 11.25 degree angles,offset by -8 when not -16 or 192
const int16_t launchPosY[] = {
    0x0058,0x0075,0x0090,0x00AA,0x00C0,0x00C0,0x00C0,0x00C0,
    0x00C0,0x00C0,0x00C0,0x00C0,0x00C0,0x00AA,0x0090,0x0075,
    0x0058,0x003B,0x0020,0x0006,0xFFF0,0xFFF0,0xFFF0,0xFFF0,
    0xFFF0,0xFFF0,0xFFF0,0xFFF0,0xFFF0,0x0006,0x0020,0x003B,
};

// -128 to 368 with negatives wrapping to col/row 24.  Centre at (112,96)
const int16_t rays[32][32] = {
    {4 ,4 ,4 ,5 ,6 ,6 ,7 ,8 ,9 ,10,10,11,12,12,12,13,13,13,13,14,14,14,14,14,2 ,2 ,2 ,2 ,3 ,3 ,3 ,3 },
    {3 ,4 ,4 ,5 ,5 ,6 ,7 ,8 ,9 ,10,11,11,12,12,13,13,13,14,14,14,14,14,14,14,2 ,2 ,2 ,2 ,2 ,2 ,3 ,3 },
    {3 ,3 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,10,11,12,13,13,13,14,14,14,14,14,14,15,15,15,1 ,1 ,2 ,2 ,2 ,2 ,2 ,2 },
    {2 ,2 ,3 ,3 ,4 ,5 ,6 ,8 ,10,11,12,13,13,14,14,14,14,15,15,15,15,15,15,15,1 ,1 ,1 ,1 ,1 ,1 ,2 ,2 },
    {1 ,2 ,2 ,2 ,3 ,4 ,6 ,8 ,10,12,13,14,14,14,15,15,15,15,15,15,15,15,15,15,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 },
    {1 ,1 ,1 ,1 ,2 ,2 ,4 ,8 ,12,14,14,15,15,15,15,15,15,15,16,16,16,16,16,16,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 },
    {0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 },
    {31,31,31,31,30,30,28,24,20,18,18,17,17,17,17,17,17,17,16,16,16,16,16,16,0 ,0 ,0 ,0 ,0 ,31,31,31},
    {31,30,30,30,29,28,26,24,22,20,19,18,18,18,17,17,17,17,17,17,17,17,17,17,31,31,31,31,31,31,31,31},
    {30,30,29,29,28,27,26,24,22,21,20,19,19,18,18,18,18,17,17,17,17,17,17,17,31,31,31,31,31,31,30,30},
    {29,29,29,28,27,26,25,24,23,22,21,20,19,19,19,18,18,18,18,18,18,17,17,17,31,31,30,30,30,30,30,30},
    {29,28,28,27,27,26,25,24,23,22,21,21,20,20,19,19,19,18,18,18,18,18,18,18,30,30,30,30,30,30,29,29},
    {28,28,28,27,26,26,25,24,23,22,22,21,20,20,20,19,19,19,19,18,18,18,18,18,30,30,30,30,29,29,29,29},
    {28,28,27,27,26,25,25,24,23,23,22,21,21,20,20,20,19,19,19,19,19,18,18,18,30,30,29,29,29,29,29,28},
    {28,27,27,26,26,25,25,24,23,23,22,22,21,21,20,20,20,19,19,19,19,19,18,18,30,29,29,29,29,29,28,28},
    {27,27,27,26,26,25,25,24,23,23,22,22,21,21,21,20,20,20,19,19,19,19,19,19,29,29,29,29,29,28,28,28},
    {27,27,26,26,25,25,25,24,23,23,23,22,22,21,21,21,20,20,20,20,19,19,19,19,29,29,29,28,28,28,28,27},
    {27,27,26,26,25,25,24,24,24,23,23,22,22,21,21,21,21,20,20,20,20,19,19,19,29,29,28,28,28,28,27,27},
    {27,26,26,26,25,25,24,24,24,23,23,22,22,22,21,21,21,20,20,20,20,20,19,19,29,28,28,28,28,28,27,27},
    {27,26,26,26,25,25,24,24,24,23,23,22,22,22,21,21,21,21,20,20,20,20,20,19,28,28,28,28,28,27,27,27},
    {26,26,26,25,25,25,24,24,24,23,23,23,22,22,22,21,21,21,21,20,20,20,20,20,28,28,28,28,27,27,27,27},
    {26,26,26,25,25,25,24,24,24,23,23,23,22,22,22,22,21,21,21,21,20,20,20,20,28,28,28,27,27,27,27,26},
    {26,26,26,25,25,25,24,24,24,23,23,23,22,22,22,22,21,21,21,21,21,20,20,20,28,28,27,27,27,27,27,26},
    {26,26,25,25,25,25,24,24,24,23,23,23,23,22,22,22,22,21,21,21,21,20,20,20,28,28,27,27,27,27,26,26},
    {6 ,6 ,6 ,7 ,7 ,7 ,8 ,8 ,8 ,9 ,9 ,9 ,10,10,10,11,11,11,11,12,12,12,12,12,4 ,4 ,4 ,4 ,5 ,5 ,5 ,5 },
    {5 ,6 ,6 ,6 ,7 ,7 ,8 ,8 ,8 ,9 ,9 ,10,10,10,11,11,11,11,12,12,12,12,12,13,4 ,4 ,4 ,4 ,4 ,5 ,5 ,5 },
    {5 ,6 ,6 ,6 ,7 ,7 ,8 ,8 ,8 ,9 ,9 ,10,10,10,11,11,11,12,12,12,12,12,13,13,3 ,4 ,4 ,4 ,4 ,4 ,5 ,5 },
    {5 ,5 ,6 ,6 ,7 ,7 ,8 ,8 ,8 ,9 ,9 ,10,10,11,11,11,11,12,12,12,12,13,13,13,3 ,3 ,4 ,4 ,4 ,4 ,5 ,5 },
    {5 ,5 ,6 ,6 ,7 ,7 ,7 ,8 ,9 ,9 ,9 ,10,10,11,11,11,12,12,12,12,13,13,13,13,3 ,3 ,3 ,4 ,4 ,4 ,4 ,5 },
    {5 ,5 ,5 ,6 ,6 ,7 ,7 ,8 ,9 ,9 ,10,10,11,11,11,12,12,12,13,13,13,13,13,13,3 ,3 ,3 ,3 ,3 ,4 ,4 ,4 },
    {4 ,5 ,5 ,6 ,6 ,7 ,7 ,8 ,9 ,9 ,10,10,11,11,12,12,12,13,13,13,13,13,14,14,2 ,3 ,3 ,3 ,3 ,3 ,4 ,4 },
    {4 ,4 ,5 ,5 ,6 ,7 ,7 ,8 ,9 ,9 ,10,11,11,12,12,12,13,13,13,13,13,14,14,14,2 ,2 ,3 ,3 ,3 ,3 ,3 ,4 },
};

const uint16_t velXfrac[] = {
    0x8000,0x7D8A,0x7641,0x6A6D,0x5A82,0x471C,0x30FB,0x18F8,  // 0.5
    0x0000,0xE708,0xCF05,0xB8E4,0xA57E,0x9593,0x89BF,0x8276,
    0x8000,0x8276,0x89BF,0x9593,0xA57E,0xB8E4,0xCF05,0xE708,
    0x0000,0x18F8,0x30FB,0x471C,0x5A82,0x6A6D,0x7641,0x7D8A,
    0xC000,0xBC4F,0xB162,0x9FA4,0x87C3,0x6AAB,0x4979,0x2575,  // 0.75
    0x0000,0xDA8B,0xB687,0x9555,0x783D,0x605C,0x4E9E,0x43B1,
    0x4000,0x43B1,0x4E9E,0x605C,0x783D,0x9555,0xB687,0xDA8B,
    0x0000,0x2575,0x4979,0x6AAB,0x87C3,0x9FA4,0xB162,0xBC4F,
    0x0000,0xFB14,0xEC83,0xD4DB,0xB504,0x8E39,0x61F7,0x31F1,  // 1.0
    0x0000,0xCE0F,0x9E09,0x71C7,0x4AFC,0x2B25,0x137D,0x04EC,
    0x0000,0x04EC,0x137D,0x2B25,0x4AFC,0x71C7,0x9E09,0xCE0F,
    0x0000,0x31F1,0x61F7,0x8E39,0xB504,0xD4DB,0xEC83,0xFB14,
    0x30A3,0x2AC9,0x1973,0xFD4C,0xD769,0xA93F,0x7494,0x3B6E,  // 1.19
    0x0000,0xC492,0x8B6C,0x56C1,0x2897,0x02B4,0xE68D,0xD537,
    0xCF5D,0xD537,0xE68D,0x02B4,0x2897,0x56C1,0x8B6C,0xC492,
    0x0000,0x3B6E,0x7494,0xA93F,0xD769,0xFD4C,0x1973,0x2AC9,
    0x8000,0x789F,0x62C5,0x3F48,0x0F87,0xD556,0x92F3,0x4AEA,  // 1.5
    0x0000,0xB516,0x6D0D,0x2AAA,0xF079,0xC0B8,0x9D3B,0x8761,
    0x8000,0x8761,0x9D3B,0xC0B8,0xF079,0x2AAA,0x6D0D,0xB516,
    0x0000,0x4AEA,0x92F3,0xD556,0x0F87,0x3F48,0x62C5,0x789F,
    0x0000,0xF629,0xD906,0xA9B6,0x6A09,0x1C73,0xC3EF,0x63E2,  // 2.0
    0x0000,0x9C1E,0x3C11,0xE38D,0x95F7,0x564A,0x26FA,0x09D7,
    0x0000,0x09D7,0x26FA,0x564A,0x95F7,0xE38D,0x3C11,0x9C1E,
    0x0000,0x63E2,0xC3EF,0x1C73,0x6A09,0xA9B6,0xD906,0xF629,
    0x0000,0xEC52,0xB20D,0x536C,0xD413,0x38E7,0x87DE,0xC7C5,  // 4.0
    0x0000,0x383B,0x7822,0xC719,0x2BED,0xAC94,0x4DF3,0x13AE,
    0x0000,0x13AE,0x4DF3,0xAC94,0x2BED,0xC719,0x7822,0x383B,
    0x0000,0xC7C5,0x87DE,0x38E7,0xD413,0x536C,0xB20D,0xEC52,
};

const uint16_t velXwhole[] = {
    0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,  // 0.5
    0x0000,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,
    0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,
    0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
    0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,  // 0.75
    0x0000,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,
    0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,
    0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
    0x0001,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,  // 1.0
    0x0000,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,
    0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,
    0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
    0x0001,0x0001,0x0001,0x0000,0x0000,0x0000,0x0000,0x0000,  // 1.19
    0x0000,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFE,0xFFFE,
    0xFFFE,0xFFFE,0xFFFE,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,
    0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0001,0x0001,
    0x0001,0x0001,0x0001,0x0001,0x0001,0x0000,0x0000,0x0000,  // 1.5
    0x0000,0xFFFF,0xFFFF,0xFFFF,0xFFFE,0xFFFE,0xFFFE,0xFFFE,
    0xFFFE,0xFFFE,0xFFFE,0xFFFE,0xFFFE,0xFFFF,0xFFFF,0xFFFF,
    0x0000,0x0000,0x0000,0x0000,0x0001,0x0001,0x0001,0x0001,
    0x0002,0x0001,0x0001,0x0001,0x0001,0x0001,0x0000,0x0000,  // 2.0
    0x0000,0xFFFF,0xFFFF,0xFFFE,0xFFFE,0xFFFE,0xFFFE,0xFFFE,
    0xFFFE,0xFFFE,0xFFFE,0xFFFE,0xFFFE,0xFFFE,0xFFFF,0xFFFF,
    0x0000,0x0000,0x0000,0x0001,0x0001,0x0001,0x0001,0x0001,
    0x0004,0x0003,0x0003,0x0003,0x0002,0x0002,0x0001,0x0000,  // 4.0
    0x0000,0xFFFF,0xFFFE,0xFFFD,0xFFFD,0xFFFC,0xFFFC,0xFFFC,
    0xFFFC,0xFFFC,0xFFFC,0xFFFC,0xFFFD,0xFFFD,0xFFFE,0xFFFF,
    0x0000,0x0000,0x0001,0x0002,0x0002,0x0003,0x0003,0x0003,
};

const uint16_t velYfrac[] = {
    0x0000,0x18F8,0x30FB,0x471C,0x5A82,0x6A6D,0x7641,0x7D8A,  // 0.5
    0x8000,0x7D8A,0x7641,0x6A6D,0x5A82,0x471C,0x30FB,0x18F8,
    0x0000,0xE708,0xCF05,0xB8E4,0xA57E,0x9593,0x89BF,0x8276,
    0x8000,0x8276,0x89BF,0x9593,0xA57E,0xB8E4,0xCF05,0xE708,
    0x0000,0x2575,0x4979,0x6AAB,0x87C3,0x9FA4,0xB162,0xBC4F,  // 0.75
    0xC000,0xBC4F,0xB162,0x9FA4,0x87C3,0x6AAB,0x4979,0x2575,
    0x0000,0xDA8B,0xB687,0x9555,0x783D,0x605C,0x4E9E,0x43B1,
    0x4000,0x43B1,0x4E9E,0x605C,0x783D,0x9555,0xB687,0xDA8B,
    0x0000,0x31F1,0x61F7,0x8E39,0xB504,0xD4DB,0xEC83,0xFB14,  // 1.0
    0x0000,0xFB14,0xEC83,0xD4DB,0xB504,0x8E39,0x61F7,0x31F1,
    0x0000,0xCE0F,0x9E09,0x71C7,0x4AFC,0x2B25,0x137D,0x04EC,
    0x0000,0x04EC,0x137D,0x2B25,0x4AFC,0x71C7,0x9E09,0xCE0F,
    0x0000,0x3B6E,0x7494,0xA93F,0xD769,0xFD4C,0x1973,0x2AC9,  // 1.19
    0x30A3,0x2AC9,0x1973,0xFD4C,0xD769,0xA93F,0x7494,0x3B6E,
    0x0000,0xC492,0x8B6C,0x56C1,0x2897,0x02B4,0xE68D,0xD537,
    0xCF5D,0xD537,0xE68D,0x02B4,0x2897,0x56C1,0x8B6C,0xC492,
    0x0000,0x4AEA,0x92F3,0xD556,0x0F87,0x3F48,0x62C5,0x789F,  // 1.5
    0x8000,0x789F,0x62C5,0x3F48,0x0F87,0xD556,0x92F3,0x4AEA,
    0x0000,0xB516,0x6D0D,0x2AAA,0xF079,0xC0B8,0x9D3B,0x8761,
    0x8000,0x8761,0x9D3B,0xC0B8,0xF079,0x2AAA,0x6D0D,0xB516,
    0x0000,0x63E2,0xC3EF,0x1C73,0x6A09,0xA9B6,0xD906,0xF629,  // 2.0
    0x0000,0xF629,0xD906,0xA9B6,0x6A09,0x1C73,0xC3EF,0x63E2,
    0x0000,0x9C1E,0x3C11,0xE38D,0x95F7,0x564A,0x26FA,0x09D7,
    0x0000,0x09D7,0x26FA,0x564A,0x95F7,0xE38D,0x3C11,0x9C1E,
    0x0000,0xC7C5,0x87DE,0x38E7,0xD413,0x536C,0xB20D,0xEC52,  // 4.0
    0x0000,0xEC52,0xB20D,0x536C,0xD413,0x38E7,0x87DE,0xC7C5,
    0x0000,0x383B,0x7822,0xC719,0x2BED,0xAC94,0x4DF3,0x13AE,
    0x0000,0x13AE,0x4DF3,0xAC94,0x2BED,0xC719,0x7822,0x383B,
};

const uint16_t velYwhole[] = {
    0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,  // 0.5
    0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
    0x0000,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,
    0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,
    0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,  // 0.75
    0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
    0x0000,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,
    0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,
    0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,  // 1.0
    0x0001,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
    0x0000,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,
    0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,
    0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0001,0x0001,  // 1.19
    0x0001,0x0001,0x0001,0x0000,0x0000,0x0000,0x0000,0x0000,
    0x0000,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFE,0xFFFE,
    0xFFFE,0xFFFE,0xFFFE,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,
    0x0000,0x0000,0x0000,0x0000,0x0001,0x0001,0x0001,0x0001,  // 1.5
    0x0001,0x0001,0x0001,0x0001,0x0001,0x0000,0x0000,0x0000,
    0x0000,0xFFFF,0xFFFF,0xFFFF,0xFFFE,0xFFFE,0xFFFE,0xFFFE,
    0xFFFE,0xFFFE,0xFFFE,0xFFFE,0xFFFE,0xFFFF,0xFFFF,0xFFFF,
    0x0000,0x0000,0x0000,0x0001,0x0001,0x0001,0x0001,0x0001,  // 2.0
    0x0002,0x0001,0x0001,0x0001,0x0001,0x0001,0x0000,0x0000,
    0x0000,0xFFFF,0xFFFF,0xFFFE,0xFFFE,0xFFFE,0xFFFE,0xFFFE,
    0xFFFE,0xFFFE,0xFFFE,0xFFFE,0xFFFE,0xFFFE,0xFFFF,0xFFFF,
    0x0000,0x0000,0x0001,0x0002,0x0002,0x0003,0x0003,0x0003,  // 4.0
    0x0004,0x0003,0x0003,0x0003,0x0002,0x0002,0x0001,0x0000,
    0x0000,0xFFFF,0xFFFE,0xFFFD,0xFFFD,0xFFFC,0xFFFC,0xFFFC,
    0xFFFC,0xFFFC,0xFFFC,0xFFFC,0xFFFD,0xFFFD,0xFFFE,0xFFFF,
};

//-----------------------------------------------------------------------------
const int16_t bonusScores[NUM_SCORES] = {
    10, 20, 30, 40, 50, 15,
};

const int16_t bossAnimFrames[4] = {
    3, 3, 2, 1
};

// RGB here but GBR in 65816.  The dark variants in the 65816 are mapped to enemy colours (RGB) and Y and Extra to a prop
const uint32_t colorPalette[16] = {
    0x000000,                   // BLACK
    0xF00000,                   // RED
    0x00C000,                   // GREEN
    0x0050F0,                   // BLUE
    0xF0F000,                   // YELLOW
    0xF08000,                   // ORANGE
    0xC000C0,                   // MAGENTA
    0x00C0F0,                   // CYAN
    0x808080,                   // GRAY
    0xF0F0F0,                   // WHITE
    0x123456,                   // SKY
    0x800000,                   // RED (DARK)    - also Enemy colours on palette systems
    0x608000,                   // GREEN (DARK)  - also Enemy colours on palette systems
    0x0000A0,                   // BLUE (DARK)   - also Enemy colours on palette systems
    0xB0B000,                   // YELLOW (DARK) - also prop colours on palette systems
    0x789abc,                   // Extra         - also prop colours on palette systems
};

const uint32_t colorPaletteSky[5] = {
    0x000060,                   // TIME_PERIOD0_1910
    0x005060,                   // TIME_PERIOD1_1940
    0x006050,                   // TIME_PERIOD2_1970
    0x500050,                   // TIME_PERIOD3_1982
    0x000000,                   // TIME_PERIOD4_2001
};

const uint16_t explode_16x16_hold_table[4] = {
    4, 8, 4, 4
};

const uint16_t explode_32x16_hold_table[4] = {
    8, 16, 8, 8
};

const int16_t heliFrameMap[] = {
    0, 0, 1, 1, 2, 2, 3, 3,
    4, 5, 5, 6, 6, 7, 7, 8,
    8, 8, 7, 7, 6, 6, 5, 5,
    4, 3, 3, 2, 2, 1, 1, 0
};

const uint16_t highScoreColorIndex[5] = {
    TP_COLOR_RED,
    TP_COLOR_ORANGE,
    TP_COLOR_YELLOW,
    TP_COLOR_GREEN,
    TP_COLOR_CYAN
};

const uint16_t highScoreInitialsY[] = {
    8,
    10,
    12,
    14,
    16
};

const uint16_t horizontalDirectionTable[] = {
    ACTIVEFLAGS_NONE,
    ACTIVEFLAGS_NONE,
    ACTIVEFLAGS_NONE,
    ACTIVEFLAGS_NONE,
    ACTIVEFLAGS_NONE,
    ACTIVEFLAGS_NONE,
    ACTIVEFLAGS_NONE,
    ACTIVEFLAGS_NONE,
    (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT), // Same flag, for clarity
    (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT),
    (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT),
    (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT),
    (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT),
    (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT),
    (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT),
    (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT),
    (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT),
    (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT),
    (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT),
    (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT),
    (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT),
    (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT),
    (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT),
    (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT),
    ACTIVEFLAGS_NONE,
    ACTIVEFLAGS_NONE,
    ACTIVEFLAGS_NONE,
    ACTIVEFLAGS_NONE,
    ACTIVEFLAGS_NONE,
    ACTIVEFLAGS_NONE,
    ACTIVEFLAGS_NONE,
    ACTIVEFLAGS_NONE
};

const int16_t horizontalLaunchRayTable[] = {
    0 , 1 , 2 , 3 , 3 , 3 , 3 , 3 ,
    13, 13, 13, 13, 13, 13, 14, 15,
    16, 17, 18, 19, 19, 19, 19, 19,
    29, 29, 29, 29, 29, 29, 30, 31
};

const int16_t parachute_sprite_table[6] = {
    0, 1, 2, 3, 2, 1
};

// The movement mask & 15 indexes into this to see the desired playerAngle. -1 is not valid
const int16_t playerJoyAngles[16] = {
    -1, 24, 0 , 28, 8 , -1, 4 , -1,
    16, 20, -1, -1, 12, -1, -1, -1
};

const int16_t stageBossAudio[5] = {
    AUDIO_BOSSL0,
    AUDIO_BOSSL1,
    AUDIO_BOSSL2,
    AUDIO_BOSSL3,
    AUDIO_BOSSL4
};

const uint16_t stageLabelColor[3] = {
    TP_COLOR_WHITE, TP_COLOR_BLUE, TP_COLOR_RED
};

const char** stageLabelText[5] = {
    &TEXT_PERIOD0_1910,
    &TEXT_PERIOD1_1940,
    &TEXT_PERIOD2_1970,
    &TEXT_PERIOD3_1982,
    &TEXT_PERIOD4_2001
};

/* This array nees some explanation:
   Position index (into timeWarpDrawX)
   Length (Start at position index and increment length times drawing a row of this sprite)
   frame from sprite sheet
   length again, but if -1 end this draw run
   You can reat this as something like:
   starting at position 5 (so 88), 3 sprites from frame 0 and yeild; then
   stating at 72, 5 sprites from frame 0; yield, etc.
*/
const int16_t timeWarpDrawScript[] = {
    5,3,0,-1,
    4,5,0,-1,
    3,7,0,-1,
    2,9,0,-1,
    1,11,0,-1,
    0,13,0,-1,
    0,13,0,5,3,1,-1,
    0,13,0,4,5,1,-1,
    0,13,0,3,7,1,5,3,2,-1,
    0,13,0,2,9,1,4,5,2,6,1,3,-1,
    0,13,0,2,9,1,4,5,2,6,1,3,-1,
    0,13,0,2,9,1,4,5,2,6,1,3,-1,
    0,13,0,2,9,1,4,5,2,6,1,3,-1,
    0,13,0,3,7,1,5,3,2,-1,
    0,13,0,4,5,1,-1,
    0,13,0,5,3,1,-1,
    0,13,0,-1,
    1,11,0,-1,
    2,9,0,-1,
    3,7,0,-1,
    4,5,0,-1,
    5,3,0,-1,
    -1
};

const int16_t timeWarpDrawX[13] = {
    8,
    24,
    40,
    56,
    72,
    88,
    104,
    120,
    136,
    152,
    168,
    184,
    200
};

//-----------------------------------------------------------------------------
// Replay data
uint8_t demoAttractBuffer[DEMO_ATTRACT_LENGTH] = {
    0x00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,
    0x00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,
    0x00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,
    0x00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,
    0x00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X08,0X09,0X09,0X09,0X09,0X09,
    0x09,0X09,0X09,0X09,0X09,0X09,0X08,0X08,0X08,0X08,0X0C,0X0C,0X04,0X04,0X04,0X04,
    0x04,0X06,0X06,0X06,0X06,0X06,0X06,0X06,0X02,0X02,0X02,0X02,0X02,0X03,0X03,0X03,
    0x01,0X01,0X01,0X01,0X01,0X01,0X01,0X01,0X09,0X09,0X09,0X09,0X09,0X09,0X01,0X01,
    0x01,0X01,0X03,0X03,0X03,0X03,0X03,0X03,0X43,0X43,0X43,0X02,0X02,0X02,0X02,0X02,
    0x03,0X01,0X41,0X49,0X49,0X49,0X09,0X08,0X08,0X08,0X08,0X48,0X48,0X49,0X49,0X09,
    0x09,0X09,0X09,0X01,0X00,0X08,0X08,0X08,0X08,0X08,0X48,0X48,0X48,0X4C,0X0C,0X0C,
    0x04,0X04,0X0C,0X08,0X08,0X08,0X09,0X09,0X01,0X01,0X01,0X01,0X41,0X41,0X41,0X01,
    0x09,0X09,0X09,0X49,0X49,0X49,0X08,0X08,0X0C,0X0C,0X0C,0X08,0X09,0X03,0X43,0X43,
    0x43,0X03,0X03,0X03,0X03,0X02,0X42,0X42,0X42,0X02,0X02,0X06,0X06,0X04,0X44,0X44,
    0x44,0X0C,0X0C,0X08,0X48,0X48,0X48,0X08,0X08,0X08,0X08,0X08,0X08,0X4C,0X4C,0X4C,
    0x44,0X04,0X04,0X04,0X04,0X04,0X04,0X06,0X06,0X06,0X06,0X06,0X06,0X06,0X06,0X06,
    0x06,0X06,0X04,0X44,0X4C,0X4C,0X4C,0X0C,0X0C,0X0C,0X0C,0X04,0X04,0X04,0X04,0X04,
    0x04,0X04,0X04,0X04,0X0C,0X0C,0X0C,0X0C,0X0C,0X0C,0X0C,0X0C,0X0C,0X0C,0X0C,0X0C,
    0x0C,0X4C,0X4C,0X4C,0X48,0X48,0X09,0X09,0X01,0X01,0X01,0X03,0X03,0X03,0X03,0X03,
    0x43,0X41,0X41,0X09,0X09,0X09,0X09,0X01,0X43,0X43,0X03,0X01,0X01,0X09,0X09,0X09,
    0x09,0X09,0X09,0X08,0X08,0X09,0X01,0X41,0X43,0X43,0X43,0X43,0X03,0X03,0X03,0X42,
    0x42,0X42,0X02,0X02,0X02,0X46,0X44,0X44,0X0C,0X0C,0X0C,0X0C,0X0C,0X0C,0X0C,0X0C,
    0x0C,0X08,0X08,0X09,0X01,0X01,0X01,0X01,0X01,0X03,0X03,0X43,0X43,0X43,0X03,0X03,
    0x03,0X02,0X02,0X02,0X02,0X02,0X02,0X02,0X02,0X02,0X06,0X06,0X44,0X44,0X04,0X04,
    0x04,0X04,0X04,0X06,0X42,0X42,0X03,0X03,0X03,0X03,0X02,0X02,0X42,0X42,0X42,0X03,
    0x03,0X01,0X01,0X09,0X49,0X09,0X09,0X09,0X08,0X08,0X08,0X4C,0X4C,0X0C,0X0C,0X0C,
    0x0C,0X0C,0X0C,0X0C,0X0C,0X48,0X49,0X49,0X09,0X09,0X09,0X09,0X09,0X09,0X08,0X08,
    0x08,0X08,0X48,0X48,0X48,0X08,0X08,0X09,0X09,0X09,0X09,0X09,0X08,0X08,0X08,0X48,
    0x4C,0X4C,0X4C,0X0C,0X0C,0X0C,0X0C,0X0C,0X0C,0X0C,0X0C,0X08,0X08,0X09,0X49,0X41,
    0x41,0X03,0X03,0X03,0X03,0X03,0X02,0X02,0X42,0X40,0X48,0X08,0X08,0X08,0X48,0X48,
    0x48,0X08,0X08,0X08,0X08,0X48,0X48,0X08,0X0C,0X0C,0X0C,0X0C,0X4C,0X44,0X04,0X04,
    0x00,0X40,0X40,0X40,0X00,0X00,0X00,0X00,0X00,0X00,0X08,0X08,0X08,0X08,0X08,0X4C,
    0x4C,0X0C,0X08,0X08,0X08,0X09,0X00,0X40,0X44,0X44,0X04,0X04,0X04,0X0C,0X48,0X48,
    0x48,0X08,0X00,0X00,0X40,0X40,0X40,0X00,0X00,0X00,0X40,0X40,0X40,0X02,0X02,0X06,
    0x42,0X42,0X42,0X02,0X02,0X02,0X42,0X42,0X42,0X42,0X02,0X02,0X02,0X42,0X40,0X00,
    0x00,0X00,0X00,0X40,0X40,0X44,0X04,0X04,0X04,0X44,0X44,0X44,0X04,0X04,0X04,0X44,
    0x44,0X00,0X00,0X00,0X00,0X00,0X00,0X40,0X41,0X41,0X49,0X09,0X09,0X09,0X09,0X49,
    0x49,0X49,0X09,0X09,0X01,0X01,0X41,0X41,0X41,0X03,0X03,0X03,0X03,0X03,0X03,0X03,
    0x43,0X42,0X42,0X03,0X01,0X09,0X09,0X09,0X09,0X09,0X09,0X01,0X43,0X43,0X03,0X03,
    0x03,0X03,0X03,0X03,0X02,0X42,0X42,0X42,0X02,0X02,0X02,0X02,0X02,0X02,0X02,0X02,
    0x02,0X02,0X02,0X02,0X02,0X46,0X44,0X44,0X04,0X04,0X0C,0X0C,0X0C,0X0C,0X4C,0X4C,
    0x4C,0X0C,0X04,0X04,0X04,0X04,0X04,0X0C,0X4C,0X4C,0X4C,0X0C,0X0C,0X0C,0X4C,0X4C,
    0x48,0X08,0X08,0X08,0X08,0X48,0X48,0X48,0X08,0X08,0X08,0X08,0X48,0X48,0X48,0X08,
    0x08,0X08,0X08,0X48,0X48,0X49,0X01,0X03,0X03,0X43,0X43,0X43,0X03,0X03,0X02,0X40,
    0x48,0X08,0X08,0X08,0X48,0X48,0X48,0X08,0X09,0X01,0X43,0X43,0X03,0X03,0X03,0X03,
    0x03,0X42,0X42,0X02,0X02,0X02,0X02,0X02,0X02,0X02,0X02,0X40,0X40,0X48,0X08,0X08,
    0x08,0X08,0X48,0X48,0X48,0X08,0X08,0X08,0X48,0X49,0X49,0X09,0X09,0X09,0X08,0X4C,
    0x4C,0X4C,0X04,0X04,0X04,0X04,0X44,0X44,0X44,0X46,0X06,0X06,0X06,0X46,0X42,0X42,
    0x02,0X02,0X01,0X09,0X49,0X49,0X09,0X09,0X08,0X08,0X48,0X08,0X00,0X00,0X40,0X40,
    0x40,0X00,0X00,0X00,0X48,0X48,0X08,0X08,0X08,0X48,0X42,0X02,0X02,0X02,0X42,0X42,
    0x42,0X02,0X02,0X02,0X02,0X42,0X42,0X02,0X02,0X02,0X02,0X42,0X42,0X02,0X02,0X02,
    0x02,0X02,0X03,0X03,0X03,0X03,0X43,0X41,0X41,0X41,0X01,0X01,0X01,0X01,0X49,0X49,
    0x09,0X09,0X01,0X03,0X03,0X03,0X03,0X41,0X41,0X49,0X09,0X08,0X08,0X08,0X08,0X08,
    0x08,0X08,0X08,0X08,0X44,0X44,0X44,0X46,0X46,0X06,0X06,0X06,0X06,0X06,0X06,0X42,
    0x42,0X42,0X02,0X02,0X03,0X03,0X41,0X41,0X01,0X08,0X08,0X48,0X48,0X48,0X08,0X08,
    0x08,0X48,0X48,0X48,0X08,0X08,0X08,0X08,0X48,0X48,0X08,0X08,0X0C,0X0C,0X48,0X48,
    0x48,0X08,0X08,0X08,0X48,0X48,0X08,0X08,0X08,0X08,0X49,0X49,0X49,0X01,0X09,0X08,
    0x48,0X48,0X48,0X08,0X08,0X08,0X48,0X48,0X08,0X08,0X08,0X08,0X08,0X08,0X48,0X41,
    0x41,0X01,0X03,0X03,0X43,0X43,0X43,0X03,0X03,0X03,0X03,0X41,0X41,0X03,0X03,0X03,
    0x03,0X03,0X43,0X43,0X43,0X03,0X03,0X03,0X03,0X02,0X42,0X42,0X42,0X02,0X02,0X02,
    0x42,0X42,0X46,0X06,0X04,0X04,0X04,0X46,0X46,0X46,0X06,0X06,0X06,0X06,0X04,0X44,
    0x44,0X0C,0X08,0X08,0X08,0X48,0X49,0X09,0X09,0X09,0X41,0X41,0X41,0X01,0X01,0X41,
    0x41,0X00,0X00,0X00,0X40,0X40,0X40,0X00,0X00,0X40,0X48,0X08,0X08,0X08,0X48,0X48,
    0x08,0X00,0X00,0X40,0X40,0X00,0X00,0X00,0X00,0X40,0X40,0X00,0X08,0X08,0X49,0X49,
    0x01,0X02,0X02,0X42,0X40,0X40,0X00,0X00,0X08,0X48,0X48,0X48,0X08,0X08,0X08,0X48,
    0x48,0X00,0X00,0X00,0X00,0X40,0X40,0X00,0X00,0X08,0X08,0X48,0X48,0X00,0X00,0X00,
    0x40,0X40,0X40,0X00,0X00,0X00,0X40,0X40,0X41,0X01,0X01,0X00,0X40,0X40,0X00,0X00,
    0x41,0X41,0X40,0X00,0X40,0X40,0X40,0X00,0X00,0X00,0X02,0X02,0X42,0X42,0X02,0X02,
    0x02,0X02,0X02,0X46,0X46,0X06,0X00,0X00,0X00,0X40,0X40,0X40,0X00,0X02,0X02,0X02,
    0x02,0X42,0X42,0X42,0X02,0X02,0X00,0X00,0X40,0X40,0X00,0X04,0X04,0X04,0X44,0X4C,
    0x0C,0X0C,0X00,0X00,0X40,0X40,0X00,0X00,0X40,0X42,0X42,0X02,0X02,0X02,0X02,0X43,
    0x43,0X03,0X03,0X01,0X01,0X01,0X00,0X40,0X44,0X44,0X04,0X04,0X04,0X04,0X44,0X44,
    0x00,0X00,0X00,0X40,0X44,0X44,0X04,0X04,0X04,0X0C,0X4C,0X4C,0X4C,0X08,0X08,0X08,
    0x40,0X40,0X40,0X00,0X00,0X00,0X00,0X40,0X44,0X44,0X06,0X06,0X02,0X02,0X42,0X42,
    0x42,0X42,0X02,0X02,0X02,0X43,0X41,0X41,0X01,0X01,0X01,0X49,0X49,0X49,0X08,0X08,
    0x08,0X48,0X48,0X08,0X08,0X48,0X48,0X48,0X08,0X08,0X08,0X08,0X48,0X48,0X41,0X01,
    0x01,0X01,0X01,0X41,0X41,0X41,0X09,0X09,0X08,0X48,0X48,0X48,0X08,0X08,0X08,0X48,
    0x4C,0X48,0X08,0X08,0X08,0X08,0X0C,0X0C,0X0C,0X0C,0X0C,0X0C,0X0C,0X0C,0X0C,0X0C,
    0x0C,0X0C,0X0C,0X0C,0X48,0X49,0X41,0X41,0X01,0X01,0X01,0X49,0X49,0X49,0X09,0X09,
    0x01,0X41,0X43,0X43,0X43,0X03,0X01,0X09,0X09,0X09,0X08,0X48,0X08,0X08,0X08,0X08,
    0x08,0X08,0X08,0X48,0X48,0X48,0X48,0X08,0X08,0X08,0X08,0X48,0X48,0X09,0X01,0X00,
    0x00,0X40,0X40,0X48,0X08,0X09,0X09,0X08,0X48,0X48,0X48,0X04,0X04,0X04,0X04,0X44,
    0x44,0X44,0X04,0X0C,0X08,0X08,0X48,0X48,0X48,0X08,0X08,0X0C,0X4C,0X4C,0X4C,0X04,
    0x04,0X04,0X44,0X44,0X44,0X44,0X0C,0X0C,0X08,0X08,0X48,0X48,0X48,0X08,0X08,0X08,
    0x08,0X48,0X49,0X49,0X09,0X01,0X01,0X41,0X43,0X43,0X03,0X03,0X03,0X03,0X43,0X43,
    0x42,0X02,0X02,0X03,0X43,0X43,0X43,0X03,0X03,0X01,0X40,0X42,0X46,0X06,0X02,0X02,
    0x43,0X41,0X01,0X09,0X09,0X09,0X09,0X09,0X09,0X01,0X01,0X03,0X43,0X41,0X49,0X49,
    0x09,0X08,0X0C,0X44,0X44,0X44,0X44,0X04,0X04,0X04,0X04,0X44,0X44,0X44,0X04,0X04,
    0x04,0X00,0X08,0X48,0X48,0X48,0X08,0X08,0X08,0X08,0X49,0X49,0X09,0X09,0X09,0X09,
    0x09,0X49,0X48,0X48,0X08,0X04,0X04,0X44,0X44,0X40,0X03,0X03,0X03,0X43,0X43,0X43,
    0x43,0X03,0X03,0X43,0X43,0X43,0X43,0X03,0X03,0X03,0X43,0X42,0X42,0X02,0X02,0X02,
    0x02,0X42,0X40,0X00,0X00,0X00,0X40,0X40,0X40,0X01,0X01,0X01,0X03,0X43,0X43,0X03,
    0x03,0X03,0X41,0X41,0X49,0X09,0X09,0X09,0X09,0X09,0X09,0X09,0X49,0X49,0X49,0X09,
    0x09,0X09,0X08,0X48,0X4C,0X44,0X04,0X04,0X04,0X46,0X46,0X46,0X06,0X06,0X02,0X42,
    0x42,0X42,0X03,0X03,0X03,0X41,0X41,0X01,0X01,0X01,0X01,0X41,0X41,0X49,0X09,0X09,
    0x08,0X48,0X48,0X08,0X00,0X02,0X02,0X02,0X02,0X02,0X02,0X02,0X42,0X42,0X42,0X43,
    0x01,0X01,0X01,0X01,0X01,0X41,0X49,0X09,0X09,0X08,0X08,0X48,0X48,0X08,0X09,0X09,
    0x09,0X48,0X48,0X08,0X08,0X08,0X08,0X08,0X48,0X48,0X48,0X09,0X09,0X01,0X41,0X41,
    0x41,0X03,0X03,0X03,0X03,0X43,0X43,0X03,0X03,0X03,0X03,0X03,0X03,0X43,0X43,0X42,
    0x02,0X01,0X01,0X41,0X41,0X41,0X03,0X03,0X03,0X43,0X42,0X02,0X02,0X02,0X02,0X42,
    0x42,0X43,0X01,0X01,0X01,0X49,0X49,0X41,0X41,0X03,0X03,0X43,0X41,0X41,0X09,0X09,
    0x09,0X09,0X09,0X09,0X08,0X08,0X08,0X08,0X08,0X48,0X48,0X48,0X08,0X08,0X08,0X0C,
    0x0C,0X4C,0X44,0X44,0X44,0X04,0X04,0X04,0X46,0X46,0X46,0X06,0X06,0X06,0X04,0X04,
    0x44,0X44,0X44,0X04,0X04,0X04,0X04,0X04,0X44,0X44,0X00,0X08,0X08,0X09,0X49,0X49,
    0x09,0X09,0X09,0X01,0X41,0X41,0X01,0X01,0X01,0X01,0X41,0X41,0X41,0X01,0X01,0X03,
    0x03,0X09,0X49,0X48,0X08,0X08,0X08,0X08,0X48,0X48,0X4C,0X0C,0X0C,0X0C,0X04,0X04,
    0x44,0X44,0X44,0X04,0X04,0X04,0X04,0X04,0X44,0X44,0X4C,0X0C,0X08,0X08,0X08,0X08,
    0x08,0X08,0X08,0X48,0X4C,0X44,0X44,0X04,0X04,0X04,0X44,0X44,0X46,0X06,0X06,0X06,
    0x06,0X06,0X46,0X46,0X06,0X02,0X02,0X02,0X41,0X41,0X01,0X01,0X01,0X09,0X49,0X49,
    0x09,0X09,0X09,0X40,0X40,0X00,0X00,0X00,0X40,0X49,0X49,0X09,0X00,0X00,0X40,0X40,
    0x40,0X00,0X01,0X03,0X03,0X42,0X42,0X02,0X02,0X02,0X02,0X43,0X41,0X41,0X01,0X09,
    0x09,0X09,0X49,0X49,0X01,0X01,0X03,0X03,0X43,0X43,0X43,0X03,0X03,0X03,0X03,0X41,
    0x41,0X41,0X03,0X03,0X02,0X02,0X02,0X42,0X42,0X42,0X02,0X02,0X02,0X42,0X46,0X46,
    0x04,0X08,0X08,0X08,0X48,0X48,0X08,0X08,0X08,0X00,0X40,0X40,0X00,0X00,0X08,0X48,
    0x48,0X44,0X04,0X06,0X46,0X42,0X42,0X02,0X02,0X02,0X02,0X42,0X42,0X42,0X02,0X03,
    0x01,0X41,0X41,0X41,0X01,0X09,0X09,0X40,0X40,0X00,0X00,0X00,0X40,0X40,0X00,0X00,
    0x00,0X40,0X40,0X00,0X00,0X00,0X40,0X00,0X00,0X40,0X49,0X49,0X09,0X49,0X49,0X40,
    0x00,0X40,0X40,0X40,0X00,0X00,0X40,0X40,0X40,0X00,0X00,0X40,0X40,0X40,0X00,0X00,
    0x00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,
    0x00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,
    0x00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,
    0x00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,
    0x00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00,0X00
};

//-----------------------------------------------------------------------------
void dataCleanup() {
    uint16_t i;

    for(i = 0; i < numSpriteFiles; i++) {
        tigrFree(*spritePtrs[i]);
    }

    for(i=0; i < NUM_AUDIO_SOURCES; i++) {
        if(audioSourceHandles[i]) {
            alDeleteSources(1, &audioSourceHandles[i]);
        }
        if(audioSourceBuffers[i]) {
            alDeleteBuffers(1, &audioSourceBuffers[i]);
        }
    }
}

//-----------------------------------------------------------------------------
int16_t dataInit() {
    uint16_t i;
    char fileName[64];

    // First the graphics
    for(i = 0; i < numSpriteFiles; i++) {
        sprintf(fileName, "sprites/%s.png", spriteFileNames[i]);
        *spritePtrs[i] = tigrLoadImage(fileName);
        if(!*spritePtrs[i]) {
            printf("FATAL - File not found: %s\n", fileName);
            return 0;
        }
    }
    font = tigrLoadFont(fontSprites, TCP_ASCII);
    if(!font) {
        printf("FATAL - font could not be created.\n");
        return 0;
    }

    // Set all handles and buffers to 0 (not init)
    for(i = 0; i < NUM_AUDIO_SOURCES; i++) {
        audioSourceHandles[i] = audioSourceBuffers[i] = 0;
    }

    // Then load the sound if and while audio is init
    if(audioIsInit) {
        for(i = 0; i < NUM_AUDIO_SOURCES; i++) {
            sprintf(fileName, "audio/%s.wav", audioSourceFileNames[i]);
            audioSourceBuffers[i] = alutCreateBufferFromFile(fileName);
            if(audioSourceBuffers[i]) {
                alGenSources(1, &audioSourceHandles[i]);
                alSourcei(audioSourceHandles[i], AL_BUFFER, audioSourceBuffers[i]);
            } else {
                printf("Audio for %s not created\n", fileName);
            }
        }
        audioConfigSource(AUDIO_HIGHSCORE, AL_LOOPING, AL_TRUE);
        audioConfigSource(AUDIO_BOSSL0, AL_LOOPING, AL_TRUE);
        audioConfigSource(AUDIO_BOSSL1, AL_LOOPING, AL_TRUE);
        audioConfigSource(AUDIO_BOSSL2, AL_LOOPING, AL_TRUE);
        audioConfigSource(AUDIO_BOSSL3, AL_LOOPING, AL_TRUE);
        audioConfigSource(AUDIO_ROCKET_FLY, AL_LOOPING, AL_TRUE);
    }
    return 1;
}
