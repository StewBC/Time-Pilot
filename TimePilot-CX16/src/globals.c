//-----------------------------------------------------------------------------
// globals.c
// Part of Time Pilot, the 1982 arcade game remake for the Commander X16
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include <stdint.h>
#include "globals.h"

// Timers
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

// General gameplay variables
uint8_t     activePlayer;
uint8_t     activeSky;
uint8_t     activeStage;
int8_t      aiEnemiesAlive;
uint8_t     bomberHealth;
uint16_t    enemiesKilled;
uint8_t     enemyScore;
uint16_t    exitGameMask;
uint16_t    inputMask;
uint16_t    inputMaskDebounced;
uint16_t    inputMaskPrev;
uint16_t    inputMaskRepeat;
uint8_t     inputRepeatRate;
int8_t      invPlayerAngle;
int8_t      launchSide;
uint8_t     levelBossHealth;
uint8_t     numberOfAIFollowers;
uint8_t     numberOfAIFollowersMax;
uint8_t     numberOfEnemies;
uint8_t     numberOfPlayers;
uint8_t     numberOfPlayersAlive;
uint8_t     numberOfRockets;
uint8_t     numberOfTracked;
uint8_t     numberOfTrackedMax;
uint8_t     numberOfWaveEnemies;
uint8_t     parachuteScore;
uint8_t     playerAngle;
uint16_t    playerExtraLife;
int8_t      playerLives;
uint16_t    playerNextExtraLife;
uint16_t    playerScore;
uint8_t     propState;
int8_t      randomSeed;
int16_t     readFrameStall;
uint8_t     stageIntroState;
int16_t     spawnX;
int16_t     spawnY;
int8_t      waveSpawnL;
int8_t      waveSpawnR;
int8_t      waveSpawnDir;
int8_t      waveSpawnDuration;
int8_t      waveSpawnIndex;
int8_t      waveSpawnNumber;

// Per-player Game State Variables
uint8_t     playersActiveStage[2];
uint16_t    playersEnemiesKilled[2];
uint16_t    playersExtraLife[2];
uint8_t     playersLevelBossHealth[2];
uint8_t     playersLives[2];
uint16_t    playersNextExtraLife[2];
uint16_t    playersScore[2];
uint8_t     playersStageIntroState[2];

// Print Buffer
char        printBuffer[SCOL];

// High-score tracking and display
uint16_t    highScore[5];
uint16_t    highScoresDisplay;

// Stage Vars
uint8_t     activeCollides[MAX_OBJECTS];
uint8_t     activeColsig[MAX_OBJECTS];
int8_t      activeExtra[MAX_OBJECTS];
uint16_t    activeFlags[MAX_OBJECTS];
int8_t      activeFrame[MAX_OBJECTS];
int8_t      activeHeight[MAX_OBJECTS];
uint8_t     activeLayer[MAX_OBJECTS];
int16_t     activeMaxX[MAX_OBJECTS];
int16_t     activeMaxY[MAX_OBJECTS];
int16_t     activeMinX[MAX_OBJECTS];
int16_t     activeMinY[MAX_OBJECTS];
uint8_t     activeOffScreen[MAX_OBJECTS];
int16_t     activeOldX[MAX_OBJECTS];
int16_t     activeOldY[MAX_OBJECTS];
int8_t      activeWidth[MAX_OBJECTS];
uint16_t    activeXVelFrac[MAX_OBJECTS];
uint16_t    activeYVelFrac[MAX_OBJECTS];

int8_t*     activeTimer = activeExtra;    // Alias for activeExtra - just for readability
int8_t*     activeHeading = activeExtra;  // Alias for activeExtra

// One for each on-screen enemy
int8_t      enemyHeading[ACTIVEFLAGS_ENEMYMASK+1];
uint8_t     enemyID[ACTIVEFLAGS_ENEMYMASK+1];
uint8_t     enemyWeapon[ACTIVEFLAGS_ENEMYMASK+1];

// Hardware
int8_t      inputUsingJoystick;

// Tracking, sorting & drawing
uint8_t     drawIndex;
int8_t      introColorOffset;
uint8_t     numSortedThingIDs;
int8_t      sortedThingIDs[MAX_OBJECTS];

// Demo Mode
int16_t     demoAttractIndex;
int16_t     demoAttractLength;
int8_t      demoAttractMode;
uint16_t    demoAttractScore;
#ifdef  RECORD_REPLAY
int8_t      demoRecordMode;
#endif

// Audio
uint8_t     audioCurrentBank;
uint16_t    audioEndAddress;
uint8_t     audioEndBank;
uint16_t    audioIndex;
int8_t      audioIsInit;
int8_t      audioIsPlaying;
int8_t      audioLoopingSample;

// Temp locals in the Things file
uint8_t     colId0;
uint8_t     colId1;
uint8_t     index0;
uint8_t     index1;
uint8_t     reduce;
uint8_t     sortKey;
int16_t     sortKeyValue;

// Temp locals in the UI file
uint8_t     uiInitialsColor;
uint8_t     uiInsertRow;
uint8_t     uiLetter;
uint8_t     uiLetterIndex;
uint8_t     uiState;
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
    audioCurrentBank = 0;
    audioEndAddress = 0;
    audioEndBank = 0;
    audioIsInit = 0;
    audioIsPlaying = -1;
    audioLoopingSample = -1;
    demoAttractLength = DEMO_ATTRACT_LENGTH;
    demoAttractMode = 0;
    inputUsingJoystick = 0;
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
    propState = 0;
    scoreTimer = 0;
    waveSpawnDir = 0;
    waveSpawnDuration = 0;
    waveSpawnIndex = 0;
    waveSpawnL = 0;
    waveSpawnNumber = 0;
    waveSpawnR = 0;
}
