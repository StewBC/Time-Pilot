;-----------------------------------------------------------------------------
; draw.asm
; Part of Time Pilot, the 1982 arcade game remake for the Apple IIgs
;
; Stefan Wessels, 2024
; This is free and unencumbered software released into the public domain.
;-----------------------------------------------------------------------------

                        copy    src/globals.s
                        mcopy   src/draw.mac

DRAW                    START

                        using   GAMEDATA
                        using   VARIABLES

ptIsOdd                 equ     zTemp00
ptScreenClips           equ     zTemp01
ptImageStartX           equ     zTemp02
ptImageStartY           equ     zTemp03

;-----------------------------------------------------------------------------
; MARK: drawAstros0
drawAstros0             entry
                        lda     ptIsOdd
                        bne     da0Odd
da0Even                 jsl     ASTRO0_000A
                        rts
da0Odd                  jsl     ASTRO0_000B
                        rts

;-----------------------------------------------------------------------------
; MARK: drawAstros0Part
drawAstros0Part         entry
                        lda     #^ASTRO0_000A_DATA
                        sta     zSpriteDataBank
                        ldy     ptImageStartY
                        lda     dt_mult_8,y
                        adc     ptImageStartX
                        sta     ptImageStartX
                        lda     ptIsOdd
                        bne     da0pOdd
                        lda     #ASTRO0_000A_DATA
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     #ASTRO0_000A_MASK
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
da0pOdd                 lda     #ASTRO0_000B_DATA
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     #ASTRO0_000B_MASK
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawAstros1
drawAstros1             entry
                        lda     ptIsOdd
                        bne     da1Odd
da1Even                 jsl     ASTRO1_000A
                        rts
da1Odd                  jsl     ASTRO1_000B
                        rts

;-----------------------------------------------------------------------------
; MARK: drawAstros1Part
drawAstros1Part         entry
                        lda     #^ASTRO1_000A_DATA
                        sta     zSpriteDataBank
                        ldy     ptImageStartY
                        lda     dt_mult_8,y
                        adc     ptImageStartX
                        sta     ptImageStartX
                        lda     ptIsOdd
                        bne     da1pOdd
                        lda     #ASTRO1_000A_DATA
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     #ASTRO1_000A_MASK
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
da1pOdd                 lda     #ASTRO1_000B_DATA
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     #ASTRO1_000B_MASK
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawAstros2
drawAstros2             entry
                        lda     ptIsOdd
                        bne     da2Odd
da2Even                 jsl     ASTRO2_000A
                        rts
da2Odd                  jsl     ASTRO2_000B
                        rts

;-----------------------------------------------------------------------------
; MARK: drawAstros2Part
drawAstros2Part         entry
                        lda     #^ASTRO2_000A_DATA
                        sta     zSpriteDataBank
                        ldy     ptImageStartY
                        lda     dt_mult_15,y
                        adc     ptImageStartX
                        sta     ptImageStartX
                        lda     ptIsOdd
                        bne     da2pOdd
                        lda     #ASTRO2_000A_DATA
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     #ASTRO2_000A_MASK
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
da2pOdd                 lda     #ASTRO2_000B_DATA
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     #ASTRO2_000B_MASK
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawBomb
drawBomb                entry
                        ldx     zThingID0
                        lda     activeFlags,x
                        bit     #AF_DIR_RIGHT
                        beq     dboLeft
                        lda     ptIsOdd
                        bne     dboOdd
                        jsl     BOMB_000A
                        rts
dboOdd                  jsl     BOMB_000B
                        rts
dboLeft                 lda     ptIsOdd
                        bne     dboLOdd
                        jsl     BOMB_001A
                        rts
dboLOdd                 jsl     BOMB_001B
                        rts

;-----------------------------------------------------------------------------
; MARK: drawBombPart
drawBombPart            entry
                        ldx     zThingID0
                        lda     #^BOMB_000A_DATA
                        sta     zSpriteDataBank
                        ldy     ptImageStartY
                        lda     dt_mult_4,y
                        adc     ptImageStartX
                        sta     ptImageStartX
                        ldy     #0                            ; frame 0 is right
                        lda     activeFlags,x
                        bit     #AF_DIR_RIGHT
                        bne     dbopTravelRight
                        ldy     #2                            ; this bomb travels left
dbopTravelRight         lda     ptIsOdd
                        bne     dbopOdd
                        lda     it_bomb_a,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_bomb_a,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
dbopOdd                 lda     it_bomb_b,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_bomb_b,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawBomber
drawBomber              entry
                        ldx     zThingID0
                        lda     activeFlags,x
                        bit     #AF_DIR_RIGHT
                        bne     dbmTravelRight
                        lda     #8
                        ora     activeFrame,x
                        bra     dbmLefFrameFixed
dbmTravelRight          lda     activeFrame,x
dbmLefFrameFixed        tax
                        lda     ptIsOdd
                        bne     dbmOdd
                        lda     st_bomber_a,x
                        bra     dbmSetJmp
dbmOdd                  lda     st_bomber_b,x
dbmSetJmp               sta     dbmJmpAddr+1                  ; bank is set, set specific sprite
dbmJmpAddr              jsl     BOMBER_000A                   ; draw that sprite
                        rts

;-----------------------------------------------------------------------------
; MARK: drawBomberPart
drawBomberPart          entry
                        ldx     zThingID0
                        lda     #^BOMBER_000A_DATA
                        sta     zSpriteDataBank
                        ldy     ptImageStartY
                        lda     dt_mult_14,y
                        adc     ptImageStartX
                        sta     ptImageStartX
                        lda     activeFlags,x
                        bit     #AF_DIR_RIGHT
                        bne     dbmpTravelRight
                        lda     #8
                        ora     activeFrame,x
                        bra     dbmpLefFrameFixed
dbmpTravelRight         lda     activeFrame,x
dbmpLefFrameFixed       tay
                        lda     ptIsOdd
                        bne     dbmpOdd
                        lda     it_bomber_a,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_bomber_a,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
dbmpOdd                 lda     it_bomber_b,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_bomber_b,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawBoomerang
drawBoomerang           entry
                        ldx     zThingID0
                        lda     activeFrame,x
                        tax
                        lda     ptIsOdd
                        bne     dbrOdd
                        lda     st_boomerang_a,x
                        bra     dbrSetJmp
dbrOdd                  lda     st_boomerang_b,x
dbrSetJmp               sta     dbrJmpAddr+1                  ; bank is set, set specific sprite
dbrJmpAddr              jsl     BOOMERANG_000A
                        rts

;-----------------------------------------------------------------------------
; MARK: drawBoomerangPart
drawBoomerangPart       entry
                        bcs     drawBoomerangPart
                        ldx     zThingID0
                        lda     #^BOOMERANG_000A_DATA
                        sta     zSpriteDataBank
                        ldy     ptImageStartY
                        lda     dt_mult_4,y
                        adc     ptImageStartX
                        sta     ptImageStartX
                        lda     activeFlags,x
                        bit     #AF_DIR_RIGHT
                        bne     dbrpTravelRight
                        lda     #8
                        ora     activeFrame,x
                        bra     dbrpLefFrameFixed
dbrpTravelRight         lda     activeFrame,x
dbrpLefFrameFixed       tay
                        lda     ptIsOdd
                        bne     dbrpOdd
                        lda     it_boomerang_a,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_boomerang_a,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
dbrpOdd                 lda     it_boomerang_b,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_boomerang_b,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawBoss
drawBoss                entry
                        ldx     zActiveStage
                        lda     ct_boss,x
                        ldx     zThingID0
                        adc     activeFrame,x
                        pha
                        lda     activeFlags,x
                        bit     #AF_DIR_RIGHT
                        bne     dbsRight
                        pla
                        adc     #2*4                          ; put it in the 4-7 bank - going left
                        tax
                        bra     dbsFrameInX
dbsRight                plx
dbsFrameInX             lda     ptIsOdd
                        bne     dbsOdd
                        lda     st_boss_a,x
                        bra     dbsSetJmp
dbsOdd                  lda     st_boss_b,x
dbsSetJmp               sta     dbsJmpAddr+1                  ; bank is set, set specific sprite
dbsJmpAddr              entry
                        jsl     BOSS0_000A                    ; draw that sprite
                        rts

;-----------------------------------------------------------------------------
; MARK: drawBossPart
drawBossPart            entry
                        ldx     zActiveStage
                        lda     bt_level,x
                        sta     zSpriteDataBank
                        lda     ct_boss,x
                        ldx     zThingID0
                        adc     activeFrame,x
                        tay
                        lda     activeFlags,x
                        bit     #AF_DIR_RIGHT
                        bne     dbspRight
                        tya
                        adc     #8
                        tay
dbspRight               ldx     ptImageStartY
                        lda     dt_mult_16,x                  ; 4bpp, 2ppbyte, so sprite width / 2
                        adc     ptImageStartX
                        sta     ptImageStartX
                        lda     ptIsOdd
                        bne     dbspOdd
                        lda     it_boss_a,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_boss_a,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
dbspOdd                 lda     it_boss_b,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_boss_b,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawBullet
drawBullet              entry
                        LDAPAL  COLOR_YELLOW
                        tyx
                        short   m
                        sta     >SCREEN_ROW_BASE,x
                        sta     >SCREEN_ROW_BASE+160,x
                        long    m
                        rts

;-----------------------------------------------------------------------------
; MARK: drawClouds0
drawClouds0             entry
                        lda     ptIsOdd
                        bne     dc0Odd
dc0Even                 jsl     CLOUD0_000A
                        rts
dc0Odd                  jsl     CLOUD0_000B
                        rts

;-----------------------------------------------------------------------------
; MARK: drawClouds0Part
drawClouds0Part         entry
                        lda     #^CLOUD0_000A_DATA
                        sta     zSpriteDataBank
                        ldy     ptImageStartY
                        lda     dt_mult_8,y
                        adc     ptImageStartX
                        sta     ptImageStartX
                        lda     ptIsOdd
                        bne     dc0pOdd
                        lda     #CLOUD0_000A_DATA
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     #CLOUD0_000A_MASK
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
dc0pOdd                 lda     #CLOUD0_000B_DATA
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     #CLOUD0_000B_MASK
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawClouds1
drawClouds1             entry
                        lda     ptIsOdd
                        bne     dc1Odd
dc1Even                 jsl     CLOUD1_000A
                        rts
dc1Odd                  jsl     CLOUD1_000B
                        rts

;-----------------------------------------------------------------------------
; MARK: drawClouds1Part
drawClouds1Part         entry
                        lda     #^CLOUD1_000A_DATA
                        sta     zSpriteDataBank
                        ldy     ptImageStartY
                        lda     dt_mult_15,y
                        adc     ptImageStartX
                        sta     ptImageStartX
                        lda     ptIsOdd
                        bne     dc1pOdd
                        lda     #CLOUD1_000A_DATA
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     #CLOUD1_000A_MASK
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
dc1pOdd                 lda     #CLOUD1_000B_DATA
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     #CLOUD1_000B_MASK
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawClouds2
drawClouds2             entry
                        lda     ptIsOdd
                        bne     dc2Odd
dc2Even                 jsl     CLOUD2_000A
                        rts
dc2Odd                  jsl     CLOUD2_000B
                        rts

;-----------------------------------------------------------------------------
; MARK: drawClouds2Part
drawClouds2Part         entry
                        lda     #^CLOUD2_000A_DATA
                        sta     zSpriteDataBank
                        ldy     ptImageStartY
                        lda     dt_mult_23,y
                        adc     ptImageStartX
                        sta     ptImageStartX
                        lda     ptIsOdd
                        bne     dc2pOdd
                        lda     #CLOUD2_000A_DATA
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     #CLOUD2_000A_MASK
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
dc2pOdd                 lda     #CLOUD2_000B_DATA
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     #CLOUD2_000B_MASK
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawEnemy
drawEnemy               entry
                        ldx     zActiveStage
                        lda     ct_enemy,x
                        ldx     zThingID0
                        adc     activeFrame,x
                        lsr     a
                        and     #$FFFE
                        tax
                        lda     ptIsOdd
                        bne     deOdd
                        lda     st_enemy_a,x
                        bra     deSetJmp
deOdd                   lda     st_enemy_b,x
deSetJmp                sta     deJmpAddr+1                   ; bank is set, set specific sprite
deJmpAddr               entry
                        jsl     ENEMY1_000A                   ; draw that sprite
                        rts

;-----------------------------------------------------------------------------
; MARK: drawEnemyPart
drawEnemyPart           entry
                        ldx     zActiveStage
                        lda     bt_level,x
                        sta     zSpriteDataBank
                        lda     ct_enemy,x
                        ldx     zThingID0
                        adc     activeFrame,x
                        lsr     a
                        and     #$FFFE
                        tay

                        ldx     ptImageStartY
                        lda     dt_mult_10,x                  ; 4bpp, 2ppbyte, so sprite width / 2
                        adc     ptImageStartX
                        sta     ptImageStartX

                        lda     ptIsOdd
                        bne     depOdd
                        lda     it_enemy_a,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_enemy_a,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
depOdd                  lda     it_enemy_b,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_enemy_b,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawExpl_boom
drawExpl_boom           entry
                        ldx     zThingID0
                        lda     activeFrame,x
                        tax
                        lda     ptIsOdd
                        bne     debOdd
                        lda     st_explode_boom_a,x
                        bra     debSetJmp
debOdd                  lda     st_explode_boom_b,x
debSetJmp               sta     debJmpAddr+1                  ; bank is set, set specific sprite
debJmpAddr              jsl     EXLBM_000A                    ; draw that sprite
                        rts

;-----------------------------------------------------------------------------
; MARK: drawExpl_boomPart
drawExpl_boomPart       entry
                        ldx     zThingID0
                        lda     #^EXLBM_000A_DATA
                        sta     zSpriteDataBank
                        ldy     ptImageStartY
                        lda     dt_mult_8,y
                        adc     ptImageStartX
                        sta     ptImageStartX
                        ldy     activeFrame,x
                        lda     ptIsOdd
                        bne     debpOdd
                        lda     it_explode_boom_a,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_explode_boom_a,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
debpOdd                 lda     it_explode_boom_b,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_explode_boom_b,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawExpl_large
drawExpl_large          entry
                        ldx     zThingID0
                        lda     activeFrame,x
                        tax
                        lda     ptIsOdd
                        bne     delOdd
                        lda     st_explode_large_a,x
                        bra     delSetJmp
delOdd                  lda     st_explode_large_b,x
delSetJmp               sta     delJmpAddr+1                  ; bank is set, set specific sprite
delJmpAddr              jsl     EXLLG_000A                    ; draw that sprite
                        rts

;-----------------------------------------------------------------------------
; MARK: drawExpl_largePart
drawExpl_largePart      entry
                        ldx     zThingID0
                        lda     #^EXLLG_000A_DATA
                        sta     zSpriteDataBank
                        ldy     ptImageStartY
                        lda     dt_mult_16,y
                        adc     ptImageStartX
                        sta     ptImageStartX
                        ldy     activeFrame,x
                        lda     ptIsOdd
                        bne     delpOdd
                        lda     it_explode_large_a,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_explode_large_a,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
delpOdd                 lda     it_explode_large_b,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_explode_large_b,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawExpl_sblt
drawExpl_sblt           entry
                        ldx     zThingID0
                        lda     activeFrame,x
                        tax
                        lda     ptIsOdd
                        bne     desbOdd
                        lda     st_explode_sblt_a,x
                        bra     desbSetJmp
desbOdd                 lda     st_explode_sblt_b,x
desbSetJmp              sta     desbJmpAddr+1                 ; bank is set, set specific sprite
desbJmpAddr             jsl     EXLSB_000A                    ; draw that sprite
                        rts

;-----------------------------------------------------------------------------
; MARK: drawExpl_sbltPart
drawExpl_sbltPart       entry
                        ldx     zThingID0
                        lda     #^EXLSB_000A_DATA
                        sta     zSpriteDataBank
                        ldy     ptImageStartY
                        lda     dt_mult_8,y
                        adc     ptImageStartX
                        sta     ptImageStartX
                        ldy     activeFrame,x
                        lda     ptIsOdd
                        bne     desbpOdd
                        lda     it_explode_sblt_a,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_explode_sblt_a,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
desbpOdd                lda     it_explode_sblt_b,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_explode_sblt_b,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawExpl_small
drawExpl_small          entry
                        ldx     zThingID0
                        lda     activeFrame,x
                        tax
                        lda     ptIsOdd
                        bne     desmOdd
                        lda     st_explode_small_a,x
                        bra     desmSetJmp
desmOdd                 lda     st_explode_small_b,x
desmSetJmp              sta     desmJmpAddr+1                 ; bank is set, set specific sprite
desmJmpAddr             jsl     EXLSM_000A                    ; draw that sprite
                        rts

;-----------------------------------------------------------------------------
; MARK: drawExpl_smallPart
drawExpl_smallPart      entry
                        ldx     zThingID0
                        lda     #^EXLSM_000A_DATA
                        sta     zSpriteDataBank
                        ldy     ptImageStartY
                        lda     dt_mult_10,y
                        adc     ptImageStartX
                        sta     ptImageStartX
                        ldy     activeFrame,x
                        lda     ptIsOdd
                        bne     desmpOdd
                        lda     it_explode_small_a,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_explode_small_a,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
desmpOdd                lda     it_explode_small_b,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_explode_small_b,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawExpl_wep
drawExpl_wep            entry
                        ldx     zThingID0
                        lda     activeFrame,x
                        tax
                        lda     ptIsOdd
                        bne     dewOdd
                        lda     st_explode_wep_a,x
                        bra     dewSetJmp
dewOdd                  lda     st_explode_wep_b,x
dewSetJmp               sta     dewJmpAddr+1                  ; bank is set, set specific sprite
dewJmpAddr              jsl     EXLWE_000A                    ; draw that sprite
                        rts

;-----------------------------------------------------------------------------
; MARK: drawExpl_wepPart
drawExpl_wepPart        entry
                        ldx     zThingID0
                        lda     #^EXLWE_000A_DATA
                        sta     zSpriteDataBank
                        ldy     ptImageStartY
                        lda     dt_mult_8,y
                        adc     ptImageStartX
                        sta     ptImageStartX
                        ldy     activeFrame,x
                        lda     ptIsOdd
                        bne     dewpOdd
                        lda     it_explode_wep_a,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_explode_wep_a,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
dewpOdd                 lda     it_explode_wep_b,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_explode_wep_b,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawHeli
drawHeli                entry
                        ldx     zThingID0
                        lda     activeFrame,x
                        tax
                        lda     dt_heli_frames,x
                        adc     #(it_enemy2_a-it_enemy_a)
                        tax
                        lda     ptIsOdd
                        bne     dhOdd
                        lda     st_enemy_a,x
                        bra     dhSetJmp
dhOdd                   lda     st_enemy_b,x
dhSetJmp                sta     dhJmpAddr+1                   ; bank is set, set specific sprite
dhJmpAddr               entry
                        jsl     ENEMY2_000A                   ; draw that sprite
                        rts

;-----------------------------------------------------------------------------
; MARK: drawHeliPart
drawHeliPart            entry
                        ldx     zThingID0
                        lda     #^ENEMY2_000A
                        sta     zSpriteDataBank
                        lda     activeFrame,x
                        tay
                        lda     dt_heli_frames,y
                        adc     #(it_enemy2_a-it_enemy_a)
                        tay

                        ldx     ptImageStartY
                        lda     dt_mult_10,x                  ; 4bpp, 2ppbyte, so sprite width / 2
                        adc     ptImageStartX
                        sta     ptImageStartX

                        lda     ptIsOdd
                        bne     dhpOdd
                        lda     it_enemy_a,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_enemy_a,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
dhpOdd                  lda     it_enemy_b,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_enemy_b,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawParachute
drawParachute           entry
                        ldx     zThingID0
                        lda     activeFrame,x
                        tax
                        lda     ptIsOdd
                        bne     dpaOdd
                        lda     st_parachute_a,x
                        bra     dpaSetJmp
dpaOdd                  lda     st_parachute_b,x
dpaSetJmp               sta     dpaJmpAddr+1                  ; bank is set, set specific sprite
dpaJmpAddr              jsl     PARACHUTE_000A                ; draw that sprite
                        rts

;-----------------------------------------------------------------------------
; MARK: drawParachutePart
drawParachutePart       entry
                        ldx     zThingID0
                        lda     #^PARACHUTE_000A_DATA
                        sta     zSpriteDataBank
                        ldy     ptImageStartY
                        lda     dt_mult_10,y
                        adc     ptImageStartX
                        sta     ptImageStartX
                        ldy     activeFrame,x
                        lda     ptIsOdd
                        bne     dpapOdd
                        lda     it_parachute_a,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_parachute_a,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
dpapOdd                 lda     it_parachute_b,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_parachute_b,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawPlayer
drawPlayer              entry
                        ldx     zPlayerAngle                  ; frame
                        lda     st_player,x                   ; get the address
                        sta     dplDraw+1                     ; set lower 16 bits
dplDraw                 jsl     PLAYER_000A                   ; draw the player
                        rts

;-----------------------------------------------------------------------------
; MARK: drawPlayerBullet
drawPlayerBullet        entry
                        LDAPAL  COLOR_WHITE
                        tyx
                        short   m
                        sta     >SCREEN_ROW_BASE,x
                        sta     >SCREEN_ROW_BASE+160,x
                        long    m
                        rts

;-----------------------------------------------------------------------------
; MARK: drawRocket
drawRocket              entry
                        ldx     zThingID0
                        lda     activeFrame,x
                        tax
                        lda     ptIsOdd
                        bne     drOdd
                        lda     st_rocket_a,x
                        bra     drSetJmp
drOdd                   lda     st_rocket_b,x
drSetJmp                sta     drJmpAddr+1                   ; bank is set, set specific sprite
drJmpAddr               entry
                        jsl     ROCKET_000A                   ; draw that sprite
drawRts                 entry
                        rts

;-----------------------------------------------------------------------------
; MARK: drawRocketPart
drawRocketPart          entry
                        lda     #^ROCKET_000A
                        sta     zSpriteDataBank
                        ldx     zThingID0
                        lda     activeFrame,x
                        tay
                        ldx     ptImageStartY
                        lda     dt_mult_6,x                   ; 4bpp, 2ppbyte, so sprite width / 2
                        adc     ptImageStartX
                        sta     ptImageStartX
                        lda     ptIsOdd
                        bne     drpOdd
                        lda     it_rocket_a,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_rocket_a,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
drpOdd                  lda     it_rocket_b,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_rocket_b,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawSBullets
drawSBullets            entry
                        ldx     zThingID0
                        lda     activeFrame,x
                        tax
                        lda     ptIsOdd
                        bne     dsbuOdd
                        lda     st_sbullet_a,x
                        bra     dsbuSetJmp
dsbuOdd                 lda     st_sbullet_b,x
dsbuSetJmp              sta     dsbuJmpAddr+1                 ; bank is set, set specific sprite
dsbuJmpAddr             entry
                        jsl     SBULLET_000A
                        rts

;-----------------------------------------------------------------------------
; MARK: drawSBulletsPart
drawSBulletsPart        entry
                        lda     #^SBULLET_000A
                        sta     zSpriteDataBank
                        ldx     zThingID0
                        lda     activeFrame,x
                        tay
                        ldx     ptImageStartY
                        lda     dt_mult_4,x                   ; 4bpp, 2ppbyte, so sprite width / 2
                        adc     ptImageStartX
                        sta     ptImageStartX
                        lda     ptIsOdd
                        bne     dsbupOdd
                        lda     it_sbullet_a,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_sbullet_a,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
dsbupOdd                lda     it_sbullet_b,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_sbullet_b,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawScores
drawScores              entry
                        ldx     zThingID0
                        lda     activeFrame,x
                        tax
                        lda     ptIsOdd
                        bne     dsOdd
                        lda     st_number_a,x
                        bra     dsSetJmp
dsOdd                   lda     st_number_b,x
dsSetJmp                sta     dsJmpAddr+1                   ; bank is set, set specific sprite
dsJmpAddr               jsl     NUMBER_000A                   ; draw that sprite
                        rts

;-----------------------------------------------------------------------------
; MARK: drawScoresPart
drawScoresPart          entry
                        ldx     zThingID0
                        lda     #^NUMBER_000A_DATA
                        sta     zSpriteDataBank
                        ldy     ptImageStartY
                        lda     dt_mult_8,y
                        adc     ptImageStartX
                        sta     ptImageStartX
                        ldy     activeFrame,x
                        lda     ptIsOdd
                        bne     dspOdd
                        lda     it_number_a,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_number_a,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
dspOdd                  lda     it_number_b,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_number_b,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawSpaceBoss
drawSpaceBoss           entry
                        ldx     zActiveStage
                        lda     ct_boss,x
                        ldx     zThingID0
                        adc     activeFrame,x
                        tax
                        lda     ptIsOdd
                        bne     dsboOdd
                        lda     st_boss_a,x
                        bra     dsboSetJmp
dsboOdd                 lda     st_boss_b,x
dsboSetJmp              sta     dsboJmpAddr+1                 ; bank is set, set specific sprite
dsboJmpAddr             entry
                        jsl     BOSS4_000A                    ; draw that sprite
                        rts

;-----------------------------------------------------------------------------
; MARK: drawSpaceBossPart
drawSpaceBossPart       entry
                        ldx     zActiveStage
                        lda     bt_level,x
                        sta     zSpriteDataBank
                        lda     ct_boss,x
                        ldx     zThingID0
                        adc     activeFrame,x
                        tay
dsbopRight              ldx     ptImageStartY
                        lda     dt_mult_16,x                  ; 4bpp, 2ppbyte, so sprite width / 2
                        adc     ptImageStartX
                        sta     ptImageStartX
                        lda     ptIsOdd
                        bne     dsbopOdd
                        lda     it_boss_a,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_boss_a,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
dsbopOdd                lda     it_boss_b,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_boss_b,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawSpaceEnemy
drawSpaceEnemy          entry
                        lda     zFrameCounter
                        and     #12
                        lsr     a
                        tax
                        adc     #(it_enemy4_a-it_enemy_a)
                        tax
                        lda     ptIsOdd
                        bne     dseOdd
                        lda     st_enemy_a,x
                        bra     dseSetJmp
dseOdd                  lda     st_enemy_b,x
dseSetJmp               sta     dseJmpAddr+1                  ; bank is set, set specific sprite
dseJmpAddr              entry
                        jsl     ENEMY4_000A                   ; draw that sprite
                        rts

;-----------------------------------------------------------------------------
; MARK: drawSpaceEnemyPart
drawSpaceEnemyPart      entry
                        lda     #^ENEMY4_000A
                        sta     zSpriteDataBank
                        lda     zFrameCounter
                        and     #12
                        lsr     a
                        adc     #(it_enemy4_a-it_enemy_a)
                        tay

                        ldx     ptImageStartY
                        lda     dt_mult_10,x                  ; 4bpp, 2ppbyte, so sprite width / 2
                        adc     ptImageStartX
                        sta     ptImageStartX

                        lda     ptIsOdd
                        bne     dsepOdd
                        lda     it_enemy_a,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_enemy_a,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial
dsepOdd                 lda     it_enemy_b,y
                        adc     ptImageStartX
                        sta     [zImageAddressPdpB1]
                        lda     mt_enemy_b,y
                        adc     ptImageStartX
                        sta     [zMaskAddressPdpB1]
                        jmp     screenDrawPartial

;-----------------------------------------------------------------------------
; MARK: drawText
drawText                entry
                        ldx     zThingID0
                        lda     activeFrame,x                 ; what text to show (and color baked in)
                        tax
                        lda     st_text,x                     ; get address of draw
                        sta     dtxJmpAddr+1                  ; set up the render
dtxJmpAddr              jsl     TXT1_000A                     ; show that text
                        rts

;-----------------------------------------------------------------------------
; MARK: drawThing
drawThing               entry
tScreenAddress          equ     zTemp02
                        stz     ptIsOdd                       ; assume not odd screen address
                        lda     activeLayer,x
                        jsr     screenClips                   ; clip sprite (sets ptScreenClips via tscClipMask)
                        lda     #$FFFF-AF_ERASED-AF_CLIPMASK  ; ~(AF_ERASED|AF_CLIPMASK)
                        and     activeFlags,x
                        ora     ptScreenClips                 ; put clip info into flags
                        sta     activeFlags,x
                        and     #AF_CLIPMASK
                        beq     dtFullyVisible
                        cmp     #AF_CLIPMASK
                        bne     drawThingPartlyVisible
                        stz     activeScreenAddress,x         ; off screen - clear draw address cache
                        rts
dtFullyVisible          lda     activeMinX,x
                        lsr     a                             ; x / 2 because 4 bpp
                        sta     tScreenAddress                ; save x coord
                        bcc     dtIsEven                      ; also note if sprite is even/odd pixel start
                        inc     ptIsOdd
dtIsEven                lda     activeMinY,x
                        asl     a                             ; make y coord 16 bit lookup ready
                        tay
                        lda     dt_screen_rows,y              ; get the row address
                        adc     tScreenAddress                ; add the x coord
                        sta     activeScreenAddress,x         ; save the screen address of this thing's draw
                        tay                                   ; put in y for Mr Sprite drawing
                        lda     activeLayer,x                 ; get the layer
                        tax                                   ; put in x for jump
                        jmp     (at_handler_draw,x)           ; draw the thing's sprite

;-----------------------------------------------------------------------------
; MARK: drawThingPartlyVisible
drawThingPartlyVisible  entry
tImageVisibleWidth      equ     zTemp04
tScreenStartX           equ     zTemp05
tScreenStartY           equ     zTemp06
                        bit     #AF_CLIPLX
                        beq     dtpvCheckRX
                        lda     activeMinX,x
                        pha
                        adc     activeWidth,x
                        sta     activeVisibleWidth,x
                        sta     tImageVisibleWidth
                        clc
                        pla
                        eor     #$ffff
                        adc     #1
                        lsr     a
                        bcc     dtpvSetLStart
                        rol     ptIsOdd
                        ina
                        dec     tImageVisibleWidth
dtpvSetLStart           sta     ptImageStartX
                        stz     tScreenStartX
                        bra     dtpvCheckPreTY
dtpvCheckRX             bit     #AF_CLIPRX
                        beq     dtpvNoXClip
                        lda     #SCREEN_PRIGHT
                        sec
                        sbc     activeMinX,x
                        sta     tImageVisibleWidth
                        lda     activeMinX,x
                        lsr     a
                        bcc     dtpvSetRStart
                        rol     ptIsOdd
                        inc     tImageVisibleWidth
dtpvSetRStart           sta     tScreenStartX
                        stz     ptImageStartX
                        bra     dtpvCheckPreTY
dtpvNoXClip             lda     activeMinX,x
                        lsr     a
                        sta     tScreenStartX
                        rol     ptIsOdd
                        lda     activeWidth,x
                        sta     tImageVisibleWidth
                        stz     ptImageStartX
dtpvCheckPreTY          lda     ptScreenClips
dtpvCheckTY             bit     #AF_CLIPTY
                        beq     dtpvCheckBY
                        lda     activeMinY,x
                        pha
                        eor     #$ffff
                        adc     #1
                        asl     a
                        sta     ptImageStartY
                        pla
                        adc     activeHeight,x
                        sta     activeVisibleHeight,x
                        sta     [zImageVisHeightPdpB1]
                        stz     tScreenStartY
                        bra     dtpvFixLength
dtpvCheckBY             bit     #AF_CLIPBY
                        beq     dtpvNoYClip
                        lda     #SCREEN_PBOTTOM
                        sec
                        sbc     activeMinY,x
                        bra     dtpvFinClip
dtpvNoYClip             lda     activeHeight,x
dtpvFinClip             sta     activeVisibleHeight,x
                        sta     [zImageVisHeightPdpB1]
                        lda     activeMinY,x
                        asl     a
                        sta     tScreenStartY
                        stz     ptImageStartY
dtpvFixLength           lda     tImageVisibleWidth
                        sta     activeVisibleWidth,x
                        bit     #3
                        beq     dtpvNoRemainder
                        and     #$FFFC
                        lsr     a
                        sta     [zImageVisWidthPdpB1]
                        tay
                        lda     at_col_jump_draw,y
                        sta     remainderexit+1
                        lda     #remainder
                        sta     ifreturnAddress+1
                        bra     dtpvFixDP
dtpvNoRemainder         and     #$FFFC
                        lsr     a
                        sta     [zImageVisWidthPdpB1]
                        tay
                        lda     at_col_jump_draw,y
                        sta     ifreturnAddress+1
dtpvFixDP               lda     activeWidth,x
                        lsr     a
                        sta     [zImageDataWidthPdpB1]
                        ldy     tScreenStartY
                        lda     dt_screen_rows,y
                        adc     tScreenStartX
                        sta     activeScreenAddress,x
                        sta     [zScreenAddressPdpB1]
                        lda     activeLayer,x
                        tax
                        jmp     (at_handler_part_draw,x)

thisisaformattinglabel  anop
                        END
