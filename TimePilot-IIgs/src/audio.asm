;
; Sounds for Time Pilot
;
; (c) 2024, Brutal Deluxe Software
;

                        copy        src/globals.s
                        mcopy       src/audio.mac

AUDIO                   START
                        USING       SOUNDDATA

;-----------------------------------
; SOFTSWITCHES
;-----------------------------------

tiUserID                equ         zTemp02                                  ; Must still be valid when audioInit is called
GSOS                    equ         $E100A8
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

dpFROM                  equ         zTemp00                                  ; Antoine - I need a long in the Direct Page space

TRUE                    gequ        255
FALSE                   gequ        0

NUM_OSCILLATORS         gequ        30                                       ; leave the last 2 alone

;-----------------------------------
; ENTRY POINT
;-----------------------------------
audioInit               entry
                        jsr         initSOUND                                ; set vector
                        jsr         loadFILES                                ; load all files
                        jsr         initENSONIQ                              ; init the ensoniq (or JMP and no RTS below)
                        rts

audioShutdown           entry
                        jsr         stopENSONIQ                              ; stop all oscillators
                        jsr         stopSOUND                                ; restore vector and return (or JMP and no RTS below)
                        rts

;-----------------------------------
; LOAD ALL FILES
;-----------------------------------
loadFILES               entry
                        lda         #pSOUNDBANK                              ; The 64KB wavebank
                        ldy         #0
                        jsr         loadFILE
                        sty         ptrSOUNDBANK
                        stx         ptrSOUNDBANK+2

                        lda         #pBIGEXPLO
                        ldy         #0
                        jsr         loadFILE
                        sta         sndPAGE                                  ; 0 - save number of pages
                        sty         ptrBIGEXPLO                              ; and RAM pointer
                        stx         ptrBIGEXPLO+2

                        lda         #pBOMB
                        ldy         #0
                        jsr         loadFILE
                        sta         sndPAGE+2                                ; 1
                        sty         ptrBOMB
                        stx         ptrBOMB+2

                        lda         #pBOOMERANG
                        ldy         #0
                        jsr         loadFILE
                        sta         sndPAGE+4                                ; 2
                        sty         ptrBOOMERANG
                        stx         ptrBOOMERANG+2

                        lda         #pBOSS
                        ldy         #0
                        jsr         loadFILE
                        sta         sndPAGE+6                                ; 3
                        sty         ptrBOSS
                        stx         ptrBOSS+2

                        lda         #pCOINDROP
                        ldy         #0
                        jsr         loadFILE
                        sta         sndPAGE+16                               ; 8
                        sty         ptrCOINDROP
                        stx         ptrCOINDROP+2

                        lda         #pEXTRALIFE
                        ldy         #0
                        jsr         loadFILE
                        sta         sndPAGE+24                               ; 12
                        sty         ptrEXTRALIFE
                        stx         ptrEXTRALIFE+2

                        lda         #pGAMESTART
                        ldy         #0
                        jsr         loadFILE
                        sta         sndPAGE+26                               ; 13
                        sty         ptrGAMESTART
                        stx         ptrGAMESTART+2

                        lda         #pHIGHSCORE
                        ldy         #0
                        jsr         loadFILE
                        sta         sndPAGE+28                               ; 14
                        sty         ptrHIGHSCORE
                        stx         ptrHIGHSCORE+2

                        lda         #pNEXTLEVEL
                        ldy         #0
                        jsr         loadFILE
                        sta         sndPAGE+30                               ; 15
                        sty         ptrNEXTLEVEL
                        stx         ptrNEXTLEVEL+2

                        lda         #pSTAGECLEAR
                        ldy         #0
                        jsr         loadFILE
                        sta         sndPAGE+40                               ; 20
                        sty         ptrSTAGECLEAR
                        stx         ptrSTAGECLEAR+2

                        lda         #pTIMEWARP
                        ldy         #0
                        jsr         loadFILE
                        sta         sndPAGE+42                               ; 21
                        sty         ptrTIMEWARP
                        stx         ptrTIMEWARP+2
                        rts

;-----------------------------------
; LOAD THE BOSS
;-----------------------------------

loadBOSS                entry
                        short       m
                        ora         #'0'
                        sta         pBOSS+12
                        long        m

                        ldy         ptrBOSS                                  ; set the RAM pointer
                        sty         proREAD+4
                        ldx         ptrBOSS+2
                        stx         proREAD+6

                        lda         #pBOSS
                        ldy         #$bdbd                                   ; no new memory handle
                        jsr         loadFILE

                        lda         proEOF+1                                 ; if no bytes loaded
                        bne         lb_1                                     ; do not replace the
                        rts                                                  ; sound data

;--- And move the sound into DOCRAM

lb_1                    php
                        sei
                        short       m

                        ldy         ptrBOSS
                        sty         dpFROM
                        ldx         ptrBOSS+2
                        stx         dpFROM+2

                        lda         IRQ_VOLUME
                        ora         #%01100000                               ; bit 6: access RAM, bit 5: enable auto increment
                        sta         SOUNDCTL

                        lda         #$00                                     ; DOCRAM address $3000
                        sta         SOUNDADRL
                        lda         #$30
                        sta         SOUNDADRH

                        ldy         #0                                       ; Move 4K
lb_2                    lda         [dpFROM],y
                        sta         SOUNDDATA
                        iny
                        cpy         #$1000
                        bcc         lb_2

                        long        m
                        plp
                        rts

;-----------------------------------
; LOAD A FILE
;-----------------------------------

loadFILE                entry
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

initENSONIQ             entry
                        php
                        sei
                        short       m

                        jsr         stopALLOSCS

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

stopENSONIQ             entry
                        php
                        sei
                        short       m

                        jsr         stopALLOSCS

                        long        m
                        plp
                        rts

;----------------------------------------
; THE MANDATORY ROUTINE
;----------------------------------------
                        longa       off

stopALLOSCS             entry

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

initSOUND               entry
                        php                                                  ; get the previous sound interrupt vector
                        sei
                        ph4         #0
                        ~GetVector  #11
                        pl4         sndVECTOR

                        ~SetVector  #11,#sndINTERRUPT
                        plp
                        rts

;--------- Remove the vector

stopSOUND               entry
                        php                                                  ; restore the original sound interrupt vector
                        sei
                        ~SetVector  #11,sndVECTOR
                        plp
                        rts

;--------- Data

sndVECTOR               ds          4

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
                        and         #$ff
                        tay

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

                        short       m

                        lda         sndPLAY,x                                ; check if sound is in DOCRAM
                        bpl         ps_ram                                   ; no, handle RAM sound

;--- Play the sound from the DOCRAM

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

                        tya                                                  ; start the oscillators
                        ora         #$a0
                        sta         SOUNDADRL
                        lda         #%00000010                               ; left one shot (which is right)
                        sta         SOUNDDATA
                        tya
                        ora         #$a1
                        sta         SOUNDADRL
                        lda         #%00010010                               ; right one shot (which is left)
                        sta         SOUNDDATA
                        long        m

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

sndINTERRUPT            entry
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

si_continue             lda         dpSOUNDCTL
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
SOUNDDATA               DATA

sndADDRESS              dc          a2'ptrBIGEXPLO'                          ; 0
                        dc          a2'ptrBOMB'                              ; 1
                        dc          a2'ptrBOOMERANG'                         ; 2
                        dc          a2'$0000'                                ; 3
                        dc          a2'$0000'                                ; 4
                        dc          a2'$0000'                                ; 5
                        dc          a2'$0000'                                ; 6
                        dc          a2'$0000'                                ; 7
                        dc          a2'ptrCOINDROP'                          ; 8
                        dc          a2'$0000'                                ; 9
                        dc          a2'$0000'                                ; 10
                        dc          a2'$0000'                                ; 11
                        dc          a2'ptrEXTRALIFE'                         ; 12
                        dc          a2'ptrGAMESTART'                         ; 13
                        dc          a2'ptrHIGHSCORE'                         ; 14
                        dc          a2'ptrNEXTLEVEL'                         ; 15
                        dc          a2'$0000'                                ; 16
                        dc          a2'$0000'                                ; 17
                        dc          a2'$0000'                                ; 18
                        dc          a2'$0000'                                ; 19
                        dc          a2'ptrSTAGECLEAR'                        ; 20
                        dc          a2'ptrTIMEWARP'                          ; 21
                        dc          a2'$0000'                                ; 22
                        dc          a2'$0000'                                ; 23

sndPAGE                 dc          i2'0'                                    ; 0 - number of sound pages - word
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
                        dc          i2'0'                                    ; 15
                        dc          i2'0'                                    ; 16
                        dc          i2'0'                                    ; 17
                        dc          i2'0'                                    ; 18
                        dc          i2'0'                                    ; 19
                        dc          i2'0'                                    ; 20
                        dc          i2'0'                                    ; 21
                        dc          i2'0'                                    ; 22
                        dc          i2'0'                                    ; 23

sndPLAY                 dc          i1'FALSE'                                ; A 0 - in DOCRAM if TRUE, in RAM if FALSE
                        dc          i1'FALSE'                                ; B 1 -
                        dc          i1'FALSE'                                ; C 2 -
                        dc          i1'TRUE'                                 ; D 3 -
                        dc          i1'TRUE'                                 ; E 4 -
                        dc          i1'TRUE'                                 ; F 5 -
                        dc          i1'TRUE'                                 ; G 6 -
                        dc          i1'TRUE'                                 ; H 7 -
                        dc          i1'FALSE'                                ; I 8 -
                        dc          i1'TRUE'                                 ; J 9 -
                        dc          i1'TRUE'                                 ; K 10 -
                        dc          i1'TRUE'                                 ; L 11 -
                        dc          i1'FALSE'                                ; M 12 -
                        dc          i1'FALSE'                                ; N 13 -
                        dc          i1'FALSE'                                ; O 14 -
                        dc          i1'FALSE'                                ; P 15 -
                        dc          i1'TRUE'                                 ; Q 16 -
                        dc          i1'TRUE'                                 ; R 17 -
                        dc          i1'TRUE'                                 ; S 18 -
                        dc          i1'TRUE'                                 ; T 19 -
                        dc          i1'FALSE'                                ; U 20 -
                        dc          i1'FALSE'                                ; V 21 -
                        dc          i1'TRUE'                                 ; W 22 -
                        dc          i1'TRUE'                                 ; X 23 -

snd2OSC                 dc          i1'18'                                   ; A 0 - sound index to oscillator index
                        dc          i1'24'                                   ; B 1
                        dc          i1'24'                                   ; C 2 - boomerang?
                        dc          i1'2'                                    ; D 3
                        dc          i1'2'                                    ; E 4
                        dc          i1'2'                                    ; F 5
                        dc          i1'2'                                    ; G 6
                        dc          i1'2'                                    ; H 7
                        dc          i1'26'                                   ; I 8
                        dc          i1'4'                                    ; J 9
                        dc          i1'6'                                    ; K 10
                        dc          i1'6'                                    ; L 11 - enemy shoot space?
                        dc          i1'22'                                   ; M 12
                        dc          i1'26'                                   ; N 13
                        dc          i1'26'                                   ; O 14
                        dc          i1'20'                                   ; P 15
                        dc          i1'8'                                    ; Q 16
                        dc          i1'10'                                   ; R 17
                        dc          i1'14'                                   ; S 18
                        dc          i1'16'                                   ; T 19
                        dc          i1'26'                                   ; U 20 - stage clear?
                        dc          i1'28'                                   ; V 21
                        dc          i1'0'                                    ; W 22
                        dc          i1'12'                                   ; X 23

;-----------------------------------
; ENSONIQ DATA
;-----------------------------------

; FREQUENCY CONTROL LOW AND HIGH

oscFREQL                dc          h'D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6'
                        dc          h'D6D6D6D6D6D6D6D6D6D6D6D6D6D60000'

oscFREQH                dc          h'00000000000000000000000000000000'
                        dc          h'00000000000000000000000000000000'

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

ptrSOUNDBANK            ds          4

ptrBIGEXPLO             ds          4
ptrBOMB                 ds          4
ptrBOOMERANG            ds          4
ptrBOSS                 ds          4
ptrCOINDROP             ds          4
ptrEXTRALIFE            ds          4
ptrGAMESTART            ds          4
ptrHIGHSCORE            ds          4
ptrNEXTLEVEL            ds          4
ptrSTAGECLEAR           ds          4
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

pSOUNDBANK              dc          i2'15',c'1/snd/soundbank'
pBIGEXPLO               dc          i2'18',c'1/snd/bigexplo.snd'
pBOMB                   dc          i2'14',c'1/snd/bomb.snd'
pBOOMERANG              dc          i2'19',c'1/snd/boomerang.snd'
pBOSS                   dc          i2'16',c'1/snd/bossl0.snd'               ; +12 for the level
pCOINDROP               dc          i2'18',c'1/snd/coindrop.snd'
pEXTRALIFE              dc          i2'19',c'1/snd/extralife.snd'
pGAMESTART              dc          i2'19',c'1/snd/gamestart.snd'
pHIGHSCORE              dc          i2'19',c'1/snd/highscore.snd'
pNEXTLEVEL              dc          i2'19',c'1/snd/nextlevel.snd'
pSTAGECLEAR             dc          i2'20',c'1/snd/stageclear.snd'
pTIMEWARP               dc          i2'18',c'1/snd/timewarp.snd'

thisisformatsounddata_  anop
                        END
