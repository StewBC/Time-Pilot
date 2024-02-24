//-----------------------------------------------------------------------------
// globals.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "tigr.h"
#include "globals.h"

// Tigr
TPixel      colors[16];
TPixel      drawBackgroundColor;
TigrFont*   font;
Tigr*       screen;
TPixel      skyColors[5];

uint16_t    aiSpawnTimer;
int16_t     bulletTimer;
int16_t     bomberTimer;
int16_t     levelBossTimer;
int16_t     parachuteTimer;
int16_t     playerExitTimer;
int16_t     prePlayTimer;
int16_t     scoreTimer;
int16_t     introColorTimer;
uint16_t    frameCounter;

uint16_t    activePlayer;
uint16_t    activeSky;
uint16_t    activeStage;
int16_t     aiEnemiesAlive;
uint16_t    bomberHealth;
uint16_t    enemiesKilled;
uint16_t    enemyScore;
uint16_t    exitGameMask;
uint16_t    gameOver;
uint16_t    inputMask;
uint16_t    inputMaskDebounced;
uint16_t    inputMaskPrev;
uint16_t    inputMaskRepeat;
uint16_t    inputRepeatRate;
int16_t     invPlayerAngle;
int16_t     launchSide;
uint16_t    levelBossHealth;
uint16_t    numberOfAIFollowers;
uint16_t    numberOfAIFollowersMax;
uint16_t    numberOfEnemies;
uint16_t    numberOfPlayers;
uint16_t    numberOfPlayersAlive;
uint16_t    numberOfRockets;
uint16_t    numberOfTracked;
uint16_t    numberOfTrackedMax;
uint16_t    numberOfWaveEnemies;
uint16_t    parachuteScore;
uint16_t    playerAngle;
uint16_t    playerExtraLife;
int16_t     playerLives;
uint16_t    playerNextExtraLife;
uint16_t    playerScore;
int16_t     randomSeed;
int16_t     readFrameStall;
uint16_t    stageIntroState;
int16_t     spawnX;
int16_t     spawnY;
int16_t     waveSpawnL;
int16_t     waveSpawnR;
int16_t     waveSpawnDir;
int16_t     waveSpawnDuration;
int16_t     waveSpawnIndex;
int16_t     waveSpawnNumber;

// Per-player Game State Variables
uint16_t    playersActiveStage[2];
uint16_t    playersEnemiesKilled[2];
uint16_t    playersExtraLife[2];
uint16_t    playersLevelBossHealth[2];
uint16_t    playersLives[2];
uint16_t    playersNextExtraLife[2];
uint16_t    playersScore[2];
uint16_t    playersStageIntroState[2];

// Print Buffer
char         printBuffer[SCOL];

// High-score tracking and display
uint16_t    highScore[5];
uint16_t    highScoresDisplay;

// Stage Vars
uint16_t    activeBMPIdx[MAX_OBJECTS];
uint16_t    activeCollides[MAX_OBJECTS];
uint16_t    activeColsig[MAX_OBJECTS];
int16_t     activeExtra[MAX_OBJECTS];
uint16_t    activeFlags[MAX_OBJECTS];
int16_t     activeFrame[MAX_OBJECTS];
int16_t     activeHeight[MAX_OBJECTS];
uint16_t    activeLayer[MAX_OBJECTS];
int16_t     activeMaxX[MAX_OBJECTS];
int16_t     activeMaxY[MAX_OBJECTS];
int16_t     activeMinX[MAX_OBJECTS];
int16_t     activeMinY[MAX_OBJECTS];
uint16_t    activeOffScreen[MAX_OBJECTS];
int16_t     activeOldX[MAX_OBJECTS];
int16_t     activeOldY[MAX_OBJECTS];
int16_t     activeWidth[MAX_OBJECTS];
uint16_t    activeXVelFrac[MAX_OBJECTS];
uint16_t    activeYVelFrac[MAX_OBJECTS];

int16_t*    activeTimer = activeExtra;      // Alias for activeExtra - just for readability
int16_t*    activeHeading = activeExtra;    // Alias for activeExtra

int16_t     enemyHeading[ACTIVEFLAGS_ENEMYMASK+1];
int16_t     enemyID[ACTIVEFLAGS_ENEMYMASK+1];
int16_t     enemyWeapon[ACTIVEFLAGS_ENEMYMASK+1];

// Hardware
int16_t     inputUsingJoystick;
int16_t     scanLine;

// Tracking, sorting & drawing
uint16_t    drawIndex;
uint16_t    eraseIndex;
int16_t     eraseThingIDs[MAX_OBJECTS];
uint16_t    insertThings;
int16_t     introColorOffset;
uint16_t    numSortedThingIDs;
int16_t     sortedThingIDs[MAX_OBJECTS];

// Demo Mode
int16_t      demoAttractIndex;
int16_t      demoAttractLength;
int16_t      demoAttractMode;
uint16_t     demoAttractScore;
#ifdef  RECORD_REPLAY
int16_t      demoRecordMode;
#endif

// Audio
int16_t     audioIsInit;
ALuint      audioSourceBuffers[NUM_AUDIO_SOURCES];
ALuint      audioSourceHandles[NUM_AUDIO_SOURCES];

// Temp locals in the Things file
uint16_t    colId0;
uint16_t    colId1;
uint16_t    endIndex;
uint16_t    index0;
uint16_t    index1;
uint16_t    reduce;
uint16_t    sortKey;
 int16_t    sortKeyValue;
uint16_t    startIndex;

// Temp locals in the UI file
uint16_t    uiInitialsColor;
uint16_t    uiInsertRow;
uint16_t    uiLetter;
uint16_t    uiLetterIndex;
uint16_t    uiState;
int16_t     uiTimer;

//-----------------------------------------------------------------------------
// One time only init
void globalsInit() {
    // Non-Zero
    highScore[0] = 658;
    highScore[1] =  80;
    highScore[2] =  68;
    highScore[3] =  65;
    highScore[4] =  40;
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
    uint8_t i;
    for(i = 0; i < 2; i++) {
        // Non-zero
        playersLives[i] = 2;
        playersNextExtraLife[i] = 100;

        // Zero
        playersActiveStage[i] = 0;      // TIME_PERIOD0_1910
        playersEnemiesKilled[i] = 0;
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
    uint8_t i;
    for(i = 0; i < MAX_OBJECTS; i++) {
        activeCollides[i] = 0;
        activeColsig[i] = 0;
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
        activeWidth[i] = 0;
        activeXVelFrac[i] = 0;
        activeYVelFrac[i] = 0;
        sortedThingIDs[i] = 0;
    }

    for(i = 0; i < ACTIVEFLAGS_ENEMYMASK+1; i++) {
        // Non-Zero
        enemyID[i] = 128;
        enemyWeapon[i] = 128;

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
    drawIndex = 0;
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
