;-----------------------------------------------------------------------------
; ai.asm
; Part of Time Pilot, the 1982 arcade game remake for the Apple IIgs
;
; Stefan Wessels, 2024
; This is free and unencumbered software released into the public domain.
;-----------------------------------------------------------------------------

                        copy   src/globals.s
                        mcopy  src/ai.mac

AI                      START

                        using  GAMEDATA
                        using  VARIABLES

;-----------------------------------------------------------------------------
; Thing in X, velocity index in Y (velocity desired index * 32 + 0 .. 31)
; Use VELOCITY_nnn defines for desired velocity * 32
; MARK: aiAddVelocity
aiAddVelocity           entry
                        clc
                        lda    dt_velocity_x_frac,y         ; first the fraction
                        adc    activeXVelFrac,x
                        sta    activeXVelFrac,x
                        lda    dt_velocity_x,y              ; then the integer part
                        adc    activeMinX,x
                        sta    activeMinX,x
                        clc
                        adc    activeWidth,x
                        sta    activeMaxX,x                 ; update the max (min + width)
                        clc
                        lda    dt_velocity_y_frac,y
                        adc    activeYVelFrac,x
                        sta    activeYVelFrac,x
                        lda    dt_velocity_y,y
                        adc    activeMinY,x
                        sta    activeMinY,x
                        clc
                        adc    activeHeight,x
                        sta    activeMaxY,x
                        rts

;-----------------------------------------------------------------------------
; MARK: aiBomber
aiBomber                entry
                        ldx    zThingID0
                        jsr    aiHorizontalFlyer
                        lda    activeFlags,x
                        bit    #AF_REMOVE                   ; is flyer now off-screen?
                        beq    aebAlive
                        lda    #BOMBER_TIMER                ; yes, reset the time to bomber
                        sta    zBomberTimer
                        rts
aebAlive                lda    zBomberHealth
                        cmp    #BOMBER_HEALTH
                        bcc    aebAnimate
                        rts
aebAnimate              lda    zFrameCounter
                        and    #3
                        beq    aebAnimateTime
                        rts
aebAnimateTime          lda    activeFrame,x
                        dea
                        dea
                        bpl    aebSetFrame
                        lda    zBomberHealth
                        asl    a
                        tay
                        lda    bossHealthFrames,y
aebSetFrame             sta    activeFrame,x
                        rts

;-----------------------------------------------------------------------------
; MARK: aiBombs
aiBombs                 entry
                        ldx    zThingID0
                        lda    zInvPlayerAngle
                        adc    #VELOCITY_119
                        tay
                        jsr    aiAddVelocity
                        lda    activeFlags,x
                        bit    #AF_DIR_RIGHT
                        beq    aebLeft
                        lda    activeFrame,x
                        cmp    #12                          ; 69 deg, down to right
                        clc
                        beq    aebMax                       ; at max fall angle
                        tay
                        lda    zFrameCounter                ; animate every 4 frames
                        and    #3
                        bne    aebSteady
                        tya
                        ina                                 ; increase angle (going right)
                        ina
                        and    #62
                        sta    activeFrame,x
                        adc    #VELOCITY_150
                        tay
                        jsr    aiAddVelocity
                        jmp    aiNonWrapping
aebLeft                 lda    activeFrame,x
                        cmp    #20                          ; 69 deg, down to left
                        clc
                        beq    aebMax
                        tay
                        lda    zFrameCounter
                        and    #3
                        bne    aebSteady
                        tya
                        dea                                 ; decrease angle (going left)
                        dea
                        sta    activeFrame,x
                        adc    #VELOCITY_150
                        tay
                        jsr    aiAddVelocity
                        jmp    aiNonWrapping
aebSteady               tya
                        adc    #VELOCITY_150
                        tay
                        jsr    aiAddVelocity
                        jmp    aiNonWrapping
aebMax                  adc    #VELOCITY_200
                        tay
                        jsr    aiAddVelocity
                        jmp    aiNonWrapping

;-----------------------------------------------------------------------------
; MARK: aiBoomerang
aiBoomerang             entry
                        ldx    zThingID0
                        lda    zFrameCounter
                        and    #15
                        bne    aebrNoTurn
                        lda    activeMinX,x
                        cmp    #(PLAYFIELDW/2+8)*8
                        bcs    aebrNoTurn                   ; right of right
                        cmp    #(PLAYFIELDW/2-8)*8
                        bcc    aebrNoTurn                   ; left of left
                        lda    activeMinY,x
                        cmp    #(PLAYFIELDH/2+8)*8
                        bcs    aebrNoTurn                   ; too low
                        cmp    #(PLAYFIELDH/2-8)*8
                        bcc    aebrNoTurn                   ; too high
                        jsr    aiTurnOnRay
                        clc
                        sta    activeExtra,x                ; Heading
                        lda    zFrameCounter
aebrNoTurn              and    #1
                        bne    aebrNoAnim
                        lda    activeFrame,x
                        ina
                        ina
                        and    #14
                        sta    activeFrame,x
aebrNoAnim              lda    zInvPlayerAngle
                        adc    #VELOCITY_119
                        tay
                        jsr    aiAddVelocity
                        lda    activeExtra,x                ; Heading
                        adc    #VELOCITY_200
                        tay
                        jsr    aiAddVelocity
                        jmp    aiNonWrapping

;-----------------------------------------------------------------------------
; MARK: aiBoss
aiBoss                  entry
                        ldx    zThingID0
                        jsr    aiHorizontalFlyer
                        lda    activeFlags,x
                        bit    #AF_REMOVE                   ; is flyer now off-screen?
                        beq    albMaybeAnimate
                        lda    #BOSS_TIMER                  ; yes, reset the time to spawn
                        sta    zBossTimer
                        rts
albMaybeAnimate         lda    zFrameCounter                ; animates every 8 frames
                        and    #7
                        beq    albAnimate
                        rts
albAnimate              lda    zActiveStage                 ; space is different
                        cmp    #TIME_PERIOD4_2001
                        bne    albNotSpace
                        lda    activeFrame,x                ; just flip between two frames in space
                        eor    #2
                        sta    activeFrame,x
                        lda    PALETTE_BASE+COLOR_PROP0*2   ; flip the prop colors
                        pha
                        lda    PALETTE_BASE+COLOR_PROP1*2
                        sta    PALETTE_BASE+COLOR_PROP0*2
                        pla
                        sta    PALETTE_BASE+COLOR_PROP1*2
                        rts
albNotSpace             lda    zBossHealth                  ; only animate if not 100%
                        cmp    #BOSS_HEALTH
                        bne    albDecFrame
                        rts
albDecFrame             dec    activeFrame,x                ; prev frame
                        dec    activeFrame,x
                        bmi    albResetFrame                ; if out of range, reset
                        rts
albResetFrame           and    #6                           ; keep health even for lookup
                        tay
                        lda    bossHealthFrames,y           ; Look up frame based on health
                        sta    activeFrame,x
                        rts

;-----------------------------------------------------------------------------
; MARK: aiBullets
aiBullets               entry
                        ldx    zThingID0
                        lda    zInvPlayerAngle
                        adc    #VELOCITY_119
                        tay
                        jsr    aiAddVelocity                ; can leave carry set
                        lda    activeExtra,x                ; Heading
                        clc
                        adc    #VELOCITY_200
                        tay
                        jsr    aiAddVelocity
                        jmp    aiNonWrapping

;-----------------------------------------------------------------------------
; See if things that wrap (clouds) should wrap
; IN: x = index of thing
; MARK: aiCheckWrap
aiCheckWrap             entry
                        lda    activeMinX,x
                        cmp    #-WRAP_SIZE
                        bpl    acwRight
                        clc
                        lda    #WRAP_SIZE+SCREEN_PRIGHT
                        sta    activeMaxX,x
                        sec
                        sbc    activeWidth,x
                        sta    activeMinX,x
                        bra    acwTop
acwRight                lda    #WRAP_SIZE+SCREEN_PRIGHT
                        cmp    activeMaxX,x
                        bpl    acwTop
                        lda    #-WRAP_SIZE
                        sta    activeMinX,x
                        clc
                        adc    activeWidth,x
                        sta    activeMaxX,x
acwTop                  lda    activeMinY,x
                        cmp    #-WRAP_SIZE
                        bpl    acwBottom
                        sec
                        lda    #WRAP_SIZE+SCREEN_PBOTTOM
                        sta    activeMaxY,x
                        sbc    activeHeight,X
                        sta    activeMinY,x
                        rts
acwBottom               lda    #WRAP_SIZE+SCREEN_PBOTTOM
                        cmp    activeMaxY,x
                        bpl    wrapDone
                        lda    #-WRAP_SIZE
                        sta    activeMinY,x
                        clc
                        adc    activeHeight,x
                        sta    activeMaxY,x
wrapDone                rts

;-----------------------------------------------------------------------------
; MARK: aiClouds0
aiClouds0               entry
                        ldx    zThingID0
                        ldy    zInvPlayerAngle              ; velocity 50 = 0
                        jsr    aiAddVelocity
                        jmp    aiCheckWrap

;-----------------------------------------------------------------------------
; MARK: aiClouds1
aiClouds1               entry
                        ldx    zThingID0
                        lda    zInvPlayerAngle
                        adc    #VELOCITY_075
                        tay
                        jsr    aiAddVelocity
                        jmp    aiCheckWrap

;-----------------------------------------------------------------------------
; MARK: aiClouds2
aiClouds2               entry
                        ldx    zThingID0
                        lda    zInvPlayerAngle
                        adc    #VELOCITY_119
                        tay
                        jsr    aiAddVelocity
                        jmp    aiCheckWrap

;-----------------------------------------------------------------------------
; MARK: aiEndFrame
aiEndFrame              entry
                        lda    zPlayerExitTimer             ; if != 0 something's up
                        beq    aefNoExitTimer
                        ina
                        cmp    #PLAYER_DIED_TIMER           ; reached end?
                        bcc    aefNotDieTimer               ; not yet
                        lda    #-1                          ; yes, set to negative
aefNotDieTimer          sta    zPlayerExitTimer
                        rts                                 ; and end here
aefNoExitTimer          lda    zBossHealth
                        bpl    aefBossOkay                  ; if has health okay
                        rts                                 ; else end here
aefBossOkay             inc    zScoreTimer                  ; quick kills score more - time kills
                        lda    zEnemiesKilled
                        cmp    #ENEMIES_TO_KILL_TO_CLEAR+1  ; made needed progress to get boss?
                        bcc    aefStageActive               ; not yet
                        lda    zBossHealth                  ; Boss is still alive?
                        beq    aefNoBossAudio               ; no - no boss audio
; !audioIsSourcePlaying(stageBossAudio[activeStage])) audioPlaySource(stageBossAudio[activeStage])
aefNoBossAudio          lda    zBossTimer                   ; countdown alive?
                        bmi    aefBulletTrampoline          ; no - don't consider spawning a boss
                        dec    zBossTimer
                        bpl    aefBulletTrampoline          ; >= 0 not yet time to spawn
                        jsr    aiRandom                     ; maybe move boss spawn up/down a little
                        and    #6
                        sec
                        sbc    #4
                        clc
                        adc    zPlayerAngle
                        and    #62
                        tay
                        lda    dt_horizonal_launch,y        ; pick a vertical launch point in screen limits
                        tay
                        lda    dt_launch_y,y
                        sta    zSpawnY
                        lda    dt_horizontal,y              ; see if boss is moving left or right
                        beq    aefBossToLeft                ; is it AF_NONE?
                        lda    #-32                         ; moving right start off screen left
                        bra    aefSaveBossSpawnX
aefBossToLeft           lda    #224                         ; start off screen right and move left
aefSaveBossSpawnX       sta    zSpawnX
                        ldy    #LAYER_BOSS
                        jsr    thingsAdd                    ; spawn the boss
                        lda    zSpawnX
                        bpl    aefBulletTrampoline          ; if moving left, done
                        lda    activeFlags,x                ; mark flags
                        ora    #AF_DIR_RIGHT                ; as moving right
                        sta    activeFlags,x
aefBulletTrampoline     jmp    aefBulletTimer
aefStageActive          lda    zActiveStage                 ; not yet boss time
                        cmp    #TIME_PERIOD4_2001           ; space?
                        beq    aefBulletTimer               ; yes - skip parachute
                        lda    zParachuteTimer
                        bmi    aefBomberTimer               ; if timer < 0 then skip
                        dec    zParachuteTimer
                        bne    aefBomberTimer               ; if timer now <> 0 then skip
                        dec    zParachuteTimer              ; make timer -1
                        jsr    aiRandom                     ; get spawn offset in front of
                        and    #6                           ; player but randomly moved to a side
                        sec
                        sbc    #4
                        adc    zPlayerAngle
                        and    #62
                        tay
                        lda    dt_launch_x,y
                        sta    zSpawnX
                        lda    dt_launch_y,y
                        sta    zSpawnY
                        ldy    #LAYER_PARACHUTE
                        jsr    thingsAdd                    ; and spawn the parachute
aefBomberTimer          lda    zBomberTimer                 ; see if it's time for a bomber
                        bmi    aefBulletTimer               ; if timer <= 0, no bomber
                        beq    aefBulletTimer
                        dec    zBomberTimer
                        bne    aefBulletTimer               ; if timer not reached 0 skip
                        jsr    aiRandom                     ; maybe move boss spawn up/down a little
                        and    #6
                        sec
                        sbc    #4
                        clc
                        adc    zPlayerAngle
                        and    #62
                        tay
                        lda    dt_horizonal_launch,y        ; pick a vertical launch point in screen limits
                        tay
                        lda    dt_launch_y,y
                        sta    zSpawnY
                        lda    dt_horizontal,y
                        beq    aefBomberToLeft
                        lda    #-32
                        bra    aefSaveBomberSpawnX
aefBomberToLeft         lda    #224
aefSaveBomberSpawnX     sta    zSpawnX
                        ldy    #LAYER_BOMBER
                        jsr    thingsAdd                    ; spawn the bomber
                        lda    #BOMBER_HEALTH
                        sta    zBomberHealth                ; set at full health
                        lda    zSpawnX                      ; set flag if moving to right
                        bpl    aefBulletTimer
                        lda    activeFlags,x
                        ora    #AF_DIR_RIGHT
                        sta    activeFlags,x
aefBulletTimer          lda    zBulletTimer
                        beq    aefEnemies                   ; no timer no spawn
                        and    #7                           ; spawn only every 8 frames
                        bne    aefBulletCountdown           ; so not now
                        lda    #PLAYER_X+6
                        sta    zSpawnX
                        lda    #PLAYER_Y+8
                        sta    zSpawnY
                        ldy    #LAYER_PLAYER_BULLETS
                        jsr    thingsAdd
                        lda    zPlayerAngle
                        sta    activeExtra,x                ; Heading
; audioPlay AUDIO_PLAYER_SHOOT
aefBulletCountdown      dec    zBulletTimer
aefEnemies              lda    zActiveStage                 ; is the stage space
                        cmp    #TIME_PERIOD4_2001           ; then skip waves
                        bne    aefNotSpace
                        jmp    aefNoSpaceWaves
aefNotSpace             lda    zAiSpawnTimer                ; time to spawn a wave?
                        cmp    #ENEMY_SPAWN_WAVE_TIMER
                        bcc    aefNoWaveYet                 ; no
                        bne    aefMaybeSpawnNext
                        lda    zPlayerAngle                 ; based on player angle
                        sta    zWaveSpawnL                  ; set left and right spawn points
                        sta    zWaveSpawnR
                        lda    #MAX_ENEMY_INDEX
                        sec
                        sbc    zNumberOfEnemies
                        cmp    #3                           ; Enough open enemy spots
                        bcs    aefEnoughToSpawn             ; to spawn a wave
                        stz    zAiSpawnTimer                ; reset spawn timer
                        rts                                 ; return - not enough spots
aefEnoughToSpawn        cmp    #6                           ; more then 5?
                        bcs    aefMakeFiveOnly
                        cmp    #4                           ; exactly 4
                        bne    aefConfigWave
                        pha
                        lda    zWaveSpawnL                  ; skip the tip enemy
                        dea
                        dea
                        and    #62
                        sta    zWaveSpawnL                  ; move l and r +|- 1 with wrap
                        lda    zWaveSpawnR
                        ina
                        ina
                        and    #62
                        sta    zWaveSpawnR
                        pla
                        bra    aefConfigWave
aefMakeFiveOnly         lda    #5
aefConfigWave           sta    zWaveSpawnCount
                        sta    zNumberOfWaveEnemies
                        lda    zInvPlayerAngle
                        sta    zWaveSpawnDir
                        jsr    aiRandom
                        and    #15
                        adc    #ENEMY_WAVE_ENTRY_TIMER      ; how long wave formation lasts + random
                        sta    zWaveSpawnDuration
                        lda    #2*MAX_ENEMY_INDEX
                        sta    zWaveSpawnIndex
; audioPlaySource(AUDIO_WAVE_START)
                        rts
aefMaybeSpawnNext       and    #ENEMY_SPAWN_TIMER/2
                        beq    aefSpawnNext
                        rts
aefSpawnNext            jmp    aiSpawnWave                  ; spawn and finish
aefNoWaveYet            and    #ENEMY_SPAWN_TIMER
                        ora    zPlayerExitTimer
                        beq    aefSpawnOrRecall
                        rts
aefSpawnOrRecall        lda    zAiSpawnTimer
                        cmp    #ENEMY_RECALL_TIMER
                        bcc    aefCheckIfEnemySpace
                        beq    aefDoRecall
                        rts
aefDoRecall             jmp    aiRecallEnemies
aefNoSpaceWaves         lda    zAiSpawnTimer
                        and    #ENEMY_SPAWN_TIMER
                        ora    zPlayerExitTimer
                        beq    aefCheckIfEnemySpace
                        rts
aefCheckIfEnemySpace    lda    zNumberOfEnemies
                        cmp    #MAX_ENEMY_INDEX+1
                        bcc    aefRoomForEnemy
                        rts
aefRoomForEnemy         jmp    aiSpawnEnemy

;-----------------------------------------------------------------------------
; MARK: aiEnemy
aiEnemy                 entry
taeTarget               equ    zTemp00
                        ldx    zThingID0
                        lda    zInvPlayerAngle
                        adc    #VELOCITY_119                ; move by player
                        tay
                        jsr    aiAddVelocity
                        ldy    zEnemyIdx                    ; keep EnemyIdx in Y (enemy meant to think)
                        lda    enemyID,y                    ; Get the enemy at index
                        cmp    zThingID0                    ; is it this enemy
                        beq    aeEnemyThinks                ; yes, run ai for this enemy
                        jmp    aeStageVelocity              ; no, just move this enemy by its own power
aeEnemyThinks           lda    #-1
                        sta    taeTarget                    ; mark target as not calculated
                        lda    activeFlags,x                ; is enemy in a wave
                        bit    #AF_AI_WAVE                  ; then do wave level things
                        beq    aeNotWave
                        dec    activeExtra,x                ; Timer expires = make changes
                        bne    aeBeamFlgsLoaded
                        bit    #AF_AI_FLEE+AF_AI_FOLLOW
                        beq    aeConfigWave                 ; wave+no action - intact so start scatter
                        and    #$FFFF-AF_AI_WAVE            ; wave+action already scattered so disband
                        sta    activeFlags,X                ; meaning no wave killing bonus
                        bra    aeBeamFlgsLoaded
aeConfigWave            ldy    zNumberOfAIFollowers         ; scatter - fill follow quota
                        cpy    zNumberOfAIFollowersMax
                        bcs    aeWaveToFlee                 ; already all the followers?
                        iny
                        sty    zNumberOfAIFollowers         ; add as follower
                        ora    #AF_AI_FOLLOW
                        sta    activeFlags,x
                        bra    aeSetWaveTime
aeWaveToFlee            ora    #AF_AI_FLEE                  ; disband to flee state - follower quota full
                        sta    activeFlags,x
                        ldy    zEnemyIdx
                        lda    #2*MAX_OBJECTS+1             ; try to prevent fleeing enemy from shooting
                        sta    enemyWeapon,y
aeSetWaveTime           lda    #ENEMY_WAVE_ACTIVE_TIMER
                        sta    activeExtra,x                ; timer
                        bra    aeBeam
aeNotWave               dec    activeExtra,x                ; Timer
                        bne    aeBeamFlgsLoaded
                        jsr    aiRandom
                        and    #62
                        sta    enemyHeading,y
                        lsr    a                            ; reuse random number as a timer modifier
                        adc    #ENEMY_STEADY_MIN_TIME       ; random clears carry
                        sta    activeExtra,x                ; timer
aeBeam                  lda    activeFlags,x                ; if flee or follow
aeBeamFlgsLoaded        bit    #AF_AI_FOLLOW+AF_AI_FLEE
                        beq    aeTurn                       ; not fleeing or following
                        lda    activeMinY,x
                        asl    a
                        asl    a                            ; ((y >> 4) << 6) (for 16 bit row lookup)
                        and    #1984                        ; 31*64 [bytes per row] = 1984 - clamp to 32x32 table
                        sta    taeTarget
                        lda    activeMinX,x                 ; get col for table
                        and    #496                         ; (62 << 3) 62 - even bytes per row
                        lsr    a                            ; x / 8
                        lsr    a
                        lsr    a                            ; carry clear due to and earlier
                        adc    taeTarget                    ; the address of the value in rays[y][x]
                        tay
                        lda    dt_movement_rays,y
                        sta    taeTarget                    ; set target
                        lda    activeFlags,x
                        and    #AF_AI_FLEE
                        beq    aeNotFleeing                 ; not fleeing
                        lda    taeTarget
                        eor    #32                          ; invert target when fleeing
                        sta    taeTarget
aeNotFleeing            lda    taeTarget
                        ldy    zEnemyIdx                    ; restore zEnemyIdx
                        sta    enemyHeading,y               ; make heading = target
aeTurn                  lda    enemyHeading,y
                        sec
                        sbc    activeFrame,x
                        beq    aeThinkShoot                 ; already facing desired
                        bit    #32                          ; a >= 32 - turn anti clock
                        beq    eaTurnClock
                        lda    activeFrame,x
                        dea
                        dea
                        bra    aeSaveCurr
eaTurnClock             lda    activeFrame,x
                        ina                                 ; turn clockwise
                        ina
aeSaveCurr              and    #62                          ; stay in range
                        sta    activeFrame,x                ; set new facing direction
aeThinkShoot            lda    enemyWeapon,y                ; y is still enemyIdx
                        cmp    #2*MAX_OBJECTS               ; already has a bullet?
                        bne    aeGoStageVelocity            ; yes, don't shoot
                        lda    zExitGameMask
                        and    #EXIT_PLAYER_DIED            ; don't shoot when player dead
                        beq    aePossiblyShoot
aeGoStageVelocity       jmp    aeStageVelocity
aePossiblyShoot         lda    taeTarget
                        bpl    aeHasTarget                  ; has target been calculated
                        lda    activeMinY,x                 ; no, calculate target
                        asl    a
                        asl    a                            ; ((y >> 4) << 6) (for 16 bit row lookup)
                        and    #1984                        ; 31*64 [bytes per row] = 1984 - clamp to 32x32 table
                        sta    taeTarget
                        lda    activeMinX,x                 ; get col for table
                        and    #496                         ; (62 << 3) 62 - even bytes per row
                        lsr    a                            ; x / 8
                        lsr    a
                        lsr    a                            ; carry clear due to and earlier
                        adc    taeTarget                    ; the address of the value in dt_movement_rays[y][x]
                        tay
                        lda    dt_movement_rays,y
                        sta    taeTarget
aeHasTarget             cmp    activeFrame,X                ; if target = facing, then facing player
                        bne    aePlayerUnsighted            ; player not lined up
                        sec
                        sbc    zPlayerAngle                 ; calculate if player is pointing within
                        and    #62                          ; a pie of this enemy's target dir
                        cmp    #60                          ; incl. 60, 62, 00, 02, 04
                        bcs    aeShoot
                        cmp    #6
                        bcs    aeStageVelocityLong
aeShoot                 lda    activeMinX,x
                        clc
                        adc    #8
                        sta    zSpawnX
                        lda    activeMinY,x
                        adc    #4
                        sta    zSpawnY
                        phx
                        ldy    #LAYER_BULLETS
                        jsr    thingsAdd
                        ldy    zEnemyIdx                    ; zEnemyIdx
                        sta    enemyWeapon,y                ; a = x = bulletId into enemyWeapon
                        tya
                        sta    activeEID,x
                        txy                                 ; bulletID into Y
                        plx                                 ; restore enemy id
                        lda    activeFrame,X                ; thing heading
                        sta    activeExtra,y                ; into bullet heading
; audioPlaySource(AUDIO_ENEMY_SHOOT)
aeStageVelocityLong     jmp    aeStageVelocity
aePlayerUnsighted       lda    zActiveStage
                        cmp    #TIME_PERIOD1_1940
                        beq    aeStageVelocityLong          ; no bombs/rockets in 1940
                        lda    zNumberOfTracked
                        cmp    zNumberOfTrackedMax
                        bcs    aeStageVelocityLong          ; no room for more bombs or rockets
                        lda    zActiveStage
                        bne    aeNotStage0                  ; rockets 1970+
                        lda    zLaunchSide                  ; bombs in 1910
                        bne    aeChkFromRight               ; bomb needs to come from right
                        lda    activeMinX,x                 ; look for bomb window on left
                        cmp    #WEAPON_BORDER
                        bcs    aeStageVelocityLong          ; too close to player, pass
                        lda    taeTarget                    ; take enemy facing direction
                        cmp    #4
                        bcc    aeL0BombOkay
                        cmp    #62
                        beq    aeL0BombOkay                 ; angle too steep up
                        bra    aeStageVelocityLong
aeChkFromRight          lda    activeMinX,x
                        cmp    #PLAYFIELDW*8-WEAPON_BORDER
                        bcc    aeStageVelocityLong          ; not in window at (from) right
aeOtherWdge             lda    taeTarget
                        cmp    #30
                        bcc    aeStageVelocityLong          ; too steep down
                        cmp    #36
                        bcs    aeStageVelocityLong          ; too steep up
aeL0BombOkay            lda    activeMinX,x
                        clc
                        adc    #8
                        sta    zSpawnX
                        lda    activeMinY,X
                        adc    #4
                        sta    zSpawnY
                        ldy    #LAYER_ROCKETS
                        phx
                        jsr    thingsAdd
                        ldy    zEnemyIdx
                        sta    enemyWeapon,y                ; bomb ID
                        tya                                 ; enemyIdx
                        sta    activeEID,x
                        lda    zLaunchSide
                        bne    aeBombToLeft
                        lda    #58
                        sta    activeFrame,x
                        lda    #AF_DIR_RIGHT
                        ora    activeFlags,x                ; flag bomb |= RIGHT
                        sta    activeFlags,x
                        bra    aeBombsAway
aeBombToLeft            lda    #38
                        sta    activeFrame,x
aeBombsAway             inc    zNumberOfTracked
                        lda    #1
                        eor    zLaunchSide
                        sta    zLaunchSide
; audioPlaySource(AUDIO_BOMB)
                        plx                                 ; restore thing index
                        bra    aeStageVelocity
aeNotStage0             lda    zLaunchSide
                        bne    aeRocketFromRight
                        lda    activeMinY,x
                        cmp    #WEAPON_BORDER
                        bcc    aeLaunchRocket
                        lda    activeMinX,x
                        cmp    #WEAPON_BORDER
                        bcs    aeStageVelocity
                        bra    aeLaunchRocket
aeRocketFromRight       lda    activeMinY,x
                        cmp    #PLAYFIELDH*8-WEAPON_BORDER
                        bcs    aeLaunchRocket
                        lda    activeMinX,x
                        cmp    #PLAYFIELDW*8-WEAPON_BORDER
                        bcc    aeStageVelocity
aeLaunchRocket          anop
; audioPlaySource(AUDIO_ROCKET_LAUNCH)
                        lda    activeMinX,x
                        clc
                        adc    #8
                        sta    zSpawnX
                        lda    activeMinY,x
                        adc    #4
                        sta    zSpawnY
                        lda    zActiveStage
                        cmp    #TIME_PERIOD2_1970
                        bne    aeNotRocket
; audioPlaySource(AUDIO_ROCKET_FLY)
aeNotRocket             inc    zNumberOfRockets
                        ldy    #LAYER_ROCKETS
aeSetRocket             phx
                        jsr    thingsAdd
                        ldy    zEnemyIdx
                        sta    enemyWeapon,y
                        tya
                        sta    activeEID,x
                        txy
                        plx
                        lda    activeFrame,x                ; launcher heading
                        sta    activeExtra,y                ; into rocket heading
                        inc    zNumberOfTracked
                        lda    #1
                        eor    zLaunchSide
                        sta    zLaunchSide
aeStageVelocity         lda    #VELOCITY_100                ; pre 1982
                        ldy    zActiveStage
                        cpy    #TIME_PERIOD3_1982           ; 1982+ moves faster
                        bcc    aeTPOk
                        clc
                        lda    #VELOCITY_119                ; 1982 and post
aeTPOk                  adc    activeFrame,x                ; get direction
                        tay
                        jsr    aiAddVelocity                ; move enemy by its own velocity
                        jmp    aiNonWrapping

;-----------------------------------------------------------------------------
; MARK: aiExplodeThing
aiExplodeThing          entry
                        ldx    zThingID0
                        dec    activeExtra,x                ; timer
                        bpl    aetNoAnim
                        lda    activeFrame,x
                        dea
                        dea
                        bpl    aetNotDone
                        lda    #AF_REMOVE
                        ora    activeFlags,x
                        sta    activeFlags,x
                        rts
aetNotDone              sta    activeFrame,x
                        lda    activeWidth,x
                        bit    #32
                        bne    aet32
aet16                   ldy    activeFrame,x
                        lda    dt_explode_small_ftime,y
                        sta    activeExtra,x                ; timer
                        bra    aetNoAnim
aet32                   ldy    activeFrame,x
                        lda    dt_explode_large_ftime,y
                        sta    activeExtra,x                ; timer
aetNoAnim               lda    zInvPlayerAngle
                        clc
                        adc    #VELOCITY_119
                        tay
                        jsr    aiAddVelocity
                        jmp    aiNonWrapping

;-----------------------------------------------------------------------------
; MARK: aiHorizontalFlyer
aiHorizontalFlyer       entry
                        lda    zInvPlayerAngle              ; Move flyer based on player
                        adc    #VELOCITY_119
                        tay
                        jsr    aiAddVelocity
                        ldy    #VELOCITY_100                ; Move flyer based on own propulsion
                        lda    activeFlags,x
                        bit    #AF_DIR_RIGHT
                        bne    ahfRight
                        ldy    #VELOCITY_100+32
ahfRight                jsr    aiAddVelocity
                        jsr    aiNonWrapping
                        lda    zFrameCounter                ; see if flyer might want to shoot
                        and    #31
                        beq    ahfMaybeShoot
                        rts
ahfMaybeShoot           lda    zNumberOfAIFollowersMax      ; see if aggressive mode on
                        cmp    #3
                        bcs    ahfAggressive                ; yes - raised state so can shoot
                        rts
ahfAggressive           lda    zNumberOfTracked             ; Not too many bullets in the air?
                        cmp    zNumberOfTrackedMax
                        bcc    ahfShootOnScreen
                        rts
ahfShootOnScreen        lda    activeOffScreen,x
                        beq    ahfShoot
                        rts
ahfShoot                lda    activeMinY,x                 ; get the bullet launch pos
                        adc    #4
                        sta    zSpawnY
                        lda    activeMinX,x
                        adc    #15
                        sta    zSpawnX
                        ldy    #LAYER_BULLETS
                        jsr    thingsAdd
                        lda    #PLAYFIELDW*8/2              ; is the flyer left or right of player?
                        cmp    zSpawnX
                        bcc    ahfShootToLeft               ; spawn > mid so on right, shoot left
                        jsr    aiRandom
                        and    #30
                        sec                                 ; random clears carry
                        sbc    #16
                        and    #63
                        bra    ahfSetBulletDir
ahfShootToLeft          jsr    aiRandom
                        and    #30
                        adc    #16
ahfSetBulletDir         sta    activeExtra,x                ; Heading
                        lda    activeFlags,x                ; flyer bullets are tracked
                        ora    #AF_TRACKED
                        sta    activeFlags,x
                        inc    zNumberOfTracked
                        ldx    zThingID0                    ; restore the flyer's id to x
                        rts

;-----------------------------------------------------------------------------
; MARK: aiNonWrapping
aiNonWrapping           entry
                        lda    activeFlags,x
                        tay                                 ; keep activeFlags in Y
                        and    #AF_CLIPMASK
                        cmp    #AF_CLIPMASK
                        beq    anwOffScreen
                        stz    activeOffScreen,x
                        rts
anwOffScreen            lda    activeLayer,x
                        cmp    #LAYER_PLAYER_BULLETS        ; bullets die instantly off-screen
                        bne    anwNotPB
                        tya                                 ; activeFlags to a
                        ora    #AF_REMOVE
                        sta    activeFlags,x
                        rts
anwNotPB                cmp    #LAYER_BULLETS
                        bne    anwCount
anwIsBullet             tya                                 ; activeFlags to a
                        ora    #AF_REMOVE
                        sta    activeFlags,x
                        bit    #AF_TRACKED
                        beq    anwEnemyBullet
                        dec    zNumberOfTracked
                        rts
anwEnemyBullet          ldy    activeEID,x
                        lda    #2*MAX_OBJECTS
                        sta    enemyWeapon,y
                        rts
anwCount                inc    activeOffScreen,x            ; something that lives off screen
                        lda    activeOffScreen,x
                        cmp    #ACTIVEOFFSCREEN_COUNT
                        beq    anwCountOut
                        rts
anwCountOut             tya                                 ; activeFlags to a
                        ora    #AF_REMOVE
                        sta    activeFlags,x
                        ldy    activeLayer,x
                        cpy    #LAYER_ENEMY
                        bne    anwWeaponCheck
                        dec    zNumberOfEnemies
                        pha
                        ldy    activeEID,x
                        lda    #2*MAX_OBJECTS
                        sta    enemyID,y
                        pla                                 ; activeFlags to a
                        and    #AF_AI_FOLLOW
                        bne    anwDidFollow
                        rts
anwDidFollow            dec    zNumberOfAIFollowers
                        rts
anwWeaponCheck          lda    activeLayer,x
                        cmp    #LAYER_ROCKETS
                        beq    anwIsWeapon
anwMaybeWeapon          cmp    #LAYER_BULLETS
                        beq    anwIsWeapon
                        rts
anwIsWeapon             dec    zNumberOfTracked
                        ldy    activeEID,x
                        lda    #2*MAX_OBJECTS
                        sta    enemyWeapon,y
                        lda    zNumberOfRockets
                        bne    anwRocket
                        rts
anwRocket               dec    zNumberOfRockets
                        beq    anwStopRocketSound
                        rts
anwStopRocketSound      anop
; audioStopSource(AUDIO_ROCKET_FLY)
                        rts

;-----------------------------------------------------------------------------
; MARK: aiParachute
aiParachute             entry
                        ldx    zThingID0
                        lda    zFrameCounter
                        and    #15
                        bne    apMove
                        dec    activeExtra,x
                        dec    activeExtra,x
                        lda    activeExtra,x
                        bpl    apFrameOkay
                        lda    #10
                        sta    activeExtra,x
apFrameOkay             tay
                        lda    dt_parachute_frame,y
                        sta    activeFrame,x
apMove                  lda    zInvPlayerAngle
                        adc    #VELOCITY_119
                        tay
                        jsr    aiAddVelocity
                        jsr    aiNonWrapping
                        lda    activeFlags,x
                        and    #AF_REMOVE
                        bne    apRemove
                        rts
apRemove                lda    #PARACHUTE_TIMER
                        sta    zParachuteTimer
                        stz    zParachuteScore
                        rts

;-----------------------------------------------------------------------------
; MARK: aiPlayer
aiPlayer                entry
                        jsr    inputInGame
                        ldx    zThingID0
                        rts

;-----------------------------------------------------------------------------
; MARK: aiPlayerBullets
aiPlayerBullets         entry
                        ldx    zThingID0
                        lda    activeExtra,x                ; Heading
                        adc    #VELOCITY_400
                        tay
                        jsr    aiAddVelocity
                        jmp    aiNonWrapping

;-----------------------------------------------------------------------------
; MARK: aiRandom
aiRandom                entry
                        lda    zRandomSeed
                        asl    a
                        bit    #$80
                        beq    arOkay
                        eor    #$1d
arOkay                  and    #$FF
                        sta    zRandomSeed
                        rts

;-----------------------------------------------------------------------------
; MARK: aiRecallEnemies
aiRecallEnemies         entry
                        ldy    #2*MAX_ENEMY_INDEX
areLoop                 lda    enemyID,y
                        cmp    #2*MAX_OBJECTS
                        beq    areNext
                        tax
                        lda    activeFlags,x
                        ora    #AF_AI_FLEE
                        sta    activeFlags,x
areNext                 dey
                        dey
                        bpl    areLoop
                        rts

;-----------------------------------------------------------------------------
; MARK: aiRockets
aiRockets               entry
                        ldx    zThingID0
                        lda    zInvPlayerAngle
                        adc    #VELOCITY_119
                        tay
                        jsr    aiAddVelocity
                        lda    zFrameCounter
                        and    #15
                        bne    aesbNoTurn
                        jsr    aiTurnOnRay
                        sta    activeExtra,x                ; Heading
                        and    #$FFFC
                        lsr    a
                        sta    activeFrame,x
aesbNoTurn              lda    activeExtra,x                ; Heading
                        adc    #VELOCITY_150
                        tay
                        jsr    aiAddVelocity
                        jmp    aiNonWrapping

;-----------------------------------------------------------------------------
; MARK: aiSBullets
aiSBullets              entry
                        ldx    zThingID0
                        lda    zInvPlayerAngle
                        adc    #VELOCITY_119
                        tay
                        jsr    aiAddVelocity
                        lda    activeExtra,x                ; Heading
                        adc    #VELOCITY_200
                        tay
                        jsr    aiAddVelocity
                        lda    zFrameCounter
                        and    #3
                        bne    aesbNoAnim
                        lda    activeFrame,x
                        ina
                        ina
                        and    #14
                        sta    activeFrame,x
aesbNoAnim              jmp    aiNonWrapping

;-----------------------------------------------------------------------------
; MARK: aiScores
aiScores                entry
                        ldx    zThingID0
                        dec    activeExtra,x                ; Timer
                        bne    asAlive
                        lda    #AF_REMOVE
                        ora    activeFlags,x
                        sta    activeFlags,x
                        rts
asAlive                 lda    zInvPlayerAngle              ; move relative to player
                        adc    #VELOCITY_119
                        tay
                        jsr    aiAddVelocity
                        jmp    aiNonWrapping

;-----------------------------------------------------------------------------
; MARK: aiSpawnEnemy
aiSpawnEnemy            entry
                        ldy    #2*MAX_ENEMY_INDEX           ; index into enemyID
aseFindAvail            lda    enemyID,y
                        cmp    #2*MAX_OBJECTS
                        beq    aseFound
                        dey
                        dey
                        bpl    aseFindAvail
                        rts
aseFound                jsr    aiRandom
                        and    #14
                        sec
                        sbc    #4
                        clc
                        adc    zPlayerAngle
                        and    #62
                        tax
                        lda    dt_launch_x,x
                        sta    zSpawnX
                        lda    dt_launch_y,x
                        sta    zSpawnY
                        phy                                 ; save which enemyID
                        ldy    #LAYER_ENEMY
                        jsr    thingsAdd
                        ply                                 ; restore which enemyID
                        sta    enemyID,y                    ; enemID indexes into things
                        tya
                        sta    activeEID,x                  ; activeEID indexes into enemyID
                        lda    zInvPlayerAngle
                        sta    enemyHeading,y
                        sta    activeFrame,x
                        jsr    aiRandom
                        and    #31
                        adc    #ENEMY_STEADY_MIN_TIME
                        sta    activeExtra,x                ; Timer
                        bit    #31
                        beq    aseNotFollow
                        lda    zNumberOfAIFollowers
                        cmp    zNumberOfAIFollowersMax
                        bcs    aseNotFollow
                        ina
                        sta    zNumberOfAIFollowers
                        lda    #AF_AI_FOLLOW
                        ora    activeFlags,x
                        sta    activeFlags,x
aseNotFollow            inc    zNumberOfEnemies
                        rts

;-----------------------------------------------------------------------------
; MARK: aiSpawnWave
aiSpawnWave             entry
                        ldy    zWaveSpawnL                  ; start with L
                        ldx    zWaveSpawnIndex              ; index of open slots
aswLoop                 lda    dt_launch_x,y                ; prep for thingsAdd
                        sta    zSpawnX
                        lda    dt_launch_y,y
                        sta    zSpawnY
aswFindSlot             lda    enemyID,x                    ; is this slot open?
                        cmp    #2*MAX_OBJECTS
                        beq    aswSlotFound                 ; yes
                        dex
                        dex
                        bra    aswFindSlot                  ; no, try next slot - there are enough slots
aswSlotFound            stx    zWaveSpawnIndex              ; save index
                        phx
                        ldy    #LAYER_ENEMY
                        jsr    thingsAdd                    ; add the enmey - reg a & x is now new
                        ply
                        sta    enemyID,y
                        tya
                        sta    activeEID,x
                        lda    #AF_AI_WAVE
                        ora    activeFlags,x
                        sta    activeFlags,x
                        lda    zWaveSpawnDir                ; update enemy with
                        sta    enemyHeading,y               ; set the heading
                        sta    activeFrame,x                ; direction/frame
                        lda    zWaveSpawnDuration           ; and how long to stay in wave
                        sta    activeExtra,x                ; Timer
                        inc    zNumberOfEnemies             ; enemy added
                        ldx    zWaveSpawnIndex              ; go to next slot
                        dex
                        dex
                        dec    zWaveSpawnCount              ; 1 less to spawn
                        lda    zWaveSpawnCount
                        beq    aswAllSpawned                ; yes - end wave spawning
                        bit    #1
                        beq    aswPrepNext                  ; if on even, stop for now
                        ldy    zWaveSpawnR                  ; still need to spawn R
                        bra    aswLoop
aswPrepNext             stx    zWaveSpawnIndex              ; save the slot for next invocation
                        lda    zWaveSpawnL                  ; no - space L and R out by 11.25 deg
                        dea
                        dea
                        and    #62
                        sta    zWaveSpawnL
                        lda    zWaveSpawnR
                        ina
                        ina
                        and    #62
                        sta    zWaveSpawnR
                        rts
aswAllSpawned           stz    zAiSpawnTimer                ; set this to 0 to end this wave spawn
                        rts

;-----------------------------------------------------------------------------
; MARK: aiText
aiText                  entry
                        ldx    zThingID0
                        lda    zPrePlayTimer                ; see if labels still need to be up
                        bne    atxOk
                        lda    #eraseText                   ; no - install erase handler
                        sta    zStageIntroState             ; and mark stage as in progress
                        sta    at_handler_erase+LAYER_TEXT
atxOk                   lda    activeExtra,x                ; does this have a timer
                        bmi    atxDone                      ; no (neg)
                        dea                                 ; count down
                        beq    atxAnimate                   ; and at zero animate
                        sta    activeExtra,x                ; store the timer
atxDone                 rts
atxAnimate              lda    #INTRO_COLOR_CYCLE_TIME      ; reset timer
                        sta    activeExtra,x
                        lda    activeEID,x                  ; get the frame
                        dea                                 ; count frame down
                        dea
                        bpl    atxSetIndex
                        lda    #4                           ; frame underflow, reset
atxSetIndex             sta    activeEID,x
                        adc    activeMaxX,x                 ; add frame to this text line
                        sta    activeFrame,x                ; and set the frame to draw
                        rts

;-----------------------------------------------------------------------------
; MARK: aiThing
aiThing                 entry
                        clc
                        lda    activeMaxY,x
                        sta    activeOldMaxY,x
                        lda    activeLayer,x
                        tax
                        jmp    (at_handler_ai,x)

;-----------------------------------------------------------------------------
; MARK: aiTurnOnRay
aiTurnOnRay             entry
taorTarget              equ    zTemp00
                        lda    activeMinY,x
                        asl    a
                        asl    a                            ; ((y >> 4) << 6) (for 16 bit row lookup)
                        and    #1984                        ; 31*64 [bytes per row] = 1984 - clamp to 32x32 table
                        sta    taorTarget
                        lda    activeMinX,x                 ; get col for table
                        and    #496                         ; (62 << 3) 62 - even bytes per row
                        lsr    a                            ; x / 8
                        lsr    a
                        lsr    a                            ; carry clear due to and earlier
                        adc    taorTarget                   ; the address of the value in rays[y][x]
                        tay
                        lda    dt_movement_rays,y
                        sta    taorTarget
                        sec
                        sbc    activeExtra,x
                        bne    atorTurn
                        lda    activeExtra,x
                        rts
atorTurn                and    #62
                        ldy    activeExtra,x
                        bit    #32                          ; >= 32 - anti clock
                        beq    atorClock                    ; < 32 - clock
                        dey
                        dey
                        bit    #16
                        bne    atorNoDub                    ; not more than 16 away
                        dey
                        dey
atorNoDub               tya
                        and    #62
                        rts
atorClock               iny
                        iny
                        bit    #16
                        beq    atorNoDub
                        iny
                        iny
                        tya
                        and    #62
                        rts

thisisaformattinglabel  anop
                        END
