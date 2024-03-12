//-----------------------------------------------------------------------------
// globals.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

// Types
#include <stdint.h>
#include <AL/alut.h>

// Constants
// System
#define PLAYFIELDH                  25
#define PLAYFIELDW                  28
#define SROW                        25  // Screen Rows
#define SROWH                       8   // Screen Row Height
#define SCOL                        40  // Screen Columns
#define SCOLW                       8   // Screem Column Width
#define SCREEN_PLAYAREA_BOTTOM      (PLAYFIELDH*SROWH)
#define SCREEN_PLAYAREA_RIGHT       (PLAYFIELDW*SCOLW)
#define SCREENH                     (SROW*SROWH)
#define SCREENW                     (SCOL*SCOLW)

// Colors
#define TP_COLOR_BLACK              0
#define TP_COLOR_RED                1
#define TP_COLOR_GREEN              2
#define TP_COLOR_BLUE               3
#define TP_COLOR_YELLOW             4
#define TP_COLOR_ORANGE             5
#define TP_COLOR_MAGENTA            6
#define TP_COLOR_CYAN               7
#define TP_COLOR_GRAY               8
#define TP_COLOR_WHITE              9
#define TP_COLOR_DARK_RED           10
#define TP_COLOR_DARK_GREEN         11
#define TP_COLOR_DARK_BLUE          12
#define TP_COLOR_DARK_YELLOW        13
#define TP_COLOR_SKY                14
#define TP_COLOR_EXTRA              15

// Game
// State
#define EXIT_PLAYER_DIED            0b100
#define EXIT_STAGE_CLEAR            0b010
#define EXIT_USER_QUIT              0b001

// Tunables
#define BOMBER_HEALTH               4
#define ENEMIES_TO_KILL_TO_CLEAR    48 // This is only 85% of what it should be at 56
#define LEVELBOSS_HEALTH            8
#define MAX_OBJECTS                 64
#define NUM_PROGRESS_PLANES         (((SCOL-PLAYFIELDW)*SCOLW)/16)
#define KEY_READ_RATE               2
#define WRAP_SIZE                   46

#define PLAYER_X                    104
#define PLAYER_Y                    92

// Periods
#define TIME_PERIOD0_1910           0
#define TIME_PERIOD1_1940           1
#define TIME_PERIOD2_1970           2
#define TIME_PERIOD3_1982           3
#define TIME_PERIOD4_2001           4
#define NUM_PERIODS                 5

// Layers (Not spawn-thing IDs)
#define LAYER_CLOUDS0               0
#define LAYER_ASTROS0               1
#define LAYER_CLOUDS1               2
#define LAYER_ASTROS1               3
#define LAYER_ENEMY_BULLETS         4
#define LAYER_ENEMY_SPACEBULLETS    5
#define LAYER_ENEMY_BOMBS           6
#define LAYER_ENEMY_ROCKETS         7
#define LAYER_ENEMY_BOOMERANG       8
#define LAYER_ENEMY                 9
#define LAYER_PLAYER_BULLETS        10
#define LAYER_PARACHUTE             11
#define LAYER_BOMBER                12
#define LAYER_LEVELBOSS             13
#define LAYER_WARP                  14
#define LAYER_PLAYER                15
#define LAYER_CLOUDS2               16
#define LAYER_ASTROS2               17
#define LAYER_SCORES                18
#define LAYER_NUM_LAYERS            19

// Active Flags
#define ACTIVEFLAGS_NONE            0
#define ACTIVEFLAGS_ISDEAD          0b0000000000001000
#define ACTIVEFLAGS_ERASED          0b0000000000010000
#define ACTIVEFLAGS_WRAPS           0b0000000000100000
#define ACTIVEFLAGS_INUSE           0b0000000001000000
#define ACTIVEFLAGS_CLIPLX          0b0000000010000000
#define ACTIVEFLAGS_CLIPRX          0b0000000100000000
#define ACTIVEFLAGS_CLIPTY          0b0000001000000000
#define ACTIVEFLAGS_CLIPBY          0b0000010000000000
#define ACTIVEFLAGS_REMOVE          0b0000100000000000
#define ACTIVEFLAGS_AI_FOLLOW       0b0001000000000000
#define ACTIVEFLAGS_AI_FLEE         0b0010000000000000
#define ACTIVEFLAGS_AI_WAVE         0b0100000000000000
#define ACTIVEFLAGS_MULTIPURPOSE    0b1000000000000000 // Note - This flag is multi-putpose
#define ACTIVEFLAGS_TRACKED         0b1000000000000000 // Multi = tracked
#define ACTIVEFLAGS_DIR_RIGHT       0b1000000000000000 // Multi = direction

#define ACTIVEFLAGS_CLIPMASK        (ACTIVEFLAGS_CLIPLX|ACTIVEFLAGS_CLIPRX|ACTIVEFLAGS_CLIPTY|ACTIVEFLAGS_CLIPBY)
#define ACTIVEFLAGS_ENEMYMASK       0b0000000000000111

// Active Offscreen
#define ACTIVEOFFSCREEN_COUNT       0b0000000000110000 // $30

// Collision bits
#define COLLIDE_NONE               0
#define COLLIDE_ENEMY              0b0000000000000001  // 1|0
#define COLLIDE_ENEMY_BULLETS      0b0000000000000010  // 1|1
#define COLLIDE_ENEMY_ROCKETS      0b0000000000000100  // 1|2
#define COLLIDE_PARACHUTE          0b0000000000001000  // 1|3
#define COLLIDE_PLAYER_BULLETS     0b0000000000010000  // 1|4
#define COLLIDE_PLAYER             0b0000000000100000  // 1|5

// Explosion
#define EXPLOSION_FRAMES            4

// Velocities
#define VELOCITY_050                0
#define VELOCITY_075                32
#define VELOCITY_100                64
#define VELOCITY_119                96
#define VELOCITY_150                128
#define VELOCITY_200                160
#define VELOCITY_400                192
#define VELOCITY_NUMBERS            7

// Player frames / 2 because it's not double in "C" for 16-bit lookups
#define PLAYER_FRAME_RIGHT          (0/2)
#define PLAYER_FRAME_DOWN           (16/2)
#define PLAYER_FRAME_LEFT           (32/2)
#define PLAYER_FRAME_UP             (48/2)
#define PLAYER_FRAME_LAST           (62/2)

// Timers
#define BOMBER_TIMER                (60*5)
#define ENEMY_RECALL_TIMER          ((ENEMY_SPAWN_TIMER+1)*18) // Approx 9 seconds - has to be even checked inside !(aiSpawnTimer & ENEMY_SPAWN_TIMER)
#define ENEMY_SPAWN_TIMER           (0b00011111)               // Approx .5 seconds
#define ENEMY_SPAWN_WAVE_TIMER      ((ENEMY_SPAWN_TIMER+1)*20) // Approx 10 seconds - has to be even checked inside !(aiSpawnTimer & ENEMY_SPAWN_TIMER)
#define ENEMY_STEADY_MIN_TIME       ((3*60)/8)                 // Min time between dir changes
#define ENEMY_WAVE_ACTIVE_TIMER     ((1.5*60)/8)               // div 8 becase AI thinks only every 8 frames
#define ENEMY_WAVE_ENTRY_TIMER      (60/8)                     // div 8 becase AI thinks only every 8 frames
#define EXPLOSION_HOLD_TIMER        (60/6)
#define HIGHSCORE_ENTRY_TIME        (136)                      // 34s UI_COLORCYCLE_TIMER related
#define INTRO_COLOR_CYCLE_TIME      (60/8)
#define LEVELBOSS_TIMER             (60*2)
#define PARACHUTE_TIMER             (60*9)
#define PLAYER_ANNOUNCE_TIMER       (60*3)
#define PLAYER_BULLET_FIRE_TIMER    (3*8)
#define PLAYER_DIED_TIMER           (60*3)
#define SCORE_MULT_TIMER            (60/2)
#define STAGE_ANNOUNCE_TIMER        (60*5)
#define UI_COLORCYCLE_TIMER         (60/4)
#define UI_GAME_OVER_TIMER          (60*3)
#define UI_STATE_TIMER              (60*5)
#define WAVE_TO_FOLLOW_TIME         (60)

// input
#define INPUT_NONE                  0
#define INPUT_UP                    0b0000000000000001
#define INPUT_RIGHT                 0b0000000000000010
#define INPUT_DOWN                  0b0000000000000100
#define INPUT_LEFT                  0b0000000000001000
#define INPUT_ROTATE_LEFT           0b0000000000010000
#define INPUT_ROTATE_RIGHT          0b0000000000100000
#define INPUT_FIRE                  0b0000000001000000
#define INPUT_PAUSE                 0b0000000010000000
#define INPUT_QUIT                  0b0000000100000000
#define INPUT_2P                    0b0000001000000000
#define INPUT_MASK_MOVEMENT         0b0000000000111111
#define INPUT_REPEAT_RATE           UI_COLORCYCLE_TIMER

// Score Sprites
#define SCORE_1000                  0
#define SCORE_2000                  1
#define SCORE_3000                  2
#define SCORE_4000                  3
#define SCORE_5000                  4
#define SCORE_1500                  5
#define NUM_SCORES                  6

// Audio
#define AUDIO_BIG_EXPLOSION         0
#define AUDIO_BOMB                  1
#define AUDIO_BOOOMERANG            2
#define AUDIO_BOSSL0                3
#define AUDIO_BOSSL1                4
#define AUDIO_BOSSL2                5
#define AUDIO_BOSSL3                6
#define AUDIO_BOSSL4                7
#define AUDIO_COINDROP              8
#define AUDIO_ENEMY_EXPLODE         9
#define AUDIO_ENEMY_SHOOT           10
#define AUDIO_ENEMY_SHOOT_SPACE     11
#define AUDIO_EXTRA_LIFE            12
#define AUDIO_GAME_START            13
#define AUDIO_HIGHSCORE             14
#define AUDIO_NEXT_LEVEL            15
#define AUDIO_PICKUP                16
#define AUDIO_PLAYER_SHOOT          17
#define AUDIO_ROCKET_FLY            18
#define AUDIO_ROCKET_LAUNCH         19
#define AUDIO_STAGE_CLEAR           20
#define AUDIO_TIMEWARP              21
#define AUDIO_WAPON_EXPLODE         22
#define AUDIO_WAVE_START            23
#define NUM_AUDIO_SOURCES           24

// Global Variables

// Tigr specific
extern TPixel       colors[16];
extern TPixel       drawBackgroundColor;
extern TigrFont*    font;
extern Tigr*        screen;
extern TPixel       skyColors[5];

// Timers
extern uint16_t     aiSpawnTimer;
extern int16_t      bulletTimer;
extern int16_t      bomberTimer;
extern int16_t      levelBossTimer;
extern int16_t      parachuteTimer;
extern int16_t      playerExitTimer;
extern int16_t      prePlayTimer;
extern int16_t      scoreTimer;
extern int16_t      introColorTimer;
extern uint16_t     frameCounter;

// General gameplay variables
extern uint16_t     activePlayer;
extern uint16_t     activeSky;
extern uint16_t     activeStage;
extern int16_t      aiEnemiesAlive;
extern uint16_t     bomberHealth;
extern uint16_t     colId0;
extern uint16_t     colId1;
extern uint16_t     enemiesKilled;
extern uint16_t     enemyScore;
extern uint16_t     exitGameMask;
extern uint16_t     gameOver;
extern uint16_t     inputMask;
extern uint16_t     inputMaskDebounced;
extern uint16_t     inputMaskPrev;
extern uint16_t     inputMaskRepeat;
extern uint16_t     inputRepeatRate;
extern int16_t      invPlayerAngle;
extern int16_t      launchSide;
extern uint16_t     levelBossHealth;
extern uint16_t     numberOfAIFollowers;
extern uint16_t     numberOfAIFollowersMax;
extern uint16_t     numberOfEnemies;
extern uint16_t     numberOfPlayers;
extern uint16_t     numberOfPlayersAlive;
extern uint16_t     numberOfRockets;
extern uint16_t     numberOfTracked;
extern uint16_t     numberOfTrackedMax;
extern uint16_t     numberOfWaveEnemies;
extern uint16_t     parachuteScore;
extern uint16_t     playerAngle;
extern uint16_t     playerExtraLife;
extern int16_t      playerLives;
extern uint16_t     playerNextExtraLife;
extern uint16_t     playerScore;
extern int16_t      randomSeed;
extern int16_t      readFrameStall;
extern uint16_t     stageIntroState;
extern int16_t      spawnX;
extern int16_t      spawnY;
extern int16_t      waveSpawnL;
extern int16_t      waveSpawnR;
extern int16_t      waveSpawnDir;
extern int16_t      waveSpawnDuration;
extern int16_t      waveSpawnIndex;
extern int16_t      waveSpawnNumber;

// Per-player Game State Variables
extern uint16_t     playersActiveStage[2];
extern uint16_t     playersEnemiesKilled[2];
extern uint16_t     playersExtraLife[2];
extern uint16_t     playersLevelBossHealth[2];
extern uint16_t     playersLives[2];
extern uint16_t     playersNextExtraLife[2];
extern uint16_t     playersScore[2];
extern uint16_t     playersStageIntroState[2];

// Print Buffer
extern char         printBuffer[SCOL];

// High-score tracking and display
extern uint16_t     highScore[5];
extern uint16_t     highScoresDisplay;

// Stage Vars
extern uint16_t     activeBMPIdx[MAX_OBJECTS];
extern uint16_t     activeCollides[MAX_OBJECTS];
extern uint16_t     activeColsig[MAX_OBJECTS];
extern int16_t      activeExtra[MAX_OBJECTS];
extern uint16_t     activeFlags[MAX_OBJECTS];
extern int16_t      activeFrame[MAX_OBJECTS];
extern int16_t      activeHeight[MAX_OBJECTS];
extern uint16_t     activeLayer[MAX_OBJECTS];
extern int16_t      activeMaxX[MAX_OBJECTS];
extern int16_t      activeMaxY[MAX_OBJECTS];
extern int16_t      activeMinX[MAX_OBJECTS];
extern int16_t      activeMinY[MAX_OBJECTS];
extern uint16_t     activeOffScreen[MAX_OBJECTS];
extern int16_t      activeOldX[MAX_OBJECTS];
extern int16_t      activeOldY[MAX_OBJECTS];
extern int16_t      activeWidth[MAX_OBJECTS];
extern uint16_t     activeXVelFrac[MAX_OBJECTS];
extern uint16_t     activeYVelFrac[MAX_OBJECTS];

extern int16_t*     activeTimer;    // Alias for activeExtra - just for readability
extern int16_t*     activeHeading;  // Alias for activeExtra

// One for each on-screen enemy
extern int16_t      enemyHeading[ACTIVEFLAGS_ENEMYMASK+1];
extern int16_t      enemyID[ACTIVEFLAGS_ENEMYMASK+1];
extern int16_t      enemyWeapon[ACTIVEFLAGS_ENEMYMASK+1];

// Hardware
extern int16_t      inputUsingJoystick;
extern int16_t      scanLine;

// Tracking, sorting & drawing
extern uint16_t     drawIndex;
extern uint16_t     eraseIndex;
extern int16_t      eraseThingIDs[MAX_OBJECTS];
extern uint16_t     insertThings;
extern int16_t      introColorOffset;
extern uint16_t     numSortedThingIDs;
extern int16_t      sortedThingIDs[MAX_OBJECTS];

// Demo Mode
extern int16_t      demoAttractIndex;
extern int16_t      demoAttractLength;
extern int16_t      demoAttractMode;
extern uint16_t     demoAttractScore;
// also reset DEMO_ATTRACT_LENGTH to around 2500 when recording
// #define RECORD_REPLAY
#ifdef  RECORD_REPLAY
extern int16_t      demoRecordMode;
#endif
#define DEMO_ATTRACT_LENGTH 1968
// This is filled in, in fata.c
extern uint8_t      demoAttractBuffer[DEMO_ATTRACT_LENGTH];

// Audio
extern int16_t      audioIsInit;
extern ALuint       audioSourceBuffers[NUM_AUDIO_SOURCES];
extern ALuint       audioSourceHandles[NUM_AUDIO_SOURCES];

// Temp locals in the UI file
extern uint16_t     uiInitialsColor;
extern uint16_t     uiInsertRow;
extern uint16_t     uiLetter;
extern uint16_t     uiLetterIndex;
extern uint16_t     uiState;
extern int16_t      uiTimer;

void globalsInit();
void globalsGameInit();
void globalsStageInit();
