                        MCOPY  src/sprites/SPRCLOUD.mac

SPRCLOUD                START  CLOUD

                        USING  VARIABLES

; MARK: ASTRO0_000A
ASTRO0_000A             ENTRY
                        CLC                              ; 16x12, 265 bytes, 432 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$AAAA                    ; Pattern #1 : 7
                        LDY    #$CAAA                    ; Pattern #2 : 3
                        LDA    #$A9AA                    ; Pattern #3 : 2
                        TCD
;--
                        TXA                              ; Line 0
                        STA    $02,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $A0,S
                        SHORT  M
                        LDA    #$CA
                        STA    $05,S
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 1
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A1,S
                        LONG   M
                        PHY
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    #$CA
                        STA    $A1,S
                        LONG   M
                        PEA    $9CAC
                        PEA    $CC9C
                        PHD
                        TSC                              ; Line 3
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    #$CA
                        STA    $A1,S
                        LONG   M
                        PEA    $A9CC
                        PEA    $9CCC
                        PEA    $ACAA
                        TSC                              ; Line 4
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A1,S
                        LONG   M
                        PHD
                        PEA    $9ACC
                        PEA    $CCAA
                        TSC                              ; Line 5
                        ADC    #$00A6
                        TCS
                        PHX
                        PEA    $C9AC
                        PEA    $CAAC
                        TSC                              ; Line 6
                        ADC    #$00A6
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $9B,S
                        PEA    $AA9A
                        PHY
                        PEA    $AACA
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        TYA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $9C,S
                        PEA    $ACCA
                        PEA    $CCAC
                        TSC                              ; Line 9
                        ADC    #$013F
                        TCS
                        TXA
                        STA    $02,S
                        STA    $A2,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $02,S
;--
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS             ; Restore Stack
                        TCS
                        PLD                              ; Restore Direct Page
                        CLI                              ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: ASTRO0_000B
ASTRO0_000B             ENTRY
                        CLC                              ; 16x12, 307 bytes, 505 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$AAAA                    ; Pattern #1 : 8
                        LDY    #$ACAA                    ; Pattern #2 : 3
                        LDA    #$CACC                    ; Pattern #3 : 2
                        TCD
;--
                        TXA                              ; Line 0
                        STA    $02,S
                        LDA    $05,S
                        AND    #$0FF0
                        ORA    #$A00C
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$A0AC
                        STA    $A5,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 1
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9C,S
                        LONG   M
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00A6
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $9A,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$A09C
                        STA    $A0,S
                        PEA    $CCC9
                        PHD
                        PEA    $99AA
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$AC0A
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$A09C
                        STA    $A1,S
                        PHD
                        PEA    $C9CC
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9B,S
                        LONG   M
                        PHX
                        PEA    $C9CC
                        TSC                              ; Line 5
                        ADC    #$00A5
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $9F,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $9A,S
                        LONG   M
                        PHY
                        PEA    $9ACC
                        PEA    $AACC
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$C0AA
                        STA    $A1,S
                        PEA    $A9AC
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        LDA    #$CAAC
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$A0AC
                        STA    $A0,S
                        PEA    $CCCC
                        PHX
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $03,S
                        TXA
                        STA    $A3,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $03,S
;--
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS             ; Restore Stack
                        TCS
                        PLD                              ; Restore Direct Page
                        CLI                              ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: ASTRO1_000A
ASTRO1_000A             ENTRY
                        CLC                              ; 16x15, 384 bytes, 621 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$AAAA                    ; Pattern #1 : 8
                        LDY    #$ACAA                    ; Pattern #2 : 4
                        LDA    #$AACA                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    #$CAAA                    ; Line 0
                        STA    $A3,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$A0AC
                        STA    $A1,S
                        SHORT  M
                        LDA    #$AA
                        STA    $03,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0144
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$AC0A
                        STA    $9C,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $01,S
                        LONG   M
                        PEA    $9CAA
                        PEA    $CAAA
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$A0CA
                        STA    $A0,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $9B,S
                        LONG   M
                        PEA    $CACC
                        PEA    $99CC
                        TSC                              ; Line 4
                        ADC    #$00A3
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$A0CA
                        STA    $A1,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9C,S
                        LONG   M
                        PEA    $99CC
                        PEA    $ACCC
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9C,S
                        LONG   M
                        PEA    $A9AA
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A6
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $9F,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $9A,S
                        LONG   M
                        PHD
                        PHY
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        PHY
                        PEA    $A9CC
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A1,S
                        LONG   M
                        PEA    $CCAC
                        PEA    $9ACC
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    #$AA
                        STA    $9B,S
                        LONG   M
                        PEA    $CA9C
                        PEA    $C9CC
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A7
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $9F,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9A,S
                        LONG   M
                        PHX
                        PEA    $CACC
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A2,S
                        LONG   M
                        PEA    $CACA
                        PHY
                        TSC                              ; Line 12
                        ADC    #$00A5
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0AC
                        STA    $9F,S
                        PEA    $AACC
                        PHD
                        TSC                              ; Line 14
                        ADC    #$013F
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $02,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $04,S
                        LONG   M
;--
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS             ; Restore Stack
                        TCS
                        PLD                              ; Restore Direct Page
                        CLI                              ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: ASTRO1_000B
ASTRO1_000B             ENTRY
                        CLC                              ; 16x15, 330 bytes, 542 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$AAAA                    ; Pattern #1 : 9
                        LDY    #$CCAA                    ; Pattern #2 : 4
                        LDA    #$AACC                    ; Pattern #3 : 3
                        TCD
;--
                        LDA    #$AAAC                    ; Line 0
                        STA    $A4,S
                        LDA    $03,S
                        AND    #$0FF0
                        ORA    #$A00A
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$F000
                        ORA    #$0ACA
                        STA    $A2,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$A0CC
                        STA    $A5,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $01,S
                        LONG   M
                        TSC
                        ADC    #$0005
                        TCS
                        PEA    $CAA9
                        PEA    $AAAC
                        TSC                              ; Line 3
                        ADC    #$00A3
                        TCS
                        PEA    $9CC9
                        PHY
                        TSC                              ; Line 4
                        ADC    #$00A6
                        TCS
                        PEA    $AA9C
                        PEA    $C9CC
                        PEA    $CACC
                        TSC                              ; Line 5
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A1,S
                        LONG   M
                        PEA    $AA9C
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A6
                        TCS
                        PHD
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $9A,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A0,S
                        LONG   M
                        PEA    $AACA
                        PEA    $AA9A
                        PEA    $CACC
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9B,S
                        LONG   M
                        PHY
                        PEA    $C9CC
                        TSC                              ; Line 9
                        ADC    #$00A5
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $9A,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $A0,S
                        PHD
                        PEA    $99CC
                        PEA    $ACAA
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        PHD
                        PEA    $ACAA
                        TSC                              ; Line 11
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $9C,S
                        LONG   M
                        PHX
                        PEA    $ACCC
                        PHX
                        TSC                              ; Line 12
                        ADC    #$00A6
                        TCS
                        LDA    #$CAAA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $9C,S
                        PEA    $AACA
                        PEA    $ACAA
                        TSC                              ; Line 14
                        ADC    #$013E
                        TCS
                        TXA
                        STA    $03,S
;--
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS             ; Restore Stack
                        TCS
                        PLD                              ; Restore Direct Page
                        CLI                              ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: ASTRO2_000A
ASTRO2_000A             ENTRY
                        CLC                              ; 30x14, 441 bytes, 737 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$AAAA                    ; Pattern #1 : 18
                        LDY    #$CCAA                    ; Pattern #2 : 6
                        LDA    #$AACC                    ; Pattern #3 : 6
                        TCD
;--
                        TXA                              ; Line 0
                        STA    $07,S
                        TDC
                        STA    $A3,S
                        TYA
                        STA    $A7,S
                        LDA    $A5,S
                        AND    #$000F
                        ORA    #$AAC0
                        STA    $A5,S
                        LDA    $A9,S
                        AND    #$F00F
                        ORA    #$0AC0
                        STA    $A9,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $04,S
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0149
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $A1,S
                        PHD
                        PEA    $CCC9
                        PEA    $CAAC
                        PEA    $CACC
                        TSC                              ; Line 3
                        ADC    #$00A8
                        TCS
                        PEA    $AA9A
                        PEA    $CC9C
                        PEA    $ACCC
                        PEA    $AACA
                        TSC                              ; Line 4
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    #$AA
                        STA    $A1,S
                        LONG   M
                        PEA    $CA9C
                        PEA    $A99A
                        PHX
                        PEA    $99AA
                        PEA    $AACA
                        TSC                              ; Line 5
                        ADC    #$00AA
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $A1,S
                        SHORT  M
                        LDA    $96,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $96,S
                        LONG   M
                        PEA    $CC99
                        PEA    $99AC
                        PEA    $99AA
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A2,S
                        LONG   M
                        PEA    $9AAC
                        PEA    $9AA9
                        PEA    $9AA9
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AB
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $94,S
                        PEA    $CACC
                        PEA    $ACCA
                        PEA    $A9AA
                        PEA    $CCCC
                        PEA    $AACA
                        PHY
                        TSC                              ; Line 8
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$AC
                        STA    $94,S
                        LONG   M
                        PHD
                        PEA    $ACAA
                        PEA    $AA9A
                        PEA    $ACAA
                        PEA    $99CA
                        PEA    $CCA9
                        TSC                              ; Line 9
                        ADC    #$00AC
                        TCS
                        PEA    $CCAC
                        PEA    $AACA
                        PEA    $ACAA
                        PEA    $AC99
                        PEA    $A9CC
                        PEA    $CC9C
                        TSC                              ; Line 10
                        ADC    #$00AB
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$CA0C
                        STA    $95,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0CC
                        STA    $9F,S
                        PHX
                        PHD
                        PEA    $CAAC
                        PEA    $A9CA
                        PHY
                        PEA    $9CCC
                        TSC                              ; Line 11
                        ADC    #$00AA
                        TCS
                        LDA    $9C,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $9C,S
                        LDA    $9F,S
                        AND    #$00F0
                        ORA    #$CA0C
                        STA    $9F,S
                        SHORT  M
                        LDA    $97,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $97,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A1,S
                        LONG   M
                        PEA    $ACCA
                        PEA    $ACAA
                        PHD
                        PHX
                        TSC                              ; Line 12
                        ADC    #$00A3
                        TCS
                        LDA    $9D,S
                        AND    #$0FF0
                        ORA    #$A00A
                        STA    $9D,S
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$A00A
                        STA    $A0,S
                        PHX
                        PHX
;--
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS             ; Restore Stack
                        TCS
                        PLD                              ; Restore Direct Page
                        CLI                              ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: ASTRO2_000B
ASTRO2_000B             ENTRY
                        CLC                              ; 30x14, 432 bytes, 727 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$AAAA                    ; Pattern #1 : 24
                        LDY    #$CCAA                    ; Pattern #2 : 6
                        LDA    #$AACA                    ; Pattern #3 : 5
                        TCD
;--
                        TXA                              ; Line 0
                        STA    $07,S
                        LDA    #$ACCA
                        STA    $A4,S
                        LDA    #$CCAC
                        STA    $A8,S
                        LDA    $A6,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $A6,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $05,S
                        LDA    $09,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $09,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A3,S
                        LDA    $AB,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $AB,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$AA0C
                        STA    $A2,S
                        TSC
                        ADC    #$000B
                        TCS
                        PHX
                        PEA    $CACC
                        PEA    $9CAC
                        PHY
                        TSC                              ; Line 3
                        ADC    #$00A8
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$A0CC
                        STA    $A0,S
                        SHORT  M
                        LDA    $97,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $97,S
                        LONG   M
                        PHX
                        PEA    $AAC9
                        PEA    $CCC9
                        PEA    $CAAC
                        TSC                              ; Line 4
                        ADC    #$00A7
                        TCS
                        LDA    $98,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $98,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$A0CA
                        STA    $A2,S
                        PEA    $99AA
                        PEA    $A9AA
                        PEA    $9AA9
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00A9
                        TCS
                        PEA    $9C99
                        PEA    $C99A
                        PEA    $A9AA
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $94,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $94,S
                        LONG   M
                        PHX
                        PEA    $C9AA
                        PEA    $99AA
                        PEA    $99AA
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AC
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$A0CA
                        STA    $A0,S
                        PEA    $AACC
                        PHY
                        PEA    $9CAA
                        PEA    $CACC
                        PEA    $ACAA
                        PEA    $CCAC
                        TSC                              ; Line 8
                        ADC    #$00AB
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$C90A
                        STA    $95,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $A1,S
                        PHY
                        PHX
                        PEA    $C9AA
                        PEA    $9AA9
                        PEA    $CC9C
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AC
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$C90C
                        STA    $95,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHY
                        PEA    $CA9A
                        PEA    $99CA
                        PEA    $CCCC
                        TSC                              ; Line 10
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    #$CC
                        STA    $96,S
                        LONG   M
                        PHX
                        PEA    $CAAC
                        PEA    $CC9A
                        PEA    $AACC
                        PEA    $ACCA
                        TSC                              ; Line 11
                        ADC    #$00AA
                        TCS
                        LDA    #$ACCC
                        STA    $9E,S
                        PEA    $CACC
                        PEA    $AACC
                        PHX
                        PEA    $CAAC
                        PHX
                        TSC                              ; Line 12
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$AA
                        STA    $9C,S
                        STA    $9F,S
                        LONG   M
                        PHX
                        PHX
                        PHX
;--
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS             ; Restore Stack
                        TCS
                        PLD                              ; Restore Direct Page
                        CLI                              ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: CLOUD0_000A
CLOUD0_000A             ENTRY
                        CLC                              ; 16x9, 232 bytes, 379 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$9999                    ; Pattern #1 : 4
                        LDY    #$1191                    ; Pattern #2 : 3
                        LDA    #$1119                    ; Pattern #3 : 2
                        TCD
;--
                        LDA    #$1111                    ; Line 0
                        STA    $A3,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$1901
                        STA    $A1,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$10
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$1091
                        STA    $A5,S
                        SHORT  M
                        LDA    #$11
                        STA    $01,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$09
                        STA    $A0,S
                        LONG   M
                        TSC
                        ADC    #$0005
                        TCS
                        PHD
                        PEA    $9111
                        TSC                              ; Line 3
                        ADC    #$00A3
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $A2,S
                        LONG   M
                        PHD
                        PHY
                        TSC                              ; Line 4
                        ADC    #$00A5
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$9019
                        STA    $A1,S
                        PHY
                        PEA    $9911
                        PEA    $9119
                        TSC                              ; Line 5
                        ADC    #$00A6
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $A1,S
                        PEA    $9191
                        PEA    $9111
                        PEA    $9911
                        TSC                              ; Line 6
                        ADC    #$00A6
                        TCS
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$9009
                        STA    $A0,S
                        PHX
                        PEA    $1991
                        TSC                              ; Line 7
                        ADC    #$00A3
                        TCS
                        LDA    $9E,S
                        AND    #$0FF0
                        ORA    #$9009
                        STA    $9E,S
                        PHX
                        PHX
;--
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS             ; Restore Stack
                        TCS
                        PLD                              ; Restore Direct Page
                        CLI                              ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: CLOUD0_000B
CLOUD0_000B             ENTRY
                        CLC                              ; 16x9, 211 bytes, 350 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$9999                    ; Pattern #1 : 4
                        LDY    #$1119                    ; Pattern #2 : 3
                        LDA    #$1199                    ; Pattern #3 : 3
                        TCD
;--
                        LDA    #$1111                    ; Line 0
                        STA    $03,S
                        LDA    #$9111
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A4,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $03,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $01,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$1091
                        STA    $05,S
                        TSC                              ; Line 3
                        ADC    #$00A6
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$9901
                        STA    $9A,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        PHY
                        PEA    $9111
                        PHD
                        TSC                              ; Line 4
                        ADC    #$00A5
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$1901
                        STA    $9B,S
                        PHD
                        PEA    $1911
                        TSC                              ; Line 5
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    #$99
                        STA    $9A,S
                        LONG   M
                        PEA    $9911
                        PEA    $1919
                        PEA    $1991
                        TSC                              ; Line 6
                        ADC    #$00A6
                        TCS
                        TXA
                        STA    $9C,S
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $9A,S
                        LDA    $9E,S
                        AND    #$000F
                        ORA    #$9990
                        STA    $9E,S
                        PHX
                        PHX
                        PHD
                        TSC                              ; Line 8
                        ADC    #$013F
                        TCS
                        SHORT  M
                        LDA    #$99
                        STA    $03,S
                        LONG   M
;--
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS             ; Restore Stack
                        TCS
                        PLD                              ; Restore Direct Page
                        CLI                              ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: CLOUD1_000A
CLOUD1_000A             ENTRY
                        CLC                              ; 30x14, 389 bytes, 710 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 50
                        LDY    #$9999                    ; Pattern #2 : 16
                        LDA    #$1191                    ; Pattern #3 : 9
                        TCD
;--
                        TXA                              ; Line 0
                        STA    $08,S
                        STA    $A8,S
                        LDA    #$9111
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $A6,S
                        SHORT  M
                        LDA    #$11
                        STA    $05,S
                        STA    $A3,S
                        LDA    $07,S
                        AND    #$F0
                        ORA    #$01
                        STA    $07,S
                        LDA    $AA,S
                        AND    #$0F
                        ORA    #$10
                        STA    $AA,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $02,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$09
                        STA    $A2,S
                        LONG   M
                        TSC
                        ADC    #$000B
                        TCS
                        PEA    $1199
                        PHX
                        PEA    $9199
                        PEA    $1911
                        TSC                              ; Line 3
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $A0,S
                        LONG   M
                        PHX
                        PEA    $9119
                        PHX
                        PEA    $1199
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9199
                        TSC                              ; Line 5
                        ADC    #$00AB
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $94,S
                        PEA    $9911
                        PHX
                        PHX
                        PHX
                        PEA    $1199
                        PEA    $1911
                        TSC                              ; Line 6
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $93,S
                        PEA    $9119
                        PHX
                        PHD
                        PEA    $1911
                        PHX
                        PHY
                        TSC                              ; Line 7
                        ADC    #$00AC
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHX
                        PHD
                        PEA    $1911
                        PHX
                        PHY
                        TSC                              ; Line 8
                        ADC    #$00AC
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $1199
                        PEA    $1119
                        TSC                              ; Line 9
                        ADC    #$00AE
                        TCS
                        PHX
                        PEA    $1911
                        PHX
                        PHX
                        PHX
                        PEA    $9199
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00AE
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$9091
                        STA    $9F,S
                        PHD
                        PEA    $1911
                        PEA    $1199
                        PHD
                        PHD
                        PEA    $9919
                        PEA    $1119
                        TSC                              ; Line 11
                        ADC    #$00AC
                        TCS
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$09
                        STA    $95,S
                        LONG   M
                        PHY
                        PEA    $9191
                        PHY
                        PEA    $1999
                        PEA    $9119
                        PHY
                        TSC                              ; Line 12
                        ADC    #$00AD
                        TCS
                        LDA    $96,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $96,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $9C,S
                        SHORT  M
                        LDA    #$99
                        STA    $99,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
;--
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS             ; Restore Stack
                        TCS
                        PLD                              ; Restore Direct Page
                        CLI                              ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: CLOUD1_000B
CLOUD1_000B             ENTRY
                        CLC                              ; 30x14, 449 bytes, 799 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 49
                        LDY    #$9999                    ; Pattern #2 : 16
                        LDA    #$1191                    ; Pattern #3 : 8
                        TCD
;--
                        TXA                              ; Line 0
                        STA    $08,S
                        STA    $A9,S
                        LDA    #$1119
                        STA    $A5,S
                        LDA    $05,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $05,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A3,S
                        LDA    $A7,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A7,S
                        SHORT  M
                        LDA    $0A,S
                        AND    #$0F
                        ORA    #$10
                        STA    $0A,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$014A
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$1091
                        STA    $01,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A3,S
                        LONG   M
                        PEA    $1911
                        PEA    $1199
                        PEA    $9911
                        PHX
                        TSC                              ; Line 3
                        ADC    #$00AA
                        TCS
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $96,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        PHX
                        PEA    $9911
                        PHX
                        PEA    $9119
                        PHD
                        TSC                              ; Line 4
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $96,S
                        AND    #$F0
                        ORA    #$01
                        STA    $96,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00AA
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1099
                        STA    $A0,S
                        PEA    $9119
                        PHX
                        PHX
                        PHX
                        PHD
                        PEA    $9911
                        TSC                              ; Line 6
                        ADC    #$00AB
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A1,S
                        PHX
                        PHX
                        PEA    $9911
                        PHX
                        PEA    $9199
                        PEA    $1911
                        TSC                              ; Line 7
                        ADC    #$00AC
                        TCS
                        SHORT  M
                        LDA    $94,S
                        AND    #$F0
                        ORA    #$01
                        STA    $94,S
                        LONG   M
                        PHX
                        PHX
                        PEA    $9911
                        PHX
                        PEA    $9199
                        PEA    $1911
                        TSC                              ; Line 8
                        ADC    #$00AE
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $92,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHD
                        PEA    $1991
                        TSC                              ; Line 9
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9101
                        STA    $93,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
                        PHD
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9919
                        TSC                              ; Line 10
                        ADC    #$00AC
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $93,S
                        PEA    $1199
                        PHX
                        PEA    $9119
                        PEA    $1119
                        PEA    $1199
                        PEA    $9911
                        TSC                              ; Line 11
                        ADC    #$00AC
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A0,S
                        LONG   M
                        PEA    $1999
                        PEA    $9919
                        PEA    $1999
                        PHY
                        PEA    $9119
                        PEA    $9991
                        TSC                              ; Line 12
                        ADC    #$00AB
                        TCS
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $96,S
                        LDA    $99,S
                        AND    #$0FF0
                        ORA    #$9009
                        STA    $99,S
                        LDA    $9D,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $9D,S
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
;--
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS             ; Restore Stack
                        TCS
                        PLD                              ; Restore Direct Page
                        CLI                              ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: CLOUD2_000A
CLOUD2_000A             ENTRY
                        CLC                              ; 46x16, 618 bytes, 1134 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 81
                        LDY    #$9999                    ; Pattern #2 : 27
                        LDA    #$1911                    ; Pattern #3 : 14
                        TCD
;--
                        TXA                              ; Line 0
                        STA    $AB,S
                        STA    $B1,S
                        LDA    $0B,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $0B,S
                        LDA    $11,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $11,S
                        LDA    $A7,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A7,S
                        LDA    $A9,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $A9,S
                        LDA    $AF,S
                        AND    #$F000
                        ORA    #$0119
                        STA    $AF,S
                        SHORT  M
                        LDA    #$11
                        STA    $A5,S
                        LDA    $AD,S
                        AND    #$0F
                        ORA    #$10
                        STA    $AD,S
                        LDA    $B3,S
                        AND    #$0F
                        ORA    #$10
                        STA    $B3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$9111
                        STA    $04,S
                        LDA    $06,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $06,S
                        LDA    $0E,S
                        AND    #$00F0
                        ORA    #$1901
                        STA    $0E,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A2,S
                        SHORT  M
                        LDA    #$11
                        STA    $03,S
                        LDA    $B4,S
                        AND    #$0F
                        ORA    #$10
                        STA    $B4,S
                        LONG   M
                        TSC
                        ADC    #$000D
                        TCS
                        PHX
                        PEA    $9199
                        PEA    $9111
                        TSC
                        ADC    #$000C
                        TCS
                        PEA    $9911
                        PEA    $1191
                        TSC                              ; Line 3
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $8F,S
                        AND    #$F0
                        ORA    #$09
                        STA    $8F,S
                        LONG   M
                        PEA    $9119
                        PHX
                        PEA    $1991
                        PEA    $1991
                        PHY
                        PEA    $1119
                        PEA    $9199
                        PHD
                        TSC                              ; Line 4
                        ADC    #$00B1
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $A0,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PEA    $1199
                        PEA    $9919
                        PHX
                        PHX
                        PEA    $1199
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00B1
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        PHX
                        PHX
                        PEA    $1119
                        PEA    $1199
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9199
                        TSC                              ; Line 6
                        ADC    #$00B3
                        TCS
                        LDA    $8C,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $8C,S
                        PHD
                        PHX
                        PEA    $1991
                        PHX
                        PEA    $9119
                        PHX
                        PHX
                        PHX
                        PEA    $1199
                        PHD
                        TSC                              ; Line 7
                        ADC    #$00B5
                        TCS
                        LDA    $8B,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $8B,S
                        PHX
                        PEA    $1191
                        PEA    $9919
                        PEA    $9111
                        PHX
                        PEA    $9911
                        PHX
                        PHX
                        PHX
                        PHY
                        TSC                              ; Line 8
                        ADC    #$00B4
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $9F,S
                        PEA    $9111
                        PEA    $1191
                        PHY
                        PEA    $9119
                        PHX
                        PEA    $9919
                        PHX
                        PHX
                        PHX
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00B2
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A1,S
                        PHX
                        PEA    $1199
                        PHX
                        PEA    $1191
                        PHY
                        PHX
                        PHX
                        PHX
                        PEA    $1199
                        PEA    $1119
                        TSC                              ; Line 10
                        ADC    #$00B4
                        TCS
                        SHORT  M
                        LDA    #$19
                        STA    $8D,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PEA    $1199
                        PEA    $1191
                        PHD
                        PHX
                        PHX
                        PEA    $9199
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00B5
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A0,S
                        LONG   M
                        PEA    $1119
                        PEA    $1119
                        PEA    $9119
                        PEA    $9119
                        PHX
                        PHX
                        PHX
                        PEA    $9111
                        PEA    $9199
                        PHD
                        TSC                              ; Line 12
                        ADC    #$00B3
                        TCS
                        LDA    $8D,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $8D,S
                        PEA    $9919
                        PEA    $1991
                        PHY
                        PHD
                        PEA    $1191
                        PHX
                        PHY
                        PEA    $1999
                        PEA    $9119
                        PHY
                        TSC                              ; Line 13
                        ADC    #$00B4
                        TCS
                        LDA    $8F,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $8F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $9D,S
                        SHORT  M
                        LDA    #$99
                        STA    $92,S
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$90
                        STA    $9F,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PEA    $9991
                        PHY
                        PEA    $1199
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 14
                        ADC    #$00AC
                        TCS
                        LDA    $9C,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $9C,S
                        LDA    $9F,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $9F,S
                        PHY
                        PHY
                        PHY
;--
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS             ; Restore Stack
                        TCS
                        PLD                              ; Restore Direct Page
                        CLI                              ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: CLOUD2_000B
CLOUD2_000B             ENTRY
                        CLC                              ; 46x16, 620 bytes, 1143 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 80
                        LDY    #$9999                    ; Pattern #2 : 27
                        LDA    #$1191                    ; Pattern #3 : 17
                        TCD
;--
                        TXA                              ; Line 0
                        STA    $A8,S
                        STA    $AC,S
                        STA    $B1,S
                        LDA    $0B,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $0B,S
                        LDA    $A5,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A5,S
                        LDA    $AA,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $AA,S
                        LDA    $AF,S
                        AND    #$0FF0
                        ORA    #$9001
                        STA    $AF,S
                        SHORT  M
                        LDA    #$11
                        STA    $12,S
                        STA    $B3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$1119
                        STA    $05,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $03,S
                        LDA    $0E,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $0E,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$F0
                        ORA    #$01
                        STA    $07,S
                        LDA    $14,S
                        AND    #$0F
                        ORA    #$90
                        STA    $14,S
                        LONG   M
                        TSC
                        ADC    #$000D
                        TCS
                        PHX
                        PEA    $9919
                        PEA    $1911
                        TSC
                        ADC    #$000C
                        TCS
                        PEA    $1911
                        PEA    $1199
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
                        PEA    $1199
                        PHX
                        PEA    $9111
                        PEA    $9911
                        PHY
                        PEA    $1991
                        PEA    $1199
                        PEA    $9911
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00B2
                        TCS
                        LDA    $8E,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $8E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        PHX
                        PHX
                        PHX
                        PEA    $9199
                        PEA    $9911
                        PHX
                        PHX
                        PEA    $9119
                        PHD
                        TSC                              ; Line 5
                        ADC    #$00B1
                        TCS
                        SHORT  M
                        LDA    $8E,S
                        AND    #$F0
                        ORA    #$01
                        STA    $8E,S
                        LONG   M
                        PHX
                        PHX
                        PEA    $9111
                        PEA    $9119
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00B2
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        PEA    $9111
                        PHX
                        PEA    $9111
                        PEA    $1911
                        PEA    $1199
                        PHX
                        PHX
                        PHX
                        PHD
                        PEA    $9911
                        TSC                              ; Line 7
                        ADC    #$00B3
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1019
                        STA    $A1,S
                        PHX
                        PHY
                        PEA    $1119
                        PHX
                        PEA    $9119
                        PHX
                        PHX
                        PHX
                        PEA    $9199
                        PEA    $1911
                        TSC                              ; Line 8
                        ADC    #$00B4
                        TCS
                        LDA    $8C,S
                        AND    #$00F0
                        ORA    #$9101
                        STA    $8C,S
                        PHX
                        PHY
                        PEA    $1999
                        PHX
                        PEA    $9199
                        PHX
                        PHX
                        PHX
                        PEA    $9199
                        PEA    $1911
                        TSC                              ; Line 9
                        ADC    #$00B5
                        TCS
                        LDA    $8B,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $8B,S
                        PHX
                        PHX
                        PEA    $9119
                        PHX
                        PEA    $1199
                        PEA    $9919
                        PHX
                        PHX
                        PHX
                        PEA    $9119
                        TSC                              ; Line 10
                        ADC    #$00B4
                        TCS
                        LDA    $8B,S
                        AND    #$00F0
                        ORA    #$9101
                        STA    $8B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$1091
                        STA    $9F,S
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9119
                        PEA    $1199
                        PHX
                        PHX
                        PHX
                        PEA    $9919
                        TSC                              ; Line 11
                        ADC    #$00B2
                        TCS
                        SHORT  M
                        LDA    $8D,S
                        AND    #$F0
                        ORA    #$09
                        STA    $8D,S
                        LONG   M
                        LDA    #$1199
                        PHD
                        PHA
                        PHA
                        PHX
                        PHX
                        PHX
                        PEA    $1119
                        PHA
                        PEA    $9911
                        TSC                              ; Line 12
                        ADC    #$00B3
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $9F,S
                        PHY
                        PEA    $9111
                        PHY
                        PEA    $9911
                        PHX
                        PEA    $1911
                        PEA    $9199
                        PEA    $9991
                        PEA    $1999
                        PEA    $9199
                        TSC                              ; Line 13
                        ADC    #$00B2
                        TCS
                        TYA
                        STA    $9F,S
                        LDA    $90,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $90,S
                        LDA    $93,S
                        AND    #$0FF0
                        ORA    #$9009
                        STA    $93,S
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $96,S
                        LDA    $9C,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $9C,S
                        PHY
                        PHY
                        PEA    $9919
                        PHY
                        PEA    $1991
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 14
                        ADC    #$00AD
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $A0,S
                        PHY
                        PHY
;--
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS             ; Restore Stack
                        TCS
                        PLD                              ; Restore Direct Page
                        CLI                              ; Enable Interrupts
                        RTL

;-----------------------------------

THISISAFORMATTINGLABEL  ANOP
                        END
