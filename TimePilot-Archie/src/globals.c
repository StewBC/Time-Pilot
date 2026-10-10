//-----------------------------------------------------------------------------
// globals.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "archie.h"
#include "globals.h"

#include "resids.h"

// Archie Specific
int global_quit = 0;

// PaletteHandle archiePalette;
// GWorldPtr offScreen;
// PixMapHandle offScreenPixels;
Point spritePos;
Point displayPoint;
Rect gameRect;
Rect screenRect;
Rect spriteClipRect;                    // the rectangle to clip to
// RGBColor colors[TP_NUM_COLORS];
// RgnHandle archieOriginalGrayRgn;
// short archieMenuBarHeight;
tSpriteInfo *spritePtrs[SID_L1BOMBER7_PROP + 1];
uint32_t drawBackgroundColor;
uint32_t globalScale;
uint32_t keyMask;
uint32_t rowBytes;                      // the row bytes of the pixmap
unsigned char *baseAddr;                // the base address of the pixmap
unsigned char rawKey;
// WindowPtr screen;

// Game
uint32_t aiSpawnTimer;
int32_t bulletTimer;
int32_t bomberTimer;
int32_t levelBossTimer;
int32_t parachuteTimer;
int32_t playerExitTimer;
int32_t prePlayTimer;
int32_t scoreTimer;
int32_t introColorTimer;
uint32_t frameCounter;

uint32_t activePlayer;
uint32_t activeSky;
uint32_t activeStage;
int32_t aiEnemiesAlive;
uint32_t bomberHealth;
uint32_t colId0;
uint32_t colId1;
uint32_t enemiesKilled;
uint32_t enemyScore;
uint32_t exitGameMask;
uint32_t gameOver;
uint32_t inputMask;
uint32_t inputMaskDebounced;
uint32_t inputMaskPrev;
uint32_t inputMaskRepeat;
uint32_t inputRepeatRate;
int32_t invPlayerAngle;
int32_t launchSide;
uint32_t levelBossHealth;
uint32_t numberOfAIFollowers;
uint32_t numberOfAIFollowersMax;
uint32_t numberOfEnemies;
uint32_t numberOfPlayers;
uint32_t numberOfPlayersAlive;
uint32_t numberOfRockets;
uint32_t numberOfTracked;
uint32_t numberOfTrackedMax;
uint32_t numberOfWaveEnemies;
uint32_t parachuteScore;
uint32_t playerAngle;
uint32_t playerExtraLife;
int32_t playerLives;
uint32_t playerNextExtraLife;
uint32_t playerScore;
int32_t randomSeed;
int32_t readFrameStall;
uint32_t stageIntroState;
int32_t spawnX;
int32_t spawnY;
int32_t waveSpawnL;
int32_t waveSpawnR;
int32_t waveSpawnDir;
int32_t waveSpawnDuration;
int32_t waveSpawnIndex;
int32_t waveSpawnNumber;

// Per-player Game State Variables
uint32_t playersActiveStage[2];
uint32_t playersEnemiesKilled[2];
uint32_t playersExtraLife[2];
uint32_t playersLevelBossHealth[2];
uint32_t playersLives[2];
uint32_t playersNextExtraLife[2];
uint32_t playersScore[2];
uint32_t playersStageIntroState[2];

// Print Buffer
char printBuffer[SCOL + 1];

// High-score tracking and display
uint32_t highScore[5];
uint32_t highScoresDisplay;

// Stage Vars
uint32_t activeBMPIdx[MAX_OBJECTS];
uint32_t activeCollides[MAX_OBJECTS];
uint32_t activeColsig[MAX_OBJECTS];
int32_t activeEID[MAX_OBJECTS];
int32_t activeExtra[MAX_OBJECTS];
uint32_t activeFlags[MAX_OBJECTS];
int32_t activeFrame[MAX_OBJECTS];
int32_t activeHeight[MAX_OBJECTS];
uint32_t activeLayer[MAX_OBJECTS];
int32_t activeMaxX[MAX_OBJECTS];
int32_t activeMaxY[MAX_OBJECTS];
int32_t activeMinX[MAX_OBJECTS];
int32_t activeMinY[MAX_OBJECTS];
uint32_t activeOffScreen[MAX_OBJECTS];
int32_t activeOldX[MAX_OBJECTS];
int32_t activeOldY[MAX_OBJECTS];
int32_t activePosX[MAX_OBJECTS];
int32_t activePosY[MAX_OBJECTS];
int32_t activeWidth[MAX_OBJECTS];

int32_t *activeTimer = activeExtra;     // Alias for activeExtra - just for readability
int32_t *activeHeading = activeExtra;   // Alias for activeExtra
int32_t enemyHeading[ACTIVEFLAGS_ENEMYMASK + 1];
int32_t enemyID[ACTIVEFLAGS_ENEMYMASK + 1];
int32_t enemyWeapon[ACTIVEFLAGS_ENEMYMASK + 1];

// Hardware
int32_t inputUsingJoystick;

// Tracking, sorting & drawing
uint32_t insertThings;
int32_t introColorOffset;
uint32_t numSortedThingIDs;
int32_t sortedThingIDs[MAX_OBJECTS];

// Demo Mode
int32_t demoAttractIndex;
int32_t demoAttractLength;
int32_t demoAttractMode;
uint32_t demoAttractScore;
#ifdef  RECORD_REPLAY
int32_t demoRecordMode;
#endif

// Audio
// SndChannelPtr audioSourceChannels[AUDIO_CHANNELS];
// Handle audioSourceHandles[AUDIO_WAVE_START + 1];
int32_t audio_channel;
int32_t audioIsInit;

// Temp locals in the UI file
uint32_t uiInitialsColor;
uint32_t uiInsertRow;
uint32_t uiLetter;
uint32_t uiLetterIndex;
uint32_t uiState;
int32_t uiTimer;

//-----------------------------------------------------------------------------
// One time only init
void globalsInit() {
    // Non-Zero
    highScore[0] = 658;
    highScore[1] = 80;
    highScore[2] = 68;
    highScore[3] = 65;
    highScore[4] = 40;
    highScoresDisplay = 658;
    randomSeed = -1;

    // Zero
    audioIsInit = 0;
    demoAttractLength = DEMO_ATTRACT_LENGTH;
    demoAttractMode = 0;
    inputUsingJoystick = -1;
}

//-----------------------------------------------------------------------------
void globalsGameInit() {
    uint32_t i;
    for(i = 0; i < 2; i++) {
        // Non-zero
        playersLives[i] = 2;
        playersNextExtraLife[i] = 100;

        // Zero
        playersActiveStage[i] = 0;      // TIME_PERIOD0_1910    playersEnemiesKilled[i] = 0;
        playersExtraLife[i] = 0;
        playersLevelBossHealth[i] = 0;
        playersScore[i] = 0;
        playersStageIntroState[i] = 0;
    }
    // Non-Zero
    activeSky = -1;

    // Zero
    activePlayer = 0;
    demoAttractIndex = 0;
    exitGameMask = 0;
}


//-----------------------------------------------------------------------------
// Some of this will be redundant but this way I am sure the replay works
void globalsStageInit() {
    uint32_t i;
    for(i = 0; i < MAX_OBJECTS; i++) {
        activeCollides[i] = 0;
        activeColsig[i] = 0;
        activeEID[i] = 0;
        activeExtra[i] = 0;
        activeFlags[i] = 0;
        activeFrame[i] = 0;
        activeHeight[i] = 0;
        activeLayer[i] = 0;
        activeMaxX[i] = 0;
        activeMaxY[i] = 0;
        activeMinX[i] = 0;
        activeMinY[i] = 0;
        activeOffScreen[i] = 0;
        activeOldX[i] = 0;
        activeOldY[i] = 0;
        activePosX[i] = 0;
        activePosY[i] = 0;
        activeWidth[i] = 0;
        sortedThingIDs[i] = 0;
    }

    for(i = 0; i < ACTIVEFLAGS_ENEMYMASK + 1; i++) {
        // Non-Zero
        enemyID[i] = 2 * MAX_OBJECTS;
        enemyWeapon[i] = 2 * MAX_OBJECTS;

        // Zero
        enemyHeading[i] = 0;
    }

    // Non-zero
    aiSpawnTimer = 1;
    bomberHealth = BOMBER_HEALTH;
    enemyScore = 1;
    invPlayerAngle = PLAYER_FRAME_LEFT;
    levelBossTimer = LEVELBOSS_TIMER;
    numberOfAIFollowersMax = 2;
    numberOfTrackedMax = 2;
    readFrameStall = KEY_READ_RATE;

    // Zero
    aiEnemiesAlive = 0;
    bomberTimer = 0;
    bulletTimer = 0;
    exitGameMask = 0;
    frameCounter = 0;
    inputMask = 0;
    inputMaskDebounced = 0;
    inputMaskPrev = 0;
    inputMaskRepeat = 0;
    inputRepeatRate = 0;
    insertThings = 0;
    introColorOffset = 0;
    introColorTimer = 0;
    launchSide = 0;
    numberOfAIFollowers = 0;
    numberOfEnemies = 0;
    numberOfRockets = 0;
    numberOfTracked = 0;
    numberOfWaveEnemies = 0;
    numSortedThingIDs = 0;
    parachuteScore = 0;
    playerAngle = 0;
    playerExitTimer = 0;
    scoreTimer = 0;
    waveSpawnDir = 0;
    waveSpawnDuration = 0;
    waveSpawnIndex = 0;
    waveSpawnL = 0;
    waveSpawnNumber = 0;
    waveSpawnR = 0;
}
