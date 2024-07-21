;-----------------------------------------------------------------------------
; data.asm
; Part of Time Pilot, the 1982 arcade game remake for the Apple IIgs
;
; Stefan Wessels, 2024
; This is free and unencumbered software released into the public domain.
;-----------------------------------------------------------------------------

                        copy   src/globals.s

GAMEDATA                DATA

                        using  TEXT

;-----------------------------------------------------------------------------
; setting RECORD_REPLAY in globals.s will enable recording a replay
                        lcla   &R_RECORD
&R_RECORD               seta   RECORD_REPLAY

;-----------------------------------------------------------------------------
; Names here generally follow these rules.
; Everything here is lookup a table of some sorts.
; Names start with a letter (table class), followed by a t for table, then
; _ and then descriptive text for what the table holds
;   The initial letter describes the class of table.  These are:
;       a - address (memory location)
;       b - bank
;       c - count (an offset, index)
;       d - data (every other type of data)
;       i - image address (sprite in data format)
;       m - mask address (sprite mask in data format)
;       s - sprite address (sprite in code format)
; It is easy to spot, everywhere in the code, if the name is .t_.* that
; the data is a table that comes from this file.
;-----------------------------------------------------------------------------
; MARK: Handlers
at_handler_ai           dc     a2'aiClouds0'               ; LAYER_CLOUDS0
                        dc     a2'aiClouds1'               ; LAYER_CLOUDS1
                        dc     a2'aiExplodeThing'          ; LAYER_EXPLODE_LARGE
                        dc     a2'aiExplodeThing'          ; LAYER_EXPLODE_ROCKETS
                        dc     a2'aiExplodeThing'          ; LAYER_EXPLODE_SMALL
                        dc     a2'aiExplodeThing'          ; LAYER_EXPLODE_BULLETS
                        dc     a2'aiParachute'             ; LAYER_PARACHUTE
                        dc     a2'aiScores'                ; LAYER_SCORES
                        dc     a2'aiRockets'               ; LAYER_ROCKETS
                        dc     a2'aiEnemy'                 ; LAYER_ENEMY
                        dc     a2'aiBullets'               ; LAYER_BULLETS
                        dc     a2'aiPlayerBullets'         ; LAYER_PLAYER_BULLETS
                        dc     a2'aiBomber'                ; LAYER_BOMBER
                        dc     a2'aiBoss'                  ; LAYER_BOSS
                        dc     a2'drawRts'                 ; LAYER_WARP
                        dc     a2'aiPlayer'                ; LAYER_PLAYER
                        dc     a2'aiClouds2'               ; LAYER_CLOUDS2
                        dc     a2'aiText'                  ; LAYER_TEXT

at_handler_draw         dc     a2'drawClouds0'             ; LAYER_CLOUDS0
                        dc     a2'drawClouds1'             ; LAYER_CLOUDS1
                        dc     a2'drawExpl_large'          ; LAYER_EXPLODE_LARGE
                        dc     a2'drawExpl_wep'            ; LAYER_EXPLODE_ROCKETS
                        dc     a2'drawExpl_small'          ; LAYER_EXPLODE_SMALL
                        dc     a2'drawExpl_sblt'           ; LAYER_EXPLODE_BULLETS
                        dc     a2'drawParachute'           ; LAYER_PARACHUTE
                        dc     a2'drawScores'              ; LAYER_SCORES
                        dc     a2'drawRocket'              ; LAYER_ROCKETS
                        dc     a2'drawEnemy'               ; LAYER_ENEMY
                        dc     a2'drawBullet'              ; LAYER_BULLETS
                        dc     a2'drawPlayerBullet'        ; LAYER_PLAYER_BULLETS
                        dc     a2'drawBomber'              ; LAYER_BOMBER
                        dc     a2'drawBoss'                ; LAYER_BOSS
                        dc     a2'drawRts'                 ; LAYER_WARP
                        dc     a2'drawPlayer'              ; LAYER_PLAYER
                        dc     a2'drawClouds2'             ; LAYER_CLOUDS2
                        dc     a2'drawText'                ; LAYER_TEXT

at_handler_part_draw    dc     a2'drawClouds0Part'         ; LAYER_CLOUDS0
                        dc     a2'drawClouds1Part'         ; LAYER_CLOUDS1
                        dc     a2'drawExpl_largePart'      ; LAYER_EXPLODE_LARGE
                        dc     a2'drawExpl_wepPart'        ; LAYER_EXPLODE_ROCKETS
                        dc     a2'drawExpl_smallPart'      ; LAYER_EXPLODE_SMALL
                        dc     a2'drawExpl_sbltPart'       ; LAYER_EXPLODE_BULLETS
                        dc     a2'drawParachutePart'       ; LAYER_PARACHUTE
                        dc     a2'drawScoresPart'          ; LAYER_SCORES
                        dc     a2'drawRocketPart'          ; LAYER_ROCKETS
                        dc     a2'drawEnemyPart'           ; LAYER_ENEMY
                        dc     a2'drawRts'                 ; LAYER_BULLETS
                        dc     a2'drawRts'                 ; LAYER_PLAYER_BULLETS
                        dc     a2'drawBomberPart'          ; LAYER_BOMBER
                        dc     a2'drawBossPart'            ; LAYER_BOSS
                        dc     a2'drawRts'                 ; LAYER_WARP
                        dc     a2'drawRts'                 ; LAYER_PLAYER
                        dc     a2'drawClouds2Part'         ; LAYER_CLOUDS2
                        dc     a2'drawRts'                 ; LAYER_TEXT

at_handler_erase        dc     a2'blank16x16'              ; LAYER_CLOUDS0
                        dc     a2'blank32x16'              ; LAYER_CLOUDS1
                        dc     a2'blank32x16'              ; LAYER_EXPLODE_LARGE
                        dc     a2'blank16x16'              ; LAYER_EXPLODE_ROCKETS
                        dc     a2'blank20x16'              ; LAYER_EXPLODE_SMALL
                        dc     a2'blank16x16'              ; LAYER_EXPLODE_BULLETS
                        dc     a2'blank20x16'              ; LAYER_PARACHUTE
                        dc     a2'blank16x16'              ; LAYER_SCORES
                        dc     a2'blank12x16'              ; LAYER_ROCKETS
                        dc     a2'blank20x16'              ; LAYER_ENEMY
                        dc     a2'blank2x2'                ; LAYER_BULLETS
                        dc     a2'blank2x2'                ; LAYER_PLAYER_BULLETS
                        dc     a2'blank28x16'              ; LAYER_BOMBER
                        dc     a2'blank32x16'              ; LAYER_BOSS
                        dc     a2'blank16x16'              ; LAYER_WARP
                        dc     a2'blank16x16'              ; LAYER_PLAYER
                        dc     a2'blank48x16'              ; LAYER_CLOUDS2
                        dc     a2'eraseRts'                ; LAYER_TEXT

at_handler_collision    dc     a2'collideRts'              ; LAYER_CLOUDS0
                        dc     a2'collideRts'              ; LAYER_CLOUDS1
                        dc     a2'collideRts'              ; LAYER_EXPLODE_LARGE
                        dc     a2'collideRts'              ; LAYER_EXPLODE_ROCKETS
                        dc     a2'collideRts'              ; LAYER_EXPLODE_SMALL
                        dc     a2'collideRts'              ; LAYER_EXPLODE_BULLETS
                        dc     a2'collideParachute'        ; LAYER_PARACHUTE
                        dc     a2'collideRts'              ; LAYER_SCORES
                        dc     a2'collideRockets'          ; LAYER_ROCKETS
                        dc     a2'collideEnemy'            ; LAYER_ENEMY
                        dc     a2'collideBullets'          ; LAYER_BULLETS
                        dc     a2'collideRemove'           ; LAYER_PLAYER_BULLETS
                        dc     a2'collideBomber'           ; LAYER_BOMBER
                        dc     a2'collideBoss'             ; LAYER_BOSS
                        dc     a2'collideRts'              ; LAYER_WARP
                        dc     a2'collidePlayer'           ; LAYER_PLAYER
                        dc     a2'collideRts'              ; LAYER_CLOUDS2
                        dc     a2'collideRts'              ; LAYER_TEXT

; These handlers patch in, per level, to override level specific behaviors
at_enemy_draw           dc     a2'drawEnemy'
                        dc     a2'drawEnemy'
                        dc     a2'drawHeli'
                        dc     a2'drawEnemy'
                        dc     a2'drawSpaceEnemy'

at_enemy_pdraw          dc     a2'drawEnemyPart'
                        dc     a2'drawEnemyPart'
                        dc     a2'drawHeliPart'
                        dc     a2'drawEnemyPart'
                        dc     a2'drawSpaceEnemyPart'

at_hrckt_ai             dc     a2'aiBombs'
                        dc     a2'drawRts'
                        dc     a2'aiRockets'
                        dc     a2'aiRockets'
                        dc     a2'aiBoomerang'

at_hrckt_draw           dc     a2'drawBomb'
                        dc     a2'drawRts'
                        dc     a2'drawRocket'
                        dc     a2'drawRocket'
                        dc     a2'drawBoomerang'

at_hrckt_pdraw          dc     a2'drawBombPart'
                        dc     a2'drawRts'
                        dc     a2'drawRocketPart'
                        dc     a2'drawRocketPart'
                        dc     a2'drawBoomerangPart'

at_hrckt_erase          dc     a2'blank8x8'
                        dc     a2'drawRts'
                        dc     a2'blank12x16'
                        dc     a2'blank12x16'
                        dc     a2'blank8x8'

;-----------------------------------------------------------------------------
; MARK: Layer Configs
dt_layer_collides_with  dc     i2'COLLIDE_NONE'            ; LAYER_CLOUDS0
                        dc     i2'COLLIDE_NONE'            ; LAYER_CLOUDS1
                        dc     a2'COLLIDE_NONE'            ; LAYER_EXPLODE_LARGE
                        dc     a2'COLLIDE_NONE'            ; LAYER_EXPLODE_ROCKETS
                        dc     a2'COLLIDE_NONE'            ; LAYER_EXPLODE_SMALL
                        dc     a2'COLLIDE_NONE'            ; LAYER_EXPLODE_BULLETS
                        dc     i2'COLLIDE_PLAYER'          ; LAYER_PARACHUTE
                        dc     i2'COLLIDE_NONE'            ; LAYER_SCORES
                        dc     i2'COLLIDE_PLAYER_BULLETS+COLLIDE_PLAYER'  ; LAYER_ROCKETS
                        dc     i2'COLLIDE_PLAYER_BULLETS+COLLIDE_PLAYER'  ; LAYER_ENEMY
                        dc     i2'COLLIDE_PLAYER'          ; LAYER_BULLETS
                        dc     i2'COLLIDE_ENEMY+COLLIDE_ENEMY_ROCKETS'  ; LAYER_PLAYER_BULLETS
                        dc     i2'COLLIDE_PLAYER_BULLETS+COLLIDE_PLAYER'  ; LAYER_BOMBER
                        dc     i2'COLLIDE_PLAYER_BULLETS+COLLIDE_PLAYER'  ; LAYER_BOSS
                        dc     i2'COLLIDE_NONE'            ; LAYER_WARP
                        dc     i2'COLLIDE_ENEMY+COLLIDE_ENEMY_BULLETS+COLLIDE_ENEMY_ROCKETS+COLLIDE_PARACHUTE'
                        dc     i2'COLLIDE_NONE'            ; LAYER_CLOUDS2
                        dc     i2'COLLIDE_NONE'            ; LAYER_TEXT

dt_layer_collide_sig    dc     i2'COLLIDE_NONE'            ; LAYER_CLOUDS0
                        dc     i2'COLLIDE_NONE'            ; LAYER_CLOUDS1
                        dc     a2'COLLIDE_NONE'            ; LAYER_EXPLODE_LARGE
                        dc     a2'COLLIDE_NONE'            ; LAYER_EXPLODE_ROCKETS
                        dc     a2'COLLIDE_NONE'            ; LAYER_EXPLODE_SMALL
                        dc     a2'COLLIDE_NONE'            ; LAYER_EXPLODE_BULLETS
                        dc     i2'COLLIDE_PARACHUTE'       ; LAYER_PARACHUTE
                        dc     i2'COLLIDE_NONE'            ; LAYER_SCORES
                        dc     i2'COLLIDE_ENEMY'           ; LAYER_ROCKETS
                        dc     i2'COLLIDE_ENEMY'           ; LAYER_ENEMY
                        dc     i2'COLLIDE_ENEMY_BULLETS'   ; LAYER_BULLETS
                        dc     i2'COLLIDE_PLAYER_BULLETS'  ; LAYER_PLAYER_BULLETS
                        dc     i2'COLLIDE_ENEMY'           ; LAYER_BOMBER
                        dc     i2'COLLIDE_ENEMY'           ; LAYER_BOSS
                        dc     i2'COLLIDE_NONE'            ; LAYER_WARP
                        dc     i2'COLLIDE_PLAYER'          ; LAYER_PLAYER
                        dc     i2'COLLIDE_NONE'            ; LAYER_CLOUDS2
                        dc     i2'COLLIDE_NONE'            ; LAYER_TEXT

dt_layer_flags          dc     i2'AF_CLIPMASK+AF_INUSE+AF_WRAPS+AF_ISDEAD'  ; LAYER_CLOUDS0
                        dc     i2'AF_CLIPMASK+AF_INUSE+AF_WRAPS+AF_ISDEAD'  ; LAYER_CLOUDS1
                        dc     a2'AF_INUSE+AF_ISDEAD'      ; LAYER_EXPLODE_LARGE
                        dc     a2'AF_INUSE+AF_ISDEAD'      ; LAYER_EXPLODE_ROCKETS
                        dc     a2'AF_INUSE+AF_ISDEAD'      ; LAYER_EXPLODE_SMALL
                        dc     a2'AF_INUSE+AF_ISDEAD'      ; LAYER_EXPLODE_BULLETS
                        dc     i2'AF_CLIPMASK+AF_INUSE'    ; LAYER_PARACHUTE
                        dc     i2'AF_CLIPMASK+AF_INUSE+AF_ISDEAD'  ; LAYER_SCORES
                        dc     i2'AF_CLIPMASK+AF_INUSE'    ; LAYER_ROCKETS
                        dc     i2'AF_CLIPMASK+AF_INUSE'    ; LAYER_ENEMY
                        dc     i2'AF_CLIPMASK+AF_INUSE'    ; LAYER_BULLETS
                        dc     i2'AF_CLIPMASK+AF_INUSE'    ; LAYER_PLAYER_BULLETS
                        dc     i2'AF_CLIPMASK+AF_INUSE'    ; LAYER_BOMBER
                        dc     i2'AF_CLIPMASK+AF_INUSE'    ; LAYER_BOSS
                        dc     i2'AF_CLIPMASK+AF_INUSE+AF_ISDEAD'  ; LAYER_WARP
                        dc     i2'AF_CLIPMASK+AF_INUSE'    ; LAYER_PLAYER
                        dc     i2'AF_CLIPMASK+AF_INUSE+AF_WRAPS+AF_ISDEAD'  ; LAYER_CLOUDS2
                        dc     i2'AF_CLIPMASK+AF_INUSE+AF_ISDEAD'  ; LAYER_TEXT

dt_layer_active_height  dc     i2'0'                       ; LAYER_CLOUDS0
                        dc     i2'0'                       ; LAYER_CLOUDS1
                        dc     a2'0'                       ; LAYER_EXPLODE_LARGE
                        dc     a2'0'                       ; LAYER_EXPLODE_ROCKETS
                        dc     a2'0'                       ; LAYER_EXPLODE_SMALL
                        dc     a2'0'                       ; LAYER_EXPLODE_BULLETS
                        dc     i2'0'                       ; LAYER_PARACHUTE
                        dc     i2'0'                       ; LAYER_SCORES
                        dc     i2'0'                       ; LAYER_ROCKETS
                        dc     i2'0'                       ; LAYER_ENEMY
                        dc     i2'0'                       ; LAYER_BULLETS
                        dc     i2'0'                       ; LAYER_PLAYER_BULLETS
                        dc     i2'0'                       ; LAYER_BOMBER
                        dc     i2'0'                       ; LAYER_BOSS
                        dc     i2'0'                       ; LAYER_WARP
                        dc     i2'0'                       ; LAYER_PLAYER
                        dc     i2'0'                       ; LAYER_CLOUDS2
                        dc     i2'0'                       ; LAYER_TEXT

dt_layer_active_width   dc     i2'0'                       ; LAYER_CLOUDS0
                        dc     i2'0'                       ; LAYER_CLOUDS1
                        dc     a2'0'                       ; LAYER_EXPLODE_LARGE
                        dc     a2'0'                       ; LAYER_EXPLODE_ROCKETS
                        dc     a2'0'                       ; LAYER_EXPLODE_SMALL
                        dc     a2'0'                       ; LAYER_EXPLODE_BULLETS
                        dc     i2'0'                       ; LAYER_PARACHUTE
                        dc     i2'0'                       ; LAYER_SCORES
                        dc     i2'0'                       ; LAYER_ROCKETS
                        dc     i2'0'                       ; LAYER_ENEMY
                        dc     i2'0'                       ; LAYER_BULLETS
                        dc     i2'0'                       ; LAYER_PLAYER_BULLETS
                        dc     i2'0'                       ; LAYER_BOMBER
                        dc     i2'0'                       ; LAYER_BOSS
                        dc     i2'0'                       ; LAYER_WARP
                        dc     i2'0'                       ; LAYER_PLAYER
                        dc     i2'0'                       ; LAYER_CLOUDS2
                        dc     i2'0'                       ; LAYER_TEXT

dt_layer_tp0_height     dc     i2'9'                       ; LAYER_CLOUDS0
                        dc     i2'14'                      ; LAYER_CLOUDS1
                        dc     a2'16'                      ; LAYER_EXPLODE_LARGE
                        dc     a2'16'                      ; LAYER_EXPLODE_ROCKETS
                        dc     a2'16'                      ; LAYER_EXPLODE_SMALL
                        dc     a2'16'                      ; LAYER_EXPLODE_BULLETS
                        dc     i2'16'                      ; LAYER_PARACHUTE
                        dc     i2'8'                       ; LAYER_SCORES
                        dc     i2'3'                       ; LAYER_ROCKETS
                        dc     i2'16'                      ; LAYER_ENEMY
                        dc     i2'2'                       ; LAYER_BULLETS
                        dc     i2'2'                       ; LAYER_PLAYER_BULLETS
                        dc     i2'9'                       ; LAYER_BOMBER
                        dc     i2'16'                      ; LAYER_BOSS
                        dc     i2'16'                      ; LAYER_WARP
                        dc     i2'16'                      ; LAYER_PLAYER
                        dc     i2'16'                      ; LAYER_CLOUDS2
                        dc     i2'0'                       ; LAYER_TEXT

dt_layer_tp0_width      dc     i2'16'                      ; LAYER_CLOUDS0
                        dc     i2'30'                      ; LAYER_CLOUDS1
                        dc     a2'32'                      ; LAYER_EXPLODE_LARGE
                        dc     a2'16'                      ; LAYER_EXPLODE_ROCKETS
                        dc     a2'20'                      ; LAYER_EXPLODE_SMALL
                        dc     a2'16'                      ; LAYER_EXPLODE_BULLETS
                        dc     i2'20'                      ; LAYER_PARACHUTE
                        dc     i2'16'                      ; LAYER_SCORES
                        dc     i2'8'                       ; LAYER_ROCKETS
                        dc     i2'20'                      ; LAYER_ENEMY
                        dc     i2'2'                       ; LAYER_BULLETS
                        dc     i2'2'                       ; LAYER_PLAYER_BULLETS
                        dc     i2'28'                      ; LAYER_BOMBER
                        dc     i2'32'                      ; LAYER_BOSS
                        dc     i2'16'                      ; LAYER_WARP
                        dc     i2'16'                      ; LAYER_PLAYER
                        dc     i2'46'                      ; LAYER_CLOUDS2
                        dc     i2'0'                       ; LAYER_TEXT

dt_layer_tp1_height     dc     i2'9'                       ; LAYER_CLOUDS0
                        dc     i2'14'                      ; LAYER_CLOUDS1
                        dc     a2'16'                      ; LAYER_EXPLODE_LARGE
                        dc     a2'16'                      ; LAYER_EXPLODE_ROCKETS
                        dc     a2'16'                      ; LAYER_EXPLODE_SMALL
                        dc     a2'16'                      ; LAYER_EXPLODE_BULLETS
                        dc     i2'16'                      ; LAYER_PARACHUTE
                        dc     i2'8'                       ; LAYER_SCORES
                        dc     i2'0'                       ; LAYER_ROCKETS
                        dc     i2'16'                      ; LAYER_ENEMY
                        dc     i2'2'                       ; LAYER_BULLETS
                        dc     i2'2'                       ; LAYER_PLAYER_BULLETS
                        dc     i2'9'                       ; LAYER_BOMBER
                        dc     i2'9'                       ; LAYER_BOSS
                        dc     i2'16'                      ; LAYER_WARP
                        dc     i2'16'                      ; LAYER_PLAYER
                        dc     i2'16'                      ; LAYER_CLOUDS2
                        dc     i2'0'                       ; LAYER_TEXT

dt_layer_tp1_width      dc     i2'16'                      ; LAYER_CLOUDS0
                        dc     i2'30'                      ; LAYER_CLOUDS1
                        dc     a2'32'                      ; LAYER_EXPLODE_LARGE
                        dc     a2'16'                      ; LAYER_EXPLODE_ROCKETS
                        dc     a2'20'                      ; LAYER_EXPLODE_SMALL
                        dc     a2'16'                      ; LAYER_EXPLODE_BULLETS
                        dc     i2'20'                      ; LAYER_PARACHUTE
                        dc     i2'16'                      ; LAYER_SCORES
                        dc     i2'0'                       ; LAYER_ROCKETS
                        dc     i2'20'                      ; LAYER_ENEMY
                        dc     i2'2'                       ; LAYER_BULLETS
                        dc     i2'2'                       ; LAYER_PLAYER_BULLETS
                        dc     i2'28'                      ; LAYER_BOMBER
                        dc     i2'32'                      ; LAYER_BOSS
                        dc     i2'16'                      ; LAYER_WARP
                        dc     i2'16'                      ; LAYER_PLAYER
                        dc     i2'46'                      ; LAYER_CLOUDS2
                        dc     i2'0'                       ; LAYER_TEXT

dt_layer_tp2_height     dc     i2'9'                       ; LAYER_CLOUDS0
                        dc     i2'14'                      ; LAYER_CLOUDS1
                        dc     a2'16'                      ; LAYER_EXPLODE_LARGE
                        dc     a2'16'                      ; LAYER_EXPLODE_ROCKETS
                        dc     a2'16'                      ; LAYER_EXPLODE_SMALL
                        dc     a2'16'                      ; LAYER_EXPLODE_BULLETS
                        dc     i2'16'                      ; LAYER_PARACHUTE
                        dc     i2'8'                       ; LAYER_SCORES
                        dc     i2'9'                       ; LAYER_ROCKETS
                        dc     i2'9'                       ; LAYER_ENEMY
                        dc     i2'2'                       ; LAYER_BULLETS
                        dc     i2'2'                       ; LAYER_PLAYER_BULLETS
                        dc     i2'9'                       ; LAYER_BOMBER
                        dc     i2'13'                      ; LAYER_BOSS
                        dc     i2'16'                      ; LAYER_WARP
                        dc     i2'16'                      ; LAYER_PLAYER
                        dc     i2'16'                      ; LAYER_CLOUDS2
                        dc     i2'0'                       ; LAYER_TEXT

dt_layer_tp2_width      dc     i2'16'                      ; LAYER_CLOUDS0
                        dc     i2'30'                      ; LAYER_CLOUDS1
                        dc     a2'32'                      ; LAYER_EXPLODE_LARGE
                        dc     a2'16'                      ; LAYER_EXPLODE_ROCKETS
                        dc     a2'20'                      ; LAYER_EXPLODE_SMALL
                        dc     a2'16'                      ; LAYER_EXPLODE_BULLETS
                        dc     i2'20'                      ; LAYER_PARACHUTE
                        dc     i2'16'                      ; LAYER_SCORES
                        dc     i2'12'                      ; LAYER_ROCKETS
                        dc     i2'20'                      ; LAYER_ENEMY
                        dc     i2'2'                       ; LAYER_BULLETS
                        dc     i2'2'                       ; LAYER_PLAYER_BULLETS
                        dc     i2'28'                      ; LAYER_BOMBER
                        dc     i2'32'                      ; LAYER_BOSS
                        dc     i2'16'                      ; LAYER_WARP
                        dc     i2'16'                      ; LAYER_PLAYER
                        dc     i2'46'                      ; LAYER_CLOUDS2
                        dc     i2'0'                       ; LAYER_TEXT

dt_layer_tp3_height     dc     i2'9'                       ; LAYER_CLOUDS0
                        dc     i2'14'                      ; LAYER_CLOUDS1
                        dc     a2'16'                      ; LAYER_EXPLODE_LARGE
                        dc     a2'16'                      ; LAYER_EXPLODE_ROCKETS
                        dc     a2'16'                      ; LAYER_EXPLODE_SMALL
                        dc     a2'16'                      ; LAYER_EXPLODE_BULLETS
                        dc     i2'16'                      ; LAYER_PARACHUTE
                        dc     i2'8'                       ; LAYER_SCORES
                        dc     i2'9'                       ; LAYER_ROCKETS
                        dc     i2'16'                      ; LAYER_ENEMY
                        dc     i2'2'                       ; LAYER_BULLETS
                        dc     i2'2'                       ; LAYER_PLAYER_BULLETS
                        dc     i2'9'                       ; LAYER_BOMBER
                        dc     i2'13'                      ; LAYER_BOSS
                        dc     i2'16'                      ; LAYER_WARP
                        dc     i2'16'                      ; LAYER_PLAYER
                        dc     i2'16'                      ; LAYER_CLOUDS2
                        dc     i2'0'                       ; LAYER_TEXT

dt_layer_tp3_width      dc     i2'16'                      ; LAYER_CLOUDS0
                        dc     i2'30'                      ; LAYER_CLOUDS1
                        dc     a2'32'                      ; LAYER_EXPLODE_LARGE
                        dc     a2'16'                      ; LAYER_EXPLODE_ROCKETS
                        dc     a2'20'                      ; LAYER_EXPLODE_SMALL
                        dc     a2'16'                      ; LAYER_EXPLODE_BULLETS
                        dc     i2'20'                      ; LAYER_PARACHUTE
                        dc     i2'16'                      ; LAYER_SCORES
                        dc     i2'12'                      ; LAYER_ROCKETS
                        dc     i2'20'                      ; LAYER_ENEMY
                        dc     i2'2'                       ; LAYER_BULLETS
                        dc     i2'2'                       ; LAYER_PLAYER_BULLETS
                        dc     i2'28'                      ; LAYER_BOMBER
                        dc     i2'32'                      ; LAYER_BOSS
                        dc     i2'16'                      ; LAYER_WARP
                        dc     i2'16'                      ; LAYER_PLAYER
                        dc     i2'46'                      ; LAYER_CLOUDS2
                        dc     i2'0'                       ; LAYER_TEXT

dt_layer_tp4_height     dc     i2'12'                      ; LAYER_CLOUDS0
                        dc     i2'15'                      ; LAYER_CLOUDS1
                        dc     a2'16'                      ; LAYER_EXPLODE_LARGE
                        dc     a2'16'                      ; LAYER_EXPLODE_ROCKETS
                        dc     a2'16'                      ; LAYER_EXPLODE_SMALL
                        dc     a2'16'                      ; LAYER_EXPLODE_BULLETS
                        dc     i2'16'                      ; LAYER_PARACHUTE
                        dc     i2'8'                       ; LAYER_SCORES
                        dc     i2'6'                       ; LAYER_ROCKETS
                        dc     i2'8'                       ; LAYER_ENEMY
                        dc     i2'7'                       ; LAYER_BULLETS
                        dc     i2'2'                       ; LAYER_PLAYER_BULLETS
                        dc     i2'9'                       ; LAYER_BOMBER
                        dc     i2'16'                      ; LAYER_BOSS
                        dc     i2'16'                      ; LAYER_WARP
                        dc     i2'16'                      ; LAYER_PLAYER
                        dc     i2'14'                      ; LAYER_CLOUDS2
                        dc     i2'0'                       ; LAYER_TEXT

dt_layer_tp4_width      dc     i2'16'                      ; LAYER_CLOUDS0
                        dc     i2'16'                      ; LAYER_CLOUDS1
                        dc     a2'32'                      ; LAYER_EXPLODE_LARGE
                        dc     a2'16'                      ; LAYER_EXPLODE_ROCKETS
                        dc     a2'20'                      ; LAYER_EXPLODE_SMALL
                        dc     a2'16'                      ; LAYER_EXPLODE_BULLETS
                        dc     i2'20'                      ; LAYER_PARACHUTE
                        dc     i2'16'                      ; LAYER_SCORES
                        dc     i2'8'                       ; LAYER_ROCKETS
                        dc     i2'20'                      ; LAYER_ENEMY
                        dc     i2'8'                       ; LAYER_BULLETS
                        dc     i2'2'                       ; LAYER_PLAYER_BULLETS
                        dc     i2'28'                      ; LAYER_BOMBER
                        dc     i2'32'                      ; LAYER_BOSS
                        dc     i2'16'                      ; LAYER_WARP
                        dc     i2'16'                      ; LAYER_PLAYER
                        dc     i2'30'                      ; LAYER_CLOUDS2
                        dc     i2'0'                       ; LAYER_TEXT

dt_stage_dim_offsets    dc     i2'dt_layer_tp0_height-dt_layer_tp0_height+32'
                        dc     i2'dt_layer_tp1_height-dt_layer_tp0_height+32'
                        dc     i2'dt_layer_tp2_height-dt_layer_tp0_height+32'
                        dc     i2'dt_layer_tp3_height-dt_layer_tp0_height+32'
                        dc     i2'dt_layer_tp4_height-dt_layer_tp0_height+32'

;-----------------------------------------------------------------------------
; MARK: Initial Spawn
dt_spawn_layer          dc     i2'LAYER_CLOUDS0'
                        dc     i2'LAYER_CLOUDS1'
                        dc     i2'LAYER_CLOUDS2'
                        dc     i2'LAYER_CLOUDS1'
                        dc     i2'LAYER_CLOUDS0'
                        dc     i2'LAYER_CLOUDS1'
                        dc     i2'LAYER_CLOUDS2'
                        dc     i2'LAYER_CLOUDS1'
                        dc     i2'LAYER_PLAYER'
NUM_SPAWN_LAYERS        gequ   *-dt_spawn_layer

dt_spawn_min_x          dc     i2'128'                     ; LAYER_CLOUDS0
                        dc     i2'-8'                      ; LAYER_CLOUDS1
                        dc     i2'160'                     ; LAYER_CLOUDS2
                        dc     i2'32'                      ; LAYER_CLOUDS1
                        dc     i2'0'                       ; LAYER_CLOUDS0
                        dc     i2'112'                     ; LAYER_CLOUDS1
                        dc     i2'32'                      ; LAYER_CLOUDS2
                        dc     i2'160'                     ; LAYER_CLOUDS1
                        dc     i2'PLAYER_X'                ; LAYER_PLAYER

dt_spawn_min_y          dc     i2'188'                     ; LAYER_CLOUDS0
                        dc     i2'184'                     ; LAYER_CLOUDS1
                        dc     i2'168'                     ; LAYER_CLOUDS2
                        dc     i2'120'                     ; LAYER_CLOUDS1
                        dc     i2'60'                      ; LAYER_CLOUDS0
                        dc     i2'56'                      ; LAYER_CLOUDS1
                        dc     i2'40'                      ; LAYER_CLOUDS2
                        dc     i2'-8'                      ; LAYER_CLOUDS1
                        dc     i2'PLAYER_Y'                ; LAYER_PLAYER

;-----------------------------------------------------------------------------
; MARK: Level Banks
; Map frame index to sprite draw
bt_level                dc     i2^'ENEMY0_000A'
                        dc     i2^'ENEMY1_000A'
                        dc     i2^'ENEMY2_000A'
                        dc     i2^'ENEMY3_000A'
                        dc     i2^'ENEMY4_000A'

;-----------------------------------------------------------------------------
; MARK: Bomb
it_bomb_a               dc     a2'BOMB_000A_DATA'
                        dc     a2'BOMB_001A_DATA'
it_bomb_b               dc     a2'BOMB_000B_DATA'
                        dc     a2'BOMB_001B_DATA'
mt_bomb_a               dc     a2'BOMB_000A_MASK'
                        dc     a2'BOMB_001A_MASK'
mt_bomb_b               dc     a2'BOMB_000B_MASK'
                        dc     a2'BOMB_001B_MASK'

;-----------------------------------------------------------------------------
; MARK: Bomber
it_bomber_a             dc     a2'BOMBER_000A_DATA'
                        dc     a2'BOMBER_001A_DATA'
                        dc     a2'BOMBER_002A_DATA'
                        dc     a2'BOMBER_003A_DATA'
                        dc     a2'BOMBER_004A_DATA'
                        dc     a2'BOMBER_005A_DATA'
                        dc     a2'BOMBER_006A_DATA'
                        dc     a2'BOMBER_007A_DATA'
it_bomber_b             dc     a2'BOMBER_000B_DATA'
                        dc     a2'BOMBER_001B_DATA'
                        dc     a2'BOMBER_002B_DATA'
                        dc     a2'BOMBER_003B_DATA'
                        dc     a2'BOMBER_004B_DATA'
                        dc     a2'BOMBER_005B_DATA'
                        dc     a2'BOMBER_006B_DATA'
                        dc     a2'BOMBER_007B_DATA'
mt_bomber_a             dc     a2'BOMBER_000A_MASK'
                        dc     a2'BOMBER_001A_MASK'
                        dc     a2'BOMBER_002A_MASK'
                        dc     a2'BOMBER_003A_MASK'
                        dc     a2'BOMBER_004A_MASK'
                        dc     a2'BOMBER_005A_MASK'
                        dc     a2'BOMBER_006A_MASK'
                        dc     a2'BOMBER_007A_MASK'
mt_bomber_b             dc     a2'BOMBER_000B_MASK'
                        dc     a2'BOMBER_001B_MASK'
                        dc     a2'BOMBER_002B_MASK'
                        dc     a2'BOMBER_003B_MASK'
                        dc     a2'BOMBER_004B_MASK'
                        dc     a2'BOMBER_005B_MASK'
                        dc     a2'BOMBER_006B_MASK'
                        dc     a2'BOMBER_007B_MASK'
st_bomber_a             dc     a2'BOMBER_000A'
                        dc     a2'BOMBER_001A'
                        dc     a2'BOMBER_002A'
                        dc     a2'BOMBER_003A'
                        dc     a2'BOMBER_004A'
                        dc     a2'BOMBER_005A'
                        dc     a2'BOMBER_006A'
                        dc     a2'BOMBER_007A'
st_bomber_b             dc     a2'BOMBER_000B'
                        dc     a2'BOMBER_001B'
                        dc     a2'BOMBER_002B'
                        dc     a2'BOMBER_003B'
                        dc     a2'BOMBER_004B'
                        dc     a2'BOMBER_005B'
                        dc     a2'BOMBER_006B'
                        dc     a2'BOMBER_007B'

;-----------------------------------------------------------------------------
; MARK: Boomerang
it_boomerang_a          dc     a2'BOOMERANG_000A_DATA'
                        dc     a2'BOOMERANG_001A_DATA'
                        dc     a2'BOOMERANG_002A_DATA'
                        dc     a2'BOOMERANG_003A_DATA'
                        dc     a2'BOOMERANG_004A_DATA'
                        dc     a2'BOOMERANG_005A_DATA'
                        dc     a2'BOOMERANG_006A_DATA'
                        dc     a2'BOOMERANG_007A_DATA'
it_boomerang_b          dc     a2'BOOMERANG_000B_DATA'
                        dc     a2'BOOMERANG_001B_DATA'
                        dc     a2'BOOMERANG_002B_DATA'
                        dc     a2'BOOMERANG_003B_DATA'
                        dc     a2'BOOMERANG_004B_DATA'
                        dc     a2'BOOMERANG_005B_DATA'
                        dc     a2'BOOMERANG_006B_DATA'
                        dc     a2'BOOMERANG_007B_DATA'
mt_boomerang_a          dc     a2'BOOMERANG_000A_MASK'
                        dc     a2'BOOMERANG_001A_MASK'
                        dc     a2'BOOMERANG_002A_MASK'
                        dc     a2'BOOMERANG_003A_MASK'
                        dc     a2'BOOMERANG_004A_MASK'
                        dc     a2'BOOMERANG_005A_MASK'
                        dc     a2'BOOMERANG_006A_MASK'
                        dc     a2'BOOMERANG_007A_MASK'
mt_boomerang_b          dc     a2'BOOMERANG_000B_MASK'
                        dc     a2'BOOMERANG_001B_MASK'
                        dc     a2'BOOMERANG_002B_MASK'
                        dc     a2'BOOMERANG_003B_MASK'
                        dc     a2'BOOMERANG_004B_MASK'
                        dc     a2'BOOMERANG_005B_MASK'
                        dc     a2'BOOMERANG_006B_MASK'
                        dc     a2'BOOMERANG_007B_MASK'
st_boomerang_a          dc     a2'BOOMERANG_000A'
                        dc     a2'BOOMERANG_001A'
                        dc     a2'BOOMERANG_002A'
                        dc     a2'BOOMERANG_003A'
                        dc     a2'BOOMERANG_004A'
                        dc     a2'BOOMERANG_005A'
                        dc     a2'BOOMERANG_006A'
                        dc     a2'BOOMERANG_007A'
st_boomerang_b          dc     a2'BOOMERANG_000B'
                        dc     a2'BOOMERANG_001B'
                        dc     a2'BOOMERANG_002B'
                        dc     a2'BOOMERANG_003B'
                        dc     a2'BOOMERANG_004B'
                        dc     a2'BOOMERANG_005B'
                        dc     a2'BOOMERANG_006B'
                        dc     a2'BOOMERANG_007B'

;-----------------------------------------------------------------------------
; MARK: Boss
ct_boss                 dc     i2'0'
                        dc     i2'it_boss1_a-it_boss_a'
                        dc     i2'it_boss2_a-it_boss_a'
                        dc     i2'it_boss3_a-it_boss_a'
                        dc     i2'it_boss4_a-it_boss_a'

it_boss_a               dc     a2'BOSS0_000A_DATA'
                        dc     a2'BOSS0_001A_DATA'
                        dc     a2'BOSS0_002A_DATA'
                        dc     a2'BOSS0_003A_DATA'
                        dc     a2'BOSS0_004A_DATA'
                        dc     a2'BOSS0_005A_DATA'
                        dc     a2'BOSS0_006A_DATA'
                        dc     a2'BOSS0_007A_DATA'
it_boss1_a              dc     a2'BOSS1_000A_DATA'
                        dc     a2'BOSS1_001A_DATA'
                        dc     a2'BOSS1_002A_DATA'
                        dc     a2'BOSS1_003A_DATA'
                        dc     a2'BOSS1_004A_DATA'
                        dc     a2'BOSS1_005A_DATA'
                        dc     a2'BOSS1_006A_DATA'
                        dc     a2'BOSS1_007A_DATA'
it_boss2_a              dc     a2'BOSS2_000A_DATA'
                        dc     a2'BOSS2_001A_DATA'
                        dc     a2'BOSS2_002A_DATA'
                        dc     a2'BOSS2_003A_DATA'
                        dc     a2'BOSS2_004A_DATA'
                        dc     a2'BOSS2_005A_DATA'
                        dc     a2'BOSS2_006A_DATA'
                        dc     a2'BOSS2_007A_DATA'
it_boss3_a              dc     a2'BOSS3_000A_DATA'
                        dc     a2'BOSS3_001A_DATA'
                        dc     a2'BOSS3_002A_DATA'
                        dc     a2'BOSS3_003A_DATA'
                        dc     a2'BOSS3_004A_DATA'
                        dc     a2'BOSS3_005A_DATA'
                        dc     a2'BOSS3_006A_DATA'
                        dc     a2'BOSS3_007A_DATA'
it_boss4_a              dc     a2'BOSS4_000A_DATA'
                        dc     a2'BOSS4_001A_DATA'

it_boss_b               dc     a2'BOSS0_000B_DATA'
                        dc     a2'BOSS0_001B_DATA'
                        dc     a2'BOSS0_002B_DATA'
                        dc     a2'BOSS0_003B_DATA'
                        dc     a2'BOSS0_004B_DATA'
                        dc     a2'BOSS0_005B_DATA'
                        dc     a2'BOSS0_006B_DATA'
                        dc     a2'BOSS0_007B_DATA'
                        dc     a2'BOSS1_000B_DATA'
                        dc     a2'BOSS1_001B_DATA'
                        dc     a2'BOSS1_002B_DATA'
                        dc     a2'BOSS1_003B_DATA'
                        dc     a2'BOSS1_004B_DATA'
                        dc     a2'BOSS1_005B_DATA'
                        dc     a2'BOSS1_006B_DATA'
                        dc     a2'BOSS1_007B_DATA'
                        dc     a2'BOSS2_000B_DATA'
                        dc     a2'BOSS2_001B_DATA'
                        dc     a2'BOSS2_002B_DATA'
                        dc     a2'BOSS2_003B_DATA'
                        dc     a2'BOSS2_004B_DATA'
                        dc     a2'BOSS2_005B_DATA'
                        dc     a2'BOSS2_006B_DATA'
                        dc     a2'BOSS2_007B_DATA'
                        dc     a2'BOSS3_000B_DATA'
                        dc     a2'BOSS3_001B_DATA'
                        dc     a2'BOSS3_002B_DATA'
                        dc     a2'BOSS3_003B_DATA'
                        dc     a2'BOSS3_004B_DATA'
                        dc     a2'BOSS3_005B_DATA'
                        dc     a2'BOSS3_006B_DATA'
                        dc     a2'BOSS3_007B_DATA'
                        dc     a2'BOSS4_000B_DATA'
                        dc     a2'BOSS4_001B_DATA'

mt_boss_a               dc     a2'BOSS0_000A_MASK'
                        dc     a2'BOSS0_001A_MASK'
                        dc     a2'BOSS0_002A_MASK'
                        dc     a2'BOSS0_003A_MASK'
                        dc     a2'BOSS0_004A_MASK'
                        dc     a2'BOSS0_005A_MASK'
                        dc     a2'BOSS0_006A_MASK'
                        dc     a2'BOSS0_007A_MASK'
                        dc     a2'BOSS1_000A_MASK'
                        dc     a2'BOSS1_001A_MASK'
                        dc     a2'BOSS1_002A_MASK'
                        dc     a2'BOSS1_003A_MASK'
                        dc     a2'BOSS1_004A_MASK'
                        dc     a2'BOSS1_005A_MASK'
                        dc     a2'BOSS1_006A_MASK'
                        dc     a2'BOSS1_007A_MASK'
                        dc     a2'BOSS2_000A_MASK'
                        dc     a2'BOSS2_001A_MASK'
                        dc     a2'BOSS2_002A_MASK'
                        dc     a2'BOSS2_003A_MASK'
                        dc     a2'BOSS2_004A_MASK'
                        dc     a2'BOSS2_005A_MASK'
                        dc     a2'BOSS2_006A_MASK'
                        dc     a2'BOSS2_007A_MASK'
                        dc     a2'BOSS3_000A_MASK'
                        dc     a2'BOSS3_001A_MASK'
                        dc     a2'BOSS3_002A_MASK'
                        dc     a2'BOSS3_003A_MASK'
                        dc     a2'BOSS3_004A_MASK'
                        dc     a2'BOSS3_005A_MASK'
                        dc     a2'BOSS3_006A_MASK'
                        dc     a2'BOSS3_007A_MASK'
                        dc     a2'BOSS4_000A_MASK'
                        dc     a2'BOSS4_001A_MASK'

mt_boss_b               dc     a2'BOSS0_000B_MASK'
                        dc     a2'BOSS0_001B_MASK'
                        dc     a2'BOSS0_002B_MASK'
                        dc     a2'BOSS0_003B_MASK'
                        dc     a2'BOSS0_004B_MASK'
                        dc     a2'BOSS0_005B_MASK'
                        dc     a2'BOSS0_006B_MASK'
                        dc     a2'BOSS0_007B_MASK'
                        dc     a2'BOSS1_000B_MASK'
                        dc     a2'BOSS1_001B_MASK'
                        dc     a2'BOSS1_002B_MASK'
                        dc     a2'BOSS1_003B_MASK'
                        dc     a2'BOSS1_004B_MASK'
                        dc     a2'BOSS1_005B_MASK'
                        dc     a2'BOSS1_006B_MASK'
                        dc     a2'BOSS1_007B_MASK'
                        dc     a2'BOSS2_000B_MASK'
                        dc     a2'BOSS2_001B_MASK'
                        dc     a2'BOSS2_002B_MASK'
                        dc     a2'BOSS2_003B_MASK'
                        dc     a2'BOSS2_004B_MASK'
                        dc     a2'BOSS2_005B_MASK'
                        dc     a2'BOSS2_006B_MASK'
                        dc     a2'BOSS2_007B_MASK'
                        dc     a2'BOSS3_000B_MASK'
                        dc     a2'BOSS3_001B_MASK'
                        dc     a2'BOSS3_002B_MASK'
                        dc     a2'BOSS3_003B_MASK'
                        dc     a2'BOSS3_004B_MASK'
                        dc     a2'BOSS3_005B_MASK'
                        dc     a2'BOSS3_006B_MASK'
                        dc     a2'BOSS3_007B_MASK'
                        dc     a2'BOSS4_000B_MASK'
                        dc     a2'BOSS4_001B_MASK'

st_boss_a               dc     a2'BOSS0_000A'
                        dc     a2'BOSS0_001A'
                        dc     a2'BOSS0_002A'
                        dc     a2'BOSS0_003A'
                        dc     a2'BOSS0_004A'
                        dc     a2'BOSS0_005A'
                        dc     a2'BOSS0_006A'
                        dc     a2'BOSS0_007A'
                        dc     a2'BOSS1_000A'
                        dc     a2'BOSS1_001A'
                        dc     a2'BOSS1_002A'
                        dc     a2'BOSS1_003A'
                        dc     a2'BOSS1_004A'
                        dc     a2'BOSS1_005A'
                        dc     a2'BOSS1_006A'
                        dc     a2'BOSS1_007A'
                        dc     a2'BOSS2_000A'
                        dc     a2'BOSS2_001A'
                        dc     a2'BOSS2_002A'
                        dc     a2'BOSS2_003A'
                        dc     a2'BOSS2_004A'
                        dc     a2'BOSS2_005A'
                        dc     a2'BOSS2_006A'
                        dc     a2'BOSS2_007A'
                        dc     a2'BOSS3_000A'
                        dc     a2'BOSS3_001A'
                        dc     a2'BOSS3_002A'
                        dc     a2'BOSS3_003A'
                        dc     a2'BOSS3_004A'
                        dc     a2'BOSS3_005A'
                        dc     a2'BOSS3_006A'
                        dc     a2'BOSS3_007A'
                        dc     a2'BOSS4_000A'
                        dc     a2'BOSS4_001A'

st_boss_b               dc     a2'BOSS0_000B'
                        dc     a2'BOSS0_001B'
                        dc     a2'BOSS0_002B'
                        dc     a2'BOSS0_003B'
                        dc     a2'BOSS0_004B'
                        dc     a2'BOSS0_005B'
                        dc     a2'BOSS0_006B'
                        dc     a2'BOSS0_007B'
                        dc     a2'BOSS1_000B'
                        dc     a2'BOSS1_001B'
                        dc     a2'BOSS1_002B'
                        dc     a2'BOSS1_003B'
                        dc     a2'BOSS1_004B'
                        dc     a2'BOSS1_005B'
                        dc     a2'BOSS1_006B'
                        dc     a2'BOSS1_007B'
                        dc     a2'BOSS2_000B'
                        dc     a2'BOSS2_001B'
                        dc     a2'BOSS2_002B'
                        dc     a2'BOSS2_003B'
                        dc     a2'BOSS2_004B'
                        dc     a2'BOSS2_005B'
                        dc     a2'BOSS2_006B'
                        dc     a2'BOSS2_007B'
                        dc     a2'BOSS3_000B'
                        dc     a2'BOSS3_001B'
                        dc     a2'BOSS3_002B'
                        dc     a2'BOSS3_003B'
                        dc     a2'BOSS3_004B'
                        dc     a2'BOSS3_005B'
                        dc     a2'BOSS3_006B'
                        dc     a2'BOSS3_007B'
                        dc     a2'BOSS4_000B'
                        dc     a2'BOSS4_001B'

bossHealthFrames        dc     i2'6,6,4,2'

;-----------------------------------------------------------------------------
; MARK: Enemy
ct_enemy                dc     i2'0'
                        dc     i2'2*(it_enemy1_a-it_enemy_a)'
                        dc     i2'2*(it_enemy2_a-it_enemy_a)'
                        dc     i2'2*(it_enemy3_a-it_enemy_a)'
                        dc     i2'2*(it_enemy4_a-it_enemy_a)'

it_enemy_a              dc     a2'ENEMY0_000A_DATA'
                        dc     a2'ENEMY0_001A_DATA'
                        dc     a2'ENEMY0_002A_DATA'
                        dc     a2'ENEMY0_003A_DATA'
                        dc     a2'ENEMY0_004A_DATA'
                        dc     a2'ENEMY0_005A_DATA'
                        dc     a2'ENEMY0_006A_DATA'
                        dc     a2'ENEMY0_007A_DATA'
                        dc     a2'ENEMY0_008A_DATA'
                        dc     a2'ENEMY0_009A_DATA'
                        dc     a2'ENEMY0_010A_DATA'
                        dc     a2'ENEMY0_011A_DATA'
                        dc     a2'ENEMY0_012A_DATA'
                        dc     a2'ENEMY0_013A_DATA'
                        dc     a2'ENEMY0_014A_DATA'
                        dc     a2'ENEMY0_015A_DATA'
it_enemy1_a             dc     a2'ENEMY1_000A_DATA'
                        dc     a2'ENEMY1_001A_DATA'
                        dc     a2'ENEMY1_002A_DATA'
                        dc     a2'ENEMY1_003A_DATA'
                        dc     a2'ENEMY1_004A_DATA'
                        dc     a2'ENEMY1_005A_DATA'
                        dc     a2'ENEMY1_006A_DATA'
                        dc     a2'ENEMY1_007A_DATA'
                        dc     a2'ENEMY1_008A_DATA'
                        dc     a2'ENEMY1_009A_DATA'
                        dc     a2'ENEMY1_010A_DATA'
                        dc     a2'ENEMY1_011A_DATA'
                        dc     a2'ENEMY1_012A_DATA'
                        dc     a2'ENEMY1_013A_DATA'
                        dc     a2'ENEMY1_014A_DATA'
                        dc     a2'ENEMY1_015A_DATA'
it_enemy2_a             dc     a2'ENEMY2_000A_DATA'
                        dc     a2'ENEMY2_001A_DATA'
                        dc     a2'ENEMY2_002A_DATA'
                        dc     a2'ENEMY2_003A_DATA'
                        dc     a2'ENEMY2_004A_DATA'
                        dc     a2'ENEMY2_005A_DATA'
                        dc     a2'ENEMY2_006A_DATA'
                        dc     a2'ENEMY2_007A_DATA'
                        dc     a2'ENEMY2_008A_DATA'
it_enemy3_a             dc     a2'ENEMY3_000A_DATA'
                        dc     a2'ENEMY3_001A_DATA'
                        dc     a2'ENEMY3_002A_DATA'
                        dc     a2'ENEMY3_003A_DATA'
                        dc     a2'ENEMY3_004A_DATA'
                        dc     a2'ENEMY3_005A_DATA'
                        dc     a2'ENEMY3_006A_DATA'
                        dc     a2'ENEMY3_007A_DATA'
                        dc     a2'ENEMY3_008A_DATA'
                        dc     a2'ENEMY3_009A_DATA'
                        dc     a2'ENEMY3_010A_DATA'
                        dc     a2'ENEMY3_011A_DATA'
                        dc     a2'ENEMY3_012A_DATA'
                        dc     a2'ENEMY3_013A_DATA'
                        dc     a2'ENEMY3_014A_DATA'
                        dc     a2'ENEMY3_015A_DATA'
it_enemy4_a             dc     a2'ENEMY4_000A_DATA'
                        dc     a2'ENEMY4_001A_DATA'
                        dc     a2'ENEMY4_002A_DATA'
                        dc     a2'ENEMY4_003A_DATA'

it_enemy_b              dc     a2'ENEMY0_000B_DATA'
                        dc     a2'ENEMY0_001B_DATA'
                        dc     a2'ENEMY0_002B_DATA'
                        dc     a2'ENEMY0_003B_DATA'
                        dc     a2'ENEMY0_004B_DATA'
                        dc     a2'ENEMY0_005B_DATA'
                        dc     a2'ENEMY0_006B_DATA'
                        dc     a2'ENEMY0_007B_DATA'
                        dc     a2'ENEMY0_008B_DATA'
                        dc     a2'ENEMY0_009B_DATA'
                        dc     a2'ENEMY0_010B_DATA'
                        dc     a2'ENEMY0_011B_DATA'
                        dc     a2'ENEMY0_012B_DATA'
                        dc     a2'ENEMY0_013B_DATA'
                        dc     a2'ENEMY0_014B_DATA'
                        dc     a2'ENEMY0_015B_DATA'
                        dc     a2'ENEMY1_000B_DATA'
                        dc     a2'ENEMY1_001B_DATA'
                        dc     a2'ENEMY1_002B_DATA'
                        dc     a2'ENEMY1_003B_DATA'
                        dc     a2'ENEMY1_004B_DATA'
                        dc     a2'ENEMY1_005B_DATA'
                        dc     a2'ENEMY1_006B_DATA'
                        dc     a2'ENEMY1_007B_DATA'
                        dc     a2'ENEMY1_008B_DATA'
                        dc     a2'ENEMY1_009B_DATA'
                        dc     a2'ENEMY1_010B_DATA'
                        dc     a2'ENEMY1_011B_DATA'
                        dc     a2'ENEMY1_012B_DATA'
                        dc     a2'ENEMY1_013B_DATA'
                        dc     a2'ENEMY1_014B_DATA'
                        dc     a2'ENEMY1_015B_DATA'
                        dc     a2'ENEMY2_000B_DATA'
                        dc     a2'ENEMY2_001B_DATA'
                        dc     a2'ENEMY2_002B_DATA'
                        dc     a2'ENEMY2_003B_DATA'
                        dc     a2'ENEMY2_004B_DATA'
                        dc     a2'ENEMY2_005B_DATA'
                        dc     a2'ENEMY2_006B_DATA'
                        dc     a2'ENEMY2_007B_DATA'
                        dc     a2'ENEMY2_008B_DATA'
                        dc     a2'ENEMY3_000B_DATA'
                        dc     a2'ENEMY3_001B_DATA'
                        dc     a2'ENEMY3_002B_DATA'
                        dc     a2'ENEMY3_003B_DATA'
                        dc     a2'ENEMY3_004B_DATA'
                        dc     a2'ENEMY3_005B_DATA'
                        dc     a2'ENEMY3_006B_DATA'
                        dc     a2'ENEMY3_007B_DATA'
                        dc     a2'ENEMY3_008B_DATA'
                        dc     a2'ENEMY3_009B_DATA'
                        dc     a2'ENEMY3_010B_DATA'
                        dc     a2'ENEMY3_011B_DATA'
                        dc     a2'ENEMY3_012B_DATA'
                        dc     a2'ENEMY3_013B_DATA'
                        dc     a2'ENEMY3_014B_DATA'
                        dc     a2'ENEMY3_015B_DATA'
                        dc     a2'ENEMY4_000B_DATA'
                        dc     a2'ENEMY4_001B_DATA'
                        dc     a2'ENEMY4_002B_DATA'
                        dc     a2'ENEMY4_003B_DATA'

mt_enemy_a              dc     a2'ENEMY0_000A_MASK'
                        dc     a2'ENEMY0_001A_MASK'
                        dc     a2'ENEMY0_002A_MASK'
                        dc     a2'ENEMY0_003A_MASK'
                        dc     a2'ENEMY0_004A_MASK'
                        dc     a2'ENEMY0_005A_MASK'
                        dc     a2'ENEMY0_006A_MASK'
                        dc     a2'ENEMY0_007A_MASK'
                        dc     a2'ENEMY0_008A_MASK'
                        dc     a2'ENEMY0_009A_MASK'
                        dc     a2'ENEMY0_010A_MASK'
                        dc     a2'ENEMY0_011A_MASK'
                        dc     a2'ENEMY0_012A_MASK'
                        dc     a2'ENEMY0_013A_MASK'
                        dc     a2'ENEMY0_014A_MASK'
                        dc     a2'ENEMY0_015A_MASK'
                        dc     a2'ENEMY1_000A_MASK'
                        dc     a2'ENEMY1_001A_MASK'
                        dc     a2'ENEMY1_002A_MASK'
                        dc     a2'ENEMY1_003A_MASK'
                        dc     a2'ENEMY1_004A_MASK'
                        dc     a2'ENEMY1_005A_MASK'
                        dc     a2'ENEMY1_006A_MASK'
                        dc     a2'ENEMY1_007A_MASK'
                        dc     a2'ENEMY1_008A_MASK'
                        dc     a2'ENEMY1_009A_MASK'
                        dc     a2'ENEMY1_010A_MASK'
                        dc     a2'ENEMY1_011A_MASK'
                        dc     a2'ENEMY1_012A_MASK'
                        dc     a2'ENEMY1_013A_MASK'
                        dc     a2'ENEMY1_014A_MASK'
                        dc     a2'ENEMY1_015A_MASK'
                        dc     a2'ENEMY2_000A_MASK'
                        dc     a2'ENEMY2_001A_MASK'
                        dc     a2'ENEMY2_002A_MASK'
                        dc     a2'ENEMY2_003A_MASK'
                        dc     a2'ENEMY2_004A_MASK'
                        dc     a2'ENEMY2_005A_MASK'
                        dc     a2'ENEMY2_006A_MASK'
                        dc     a2'ENEMY2_007A_MASK'
                        dc     a2'ENEMY2_008A_MASK'
                        dc     a2'ENEMY3_000A_MASK'
                        dc     a2'ENEMY3_001A_MASK'
                        dc     a2'ENEMY3_002A_MASK'
                        dc     a2'ENEMY3_003A_MASK'
                        dc     a2'ENEMY3_004A_MASK'
                        dc     a2'ENEMY3_005A_MASK'
                        dc     a2'ENEMY3_006A_MASK'
                        dc     a2'ENEMY3_007A_MASK'
                        dc     a2'ENEMY3_008A_MASK'
                        dc     a2'ENEMY3_009A_MASK'
                        dc     a2'ENEMY3_010A_MASK'
                        dc     a2'ENEMY3_011A_MASK'
                        dc     a2'ENEMY3_012A_MASK'
                        dc     a2'ENEMY3_013A_MASK'
                        dc     a2'ENEMY3_014A_MASK'
                        dc     a2'ENEMY3_015A_MASK'
                        dc     a2'ENEMY4_000A_MASK'
                        dc     a2'ENEMY4_001A_MASK'
                        dc     a2'ENEMY4_002A_MASK'
                        dc     a2'ENEMY4_003A_MASK'

mt_enemy_b              dc     a2'ENEMY0_000B_MASK'
                        dc     a2'ENEMY0_001B_MASK'
                        dc     a2'ENEMY0_002B_MASK'
                        dc     a2'ENEMY0_003B_MASK'
                        dc     a2'ENEMY0_004B_MASK'
                        dc     a2'ENEMY0_005B_MASK'
                        dc     a2'ENEMY0_006B_MASK'
                        dc     a2'ENEMY0_007B_MASK'
                        dc     a2'ENEMY0_008B_MASK'
                        dc     a2'ENEMY0_009B_MASK'
                        dc     a2'ENEMY0_010B_MASK'
                        dc     a2'ENEMY0_011B_MASK'
                        dc     a2'ENEMY0_012B_MASK'
                        dc     a2'ENEMY0_013B_MASK'
                        dc     a2'ENEMY0_014B_MASK'
                        dc     a2'ENEMY0_015B_MASK'
                        dc     a2'ENEMY1_000B_MASK'
                        dc     a2'ENEMY1_001B_MASK'
                        dc     a2'ENEMY1_002B_MASK'
                        dc     a2'ENEMY1_003B_MASK'
                        dc     a2'ENEMY1_004B_MASK'
                        dc     a2'ENEMY1_005B_MASK'
                        dc     a2'ENEMY1_006B_MASK'
                        dc     a2'ENEMY1_007B_MASK'
                        dc     a2'ENEMY1_008B_MASK'
                        dc     a2'ENEMY1_009B_MASK'
                        dc     a2'ENEMY1_010B_MASK'
                        dc     a2'ENEMY1_011B_MASK'
                        dc     a2'ENEMY1_012B_MASK'
                        dc     a2'ENEMY1_013B_MASK'
                        dc     a2'ENEMY1_014B_MASK'
                        dc     a2'ENEMY1_015B_MASK'
                        dc     a2'ENEMY2_000B_MASK'
                        dc     a2'ENEMY2_001B_MASK'
                        dc     a2'ENEMY2_002B_MASK'
                        dc     a2'ENEMY2_003B_MASK'
                        dc     a2'ENEMY2_004B_MASK'
                        dc     a2'ENEMY2_005B_MASK'
                        dc     a2'ENEMY2_006B_MASK'
                        dc     a2'ENEMY2_007B_MASK'
                        dc     a2'ENEMY2_008B_MASK'
                        dc     a2'ENEMY3_000B_MASK'
                        dc     a2'ENEMY3_001B_MASK'
                        dc     a2'ENEMY3_002B_MASK'
                        dc     a2'ENEMY3_003B_MASK'
                        dc     a2'ENEMY3_004B_MASK'
                        dc     a2'ENEMY3_005B_MASK'
                        dc     a2'ENEMY3_006B_MASK'
                        dc     a2'ENEMY3_007B_MASK'
                        dc     a2'ENEMY3_008B_MASK'
                        dc     a2'ENEMY3_009B_MASK'
                        dc     a2'ENEMY3_010B_MASK'
                        dc     a2'ENEMY3_011B_MASK'
                        dc     a2'ENEMY3_012B_MASK'
                        dc     a2'ENEMY3_013B_MASK'
                        dc     a2'ENEMY3_014B_MASK'
                        dc     a2'ENEMY3_015B_MASK'
                        dc     a2'ENEMY4_000B_MASK'
                        dc     a2'ENEMY4_001B_MASK'
                        dc     a2'ENEMY4_002B_MASK'
                        dc     a2'ENEMY4_003B_MASK'

st_enemy_a              dc     a2'ENEMY0_000A'
                        dc     a2'ENEMY0_001A'
                        dc     a2'ENEMY0_002A'
                        dc     a2'ENEMY0_003A'
                        dc     a2'ENEMY0_004A'
                        dc     a2'ENEMY0_005A'
                        dc     a2'ENEMY0_006A'
                        dc     a2'ENEMY0_007A'
                        dc     a2'ENEMY0_008A'
                        dc     a2'ENEMY0_009A'
                        dc     a2'ENEMY0_010A'
                        dc     a2'ENEMY0_011A'
                        dc     a2'ENEMY0_012A'
                        dc     a2'ENEMY0_013A'
                        dc     a2'ENEMY0_014A'
                        dc     a2'ENEMY0_015A'
                        dc     a2'ENEMY1_000A'
                        dc     a2'ENEMY1_001A'
                        dc     a2'ENEMY1_002A'
                        dc     a2'ENEMY1_003A'
                        dc     a2'ENEMY1_004A'
                        dc     a2'ENEMY1_005A'
                        dc     a2'ENEMY1_006A'
                        dc     a2'ENEMY1_007A'
                        dc     a2'ENEMY1_008A'
                        dc     a2'ENEMY1_009A'
                        dc     a2'ENEMY1_010A'
                        dc     a2'ENEMY1_011A'
                        dc     a2'ENEMY1_012A'
                        dc     a2'ENEMY1_013A'
                        dc     a2'ENEMY1_014A'
                        dc     a2'ENEMY1_015A'
                        dc     a2'ENEMY2_000A'
                        dc     a2'ENEMY2_001A'
                        dc     a2'ENEMY2_002A'
                        dc     a2'ENEMY2_003A'
                        dc     a2'ENEMY2_004A'
                        dc     a2'ENEMY2_005A'
                        dc     a2'ENEMY2_006A'
                        dc     a2'ENEMY2_007A'
                        dc     a2'ENEMY2_008A'
                        dc     a2'ENEMY3_000A'
                        dc     a2'ENEMY3_001A'
                        dc     a2'ENEMY3_002A'
                        dc     a2'ENEMY3_003A'
                        dc     a2'ENEMY3_004A'
                        dc     a2'ENEMY3_005A'
                        dc     a2'ENEMY3_006A'
                        dc     a2'ENEMY3_007A'
                        dc     a2'ENEMY3_008A'
                        dc     a2'ENEMY3_009A'
                        dc     a2'ENEMY3_010A'
                        dc     a2'ENEMY3_011A'
                        dc     a2'ENEMY3_012A'
                        dc     a2'ENEMY3_013A'
                        dc     a2'ENEMY3_014A'
                        dc     a2'ENEMY3_015A'
                        dc     a2'ENEMY4_000A'
                        dc     a2'ENEMY4_001A'
                        dc     a2'ENEMY4_002A'
                        dc     a2'ENEMY4_003A'

st_enemy_b              dc     a2'ENEMY0_000B'
                        dc     a2'ENEMY0_001B'
                        dc     a2'ENEMY0_002B'
                        dc     a2'ENEMY0_003B'
                        dc     a2'ENEMY0_004B'
                        dc     a2'ENEMY0_005B'
                        dc     a2'ENEMY0_006B'
                        dc     a2'ENEMY0_007B'
                        dc     a2'ENEMY0_008B'
                        dc     a2'ENEMY0_009B'
                        dc     a2'ENEMY0_010B'
                        dc     a2'ENEMY0_011B'
                        dc     a2'ENEMY0_012B'
                        dc     a2'ENEMY0_013B'
                        dc     a2'ENEMY0_014B'
                        dc     a2'ENEMY0_015B'
                        dc     a2'ENEMY1_000B'
                        dc     a2'ENEMY1_001B'
                        dc     a2'ENEMY1_002B'
                        dc     a2'ENEMY1_003B'
                        dc     a2'ENEMY1_004B'
                        dc     a2'ENEMY1_005B'
                        dc     a2'ENEMY1_006B'
                        dc     a2'ENEMY1_007B'
                        dc     a2'ENEMY1_008B'
                        dc     a2'ENEMY1_009B'
                        dc     a2'ENEMY1_010B'
                        dc     a2'ENEMY1_011B'
                        dc     a2'ENEMY1_012B'
                        dc     a2'ENEMY1_013B'
                        dc     a2'ENEMY1_014B'
                        dc     a2'ENEMY1_015B'
                        dc     a2'ENEMY2_000B'
                        dc     a2'ENEMY2_001B'
                        dc     a2'ENEMY2_002B'
                        dc     a2'ENEMY2_003B'
                        dc     a2'ENEMY2_004B'
                        dc     a2'ENEMY2_005B'
                        dc     a2'ENEMY2_006B'
                        dc     a2'ENEMY2_007B'
                        dc     a2'ENEMY2_008B'
                        dc     a2'ENEMY3_000B'
                        dc     a2'ENEMY3_001B'
                        dc     a2'ENEMY3_002B'
                        dc     a2'ENEMY3_003B'
                        dc     a2'ENEMY3_004B'
                        dc     a2'ENEMY3_005B'
                        dc     a2'ENEMY3_006B'
                        dc     a2'ENEMY3_007B'
                        dc     a2'ENEMY3_008B'
                        dc     a2'ENEMY3_009B'
                        dc     a2'ENEMY3_010B'
                        dc     a2'ENEMY3_011B'
                        dc     a2'ENEMY3_012B'
                        dc     a2'ENEMY3_013B'
                        dc     a2'ENEMY3_014B'
                        dc     a2'ENEMY3_015B'
                        dc     a2'ENEMY4_000B'
                        dc     a2'ENEMY4_001B'
                        dc     a2'ENEMY4_002B'
                        dc     a2'ENEMY4_003B'

;-----------------------------------------------------------------------------
;MARK: Explode
dt_explode_small_ftime  dc     i2'4,8,4,4'                 ; frame hold time
dt_explode_large_ftime  dc     i2'8,16,8,8'

it_explode_boom_a       dc     a2'EXLBM_002A_DATA'
                        dc     a2'EXLBM_003A_DATA'
                        dc     a2'EXLBM_002A_DATA'
                        dc     a2'EXLBM_001A_DATA'
                        dc     a2'EXLBM_000A_DATA'
it_explode_boom_b       dc     a2'EXLBM_002B_DATA'
                        dc     a2'EXLBM_003B_DATA'
                        dc     a2'EXLBM_002B_DATA'
                        dc     a2'EXLBM_001B_DATA'
                        dc     a2'EXLBM_000B_DATA'
mt_explode_boom_a       dc     a2'EXLBM_002A_MASK'
                        dc     a2'EXLBM_003A_MASK'
                        dc     a2'EXLBM_002A_MASK'
                        dc     a2'EXLBM_001A_MASK'
                        dc     a2'EXLBM_000A_MASK'
mt_explode_boom_b       dc     a2'EXLBM_002B_MASK'
                        dc     a2'EXLBM_003B_MASK'
                        dc     a2'EXLBM_002B_MASK'
                        dc     a2'EXLBM_001B_MASK'
                        dc     a2'EXLBM_000B_MASK'
st_explode_boom_a       dc     a2'EXLBM_002A'
                        dc     a2'EXLBM_003A'
                        dc     a2'EXLBM_002A'
                        dc     a2'EXLBM_001A'
                        dc     a2'EXLBM_000A'
st_explode_boom_b       dc     a2'EXLBM_002B'
                        dc     a2'EXLBM_003B'
                        dc     a2'EXLBM_002B'
                        dc     a2'EXLBM_001B'
                        dc     a2'EXLBM_000B'

it_explode_large_a      dc     a2'EXLLG_002A_DATA'
                        dc     a2'EXLLG_003A_DATA'
                        dc     a2'EXLLG_002A_DATA'
                        dc     a2'EXLLG_001A_DATA'
                        dc     a2'EXLLG_000A_DATA'
it_explode_large_b      dc     a2'EXLLG_002B_DATA'
                        dc     a2'EXLLG_003B_DATA'
                        dc     a2'EXLLG_002B_DATA'
                        dc     a2'EXLLG_001B_DATA'
                        dc     a2'EXLLG_000B_DATA'
mt_explode_large_a      dc     a2'EXLLG_002A_MASK'
                        dc     a2'EXLLG_003A_MASK'
                        dc     a2'EXLLG_002A_MASK'
                        dc     a2'EXLLG_001A_MASK'
                        dc     a2'EXLLG_000A_MASK'
mt_explode_large_b      dc     a2'EXLLG_002B_MASK'
                        dc     a2'EXLLG_003B_MASK'
                        dc     a2'EXLLG_002B_MASK'
                        dc     a2'EXLLG_001B_MASK'
                        dc     a2'EXLLG_000B_MASK'
st_explode_large_a      dc     a2'EXLLG_002A'
                        dc     a2'EXLLG_003A'
                        dc     a2'EXLLG_002A'
                        dc     a2'EXLLG_001A'
                        dc     a2'EXLLG_000A'
st_explode_large_b      dc     a2'EXLLG_002B'
                        dc     a2'EXLLG_003B'
                        dc     a2'EXLLG_002B'
                        dc     a2'EXLLG_001B'
                        dc     a2'EXLLG_000B'

it_explode_sblt_a       dc     a2'EXLSB_002A_DATA'
                        dc     a2'EXLSB_003A_DATA'
                        dc     a2'EXLSB_002A_DATA'
                        dc     a2'EXLSB_001A_DATA'
                        dc     a2'EXLSB_000A_DATA'
it_explode_sblt_b       dc     a2'EXLSB_002B_DATA'
                        dc     a2'EXLSB_003B_DATA'
                        dc     a2'EXLSB_002B_DATA'
                        dc     a2'EXLSB_001B_DATA'
                        dc     a2'EXLSB_000B_DATA'
mt_explode_sblt_a       dc     a2'EXLSB_002A_MASK'
                        dc     a2'EXLSB_003A_MASK'
                        dc     a2'EXLSB_002A_MASK'
                        dc     a2'EXLSB_001A_MASK'
                        dc     a2'EXLSB_000A_MASK'
mt_explode_sblt_b       dc     a2'EXLSB_002B_MASK'
                        dc     a2'EXLSB_003B_MASK'
                        dc     a2'EXLSB_002B_MASK'
                        dc     a2'EXLSB_001B_MASK'
                        dc     a2'EXLSB_000B_MASK'
st_explode_sblt_a       dc     a2'EXLSB_002A'
                        dc     a2'EXLSB_003A'
                        dc     a2'EXLSB_002A'
                        dc     a2'EXLSB_001A'
                        dc     a2'EXLSB_000A'
st_explode_sblt_b       dc     a2'EXLSB_002B'
                        dc     a2'EXLSB_003B'
                        dc     a2'EXLSB_002B'
                        dc     a2'EXLSB_001B'
                        dc     a2'EXLSB_000B'

it_explode_small_a      dc     a2'EXLSM_002A_DATA'
                        dc     a2'EXLSM_003A_DATA'
                        dc     a2'EXLSM_002A_DATA'
                        dc     a2'EXLSM_001A_DATA'
                        dc     a2'EXLSM_000A_DATA'
it_explode_small_b      dc     a2'EXLSM_002B_DATA'
                        dc     a2'EXLSM_003B_DATA'
                        dc     a2'EXLSM_002B_DATA'
                        dc     a2'EXLSM_001B_DATA'
                        dc     a2'EXLSM_000B_DATA'
mt_explode_small_a      dc     a2'EXLSM_002A_MASK'
                        dc     a2'EXLSM_003A_MASK'
                        dc     a2'EXLSM_002A_MASK'
                        dc     a2'EXLSM_001A_MASK'
                        dc     a2'EXLSM_000A_MASK'
mt_explode_small_b      dc     a2'EXLSM_002B_MASK'
                        dc     a2'EXLSM_003B_MASK'
                        dc     a2'EXLSM_002B_MASK'
                        dc     a2'EXLSM_001B_MASK'
                        dc     a2'EXLSM_000B_MASK'
st_explode_small_a      dc     a2'EXLSM_002A'
                        dc     a2'EXLSM_003A'
                        dc     a2'EXLSM_002A'
                        dc     a2'EXLSM_001A'
                        dc     a2'EXLSM_000A'
st_explode_small_b      dc     a2'EXLSM_002B'
                        dc     a2'EXLSM_003B'
                        dc     a2'EXLSM_002B'
                        dc     a2'EXLSM_001B'
                        dc     a2'EXLSM_000B'

it_explode_wep_a        dc     a2'EXLWE_002A_DATA'
                        dc     a2'EXLWE_003A_DATA'
                        dc     a2'EXLWE_002A_DATA'
                        dc     a2'EXLWE_001A_DATA'
                        dc     a2'EXLWE_000A_DATA'
it_explode_wep_b        dc     a2'EXLWE_002B_DATA'
                        dc     a2'EXLWE_003B_DATA'
                        dc     a2'EXLWE_002B_DATA'
                        dc     a2'EXLWE_001B_DATA'
                        dc     a2'EXLWE_000B_DATA'
mt_explode_wep_a        dc     a2'EXLWE_002A_MASK'
                        dc     a2'EXLWE_003A_MASK'
                        dc     a2'EXLWE_002A_MASK'
                        dc     a2'EXLWE_001A_MASK'
                        dc     a2'EXLWE_000A_MASK'
mt_explode_wep_b        dc     a2'EXLWE_002B_MASK'
                        dc     a2'EXLWE_003B_MASK'
                        dc     a2'EXLWE_002B_MASK'
                        dc     a2'EXLWE_001B_MASK'
                        dc     a2'EXLWE_000B_MASK'
st_explode_wep_a        dc     a2'EXLWE_002A'
                        dc     a2'EXLWE_003A'
                        dc     a2'EXLWE_002A'
                        dc     a2'EXLWE_001A'
                        dc     a2'EXLWE_000A'
st_explode_wep_b        dc     a2'EXLWE_002B'
                        dc     a2'EXLWE_003B'
                        dc     a2'EXLWE_002B'
                        dc     a2'EXLWE_001B'
                        dc     a2'EXLWE_000B'

;-----------------------------------------------------------------------------
; MARK: Rockets
it_rocket_a             dc     a2'ROCKET_000A_DATA'
                        dc     a2'ROCKET_001A_DATA'
                        dc     a2'ROCKET_002A_DATA'
                        dc     a2'ROCKET_003A_DATA'
                        dc     a2'ROCKET_004A_DATA'
                        dc     a2'ROCKET_005A_DATA'
                        dc     a2'ROCKET_006A_DATA'
                        dc     a2'ROCKET_007A_DATA'
                        dc     a2'ROCKET_008A_DATA'
                        dc     a2'ROCKET_009A_DATA'
                        dc     a2'ROCKET_010A_DATA'
                        dc     a2'ROCKET_011A_DATA'
                        dc     a2'ROCKET_012A_DATA'
                        dc     a2'ROCKET_013A_DATA'
                        dc     a2'ROCKET_014A_DATA'
                        dc     a2'ROCKET_015A_DATA'
it_rocket_b             dc     a2'ROCKET_000B_DATA'
                        dc     a2'ROCKET_001B_DATA'
                        dc     a2'ROCKET_002B_DATA'
                        dc     a2'ROCKET_003B_DATA'
                        dc     a2'ROCKET_004B_DATA'
                        dc     a2'ROCKET_005B_DATA'
                        dc     a2'ROCKET_006B_DATA'
                        dc     a2'ROCKET_007B_DATA'
                        dc     a2'ROCKET_008B_DATA'
                        dc     a2'ROCKET_009B_DATA'
                        dc     a2'ROCKET_010B_DATA'
                        dc     a2'ROCKET_011B_DATA'
                        dc     a2'ROCKET_012B_DATA'
                        dc     a2'ROCKET_013B_DATA'
                        dc     a2'ROCKET_014B_DATA'
                        dc     a2'ROCKET_015B_DATA'
mt_rocket_a             dc     a2'ROCKET_000A_MASK'
                        dc     a2'ROCKET_001A_MASK'
                        dc     a2'ROCKET_002A_MASK'
                        dc     a2'ROCKET_003A_MASK'
                        dc     a2'ROCKET_004A_MASK'
                        dc     a2'ROCKET_005A_MASK'
                        dc     a2'ROCKET_006A_MASK'
                        dc     a2'ROCKET_007A_MASK'
                        dc     a2'ROCKET_008A_MASK'
                        dc     a2'ROCKET_009A_MASK'
                        dc     a2'ROCKET_010A_MASK'
                        dc     a2'ROCKET_011A_MASK'
                        dc     a2'ROCKET_012A_MASK'
                        dc     a2'ROCKET_013A_MASK'
                        dc     a2'ROCKET_014A_MASK'
                        dc     a2'ROCKET_015A_MASK'
mt_rocket_b             dc     a2'ROCKET_000B_MASK'
                        dc     a2'ROCKET_001B_MASK'
                        dc     a2'ROCKET_002B_MASK'
                        dc     a2'ROCKET_003B_MASK'
                        dc     a2'ROCKET_004B_MASK'
                        dc     a2'ROCKET_005B_MASK'
                        dc     a2'ROCKET_006B_MASK'
                        dc     a2'ROCKET_007B_MASK'
                        dc     a2'ROCKET_008B_MASK'
                        dc     a2'ROCKET_009B_MASK'
                        dc     a2'ROCKET_010B_MASK'
                        dc     a2'ROCKET_011B_MASK'
                        dc     a2'ROCKET_012B_MASK'
                        dc     a2'ROCKET_013B_MASK'
                        dc     a2'ROCKET_014B_MASK'
                        dc     a2'ROCKET_015B_MASK'
st_rocket_a             dc     a2'ROCKET_000A'
                        dc     a2'ROCKET_001A'
                        dc     a2'ROCKET_002A'
                        dc     a2'ROCKET_003A'
                        dc     a2'ROCKET_004A'
                        dc     a2'ROCKET_005A'
                        dc     a2'ROCKET_006A'
                        dc     a2'ROCKET_007A'
                        dc     a2'ROCKET_008A'
                        dc     a2'ROCKET_009A'
                        dc     a2'ROCKET_010A'
                        dc     a2'ROCKET_011A'
                        dc     a2'ROCKET_012A'
                        dc     a2'ROCKET_013A'
                        dc     a2'ROCKET_014A'
                        dc     a2'ROCKET_015A'
st_rocket_b             dc     a2'ROCKET_000B'
                        dc     a2'ROCKET_001B'
                        dc     a2'ROCKET_002B'
                        dc     a2'ROCKET_003B'
                        dc     a2'ROCKET_004B'
                        dc     a2'ROCKET_005B'
                        dc     a2'ROCKET_006B'
                        dc     a2'ROCKET_007B'
                        dc     a2'ROCKET_008B'
                        dc     a2'ROCKET_009B'
                        dc     a2'ROCKET_010B'
                        dc     a2'ROCKET_011B'
                        dc     a2'ROCKET_012B'
                        dc     a2'ROCKET_013B'
                        dc     a2'ROCKET_014B'
                        dc     a2'ROCKET_015B'

;-----------------------------------------------------------------------------
; MARK: Scores (Number)
it_number_a             dc     a2'NUMBER_000A_DATA'
                        dc     a2'NUMBER_001A_DATA'
                        dc     a2'NUMBER_002A_DATA'
                        dc     a2'NUMBER_003A_DATA'
                        dc     a2'NUMBER_004A_DATA'
                        dc     a2'NUMBER_005A_DATA'
it_number_b             dc     a2'NUMBER_000B_DATA'
                        dc     a2'NUMBER_001B_DATA'
                        dc     a2'NUMBER_002B_DATA'
                        dc     a2'NUMBER_003B_DATA'
                        dc     a2'NUMBER_004B_DATA'
                        dc     a2'NUMBER_005B_DATA'
mt_number_a             dc     a2'NUMBER_000A_MASK'
                        dc     a2'NUMBER_001A_MASK'
                        dc     a2'NUMBER_002A_MASK'
                        dc     a2'NUMBER_003A_MASK'
                        dc     a2'NUMBER_004A_MASK'
                        dc     a2'NUMBER_005A_MASK'
mt_number_b             dc     a2'NUMBER_000B_MASK'
                        dc     a2'NUMBER_001B_MASK'
                        dc     a2'NUMBER_002B_MASK'
                        dc     a2'NUMBER_003B_MASK'
                        dc     a2'NUMBER_004B_MASK'
                        dc     a2'NUMBER_005B_MASK'
st_number_a             dc     a2'NUMBER_000A'
                        dc     a2'NUMBER_001A'
                        dc     a2'NUMBER_002A'
                        dc     a2'NUMBER_003A'
                        dc     a2'NUMBER_004A'
                        dc     a2'NUMBER_005A'
st_number_b             dc     a2'NUMBER_000B'
                        dc     a2'NUMBER_001B'
                        dc     a2'NUMBER_002B'
                        dc     a2'NUMBER_003B'
                        dc     a2'NUMBER_004B'
                        dc     a2'NUMBER_005B'

;-----------------------------------------------------------------------------
; MARK: Space Bullets
it_sbullet_a            dc     a2'SBULLET_000A_DATA'
                        dc     a2'SBULLET_001A_DATA'
                        dc     a2'SBULLET_002A_DATA'
                        dc     a2'SBULLET_003A_DATA'
                        dc     a2'SBULLET_004A_DATA'
                        dc     a2'SBULLET_005A_DATA'
                        dc     a2'SBULLET_006A_DATA'
                        dc     a2'SBULLET_007A_DATA'
it_sbullet_b            dc     a2'SBULLET_000B_DATA'
                        dc     a2'SBULLET_001B_DATA'
                        dc     a2'SBULLET_002B_DATA'
                        dc     a2'SBULLET_003B_DATA'
                        dc     a2'SBULLET_004B_DATA'
                        dc     a2'SBULLET_005B_DATA'
                        dc     a2'SBULLET_006B_DATA'
                        dc     a2'SBULLET_007B_DATA'
mt_sbullet_a            dc     a2'SBULLET_000A_MASK'
                        dc     a2'SBULLET_001A_MASK'
                        dc     a2'SBULLET_002A_MASK'
                        dc     a2'SBULLET_003A_MASK'
                        dc     a2'SBULLET_004A_MASK'
                        dc     a2'SBULLET_005A_MASK'
                        dc     a2'SBULLET_006A_MASK'
                        dc     a2'SBULLET_007A_MASK'
mt_sbullet_b            dc     a2'SBULLET_000B_MASK'
                        dc     a2'SBULLET_001B_MASK'
                        dc     a2'SBULLET_002B_MASK'
                        dc     a2'SBULLET_003B_MASK'
                        dc     a2'SBULLET_004B_MASK'
                        dc     a2'SBULLET_005B_MASK'
                        dc     a2'SBULLET_006B_MASK'
                        dc     a2'SBULLET_007B_MASK'
st_sbullet_a            dc     a2'SBULLET_000A'
                        dc     a2'SBULLET_001A'
                        dc     a2'SBULLET_002A'
                        dc     a2'SBULLET_003A'
                        dc     a2'SBULLET_004A'
                        dc     a2'SBULLET_005A'
                        dc     a2'SBULLET_006A'
                        dc     a2'SBULLET_007A'
st_sbullet_b            dc     a2'SBULLET_000B'
                        dc     a2'SBULLET_001B'
                        dc     a2'SBULLET_002B'
                        dc     a2'SBULLET_003B'
                        dc     a2'SBULLET_004B'
                        dc     a2'SBULLET_005B'
                        dc     a2'SBULLET_006B'
                        dc     a2'SBULLET_007B'

;-----------------------------------------------------------------------------
; MARK: Parachute
dt_parachute_frame      dc     i2'0,2,4,6,4,2'             ; animate frame order
it_parachute_a          dc     a2'PARACHUTE_000A_DATA'
                        dc     a2'PARACHUTE_001A_DATA'
                        dc     a2'PARACHUTE_002A_DATA'
                        dc     a2'PARACHUTE_003A_DATA'
it_parachute_b          dc     a2'PARACHUTE_000B_DATA'
                        dc     a2'PARACHUTE_001B_DATA'
                        dc     a2'PARACHUTE_002B_DATA'
                        dc     a2'PARACHUTE_003B_DATA'
mt_parachute_a          dc     a2'PARACHUTE_000A_MASK'
                        dc     a2'PARACHUTE_001A_MASK'
                        dc     a2'PARACHUTE_002A_MASK'
                        dc     a2'PARACHUTE_003A_MASK'
mt_parachute_b          dc     a2'PARACHUTE_000B_MASK'
                        dc     a2'PARACHUTE_001B_MASK'
                        dc     a2'PARACHUTE_002B_MASK'
                        dc     a2'PARACHUTE_003B_MASK'
st_parachute_a          dc     a2'PARACHUTE_000A'
                        dc     a2'PARACHUTE_001A'
                        dc     a2'PARACHUTE_002A'
                        dc     a2'PARACHUTE_003A'
st_parachute_b          dc     a2'PARACHUTE_000B'
                        dc     a2'PARACHUTE_001B'
                        dc     a2'PARACHUTE_002B'
                        dc     a2'PARACHUTE_003B'

;-----------------------------------------------------------------------------
; MARK: Player
st_player               dc     a2'PLAYER_000A,PLAYER_001A,PLAYER_002A,PLAYER_003A'
                        dc     a2'PLAYER_004A,PLAYER_005A,PLAYER_006A,PLAYER_007A'
                        dc     a2'PLAYER_008A,PLAYER_009A,PLAYER_010A,PLAYER_011A'
                        dc     a2'PLAYER_012A,PLAYER_013A,PLAYER_014A,PLAYER_015A'
                        dc     a2'PLAYER_016A,PLAYER_017A,PLAYER_018A,PLAYER_019A'
                        dc     a2'PLAYER_020A,PLAYER_021A,PLAYER_022A,PLAYER_023A'
                        dc     a2'PLAYER_024A,PLAYER_025A,PLAYER_026A,PLAYER_027A'
                        dc     a2'PLAYER_028A,PLAYER_029A,PLAYER_030A,PLAYER_031A'

;-----------------------------------------------------------------------------
st_text                 dc     a2'TXT1_000A'
                        dc     a2'TXT2_000A'
                        dc     a2'TXT3_000A'
                        dc     a2'TXT4_000A'
                        dc     a2'TXT5_000A'
                        dc     a2'TXT1910_000A'
                        dc     a2'TXT1910B_000A'
                        dc     a2'TXT1910R_000A'
                        dc     a2'TXT1940_000A'
                        dc     a2'TXT1940B_000A'
                        dc     a2'TXT1940R_000A'
                        dc     a2'TXT1970_000A'
                        dc     a2'TXT1970B_000A'
                        dc     a2'TXT1970R_000A'
                        dc     a2'TXT1982_000A'
                        dc     a2'TXT1982B_000A'
                        dc     a2'TXT1982R_000A'
                        dc     a2'TXT2001_000A'
                        dc     a2'TXT2001B_000A'
                        dc     a2'TXT2001R_000A'
                        dc     a2'TXTAD_000A'
                        dc     a2'TXTADB_000A'
                        dc     a2'TXTADR_000A'
                        dc     a2'TXTPAUSE_000A'
                        dc     a2'TXTGAMEOVER_000A'
                        dc     a2'TXTPLAYER_000A'
                        dc     a2'TXTREADY_000A'
                        dc     a2'TXTSTAGE_000A'


;-----------------------------------------------------------------------------
; MARK: Timewarp
st_timewarp             dc     a2'TIMEWARP_000A,TIMEWARP_001A,TIMEWARP_002A,TIMEWARP_003A'

; This array needs some explanation:
; Position index (into timewarp_draw_x)
; Length (Start at position index and increment length times drawing a row of this sprite)
; frame from sprite sheet
; length again, but if -1 end this draw run
; You can read this as something like:
; starting at position 5 (so 88), 3 sprites at frame 0 and yeild then
; stating at 72, 5 sprites frame 0 yield, etc.
script_timewarp_draw    dc     i2'2*5,3,0,-1'
                        dc     i2'2*4,5,0,-1'
                        dc     i2'2*3,7,0,-1'
                        dc     i2'2*2,9,0,-1'
                        dc     i2'2*1,11,0,-1'
                        dc     i2'2*0,13,0,-1'
                        dc     i2'2*0,13,0,2*5,3,2*1,-1'
                        dc     i2'2*0,13,0,2*4,5,2*1,-1'
                        dc     i2'2*0,13,0,2*3,7,2*1,2*5,3,2*2,-1'
                        dc     i2'2*0,13,0,2*2,9,2*1,2*4,5,2*2,2*6,1,2*3,-1'
                        dc     i2'2*0,13,0,2*2,9,2*1,2*4,5,2*2,2*6,1,2*3,-1'
                        dc     i2'2*0,13,0,2*2,9,2*1,2*4,5,2*2,2*6,1,2*3,-1'
                        dc     i2'2*0,13,0,2*2,9,2*1,2*4,5,2*2,2*6,1,2*3,-1'
                        dc     i2'2*0,13,0,2*3,7,2*1,2*5,3,2*2,-1'
                        dc     i2'2*0,13,0,2*4,5,2*1,-1'
                        dc     i2'2*0,13,0,2*5,3,2*1,-1'
                        dc     i2'2*0,13,0,-1'
                        dc     i2'2*1,11,0,-1'
                        dc     i2'2*2,9,0,-1'
                        dc     i2'2*3,7,0,-1'
                        dc     i2'2*4,5,0,-1'
                        dc     i2'2*5,3,0,-1'
                        dc     i2'-1'

dt_timewarp_pos_x       dc     i2'$2000+PLAYER_Y*160+8/2'
                        dc     i2'$2000+PLAYER_Y*160+24/2'
                        dc     i2'$2000+PLAYER_Y*160+40/2'
                        dc     i2'$2000+PLAYER_Y*160+56/2'
                        dc     i2'$2000+PLAYER_Y*160+72/2'
                        dc     i2'$2000+PLAYER_Y*160+88/2'
                        dc     i2'$2000+PLAYER_Y*160+104/2'
                        dc     i2'$2000+PLAYER_Y*160+120/2'
                        dc     i2'$2000+PLAYER_Y*160+136/2'
                        dc     i2'$2000+PLAYER_Y*160+152/2'
                        dc     i2'$2000+PLAYER_Y*160+168/2'
                        dc     i2'$2000+PLAYER_Y*160+184/2'
                        dc     i2'$2000+PLAYER_Y*160+200/2'

;-----------------------------------------------------------------------------
; MARK: Launch
dt_horizontal           dc     i2'AF_NONE'                 ; direction flags
                        dc     i2'AF_NONE'
                        dc     i2'AF_NONE'
                        dc     i2'AF_NONE'
                        dc     i2'AF_NONE'
                        dc     i2'AF_NONE'
                        dc     i2'AF_NONE'
                        dc     i2'AF_NONE'
                        dc     i2'AF_DIR_RIGHT'
                        dc     i2'AF_DIR_RIGHT'
                        dc     i2'AF_DIR_RIGHT'
                        dc     i2'AF_DIR_RIGHT'
                        dc     i2'AF_DIR_RIGHT'
                        dc     i2'AF_DIR_RIGHT'
                        dc     i2'AF_DIR_RIGHT'
                        dc     i2'AF_DIR_RIGHT'
                        dc     i2'AF_DIR_RIGHT'
                        dc     i2'AF_DIR_RIGHT'
                        dc     i2'AF_DIR_RIGHT'
                        dc     i2'AF_DIR_RIGHT'
                        dc     i2'AF_DIR_RIGHT'
                        dc     i2'AF_DIR_RIGHT'
                        dc     i2'AF_DIR_RIGHT'
                        dc     i2'AF_DIR_RIGHT'
                        dc     i2'AF_NONE'
                        dc     i2'AF_NONE'
                        dc     i2'AF_NONE'
                        dc     i2'AF_NONE'
                        dc     i2'AF_NONE'
                        dc     i2'AF_NONE'
                        dc     i2'AF_NONE'
                        dc     i2'AF_NONE'

; Index into dt_launch (based on player direction)
dt_horizonal_launch     dc     i2'0,2,4,6,6,6,6,6'
                        dc     i2'26,26,26,26,26,26,28,30'
                        dc     i2'32,34,36,38,38,38,38,38'
                        dc     i2'58,58,58,58,58,58,60,32'

; -16 .. 224 around the screen at 11.25 degree angles - offset by -8 when not -16 or 224
dt_launch_x             dc     i2'$00E0,$00E0,$00E0,$00E0,$00E0,$00C6,$00A9,$0089'
                        dc     i2'$0068,$0047,$0027,$000A,$FFF0,$FFF0,$FFF0,$FFF0'
                        dc     i2'$FFF0,$FFF0,$FFF0,$FFF0,$FFF0,$000A,$0027,$0047'
                        dc     i2'$0068,$0089,$00A9,$00C6,$00E0,$00E0,$00E0,$00E0'

; -16 .. 192 around the screen at 11.25 degree angles,offset by -8 when not -16 or 192
dt_launch_y             dc     i2'$0058,$0075,$0090,$00AA,$00C0,$00C0,$00C0,$00C0'
                        dc     i2'$00C0,$00C0,$00C0,$00C0,$00C0,$00AA,$0090,$0075'
                        dc     i2'$0058,$003B,$0020,$0006,$FFF0,$FFF0,$FFF0,$FFF0'
                        dc     i2'$FFF0,$FFF0,$FFF0,$FFF0,$FFF0,$0006,$0020,$003B'

;-----------------------------------------------------------------------------
; MARK: Rays
; -128 to 368 with negatives wrapping to col/row 24.  Centre at (112,96)
dt_movement_rays        dc     i'8 ,8 ,8 ,10,12,12,14,16,18,20,20,22,24,24,24,26,26,26,26,28,28,28,28,28,4 ,4 ,4 ,4 ,6 ,6 ,6 ,6 '
                        dc     i'6 ,8 ,8 ,10,10,12,14,16,18,20,22,22,24,24,26,26,26,28,28,28,28,28,28,28,4 ,4 ,4 ,4 ,4 ,4 ,6 ,6 '
                        dc     i'6 ,6 ,6 ,8 ,10,12,14,16,18,20,22,24,26,26,26,28,28,28,28,28,28,30,30,30,2 ,2 ,4 ,4 ,4 ,4 ,4 ,4 '
                        dc     i'4 ,4 ,6 ,6 ,8 ,10,12,16,20,22,24,26,26,28,28,28,28,30,30,30,30,30,30,30,2 ,2 ,2 ,2 ,2 ,2 ,4 ,4 '
                        dc     i'2 ,4 ,4 ,4 ,6 ,8 ,12,16,20,24,26,28,28,28,30,30,30,30,30,30,30,30,30,30,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 '
                        dc     i'2 ,2 ,2 ,2 ,4 ,4 ,8 ,16,24,28,28,30,30,30,30,30,30,30,32,32,32,32,32,32,0 ,0 ,0 ,0 ,0 ,2 ,2 ,2 '
                        dc     i'0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 '
                        dc     i'62,62,62,62,60,60,56,48,40,36,36,34,34,34,34,34,34,34,32,32,32,32,32,32,0 ,0 ,0 ,0 ,0 ,62,62,62'
                        dc     i'62,60,60,60,58,56,52,48,44,40,38,36,36,36,34,34,34,34,34,34,34,34,34,34,62,62,62,62,62,62,62,62'
                        dc     i'60,60,58,58,56,54,52,48,44,42,40,38,38,36,36,36,36,34,34,34,34,34,34,34,62,62,62,62,62,62,60,60'
                        dc     i'58,58,58,56,54,52,50,48,46,44,42,40,38,38,38,36,36,36,36,36,36,34,34,34,62,62,60,60,60,60,60,60'
                        dc     i'58,56,56,54,54,52,50,48,46,44,42,42,40,40,38,38,38,36,36,36,36,36,36,36,60,60,60,60,60,60,58,58'
                        dc     i'56,56,56,54,52,52,50,48,46,44,44,42,40,40,40,38,38,38,38,36,36,36,36,36,60,60,60,60,58,58,58,58'
                        dc     i'56,56,54,54,52,50,50,48,46,46,44,42,42,40,40,40,38,38,38,38,38,36,36,36,60,60,58,58,58,58,58,56'
                        dc     i'56,54,54,52,52,50,50,48,46,46,44,44,42,42,40,40,40,38,38,38,38,38,36,36,60,58,58,58,58,58,56,56'
                        dc     i'54,54,54,52,52,50,50,48,46,46,44,44,42,42,42,40,40,40,38,38,38,38,38,38,58,58,58,58,58,56,56,56'
                        dc     i'54,54,52,52,50,50,50,48,46,46,46,44,44,42,42,42,40,40,40,40,38,38,38,38,58,58,58,56,56,56,56,54'
                        dc     i'54,54,52,52,50,50,48,48,48,46,46,44,44,42,42,42,42,40,40,40,40,38,38,38,58,58,56,56,56,56,54,54'
                        dc     i'54,52,52,52,50,50,48,48,48,46,46,44,44,44,42,42,42,40,40,40,40,40,38,38,58,56,56,56,56,56,54,54'
                        dc     i'54,52,52,52,50,50,48,48,48,46,46,44,44,44,42,42,42,42,40,40,40,40,40,38,56,56,56,56,56,54,54,54'
                        dc     i'52,52,52,50,50,50,48,48,48,46,46,46,44,44,44,42,42,42,42,40,40,40,40,40,56,56,56,56,54,54,54,54'
                        dc     i'52,52,52,50,50,50,48,48,48,46,46,46,44,44,44,44,42,42,42,42,40,40,40,40,56,56,56,54,54,54,54,52'
                        dc     i'52,52,52,50,50,50,48,48,48,46,46,46,44,44,44,44,42,42,42,42,42,40,40,40,56,56,54,54,54,54,54,52'
                        dc     i'52,52,50,50,50,50,48,48,48,46,46,46,46,44,44,44,44,42,42,42,42,40,40,40,56,56,54,54,54,54,52,52'
                        dc     i'12,12,12,14,14,14,16,16,16,18,18,18,20,20,20,22,22,22,22,24,24,24,24,24,8 ,8 ,8 ,8 ,10,10,10,10'
                        dc     i'10,12,12,12,14,14,16,16,16,18,18,20,20,20,22,22,22,22,24,24,24,24,24,26,8 ,8 ,8 ,8 ,8 ,10,10,10'
                        dc     i'10,12,12,12,14,14,16,16,16,18,18,20,20,20,22,22,22,24,24,24,24,24,26,26,6 ,8 ,8 ,8 ,8 ,8 ,10,10'
                        dc     i'10,10,12,12,14,14,16,16,16,18,18,20,20,22,22,22,22,24,24,24,24,26,26,26,6 ,6 ,8 ,8 ,8 ,8 ,10,10'
                        dc     i'10,10,12,12,14,14,14,16,18,18,18,20,20,22,22,22,24,24,24,24,26,26,26,26,6 ,6 ,6 ,8 ,8 ,8 ,8 ,10'
                        dc     i'10,10,10,12,12,14,14,16,18,18,20,20,22,22,22,24,24,24,26,26,26,26,26,26,6 ,6 ,6 ,6 ,6 ,8 ,8 ,8 '
                        dc     i'8 ,10,10,12,12,14,14,16,18,18,20,20,22,22,24,24,24,26,26,26,26,26,28,28,4 ,6 ,6 ,6 ,6 ,6 ,8 ,8 '
                        dc     i'8 ,8 ,10,10,12,14,14,16,18,18,20,22,22,24,24,24,26,26,26,26,26,28,28,28,4 ,4 ,6 ,6 ,6 ,6 ,6 ,8 '

;-----------------------------------------------------------------------------
; MARK: dt_screen_rows
; Byte start address of byte at each row start on the screen
dt_screen_rows          dc     i'$2000,$20A0,$2140,$21E0,$2280,$2320,$23C0,$2460'
                        dc     i'$2500,$25A0,$2640,$26E0,$2780,$2820,$28C0,$2960'
                        dc     i'$2A00,$2AA0,$2B40,$2BE0,$2C80,$2D20,$2DC0,$2E60'
                        dc     i'$2F00,$2FA0,$3040,$30E0,$3180,$3220,$32C0,$3360'
                        dc     i'$3400,$34A0,$3540,$35E0,$3680,$3720,$37C0,$3860'
                        dc     i'$3900,$39A0,$3A40,$3AE0,$3B80,$3C20,$3CC0,$3D60'
                        dc     i'$3E00,$3EA0,$3F40,$3FE0,$4080,$4120,$41C0,$4260'
                        dc     i'$4300,$43A0,$4440,$44E0,$4580,$4620,$46C0,$4760'
                        dc     i'$4800,$48A0,$4940,$49E0,$4A80,$4B20,$4BC0,$4C60'
                        dc     i'$4D00,$4DA0,$4E40,$4EE0,$4F80,$5020,$50C0,$5160'
                        dc     i'$5200,$52A0,$5340,$53E0,$5480,$5520,$55C0,$5660'
                        dc     i'$5700,$57A0,$5840,$58E0,$5980,$5A20,$5AC0,$5B60'
                        dc     i'$5C00,$5CA0,$5D40,$5DE0,$5E80,$5F20,$5FC0,$6060'
                        dc     i'$6100,$61A0,$6240,$62E0,$6380,$6420,$64C0,$6560'
                        dc     i'$6600,$66A0,$6740,$67E0,$6880,$6920,$69C0,$6A60'
                        dc     i'$6B00,$6BA0,$6C40,$6CE0,$6D80,$6E20,$6EC0,$6F60'
                        dc     i'$7000,$70A0,$7140,$71E0,$7280,$7320,$73C0,$7460'
                        dc     i'$7500,$75A0,$7640,$76E0,$7780,$7820,$78C0,$7960'
                        dc     i'$7A00,$7AA0,$7B40,$7BE0,$7C80,$7D20,$7DC0,$7E60'
                        dc     i'$7F00,$7FA0,$8040,$80E0,$8180,$8220,$82C0,$8360'
                        dc     i'$8400,$84A0,$8540,$85E0,$8680,$8720,$87C0,$8860'
                        dc     i'$8900,$89A0,$8A40,$8AE0,$8B80,$8C20,$8CC0,$8D60'
                        dc     i'$8E00,$8EA0,$8F40,$8FE0,$9080,$9120,$91C0,$9260'
                        dc     i'$9300,$93A0,$9440,$94E0,$9580,$9620,$96C0,$9760'
                        dc     i'$9800,$98A0,$9940,$99E0,$9A80,$9B20,$9BC0,$9C60'

;-----------------------------------------------------------------------------
; MARK: Velocities
; Every 32 bytes represent a velocity at the 32 angles the player can fly.  These
; velocities are 0.5, 0.75, 1.0, 1.19, 1.5, 2.0 & 4.0
dt_velocity_x_frac      dc     i2'$8000,$7D8A,$7641,$6A6D,$5A82,$471C,$30FB,$18F8'
                        dc     i2'$0000,$E708,$CF05,$B8E4,$A57E,$9593,$89BF,$8276'
                        dc     i2'$8000,$8276,$89BF,$9593,$A57E,$B8E4,$CF05,$E708'
                        dc     i2'$0000,$18F8,$30FB,$471C,$5A82,$6A6D,$7641,$7D8A'
                        dc     i2'$C000,$BC4F,$B162,$9FA4,$87C3,$6AAB,$4979,$2575'
                        dc     i2'$0000,$DA8B,$B687,$9555,$783D,$605C,$4E9E,$43B1'
                        dc     i2'$4000,$43B1,$4E9E,$605C,$783D,$9555,$B687,$DA8B'
                        dc     i2'$0000,$2575,$4979,$6AAB,$87C3,$9FA4,$B162,$BC4F'
                        dc     i2'$0000,$FB14,$EC83,$D4DB,$B504,$8E39,$61F7,$31F1'
                        dc     i2'$0000,$CE0F,$9E09,$71C7,$4AFC,$2B25,$137D,$04EC'
                        dc     i2'$0000,$04EC,$137D,$2B25,$4AFC,$71C7,$9E09,$CE0F'
                        dc     i2'$0000,$31F1,$61F7,$8E39,$B504,$D4DB,$EC83,$FB14'
                        dc     i2'$30A3,$2AC9,$1973,$FD4C,$D769,$A93F,$7494,$3B6E'
                        dc     i2'$0000,$C492,$8B6C,$56C1,$2897,$02B4,$E68D,$D537'
                        dc     i2'$CF5D,$D537,$E68D,$02B4,$2897,$56C1,$8B6C,$C492'
                        dc     i2'$0000,$3B6E,$7494,$A93F,$D769,$FD4C,$1973,$2AC9'
                        dc     i2'$8000,$789F,$62C5,$3F48,$0F87,$D556,$92F3,$4AEA'
                        dc     i2'$0000,$B516,$6D0D,$2AAA,$F079,$C0B8,$9D3B,$8761'
                        dc     i2'$8000,$8761,$9D3B,$C0B8,$F079,$2AAA,$6D0D,$B516'
                        dc     i2'$0000,$4AEA,$92F3,$D556,$0F87,$3F48,$62C5,$789F'
                        dc     i2'$0000,$F629,$D906,$A9B6,$6A09,$1C73,$C3EF,$63E2'
                        dc     i2'$0000,$9C1E,$3C11,$E38D,$95F7,$564A,$26FA,$09D7'
                        dc     i2'$0000,$09D7,$26FA,$564A,$95F7,$E38D,$3C11,$9C1E'
                        dc     i2'$0000,$63E2,$C3EF,$1C73,$6A09,$A9B6,$D906,$F629'
                        dc     i2'$0000,$EC52,$B20D,$536C,$D413,$38E7,$87DE,$C7C5'
                        dc     i2'$0000,$383B,$7822,$C719,$2BED,$AC94,$4DF3,$13AE'
                        dc     i2'$0000,$13AE,$4DF3,$AC94,$2BED,$C719,$7822,$383B'
                        dc     i2'$0000,$C7C5,$87DE,$38E7,$D413,$536C,$B20D,$EC52'

dt_velocity_x           dc     i2'$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000'
                        dc     i2'$0000,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF'
                        dc     i2'$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF'
                        dc     i2'$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000'
                        dc     i2'$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000'
                        dc     i2'$0000,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF'
                        dc     i2'$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF'
                        dc     i2'$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000'
                        dc     i2'$0001,$0000,$0000,$0000,$0000,$0000,$0000,$0000'
                        dc     i2'$0000,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF'
                        dc     i2'$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF'
                        dc     i2'$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000'
                        dc     i2'$0001,$0001,$0001,$0000,$0000,$0000,$0000,$0000'
                        dc     i2'$0000,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFE,$FFFE'
                        dc     i2'$FFFE,$FFFE,$FFFE,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF'
                        dc     i2'$0000,$0000,$0000,$0000,$0000,$0000,$0001,$0001'
                        dc     i2'$0001,$0001,$0001,$0001,$0001,$0000,$0000,$0000'
                        dc     i2'$0000,$FFFF,$FFFF,$FFFF,$FFFE,$FFFE,$FFFE,$FFFE'
                        dc     i2'$FFFE,$FFFE,$FFFE,$FFFE,$FFFE,$FFFF,$FFFF,$FFFF'
                        dc     i2'$0000,$0000,$0000,$0000,$0001,$0001,$0001,$0001'
                        dc     i2'$0002,$0001,$0001,$0001,$0001,$0001,$0000,$0000'
                        dc     i2'$0000,$FFFF,$FFFF,$FFFE,$FFFE,$FFFE,$FFFE,$FFFE'
                        dc     i2'$FFFE,$FFFE,$FFFE,$FFFE,$FFFE,$FFFE,$FFFF,$FFFF'
                        dc     i2'$0000,$0000,$0000,$0001,$0001,$0001,$0001,$0001'
                        dc     i2'$0004,$0003,$0003,$0003,$0002,$0002,$0001,$0000'
                        dc     i2'$0000,$FFFF,$FFFE,$FFFD,$FFFD,$FFFC,$FFFC,$FFFC'
                        dc     i2'$FFFC,$FFFC,$FFFC,$FFFC,$FFFD,$FFFD,$FFFE,$FFFF'
                        dc     i2'$0000,$0000,$0001,$0002,$0002,$0003,$0003,$0003'

dt_velocity_y_frac      dc     i2'$0000,$18F8,$30FB,$471C,$5A82,$6A6D,$7641,$7D8A'
                        dc     i2'$8000,$7D8A,$7641,$6A6D,$5A82,$471C,$30FB,$18F8'
                        dc     i2'$0000,$E708,$CF05,$B8E4,$A57E,$9593,$89BF,$8276'
                        dc     i2'$8000,$8276,$89BF,$9593,$A57E,$B8E4,$CF05,$E708'
                        dc     i2'$0000,$2575,$4979,$6AAB,$87C3,$9FA4,$B162,$BC4F'
                        dc     i2'$C000,$BC4F,$B162,$9FA4,$87C3,$6AAB,$4979,$2575'
                        dc     i2'$0000,$DA8B,$B687,$9555,$783D,$605C,$4E9E,$43B1'
                        dc     i2'$4000,$43B1,$4E9E,$605C,$783D,$9555,$B687,$DA8B'
                        dc     i2'$0000,$31F1,$61F7,$8E39,$B504,$D4DB,$EC83,$FB14'
                        dc     i2'$0000,$FB14,$EC83,$D4DB,$B504,$8E39,$61F7,$31F1'
                        dc     i2'$0000,$CE0F,$9E09,$71C7,$4AFC,$2B25,$137D,$04EC'
                        dc     i2'$0000,$04EC,$137D,$2B25,$4AFC,$71C7,$9E09,$CE0F'
                        dc     i2'$0000,$3B6E,$7494,$A93F,$D769,$FD4C,$1973,$2AC9'
                        dc     i2'$30A3,$2AC9,$1973,$FD4C,$D769,$A93F,$7494,$3B6E'
                        dc     i2'$0000,$C492,$8B6C,$56C1,$2897,$02B4,$E68D,$D537'
                        dc     i2'$CF5D,$D537,$E68D,$02B4,$2897,$56C1,$8B6C,$C492'
                        dc     i2'$0000,$4AEA,$92F3,$D556,$0F87,$3F48,$62C5,$789F'
                        dc     i2'$8000,$789F,$62C5,$3F48,$0F87,$D556,$92F3,$4AEA'
                        dc     i2'$0000,$B516,$6D0D,$2AAA,$F079,$C0B8,$9D3B,$8761'
                        dc     i2'$8000,$8761,$9D3B,$C0B8,$F079,$2AAA,$6D0D,$B516'
                        dc     i2'$0000,$63E2,$C3EF,$1C73,$6A09,$A9B6,$D906,$F629'
                        dc     i2'$0000,$F629,$D906,$A9B6,$6A09,$1C73,$C3EF,$63E2'
                        dc     i2'$0000,$9C1E,$3C11,$E38D,$95F7,$564A,$26FA,$09D7'
                        dc     i2'$0000,$09D7,$26FA,$564A,$95F7,$E38D,$3C11,$9C1E'
                        dc     i2'$0000,$C7C5,$87DE,$38E7,$D413,$536C,$B20D,$EC52'
                        dc     i2'$0000,$EC52,$B20D,$536C,$D413,$38E7,$87DE,$C7C5'
                        dc     i2'$0000,$383B,$7822,$C719,$2BED,$AC94,$4DF3,$13AE'
                        dc     i2'$0000,$13AE,$4DF3,$AC94,$2BED,$C719,$7822,$383B'

dt_velocity_y           dc     i2'$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000'
                        dc     i2'$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000'
                        dc     i2'$0000,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF'
                        dc     i2'$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF'
                        dc     i2'$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000'
                        dc     i2'$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000'
                        dc     i2'$0000,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF'
                        dc     i2'$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF'
                        dc     i2'$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000'
                        dc     i2'$0001,$0000,$0000,$0000,$0000,$0000,$0000,$0000'
                        dc     i2'$0000,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF'
                        dc     i2'$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF'
                        dc     i2'$0000,$0000,$0000,$0000,$0000,$0000,$0001,$0001'
                        dc     i2'$0001,$0001,$0001,$0000,$0000,$0000,$0000,$0000'
                        dc     i2'$0000,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFE,$FFFE'
                        dc     i2'$FFFE,$FFFE,$FFFE,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF'
                        dc     i2'$0000,$0000,$0000,$0000,$0001,$0001,$0001,$0001'
                        dc     i2'$0001,$0001,$0001,$0001,$0001,$0000,$0000,$0000'
                        dc     i2'$0000,$FFFF,$FFFF,$FFFF,$FFFE,$FFFE,$FFFE,$FFFE'
                        dc     i2'$FFFE,$FFFE,$FFFE,$FFFE,$FFFE,$FFFF,$FFFF,$FFFF'
                        dc     i2'$0000,$0000,$0000,$0001,$0001,$0001,$0001,$0001'
                        dc     i2'$0002,$0001,$0001,$0001,$0001,$0001,$0000,$0000'
                        dc     i2'$0000,$FFFF,$FFFF,$FFFE,$FFFE,$FFFE,$FFFE,$FFFE'
                        dc     i2'$FFFE,$FFFE,$FFFE,$FFFE,$FFFE,$FFFE,$FFFF,$FFFF'
                        dc     i2'$0000,$0000,$0001,$0002,$0002,$0003,$0003,$0003'
                        dc     i2'$0004,$0003,$0003,$0003,$0002,$0002,$0001,$0000'
                        dc     i2'$0000,$FFFF,$FFFE,$FFFD,$FFFD,$FFFC,$FFFC,$FFFC'
                        dc     i2'$FFFC,$FFFC,$FFFC,$FFFC,$FFFD,$FFFD,$FFFE,$FFFF'

;-----------------------------------------------------------------------------
; MARK: Blank Fixes
at_blank_row8           dc     a2'blank8x8FailSafe'        ; Shouldn't be possible, just in case
                        dc     a2'skip8x8+3+42'
                        dc     a2'skip8x8+3+36'
                        dc     a2'skip8x8+3+30'
                        dc     a2'skip8x8+3+24'
                        dc     a2'skip8x8+3+18'
                        dc     a2'skip8x8+3+12'
                        dc     a2'skip8x8+3+6'
                        dc     a2'skip8x8+3+0'

at_blank_row12          dc     a2'blank12x16FailSafe'      ; Shouldn't be possible, just in case
                        dc     a2'skip12x16+3+105'
                        dc     a2'skip12x16+3+98'
                        dc     a2'skip12x16+3+91'
                        dc     a2'skip12x16+3+84'
                        dc     a2'skip12x16+3+77'
                        dc     a2'skip12x16+3+70'
                        dc     a2'skip12x16+3+63'
                        dc     a2'skip12x16+3+56'
                        dc     a2'skip12x16+3+49'
                        dc     a2'skip12x16+3+42'
                        dc     a2'skip12x16+3+35'
                        dc     a2'skip12x16+3+28'
                        dc     a2'skip12x16+3+21'
                        dc     a2'skip12x16+3+14'
                        dc     a2'skip12x16+3+7'
                        dc     a2'skip12x16+3+0'

at_blank_row16          dc     a2'blank16x16FailSafe'      ; Shouldn't be possible, just in case
                        dc     a2'skip16x16+3+120'
                        dc     a2'skip16x16+3+112'
                        dc     a2'skip16x16+3+104'
                        dc     a2'skip16x16+3+96'
                        dc     a2'skip16x16+3+88'
                        dc     a2'skip16x16+3+80'
                        dc     a2'skip16x16+3+72'
                        dc     a2'skip16x16+3+64'
                        dc     a2'skip16x16+3+56'
                        dc     a2'skip16x16+3+48'
                        dc     a2'skip16x16+3+40'
                        dc     a2'skip16x16+3+32'
                        dc     a2'skip16x16+3+24'
                        dc     a2'skip16x16+3+16'
                        dc     a2'skip16x16+3+8'
                        dc     a2'skip16x16+3+0'

at_blank_row20          dc     a2'blank20x16FailSafe'      ; Shouldn't be possible, just in case
                        dc     a2'skip20x16+3+135'
                        dc     a2'skip20x16+3+126'
                        dc     a2'skip20x16+3+117'
                        dc     a2'skip20x16+3+108'
                        dc     a2'skip20x16+3+99'
                        dc     a2'skip20x16+3+90'
                        dc     a2'skip20x16+3+81'
                        dc     a2'skip20x16+3+72'
                        dc     a2'skip20x16+3+63'
                        dc     a2'skip20x16+3+54'
                        dc     a2'skip20x16+3+45'
                        dc     a2'skip20x16+3+36'
                        dc     a2'skip20x16+3+27'
                        dc     a2'skip20x16+3+18'
                        dc     a2'skip20x16+3+9'
                        dc     a2'skip20x16+3+0'

at_blank_row28          dc     a2'blank28x16FailSafe'      ; Shouldn't be possible, just in case
                        dc     a2'skip28x16+3+165'
                        dc     a2'skip28x16+3+154'
                        dc     a2'skip28x16+3+143'
                        dc     a2'skip28x16+3+132'
                        dc     a2'skip28x16+3+121'
                        dc     a2'skip28x16+3+110'
                        dc     a2'skip28x16+3+99'
                        dc     a2'skip28x16+3+88'
                        dc     a2'skip28x16+3+77'
                        dc     a2'skip28x16+3+66'
                        dc     a2'skip28x16+3+55'
                        dc     a2'skip28x16+3+44'
                        dc     a2'skip28x16+3+33'
                        dc     a2'skip28x16+3+22'
                        dc     a2'skip28x16+3+11'
                        dc     a2'skip28x16+3+0'

at_blank_row32          dc     a2'blank32x16FailSafe'      ; Shouldn't be possible, just in case
                        dc     a2'skip32x16+3+180'
                        dc     a2'skip32x16+3+168'
                        dc     a2'skip32x16+3+156'
                        dc     a2'skip32x16+3+144'
                        dc     a2'skip32x16+3+132'
                        dc     a2'skip32x16+3+120'
                        dc     a2'skip32x16+3+108'
                        dc     a2'skip32x16+3+96'
                        dc     a2'skip32x16+3+84'
                        dc     a2'skip32x16+3+72'
                        dc     a2'skip32x16+3+60'
                        dc     a2'skip32x16+3+48'
                        dc     a2'skip32x16+3+36'
                        dc     a2'skip32x16+3+24'
                        dc     a2'skip32x16+3+12'
                        dc     a2'skip32x16+3+0'

;-----------------------------------------------------------------------------
; MARK: Column Fixes
; Depending on the width of the clipped sprite being drawn, look up
; where to jump to in the screenDrawPartial function to draw the right number of
; columns
at_col_jump_draw        dc     a2'noCols'
                        dc     a2'cols00'
                        dc     a2'cols02'
                        dc     a2'cols04'
                        dc     a2'cols06'
                        dc     a2'cols08'
                        dc     a2'cols10'
                        dc     a2'cols12'
                        dc     a2'cols14'
                        dc     a2'cols16'
                        dc     a2'cols18'
                        dc     a2'cols20'

; Depending on the width of the clipped sprite being erased, look up
; where to jump to in the screenErasePartial function to erase the right number of
; columns
at_col_jump_erase       dc     a2'ienoCols'
                        dc     a2'iecols00'
                        dc     a2'iecols02'
                        dc     a2'iecols04'
                        dc     a2'iecols06'
                        dc     a2'iecols08'
                        dc     a2'iecols10'
                        dc     a2'iecols12'
                        dc     a2'iecols14'
                        dc     a2'iecols16'
                        dc     a2'iecols18'
                        dc     a2'iecols20'

;-----------------------------------------------------------------------------
; MARK: Colors
; palette is gb0r
dt_color_palette        dc     h'0000FF0F000FCF00'         ; Black,White,Red,Cyan
                        dc     h'0C0CC0005F00F00F'         ; Magenta,Green,Blue,Yellow
                        dc     h'800F880800088006'         ; Orange,Gray,Dark Red,Olive Green
                        dc     h'B00B000000000A00'         ; Dark Yellow,Prop 0, Prop 1, Dark Blue (Sky)

dt_color_palette_prop   dc     h'8006'                     ; TIME_PERIOD0_1910
                        dc     h'000F'                     ; TIME_PERIOD1_1940
                        dc     h'CF00'                     ; TIME_PERIOD2_1970

dt_color_palette_sky    dc     h'0600'                     ; TIME_PERIOD0_1910
                        dc     h'5600'                     ; TIME_PERIOD1_1940
                        dc     h'6500'                     ; TIME_PERIOD2_1970
                        dc     h'0505'                     ; TIME_PERIOD3_1982
                        dc     h'0000'                     ; TIME_PERIOD4_2001

;-----------------------------------------------------------------------------
; MARK: Multiplication
dt_mult_4               dc     i2'0,4,8,12,16,20,24,28,32,36,40,44,48,52,56,60'
dt_mult_6               dc     i2'0,6,12,18,24,30,36,42,48,54,60,66,72,78,84,90'
dt_mult_8               dc     i2'0,8,16,24,32,40,48,56,64,72,80,88,96,104,112,120'
dt_mult_10              dc     i2'0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150'
dt_mult_14              dc     i2'0,14,28,42,56,70,84,98,112,126,140,154,168,182,196,210'
dt_mult_15              dc     i2'0,15,30,45,60,75,90,105,120,135,150,165,180,195,210,225'
dt_mult_16              dc     i2'0,16,32,48,64,80,96,112,128,144,160,176,192,208,224,240'
dt_mult_23              dc     i2'0,23,46,69,92,115,138,161,184,207,230,253,276,299,322,345'

;-----------------------------------------------------------------------------
; MARK: Helper Maps
; The movement mask & 15 indexes into this to see the desired playerAngle. -1 is not valid
dt_angles_joystick      dc     i2'-1,48,0,56,16,-1,8,-1'
                        dc     i2'32,40,-1,-1,24,-1,-1,-1'

dt_heli_frames          dc     i2'0,0,2,2,4,4,6,6'
                        dc     i2'8,10,10,12,12,14,14,16'
                        dc     i2'16,16,14,14,12,12,10,10'
                        dc     i2'8,6,6,4,4,2,2,0'

dt_scores_bonus         dc     h'100020003000400050001500'

;-----------------------------------------------------------------------------
; MARK: UI
dt_ui_initials_y        dc     i2'(8*160+10)*8'
                        dc     i2'(10*160+10)*8'
                        dc     i2'(12*160+10)*8'
                        dc     i2'(14*160+10)*8'
                        dc     i2'(16*160+10)*8'

;-----------------------------------------------------------------------------
; MARK: highscoreData
proCREATEHS             entry
                        dc     i2'7'
                        dc     a4'pHIGHSCORE2'
                        dc     i2'$00C3'
                        dc     i2'$005D'
                        dc     i4'$00008023'
                        ds     2
                        ds     4
                        ds     4

proDESTROYHS            entry
                        dc     i2'1'
                        dc     a4'pHIGHSCORE2'

proOPENHS               entry
                        dc     i2'2'
                        ds     2
                        dc     a4'pHIGHSCORE2'

proREADHS1              entry
                        dc     i2'4'
                        ds     2
                        dc     a4'TEXT_HIGH_AV'
                        dc     i4'67'
                        ds     4

proREADHS2              entry
                        dc     i2'4'
                        ds     2
                        dc     a4'highScoreTableStart'
                        dc     i4'12'
                        ds     4

proCLOSEHS              entry
                        dc     i2'1'
                        ds     2

pHIGHSCORE2             dc     i2'11',c'1/highscore'

;-----------------------------------------------------------------------------
; MARK: replayData
                        aif    &R_RECORD>0,.gsiRecordFile
                        ago    .gsiSkipRecordFile
.gsiRecordFile
createFileData          dc     a4'createName'
                        dc     i2'195'                     ; access $C3
                        dc     i2'6'                       ; FileType
                        dc     i4'0'                       ; AuxType
                        dc     i2'3'                       ; StorageType
                        dc     i2'0'                       ; CreateDate
                        dc     i2'0'                       ; CreateTime
createName              dc     i1'createEnd-createName-1'
                        dc     c'1/REPLAY.0000'
createEnd               anop

openFileData            dc     i2'0'                       ; Ref
                        dc     i4'createName'              ; Name
                        dc     a4'0'                       ; IO Buffer
openEnd                 anop

writeFileData           dc     i2'0'                       ; Ref
                        dc     i4'dt_demo_buffer'
writeLen                dc     i2'0'                       ; Length to write
                        dc     i4'0'                       ; Length written
.gsiSkipRecordFile

;-----------------------------------------------------------------------------
; MARK: dt_demo_buffer
; Replay data
dt_demo_buffer          anop
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000001010101010'
                        dc     h'10101010101010101010101010101010'
                        dc     h'10101010101010101010101000000000'
                        dc     h'20202020202020202020202020202020'
                        dc     h'20202020202020202020202020202020'
                        dc     h'20202020202020200000002020202020'
                        dc     h'20202020202020202060200000105010'
                        dc     h'10105010101010100000000000004000'
                        dc     h'20202020602020202060000000501010'
                        dc     h'10501010000000000000006020202020'
                        dc     h'60202020204000000000501010000000'
                        dc     h'00000000206020200000400000202020'
                        dc     h'00000000000020602000000040101010'
                        dc     h'10501010105010101010501010100040'
                        dc     h'00101010501010101050101010105010'
                        dc     h'10101010100000000040101010101050'
                        dc     h'10101010501010104000000060202020'
                        dc     h'20206020000000400000101050101010'
                        dc     h'10105010101010501010101050101010'
                        dc     h'50101000000000004000000020206020'
                        dc     h'20202060000000004020202020206020'
                        dc     h'00000040000000400000004000000000'
                        dc     h'40000000400000004000202020202020'
                        dc     h'20602000000000004010101010105010'
                        dc     h'10101010400000000000000000000000'
                        dc     h'00004000000000000000002020200000'
                        dc     h'00000000000000000000000000002060'
                        dc     h'20202060202020206020200000400000'
                        dc     h'10501010101050101000005010101000'
                        dc     h'40000010501010101010500000000060'
                        dc     h'20202020602020202060202020206020'
                        dc     h'20200040202020206020202000000000'
                        dc     h'40000000000000004000000000101050'
                        dc     h'10101010501010100000400000000040'
                        dc     h'00000000402020202060000040002020'
                        dc     h'20206020202020202020206020202020'
                        dc     h'60202020206020202000400000000040'
                        dc     h'00101010105000000040000000202060'
                        dc     h'20202020602020200000400000000020'
                        dc     h'60202020200040000000000000000040'
                        dc     h'00000000004000000000000060200000'
                        dc     h'00105010101010501010101050101010'
                        dc     h'00000040001010105010101010501010'
                        dc     h'10105010101010101050101010105010'
                        dc     h'10000040202020602020202060202020'
                        dc     h'20206020000000000040000000000000'
                        dc     h'00000000000000001010104000000000'
                        dc     h'40202020004000000000400000001050'
                        dc     h'10101010501010101050000000000060'
                        dc     h'20202020202060202020206020202020'
                        dc     h'60202020206020202020204000000000'
                        dc     h'50101010105000000000400000000040'
                        dc     h'00202020204000000010501000000040'
                        dc     h'00002020602020202060202020206000'
                        dc     h'00000040000000000040000000000000'
                        dc     h'40000000004000002020602020202020'
                        dc     h'60202020206020000000004000000000'
                        dc     h'20602020202060202020206020200000'
                        dc     h'00400000000040101010105010101000'
                        dc     h'00400000000000401000000000000000'
                        dc     h'50101010101010004000000000400000'
                        dc     h'00005010101010501010101050000000'
                        dc     h'00004000202020206000000000602020'
                        dc     h'20202060202020400000000040000020'
                        dc     h'20206020202020602020202060202020'
                        dc     h'20602000000000000000000020206020'
                        dc     h'20202060202020202060202020602020'
                        dc     h'20202060202020202060000000000040'
                        dc     h'00000000000010101010400000000000'
                        dc     h'00501000000000400000000040202020'
                        dc     h'20602020206020000000400000000000'
                        dc     h'00004010101010105010101010105010'
                        dc     h'10101040000000000050101010100040'
                        dc     h'00000000005010101010501010101050'
                        dc     h'10000000006020202020602020202060'
                        dc     h'20200000400000202060202020206020'
                        dc     h'00000010105010101010501000004000'
                        dc     h'00000040002020206000000050101010'
                        dc     h'10400000004000202020602020200040'
                        dc     h'10101010501010101050101010004000'
                        dc     h'10101050000000602020202060202020'
                        dc     h'20000000105010101050101010105000'
                        dc     h'00000020602020202020202000000040'
                        dc     h'00000000602020202060202020602020'
                        dc     h'20206020202060202020206020202060'
                        dc     h'20202020600000002060202020602020'
                        dc     h'20202060202020602020202060202020'
                        dc     h'20602020000040000000004020202020'
                        dc     h'40000000501010101050000000004000'
                        dc     h'00004020202020600000000050101000'
                        dc     h'00400000004020202020602020206020'
                        dc     h'20202060202020206020202020206020'
                        dc     h'20200040000040000010105010000000'
                        dc     h'40000000400000101050100000004000'
                        dc     h'00004000000040000000400000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
                        dc     h'00000000000000000000000000000000'
thisisformatgamedata__  anop
                        END
