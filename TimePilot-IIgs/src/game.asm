;-----------------------------------------------------------------------------
; game.asm
; Part of Time Pilot, the 1982 arcade game remake for the Apple IIgs
;
; Stefan Wessels, 2024
; This is free and unencumbered software released into the public domain.
;-----------------------------------------------------------------------------

                        copy     src/globals.s
                        mcopy    src/game.mac

;-----------------------------------------------------------------------------
GAME                    START

                        using    GAMEDATA
                        using    TEXT
                        using    VARIABLES

;-----------------------------------------------------------------------------
; setting RECORD_REPLAY in globals.s will enable recording a replay
                        lcla     &R_RECORD
&R_RECORD               seta     RECORD_REPLAY

;-----------------------------------------------------------------------------
; MARK: gameAddBonus
; If not called from a collision handler, zThingID0 must be set to x of calling-thing
gameAddBonus            entry
tgabScore               equ      zTemp00
                        sta      tgabScore                                   ; save the index
                        lda      activeMinX,x                                ; position bonus score
                        sec
                        sbc      #16
                        sta      zSpawnX
                        lda      activeMinY,x
                        sta      zSpawnY
                        ldy      #LAYER_SCORES                               ; Add score sprite
                        jsr      thingsAdd
                        lda      tgabScore                                   ; get index
                        sta      activeFrame,x                               ; set as frame to show correct score
                        lda      #60                                         ; keep on-screen duration
                        sta      activeExtra,x                               ; Timer
                        ldy      tgabScore
                        lda      dt_scores_bonus,y                           ; get the BCD value of the bonus
                        jsr      gameAddScoreInternal                        ; add the BCD score to score
                        ldx      zThingID0                                   ; restore x
                        rts

;-----------------------------------------------------------------------------
; MARK: gameAddScore
gameAddScore            entry
                        lda      zScoreTimer                                 ; time since last score
                        cmp      #SCORE_MULT_TIMER
                        bcc      gasReset                                    ; not expired - keep going
                        stz      zEnemyScore                                 ; expired - set back to 0
gasReset                stz      zScoreTimer
                        inc      zEnemyScore                                 ; add (1 or more - looks like 100)
                        lda      zEnemyScore
; fall through intentionally

;-----------------------------------------------------------------------------
; This adds a BCD score (in A) to the player score
; MARK: gameAddScoreInternal
gameAddScoreInternal    entry
                        pha                                                  ; save the score
                        clc
                        sed                                                  ; BCD
                        adc      zPlayerScore                                ; add
                        cld                                                  ; BCD off
                        sta      zPlayerScore
                        cmp      highScoresDisplay
                        bcc      gasiExtra                                   ; still not highscore
                        sta      highScoresDisplay                           ; update highscore
                        jsr      uiShowHighScore                             ; and display it
gasiExtra               pla                                                  ; restore the score
                        jsr      gameScoreCheckExtra                         ; see if this added gives extra life
                        lda      zActivePlayer
                        beq      gas1P1                                      ; update screen for p1 or p2
                        jmp      uiShowP2Score
gas1P1                  jmp      uiShowP1Score

;-----------------------------------------------------------------------------
; MARK: gameInit
gameInit                entry
                        lda      zDemoAttractMode
                        bne      giSkipSong
                        lda      #AUDIO_GAME_START
                        jsr      audioPlaySource
giSkipSong              jsr      gameInitVarsGame
                        jsr      gameRestorePlayer                           ; init all of the shadow stats
                        LDAPAL   COLOR_BLACK
                        sta      zSkyColor
                        LDBOX    28,7,9,1
                        jsr      screenClearSection                          ; clear P1 score
                        lda      zNumberOfPlayers
                        beq      giOnePlayer
                        jmp      uiShowP2Playing                             ; show P2 details
giOnePlayer             LDBOX    28,9,12,2                                   ; erase P2 area if 1P
                        jmp      screenClearSection

;-----------------------------------------------------------------------------
; MARK: gameInitVarsGame
gameInitVarsGame        entry
                        ldx      #gpVarsEnd-gpVarsStart-2                    ; zero based
gvigClearVars           stz      gpVarsStart,x                               ; per player variables to 0
                        dex
                        dex
                        bpl      gvigClearVars
                        lda      #2                                          ; init lives
                        sta      playersLives
                        sta      playersLives+2
                        lda      #$0100                                      ; init 1st extra life score (10000)
                        sta      playersNextExtraLife                        ; BCD
                        sta      playersNextExtraLife+2
                        lda      #-1
                        sta      zActiveSky                                  ; force a wipe
                        lda      #ENEMIES_TO_KILL_TO_CLEAR/2
                        sta      zDifficultyKillCount                        ; carries over stage boundaries
                        lda      #2
                        sta      zNumberOfAIFollowersMax                     ; Init difficulty
                        stz      zActivePlayer                               ; 1st player starts (0)
                        stz      zDemoAttractIndex
                        stz      zExitGameMask
                        rts

;-----------------------------------------------------------------------------
; MARK: gameInitVarsStage
gameInitVarsStage       entry
                        ldx      #gSVarsEnd-gsVarsStart-2                    ; zero based
gvisClearVars           stz      gsVarsStart,x                               ; stage variables to 0
                        dex
                        dex
                        bpl      gvisClearVars
                        ldx      #zsVarsEnd-zsVarsStart
gvisClearZVars          stz      zsVarsStart,x                               ; stage ZP variables to 0
                        dex
                        dex
                        bpl      gvisClearZVars
                        lda      #2*MAX_OBJECTS
                        ldx      #2*MAX_ENEMY_INDEX
gvisEnemyInit           sta      enemyID,X                                   ; enemy arrays to 2*MAX_OBJECTS
                        sta      enemyWeapon,x
                        dex
                        dex
                        bpl      gvisEnemyInit
                        lda      #1                                          ; init other non-zero variables
                        sta      zAiSpawnTimer
                        ina
                        sta      zNumberOfTrackedMax                         ; This goes down at a new stage
                        lda      #BOMBER_HEALTH
                        sta      zBomberHealth
                        lda      #PLAYER_FRAME_LEFT
                        sta      zInvPlayerAngle
                        lda      #BOSS_TIMER
                        sta      zBossTimer
                        lda      #KEY_READ_RATE
                        sta      zReadFrameStall
                        rts

;-----------------------------------------------------------------------------
; return with carry set when all players dead
; IN: A contains zExitGameMask
; MARK: gameNextPlayer
gameNextPlayer          entry
tgnpGameOver            equ      zTemp11
                        stz      tgnpGameOver                                ; game over flag
                        bit      #EXIT_USER_QUIT
                        bne      gnpUserQuit
                        lda      cheatModeActive
                        bne      gnpAlive
                        dec      zPlayerLives                                ; player lost a life
                        bpl      gnpAlive                                    ; but not game over yet
                        jsr      uiGameOver
gnpAlive                lda      zNumberOfPlayersAlive
                        beq      gnpStillPlaying                             ; > 0 means 2 players
                        jsr      gameSavePlayer                              ; swap to other player
                        lda      #2
                        eor      zActivePlayer
                        sta      zActivePlayer
                        jsr      gameRestorePlayer
gnpStillPlaying         lda      tgnpGameOver
                        beq      gnpNotOver
                        dec      zNumberOfPlayersAlive                       ; if game over, reduce players
                        beq      gnpNotOver                                  ; all players dead?
                        sec                                                  ; yes, return with carry set
                        rts
gnpNotOver              clc                                                  ; no, return with carry clear
                        rts
gnpUserQuit             inc      tgnpGameOver
                        lda      #-1
                        sta      zPlayerLives                                ; All lives lost
                        lda      cheatModeActive                             ; If chearing don't ask for score
                        bne      gnpAlive
                        jsr      ugoHaveKey                                  ; skip game-over - ask for score if on table
                        bra      gnpAlive

;-----------------------------------------------------------------------------
; MARK: gamePostFrame
gamePostFrame           entry
                        lda      zPrePlayTimer
                        beq      gpfNoPrePlay                                ; intro not active
                        dec      zPrePlayTimer                               ; count down intro timer
                        bne      gpfSort
gpfNoPrePlay            inc      zAiSpawnTimer                               ; mark which enemy will process
                        lda      zAiSpawnTimer                               ; 0-7 takes turns running ai
                        and      #14                                         ; so enemies think every 7 frames
                        sta      zEnemyIdx
                        inc      zFrameCounter                               ; global frame counter
                        lda      zActiveStage
                        cmp      #TIME_PERIOD3_1982                          ; No propellers past 1982
                        bcs      gpfAiEndFrame
                        tax                                                  ; swap prop color palettes
                        lda      zFrameCounter
                        bit      #3                                          ; every 4  frames
                        bne      gpfAiEndFrame
                        bit      #4                                          ; alternate
                        beq      gpfColReverse
                        lda      dt_color_palette_sky,x
                        sta      PALETTE_BASE+COLOR_PROP0*2                  ; put sky
                        lda      dt_color_palette_prop,x
                        sta      PALETTE_BASE+COLOR_PROP1*2                  ; and prop directly in palette
                        bra      gpfAiEndFrame
gpfColReverse           lda      dt_color_palette_sky,x
                        sta      PALETTE_BASE+COLOR_PROP1*2
                        lda      dt_color_palette_prop,x
                        sta      PALETTE_BASE+COLOR_PROP0*2
gpfAiEndFrame           jsr      aiEndFrame                                  ; run end frame AI (spawn boss, etc)
gpfSort                 jsr      thingsSortAndCollide                        ; do the main work, collisions etc
                        stz      zDrawIndex                                  ; reset indicies for next frame
                        stz      zEraseIndex
                        lda      zPlayerAngle
                        eor      #32                                         ; inv angle to player angle
                        sta      zInvPlayerAngle
                        rts

;-----------------------------------------------------------------------------
; MARK: gameProcessThings
gameProcessThings       entry
;                        lda     BORDER                                       ; SQW
;                        ina
;                        sta     BORDER
gptEraseLoop            ldx      zEraseIndex                                 ; Iterate the erase list
                        cpx      zNumEraseThingIDs
                        bcs      gptDrawLoop
                        lda      eraseThingIDs,x
                        tax                                                  ; erase thing in X
                        lda      activeOldMaxY,x
                        cmp      zScanLine
                        bpl      gptDrawLoop
                        lda      activeFlags,x
                        ora      #AF_ERASED                                  ; mark as erased when off-screen
                        sta      activeFlags,x
                        and      #AF_CLIPMASK
                        cmp      #AF_CLIPMASK
                        beq      gptEraseNext
                        jsr      eraseThing                                  ; no - erase this thing
gptEraseNext            inc      zEraseIndex                                 ; step to next erase thing
                        inc      zEraseIndex
                        bra      gptEraseLoop
gptDrawLoop             ldx      zDrawIndex                                  ; iterate the draw list
                        cpx      zNumSortedThingIDs
                        bcs      gptDone
                        lda      sortedThingIDs,x
                        tax                                                  ; thing to draw in X
                        lda      activeMaxY,x
                        cmp      zScanLine
                        bpl      gptDone                                     ; no
                        lda      activeFlags,x                               ; yes
                        bit      #AF_ERASED                                  ; has it been erased?
                        beq      gptDone                                     ; no - done this pass
                        bit      #AF_REMOVE                                  ; does it need to be removed?
                        bne      gptRemove                                   ; yes
                        stx      zThingID0
                        jsr      drawThing                                   ; no - draw it
                        ldx      zThingID0
                        jsr      aiThing
                        inc      zDrawIndex                                  ; step to next thing to draw
                        inc      zDrawIndex
                        bra      gptDrawLoop
gptRemove               stz      activeFlags,x                               ; remove it - set activeFlags to 0
                        stz      activeScreenAddress,x
                        stx      zInsertThings
                        lda      #-1                                         ; set sortedThingID to -1
                        ldx      zDrawIndex
                        sta      sortedThingIDs,x
                        inc      zDrawIndex                                  ; setup to next thing to draw
                        inc      zDrawIndex
                        bra      gptDrawLoop
gptDone                 rts

;-----------------------------------------------------------------------------
; MARK: gameRestorePlayer
gameRestorePlayer       entry
                        ldx      zActivePlayer
                        lda      playersLives,x
                        sta      zPlayerLives
                        lda      playersScore,x
                        sta      zPlayerScore
                        lda      playersExtraLife,x
                        sta      zPlayerExtraLife
                        lda      playersNextExtraLife,x
                        sta      zPlayerNextExtraLife
                        lda      playersActiveStage,x
                        sta      zActiveStage
                        lda      playersEnemiesKilled,x
                        sta      zEnemiesKilled
                        lda      playersBossHealth,x
                        sta      zBossHealth
                        lda      playersStageIntroState,x
                        sta      zStageIntroState
;                        lda      #TIME_PERIOD2_1970                          ; SQW - Stage start override
;                        sta      zActiveStage
                        rts

;-----------------------------------------------------------------------------
; MARK: gameSavePlayer
gameSavePlayer          entry
                        ldx      zActivePlayer
                        lda      zPlayerLives
                        sta      playersLives,x
                        lda      zPlayerScore
                        sta      playersScore,x
                        lda      zPlayerExtraLife
                        sta      playersExtraLife,x
                        lda      zPlayerNextExtraLife
                        sta      playersNextExtraLife,x
                        lda      zActiveStage
                        sta      playersActiveStage,x
                        lda      zEnemiesKilled
                        sta      playersEnemiesKilled,x
                        lda      zBossHealth
                        sta      playersBossHealth,x
                        lda      zStageIntroState
                        sta      playersStageIntroState,x
                        rts

;-----------------------------------------------------------------------------
; MARK: gameScoreCheckExtra
gameScoreCheckExtra     entry
gsccarry                bcs      gsccarry
                        sed
                        adc      zPlayerExtraLife
                        sta      zPlayerExtraLife
                        cmp      zPlayerNextExtraLife
                        bcs      gscAddLife
                        cld
                        rts
gscAddLife              sec
                        sbc      zPlayerNextExtraLife
                        sta      zPlayerExtraLife
                        cld
                        lda      #$0500
                        sta      zPlayerNextExtraLife
                        lda      cheatModeActive                             ; if cheating, add the life back
                        bne      noAddLife
                        inc      zPlayerLives
noAddLife               jmp      uiShowPlayerShips

;-----------------------------------------------------------------------------
; MARK: gameStageInit
gameStageInit           entry
                        aif      &R_RECORD>0,.gsiRecordDemo
                        ago      .gsiSkipDemoRecord
.gsiRecordDemo
                        lda      demoRecordMode                              ; if not recording
                        bne      gsiDemoRecDone
                        inc      demoRecordMode                              ; switch to recording
                        stz      zDemoAttractLength                          ; starting a location 0
                        bra      gsiRecordIsInit
gsiDemoRecDone          lda      #1                                          ; if were recording
                        sta      zDemoAttractMode                            ; show recording
                        stz      demoRecordMode                              ; and turn recording off
                        _Create  createFileData                              ; Create the replay file
                        bcs      gsiFileError
                        _Open    openFileData
                        bcs      gsiFileError
                        lda      openFileData                                ; Copy the ref
                        sta      writeFileData
                        lda      zDemoAttractLength                          ; and length
                        sta      writeLen
                        _Write   writeFileData
                        bcs      gsiFileError
                        _Close   openFileData
                        bcs      gsiFileError
                        ldx      #3                                          ; update file name to next nunber
                        short    m
gsiDigit                lda      createEnd-4,x
                        ina
                        cmp      #'9'+1
                        bcs      gsiOverFlow
                        sta      createEnd-4,x
                        long     m
                        bra      gsiRecordIsInit
                        short    m
gsiOverFlow             lda      #'0'
                        sta      createEnd-4,x
                        dex
                        bpl      gsiDigit
                        long     m
                        bra      gsiRecordIsInit
gsiFileError            sta      BORDER
                        clc
gsiRecordIsInit         stz      zStageIntroState
                        ago      .gsiIsDemoMode
.gsiSkipDemoRecord
                        lda      zDemoAttractMode                            ; normal flow - see if demo mode
                        beq      gsiNotDemoMode
.gsiIsDemoMode
                        lda      #TIME_PERIOD1_1940                          ; demo in 1940
                        sta      zActiveStage
                        lda      #-1                                         ; reset the seed
                        sta      zRandomSeed
gsiNotDemoMode          ldx      zActiveStage                                ; see if sky needs a wipe
                        cpx      zActiveSky
                        beq      gsiNoWipe
                        jsr      audioLoadBOSS
                        jsr      screenWipeToStageSky
                        bra      gsiGSInit
gsiNoWipe               LDAPAL   COLOR_SKY                                   ; reset sky color if no wipe
                        sta      zSkyColor                                   ; and clear playfield
                        LDBOX    0,0,PLAYFIELDW,PLAYFIELDH
                        jsr      screenClearSection
gsiGSInit               jsr      gameInitVarsStage                           ; init the stage variables
                        lda      zStageIntroState
                        bne      gsiShortIntro                               ; not first time on this stage - short intro
                        lda      #BOSS_HEALTH                                ; first time on stage
                        sta      zBossHealth
                        lda      #STAGE_TIMER
                        sta      zPrePlayTimer
                        lda      #STAGE_TIMER+PARACHUTE_TIMER
                        sta      zParachuteTimer
                        stz      zEnemiesKilled
                        lda      zActiveStage
                        cmp      #TIME_PERIOD1_1940
                        bne      gsiPostBomberInit
                        lda      #STAGE_TIMER+BOMBER_TIMER
                        sta      zBomberTimer
gsiPostBomberInit       aif      &R_RECORD>0,.gsiRecordMode
                        ago      .gsiNotRecordMode
.gsiRecordMode
                        lda      demoRecordMode
                        bne      gsiShortIntro                               ; if record mode - override to short intro
.gsiNotRecordMode
                        lda      zDemoAttractMode                            ; show demo?
                        beq      gsiScreenSetup                              ; override to short intro
gsiShortIntro           lda      #RESTAGE_TIMER
                        sta      zPrePlayTimer
                        lda      #RESTAGE_TIMER+PARACHUTE_TIMER
                        sta      zParachuteTimer
                        lda      zActiveStage
                        cmp      #TIME_PERIOD1_1940
                        bne      gsiScreenSetup
                        lda      #RESTAGE_TIMER+BOMBER_TIMER
                        sta      zBomberTimer
gsiScreenSetup          jsr      uiShowStageIcon
                        jsr      uiShowPlayerShips
                        jsr      uiShowStageProgress

                        lda      #eraseRts
                        sta      at_handler_erase+LAYER_TEXT

                        ldx      zActiveStage                                ; stage specific overrides
                        lda      bt_level,x                                  ; preset the bank for draw/jumps
                        short    m
                        sta      deJmpAddr+3                                 ; enemies
                        sta      dbsJmpAddr+3                                ; bosses
                        long     m
                        lda      at_enemy_draw,x                             ; table driven stage overrides
                        sta      at_handler_draw+LAYER_ENEMY
                        lda      at_enemy_pdraw,x
                        sta      at_handler_part_draw+LAYER_ENEMY
                        lda      at_hrckt_ai,x
                        sta      at_handler_ai+LAYER_ROCKETS
                        lda      at_hrckt_draw,x
                        sta      at_handler_draw+LAYER_ROCKETS
                        lda      at_hrckt_pdraw,x
                        sta      at_handler_part_draw+LAYER_ROCKETS
                        lda      at_hrckt_erase,x
                        sta      at_handler_erase+LAYER_ROCKETS
                        cpx      #TIME_PERIOD4_2001                          ; check for space level or not
                        beq      gsiSpace                                    ; set space specific defaults
                        lda      #drawBoss                                   ; non-space boss
                        sta      at_handler_draw+LAYER_BOSS
                        lda      #drawBossPart
                        sta      at_handler_part_draw+LAYER_BOSS
                        lda      #aiBullets                                  ; non-space bullets
                        sta      at_handler_ai+LAYER_BULLETS
                        lda      #COLLIDE_PLAYER
                        sta      dt_layer_collides_with+LAYER_BULLETS
                        lda      #collideBullets
                        sta      at_handler_collision+LAYER_BULLETS
                        lda      #drawBullet
                        sta      at_handler_draw+LAYER_BULLETS
                        lda      #drawRts
                        sta      at_handler_part_draw+LAYER_BULLETS
                        lda      #blank2x2
                        sta      at_handler_erase+LAYER_BULLETS
                        lda      #drawClouds0                                ; non-space clouds
                        sta      at_handler_draw+LAYER_CLOUDS0
                        lda      #drawClouds0Part
                        sta      at_handler_part_draw+LAYER_CLOUDS0
                        lda      #drawClouds1
                        sta      at_handler_draw+LAYER_CLOUDS1
                        lda      #drawClouds1Part
                        sta      at_handler_part_draw+LAYER_CLOUDS1
                        lda      #blank32x16
                        sta      at_handler_erase+LAYER_CLOUDS1
                        lda      #drawClouds2
                        sta      at_handler_draw+LAYER_CLOUDS2
                        lda      #drawClouds2Part
                        sta      at_handler_part_draw+LAYER_CLOUDS2
                        lda      #blank48x16
                        sta      at_handler_erase+LAYER_CLOUDS2
                        lda      #drawExpl_wep                               ; non-space rocket explosions
                        sta      at_handler_draw+LAYER_EXPLODE_ROCKETS
                        lda      #drawExpl_wepPart
                        sta      at_handler_part_draw+LAYER_EXPLODE_ROCKETS
                        lda      #$0680                                      ; Olive Green
                        sta      PALETTE_BASE+COLOR_OLIVE_GREEN*2
                        jmp      gsiSetDimensions                            ; skip space overrides
gsiSpace                lda      #drawSpaceBoss                              ; space boss
                        sta      at_handler_draw+LAYER_BOSS
                        lda      #drawSpaceBossPart
                        sta      at_handler_part_draw+LAYER_BOSS
                        lda      #aiSBullets                                 ; space bullets
                        sta      at_handler_ai+LAYER_BULLETS
                        lda      #COLLIDE_PLAYER_BULLETS+COLLIDE_PLAYER
                        sta      dt_layer_collides_with+LAYER_BULLETS
                        lda      #collideSBullets
                        sta      at_handler_collision+LAYER_BULLETS
                        lda      #drawSBullets
                        sta      at_handler_draw+LAYER_BULLETS
                        lda      #drawSBulletsPart
                        sta      at_handler_part_draw+LAYER_BULLETS
                        lda      #blank8x8
                        sta      at_handler_erase+LAYER_BULLETS
                        lda      #drawAstros0                                ; space clouds
                        sta      at_handler_draw+LAYER_CLOUDS0
                        lda      #drawAstros0Part
                        sta      at_handler_part_draw+LAYER_CLOUDS0
                        lda      #drawAstros1
                        sta      at_handler_draw+LAYER_CLOUDS1
                        lda      #drawAstros1Part
                        sta      at_handler_part_draw+LAYER_CLOUDS1
                        lda      #blank16x16
                        sta      at_handler_erase+LAYER_CLOUDS1
                        lda      #drawAstros2
                        sta      at_handler_draw+LAYER_CLOUDS2
                        lda      #drawAstros2Part
                        sta      at_handler_part_draw+LAYER_CLOUDS2
                        lda      #blank32x16
                        sta      at_handler_erase+LAYER_CLOUDS2
                        lda      #drawExpl_boom                              ; space rocket explosion
                        sta      at_handler_draw+LAYER_EXPLODE_ROCKETS
                        lda      #drawExpl_boomPart
                        sta      at_handler_part_draw+LAYER_EXPLODE_ROCKETS
                        lda      #$000A                                      ; in space olive green becomes dark blue
                        sta      PALETTE_BASE+COLOR_OLIVE_GREEN*2
                        lda      #$00CF
                        sta      PALETTE_BASE+COLOR_PROP0*2
                        sta      PALETTE_BASE+COLOR_PROP1*2
                        lda      zBossHealth                                 ; if boss health low, flash
                        cmp      #1+BOSS_HEALTH/2
                        bcs      gsiSetDimensions
                        lda      #$0C0C
                        sta      PALETTE_BASE+COLOR_PROP1*2

gsiSetDimensions        lda      dt_stage_dim_offsets,x
                        tax
                        ldy      #16*2
gsiSetDimLoop           lda      dt_layer_tp0_height,x
                        sta      dt_layer_active_height,y
                        lda      dt_layer_tp0_width,x
                        sta      dt_layer_active_width,y
                        dex
                        dex
                        dey
                        dey
                        bpl      gsiSetDimLoop

                        ldy      #NUM_SPAWN_LAYERS                           ; spawn player and clouds
gsiSpawnLoop            dey
                        dey
                        bmi      giFinalize
                        phy
                        lda      dt_spawn_min_x,y
                        sta      zSpawnX
                        lda      dt_spawn_min_y,y
                        sta      zSpawnY
                        lda      dt_spawn_layer,y
                        tay
                        jsr      thingsAdd
                        ply
                        bra      gsiSpawnLoop
giFinalize              sta      KBDSTRB
                        jsr      uiShowPreGameLabels
                        jmp      thingsSortAndCollide                        ; Finally - sort things

;-----------------------------------------------------------------------------
;   _______________________________________________________________
;  |          Vertical Counter         |     Horizontal Counter    |
;  |___________________________________|___________________________|
;  | V5| V4| V3| V2| V1| V0| VC| VB| VA|HPE| H5| H4| H3| H2| H1| H0|
;  |_______________________________|___|___________________________|
;  |            $E0C02E            |             $E0C02F           |
;  |_______________________________________________________________|
;
; MARK: gameStart
gameStart               entry

                        jsr      gameInit
gsStageInit             jsr      gameStageInit
                        lda      zAudioTimeWarp
                        beq      gsRasterLoop
                        stz      zAudioTimeWarp
                        lda      #AUDIO_BIG_EXPLOSION
                        jsr      audioPlaySource
gsRasterLoop            lda      RASTER_LINE
                        and      #%0000000011111111                          ; Only interested in the low byte
                        asl      a                                           ; the MSB is actually bit 0 but I am happy
                        cmp      zScanLinePrev                               ; with every 2 scan lines and getting the
                        beq      gsRasterLoop                                ; scan line in "screen space"
                        bmi      gsRasterDone                                ; Raster wrapped back to top so endframe?
                        cmp      #NTSC_TOP+SCREEN_PBOTTOM
                        bcs      gsRasterDone                                ; Past bottom so endframe
                        cmp      #NTSC_TOP                                   ; Scan line 0 in NTSC
                        bcc      gsRasterLoop                                ; Raster still above draw area?
                        sta      zScanLinePrev                               ; Raster in screen area
                        sbc      #NTSC_TOP                                   ; Remove NTSC lines at the top of the screen
                        sta      zScanLine                                   ; Actual line the raster is on
                        jsr      gameProcessThings                           ; Run a frame of the game
                        stz      zEndFrameProcessed                          ; Need to run endfrane
                        bra      gsRasterLoop
gsRasterDone            sta      zScanLinePrev                               ; save raster
                        lda      zEndFrameProcessed                          ; has an endframe already been run
                        bne      gsRasterLoop                                ; yes, keep waiting for a normal frame
                        lda      #$7dff                                      ; no, force an update
                        sta      zScanLine
                        sta      zEndFrameProcessed                          ; mark that end frame has happened
                        jsr      gameProcessThings                           ; one more pass to get everything
                        jsr      gamePostFrame                               ; run checks for end of frame
                        lda      zExitGameMask
                        bit      #EXIT_USER_QUIT
                        bne      gsPostPlay                                  ; user does want to quit
                        lda      zPlayerExitTimer
                        bpl      gsRasterLoop                                ; this life or stage not done yet
gsPostPlay              short    m                                           ; at this point the stage is clear or the player is dead
                        jsr      audioStopALLOSCS
                        long     m
                        LDBOX    0,0,PLAYFIELDW,PLAYFIELDH
                        jsr      screenClearSection                          ; clear playfield to sky color
                        lda      zDemoAttractMode
                        bne      gsGameExit                                  ; if demo-attract - exit now
                        lda      zExitGameMask
;                        bit      #EXIT_USER_QUIT
;                        bne      gsNextPlayer                                ; user wants to quit
                        bit      #EXIT_STAGE_CLEAR                           ; was AND # with above in
                        bne      gsStageComplete                             ; The player cleared the stage
gsNextPlayer            jsr      gameNextPlayer                              ; player dead - next player/life
                        bcc      gsStageInit
gsGameExit              LDAPAL   COLOR_BLACK
                        sta      zSkyColor
                        LDBOX    PLAYFIELDW,12,12,9                          ; erase Stage & Ships
                        jsr      screenClearSection
                        jmp      screenWipe
gsStageComplete         lda      zExitGameMask
                        bit      #EXIT_PLAYER_DIED
                        bne      gsSkipTimeWarp
                        jsr      screenTimeWarp
gsSkipTimeWarp          inc      zActiveStage
                        inc      zActiveStage
                        lda      zActiveStage
                        cmp      #NUM_PERIODS
                        bcc      gsStageEnd
                        stz      zActiveStage                                ; TIME_PERIOD0_1910
gsStageEnd              lda      zExitGameMask
                        bit      #EXIT_PLAYER_DIED
                        bne      gsNextPlayer                                ; if player died - swap
                        jmp      gsStageInit

thisisaformattinglabel  anop
                        END
