;-----------------------------------------------------------------------------
; variables.asm
; Part of Time Pilot, the 1982 arcade game remake for the Apple IIgs
;
; Stefan Wessels, 2024
; This is free and unencumbered software released into the public domain.
;-----------------------------------------------------------------------------


                        copy  src/globals.s

VARIABLES               DATA

;-----------------------------------------------------------------------------
; Cannot be in DP as it's used when DP is moved to bank1
stackAddress            ds    2

; High-score tracking and display
highScoreTableStart     entry
highScoresDisplay       dc    h'5806'
highScore1              dc    h'5806'
highScore2              dc    h'8000'
highScore3              dc    h'6800'
highScore4              dc    h'6500'
highScore5              dc    h'4000'

; Stage Vars
gsVarsStart             entry
activeCollides          ds    2*MAX_OBJECTS
activeColsig            ds    2*MAX_OBJECTS
activeEID               ds    2*MAX_OBJECTS
activeExtra             ds    2*MAX_OBJECTS
activeFlags             ds    2*MAX_OBJECTS
activeFrame             ds    2*MAX_OBJECTS
activeHeight            ds    2*MAX_OBJECTS
activeLayer             ds    2*MAX_OBJECTS
activeMaxX              ds    2*MAX_OBJECTS
activeMaxY              ds    2*MAX_OBJECTS
activeMinX              ds    2*MAX_OBJECTS
activeMinY              ds    2*MAX_OBJECTS
activeOffScreen         ds    2*MAX_OBJECTS
activeOldMaxY           ds    2*MAX_OBJECTS
activeScreenAddress     ds    2*MAX_OBJECTS
activeVisibleHeight     ds    2*MAX_OBJECTS
activeVisibleWidth      ds    2*MAX_OBJECTS
activeWidth             ds    2*MAX_OBJECTS
activeXVelFrac          ds    2*MAX_OBJECTS
activeYVelFrac          ds    2*MAX_OBJECTS

; One for each on-screen enemy
enemyHeading            ds    2*(MAX_ENEMY_INDEX+1)
enemyID                 ds    2*(MAX_ENEMY_INDEX+1)
enemyWeapon             ds    2*(MAX_ENEMY_INDEX+1)

eraseThingIDs           ds    2*MAX_OBJECTS
sortedThingIDs          ds    2*MAX_OBJECTS
gsVarsEnd               entry

; Per-player Game State Variables
gpVarsStart             entry
playersActiveStage      ds    2*2
playersEnemiesKilled    ds    2*2
playersExtraLife        ds    2*2
playersBossHealth       ds    2*2
playersLives            ds    2*2
playersNextExtraLife    ds    2*2
playersScore            ds    2*2
playersStageIntroState  ds    2*2
gpVarsEnd               entry

; Demo record only
demoRecordMode          ds    2

; Non zero-page variables
originalBorder          ds    2

thisisaformattinglabel  anop
                        END
