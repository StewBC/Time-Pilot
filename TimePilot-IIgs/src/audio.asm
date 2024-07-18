;
; Sounds for Time Pilot
;
; (c) 2024, Brutal Deluxe Software
;

                        copy        src/globals.s
                        mcopy       src/audio.mac

AUDIO                   START
                        USING       SOUNDDATAAREA
                        USING       AUDIODATA

;-----------------------------------
; SOFTSWITCHES
;-----------------------------------

SOUNDCTL                equ         $01c03c
SOUNDDATA               equ         $01c03d
SOUNDADRL               equ         $01c03e
SOUNDADRH               equ         $01c03f

dpSOUNDCTL              equ         $3c                                      ; same as above
dpSOUNDDATA             equ         $3d                                      ; but set as direct page
dpSOUNDADRL             equ         $3e                                      ; for faster accesses
dpSOUNDADRH             equ         $3f

IRQ_VOLUME              equ         $e100ca

;-----------------------------------
; EQUATES
;-----------------------------------

tiUserID                equ         zTemp02                                  ; Must still be valid when audioInit is called
dpFROM                  equ         zTemp03                                  ; Antoine - I need a long in the Direct Page space
dpFROMH                 equ         zTemp04                                  ; Antoine - I need a long in the Direct Page space
dpPREVADRL              equ         zTemp05
dpPREVADRH              equ         zTemp06

TRUE                    gequ        255
FALSE                   gequ        0

NUM_OSCILLATORS         gequ        30                                       ; leave the last 2 alone

;-----------------------------------
; ENTRY POINT
;-----------------------------------
audioInit               entry
                        jsr         audioLoadFILES                           ; load all files
                        jsr         audioInitSOUND                           ; set vector
                        jsr         audioInitENSONIQ                         ; init the ensoniq (or JMP and no RTS below)
ai_done                 rts

audioShutdown           entry
                        jsr         audioStopENSONIQ                         ; stop all oscillators
                        jmp         audioStopSOUND                           ; restore vector and return (or JMP and no RTS below)

;-----------------------------------
; LOAD ALL FILES
;-----------------------------------
audioLoadFILES          entry
                        lda         #pSOUNDBANK                              ; The 64KB wavebank
                        ldy         #0
                        jsr         audioLoadFILE
                        sty         ptrSOUNDBANK
                        stx         ptrSOUNDBANK+2

                        lda         #pBIGEXPLO
                        ldy         #0
                        jsr         audioLoadFILE
                        sta         sndPAGE                                  ; 0 - save number of pages
                        sty         ptrBIGEXPLO                              ; and RAM pointer
                        stx         ptrBIGEXPLO+2

                        lda         #pBOMB
                        ldy         #0
                        jsr         audioLoadFILE
                        sta         sndPAGE+2                                ; 1
                        sty         ptrBOMB
                        stx         ptrBOMB+2

                        lda         #pCOINDROP
                        ldy         #0
                        jsr         audioLoadFILE
                        sta         sndPAGE+6                                ; 3
                        sty         ptrCOINDROP
                        stx         ptrCOINDROP+2

                        lda         #pEXTRALIFE
                        ldy         #0
                        jsr         audioLoadFILE
                        sta         sndPAGE+12                               ; 6
                        sty         ptrEXTRALIFE
                        stx         ptrEXTRALIFE+2

                        lda         #pGAMESTART
                        ldy         #0
                        jsr         audioLoadFILE
                        sta         sndPAGE+14                               ; 7
                        sty         ptrGAMESTART
                        stx         ptrGAMESTART+2

                        lda         #pHIGHSCORE
                        ldy         #0
                        jsr         audioLoadFILE
                        sta         sndPAGE+16                               ; 8
                        sty         ptrHIGHSCORE
                        stx         ptrHIGHSCORE+2

                        lda         #pTIMEWARP
                        ldy         #0
                        jsr         audioLoadFILE
                        sta         sndPAGE+26                               ; 13
                        sty         ptrTIMEWARP
                        stx         ptrTIMEWARP+2

                        lda         #pWAVESTART
                        ldy         #0
                        jsr         audioLoadFILE
                        sta         sndPAGE+28                               ; 14
                        sty         ptrWAVESTART
                        stx         ptrWAVESTART+2
                        rts

;-----------------------------------
; LOAD THE BOSS
;-----------------------------------

audioLoadBOSS           entry
                        php
                        sei

; --- Find the sound for the BOSS

                        lda         audio_boss_ptrs,x
                        sta         dpFROM
                        lda         #^audio_boss_ptrs
                        sta         dpFROM+2

;--- And move the sound into DOCRAM

                        short       m

                        lda         IRQ_VOLUME
                        ora         #%01100000                               ; bit 6: access RAM, bit 5: enable auto increment
                        sta         SOUNDCTL

                        lda         SOUNDADRL                                ; Save the old pointer
                        sta         dpPREVADRL
                        lda         SOUNDADRH
                        sta         dpPREVADRH

                        lda         #$00                                     ; DOCRAM address $3000
                        sta         SOUNDADRL
                        lda         #$30
                        sta         SOUNDADRH

                        ldy         #0                                       ; Move 4K
lb_2                    lda         [dpFROM],y
                        sta         >SOUNDDATA
                        iny
                        cpy         #$1000                                   ; $500 okay, $800 not okay
                        bcc         lb_2

                        lda         dpPREVADRL                               ; restore the old pointer
                        sta         SOUNDADRL
                        lda         dpPREVADRH
                        sta         SOUNDADRH

                        long        m
                        plp
                        rts

;-----------------------------------
; LOAD A FILE
;-----------------------------------

audioLoadFILE           entry
                        sta         proOPEN+4                                ; A contains the filename pointer
                        sty         lf_skip+1                                ; if Yequ$bdbd then skip NewHandle

                        jsl         GSOS
                        dc          i2'$2010'
                        dc          a4'proOPEN'
                        bcs         lf_err

                        lda         proOPEN+2                                ; get file ID
                        sta         proREAD+2
                        sta         proCLOSE+2

                        lda         proEOF                                   ; get length
                        sta         proREAD+8
                        lda         proEOF+2
                        sta         proREAD+10

lf_skip                 lda         #0                                       ; skip NewHandle
                        cmp         #$bdbd                                   ; if $BDBD
                        beq         lf_ok

                        ph4         #0
                        ~NewHandle  proEOF,tiUserID,#%1100000000001100,#$00
                        phd                                                  ; dereference handle
                        tsc                                                  ; to get RAM pointer
                        tcd
                        lda         [3]
                        sta         proREAD+4
                        ldy         #2
                        lda         [3],y
                        sta         proREAD+6
                        pld
                        pla
                        pla
                        bcs         lf_err

lf_ok                   jsl         GSOS
                        dc          i2'$2012'
                        dc          a4'proREAD'

lf_err                  php                                                  ; exit w/ or w/o error
                        jsl         GSOS
                        dc          i2'$2014'
                        dc          a4'proCLOSE'
                        plp

                        lda         proEOF+1                                 ; return the number of pages
                        ldy         proREAD+4                                ; and the RAM pointer
                        ldx         proREAD+6
                        rts

;-----------------------------------
; INIT THE ENSONIQ
;-----------------------------------

audioInitENSONIQ        entry
                        php
                        sei
                        short       m

                        jsr         audioStopALLOSCS

; 2. Move the sound bank in the DOCRAM

                        ldy         ptrSOUNDBANK
                        sty         dpFROM
                        ldx         ptrSOUNDBANK+2
                        stx         dpFROM+2

                        lda         IRQ_VOLUME                               ; get the volume
                        ora         #%01100000                               ; bit 6: access RAM, bit 5: enable auto increment
                        sta         SOUNDCTL

                        lda         #0                                       ; DOCRAM address $0000
                        sta         SOUNDADRL
                        sta         SOUNDADRH

                        ldy         #0                                       ; Move 64K
ie_1                    lda         [dpFROM],y
                        sta         SOUNDDATA
                        iny
                        bne         ie_1

; 3. Set all the oscillators settings (but the CONTROL)

ie_2                    lda         SOUNDCTL
                        bmi         ie_2
                        and         #%00001111                               ; bit 6: access DOC, bit 5: disable auto increment
                        sta         SOUNDCTL

                        ldy         #0                                       ; configure the first 30 oscillators
ie_3                    tya                                                  ; frequency low
                        sta         SOUNDADRL
                        lda         oscFREQL,y
                        sta         SOUNDDATA

                        tya                                                  ; frequency high
                        ora         #$20
                        sta         SOUNDADRL
                        lda         oscFREQH,y
                        sta         SOUNDDATA

                        tya                                                  ; volume
                        ora         #$40
                        sta         SOUNDADRL
                        lda         oscVOLUME,y
                        sta         SOUNDDATA

                        tya                                                  ; address
                        ora         #$80
                        sta         SOUNDADRL
                        lda         oscADDRESS,y
                        sta         SOUNDDATA

                        tya                                                  ; size
                        ora         #$c0
                        sta         SOUNDADRL
                        lda         oscWAVRES,y
                        sta         SOUNDDATA

                        iny                                                  ; next one please
                        cpy         #NUM_OSCILLATORS
                        bcc         ie_3

                        long        m
                        plp
                        rts

;----------------------------------------
; STOP ALL THE OSCILLATORS
;----------------------------------------

audioStopENSONIQ        entry
                        php
                        sei
                        short       m

                        jsr         audioStopALLOSCS

                        long        m
                        plp
                        rts

;----------------------------------------
; THE MANDATORY ROUTINE
;----------------------------------------
                        longa       off

audioStopALLOSCS        entry

sa_1                    lda         SOUNDCTL
                        bmi         sa_1
                        and         #%10011111                               ; bit 6: access DOCRAM, bit 5: disable auto increment
                        sta         SOUNDCTL

                        ldx         #2                                       ; 2 loops
sa_2                    ldy         #$1f                                     ; 32 oscillos
sa_3                    tya
                        ora         #$a0
                        sta         SOUNDADRL
                        lda         #%00000001                               ; stop oscillator
                        sta         SOUNDDATA
                        dey
                        bpl         sa_3
                        dex
                        bne         sa_2
                        rts
                        long        m,i

;----------------------------------------
; SET/UNSET THE SOUND VECTOR
;----------------------------------------

audioInitSOUND          entry
                        php                                                  ; get the previous sound interrupt vector
                        sei
                        ph4         #0
                        ~GetVector  #11
                        pl4         sndVECTOR

                        ~SetVector  #11,#audioINTERRUPT
                        plp
                        rts

;--------- Remove the vector

audioStopSOUND          entry
                        php                                                  ; restore the original sound interrupt vector
                        sei
                        ~SetVector  #11,sndVECTOR
                        plp
                        rts

;--------- Data

sndVECTOR               ds          4

;-----------------------------------
; STOP AN OSCS
;-----------------------------------
audioStopOSCS           entry
                        sta         theA
                        stx         theX
                        sty         theY

                        php
                        sei
                        bra         ass_continue

;-----------------------------------
; STOP A SOUND
;-----------------------------------
audioStopSource         entry
                        sta         theA
                        stx         theX
                        sty         theY

                        php
                        sei

                        and         #$ff
                        tax
                        lda         snd2OSC,x                                ; get the associated oscillator
ass_continue            and         #$ff
                        tay

                        lda         dpSOUNDADRL
                        sta         >saddrL
                        lda         dpSOUNDADRH
                        sta         >saddrH
                        short       m

                        lda         IRQ_VOLUME
                        and         #%10011111                               ; bit 6: access DOC, bit 5: disable auto increment
                        sta         SOUNDCTL

                        tya                                                  ; stop the oscillators
                        clc
                        adc         #$a0
                        sta         SOUNDADRL
                        lda         #%00000001
                        sta         SOUNDDATA
                        tya
                        clc
                        adc         #$a1
                        sta         SOUNDADRL
                        lda         #%00000001
                        sta         SOUNDDATA

                        lda         >saddrL
                        sta         dpSOUNDADRL
                        lda         >saddrH
                        sta         dpSOUNDADRH
                        plp
                        ldy         theY
                        ldx         theX
                        lda         theA
                        rts


;-----------------------------------
; PLAY A SOUND
;-----------------------------------
                        longa       on
                        longi       on


audioPlaySource         entry
                        sta         theA
                        stx         theX
                        sty         theY

                        php
                        sei

                        and         #$ff
                        tax
                        lda         snd2OSC,x                                ; get the associated oscillator
                        and         #$ff
                        tay

                        lda         dpSOUNDADRL
                        sta         >saddrL
                        lda         dpSOUNDADRH
                        sta         >saddrH

                        short       m

                        lda         sndPLAY,x                                ; check if sound is in DOCRAM
                        bpl         ps_ram

;--- Play the sound from the DOCRAM

ap_indram               lda         IRQ_VOLUME
                        and         #%10011111                               ; bit 6: access DOC, bit 5: disable auto increment
                        sta         SOUNDCTL

                        tya                                                  ; stop the oscillators
                        clc
                        adc         #$a0
                        sta         SOUNDADRL
                        lda         #%00000001
                        sta         SOUNDDATA
                        tya
                        clc
                        adc         #$a1
                        sta         SOUNDADRL
                        lda         #%00000001
                        sta         SOUNDDATA
                        tya                                                  ; start the oscillators

                        cmp         #2                                       ; osc 2 is on loop
                        beq         ap_loop
                        cmp         #14
                        bne         ap_normal

ap_loop                 ora         #$a0
                        sta         SOUNDADRL
                        lda         #%00000110                               ; left loop (which is right)
                        sta         SOUNDDATA

                        tya
                        ora         #$a1
                        sta         SOUNDADRL
                        lda         #%00000110                               ; also left loop
                        bra         ap_done

ap_normal               ora         #$a0
                        sta         SOUNDADRL
                        lda         #%00000010                               ; left one shot (which is right)
                        sta         SOUNDDATA

                        tya
                        ora         #$a1
                        sta         SOUNDADRL
                        lda         #%00010010                               ; right one shot (which is left)
ap_done                 sta         SOUNDDATA
                        long        m

                        lda         >saddrL
                        sta         dpSOUNDADRL
                        lda         >saddrH
                        sta         dpSOUNDADRH

                        plp
                        ldy         theY
                        ldx         theX
                        lda         theA
                        rts
                        short       m

;--- Prepare the streaming of a sound
; X: sound index (0..23)
; Y: oscillator (0..28)

ps_ram                  phd

                        long        m

                        lda         #$c000                                   ; we need speed,
                        tcd                                                  ; we put the direct page in the firmware space

                        lda         #0                                       ; to clear the upper 8-bits

;--- Stop oscillos

                        short       m
                        phy                                                  ; save even's oscillator

                        lda         dpSOUNDCTL
                        and         #%10011111                               ; bit 6: access DOC, bit 5: disable auto increment
                        sta         dpSOUNDCTL

                        tya                                                  ; stop the oscillators
                        ora         #$a0
                        sta         dpSOUNDADRL
                        lda         #%00000001
                        sta         dpSOUNDDATA
                        tya
                        ora         #$a1
                        sta         dpSOUNDADRL
                        lda         #%00000001
                        sta         dpSOUNDDATA

;--- Set sound parms (address, nb of pages)

                        long        m

                        txa                                                  ; get the number of pages (word)
                        asl         a
                        tax
                        lda         sndPAGE,x                                ; sound index
                        sta         oscPAGE,y                                ; oscillator index

                        tya                                                  ; save it as a long too
                        asl         a
                        asl         a
                        tay

                        lda         sndADDRESS,x                             ; get pointer
                        tax
                        lda         |$0000,x                                 ; save it
                        sta         oscRAMPTR,y
                        sta         ps_patch+1

                        short       m
                        lda         |$0002,x
                        sta         oscRAMPTR+2,y

                        pha
                        plb

;--- Move 256 bytes to DOCRAM (A: bank, Y: address)

                        lda         dpSOUNDCTL
                        ora         #%01100000                               ; bit 6: access RAM, bit 5: enable auto increment
                        sta         dpSOUNDCTL

ps_patch                ldy         #$bdbd                                   ; address equ oscRAMPTR

                        lcla        &n
&n                      seta        0
.MOVE
                        lda         |&n,y
                        sta         dpSOUNDDATA
                        actr        100
&n                      seta        &n+1
                        AIF         &n<256,^MOVE

                        phk
                        plb
                        ply

;--- Start the first two oscillators (one holds the interrupt)

                        lda         dpSOUNDCTL
                        and         #%10011111                               ; bit 6: access DOC, bit 5: disable auto increment
                        sta         dpSOUNDCTL

                        tya                                                  ; start the oscillators
                        ora         #$a0
                        sta         dpSOUNDADRL
                        lda         #%00001110                               ; left, interrupt, swap, start oscillator
                        sta         dpSOUNDDATA
                        tya
                        ora         #$a1
                        sta         dpSOUNDADRL
                        lda         #%00000111                               ; right, no interrupt, swap, start oscillator
                        sta         dpSOUNDDATA

;--- The end (the rest is handled in the interrupt)

                        long        m
                        pld

                        lda         >saddrL
                        sta         dpSOUNDADRL
                        lda         >saddrH
                        sta         dpSOUNDADRH

                        plp

                        ldy         theY
                        ldx         theX
                        lda         theA
                        rts

;-----------------------------------
; SOUND INTERRUPT
;-----------------------------------
                        longa       off
                        longi       off

audioINTERRUPT          entry

                        phb                                                  ; prepare the context
                        phd

                        phk
                        plb

                        long        m,i

                        lda         #$c000
                        tcd

                        lda         #0                                       ; clear upper 8-bits
                        tax                                                  ; that helps!
                        tay

;---

                        short       m

si_1                    lda         dpSOUNDCTL
                        bmi         si_1
                        and         #%10011111                               ; bit 6: access DOC, bit 5: disable auto increment
                        sta         dpSOUNDCTL

                        lda         #$e0                                     ; get interrupt register
                        sta         dpSOUNDADRL

                        lda         dpSOUNDDATA                              ; perform two reads
                        lda         dpSOUNDDATA
                        and         #%00111110                               ; bits 1..5 contain the oscillator
                        lsr         a
                        sta         theREALOSC
                        and         #%11111110
                        sta         theMASKEDOSC
                        cmp         #NUM_OSCILLATORS
                        bcc         si_ours

;--- Exit interrupt

si_exit                 short       m,i

                        pld
                        plb
                        clc
                        rtl

;--- Stop the oscillos
                        longa       off
                        longi       on
si_ours                 asl         a
                        asl         a
                        tax

;--- Check if we reached the end of the music?

                        ldy         theMASKEDOSC
                        lda         oscPAGE+1,y                              ; did we reach the end of the music
                        bmi         si_theend
                        ora         oscPAGE,y
                        bne         si_continue

si_theend               tya
                        ora         #$a0                                     ; stop the oscillators
                        sta         dpSOUNDADRL
                        lda         #%00000001
                        sta         dpSOUNDDATA
                        tya
                        ora         #$a1
                        sta         dpSOUNDADRL
                        lda         #%00000001
                        sta         dpSOUNDDATA
                        bra         si_exit

;--- Set the sound address where to stream data

si_continue             lda         dpSOUNDADRL
                        sta         >saddrL
                        lda         dpSOUNDADRH
                        sta         >saddrH

                        lda         dpSOUNDCTL
                        ora         #%01100000                               ; bit 6: access RAM, bit 5: enable auto increment
                        sta         dpSOUNDCTL

                        stz         dpSOUNDADRL                              ; DOCRAM address $xx00

                        ldy         theREALOSC
                        lda         oscADDRESS2,y
                        sta         dpSOUNDADRH

;--- And move the page

                        lda         oscRAMPTR+2,x
                        ldy         oscRAMPTR,x
                        pha
                        plb

&n                      seta        0
.MOVE1
                        lda         |&n,y
                        sta         dpSOUNDDATA
                        actr        100
&n                      seta        &n+1
                        AIF         &n<256,^MOVE1

                        phk
                        plb

                        lda         >saddrL
                        sta         dpSOUNDADRL
                        lda         >saddrH
                        sta         dpSOUNDADRH

;--- Start the sound

                        lda         dpSOUNDCTL
                        and         #%10011111                               ; bit 6: access DOC, bit 5: disable auto increment
                        sta         dpSOUNDCTL

                        ldy         theMASKEDOSC
                        lda         theREALOSC
                        lsr         a
                        bcc         si_impair

; impair a g�n�r� l'interruption, on doit jouer sur le pair

                        tya
                        ora         #$a0
                        sta         dpSOUNDADRL
                        lda         #%00001110
                        sta         dpSOUNDDATA
                        bra         si_next

; pair a g�n�r� l'interruption, on doit jouer sur l'impair

si_impair               tya
                        ora         #$a1
                        sta         dpSOUNDADRL
                        lda         #%00001110
                        sta         dpSOUNDDATA

;--- Prepare the data for the next interrupt

si_next                 long        m

                        inc         oscRAMPTR+1,x                            ; RAM ptr++
                        tyx
                        dec         oscPAGE,x                                ; nb pages--
                        brl         si_exit
                        END

;-----------------------------------
; SOUND DATA
;-----------------------------------
SOUNDDATAAREA           DATA

; DOCRAM memory map
; 0000    WAPON EXPLODE
; 1000    WAPON EXPLODE
; 2000    WAPON EXPLODE
; 3000    BOSS LEVEL X
; 4000    ENEMY EXPLODE
; 5000    ENEMY EXPLODE
; 6000    ENEMY EXPLODE
; 7000    ENEMY SHOOT
; 8000    PLAYER SHOOT
; 9000    ROCKET FLY
; A000    ROCKET LAUNCH
; B000    WAVE START
; C000    WAVE START
; C800    BIG EXPLOSION (can start after other fx play)
; CA00    EXTRA LIFE / BOMB (exclusive)
; CC00    TIMEWARP (can start after other fx play)
; CE00    COINDROP / GAME START / HIGHSCORE (exclusive)
; D000    PICKUP
; E000    PICKUP
; F000    PICKUP

sndADDRESS              dc          a2'ptrBIGEXPLO'                          ; 0
                        dc          a2'ptrBOMB'                              ; 1
                        dc          a2'$0000'                                ; 2
                        dc          a2'ptrCOINDROP'                          ; 3
                        dc          a2'$0000'                                ; 4
                        dc          a2'$0000'                                ; 5
                        dc          a2'ptrEXTRALIFE'                         ; 6
                        dc          a2'ptrGAMESTART'                         ; 7
                        dc          a2'ptrHIGHSCORE'                         ; 8
                        dc          a2'$0000'                                ; 9
                        dc          a2'$0000'                                ; 10
                        dc          a2'$0000'                                ; 11
                        dc          a2'$0000'                                ; 12
                        dc          a2'ptrTIMEWARP'                          ; 13
                        dc          a2'ptrWAVESTART'                         ; 14

sndPAGE                 dc          i2'0'                                    ; 0  - number of sound pages - word
                        dc          i2'0'                                    ; 1
                        dc          i2'0'                                    ; 2
                        dc          i2'0'                                    ; 3
                        dc          i2'0'                                    ; 4
                        dc          i2'0'                                    ; 5
                        dc          i2'0'                                    ; 6
                        dc          i2'0'                                    ; 7
                        dc          i2'0'                                    ; 8
                        dc          i2'0'                                    ; 9
                        dc          i2'0'                                    ; 10
                        dc          i2'0'                                    ; 11
                        dc          i2'0'                                    ; 12
                        dc          i2'0'                                    ; 13
                        dc          i2'0'                                    ; 14

sndPLAY                 dc          i1'FALSE'                                ; A 0  - in DOCRAM if TRUE, in RAM if FALSE
                        dc          i1'FALSE'                                ; B 1
                        dc          i1'TRUE'                                 ; D 2
                        dc          i1'FALSE'                                ; I 3
                        dc          i1'TRUE'                                 ; J 4
                        dc          i1'TRUE'                                 ; K 5
                        dc          i1'FALSE'                                ; M 6
                        dc          i1'FALSE'                                ; N 7
                        dc          i1'FALSE'                                ; O 8
                        dc          i1'TRUE'                                 ; Q 9
                        dc          i1'TRUE'                                 ; R 10
                        dc          i1'TRUE'                                 ; S 11
                        dc          i1'TRUE'                                 ; T 12
                        dc          i1'FALSE'                                ; V 13
                        dc          i1'TRUE'                                 ; X 14

snd2OSC                 dc          i1'18'                                   ; A 0  - sound index to oscillator index
                        dc          i1'24'                                   ; B 1
                        dc          i1'2'                                    ; D 2
                        dc          i1'26'                                   ; I 3
                        dc          i1'4'                                    ; J 4
                        dc          i1'6'                                    ; K 5
                        dc          i1'22'                                   ; M 6
                        dc          i1'26'                                   ; N 7
                        dc          i1'26'                                   ; O 8
                        dc          i1'8'                                    ; Q 9
                        dc          i1'10'                                   ; R 10
                        dc          i1'14'                                   ; S 11
                        dc          i1'16'                                   ; T 12
                        dc          i1'28'                                   ; V 13
                        dc          i1'12'                                   ; X 14

;-----------------------------------
; ENSONIQ DATA
;-----------------------------------

; FREQUENCY CONTROL LOW AND HIGH

oscFREQL                dc          h'D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6'
                        dc          h'D6D6ACACACACACACACACACACACAC0000'

oscFREQH                dc          h'00000000000000000000000000000000'
                        dc          h'00000101010101010101010101010000'

; VOLUME

oscVOLUME               dc          h'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'
                        dc          h'FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000'

; ADDRESS POINTER

oscADDRESS              dc          h'00003030404070708080B0B0C0C0E0E0'
                        dc          h'F0F0D8D9DADBDCDDDEDFBCBDBEBF0000'

oscADDRESS2             dc          h'00003030404070708080B0B0C0C0E0E0'
                        dc          h'F0F0D9D8DBDADDDCDFDEBDBCBFBE0000'

; WAVEFORM TABLE SIZE / RESOLUTION / BANK SELECT (00abcabc)
; 256: 00 0000_0000
; 512: 09 0000_1001
;  1k: 12 0001_0010
;  2k: 1b 0001_1011
;  4k: 24 0010_0100
;  8k: 2d 0010_1101
; 16k: 36 0011_0110

oscWAVRES               dc          h'3636242436362424363624242D2D2424'
                        dc          h'24240000000000000000000000000000'

; FOR RAM SOUND: ADDRESS AND NB OF PAGES

oscRAMPTR               ds          4*NUM_OSCILLATORS                        ; current RAM pointer of the sound
oscPAGE                 ds          2*NUM_OSCILLATORS                        ; remaining pages to push (until 0)

theREALOSC              ds          2
theMASKEDOSC            ds          2

;-----------------------------------
; DATA
;-----------------------------------

;----------------------- Memory Manager

theA                    ds          2
theX                    ds          2
theY                    ds          2

saddrL                  ds          2
saddrH                  ds          2

ptrSOUNDBANK            ds          4

ptrBIGEXPLO             ds          4
ptrBOMB                 ds          4
ptrCOINDROP             ds          4
ptrEXTRALIFE            ds          4
ptrGAMESTART            ds          4
ptrHIGHSCORE            ds          4
ptrWAVESTART            ds          4
ptrTIMEWARP             ds          4

;----------------------- GS/OS

proOPEN                 dc          i2'12'
                        ds          2
                        dc          a4'pSOUNDBANK'
                        ds          2
                        ds          2
                        ds          2
                        ds          2
                        ds          4
                        ds          2
                        ds          8
                        ds          8
                        ds          4
proEOF                  ds          4

proREAD                 dc          i2'4'                                    ; 0 - nb parms
                        ds          2                                        ; 2 - file id
                        ds          4                                        ; 4 - pointer
                        ds          4                                        ; 8 - length
                        ds          4                                        ; C - length read

proCLOSE                dc          i2'1'
                        ds          2

proQUIT                 dc          i2'2'                                    ; pcount
                        ds          4                                        ; pathname
                        ds          2                                        ; flags

;---------- Files

pBIGEXPLO               dc          i2'18',c'1/snd/bigexplo.snd'
pBOMB                   dc          i2'14',c'1/snd/bomb.snd'
pCOINDROP               dc          i2'18',c'1/snd/coindrop.snd'
pEXTRALIFE              dc          i2'19',c'1/snd/extralife.snd'
pGAMESTART              dc          i2'19',c'1/snd/gamestart.snd'
pHIGHSCORE              dc          i2'19',c'1/snd/highscore.snd'
pSOUNDBANK              dc          i2'15',c'1/snd/soundbank'
pTIMEWARP               dc          i2'18',c'1/snd/timewarp.snd'
pWAVESTART              dc          i2'19',c'1/snd/wavestart.snd'

                        END

;---------- Boss Audio Data

AUDIODATA               DATA

audio_boss0             entry
                        dc          h'7A7A8085858686868686858486807B7B'
                        dc          h'797A797979797A7B82868686827B7B79'
                        dc          h'7A7B7B7A83848685868585857D7C7A7A'
                        dc          h'7B7B7B7E8485858E949696949695817C'
                        dc          h'7B7B7B7B7B7A79797B94969595969696'
                        dc          h'959595867B7A7B7B7A7B7A7A7B949595'
                        dc          h'9594959596967F7B7B7A797B7A797A89'
                        dc          h'9595959496968A7E7D7C7B7A7A7A797A'
                        dc          h'7A7B7B7A7A7C7C7B7A7D7B7C7C7B7C7D'
                        dc          h'7C7B79797A7A7A7A7B7B7B7D7C7C7B7D'
                        dc          h'7B7B7D7C7C7B797A7B7A7A797B7A7B7A'
                        dc          h'7A7C7D7B7B8289807B7B7B7A7B7B7979'
                        dc          h'7986898988898A8A8988817B7B7B7A7A'
                        dc          h'7B7A7A7A878A888A8A88898989898889'
                        dc          h'817B7A7A7A7A7A7B7B7B7B7A79888989'
                        dc          h'89888A8A8A848486847C7A7A7A7A7A7B'
                        dc          h'7A7B7A7B7A8285868685868585858486'
                        dc          h'85817C7B7A7A7B7A7A80858484868485'
                        dc          h'847D7B7A797A7A7B7B83858686858585'
                        dc          h'857B7B7A797A7B797B797D7C7C7C7B7D'
                        dc          h'7D7B7C7A797A797A7B7A7A7A7B7B7C7C'
                        dc          h'7C7D7D7B7B7A7A7A797A7A7A7B7D7C7B'
                        dc          h'7D7B7C7D7C7B7B7B7A797A797B7A7C7D'
                        dc          h'7C7D7D7C7C7D7C7C7C7C797B7A7A7A7B'
                        dc          h'7A7A7A7A7B7C7C7D7C7B7D7C7B7C7C7D'
                        dc          h'7C7A7B7B797B797A7A797B7B7B7B7D7D'
                        dc          h'7C7B7C7D7D7A797A7B7A7B7B7A7A7A7A'
                        dc          h'7B7B7C7C7B7B7B7A7B7B7B79797A7C7B'
                        dc          h'7B7C7B7B7C7B797B797A7B7A7B7A7B7C'
                        dc          h'7B7B7B7C7C7B7A7A7C7B7A7B7B7A797A'
                        dc          h'7A7A7A7A7A7B7C7C7B7C7B7B7A7A7B7C'
                        dc          h'7A7B7B7B7A797A7A7F83858686868685'
                        dc          h'7D7C797B7A7A7A7A8484858486858581'
                        dc          h'7C7B7B797A7B828585858586857E7A7A'
                        dc          h'7A7B7B7B838685858486867C7A7A7A7B'
                        dc          h'7B829395969695957F7B7B7B7A7B7C91'
                        dc          h'95969596958C7C7B7A7A797A8E949494'
                        dc          h'9596959596877D7A7A7A7B7B7A7A7B93'
                        dc          h'9595969595959594807B7B7B797A7B79'
                        dc          h'7A7C7B7A7C7B7D7C7C7C7C7A797A7B7A'
                        dc          h'7A7A7A7A7B7C7B7C7D7B7C7B7C7B7B79'
                        dc          h'797A797A7B7B797B7B7C7B7B7B7B7C7C'
                        dc          h'7C7B7C7B7B7A7A7A7B7B7A7A7A7A8689'
                        dc          h'8A8A89888A89888989877B7A7A7A797A'
                        dc          h'7A7A7B7B79848A898A8A8A898A8A898A'
                        dc          h'89897D7A7A797A7A7A7A7A7A7A7A8489'
                        dc          h'8A8A8A8A89898989898A887D7B7A7A7B'
                        dc          h'797A7B7A8385868585868686847D7A7A'
                        dc          h'7B7B7B797A7B848585858585867E7B7A'
                        dc          h'7B7A7A7B838685868485847E7B7A7A7A'
                        dc          h'7B79828484848686857D7B7A797A797A'
                        dc          h'7A7B7B7B7D7C7D7C7C7D7B7D7C7A7A7A'
                        dc          h'7A7A7A797B7A7B7D7C7D7D7C7C7C7B7B'
                        dc          h'7B7A7B7A7B7B7B7A7C7C7C7C7D7C7D7C'
                        dc          h'7B7A797A7A7B7A7A7B7C7C7C7D7D7C7C'
                        dc          h'7C7C7C797B7A79797B7A7A7B7B7A7B7B'
                        dc          h'7D7C7D7C7B7B7A797A7A7A7A7A7B7A7A'
                        dc          h'7B7B7C7C7D7C7D7C7C7B7A7A797A7A7B'
                        dc          h'7A7B7B7A7A7C7C7D7C7D7C7B7B7A7979'
                        dc          h'7A7A7A7A7B7B797B7C7B7A7A7B7B7C7B'
                        dc          h'7C7A797A7B797A7A7B7A7A7A7B7A7A7C'
                        dc          h'7C7B7A7B7C7C7C7B797A7B7A797A7A7A'
                        dc          h'7A7A7B7B7B7B7C7B7C7E84868686817C'
                        dc          h'7A7B7A7B7B7B7A797A7B7A8385858485'
                        dc          h'868486858686857D7B7A7B7A7B7A7B83'
                        dc          h'858686868485817B797A797B7B7A8486'
                        dc          h'8685858585867B79797A7A7A7A797991'
                        dc          h'95959696969496927F7B79797A7B7B7B'
                        dc          h'7C929495949694969595827C7A797A79'
                        dc          h'7A7A7A809295969595949596937E7C7A'
                        dc          h'797A7A7A7A7B8F8C7D7C7A7B7C7C7C7A'
                        dc          h'7B7A7B7B79797B7B7A7A79797B7B7C7D'
                        dc          h'7B7D7C7A7B7B7C7A7A7B797B7B7A7A7B'
                        dc          h'797B7B7A7B7C7B7A7A7B7B7D7C7C7A7A'
                        dc          h'7B7A7B7A79797A7A878A887A797A7A79'
                        dc          h'7B868989898A88807C7A7A7B797E888A'
                        dc          h'898A898A7E7A7A7B7A7B7B7B7B797C87'
                        dc          h'898A88898989898888887C7B7B7A7B7B'
                        dc          h'7B7A7B7B7C898685858586857D7A7B7B'
                        dc          h'7A7A7A7E848586858685867C7A7A7A7B'
                        dc          h'7A7B7E838685858585867E7B797A7979'
                        dc          h'7B7B82848585848686857C7B7A7B7B7B'
                        dc          h'7B7B8486867F7D7B7C7B7B797A7A7A7B'
                        dc          h'7A7C7C7C7B7C7C7C7D7A7A7B7A7A7A7B'
                        dc          h'7C7C7D7D7D7D7D7C7D7B7B7B797A7A7A'
                        dc          h'7A7C7B7C7C7B7D7C7D7B7B7B7B7A7A79'
                        dc          h'797B7D7C7D7D7C7B7D7D7C7A7B7B797B'
                        dc          h'7A7A7B7B7C7D7C7B7C7B7B7B7B7A7B7A'
                        dc          h'7A79797B7B7D7D7B7C7D7B7A7B7B7D7A'
                        dc          h'797B7B7A7B7A7B7B7A7A7A7C7C7B7C7B'
                        dc          h'7A7C7B7B7A7C7A7A7B7B7A7A7A7A7B7A'
                        dc          h'7B7B7B7B7C7B7B7A7B7B7B7B7B7A7B7A'
                        dc          h'797A797A797C7B7C7B7A7A7B7C7A7B7B'
                        dc          h'7A7A797A7A797B7B7B7B7B7B7C7B7A7B'
                        dc          h'7A7A847E7B797A7B797A7A7A82858485'
                        dc          h'8486868585827B7B7B7A7A7A7A7B7B84'
                        dc          h'8686848685827C7B7B7B797A80858686'
                        dc          h'8485847C7B7A7A7A7B7A828686868684'
                        dc          h'847D7C797A7B7A7B7A7A7B7B8C959495'
                        dc          h'96949595959595907C7A797A7A7A7A7A'
                        dc          h'7A8F9496959595969596877B7B7A7A7B'
                        dc          h'7A797A859294959594959596957F7C7A'
                        dc          h'7A7A7B7B7B7A7A7A7A7A7A7A7C7B7C7A'
                        dc          h'7B7B7B7B7D7D7B7B7A7B7A7B7B7A797B'
                        dc          h'797B7B7C7C7D7C7B7D7D7C7C7B7A7C7A'
                        dc          h'7A7B7A7A7A7A797B797B7B7B7B7C7D82'
                        dc          h'8A898989898A887B7A7A7A7A7A7A7A79'
                        dc          h'7B7A7E888A898A89888888898A89847A'
                        dc          h'7A79797B7B7B7A7B7B838A898A89898A'
                        dc          h'898A8A8A807B7B7B7A7A7A797B7B7B83'
                        dc          h'868686868484868686847D7A7B7A7A7B'
                        dc          h'7B7A797A82858585868586848485807C'
                        dc          h'7B7A7D848586858685827B7B7A7A797A'
                        dc          h'7C858685858585847C7B7B7A7A7A7B7A'
                        dc          h'7D7C7C7C7B7C7B7C7B7B7B7A7B7A7A7A'
                        dc          h'7B7B7C7D7D7D7B7C7D7B7A7A7A7A7A7A'
                        dc          h'797C7C7C7D7D7C7B7D7C7C7A7A7A797B'
                        dc          h'7B7A7A7B7D7C7D7D7C7D7D7B7A7A7B7B'
                        dc          h'797A7B797A7C7D7C7B7A7C7B7C7D7C7A'
                        dc          h'7B7B7A7B7A7A7B797A7A7B7B7C7B7D7C'
                        dc          h'7C7B7C7C797A7A7B797A7A797A7B7A7A'
                        dc          h'7C7B7B7B7C7C7B7C7C7C7A7B7B7B7A7A'
                        dc          h'7B7B7C7C7A7B7B7B7A7A7A7A7B7A7B7B'
                        dc          h'7B7A7C7A7C7B797A797B7A7B7B7B7C7B'
                        dc          h'7C7B7C7B7C7B7A7A7A7A7B7A797B7A7B'
                        dc          h'7C7B7A7A7B7B7B7C7B7C7A7B7A7B7979'
                        dc          h'7A7A83858685858586807B7A7A7B7A7B'
                        dc          h'7B83868584868585847A7B7B7B7B7979'
                        dc          h'81848586868586867C7B7B7A7A7A7B7E'
                        dc          h'858686858686867F7A7B7A797B7A7E92'
                        dc          h'9594969595957F7B7B7B797A7B819295'
                        dc          h'95949595967F7B7A7B7A7A7B7B7B8994'
                        dc          h'94969695959595917B7A7A797A7A7B7B'
                        dc          h'799295959695959695817C7C7B797A7B'
                        dc          h'7A7B7B7B7979797A7C7A7C7D7C7B7C7D'
                        dc          h'7C7C7B7B7B7A7A7B7B7B7C7B7C7C7D7C'
                        dc          h'7B7B797B7B7A7B7C7B7D7C7C7C7A7B7A'
                        dc          h'7B7B7B7B7C7D7C7B878A8989897F7B7A'
                        dc          h'7A7A7A7B7B7B7D88888A89898A8A8989'
                        dc          h'7D7C7A7B7A797A7B7A8288898A8A8988'
                        dc          h'888A8A7D797B7A7A7B7B7B7A84898A89'
                        dc          h'888A898988857A7B7B7B7A7B797B7E85'
                        dc          h'85858586858585837B7B7A7A7A797B79'
                        dc          h'7B84858586858685807A7A7A7A797B7A'
                        dc          h'82858685848485867D7A7A7B7A797B7A'
                        dc          h'8485858585847F7C7C7C7D7D7B7A7B7A'
                        dc          h'7A7A7A7A7A7A7A7A7B7C7D7B7C7D7C7D'
                        dc          h'7C7C7C7C7C7A7A7A7B7A7B7A7B7B7C7C'
                        dc          h'7D7D7D7D7D7C7A7A7A7A7B7B7A7B7D7C'
                        dc          h'7C7C7C7B7D7B7B7A7C7C7B7B797A7A7A'
                        dc          h'7A7B7A797A7B7C7B7B7B7C7B7B7B7C7B'
                        dc          h'7B7B7B797A797A7A7B7C7B7C7C7B7C7C'
                        dc          h'7A797A7B7A7A7A7B7B7B7C7A7D7B7B7B'
                        dc          h'7A7B7B7B7B7A7B7C7A7B7B7C7B7B7B7A'
                        dc          h'7B7B7A7A7C7B7C7A7C7C7A7B7B797B7B'
                        dc          h'79797A7B7C7B7B7B7B7A7C7C7B7A7A7A'
                        dc          h'7A7B7B7B7B7B7B7A7B7C7A7B7A7A7A7B'
                        dc          h'7A797A7A7B7A7B7C8385858685858585'
                        dc          h'8585837C7B7A79797A7A7A7A7A818585'
                        dc          h'858686857E7B7B7A7B7A7A8485858684'
                        dc          h'86857B7B7B7A7B7B7B83858585868484'
                        dc          h'7C7B7A7B7B797A7B7B85959594949595'
                        dc          h'969596827B7A7B7B7B7B7A7A798E9596'
                        dc          h'959696969695847B7A7B7B7B7A797A7F'
                        dc          h'939595959695949495807C7A7A7A7A7A'
                        dc          h'7B7A7B7D7C7C7B7C7C7D7C7A797A7A7B'
                        dc          h'7A7A7B7B7B7B7B7C7C7C7C7B7C7B7B79'
                        dc          h'7B7A797B7A7B7A7B7C7C7B7B7D7B7B7A'
                        dc          h'7A7A7A7B7A7A7D7C7B7A7D7C7B7A797B'
                        dc          h'797B7B7A7B7B7A7B7D88888889898A89'
                        dc          h'898A8889857C7B7A7A7B7A7A7B7A797B'
                        dc          h'858A89888888898A89867C7A7A7A7A7A'
                        dc          h'7A7A79878A898A8888898A897F7C7B79'
                        dc          h'7A7A7A7B7A7A79797F84868686848686'
                        dc          h'85858485847C7A7A7B7A7A7A797A7A80'
                        dc          h'8486857D797A7A7B797C848686858686'
                        dc          h'867D797B7A7A797B848685858685867E'
                        dc          h'797B7A797A7B7D7C7C7D7D7C7B7A7979'
                        dc          h'7A7B7B7B7C7C7C7D7D7C7B797B7B7A79'
                        dc          h'7B7A7C7C7C7D7C7C7C7D7D7B7A7B7A7B'
                        dc          h'7A7A7A7B7B7D7D7B7C7C7B7C7B7B7A7A'
                        dc          h'7A7A7B7B7A7A7B7D7B7C7C7D7B7B7B7C'
                        dc          h'7A797B7A7B7A7A7A7B7C7C7B7D7B7B7C'
                        dc          h'7C7B7B7B7B7A7B7D7C7B7D7D7B7B797A'
                        dc          h'7B7B797B7B7B7C7B7D7C7B7A7A7A7B7A'
                        dc          h'7B7B7A7B7C7C7A7B7B7C7B7C7B7B7B7A'
                        dc          h'797B7A7A7B7A7A7A7A7B7C7B7C7B7B7B'
                        dc          h'7B7B7A7A7B7A7B7B7B7C7C7A7B7B7C7B'
                        dc          h'7B7B7B7B7B7B7B7B7B7A797C84848485'
                        dc          h'858686857D7A7B7A7B7B7B7B7B838585'
                        dc          h'8485858585867E7B7B7A7B79797A8386'
                        dc          h'8586858586817A7A7A7B7A7A7A808685'
                        dc          h'85868684847D7B7A7A7A7A7B7A7B7B7A'
                        dc          h'7B919595969495969595949495807B7B'
                        dc          h'7B79797A797B7B7B7A8B939695959696'
                        dc          h'9595947C7B7A7A7A7A7B7A7B91949595'
                        dc          h'9696959595847C7B7C7B7C7B7B7A7B7A'
                        dc          h'797B7C7B7B7C7A7D7C7C7B7B7B7B7A7C'
                        dc          h'7D7B7B7D7D7C7E7F7E7E807E7E7F7E7D'
                        dc          h'7C7D7C7B7B797B7C7C7D7B7B7B7A7C7B'
                        dc          h'7C7B7B7879787877797B838685867979'
                        dc          h'79787B7B878C8C8D8C8C877C7D7C7C7C'
                        dc          h'7C888C8B8D8C8D817E7C7A7A7A7B7885'
                        dc          h'878988888789877D7A7B7A7B7A787E85'
                        dc          h'8685868687897F7C7A7A7A7876777777'
                        dc          h'798387898A8D8C8C8C89878179787777'
                        dc          h'7578787A7C7C84878786858584867C7C'
                        dc          h'7C7F80807F7E878786858484827F787A'
                        dc          h'7B7A7A7D7D8387807E7E7D7C7B7C7C7A'
                        dc          h'7A7A787B7B7B7D7B7D7D7D7C7D7C7D7B'
                        dc          h'7B7B7A7B7B7C7C7B7B7C7C7B7B7B7C7D'
                        dc          h'7C7B7D7D7C7C7C7B7A7B7B7A7B7B7A7D'
                        dc          h'7C7C7C7C7D7C7B7A7C7A797A7A7B7B7C'
                        dc          h'7D7B7A7A7A7D7C7C7B7B7B7B7B7A7B7A'
                        dc          h'7A7C7A7C7C7C7D7B7C7A7A7A7B7A7B7A'
                        dc          h'7A7A7A7B7B7A7C7C7D7C7D7C7A7B797B'
                        dc          h'7A7B7A797A7B7B7B7C7B7C7B7D7C7C7A'
                        dc          h'7B797A7A7B7A7A7B7C7C7C7A7C7D7C7B'
                        dc          h'7B7B7C7A7A7A7A7A7B7B7C7A7B7B7B7B'
                        dc          h'7C7C7A7A7B7A7B7A7A7B7B7A7A7B7C7B'
                        dc          h'7B7A7A7B7A797A7A797B7B7B7B858584'
                        dc          h'8585858684858485857D7A7B7A7B7A7A'
                        dc          h'7B7B7B7A7F85847A797A7A7A7B7E8486'
                        dc          h'85858585817A7B7A7B7B7B8183868685'
                        dc          h'84857E7A7B7B7B7A797A8B9496959596'
                        dc          h'96958E7E7B7B7B7A797C7C9296949496'
                        dc          h'959597817C7A7A797A7B7A7A89949494'
                        dc          h'9496959696947B7B7C7A7B7A7B7A7A91'
                        dc          h'949595827D7C7B7B7D7B7C7B7B7A7B7A'
                        dc          h'7C7B7B7A7A7A7B7A7B7D7C7C7D7D7C7B'
                        dc          h'7B7D7C7B7A7B7A7A7B7A7B7A7D7C7C7B'
                        dc          h'7A7C7C7C7A7C7A7A7A7B7A7A7C7C7B7D'
                        dc          h'7D7A898889898888827B7A7A7B7A7A7A'
                        dc          h'7A7B7B7A858A89898A8A89898A8A8989'
                        dc          h'7F797B7B7B7B797A8688898889898A86'
                        dc          h'7C7B7A7A7A797B7E898A898A88888981'
                        dc          h'7C7A7A7A797A7D838586848586857E7C'
                        dc          h'7B7A7A7B7A7C838585848585847D7B7A'
                        dc          h'7B7B7B7B828686848485857E7A7A7A7A'
                        dc          h'797B828586868586847E7B7A7B7B7A7B'
                        dc          h'7C7D7C7B7D7C7C7B7B7B7C7B7A7B7A7A'
                        dc          h'7A797B7A797A7A7C7C7D7D7B7B7C7B7D'
                        dc          h'7B7B797B7B7B7B7A7B7C7D7D7C7D7D7C'
                        dc          h'7B7A7B7A7B7A7A7B797B7C7D7D7D7C7D'
                        dc          h'7D7C7C7B7B7A7A7B7A7B797A7A7B7D7D'
                        dc          h'7B7B7B7B7C7D7C7B7A797B7B7A797A7C'
                        dc          h'7D7B7B7B7C7C7C7B7A7B7A797A7A7A7B'
                        dc          h'7B7D7C7C7C7D7C7B7A7A7A7A7A797B7C'
                        dc          h'7B7A7C7C7C7B7A797A7A7A7B7B7A7B7C'
                        dc          h'7B7A7B7A797B7A797A7A7B7B7B7C7C7B'
                        dc          h'797B7A7B7A7A7C7B7B7C7C7C7A7C7B7B'
                        dc          h'7B7A797B7A0000000000000000000000'
                        dc          h'00000000000000000000000000000000'
                        dc          h'00000000000000000000000000000000'
                        dc          h'00000000000000000000000000000000'
                        dc          h'00000000000000000000000000000000'

audio_boss1             entry
                        dc          h'78777777777677787978787877797978'
                        dc          h'77777677787778777778787878787778'
                        dc          h'79797778777877787C7D7D7D7B7C7D7C'
                        dc          h'7C7C83848181817F7F81818180818180'
                        dc          h'81808282828182828182828180808381'
                        dc          h'828382969B9A9A9B9B9B9B9A9B9C9C9B'
                        dc          h'9B9B9A9A999A999A999A9A98999A9A9A'
                        dc          h'9999989392929492948B8C8E8E8C8C88'
                        dc          h'7B797879787878787879787777787777'
                        dc          h'77767778777877777878787878787777'
                        dc          h'79787778787677787876767878787778'
                        dc          h'7778777879797877787A787A7879797A'
                        dc          h'797A7F818280807F7F807F7F7F808A8D'
                        dc          h'8D8B8888878888888886868687878786'
                        dc          h'88878989888989898988878787878887'
                        dc          h'88858685858685858685858486868686'
                        dc          h'85858686868585848585848585868781'
                        dc          h'7E7D7D7C7C7B7C7C7C7C787778767777'
                        dc          h'76787878787777757576787878777777'
                        dc          h'76787879797878797778787877777777'
                        dc          h'77787878797879787878797978797A7A'
                        dc          h'7A797A7A7B7979787878787878787780'
                        dc          h'7F80807F7F7F7D7F7E7F8080807F7F7F'
                        dc          h'91959596939495949495959595949594'
                        dc          h'95949495969696969696969596959391'
                        dc          h'8F919191908F908F8E8E9090908F8F90'
                        dc          h'8F8F8E8F8F918F90918F91918F908D8C'
                        dc          h'8B8C858485858587877D7A7979787977'
                        dc          h'76777878787776757575777676767676'
                        dc          h'76777777767676777777767776777777'
                        dc          h'77777778777878787978787879777978'
                        dc          h'78797878787878777778787776787776'
                        dc          h'787778777876777D7D7F7E7E7F838282'
                        dc          h'83828383848283848484848482848483'
                        dc          h'84828583848385848485848485848283'
                        dc          h'82838384838483828282838283838383'
                        dc          h'8281838382838383818283849A9B9C9C'
                        dc          h'9C9C9C9D9B9C9D9D9C9C9C9B9C9C9B88'
                        dc          h'7A787978797776787878797777787978'
                        dc          h'7777777979797979787A797978777878'
                        dc          h'77777978787979797878787879787776'
                        dc          h'77777877777877777777787878797777'
                        dc          h'7876767676767777767677777C848384'
                        dc          h'848384858685868587878888898F8D8E'
                        dc          h'8F8E8D8F8F8D8E8E8E8C8A8989888989'
                        dc          h'898A89898A8A8889898A898A89898A89'
                        dc          h'898A8A88898A8B8B8B88868788878786'
                        dc          h'86868787878887898988878787878887'
                        dc          h'8888888282808180807F807F807E807E'
                        dc          h'80807F7F7F80807E807F7E7F7E787979'
                        dc          h'797979797A7A78797977787678777777'
                        dc          h'78787778777676777877777878797878'
                        dc          h'77777775757675747475757676777777'
                        dc          h'77777877778B92939293949393939493'
                        dc          h'93929393939392908E8D8C8D8E8F8E8E'
                        dc          h'8E8F8F8F8F8E8E8E8E8E8E8F8E8E8E8E'
                        dc          h'95969597969596929091919091909190'
                        dc          h'9191918F8F8E8E8F8F8F908F8F8F8F8E'
                        dc          h'8E8E8D8D807E7D7E7E7F7E7E7E807F7E'
                        dc          h'7F807E7F7F7F8080817F828282818282'
                        dc          h'808081807F7F81827F81828182828180'
                        dc          h'80808180808081807F7E7E7D7E7E7B7C'
                        dc          h'7A7C7D7D7E7D7E7F7878787979787879'
                        dc          h'787A7A78797A7978797F7F7F7F7E7E7D'
                        dc          h'7D7E7D7C7C7B7A7B7C7C7D7D7C7C7C7C'
                        dc          h'7D7C7D7C7C7C7C7C7C7D7D7B7B7B7C7E'
                        dc          h'7D7C7D7C7C797A79797A79797A7A7B7A'
                        dc          h'7C7C7A7C7D7C7B7D7D7C7D7D7D7B7D7B'
                        dc          h'7C7B7C7D86929394939190918F8F7A76'
                        dc          h'757675767D7E7E7E7E7D7F7D7D7D7F7F'
                        dc          h'7E7F7E7F7E7E7E7E7F7F7D7D7D7D7E7F'
                        dc          h'7F7D7F7E7F7E7F7F7F7E7F7F7F7E7D7E'
                        dc          h'7D7F80807F7F7F8180807F8180808080'
                        dc          h'7F7F7F8181807E7F7F7F80807F817F80'
                        dc          h'8F8D908D8C8C8C8B8B8C8C8D8B8B8C8C'
                        dc          h'8B8A8B8A8A8C8B8B8B8C8B8D8C8E8D8D'
                        dc          h'8E8C8A8A8A8383818383838382838384'
                        dc          h'84838483828483848182828282828081'
                        dc          h'8182807F7E7E7E7F7E7F7D7F7F7F807E'
                        dc          h'80807F7F7F7F7A777879787879797778'
                        dc          h'7879797A797879797A797A7977777877'
                        dc          h'78787979787879777777777677767675'
                        dc          h'76777676777777777576777778777778'
                        dc          h'7877777777777675777D7D7E7D7D7D7E'
                        dc          h'7E7D7D7E8C9599989998999898989899'
                        dc          h'99999999999B9A9B9B9A9C9C9C9C9D9D'
                        dc          h'98969694959695969596949695969595'
                        dc          h'96969694969495949494949495949593'
                        dc          h'9090918F908F8F8F8E8F8F8F8E908E90'
                        dc          h'909191908F8E7F7E7E7E7F7F7E7E8080'
                        dc          h'80808081808180807F7F817F807E807F'
                        dc          h'7F7F7876777676767576747575777576'
                        dc          h'77777776777777767777787878777777'
                        dc          h'77777877777978787878797978787777'
                        dc          h'767776777778777B7F7E80807F7F7F7F'
                        dc          h'807F7E80807F7F7E7E80807F7F7F7F7E'
                        dc          h'7E7D7D7D7C7D7C7B7C7B7A7C7C7A7C7C'
                        dc          h'7B7A7B7C7C7B7B7B7A7C7B7C7D7D7B7B'
                        dc          h'7A7A7A7A7A7A7B7B7A7C7C7D7B7B7B83'
                        dc          h'8384828483827F7F807F807E7E7E807F'
                        dc          h'8080807E807F807E807F807F80807F7F'
                        dc          h'807F7F7F807F8080808080807F7F807F'
                        dc          h'7E80807F7F7F7E7F7E7F7F7F80818080'
                        dc          h'807F7E7E7E7E7F7F7E7E7E7D7D7E7F7F'
                        dc          h'7E7F7D8A8D8F8E8F8F8E8F90908F908F'
                        dc          h'8E908E8E8E8E8A888787868686858787'
                        dc          h'87878788878685868586868586868587'
                        dc          h'87878685858484848380808181808180'
                        dc          h'81818181807F81808282828281818182'
                        dc          h'8181818181828382827C7B7A7B7A7A79'
                        dc          h'797A7978787978797978787877787878'
                        dc          h'78777879777877797979787779797979'
                        dc          h'79787878787978787879797877787778'
                        dc          h'78787777777676787576777776767777'
                        dc          h'76787A7C7B7B7C7B7A7B7C7B7A7A7A79'
                        dc          h'797979797A78798C90929090908F9191'
                        dc          h'91929290939292929291919391939493'
                        dc          h'939393949494928E8E8E8E8D8E8E8C8D'
                        dc          h'8D8D8D8E8D8D8E8C8B8B8C8C8C8B8B8A'
                        dc          h'8B8B8A898A8B8683777878797879797A'
                        dc          h'7A7A79787979797979787A7A797A7979'
                        dc          h'79797A78797779797879797778777879'
                        dc          h'78787777787877787978787978797878'
                        dc          h'78787677777778777776787778777777'
                        dc          h'787876777879777877777E7E7E7F7F7E'
                        dc          h'7E7E7E7E7C7D7C7C7E7E7E7E7E7F7F80'
                        dc          h'7F7E7F7F7E7E7E7E7F7D807F7F7F807F'
                        dc          h'807E7F7F7E7D7A7A7B7B7C7B7B7C7C7C'
                        dc          h'7B7B7A7B7B7A7B7B7C7C7C7C7B7A7B7B'
                        dc          h'7B7A7A7C797776777979787879797978'
                        dc          h'78787777777878797978777979787878'
                        dc          h'78787779787778787879787878787878'
                        dc          h'77787979787777797878787676777878'
                        dc          h'78787977777875757576757576767676'
                        dc          h'76787677787877777776848C8C8C8D8C'
                        dc          h'8E8E8B8887888A898788888688878887'
                        dc          h'888889888788888A89898A8A8A898889'
                        dc          h'88878786848585858485848384848383'
                        dc          h'85848584858585848483838282838284'
                        dc          h'858482828484828282818280817F7978'
                        dc          h'78767777757475747575747576767577'
                        dc          h'77777776767574767575747475767777'
                        dc          h'77787778777778767878797778787977'
                        dc          h'79787778777879777878787879777878'
                        dc          h'7878757676757675757576767575797A'
                        dc          h'7A797A797B7B7A7A7B7B7C7B7B7A7A7B'
                        dc          h'797B7B7B7A7B7A7B7B7B7C7C7B7A7A80'
                        dc          h'90929390939392939494949394949493'
                        dc          h'94939393939492919392949493929290'
                        dc          h'8C8C8D8D8C8C8B8C8E8E8E8F8E8F8F8F'
                        dc          h'8C8D8C7B777777797878797A7A797978'
                        dc          h'77787676777878787779787879777777'
                        dc          h'78797978787978797A7A7A7979797878'
                        dc          h'78777877777779787777767676777777'
                        dc          h'7876777879797879787878777878777E'
                        dc          h'8080818281818280808080807E7E7E80'
                        dc          h'8082818281828181818182828280807F'
                        dc          h'80818182828182828181818180808081'
                        dc          h'8181828181818080808180807F7F7E7E'
                        dc          h'7E7E7E7E7E7C7E7E7E7C7D7C7D7C7D7C'
                        dc          h'7B767777777876777777777778787677'
                        dc          h'77787979797A7A797879787878777878'
                        dc          h'78787879777879787676777878777778'
                        dc          h'77777575777677777777777878777878'
                        dc          h'78797878787879777878777677777878'
                        dc          h'78787876777777767F8C8B8B8E8C8D8C'
                        dc          h'8C8C8D8D8E8D8F8F8F8E908B8B8B8B88'
                        dc          h'89888989878688868787888888888887'
                        dc          h'89878989898A8A898A89888584858586'
                        dc          h'85868484868586868586878586868584'
                        dc          h'83828482818381767675777777777677'
                        dc          h'7777767878777777777879797979797A'
                        dc          h'78787878767777787679787879797978'
                        dc          h'78787878797879787879797878777677'
                        dc          h'7676777777777777767779787977797A'
                        dc          h'7879787A7C7D7C7B7B7C7B7B7B7C7C7C'
                        dc          h'7D7E7D7E7D7C7C7D7B7A797A797A797A'
                        dc          h'7A7A7A7A7B7B7A7C79797B7B797A7A79'
                        dc          h'787979797A7A7B7B8D92949392949392'
                        dc          h'94949392939393939394949595959595'
                        dc          h'95949595949494938D7B777877777776'
                        dc          h'77777775757676757777747675767677'
                        dc          h'77777877777777787877777878797879'
                        dc          h'78787878797978787779797879787878'
                        dc          h'78787979797877777878777779797979'
                        dc          h'79778083838383828081818282828383'
                        dc          h'84838385858582828180807F80817F81'
                        dc          h'81828280828181808180828282818182'
                        dc          h'828182808182807F7F7E7F807F7F7E7E'
                        dc          h'7C7E7C7D7C7D7D7D7D7E7F7F7F7D7E7E'
                        dc          h'7E7E7F7F7C7B76767674757676767677'
                        dc          h'77767777767777787778777777767778'
                        dc          h'78787978787877797879797779787777'
                        dc          h'79787777787776777676767778787779'
                        dc          h'78767777777878777777787877787878'
                        dc          h'76767576777678768993939495979694'
                        dc          h'9495939490908E908F908E8E8F8F8F8F'
                        dc          h'8F8E908F908E8E8D8E8D8E8D8C8E8C8C'
                        dc          h'8C8D8B8C888886878888888888878788'
                        dc          h'87898A89888988898788898989888888'
                        dc          h'88898887857E7A7978797A7A7A797879'
                        dc          h'7A79787A7A7877767676777777777778'
                        dc          h'78777779787979797779787879777778'
                        dc          h'7A797979787A787978787978797A797A'
                        dc          h'7A7A7A77797879797978787978797978'
                        dc          h'7777777576767574767677777D7E7F80'
                        dc          h'807E7E7C7D7C7D7D7B7B7D7C7D7D7B7B'
                        dc          h'7C7B7A7A7A7B7B7A7B7B7C7C7D7D7B7C'
                        dc          h'7C7B7B797A7A7A7A7A7C7B7C7A7A7B79'
                        dc          h'7978787A7979797B7A7A7B79797B7B7B'
                        dc          h'7B919391919194949394939394948279'
                        dc          h'78787A79787978777676787776767778'
                        dc          h'78777978797776777777767575787778'
                        dc          h'787A7A787A7979797877787875767676'
                        dc          h'77777676767674747677757676767677'
                        dc          h'7778777877777877777779797A878988'
                        dc          h'87868687858585858587878787878686'
                        dc          h'87868686858585848484848384838381'
                        dc          h'81828280818182808082817F8080807F'
                        dc          h'80808080818182818282818280807F7E'
                        dc          h'7E7E7D7D7D7D7F7E7E7F7F7F7E7E7F7F'
                        dc          h'7E7E797877787776777877787A7A7A79'
                        dc          h'77797878787876777877787879797978'
                        dc          h'79787879777879787777777778787979'
                        dc          h'79787978777977787776777777787979'
                        dc          h'797A7A7979777776777877767878797A'
                        dc          h'7A7B7A787A78788E9392939293939393'
                        dc          h'929394939292929292939393928F8D8D'
                        dc          h'8E8D8D8E8F8E8E8D8D8E8D8D8D8D8D8E'
                        dc          h'8D8D8E8D8E8C8D8D8C8E8D8E8A89898A'
                        dc          h'8A8A8A8A898989888988878788898989'
                        dc          h'89898B8A8A8A8A89867C7A7A7A7A7A79'
                        dc          h'79797977777876767677777677757777'
                        dc          h'77757776767674767676767777777878'
                        dc          h'78777878767879787678777778787777'
                        dc          h'78787979797978787878787A7878797A'
                        dc          h'7A79797A7A7B7B79797978787879787E'
                        dc          h'8080807E7F7F7E7E7F7F7E7D7C7D7C7C'
                        dc          h'7C7C7B7B7A7A7A7B797B7B7B7C7B7C7C'
                        dc          h'7B7D7D7C7B7C7A7B7C7C7C7B7C7C7B7C'
                        dc          h'7C7C7D7C7B7D7D7C7B7C7B7D7C7B7C7C'
                        dc          h'7C7C7B7B7B797B797A88929293857776'
                        dc          h'77767677777877777677767676777677'
                        dc          h'77777677777779787879797979797977'
                        dc          h'77787879787979797777787776757677'
                        dc          h'77787878777978797978787677787576'
                        dc          h'7675767677767879797A797A787A7D88'
                        dc          h'87878686888787888787888686878686'
                        dc          h'86878686878686878686858586858484'
                        dc          h'83848485858485858280808081818180'
                        dc          h'807F8082818181807F807F8080808080'
                        dc          h'817F81818181807F7E7E807F7E7F8080'
                        dc          h'7B797979787A7A7A79787A7879797979'
                        dc          h'7778787879787778797A000000000000'
                        dc          h'00000000000000000000000000000000'
                        dc          h'00000000000000000000000000000000'

audio_boss2             entry
                        dc          h'7B7B7C7D7D7C7C7C7E7D7E7C7A7B7A79'
                        dc          h'7A797979797A7A7A7B7B7B7A7A7C7C7D'
                        dc          h'7C7D7D7B7A7B797A787977787777787A'
                        dc          h'7B7B7B7A7C7B7B7B7C7C7B7B7B7B7A7C'
                        dc          h'7C7E80807F8081817F7F7E7E7F7F7F7E'
                        dc          h'807E7D7E7D7D7E7E7D7E7E7E7D7E7E7E'
                        dc          h'7F7F808182817C7B7A7A7A7879797D7E'
                        dc          h'7E7E7F7E7D7D7B78787878797879797F'
                        dc          h'81818181828281838484858485858483'
                        dc          h'828382818181808081818080807F7F7E'
                        dc          h'7F818182838383838382828385848484'
                        dc          h'83838283838281818281818080817C7D'
                        dc          h'7C7C7D7D7D7B7C7B7B7B7B7A797A7A7B'
                        dc          h'7B7B7B7B7A7B7B7C7B7C7D7D7E7E7D7E'
                        dc          h'7E7D8282838382828281838383838079'
                        dc          h'78787979797879797A7A798483838484'
                        dc          h'85858586858485858484848584858686'
                        dc          h'85858586858585848484828382838486'
                        dc          h'85868786868787878988888889898888'
                        dc          h'888888888788888686868786867B7979'
                        dc          h'79797A7A7A797A7B7B7C7D7D7C7C7A7B'
                        dc          h'7B7B7B7B7A797978787878797778787B'
                        dc          h'78877A847D81887A8A7C878183897B8A'
                        dc          h'7D84817D8B7B897E85877F8C7D7A7B7A'
                        dc          h'7A797A7A797878787876777778777878'
                        dc          h'78787979787979787778777777777877'
                        dc          h'78787979797878787978797A7A7A797A'
                        dc          h'7A7979787978787879787B86817D8587'
                        dc          h'83828789818287848189898581878880'
                        dc          h'80868581818887828688818295979795'
                        dc          h'959595959595967F787879797A7A7978'
                        dc          h'78788196979897989798989798979797'
                        dc          h'979898979899989A9A99999A999A9999'
                        dc          h'99999999989999999997927B79787879'
                        dc          h'797879797A7879797977767776767676'
                        dc          h'75757575757776757575767776787879'
                        dc          h'7A797B7A7C7C7C7B7B7B7C7B7A8A9393'
                        dc          h'9392939290908E8F8D887D7674748486'
                        dc          h'888888898A8A7C7877787978797A848C'
                        dc          h'8E8E8F908F8F8A7D7A7A7A7877787878'
                        dc          h'7879797A7C7C7B7B7B7C7B7979787877'
                        dc          h'77767676767776767676757575757676'
                        dc          h'7576757676757676777677777879787A'
                        dc          h'7A797A7A7B797C888888888887837977'
                        dc          h'7677777776777777787C868786868687'
                        dc          h'87878787877E777777837B7F7B7A7F78'
                        dc          h'80797D7F7A81787F797B7C788079807B'
                        dc          h'7E827A837B7A79797A7A7A7A7A7A7879'
                        dc          h'797978797A7A7A797A797A7A7A7A7B7B'
                        dc          h'7B7C7D7D7D7C7D7D7D7D7B7B7C7C7B7A'
                        dc          h'7A797977777677777676757575757676'
                        dc          h'777879797C8282848383838282828181'
                        dc          h'81818181818181818282828282838384'
                        dc          h'848484848482807F7F7F807F7F7B7979'
                        dc          h'7878787778797F80818282828181827E'
                        dc          h'7C7B7A7A7B7B7A7A7978797778777575'
                        dc          h'74747574747575747676767676777878'
                        dc          h'777979797878797879797A7A7B7A7B7C'
                        dc          h'7C7B7C7C7C7C7B7B797A797A7A7A7A7D'
                        dc          h'7F7F7F807F807E7F7C79787877777778'
                        dc          h'797A7C7D7D7B7C7B7D7C7D7B7B7C7C7D'
                        dc          h'7E7E7F7F807F7F7E7D7D7D7C7D7D7E7C'
                        dc          h'7C7B7B7A7B7979797979797C7B7B7B7A'
                        dc          h'7A7B7A7B7C7C7C7C7D7C7C7B7B7C7B7B'
                        dc          h'7C7B7B7C7C7C7C7B7C7B7C7B7C7B7C7B'
                        dc          h'7C7C7C7C7B7C7C7C7C7C7C7D7B7C7C7C'
                        dc          h'7C7C7B7B7B7C7C7C7C7B7B7B7A7B7A7A'
                        dc          h'7A777777777677767676757574737374'
                        dc          h'7474747574757576777777787879787A'
                        dc          h'7B7A7A7A7B7C7A7A7A7A7B7A79797E7E'
                        dc          h'7D7E7E7C7D7C7D7C7D7A767576767676'
                        dc          h'78777776777776777575767677777777'
                        dc          h'767677777778787978797A797B7B7B7A'
                        dc          h'7B7B7C7C7B7C7C7C7D7C7B7C7C7B7B7B'
                        dc          h'7A7B7B7B7A7A7A7A787B7E7E7E7E7D7A'
                        dc          h'7D79757D7A767B7D777D7E787D807A7B'
                        dc          h'7F7A7A7F7C787F7C777E7B787C7E787B'
                        dc          h'827977777777767676757E8081828282'
                        dc          h'8282817A777777767777777881848383'
                        dc          h'83838383848484848483848483828384'
                        dc          h'84848485858585848485868685848589'
                        dc          h'89888988878787888887888888888888'
                        dc          h'89888988888889888787888888807879'
                        dc          h'787878777879797A7A7A7A7A79797879'
                        dc          h'7876767776767776777576767677777F'
                        dc          h'78817D7C8778867B83837A8A7C897E83'
                        dc          h'847B8A7B8780828979897C848A8B8A8C'
                        dc          h'8C8C8C8C8C8D8C8D8D8C8D8D8C8C8D8C'
                        dc          h'8D8D8C8D8B8B8C8C8B8B8B8B8B8F9190'
                        dc          h'908F8F8F8F90909090908F8F90909091'
                        dc          h'918F909190909090909090907B848F91'
                        dc          h'91909090908D78777676767677768A8E'
                        dc          h'8F8F8F90909080797979797879788594'
                        dc          h'969696969697987D7A7B7B7A7B797891'
                        dc          h'949595959696978C7B7B7B7C7C7A7A7A'
                        dc          h'7979787879797979797A7A7A79797878'
                        dc          h'78777878787778777878777777777777'
                        dc          h'77787777767777777678777977777876'
                        dc          h'787876777577767A8A8F8E8E8D8F9191'
                        dc          h'929292908F8F908E9090909191929191'
                        dc          h'929394939394949492938F8C7D7B7C7C'
                        dc          h'7D7D7C7D7D7D8D8D8C8C8C8B8B8C8B8C'
                        dc          h'8A7C7878797877788078777675757575'
                        dc          h'76777776767777767877787778767677'
                        dc          h'77767776757675767575767676777877'
                        dc          h'78797879797878787978787877787878'
                        dc          h'79787878777878787E7D827B7E807B84'
                        dc          h'7F7D868181877E84847E86807F867E81'
                        dc          h'857D84857E88827F857D847E7F827A83'
                        dc          h'7B817F7D8179827B807D7A8179817A7F'
                        dc          h'807A847A817C80838483848482828383'
                        dc          h'83828383828383838182828282828182'
                        dc          h'83838383838283817F807E7F7F7F7E7E'
                        dc          h'7E7F7F7F7E7E7F7F7E7F7F7F7E7E7E7D'
                        dc          h'7E7E7F7E7F7F79787979797979797877'
                        dc          h'77787777777677777776787778777878'
                        dc          h'77777878777777777A7D7D7D7C7D7D7E'
                        dc          h'7D7D7D7D7E78797A7B7B7B7B7A7B7B7A'
                        dc          h'7A7F807F7E7979797977777677767576'
                        dc          h'76767675767677787778787877777776'
                        dc          h'76767676777777777676767676777878'
                        dc          h'78787777787876767776767577777779'
                        dc          h'797B7B7C7C7B7C7B7B7B7B7B7B7B7A7D'
                        dc          h'7F7E7E7E7E7D7C7D7C7C7A7979797A7B'
                        dc          h'7B7A7B7B7F807F807F7F7E7D7D7B7A79'
                        dc          h'7A797978787B7B7A7A7B7A7A7A787677'
                        dc          h'77767676787878787878787878777777'
                        dc          h'76767877787877777777767777777877'
                        dc          h'77767777777677777676767778777879'
                        dc          h'78797A797A7A797879797878797A7A7A'
                        dc          h'797A7D7D7E7F7E7F7E7E7E7E7E7C7D7C'
                        dc          h'7B7B7B7C7B7B7B7A7B7B7C7B7C7D7D7B'
                        dc          h'7C7A7B7D7C7C7E7D7A7A7B7A7A7A7A79'
                        dc          h'7D7D7D7C7D7E7E7D7A78797978797878'
                        dc          h'7B7E7C7D7C7D7E7E7F7F7E7F7F7F7F7F'
                        dc          h'7E7F7E7F7E7E7D7D7E7E7D7E7E7F7F80'
                        dc          h'81808283848382838383828182818081'
                        dc          h'807F7F80818181818180808180818081'
                        dc          h'80817D7979797979797A797A80828182'
                        dc          h'82828282837E7A797A797A7A7A797A7F'
                        dc          h'82838483828383838384837B78787877'
                        dc          h'777777777777777D8283838383838384'
                        dc          h'84848485858585858685858585858483'
                        dc          h'83828383828383848484848584848484'
                        dc          h'868887888788888989888A898A8B8A8B'
                        dc          h'8A8B8A89888887878686868685857C76'
                        dc          h'77787878777877787878777877777777'
                        dc          h'76767677777677767778787878797A7A'
                        dc          h'82867B8A7C877E7F8979877B84807885'
                        dc          h'768679807E798878877F83877A8A8B8D'
                        dc          h'8D8D8D8E8D8C8C8C8B8C8C8C8C8B8C8C'
                        dc          h'8B8C8C8B8C8C8B8B8C8B8B8C8B8C9190'
                        dc          h'91909191919190909091909190929192'
                        dc          h'91919091919190908F908F9190929393'
                        dc          h'92927D7B7B7A7B7B7B797A7B8F909292'
                        dc          h'9091919091867B7979797A7A7A7A7978'
                        dc          h'77929798999999999B9B9A9B897C7A7A'
                        dc          h'7A7979797877797C9296959698999898'
                        dc          h'97999897989999989997989898989797'
                        dc          h'98989797989798969697969792919292'
                        dc          h'93929493929393929191919291929291'
                        dc          h'90918F8F8F8F8F8E8E8F907A78767676'
                        dc          h'77777879797A7A7A7977787777777777'
                        dc          h'77767777787878797879797977777877'
                        dc          h'77858888898887898A7C787A7A797A7A'
                        dc          h'79838889888786858788888A8A8C8C8C'
                        dc          h'8C8B8B8C8B8A8B8C8D8D8D8E8F8E8F8E'
                        dc          h'8F8F8E8D8D8C8C8B8B8A868687868786'
                        dc          h'86868787878687888988898888898989'
                        dc          h'88898887878686858478767677777D85'
                        dc          h'858485868686867A7877787977787878'
                        dc          h'85878787878787867D797A77817B7F7E'
                        dc          h'7A837A807A7D81798279807D7E827981'
                        dc          h'7B7F7D7A8378817C79797A7979797979'
                        dc          h'79797979797978797978787877777778'
                        dc          h'77777777777877777877777676767778'
                        dc          h'787878777878787878777978797A7A78'
                        dc          h'7A7A7A7A7979787E8180818080818181'
                        dc          h'8180807F7F807F7F80807F7F7F80807F'
                        dc          h'8081818180808080807B7C7E7F7F7E7E'
                        dc          h'7E7D7D7A78777777787778777B7C7E7D'
                        dc          h'7E7E7D7D7D7B79787878777877787777'
                        dc          h'78777877777877787777777777767777'
                        dc          h'78787877787777777878777778787777'
                        dc          h'78787777787777787878787777777778'
                        dc          h'77787777777B7B7A7A7B7B7A7A7B7B78'
                        dc          h'77777777777878777877787A7C7B7C7C'
                        dc          h'7C7B7B7C7C7B7B777877787778787777'
                        dc          h'7877797B7A7B7A7A7B7A7A7A7A777878'
                        dc          h'78000000000000000000000000000000'
                        dc          h'00000000000000000000000000000000'
                        dc          h'00000000000000000000000000000000'

audio_boss3             entry
                        dc          h'7B7C7B7C7C7C7C7C7C7B7C7B7C7C7C7C'
                        dc          h'7C808281828182828282828282818281'
                        dc          h'8283828282827F7B7B7C7C7B7C7C7B7C'
                        dc          h'7B7C7C7C7C7C7C7C7B7C7B7C7C7C7B7E'
                        dc          h'81818282828382828282818281828282'
                        dc          h'807B7C7B7C7B7C7C7C7C7C7B7C818182'
                        dc          h'82828282828182828382827F7B7C7B7C'
                        dc          h'7C7C7C7C7C7C7C7C7B7B7B7C7B7C7B7C'
                        dc          h'7B7E8281828281828282828282828182'
                        dc          h'818283828282827F7B7C7B7C7C7C7B7C'
                        dc          h'7C7B7C7B7C7C7C7B7C7C7B7C7B7D8181'
                        dc          h'82838282838281828182818182828283'
                        dc          h'82828182817C7B7C7C7C7C7C7C7C7C7C'
                        dc          h'7B7C7C7C7C7C7C7C7B7C7C7D7C7D8181'
                        dc          h'81828182828282828282828281827E7C'
                        dc          h'7C7B7C7B7C7B7C7B7C7B7C7B7D818282'
                        dc          h'8281828182838282828181827E7C7D7C'
                        dc          h'7C7C7C7B7B7C7B7C7C7C7C7D7C7C7B7C'
                        dc          h'7B7C7C7C808282828182818282828382'
                        dc          h'82807C7B7C7B7C7C7C7C7C7C7B7C7B80'
                        dc          h'828282828282828182818181817D7C7D'
                        dc          h'7C7C7C7B7C7C7C7B7C7C7D8182828282'
                        dc          h'8281828182818283817C7C7B7C7C7B7C'
                        dc          h'7C7C7B7C7C7C7C7D8082818281828282'
                        dc          h'82828282828182807C7D7C7C7C7B7B7B'
                        dc          h'7C7B7C7B808281828182828281828182'
                        dc          h'807D7C7C7C7C7C7C7C7C7B7C7C7C7C7C'
                        dc          h'7C7C7B7C7B7C7C7E8182838281828181'
                        dc          h'82838283838281828182817D7C7C7C7C'
                        dc          h'7B7C7C7B7C8182828382818182818282'
                        dc          h'8382837F7C7C7B7B7C7D7C7C7B7B7B7C'
                        dc          h'7C7D7D7C7B7B7C7B7D7C7F8281828182'
                        dc          h'82828382818281828382838281828182'
                        dc          h'807C7D7C7B7C7B7C7D7C7D7C7B7C7B7C'
                        dc          h'7D7C7D7C7C7B7D818182838283828382'
                        dc          h'8182828281828382828382828182807C'
                        dc          h'7C7C7C7D7C7D7C7C7B7C7B7C7C7E8282'
                        dc          h'8281828182818283828383827D7B7C7B'
                        dc          h'7C7C7C7D7C7C7C7B7C7B7C7C7D7C7D7C'
                        dc          h'7D7C7C7B7E8182838283828382818281'
                        dc          h'82828382838282817D7B7C7D7C7D8181'
                        dc          h'828182838283828281827F7C7D7C7C7B'
                        dc          h'7C7B7C7C7D7C7D808281828283828382'
                        dc          h'828182817D7C7D7C7C7B7C7B7C7C7D7C'
                        dc          h'7D81828182828182828382838282807C'
                        dc          h'7C7C7C7C7C7D7D7C7B7B7C7B7D828283'
                        dc          h'82838281828182828382827F7C7C7C7D'
                        dc          h'7C7D7C7B7C7B7C7D7C7C7F8281818283'
                        dc          h'83828282828182838283828182818282'
                        dc          h'83817D7C7B7C7B7C7D7C7D7C7C7B7C7B'
                        dc          h'7C7D7C7D7C7F81818281827F7C7D7C7C'
                        dc          h'7B7C7B7C7B7C7C7D8082828181828182'
                        dc          h'83838382807D7B7C7D7D7D7C7B7C7B7C'
                        dc          h'7C7D7D7C7B7C7B7B7C7D7C7D7B7C8181'
                        dc          h'82838282818281828283838282818282'
                        dc          h'8382838282807C7C7D7C7D7C7C7C7B7C'
                        dc          h'7D7C7D7C7D7C7B7C7B7C7B7C81838383'
                        dc          h'82828282818182818283828382838281'
                        dc          h'82817D7C7D7C7D7D7C7B7C7B7C7C7C7D'
                        dc          h'7D7D7C7C7B7B7B7B7C7D7C8082828182'
                        dc          h'818281828382838283807C7B7C7B7C7C'
                        dc          h'7D7C7D7C7C7B7C7B7E81828382838283'
                        dc          h'8281828382838281818182838283807C'
                        dc          h'7B7B7C7D7C7D7C7B7C7C7C7D7D7C7C7B'
                        dc          h'7C7B7C7B7E8283838283828182818281'
                        dc          h'82828382838383828182817C7B7C7D7D'
                        dc          h'7C7D7C7B7C7B7C7D7C7D7C7C7C7B7B7C'
                        dc          h'7D7C8082818281828283828382818281'
                        dc          h'828182838283828382827F7B7C7B7C7D'
                        dc          h'7C7C7C7D7C7B7C7B7C7B7C7D7C7D7C7D'
                        dc          h'7B7E82818182827D7D7C7D7C7B7B7C7B'
                        dc          h'7C7D7C7C7D8182818281818283828382'
                        dc          h'82838281828182818283827F7C7D7C7C'
                        dc          h'7B7C7B7C7B7C7C7D7C7D7C7D7C7B7C7B'
                        dc          h'7F8282838282838282807C7C7C7B7C7C'
                        dc          h'7D7C7D7C7C7B7C7B7C80838283828382'
                        dc          h'8281828181818283807D7D7D7C7C7B7C'
                        dc          h'7B7C7B7C7C7D7C7D8182818281828382'
                        dc          h'8382818282827E7C7D7C7B7C7B7C7D7D'
                        dc          h'7C7C7B7C808382838282828281828182'
                        dc          h'83827F7C7D7D7C7B7C7B7C7B7C7C7D7C'
                        dc          h'8083828281828182818182838283807C'
                        dc          h'7C7B7C7B7C7C7D7C7D7C7C7B7C7B7C7C'
                        dc          h'7D7C7C7C7C7B7C808282838283838281'
                        dc          h'82828182827E7C7C7C7B7C7B7C7C7D7C'
                        dc          h'7D7C7D81828182828283828182818283'
                        dc          h'807D7C7B7C7B7C7D7C7D7C7B7C7B8083'
                        dc          h'8283828182818283838283827D7B7C7B'
                        dc          h'7C7C7D7C7D7C7C7B7D81828283828382'
                        dc          h'82818281827F7C7D7C7D7D7C7B7C7B7B'
                        dc          h'7C7D7D7C808381828181828283828382'
                        dc          h'8281827E7B7C7D7C7D7C7D7C7C7B7C7B'
                        dc          h'7C7B7C7D7C7D7C7D7C7C7B7E82818282'
                        dc          h'838283838283828181828283817D7C7B'
                        dc          h'7C7B7D7D7C7D7C7C7B7D828382838282'
                        dc          h'8182838483838182817C7B7C7D7C7D7C'
                        dc          h'7D7C7B7C7C7B7C7D7C7D7C7D7C7B7C81'
                        dc          h'81828383838383828182818181838382'
                        dc          h'8382838282807C7C7C7D7C7D7D7C7D7C'
                        dc          h'7C7B7C7B7C7C7D7C7D7D7C7D7B7D8181'
                        dc          h'82818283838283828382818282818281'
                        dc          h'8383838483827D7B7C7C7B7C7D7D7D7C'
                        dc          h'7D7B7C7B7C7B7C7D7D7D7E7D7D818182'
                        dc          h'8182838383848382817E7B7C7C7D7D7D'
                        dc          h'7C7D7D7C7B7C81818284838383838282'
                        dc          h'81827F7C7D7D7D7D7C7B7C7B7C7D7C7D'
                        dc          h'7C7C7B7C7B7C7D7C7D7C7E8281818283'
                        dc          h'82838281818281827F7C7E7D7C7D7D7D'
                        dc          h'7D7B7C7B7B7C7F828383838382838381'
                        dc          h'828182817D7D7C7B7C7B7C7D7C7D7C7B'
                        dc          h'7B7F828283838281828183848383807B'
                        dc          h'7C7B7C7D7D7D7D7D7C7B7C7B7D818283'
                        dc          h'83838282818281828182827E7D7C7D7C'
                        dc          h'7C7B7C7B7C7D7C7D7C7D7C7B7C7B7C7C'
                        dc          h'7D7C7F83828181828182838283828381'
                        dc          h'828181818283807D7D7D7C7B7B7C7B7C'
                        dc          h'7D808382838281828182818383838383'
                        dc          h'827D7B7C7C7D7C7D7C7C7C7B7C7D7D7D'
                        dc          h'7C7B7C7B7C7D7C808281828182838383'
                        dc          h'828182818282838383828181827F7D7D'
                        dc          h'7C7D7C7C7B7C7C7C7D7C7D7C7B7C7B7C'
                        dc          h'7D7D7C80838282818281828383838382'
                        dc          h'81828281828383838383827E7B7C7B7D'
                        dc          h'7D7C7D7C7B7C7C7C7D7C7D7D7C7B7C7B'
                        dc          h'7C7D7C81828182818283838283828181'
                        dc          h'828283817C7C7B7C7B7C7C7C7C7C7C7C'
                        dc          h'80828283828282828182818282827F7C'
                        dc          h'7C7B7C7B7C7C7B7C7C7C7B7C7B7C7C7C'
                        dc          h'7D7C7C7B7E8182828282838282818281'
                        dc          h'828282827E7B7C7B7C7C7C7B7C7C7B7C'
                        dc          h'7B7C7C7F828282818281828282828282'
                        dc          h'8182807D7C7B7C7C7B7C7B7B7C7D7C7C'
                        dc          h'7D818182818283828282828182818280'
                        dc          h'7C7C7B7C7B7C7B7C7B7C7C7D81828282'
                        dc          h'8182818182838283807D7C7B7C7B7C7C'
                        dc          h'7C7C7C7B7C7B7C7B7C7C7C7C7C7B7D81'
                        dc          h'81828182828282828182818182838282'
                        dc          h'827E7C7C7B7C7C7B7C7C808282838282'
                        dc          h'82818281828282817D7C7C7B7C7B7C7C'
                        dc          h'7C7C7C7C7C7B7C7B7C7C7C7B7C7B7C7B'
                        dc          h'7C818282828282818281828282828281'
                        dc          h'828182828282828182817D7C7C7C7C7B'
                        dc          h'7C7B7C7C7C7B7C7B7C7C7B7B7C7D7C7C'
                        dc          h'7B7E8181828282828282818281828182'
                        dc          h'8282838282818281817E7C7D7C7C7C7C'
                        dc          h'7B7C7B7C7B7C7B7C7B7C7B7B7B7B7C7C'
                        dc          h'7F82828281828182828282828282827E'
                        dc          h'7B7C7B7C7B7C7C7B7C7C7C7D80828181'
                        dc          h'828182828382828282807C7B7C7C7C7C'
                        dc          h'7C7B7C7B7C7C7C7C7C7B7C7B7C7C7C7C'
                        dc          h'7C7B7E8182828282818282828281827E'
                        dc          h'7C7C7C7C7C7C7B7C7B7C7B7C81828282'
                        dc          h'83828282818281827F7C7B7C7C7B7B7C'
                        dc          h'7B7C7B7C7B7D81828282818281828182'
                        dc          h'8282827E7C7C7B7C7B7C7C7C7B7C7C7C'
                        dc          h'7B7C8182828382838282818281828283'
                        dc          h'7F7C7D7B7B7C7B7C7C7C7D7C7C7C8082'
                        dc          h'8283828281818281828283817C7C7B7C'
                        dc          h'7D7C7D7C7B7C7B7C7D7F828282828182'
                        dc          h'8382838281828182838283828181827F'
                        dc          h'7C7D7C7C7B7C7B7C7D7D7C7C7C7C7F82'
                        dc          h'818281828283828382828182817C7B7C'
                        dc          h'7C7D7C7D7C7C7B7C7B7C7C7F82828382'
                        dc          h'818182818282838382827D7B7C7B7C7C'
                        dc          h'7D7C7D7C7C7B7C7B7D81828383828382'
                        dc          h'81818281828283817D7D7C7B7C7B7C7B'
                        dc          h'7C7C7D7C7D7C7D818282828283828281'
                        dc          h'8281827F7C7D7C7C7B7B7C7D7C7D7C7C'
                        dc          h'80828283828382828282818283828382'
                        dc          h'818281828283807C7C7B7C7B7C7C7D7C'
                        dc          h'7D7C7B7C7B7C7D7D7C7E828182818281'
                        dc          h'82827E7C7D7C7C7B7B7C7B7C7D7C7C7D'
                        dc          h'80828182818282838281818282838283'
                        dc          h'82818281828382837E7B7C7B7C7C7D7D'
                        dc          h'7C7B7C7B7C7D7C7D7C7C7B7C7B7C7C7D'
                        dc          h'81828182818282838282818281818283'
                        dc          h'828382818281827F7C7D7C7D7C7C7B7C'
                        dc          h'7C7B7C7D7C7C7D7C7B7C7B7C7B7D8282'
                        dc          h'83828281828282828382828182818283'
                        dc          h'828382828182807D7D7C7C7B7C7B7C7D'
                        dc          h'7C7D7C7B7B7C7C7F8283828182818283'
                        dc          h'828282817C7B7C7D7C7D7C7B7C7B7C7C'
                        dc          h'7D7C7F82818282818283828382828281'
                        dc          h'8281828182838283807C7C7B7C7B7C7B'
                        dc          h'7C7D7D7C7D7C7C7C7F82818282828282'
                        dc          h'82818281818283827D7C7C7B7C7B7C7C'
                        dc          h'7D7C7D7C7D7C7E828182818283828282'
                        dc          h'83828181817E7B7C7C7D7C7D7C7C7B7C'
                        dc          h'7B7C7B7E828382828281828382838282'
                        dc          h'7F7C7C7D7C7D7C7B7B7B7C7D7C7F8281'
                        dc          h'82818281828382838282828281828182'
                        dc          h'818283807D7D7C7C7B7C7B7C7B7B7C7C'
                        dc          h'7D7C7C7B7E818282838283828281827F'
                        dc          h'7D7D7D7C7C7B7C7B7C7D7C7D7C7F8281'
                        dc          h'82828382838283828182818281828382'
                        dc          h'82828382827F7B7C7B7C7D7C7D7C7D7C'
                        dc          h'7B7B7C7B7C7C7D7C7C7D7C7B7B808281'
                        dc          h'83828382838281828182828383828282'
                        dc          h'8382817D7B7C7B7C7C7D7C7D7C7D7C7B'
                        dc          h'7C7B7C7B7C7C7C7C7D80838282818281'
                        dc          h'81828382838283828182818281828382'
                        dc          h'83827E7C7B7C7B7C7B7C7D7C7D7C7D7C'
                        dc          h'7B7B8082818282838283828382828182'
                        dc          h'817C7C7D7C7D7C7D7C7B7B7C7C7B7C7C'
                        dc          h'7F828182828382838281828182838283'
                        dc          h'82818281828283817C7B7C7B7C7C7D7D'
                        dc          h'7C7C7C7C7D7E7D808383838282828282'
                        dc          h'828384837F7D7E7D7D7C7D7C7D7C7C7D'
                        dc          h'7D7D8183828282828283838384838382'
                        dc          h'82807C7D7D7D7D7D7D7C7C7C7C7C7D7C'
                        dc          h'7F838283828283828284838383837F7C'
                        dc          h'7D7C7D7E7D7D7D7B7C7C7C7C80848382'
                        dc          h'81828383838383838281828484838282'
                        dc          h'838282817E7E7D7C7C7C7D7D7C7D7D7D'
                        dc          h'7C7D81818284848483828182827D7C7D'
                        dc          h'7C7D7D7E7C7C7B7C7C80848383838282'
                        dc          h'83828383828382838482838281828283'
                        dc          h'84837E7D7B7C7B7C7D7E7E7E7D7C7B7C'
                        dc          h'7C7D7D7D7D7D7C7D7C7D828382838282'
                        dc          h'81828283848384848281828182818385'
                        dc          h'8283807D7D7D7D7C7C7C7C7D7F7E7E7C'
                        dc          h'7C7B7B7C7E7F7F7E7C7C7B8183828283'
                        dc          h'84838283838283838383828382838383'
                        dc          h'83807E7D7D7D7D7C7B7C7D7D7C7E7E80'
                        dc          h'8383838182818282838485827E7F7D7C'
                        dc          h'7B7B7C7C7C7D7F7E8084848383828182'
                        dc          h'81828383838485858382838382828182'
                        dc          h'827E7D7C7D7E7D7C7D7C7D7D7F7E8083'
                        dc          h'8382818281818285858485837D7C7D7C'
                        dc          h'7B7C7D7C7D7D7D7C7D81838283848584'
                        dc          h'8583838182807C7B7C7D7D7F7E7F7D7C'
                        dc          h'7D7D8083838383828383818281828385'
                        dc          h'837F7E7C7C7C7D7E7E7C7D7C7B7C7B7F'
                        dc          h'83828384838283828485858484817D7C'
                        dc          h'7B7C7C7B7C7B7C7C7D7E7F8284838283'
                        dc          h'8382838282838382827D7B7B7C7E7D7D'
                        dc          h'7D7C7D7C7E7F7E7F7D7C7D7C7C7D7C7F'
                        dc          h'82818281838384848382838283817F7F'
                        dc          h'7E7F7E7D7C7C7B7C7B7C7C7D82838283'
                        dc          h'82838283828385858484807C7D7C7B7C'
                        dc          h'7C7D7D7C7D7C7C7B7E81838584858584'
                        dc          h'828382838385837F7E7C7C7B7C7B7C7B'
                        dc          h'7C7C7B7C7B7B80838383828382838483'
                        dc          h'8483838283817D7D7C7C7C7B7C7B7C7C'
                        dc          h'7C7B7E81828383828383848384838381'
                        dc          h'7D7D7E7D7C7C7B7C7B7C7B7C7D7C7B7C'
                        dc          h'7B7C7B7C7D7F82838382838283848384'
                        dc          h'838383828182828282817C7C7C7B7C7C'
                        dc          h'7C7D8082828382838483848483828282'
                        dc          h'7F7D7E7D7C7C7C7D7C7C7C7D7C7D7C7D'
                        dc          h'7C7C7C7C7C7C7D7C8083828282828282'
                        dc          h'82828383838382828282828283838382'
                        dc          h'7E7C7C7C7C7D7D7D7D7C7C7C7C7C7C7D'
                        dc          h'7D7D7D7D7D7B7C7D8182000000000000'
                        dc          h'00000000000000000000000000000000'
                        dc          h'00000000000000000000000000000000'

audio_boss_ptrs         dc          a2'audio_boss0'
                        dc          a2'audio_boss1'
                        dc          a2'audio_boss2'
                        dc          a2'audio_boss3'
                        dc          i2'audio_boss3'

thisisformatsounddata_  anop
                        END
