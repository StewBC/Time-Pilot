;-----------------------------------------------------------------------------
; globals.s
; Part of Time Pilot, the 1982 arcade game remake for the Apple IIgs
;
; Stefan Wessels, 2024
; This is free and unencumbered software released into the public domain.
;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------
; Apple locations, soft-switches and constants
RASTER_LINE               gequ  $E0C02E
SCREEN_BASE               gequ  $012000
SCANLINE_CONTROL_BYTE     gequ  $019D00
PALETTE_BASE              gequ  $019E00
KBD                       gequ  $01C000
KBDSTRB                   gequ  $01C010
VBL                       gequ  $01C019
SHR                       gequ  $01C029
BORDER                    gequ  $01C034
SHADOWR                   gequ  $01C035
BUTN0                     gequ  $01C061              ; Switch input 0 / Open-Apple key
BUTN1                     gequ  $01C062              ; Switch input 1 / Closed-Apple key
BUTN2                     gequ  $01C063              ; Switch input 2 / Shift key
PADDL0                    gequ  $01C064              ; Read to get POT msb
PTRIG                     gequ  $01C070
STATEREG                  gequ  $E1C068              ; State Reg - b7=ALTZP PAGE2 RAMRD RAMWRT RDROM LCBNK2 ROMBANK INTCXROM=b0

;-----------------------------------------------------------------------------
; Game values related to the hardware screen

; System
NTSC_TOP                  gequ  $100
PLAYFIELDH                gequ  25
PLAYFIELDW                gequ  28
SCOL                      gequ  40                   ; Screen Columns
SCOLW                     gequ  8                    ; Screen Column Width
SROW                      gequ  25                   ; Screen Rows
SROWH                     gequ  8                    ; Screen Row Height

SCREEN_BYTES              gequ  160*200
SCREEN_PBOTTOM            gequ  PLAYFIELDH*SROWH
SCREEN_PRIGHT             gequ  PLAYFIELDW*SCOLW
SCREEN_ROW_BASE           gequ  $010000
SCREENH                   gequ  SROW*SROWH
SCREENW                   gequ  SCOL*SCOLW

; Colors
COLOR_BLACK               gequ  0
COLOR_WHITE               gequ  1
COLOR_RED                 gequ  2
COLOR_CYAN                gequ  3
COLOR_MAGENTA             gequ  4
COLOR_GREEN               gequ  5
COLOR_BLUE                gequ  6
COLOR_YELLOW              gequ  7
COLOR_ORANGE              gequ  8
COLOR_GRAY                gequ  9
COLOR_DARK_RED            gequ  10
COLOR_OLIVE_GREEN         gequ  11                   ; Doubles up as dark blue in space
COLOR_DARK_YELLOW         gequ  12
COLOR_PROP0               gequ  13
COLOR_PROP1               gequ  14
COLOR_SKY                 gequ  15

; Game
; State
EXIT_PLAYER_DIED          gequ  %100
EXIT_STAGE_CLEAR          gequ  %010
EXIT_USER_QUIT            gequ  %001

; Tuneables
BOMBER_HEALTH             gequ  4
ENEMIES_TO_KILL_TO_CLEAR  gequ  48                   ; This is only 85% of what it should be at 56
BOSS_HEALTH               gequ  8
MAX_OBJECTS               gequ  64
NUM_PROGRESS_PLANES       gequ  6                    ; SCOL-PLAYFIELDW*SCOLW/16
KEY_READ_RATE             gequ  2
WRAP_SIZE                 gequ  46
WEAPON_BORDER             gequ  4*8

PLAYER_X                  gequ  104
PLAYER_Y                  gequ  92

; Periods
TIME_PERIOD0_1910         gequ  0
TIME_PERIOD1_1940         gequ  2
TIME_PERIOD2_1970         gequ  4
TIME_PERIOD3_1982         gequ  6
TIME_PERIOD4_2001         gequ  8
NUM_PERIODS               gequ  10

; Layers (Not spawn-thing IDs)
LAYER_CLOUDS0             gequ  $00
LAYER_CLOUDS1             gequ  $02
LAYER_EXPLODE_LARGE       gequ  $04
LAYER_EXPLODE_ROCKETS     gequ  $06
LAYER_EXPLODE_SMALL       gequ  $08
LAYER_EXPLODE_BULLETS     gequ  $0A
LAYER_PARACHUTE           gequ  $0C
LAYER_SCORES              gequ  $0E
LAYER_ROCKETS             gequ  $10
LAYER_ENEMY               gequ  $12
LAYER_BULLETS             gequ  $14
LAYER_PLAYER_BULLETS      gequ  $16
LAYER_BOMBER              gequ  $18
LAYER_BOSS                gequ  $1A
LAYER_WARP                gequ  $1C
LAYER_PLAYER              gequ  $1E
LAYER_CLOUDS2             gequ  $20
LAYER_TEXT                gequ  $22

; Active Flags
AF_NONE                   gequ  0
AF_ISDEAD                 gequ  %0000000000001000
AF_ERASED                 gequ  %0000000000010000
AF_WRAPS                  gequ  %0000000000100000
AF_INUSE                  gequ  %0000000001000000
AF_CLIPLX                 gequ  %0000000010000000
AF_CLIPRX                 gequ  %0000000100000000
AF_CLIPTY                 gequ  %0000001000000000
AF_CLIPBY                 gequ  %0000010000000000
AF_REMOVE                 gequ  %0000100000000000
AF_AI_FOLLOW              gequ  %0001000000000000
AF_AI_FLEE                gequ  %0010000000000000
AF_AI_WAVE                gequ  %0100000000000000
AF_TRACKED                gequ  %1000000000000000    ; Multipurpose = tracked
AF_DIR_RIGHT              gequ  %1000000000000000    ; Multipurpose = direction

AF_CLIPMASK               gequ  %0000011110000000

; Active Offscreen
ACTIVEOFFSCREEN_COUNT     gequ  %0000000000110000    ; $30

; Collision bits
COLLIDE_NONE              gequ  0
COLLIDE_ENEMY             gequ  %0000000000000001    ; 1|0
COLLIDE_ENEMY_BULLETS     gequ  %0000000000000010    ; 1|1
COLLIDE_ENEMY_ROCKETS     gequ  %0000000000000100    ; 1|2
COLLIDE_PARACHUTE         gequ  %0000000000001000    ; 1|3
COLLIDE_PLAYER_BULLETS    gequ  %0000000000010000    ; 1|4
COLLIDE_PLAYER            gequ  %0000000000100000    ; 1|5

; Explosion
EXPLOSION_FRAMES          gequ  5
; Max enemies allowed at once, -1 (0..this)
MAX_ENEMY_INDEX           gequ  7

; Player frames
PLAYER_FRAME_RIGHT        gequ  0/2
PLAYER_FRAME_DOWN         gequ  16/2
PLAYER_FRAME_LEFT         gequ  32/2
PLAYER_FRAME_UP           gequ  48/2

; TEXT LAYER TYPES
TEXTF_1                   gequ  0
TEXTF_2                   gequ  2
TEXTF_3                   gequ  4
TEXTF_4                   gequ  6
TEXTF_5                   gequ  8
TEXTF_1910                gequ  10
TEXTF_1910_BLUE           gequ  12
TEXTF_1910_RED            gequ  14
TEXTF_1940                gequ  16
TEXTF_1940_BLUE           gequ  18
TEXTF_1940_RED            gequ  20
TEXTF_1970                gequ  22
TEXTF_1970_BLUE           gequ  24
TEXTF_1970_RED            gequ  26
TEXTF_1982                gequ  28
TEXTF_1982_BLUE           gequ  30
TEXTF_1982_RED            gequ  32
TEXTF_2001                gequ  34
TEXTF_2001_BLUE           gequ  36
TEXTF_2001_RED            gequ  38
TEXTF_AD                  gequ  40
TEXTF_AD_BLUE             gequ  42
TEXTF_AD_RED              gequ  44
TEXTF_GAMEOVER            gequ  46
TEXTF_PAUSE               gequ  48
TEXTF_PLAYER              gequ  50
TEXTF_READY               gequ  52
TEXTF_STAGE               gequ  54

; Velocities
VELOCITY_050              gequ  0
VELOCITY_075              gequ  2*32
VELOCITY_100              gequ  4*32
VELOCITY_119              gequ  6*32
VELOCITY_150              gequ  8*32
VELOCITY_200              gequ  10*32
VELOCITY_400              gequ  12*32

; Timers
BOMBER_TIMER              gequ  60*5
ENEMY_RECALL_TIMER        gequ  32*18                ; Approx 9 seconds - has to be even checked inside !(aiSpawnTimer & ENEMY_SPAWN_TIMER)
ENEMY_SPAWN_TIMER         gequ  %00011111            ; Approx .5 seconds
ENEMY_SPAWN_WAVE_TIMER    gequ  32*20                ; Approx 10 seconds - has to be even checked inside !(aiSpawnTimer & ENEMY_SPAWN_TIMER)
ENEMY_STEADY_MIN_TIME     gequ  3*60/8               ; Min time between dir changes
ENEMY_WAVE_ACTIVE_TIMER   gequ  90/8                 ; div 8 because AI thinks only every 8 frames
ENEMY_WAVE_ENTRY_TIMER    gequ  60/8                 ; div 8 because AI thinks only every 8 frames
EXPLOSION_HOLD_TIMER      gequ  60/6
HIGHSCORE_ENTRY_TIME      gequ  136                  ; 34s UI_COLORCYCLE_TIMER related
INTRO_COLOR_CYCLE_TIME    gequ  60/8
BOSS_TIMER                gequ  60*2
PARACHUTE_TIMER           gequ  60*7
RESTAGE_TIMER             gequ  60*3
PLAYER_BULLET_FIRE_TIMER  gequ  3*8
PLAYER_DIED_TIMER         gequ  60*3
SCORE_MULT_TIMER          gequ  60/2
STAGE_TIMER               gequ  60*5
UI_COLORCYCLE_TIMER       gequ  60/4
UI_GAME_OVER_TIMER        gequ  60*3
UI_STATE_TIMER            gequ  60*5

; input
INPUT_NONE                gequ  0
INPUT_UP                  gequ  %0000000000000001
INPUT_RIGHT               gequ  %0000000000000010
INPUT_DOWN                gequ  %0000000000000100
INPUT_LEFT                gequ  %0000000000001000
INPUT_ROTATE_LEFT         gequ  %0000000000010000
INPUT_ROTATE_RIGHT        gequ  %0000000000100000
INPUT_FIRE                gequ  %0000000001000000
INPUT_PAUSE               gequ  %0000000010000000
INPUT_QUIT                gequ  %0000000100000000
INPUT_2P                  gequ  %0000001000000000
INPUT_SCAN                gequ  %0000010000000000
INPUT_KEYBOARD            gequ  %0000100000000000
INPUT_MASK_MOVEMENT       gequ  %0000000000001111
INPUT_MASK_ROTATE         gequ  %0000000000110000
INPUT_REPEAT_RATE         gequ  UI_COLORCYCLE_TIMER

; Score Sprites
SCORE_1000                gequ  0
SCORE_2000                gequ  2
SCORE_3000                gequ  4
SCORE_4000                gequ  6
SCORE_5000                gequ  8
SCORE_1500                gequ  10

; Demo Mode
; Set RECORD_REPLAY to 1 to enable demo recording
RECORD_REPLAY             gequ  0
DEMO_ATTRACT_LENGTH       gequ  2048                 ; 2653/2

; Audio
;AUDIO_BIG_EXPLOSION       gequ  0
;AUDIO_BOMB                gequ  1
;AUDIO_BOOOMERANG          gequ  2
;AUDIO_BOSSL0              gequ  3
;AUDIO_BOSSL1              gequ  4
;AUDIO_BOSSL2              gequ  5
;AUDIO_BOSSL3              gequ  6
;AUDIO_BOSSL4              gequ  7
;AUDIO_COINDROP            gequ  8
;AUDIO_ENEMY_EXPLODE       gequ  9
;AUDIO_ENEMY_SHOOT         gequ  10
;AUDIO_ENEMY_SHOOT_SPACE   gequ  11
;AUDIO_EXTRA_LIFE          gequ  12
;AUDIO_GAME_START          gequ  13
;AUDIO_HIGHSCORE           gequ  14
;AUDIO_NEXT_LEVEL          gequ  15
;AUDIO_PICKUP              gequ  16
;AUDIO_PLAYER_SHOOT        gequ  17
;AUDIO_ROCKET_FLY          gequ  18
;AUDIO_ROCKET_LAUNCH       gequ  19
;AUDIO_STAGE_CLEAR         gequ  20
;AUDIO_TIMEWARP            gequ  21
;AUDIO_WAPON_EXPLODE       gequ  22
;AUDIO_WAVE_START          gequ  23
;NUM_AUDIO_SOURCES         gequ  24


; Direct Page (zero page) Variables
zActivePlayer             gequ  $00
zActiveSky                gequ  $02
zActiveStage              gequ  $04
zAiSpawnTimer             gequ  $06
zBomberHealth             gequ  $08
zDemoAttractIndex         gequ  $0A
zDemoAttractLength        gequ  $0C
zDemoAttractMode          gequ  $0E
zDemoAttractScore         gequ  $10
zDifficultyKillCount      gequ  $12
zEnemiesKilled            gequ  $14
zInputUsingJoystick       gequ  $16
zInvPlayerAngle           gequ  $18
zBossHealth               gequ  $1A
zBossTimer                gequ  $1C
zMemID                    gequ  $1E
zNumberOfAIFollowersMax   gequ  $20
zNumberOfPlayers          gequ  $22
zNumberOfPlayersAlive     gequ  $24
zNumberOfTrackedMax       gequ  $26
zParachuteTimer           gequ  $28
zPlayerExtraLife          gequ  $2A
zPlayerLives              gequ  $2C
zPlayerNextExtraLife      gequ  $2E
zPlayerScore              gequ  $30
zPrePlayTimer             gequ  $32
zRandomSeed               gequ  $34
zReadFrameStall           gequ  $36
zRowsToErase              gequ  $38
zScanLine                 gequ  $3A
zScanLinePrev             gequ  $3C
zSkyColor                 gequ  $3E
zSpawnX                   gequ  $40
zSpawnY                   gequ  $42
zSpriteDataBank           gequ  $44
zStageIntroState          gequ  $46
zTemp00                   gequ  $48
zTemp01                   gequ  $4A
zTemp02                   gequ  $4C
zTemp03                   gequ  $4E
zTemp04                   gequ  $50
zTemp05                   gequ  $52
zTemp06                   gequ  $54
zTemp07                   gequ  $56
zTemp08                   gequ  $58
zTemp09                   gequ  $5A
zTemp10                   gequ  $5C
zTemp11                   gequ  $5E
zTemp12                   gequ  $60

;zCurrentJoyButtons        gequ  $68
zsVarsStart               gequ  $62                  ; global stage vars start
zAiEnemiesAlive           gequ  $62
zBomberTimer              gequ  $64
zBulletTimer              gequ  $66
zDrawIndex                gequ  $68
zEndFrameProcessed        gequ  $6A
zEnemyIdx                 gequ  $6C
zEnemyScore               gequ  $6E
zEraseIndex               gequ  $70
zExitGameMask             gequ  $72
zFrameCounter             gequ  $74
zInputMask                gequ  $76
zInputMaskDebounced       gequ  $78
zInputMaskPrev            gequ  $7A
zInputMaskRepeat          gequ  $7C
zInputRepeatRate          gequ  $7E
zInsertThings             gequ  $80
zLaunchSide               gequ  $82
zNumberOfAIFollowers      gequ  $84
zNumberOfEnemies          gequ  $86
zNumberOfRockets          gequ  $88
zNumberOfTracked          gequ  $8A
zNumberOfWaveEnemies      gequ  $8C
zNumEraseThingIDs         gequ  $8E
zNumSortedThingIDs        gequ  $90
zParachuteScore           gequ  $92
zPlayerAngle              gequ  $94
zPlayerExitTimer          gequ  $96
zScoreTimer               gequ  $98
zThingID0                 gequ  $9A
zThingID1                 gequ  $9C
zWaveSpawnDir             gequ  $9E
zWaveSpawnDuration        gequ  $A0
zWaveSpawnIndex           gequ  $A2
zWaveSpawnL               gequ  $A4
zWaveSpawnCount           gequ  $A6
zWaveSpawnR               gequ  $A8
zsVarsEnd                 gequ  $A8

zImageAddressPdpB1        gequ  $B0                  ; 24 bit address (3 bytes) points at dpB1ImageAddress
zImageDataWidthPdpB1      gequ  $B3                  ; 24 bit address (3 bytes) points at dpB1ImageDataWidth
zImageVisHeightPdpB1      gequ  $B6                  ; 24 bit address (3 bytes) points at dpB1ImageVisibleHeight
zImageVisWidthPdpB1       gequ  $B9                  ; 24 bit address (3 bytes) points at dpB1ImageVisibleWidth
zMaskAddressPdpB1         gequ  $BC                  ; 24 bit address (3 bytes) points at dpB1MaskAddress
zScreenAddressPdpB1       gequ  $BF                  ; 24 bit address (3 bytes) points at dpB1ScreenAddress

dpB1ImageAddress          gequ  $00                  ; direct page bank 1 memory work area
dpB1ImageDataWidth        gequ  $02                  ; direct page bank 1 memory work area
dpB1ImageVisibleHeight    gequ  $04                  ; direct page bank 1 memory work area
dpB1ImageVisibleWidth     gequ  $06                  ; direct page bank 1 memory work area
dpB1MaskAddress           gequ  $08                  ; direct page bank 1 memory work area
dpB1ScreenAddress         gequ  $0A                  ; direct page bank 1 memory work area
