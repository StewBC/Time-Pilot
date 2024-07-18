;-----------------------------------------------------------------------------
; screen.asm
; Part of Time Pilot, the 1982 arcade game remake for the Apple IIgs
;
; Stefan Wessels, 2024
; This is free and unencumbered software released into the public domain.
;-----------------------------------------------------------------------------

                        copy    src/globals.s
                        mcopy   src/screen.mac

SCREEN                  START

                        using   GAMEDATA
                        using   VARIABLES

;-----------------------------------------------------------------------------
ptCounter               equ     zTemp00
ptE2                    equ     zTemp01
ptX0                    equ     zTemp02
ptX1                    equ     zTemp03
ptY0                    equ     zTemp04
ptY1                    equ     zTemp05

;-----------------------------------------------------------------------------
; In A = Palette color index
; MARK: screenClear
screenClear             entry
                        ldx     #SCREEN_BYTES-2                 ; start at last visible byte
scWrite                 sta     SCREEN_BASE,x                   ; write the palette color index to the screen
                        dex
                        dex
                        bpl     scWrite
                        rts

;-----------------------------------------------------------------------------
; IN: X bottom right corner relative to $2000 (pixels/2),
;     Y width of box (in pixels/2),
;     A height of box (in pixel rows)
; Area to clear must be even bound start and multiple of 2 bytes wide
; clears area to zSkyColor
; MARK: screenClearSection
screenClearSection      entry
tscsAreaHeight          equ     zTemp10
tscsAreaWidth           equ     zTemp11
tscsAreaStride          equ     zTemp12
                        sta     tscsAreaHeight
                        sty     tscsAreaWidth
                        lda     #SCREENW/4
                        sec
                        sbc     tscsAreaWidth
                        asl     a
                        sta     tscsAreaStride

scsLoopOuter            ldy     tscsAreaWidth
                        lda     zSkyColor
scsLoop                 sta     SCREEN_BASE,x
                        dex
                        dex
                        dey
                        bne     scsLoop
                        txa
                        sec
                        sbc     tscsAreaStride
                        tax
                        dec     tscsAreaHeight
                        bne     scsLoopOuter
                        rts

;-----------------------------------------------------------------------------
; MARK: screenClips
screenClips             entry
tscClipMask             equ     zTemp01                         ; matches ptScreenClips in draw
                        stz     tscClipMask                     ; start with no clipping
                        lda     activeMinY,x
                        bpl     scCheckBotY                     ; if minY > 0 then not clipping top
                        lda     activeMaxY,x
                        bmi     scOffScreen                     ; if maxY is also <= 0 then not visible
                        beq     scOffScreen
                        lda     #AF_CLIPTY                      ; mark as clips at the top
                        sta     tscClipMask
                        bra     scCheckLeftX
scOffScreen             lda     #AF_CLIPMASK                    ; mark as not visible at all
                        sta     tscClipMask
                        rts
scCheckBotY             lda     activeMaxY,x                    ; check max first because most likely on screen
                        cmp     #SCREEN_PBOTTOM                 ; if maxY > bottom then clips at bottom
                        bmi     scCheckLeftX
                        lda     activeMinY,x                    ; see if the minY also > bottom, then off screen
                        cmp     #SCREEN_PBOTTOM
                        bpl     scOffScreen
                        lda     #AF_CLIPBY                      ; mark as clipping at the bottom
                        sta     tscClipMask
scCheckLeftX            lda     activeMinX,x
                        bpl     scCheckRightX                   ; if minX > 0 then not clipping left
                        lda     activeMaxX,x
                        bmi     scOffScreen                     ; if maxX also <= 0 then off screen
                        beq     scOffScreen
                        lda     #AF_CLIPLX                      ; mark as clipping on the left
scSet                   ora     tscClipMask                     ; retain any Y clips
                        sta     tscClipMask
                        rts
scCheckRightX           lda     activeMaxX,x
                        cmp     #SCREEN_PRIGHT
                        bmi     scReturn                        ; if maxX < screen right then doesn't clip right
                        lda     activeMinX,x
                        cmp     #SCREEN_PRIGHT
                        bpl     scOffScreen                     ; if minX also > screen right then off screen
                        lda     #AF_CLIPRX                      ; mark as clips right
                        ora     tscClipMask                     ; retaining any Y clips
                        sta     tscClipMask
scReturn                rts

;-----------------------------------------------------------------------------
; $c019 (VBL) - high bit set means vbl is in effect
; MARK: screenDelay
screenDelay             entry
                        short   m
sdLoop0                 lda     VBL
                        bmi     sdLoop0
sdLoop1                 lda     VBL
                        bpl     sdLoop1
                        long    m
                        rts

;-----------------------------------------------------------------------------
; MARK: screenDrawLine
screenDrawLine          entry
tDX                     equ     zTemp06
tDY                     equ     zTemp07
tErr                    equ     zTemp08
tSlX                    equ     zTemp09
tSlY                    equ     zTemp10
                        ldy     #1                              ; assume tSlX = 1
                        sec
                        lda     ptX1                            ; tDX
                        sbc     ptX0
                        bcs     sdl00                           ; if negative
                        eor     #$ffff                          ; abs
                        adc     #1
                        ldy     #$ffff                          ; tSlX=-1
sdl00                   sta     tDX
                        sty     tSlX
                        ldy     #$ffff                          ; assume tSlY=-1
                        sec
                        lda     ptY1
                        sbc     ptY0
                        bcc     sdl01                           ; if negative
                        clc                                     ; else -abs to make negative
                        eor     #$ffff
                        adc     #1
                        ldy     #1                              ; tSlY=1
sdl01                   sta     tDY                             ; tDY is -abs()
                        sty     tSlY
                        clc
                        adc     tDX
                        sta     tErr                            ; tErr = tDY+tDX
sdlLoop                 jsr     screenSetPixels                 ; draw a block
                        lda     ptX0                            ; see if done
                        cmp     ptX1
                        bne     sdlNotDone
                        lda     ptY0
                        cmp     ptY1
                        bne     sdlNotDone
                        rts                                     ; done
sdlNotDone              lda     tErr                            ; ptE2 = 2*tErr
                        asl     a
                        sta     ptE2
                        sec
                        sbc     tDY                             ; ptE2 - tDY positive or 0 then step x
                        beq     sdlChkXstep
                        bmi     sdlChkYstep
sdlChkXstep             clc
                        lda     tDY                             ; tErr += tDY
                        adc     tErr
                        sta     tErr
                        clc
                        lda     tSlX                            ; ptX0 += tSlX
                        adc     ptX0
                        sta     ptX0
sdlChkYstep             sec
                        lda     ptE2
                        sbc     tDX                             ; ptE2 - tDX negative or 0 then step y
                        beq     sdlStepY
                        bpl     sdlLoop                         ; otherwise sdlLoop to plot
sdlStepY                clc
                        lda     tDX                             ; tErr += tDX
                        adc     tErr
                        sta     tErr
                        clc
                        lda     tSlY                            ; ptY0 += tSlY
                        adc     ptY0
                        sta     ptY0
                        bra     sdlLoop

;-----------------------------------------------------------------------------
; MARK: screenDrawPartial
screenDrawPartial       entry
                        clc
                        sei                                     ; disable Interrupts
                        phb                                     ; save the data bank
                        phd                                     ; save the DP address
                        lda     zSpriteDataBank
                        short   m
                        pha
                        long    m
                        plb

                        lda     zImageAddressPdpB1
                        pha
                        pld
                        tsc                                     ; backup Stack
                        sta     >stackAddress
                        lda     STATEREG                        ; direct Page and Stack in Bank 01/
                        ora     #$0030
                        sta     STATEREG
                        lda     dpB1screenAddress
                        tcs                                     ; new Stack address
                        jmp     ifreturn
;---
remainder               entry
                        short   m
                        lda     [dpB1screenAddress],y
                        and     (dpB1maskAddress),y
                        ora     (dpB1imageAddress),y
                        sta     [dpB1screenAddress],y
                        long    m
remainderexit           entry
                        jmp     cols00                          ; self modifying code sets this

cols20                  entry
                        dey
                        dey
                        lda     $14,s
                        and     (dpB1maskAddress),y
                        ora     (dpB1imageAddress),y
                        sta     $14,s
cols18                  entry
                        dey
                        dey
                        lda     $12,s
                        and     (dpB1maskAddress),y
                        ora     (dpB1imageAddress),y
                        sta     $12,s
cols16                  entry
                        dey
                        dey
                        lda     $10,s
                        and     (dpB1maskAddress),y
                        ora     (dpB1imageAddress),y
                        sta     $10,s
cols14                  entry
                        dey
                        dey
                        lda     $0E,s
                        and     (dpB1maskAddress),y
                        ora     (dpB1imageAddress),y
                        sta     $0E,s
cols12                  entry
                        dey
                        dey
                        lda     $0C,s
                        and     (dpB1maskAddress),y
                        ora     (dpB1imageAddress),y
                        sta     $0C,s
cols10                  entry
                        dey
                        dey
                        lda     $0A,s
                        and     (dpB1maskAddress),y
                        ora     (dpB1imageAddress),y
                        sta     $0A,s
cols08                  entry
                        dey
                        dey
                        lda     $08,s
                        and     (dpB1maskAddress),y
                        ora     (dpB1imageAddress),y
                        sta     $08,s
cols06                  entry
                        dey
                        dey
                        lda     $06,s
                        and     (dpB1maskAddress),y
                        ora     (dpB1imageAddress),y
                        sta     $06,s
cols04                  entry
                        dey
                        dey
                        lda     $04,s
                        and     (dpB1maskAddress),y
                        ora     (dpB1imageAddress),y
                        sta     $04,s
cols02                  entry
                        dey
                        dey
                        lda     $02,s
                        and     (dpB1maskAddress),y
                        ora     (dpB1imageAddress),y
                        sta     $02,s
cols00                  entry
                        dey
                        dey
                        lda     $00,s
                        and     (dpB1maskAddress),y
                        ora     (dpB1imageAddress),y
                        sta     $00,s
;---
noCols                  entry
                        dec     dpB1imageVisibleHeight
                        beq     ifdone
;---
                        tsc
                        adc     #$a0
                        tcs
                        sta     dpB1screenAddress
                        lda     dpB1maskAddress
                        adc     dpB1imageDataWidth
                        sta     dpB1maskAddress
                        lda     dpB1imageAddress
                        adc     dpB1imageDataWidth
                        sta     dpB1imageAddress
ifreturn                entry
                        ldy     dpB1imageVisibleWidth
ifreturnAddress         entry
                        jmp     remainder                       ; self modifying code sets this

;---
ifdone                  lda     STATEREG                        ; direct Page and Stack in Bank 00/
                        and     #$FFCF
                        sta     STATEREG
                        lda     >stackAddress                   ; restore Stack
                        tcs
                        pld                                     ; restore the DP address
                        plb                                     ; restore the data bank
                        cli                                     ; enable Interrupts
                        rts

;-----------------------------------------------------------------------------
; MARK: screenErasePartial
screenErasePartial      entry
                        sei                                     ; disable Interrupts
                        phd                                     ; save the DP address
                        lda     zImageAddressPdpB1
                        pha
                        pld
                        tsc                                     ; backup Stack
                        sta     stackAddress
                        lda     STATEREG                        ; direct Page and Stack in Bank 01/
                        ora     #$0030
                        sta     STATEREG
                        lda     dpB1screenAddress
                        tcs                                     ; new Stack address
                        ldy     dpB1imageVisibleWidth
                        ldx     #$FFFF                          ; palette index to erase to
                        jmp     iereturn
ieremainder             entry
                        short   m
                        sta     [dpB1screenAddress],y
                        long    m
ieremainderexit         entry
                        jmp     iecols00
iecols20                entry
                        sta     $14,s
iecols18                entry
                        sta     $12,s
iecols16                entry
                        sta     $10,s
iecols14                entry
                        sta     $0E,s
iecols12                entry
                        sta     $0C,s
iecols10                entry
                        sta     $0A,s
iecols08                entry
                        sta     $08,s
iecols06                entry
                        sta     $06,s
iecols04                entry
                        sta     $04,s
iecols02                entry
                        sta     $02,s
iecols00                entry
                        sta     $00,s
ienoCols                entry
                        dec     dpB1imageVisibleHeight
                        beq     iedone
                        lda     dpB1screenAddress
                        adc     #$A0
                        sta     dpB1screenAddress
                        tcs
iereturn                entry
                        txa
iereturnAddress         entry
                        jmp     ieremainder
iedone                  lda     STATEREG                        ; direct Page and Stack in Bank00/
                        and     #$FFCF
                        sta     STATEREG
                        lda     stackAddress                    ; restore Stack
                        tcs
                        pld                                     ; restore the DP address
                        cli                                     ; enable Interrupts
                        rts

;-----------------------------------------------------------------------------
; MARK: screenInit
screenInit              entry
                        short   m
                        lda     #0
                        sta     SHADOWR                         ; shadowing ON
                        long    m
                        lda     #0
                        ldx     #SCREEN_BYTES-2
siClr                   sta     SCREEN_BASE,x
                        dex
                        dex
                        bpl     siClr
                        lda     BORDER
                        sta     originalBorder
                        lda     #COLOR_BLACK
                        sta     BORDER
                        lda     #0                              ; clear B of accumulator
                        ldx     #$FE
siClearSCB              sta     SCANLINE_CONTROL_BYTE,x         ; 19D00-19DFF set to 0
                        dex
                        dex
                        bpl     siClearSCB
                        ldx     #30                             ; 16 colors, 2 byes each 0 based [0,31]
siPalloop               lda     dt_color_palette,x
                        sta     PALETTE_BASE,x
                        dex
                        dex
                        bpl     siPalloop                       ; copy till 0/1 was written
                        rts

;-----------------------------------------------------------------------------
; Sets an 8x8 block of pixels in 8x8 coordinates at x0,y0 in zSkyColor
; MARK: screenSetPixels
screenSetPixels         entry
                        lda     ptY0
                        asl     a                               ; y0 * 8 for 8 rows per "pixel"
                        asl     a
                        asl     a
                        asl     a                               ; and * 2 for 2 bytes/screen row
                        tay
                        lda     dt_screen_rows,y                ; base row address
                        sta     ptE2                            ; re-use
                        lda     ptX0
                        asl     a                               ; x0 * 4 for byte where x0's pixels start (2 pixels/byte)
                        asl     a
                        adc     ptE2                            ; add row base
                        tax
                        ldy     #8                              ; draw 8 rows
sspLoop                 lda     zSkyColor                       ; in this color
                        sta     SCREEN_ROW_BASE,x               ; set 4 pixels (2 bytes written)
                        inx                                     ; move up 2 bytes
                        inx
                        sta     SCREEN_ROW_BASE,x               ; set 4 more pixels
                        dey                                     ; one less row to do
                        beq     sspDone                         ; if at zero then done
                        txa
                        clc                                     ; move to the next row (stride is 160 bytes)
                        adc     #160-2                          ; minus the 2 already moved
                        tax
                        bra     sspLoop
sspDone                 rts

;-----------------------------------------------------------------------------
; MARK: screenTimeWarp
screenTimeWarp          entry
tXposIndex              equ     zTemp00
tLength                 equ     zTemp01
tScriptIndex            equ     zTemp02
                        lda     #AUDIO_TIMEWARP
                        sta     zAudioTimeWarp
                        jsr     audioPlaySource
                        lda     #32                             ; erase 16 lines
                        sta     zRowsToErase
                        lda     zPlayerAngle                    ; get the frame the player is holding
                        tax
                        lda     st_player,x
                        sta     stwDrawPlayer+1                 ; self modify to draw that frame
                        ldx     #0                              ; script index starts at 0
stwDrawLoop             lda     script_timewarp_draw,x          ; load the position index for where to render
                        bmi     stwSeqEnd                       ; if -1 that ends this sequence
stwNextStep             sta     tXposIndex                      ; save index
                        inx
                        inx
                        lda     script_timewarp_draw,x          ; get the length to repeat the frame
                        sta     tLength
                        inx
                        inx
                        lda     script_timewarp_draw,x          ; get the frame to show
                        inx
                        inx
                        stx     tScriptIndex                    ; save the script index
                        tax
                        lda     st_timewarp,x                   ; look up the frame address
                        sta     stwDraw+1                       ; self-modify to that address
stwInnerDraw            ldx     tXposIndex                      ; get the position index
                        lda     dt_timewarp_pos_x,x             ; get the position (X pos)
                        tay                                     ; put in Y for where to draw
stwDraw                 jsl     TIMEWARP_000A                   ; draw the frame
                        inc     tXposIndex                      ; move to next X pos index
                        inc     tXposIndex
                        dec     tLength                         ; done one frame
                        bne     stwInnerDraw                    ; for total length of this frame
                        ldx     tScriptIndex                    ; do next step in this sequence
                        bra     stwDrawLoop
stwSeqEnd               ldy     #$2000+PLAYER_Y*160+PLAYER_X/2
stwDrawPlayer           jsl     PLAYER_000A                     ; show the player
                        jsr     screenDelay                     ; hold for 2 frames
                        jsr     screenDelay
                        ldx     #0                              ; erase 13 16x16 blocks (the warp)
stwEraseInner           stx     tXposIndex
                        lda     dt_timewarp_pos_x,x
                        tay
                        jsr     blank16x16
                        inc     tXposIndex
                        inc     tXposIndex
                        ldx     tXposIndex
                        cpx     #26
                        bne     stwEraseInner
stwPostErase            jsr     screenDelay                     ; hold blank for 2 frames
                        jsr     screenDelay
                        inc     tScriptIndex                    ; next script instruction
                        inc     tScriptIndex
                        ldx     tScriptIndex
                        lda     script_timewarp_draw,x          ; read instruction
                        bpl     stwNextStep                     ; if not -1 start the sequence
stwDoneX                rts

;-----------------------------------------------------------------------------
; Wipe the screen in an 8x8 block fashion, anti-clockwise
; IN: zSkyColor must be set
; MARK: screenWipe
screenWipe              entry
                        lda     #13
                        sta     ptCounter
swQ0                    lda     #13
                        sta     ptX0
                        lda     #12
                        sta     ptY0
                        lda     ptCounter
                        sta     ptX1
                        lda     #0
                        sta     ptY1
                        jsr     screenDrawLine
                        ldx     #$0001
                        jsr     screenDelay
                        dec     ptCounter
                        bpl     swQ0
                        lda     #1
                        sta     ptCounter
swQ1                    lda     #13
                        sta     ptX0
                        lda     #12
                        sta     ptY0
                        lda     #0
                        sta     ptX1
                        lda     ptCounter
                        sta     ptY1
                        jsr     screenDrawLine
                        ldx     #$0001
                        jsr     screenDelay
                        inc     ptCounter
                        lda     ptCounter
                        cmp     #25
                        bne     swQ1
                        lda     #1
swQ2                    sta     ptCounter
                        lda     #13
                        sta     ptX0
                        lda     #12
                        sta     ptY0
                        lda     ptCounter
                        sta     ptX1
                        lda     #24
                        sta     ptY1
                        jsr     screenDrawLine
                        ldx     #$0001
                        jsr     screenDelay
                        lda     ptCounter
                        ina
                        cmp     #14
                        bne     swQ2
swQ3                    sta     ptCounter
                        lda     #14
                        sta     ptX0
                        lda     #12
                        sta     ptY0
                        lda     ptCounter
                        sta     ptX1
                        lda     #24
                        sta     ptY1
                        jsr     screenDrawLine
                        ldx     #$0001
                        jsr     screenDelay
                        lda     ptCounter
                        ina
                        cmp     #28
                        bne     swQ3
                        lda     #23
swQ4                    sta     ptCounter
                        lda     #14
                        sta     ptX0
                        lda     #12
                        sta     ptY0
                        lda     #27
                        sta     ptX1
                        lda     ptCounter
                        sta     ptY1
                        jsr     screenDrawLine
                        ldx     #$0001
                        jsr     screenDelay
                        lda     ptCounter
                        dea
                        bpl     swQ4
                        lda     #26
swQ5                    sta     ptCounter
                        lda     #14
                        sta     ptX0
                        lda     #12
                        sta     ptY0
                        lda     ptCounter
                        sta     ptX1
                        lda     #0
                        sta     ptY1
                        jsr     screenDrawLine
                        ldx     #$0001
                        jsr     screenDelay
                        lda     ptCounter
                        dea
                        cmp     #13
                        bne     swQ5
                        rts

;-----------------------------------------------------------------------------
; Set the Sky Color and palette, and then screenWipe
; This wipes to the sky, but in PROP1 palette
; and then it updates the screen, post 1, to SKY palette
; Two stages needed otherwise the sky wil "snap" as soon
; as the sky palette is modifies.  Prop 1 is always
; available at the time the wipe is called
; IN: stage/period (for sky color to activate) in X
; MARK: screenWipeToStageSky
screenWipeToStageSky    entry
                        stx     zActiveSky                      ; remember the new stage
                        lda     dt_color_palette_sky,x          ; get the sky color
                        ldx     #COLOR_PROP1*2                  ; put it into prop 1
                        sta     PALETTE_BASE,x
                        LDAPAL  COLOR_PROP1                     ; get the palette entry for prop1
                        sta     zSkyColor                       ; set prop1 as the sky color
                        jsr     screenWipe                      ; wipe to prop 1

                        ldx     #COLOR_PROP1*2                  ; move the sky color
                        lda     PALETTE_BASE,x                  ; from prop 1
                        ldx     #COLOR_SKY*2                    ; move the sky color
                        sta     PALETTE_BASE,x

                        LDAPAL  COLOR_SKY                       ; get the palette entry for sky
                        sta     zSkyColor                       ; set that as the sky
                        LDBOX   0,0,PLAYFIELDW,PLAYFIELDH       ; clear the playfield to sky now
                        jmp     screenClearSection

thisisaformattinglabel  anop
                        END
