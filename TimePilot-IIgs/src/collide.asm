;-----------------------------------------------------------------------------
; collide.asm
; Part of Time Pilot, the 1982 arcade game remake for the Apple IIgs
;
; Stefan Wessels, 2024
; This is free and unencumbered software released into the public domain.
;-----------------------------------------------------------------------------

                        copy   src/globals.s
                        mcopy  src/collide.mac

COLLIDE                 START

                        using  GAMEDATA
                        using  VARIABLES

ptScreenClips           equ    zTemp01

;-----------------------------------------------------------------------------
; MARK: collideBomber
collideBomber           entry
                        tyx                                 ; zThingID0 in x
                        dec    zBomberHealth
                        beq    cbDead
                        ldy    zThingID1
                        lda    activeLayer,y
                        cmp    #LAYER_PLAYER
                        beq    cbDead
                        cmp    #LAYER_EXPLODE_LARGE         ; the player may have morphed into a large explosion
                        beq    cbDead
                        jmp    gameAddScore                 ; just a hit, not dead
cbDead                  lda    #BOMBER_TIMER
                        sta    zBomberTimer
                        lda    #SCORE_1500
                        jsr    gameAddBonus
; audioPlaySource(AUDIO_ENEMY_EXPLODE)
                        ldy    #LAYER_EXPLODE_LARGE
                        jmp    collideThingExplode

;-----------------------------------------------------------------------------
; MARK: collideBoomerang
collideBoomerang        entry
                        tyx                                 ; zThingID0 in x
                        ldy    activeEID,x
                        lda    #2*MAX_OBJECTS
                        sta    enemyWeapon,y                ; reset
                        dec    zNumberOfTracked
                        ldy    #LAYER_EXPLODE_ROCKETS
                        jsr    collideThingExplode
                        jmp    gameAddScore                 ; same as hitting an enemy

;-----------------------------------------------------------------------------
; MARK: collideBoss
collideBoss             entry
                        tyx
                        dec    zBossHealth
                        beq    clbDead
                        lda    zBossHealth                  ; Space Boss needs
                        cmp    #BOSS_HEALTH/2               ; to flash on health below 50%
                        bne    clbCollideWithWhat
                        lda    zActiveStage
                        cmp    #TIME_PERIOD4_2001
                        bne    clbCollideWithWhat
                        lda    #$0C0C
                        sta    PALETTE_BASE+COLOR_PROP1*2
clbCollideWithWhat      ldy    zThingID1
                        lda    activeLayer,y
                        cmp    #LAYER_PLAYER                ; if colliding with the player, die
                        beq    clbDead                      ; possibility the player collision was called
                        cmp    #LAYER_EXPLODE_LARGE         ; first, so if it's a LAYER_EXPLODE_LARGE
                        beq    clbDead                      ; it was the player, so die
                        jmp    gameAddScore                 ; boss hit but alive
clbDead                 lda    #SCORE_3000                  ; boss is dead
                        jsr    gameAddBonus
                        stz    zStageIntroState
                        inc    zPlayerExitTimer
                        lda    #EXIT_STAGE_CLEAR
                        ora    zExitGameMask
                        sta    zExitGameMask
                        ldy    #LAYER_EXPLODE_LARGE
                        jsr    collideThingExplode
                        ldx    #2*MAX_OBJECTS
clbLoop                 lda    activeFlags,x
                        beq    clbNext
                        lda    activeLayer,x
                        cmp    #LAYER_PARACHUTE
                        beq    clbRemove                    ; remove parachute
                        cmp    #LAYER_BULLETS
                        bne    clbBomberCheck
                        lda    zActiveStage
                        cmp    #TIME_PERIOD4_2001
                        bne    clbRemove                    ; remove non-space bullets
                        ldy    #LAYER_EXPLODE_BULLETS
                        jsr    collideThingExplode
                        bra    clbNext
clbBomberCheck          cmp    #LAYER_BOMBER
                        bne    clbRocketCheck
                        ldy    #LAYER_EXPLODE_LARGE
                        jsr    collideThingExplode
                        bra    clbNext
clbRocketCheck          cmp    #LAYER_ROCKETS
                        bcc    clbNext                      ; skip anything less than a rocket
                        beq    clbRocketExplode             ; explode rockets
                        cmp    #LAYER_PLAYER_BULLETS
                        bcs    clbNext                      ; skip player bullets and greater
                        ldy    #LAYER_EXPLODE_SMALL
                        jsr    collideThingExplode
                        bra    clbNext
clbRocketExplode        ldy    #LAYER_EXPLODE_ROCKETS
                        jsr    collideThingExplode
                        bra    clbNext
clbRemove               lda    #AF_REMOVE
                        ora    activeFlags,x
                        sta    activeFlags,x
clbNext                 dex
                        dex
                        bpl    clbLoop
                        rts

;-----------------------------------------------------------------------------
; MARK: collideBullets
collideBullets          entry
                        tyx
                        ldy    activeEID,x
                        lda    #2*MAX_OBJECTS
                        sta    enemyWeapon,y
                        lda    #AF_REMOVE
                        ora    activeFlags,x
                        sta    activeFlags,x
                        rts

;-----------------------------------------------------------------------------
; MARK: collideEnemy
collideEnemy            entry
                        tyx                                 ; zThingID0 in x
                        dec    zDifficultyKillCount
                        bpl    ceChkWave
                        lda    #3
                        sta    zNumberOfAIFollowersMax      ; Both go up here
                        sta    zNumberOfTrackedMax
                        lda    #ENEMIES_TO_KILL_TO_CLEAR/2
                        sta    zDifficultyKillCount
ceChkWave               lda    activeFlags,x
                        bit    #AF_AI_WAVE
                        beq    ceChkFollow
                        dec    zNumberOfWaveEnemies
                        bne    ceChkFollow
                        lda    #SCORE_2000
                        jsr    gameAddBonus
                        lda    activeFlags,x
ceChkFollow             bit    #AF_AI_FOLLOW
                        beq    ceKillMe
                        dec    zNumberOfAIFollowers
ceKillMe                lda    activeEID,x
                        tay
                        lda    #2*MAX_OBJECTS
                        sta    enemyID,y                    ; Slot is available
                        ldy    #LAYER_EXPLODE_SMALL
                        jsr    collideThingExplode
                        jsr    gameAddScore
                        dec    zNumberOfEnemies
                        inc    zEnemiesKilled
; audioPlaySource(AUDIO_ENEMY_EXPLODE)
                        jmp    uiUpdateStageProgress

;-----------------------------------------------------------------------------
; MARK: collideParachute
collideParachute        entry
                        tyx
                        lda    #AF_REMOVE
                        ora    activeFlags,x
                        sta    activeFlags,x
; audioPlaySource(AUDIO_PICKUP)
                        jsr    aiRandom
                        and    #$7F
                        adc    #PARACHUTE_TIMER
                        sta    zParachuteTimer
                        lda    zParachuteScore
                        cmp    #SCORE_5000
                        bcs    cpAddScore
                        inc    zParachuteScore
                        inc    zParachuteScore
cpAddScore              jmp    gameAddBonus

;-----------------------------------------------------------------------------
; MARK: collidePlayer
collidePlayer           entry
                        tyx
                        ldy    zThingID1
                        lda    activeLayer,y
                        cmp    #LAYER_PARACHUTE
                        bne    cpDead
                        rts
cpDead                  lda    #EXIT_PLAYER_DIED
                        ora    zExitGameMask
                        sta    zExitGameMask
                        inc    zPlayerExitTimer
                        stz    zBulletTimer
                        lda    #2                           ; reset aggression
                        sta    zNumberOfAIFollowersMax
                        lda    #ENEMIES_TO_KILL_TO_CLEAR/2  ; reset difficulty countdown
                        sta    zDifficultyKillCount
; audioPlaySource(AUDIO_BIG_EXPLOSION)
                        ldy    #LAYER_EXPLODE_LARGE
                        jmp    collideThingExplode

;-----------------------------------------------------------------------------
; MARK: collideRemove
collideRemove           entry
                        tyx
                        lda    activeFlags,x
                        ora    #AF_REMOVE
                        sta    activeFlags,x
                        rts

;-----------------------------------------------------------------------------
; MARK: collideRockets
collideRockets          entry
                        tyx                                 ; zThingID0 in x
                        ldy    activeEID,x
                        lda    #2*MAX_OBJECTS
                        sta    enemyWeapon,y                ; reset
                        dec    zNumberOfTracked
                        lda    zNumberOfRockets
                        beq    cerExplode
                        dec    zNumberOfRockets
;                        bne    cerExplode
; audioStopSource(AUDIO_ROCKET_FLY);
cerExplode              ldy    #LAYER_EXPLODE_ROCKETS
                        jsr    collideThingExplode
                        jmp    gameAddScore

;-----------------------------------------------------------------------------
; MARK: collideRts
collideRts              entry

;-----------------------------------------------------------------------------
; MARK: collideSBullets
collideSBullets         entry
                        tyx                                 ; zThingID0 in x
                        ldy    activeEID,x
                        lda    #2*MAX_OBJECTS
                        sta    enemyWeapon,y                ; reset
                        ldy    #LAYER_EXPLODE_BULLETS
                        jsr    collideThingExplode
                        jmp    gameAddScore

;-----------------------------------------------------------------------------
; Since explosions can be a very different size than the object, and the
; object is on-screen at this time and needs to be erased, care has to be
; taken not to draw outsize the boundaries (the object morphs so the erase
; does not know that this used to be a smaller thing).  Do this by, for any
; non-clipped object, forcing on a clip flag and set the on-screen values
; to the full old size.  For previously clipped objects, just keep the clip
; flags and activeVisible values.  This does mean that the 1st erase of a
; dead thing goes through the slower screenErasePartial.
; MARK: collideThingExplode
collideThingExplode     entry
                        tya
                        sta    activeLayer,x                ; morph to explosion
                        lda    activeFlags,x
                        and    #AF_CLIPMASK                 ; see if previously clipped
                        beq    cteSetClip                   ; no - have to set up clip info
                        ora    dt_layer_flags,y             ; yes - keep the clip flags
                        sta    activeFlags,x
                        bra    ctePostClipSetup
cteSetClip              lda    dt_layer_flags,y             ; start with explosion flags
                        ora    #AF_CLIPTY                   ; force a clip flag
                        sta    activeFlags,x
                        lda    activeHeight,x               ; put unclipped size into visible size
                        sta    activeVisibleHeight,x
                        lda    activeWidth,x
                        sta    activeVisibleWidth,x
ctePostClipSetup        lda    dt_layer_active_height,y     ; set the new size
                        sta    activeHeight,x
                        lda    dt_layer_active_width,y
                        sta    activeWidth,x                ; adjust max for size changes
                        clc
                        lda    activeMinX,x
                        adc    activeWidth,x
                        sta    activeMaxX,x
                        clc
                        lda    activeMinY,x
                        adc    activeHeight,x
                        sta    activeMaxY,x
                        lda    #EXPLOSION_HOLD_TIMER        ; set frame and duration
                        sta    activeExtra,x                ; Timer
                        lda    #2*(EXPLOSION_FRAMES-1)      ; 0 based
                        sta    activeFrame,x
                        rts

;-----------------------------------------------------------------------------
; MARK: collideThings
collideThings           entry
                        ldx    activeLayer,y
                        jmp    (at_handler_collision,x)

thisisaformattinglabel  anop
                        END
