//-----------------------------------------------------------------------------
// globals.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

// Constants
// System
// NDX              = $A00A
#define VERA_SPRITES_BASE           0xFC00
#define VERA_LAYER0                 0x0000
#define VERA_LAYER1                 0xB000
#define VERA_COLOR_PALETTE          0xFA00

#define PLAYFIELDH                  30
#define PLAYFIELDW                  28
#define SROW                        30  // Screen Rows
#define SROWH                       8   // Screen Row Height
#define SCOL                        40  // Screen Columns
#define SCOLW                       8   // Screem Column Width
#define SCREEN_PLAYAREA_BOTTOM      (PLAYFIELDH*SROWH)
#define SCREEN_PLAYAREA_RIGHT       (PLAYFIELDW*SCOLW)
#define SCREENH                     (SROW*SROWH)
#define SCREENW                     (SCOL*SCOLW)
#define MID_SCREENY                 (PLAYFIELDH/2)


#define ASBITS(X)                   (X > 8 ? X > 16 ? X > 32 ? 3 : 2 : 1 : 0)
#define ENCODE_SIZE(W,H)            ((ASBITS(H) << 6) | ASBITS(W) << 4)
#define FRAME_OFFSET(x,y)           ((((x)*(y))/2)>>5)

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
#define PLAYER_Y                    112

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

// UI (non-)Layers
#define UI_LAYER_PROGRESS           (LAYER_NUM_LAYERS)
#define UI_LAYER_STAGE              (LAYER_NUM_LAYERS+1)
#define UI_LAYER_TIME               (LAYER_NUM_LAYERS+2)
#define UI_LAYER_PILOT              (LAYER_NUM_LAYERS+3)
#define UI_LAYER_BLANK1             (LAYER_NUM_LAYERS+4)
#define UI_LAYER_BLANK2             (LAYER_NUM_LAYERS+5)

// Active Flags
#define ACTIVEFLAGS_NONE            0
#define ACTIVEFLAGS_ISDEAD          0b0000000000001000
#define ACTIVEFLAGS_UNUSED          0b0000000000010000
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
#define ACTIVEFLAGS_MULTIPURPOSE    0b1000000000000000 // Note - This flag is multi-putpose |'d with below for clarity
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
#define EXPLOSION_TYPE_16X16        0
#define EXPLOSION_TYPE_32X16        1
#define EXPLOSION_TYPE_BOOM11X11    2
#define EXPLOSION_TYPE_SBLT13X13    3
#define EXPLOSION_TYPE_WEP16X16     4
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
#define INPUT_SCAN                  0b0000010000000000
#define INPUT_MASK_MOVEMENT         0b0000000000111111
#define INPUT_REPEAT_RATE           UI_COLORCYCLE_TIMER

#define TP_GAMEPAD_RIGHT            (1<<0)
#define TP_GAMEPAD_LEFT             (1<<1)
#define TP_GAMEPAD_DOWN             (1<<2)
#define TP_GAMEPAD_UP               (1<<3)
#define TP_GAMEPAD_START            (1<<4)
#define TP_GAMEPAD_BACK             (1<<5)
#define TP_GAMEPAD_X                (1<<6)
#define TP_GAMEPAD_A                (1<<7)
#define TP_GAMEPAD_RT               (1<<12)
#define TP_GAMEPAD_LT               (1<<13)
#define TP_GAMEPAD_Y                (1<<14)
#define TP_GAMEPAD_B                (1<<15)

// UI
// Misc Sprite indicies
#define UI_SPR_EXTRA_LIVES         64
#define NUM_UI_SPR_EXTRA_LIVES     6
#define UI_SPR_STAGE_INDEX         (UI_SPR_EXTRA_LIVES+NUM_UI_SPR_EXTRA_LIVES)
#define NUM_UI_SPR_STAGE_INDEX     5
#define UI_SPR_PROGRESS            (UI_SPR_STAGE_INDEX+NUM_UI_SPR_STAGE_INDEX)
#define NUM_UI_SPR_PROGRESS        2
#define UI_SPR_LOGO                (UI_SPR_PROGRESS+NUM_UI_SPR_PROGRESS)
#define NUM_UI_SPR_LOGO            2
#define NUM_LAST_UISPR             (UI_SPR_LOGO+NUM_UI_SPR_LOGO-1)

// Score Sprites
#define SCORE_1000                  0
#define SCORE_2000                  1
#define SCORE_3000                  2
#define SCORE_4000                  3
#define SCORE_5000                  4
#define SCORE_1500                  5
#define NUM_SCORES                  6

// Audio
#define AUDIO_COINDROP              0
#define AUDIO_GAME_START            1
#define AUDIO_HIGHSCORE             2
#define AUDIO_NEXT_LEVEL            3
#define AUDIO_PLAYER_SHOOT          4
#define AUDIO_ROCKET_FLY            5
#define AUDIO_BOSSL0                6
#define AUDIO_BOSSL1                7
#define AUDIO_BOSSL2                8
#define AUDIO_BOSSL3                9
#define AUDIO_WAPON_EXPLODE         10
#define AUDIO_ENEMY_EXPLODE         11
#define AUDIO_ENEMY_SHOOT           12
#define AUDIO_BOMB                  13
#define AUDIO_ROCKET_LAUNCH         14
#define AUDIO_PICKUP                15
#define AUDIO_EXTRA_LIFE            16
#define AUDIO_WAVE_START            17
#define AUDIO_BIG_EXPLOSION         18
#define AUDIO_TIMEWARP              19
#define NUM_AUDIO_SOURCES           20

#define AUDIO_BOOOMERANG            20
#define AUDIO_ENEMY_SHOOT_SPACE     21
#define AUDIO_STAGE_CLEAR           22
#define AUDIO_BOSSL4                23

// Global Variables
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
extern uint8_t      activePlayer;
extern uint8_t      activeSky;
extern uint8_t      activeStage;
extern int8_t       aiEnemiesAlive;
extern uint8_t      bomberHealth;
extern uint16_t     enemiesKilled;
extern uint8_t      enemyScore;
extern uint16_t     exitGameMask;
extern uint16_t     inputMask;
extern uint16_t     inputMaskDebounced;
extern uint16_t     inputMaskPrev;
extern uint16_t     inputMaskRepeat;
extern uint8_t      inputRepeatRate;
extern int8_t       invPlayerAngle;
extern int8_t       launchSide;
extern uint8_t      levelBossHealth;
extern uint8_t      numberOfAIFollowers;
extern uint8_t      numberOfAIFollowersMax;
extern uint8_t      numberOfEnemies;
extern uint8_t      numberOfPlayers;
extern uint8_t      numberOfPlayersAlive;
extern uint8_t      numberOfRockets;
extern uint8_t      numberOfTracked;
extern uint8_t      numberOfTrackedMax;
extern uint8_t      numberOfWaveEnemies;
extern uint8_t      parachuteScore;
extern uint8_t      playerAngle;
extern uint16_t     playerExtraLife;
extern int8_t       playerLives;
extern uint16_t     playerNextExtraLife;
extern uint16_t     playerScore;
extern uint8_t      propState;
extern int8_t       randomSeed;
extern int16_t      readFrameStall;
extern uint8_t      stageIntroState;
extern int16_t      spawnX;
extern int16_t      spawnY;
extern int8_t       waveSpawnL;
extern int8_t       waveSpawnR;
extern int8_t       waveSpawnDir;
extern int8_t       waveSpawnDuration;
extern int8_t       waveSpawnIndex;
extern int8_t       waveSpawnNumber;

// Per-player Game State Variables
extern uint8_t      playersActiveStage[2];
extern uint16_t     playersEnemiesKilled[2];
extern uint16_t     playersExtraLife[2];
extern uint8_t      playersLevelBossHealth[2];
extern uint8_t      playersLives[2];
extern uint16_t     playersNextExtraLife[2];
extern uint16_t     playersScore[2];
extern uint8_t      playersStageIntroState[2];

// Print Buffer
extern char         printBuffer[SCOL];

// High-score tracking and display
extern uint16_t     highScore[5];
extern uint16_t     highScoresDisplay;

// Stage Vars
extern uint8_t      activeCollides[MAX_OBJECTS];
extern uint8_t      activeColsig[MAX_OBJECTS];
extern int8_t       activeExtra[MAX_OBJECTS];
extern uint16_t     activeFlags[MAX_OBJECTS];
extern int8_t       activeFrame[MAX_OBJECTS];
extern int8_t       activeHeight[MAX_OBJECTS];
extern uint8_t      activeLayer[MAX_OBJECTS];
extern int16_t      activeMaxX[MAX_OBJECTS];
extern int16_t      activeMaxY[MAX_OBJECTS];
extern int16_t      activeMinX[MAX_OBJECTS];
extern int16_t      activeMinY[MAX_OBJECTS];
extern uint8_t      activeOffScreen[MAX_OBJECTS];
extern int16_t      activeOldX[MAX_OBJECTS];
extern int16_t      activeOldY[MAX_OBJECTS];
extern int8_t       activeWidth[MAX_OBJECTS];
extern uint16_t     activeXVelFrac[MAX_OBJECTS];
extern uint16_t     activeYVelFrac[MAX_OBJECTS];

extern int8_t*      activeTimer;    // Alias for activeExtra - just for readability
extern int8_t*      activeHeading;  // Alias for activeExtra

// One for each on-screen enemy
extern int8_t       enemyHeading[ACTIVEFLAGS_ENEMYMASK+1];
extern uint8_t      enemyID[ACTIVEFLAGS_ENEMYMASK+1];
extern uint8_t      enemyWeapon[ACTIVEFLAGS_ENEMYMASK+1];

// Hardware
extern int8_t       inputUsingJoystick;

// Tracking, sorting & drawing
extern uint8_t      drawIndex;
extern int8_t       introColorOffset;
extern uint8_t      numSortedThingIDs;
extern int8_t       sortedThingIDs[MAX_OBJECTS];

// Demo Mode
extern int16_t      demoAttractIndex;
extern int16_t      demoAttractLength;
extern int8_t       demoAttractMode;
extern uint16_t     demoAttractScore;
// also reset DEMO_ATTRACT_LENGTH to around 2500 when recording
// #define RECORD_REPLAY
#ifdef  RECORD_REPLAY
extern int8_t       demoRecordMode;
#endif
#define DEMO_ATTRACT_LENGTH 1472
// This is filled in, in fata.c
extern uint8_t      demoAttractBuffer[DEMO_ATTRACT_LENGTH];

// Audio
extern uint8_t      audioCurrentBank;
extern uint16_t     audioEndAddress;
extern uint8_t      audioEndBank;
extern uint16_t     audioIndex;
extern int8_t       audioIsInit;
extern int8_t       audioIsPlaying;
extern int8_t       audioLoopingSample;

// Temp locals in the Things file
extern uint8_t      colId0;
extern uint8_t      colId1;
extern uint8_t      index0;
extern uint8_t      index1;
extern uint8_t      reduce;
extern uint8_t      sortKey;
extern int16_t      sortKeyValue;

// Temp locals in the UI file
extern uint8_t      uiInitialsColor;
extern uint8_t      uiInsertRow;
extern uint8_t      uiLetter;
extern uint8_t      uiLetterIndex;
extern uint8_t      uiState;
extern int16_t      uiTimer;

void globalsInit();
void globalsGameInit();
void globalsStageInit();
