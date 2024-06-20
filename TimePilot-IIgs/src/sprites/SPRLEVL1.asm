                        MCOPY  src/sprites/SPRLEVL1.mac

SPRLEVL1                START  LEVL1

                        USING  VARIABLES

; MARK: BOMBER_000A
BOMBER_000A             ENTRY
                        CLC                              ; 28x9, 255 bytes, 424 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCCC                    ; Pattern #1 : 9
                        LDY    #$CACC                    ; Pattern #2 : 6
                        LDA    #$AACA                    ; Pattern #3 : 5
                        TCD
;--
                        LDA    $00,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $A0,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$CCAA
                        STA    $00,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $02,S
                        LDA    $08,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $08,S
                        LDA    $AA,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $AA,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A9
                        TCS
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $A2,S
                        SHORT  M
                        LDA    #$AC
                        STA    $97,S
                        LONG   M
                        PEA    $CCCD
                        PEA    $ACAA
                        PHY
                        PHX
                        PEA    $ACAA
                        TSC                              ; Line 4
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $98,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $98,S
                        LONG   M
                        PEA    $CDAA
                        PEA    $AAAA
                        PHY
                        PEA    $ACCC
                        TSC                              ; Line 5
                        ADC    #$00AC
                        TCS
                        LDA    #$CCAC
                        STA    $96,S
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $95,S
                        LDA    $98,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $98,S
                        LONG   M
                        PHD
                        PHX
                        PEA    $AACC
                        PEA    $CCAA
                        PHX
                        PEA    $CCAA
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $9F,S
                        PEA    $AAAA
                        PHY
                        PEA    $AECA
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $9E,S
                        LONG   M
                        PHX
                        PEA    $CECC
                        PHD
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
; MARK: BOMBER_000B
BOMBER_000B             ENTRY
                        CLC                              ; 28x9, 262 bytes, 435 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCCC                    ; Pattern #1 : 8
                        LDY    #$AACC                    ; Pattern #2 : 6
                        LDA    #$CCAC                    ; Pattern #3 : 5
                        TCD
;--
                        LDA    $A1,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$C0AC
                        STA    $A1,S
                        SHORT  M
                        LDA    #$CC
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $01,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $00,S
                        LDA    $09,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $09,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00AA
                        TCS
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $96,S
                        LDA    $9E,S
                        AND    #$0F00
                        ORA    #$D0AC
                        STA    $9E,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $A1,S
                        PEA    $CCDC
                        PEA    $CCAA
                        PHY
                        PHX
                        PEA    $CCAA
                        TSC                              ; Line 4
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A6,S
                        LONG   M
                        PEA    $AAAA
                        PHY
                        PEA    $CCCA
                        TSC                              ; Line 5
                        ADC    #$00AB
                        TCS
                        LDA    #$CCAA
                        STA    $96,S
                        SHORT  M
                        LDA    $98,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $98,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A1,S
                        LONG   M
                        PHY
                        PHD
                        PEA    $CACC
                        PEA    $ACCA
                        PHX
                        PEA    $ACAA
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        LDA    $97,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $97,S
                        PEA    $AAAA
                        PEA    $CCEC
                        PHY
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $9D,S
                        LONG   M
                        PEA    $AACA
                        PEA    $CCEC
                        PHD
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
; MARK: BOMBER_001A
BOMBER_001A             ENTRY
                        CLC                              ; 28x9, 267 bytes, 438 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCCC                    ; Pattern #1 : 6
                        LDY    #$CCAC                    ; Pattern #2 : 4
                        LDA    #$CACC                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $00,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $A0,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$CCAA
                        STA    $00,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $02,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$01
                        STA    $05,S
                        LDA    $08,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $08,S
                        LDA    $AA,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $AA,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A9
                        TCS
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $A2,S
                        SHORT  M
                        LDA    #$CD
                        STA    $9F,S
                        LONG   M
                        PEA    $CCCD
                        PEA    $AC1A
                        PEA    $1AC1
                        PHX
                        PEA    $ACAA
                        TSC                              ; Line 4
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $99,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $99,S
                        LONG   M
                        PEA    $AA1A
                        PEA    $11C1
                        PHY
                        PHY
                        TSC                              ; Line 5
                        ADC    #$00AD
                        TCS
                        TYA
                        STA    $96,S
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $95,S
                        LDA    $98,S
                        AND    #$F0
                        ORA    #$01
                        STA    $98,S
                        LONG   M
                        PEA    $AACA
                        PHX
                        PEA    $AA1C
                        PEA    $11A1
                        PHX
                        PEA    $CCAA
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $9F,S
                        PEA    $AAAA
                        PHD
                        PEA    $AECA
                        PEA    $CC11
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $9E,S
                        LONG   M
                        PHX
                        PEA    $CECC
                        PEA    $AACA
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
; MARK: BOMBER_001B
BOMBER_001B             ENTRY
                        CLC                              ; 28x9, 276 bytes, 450 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCCC                    ; Pattern #1 : 5
                        LDY    #$AACC                    ; Pattern #2 : 4
                        LDA    #$CCAC                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $A1,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$C0AC
                        STA    $A1,S
                        SHORT  M
                        LDA    #$CC
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $01,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $00,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$10
                        STA    $06,S
                        LDA    $09,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $09,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00AA
                        TCS
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $96,S
                        LDA    $9E,S
                        AND    #$0F00
                        ORA    #$D0AC
                        STA    $9E,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $A1,S
                        PEA    $CCDC
                        PEA    $CCAA
                        PEA    $A111
                        PHX
                        PEA    $CCAA
                        TSC                              ; Line 4
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A6,S
                        LONG   M
                        PEA    $AA11
                        PEA    $11CC
                        PEA    $CCCA
                        TSC                              ; Line 5
                        ADC    #$00AB
                        TCS
                        LDA    #$CCAA
                        STA    $96,S
                        SHORT  M
                        LDA    $98,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $98,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A1,S
                        LONG   M
                        PHY
                        PHD
                        PEA    $CA11
                        PEA    $11CA
                        PHX
                        PEA    $ACAA
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        LDA    $97,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $97,S
                        PEA    $AAAA
                        PEA    $CCEC
                        PHY
                        PEA    $1C11
                        TSC                              ; Line 7
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $9D,S
                        LONG   M
                        PEA    $AACA
                        PEA    $CCEC
                        PHD
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
; MARK: BOMBER_002A
BOMBER_002A             ENTRY
                        CLC                              ; 28x9, 281 bytes, 452 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCAC                    ; Pattern #1 : 4
                        LDY    #$CCAA                    ; Pattern #2 : 4
                        LDA    #$CACC                    ; Pattern #3 : 3
                        TCD
;--
                        LDA    $00,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $A0,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $00,S
                        SHORT  M
                        LDA    #$11
                        STA    $05,S
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $02,S
                        LDA    $08,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $08,S
                        LDA    $AA,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $AA,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A9
                        TCS
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $A2,S
                        SHORT  M
                        LDA    #$CD
                        STA    $9F,S
                        LONG   M
                        PEA    $CCCD
                        PEA    $ACAA
                        PEA    $C111
                        PEA    $CCCC
                        PEA    $ACAA
                        TSC                              ; Line 4
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $99,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $99,S
                        LONG   M
                        PEA    $AA1A
                        PEA    $11C1
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00AD
                        TCS
                        TXA
                        STA    $96,S
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $95,S
                        LDA    $98,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $98,S
                        LONG   M
                        PEA    $AACA
                        PEA    $CCCC
                        PEA    $AA1C
                        PEA    $1111
                        PEA    $1CC1
                        PHY
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $9F,S
                        PEA    $AAAA
                        PHD
                        PEA    $AECA
                        PEA    $CC11
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $9E,S
                        LONG   M
                        PEA    $CCCC
                        PEA    $CECC
                        PEA    $AACA
                        PEA    $11CC
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
; MARK: BOMBER_002B
BOMBER_002B             ENTRY
                        CLC                              ; 28x9, 292 bytes, 469 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCAC                    ; Pattern #1 : 4
                        LDY    #$CCCC                    ; Pattern #2 : 3
                        LDA    #$AACC                    ; Pattern #3 : 3
                        TCD
;--
                        LDA    $A1,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$C0AC
                        STA    $A1,S
                        SHORT  M
                        LDA    #$CC
                        STA    $01,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $05,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $05,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $00,S
                        LDA    $09,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $09,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00AA
                        TCS
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $96,S
                        LDA    $9E,S
                        AND    #$0F00
                        ORA    #$D0AC
                        STA    $9E,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $A1,S
                        PEA    $CCDC
                        PEA    $CCAA
                        PEA    $1A1C
                        PEA    $C1CC
                        PEA    $CCAA
                        TSC                              ; Line 4
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A6,S
                        LONG   M
                        PEA    $AA11
                        PEA    $11CC
                        PEA    $CCCA
                        TSC                              ; Line 5
                        ADC    #$00AB
                        TCS
                        LDA    #$CCAA
                        STA    $96,S
                        SHORT  M
                        LDA    $98,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $98,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A1,S
                        LONG   M
                        PHD
                        PHX
                        PEA    $CA11
                        PEA    $11C1
                        PEA    $11CC
                        PEA    $ACAA
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        LDA    $97,S
                        AND    #$00F0
                        ORA    #$C10C
                        STA    $97,S
                        PEA    $AAAA
                        PEA    $CCEC
                        PHD
                        PEA    $1CC1
                        TSC                              ; Line 7
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $9D,S
                        LONG   M
                        PEA    $AACA
                        PEA    $CCEC
                        PHX
                        PEA    $AA1C
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
; MARK: BOMBER_003A
BOMBER_003A             ENTRY
                        CLC                              ; 28x9, 295 bytes, 473 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 4
                        LDY    #$AA1A                    ; Pattern #2 : 3
                        LDA    #$CCAA                    ; Pattern #3 : 3
                        TCD
;--
                        LDA    $00,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $A0,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $00,S
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $03,S
                        SHORT  M
                        LDA    #$C1
                        STA    $02,S
                        LDA    $08,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $08,S
                        LDA    $AA,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $AA,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A9
                        TCS
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $A2,S
                        SHORT  M
                        LDA    #$CD
                        STA    $9F,S
                        LONG   M
                        PEA    $CCCD
                        PEA    $ACAA
                        PEA    $1A1C
                        PEA    $C1CC
                        PEA    $ACAA
                        TSC                              ; Line 4
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $99,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $99,S
                        LONG   M
                        PHY
                        PHX
                        PEA    $11AC
                        PEA    $CCAC
                        TSC                              ; Line 5
                        ADC    #$00AD
                        TCS
                        TXA
                        STA    $96,S
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$01
                        STA    $95,S
                        LDA    $98,S
                        AND    #$F0
                        ORA    #$01
                        STA    $98,S
                        LONG   M
                        PEA    $AACA
                        PEA    $CCCC
                        PEA    $AA1C
                        PHX
                        PEA    $C1C1
                        PEA    $C1AA
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$CC01
                        STA    $96,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A0,S
                        LONG   M
                        PEA    $AAAA
                        PEA    $CACC
                        PEA    $AECA
                        PEA    $CC11
                        TSC                              ; Line 7
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $98,S
                        LDA    $9A,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9A,S
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $9D,S
                        LONG   M
                        PEA    $AACC
                        PEA    $CCCE
                        PHD
                        PEA    $1A1C
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
; MARK: BOMBER_003B
BOMBER_003B             ENTRY
                        CLC                              ; 28x9, 295 bytes, 474 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 5
                        LDY    #$AACC                    ; Pattern #2 : 3
                        LDA    #$CCCC                    ; Pattern #3 : 2
                        TCD
;--
                        LDA    $A1,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$C0AC
                        STA    $A1,S
                        SHORT  M
                        LDA    #$CC
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$11CC
                        STA    $02,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$AC0A
                        STA    $00,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$10
                        STA    $05,S
                        LDA    $09,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $09,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00AA
                        TCS
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $96,S
                        LDA    $9E,S
                        AND    #$0F00
                        ORA    #$D0AC
                        STA    $9E,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $A1,S
                        PEA    $CCDC
                        PEA    $CCAA
                        PEA    $AAC1
                        PEA    $11CC
                        PEA    $CCAA
                        TSC                              ; Line 4
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A6,S
                        LONG   M
                        PEA    $AA11
                        PHX
                        PEA    $C1CA
                        TSC                              ; Line 5
                        ADC    #$00AB
                        TCS
                        TXA
                        STA    $96,S
                        SHORT  M
                        LDA    $98,S
                        AND    #$0F
                        ORA    #$10
                        STA    $98,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A1,S
                        LONG   M
                        PHY
                        PEA    $CCAC
                        PEA    $CA11
                        PHX
                        PEA    $1C1C
                        PEA    $ACAA
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        PEA    $AAAA
                        PEA    $CCEC
                        PHY
                        PEA    $1C11
                        TSC                              ; Line 7
                        ADC    #$00A8
                        TCS
                        LDA    $97,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $97,S
                        SHORT  M
                        LDA    $99,S
                        AND    #$F0
                        ORA    #$01
                        STA    $99,S
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $9D,S
                        LONG   M
                        PEA    $AACA
                        PEA    $CCEC
                        PEA    $CCAC
                        PEA    $AAC1
                        PEA    $C11C
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
; MARK: BOMBER_004A
BOMBER_004A             ENTRY
                        CLC                              ; 28x9, 253 bytes, 423 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCCC                    ; Pattern #1 : 9
                        LDY    #$CCAC                    ; Pattern #2 : 6
                        LDA    #$AACC                    ; Pattern #3 : 5
                        TCD
;--
                        LDA    $0B,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $0B,S
                        LDA    $AB,S
                        AND    #$0F00
                        ORA    #$A0CC
                        STA    $AB,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $0B,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $04,S
                        LDA    $0A,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $0A,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00AC
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $94,S
                        SHORT  M
                        LDA    #$CA
                        STA    $A0,S
                        LONG   M
                        PEA    $AACA
                        PHX
                        PHY
                        PEA    $AACA
                        PEA    $DCCC
                        TSC                              ; Line 4
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A1,S
                        LONG   M
                        PEA    $CCCA
                        PHY
                        PEA    $AAAA
                        PEA    $AADC
                        TSC                              ; Line 5
                        ADC    #$00A8
                        TCS
                        LDA    #$CACC
                        STA    $9E,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $9D,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A0,S
                        LONG   M
                        PHD
                        PHX
                        PHD
                        PEA    $CCAA
                        PHX
                        PEA    $ACAA
                        TSC                              ; Line 6
                        ADC    #$00A8
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $99,S
                        PHX
                        PEA    $ACEA
                        PHY
                        PEA    $AAAA
                        TSC                              ; Line 7
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $9B,S
                        LONG   M
                        PHX
                        PEA    $ACAA
                        PEA    $CCEC
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
; MARK: BOMBER_004B
BOMBER_004B             ENTRY
                        CLC                              ; 28x9, 262 bytes, 435 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCCC                    ; Pattern #1 : 8
                        LDY    #$CCAA                    ; Pattern #2 : 6
                        LDA    #$CACC                    ; Pattern #3 : 5
                        TCD
;--
                        LDA    $AB,S                     ; Line 0
                        AND    #$00F0
                        ORA    #$CA0C
                        STA    $AB,S
                        SHORT  M
                        LDA    #$CC
                        STA    $0C,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $0B,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $04,S
                        LDA    $0D,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $0D,S
                        LDA    $AD,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $AD,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00AC
                        TCS
                        LDA    $95,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $95,S
                        LDA    $98,S
                        AND    #$00F0
                        ORA    #$CA0D
                        STA    $98,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$A0CC
                        STA    $A0,S
                        PEA    $AACC
                        PHX
                        PHY
                        PEA    $AACC
                        PEA    $CDCC
                        TSC                              ; Line 4
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $95,S
                        LONG   M
                        PEA    $ACCC
                        PHY
                        PEA    $AAAA
                        TSC                              ; Line 5
                        ADC    #$00A7
                        TCS
                        LDA    #$AACC
                        STA    $9E,S
                        SHORT  M
                        LDA    $94,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $94,S
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $9D,S
                        LONG   M
                        PEA    $AACA
                        PHX
                        PEA    $ACCA
                        PEA    $CCAC
                        PHD
                        PHY
                        TSC                              ; Line 6
                        ADC    #$00A8
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $A1,S
                        PHX
                        PHY
                        PEA    $CECC
                        PEA    $AAAA
                        TSC                              ; Line 7
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $9C,S
                        LONG   M
                        PHY
                        PHD
                        PEA    $CECC
                        PEA    $ACAA
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
; MARK: BOMBER_005A
BOMBER_005A             ENTRY
                        CLC                              ; 28x9, 265 bytes, 437 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCCC                    ; Pattern #1 : 6
                        LDY    #$CACC                    ; Pattern #2 : 4
                        LDA    #$AACC                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $0B,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $0B,S
                        LDA    $AB,S
                        AND    #$0F00
                        ORA    #$A0CC
                        STA    $AB,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $0B,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $04,S
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$10
                        STA    $07,S
                        LDA    $0A,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $0A,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00AC
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $94,S
                        SHORT  M
                        LDA    #$DC
                        STA    $98,S
                        LONG   M
                        PEA    $AACA
                        PHX
                        PEA    $1CA1
                        PEA    $A1CA
                        PEA    $DCCC
                        TSC                              ; Line 4
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A0,S
                        LONG   M
                        PHY
                        PHY
                        PEA    $1C11
                        PEA    $A1AA
                        TSC                              ; Line 5
                        ADC    #$00A7
                        TCS
                        TYA
                        STA    $9E,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9D,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A0,S
                        LONG   M
                        PHD
                        PHX
                        PEA    $1A11
                        PEA    $C1AA
                        PHX
                        PEA    $ACAA
                        TSC                              ; Line 6
                        ADC    #$00A8
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $99,S
                        PEA    $11CC
                        PEA    $ACEA
                        PEA    $CCAC
                        PEA    $AAAA
                        TSC                              ; Line 7
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $9B,S
                        LONG   M
                        PHX
                        PEA    $ACAA
                        PEA    $CCEC
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
; MARK: BOMBER_005B
BOMBER_005B             ENTRY
                        CLC                              ; 28x9, 276 bytes, 450 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCCC                    ; Pattern #1 : 5
                        LDY    #$CCAA                    ; Pattern #2 : 4
                        LDA    #$CACC                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $AB,S                     ; Line 0
                        AND    #$00F0
                        ORA    #$CA0C
                        STA    $AB,S
                        SHORT  M
                        LDA    #$CC
                        STA    $0C,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $0B,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $04,S
                        LDA    $07,S
                        AND    #$F0
                        ORA    #$01
                        STA    $07,S
                        LDA    $0D,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $0D,S
                        LDA    $AD,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $AD,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00AC
                        TCS
                        LDA    $95,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $95,S
                        LDA    $98,S
                        AND    #$00F0
                        ORA    #$CA0D
                        STA    $98,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$A0CC
                        STA    $A0,S
                        PEA    $AACC
                        PHX
                        PEA    $111A
                        PEA    $AACC
                        PEA    $CDCC
                        TSC                              ; Line 4
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $95,S
                        LONG   M
                        PEA    $ACCC
                        PEA    $CC11
                        PEA    $11AA
                        TSC                              ; Line 5
                        ADC    #$00A7
                        TCS
                        LDA    #$AACC
                        STA    $9E,S
                        SHORT  M
                        LDA    $94,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $94,S
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $9D,S
                        LONG   M
                        PEA    $AACA
                        PHX
                        PEA    $AC11
                        PEA    $11AC
                        PHD
                        PHY
                        TSC                              ; Line 6
                        ADC    #$00A8
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $A1,S
                        PEA    $11C1
                        PHY
                        PEA    $CECC
                        PEA    $AAAA
                        TSC                              ; Line 7
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $9C,S
                        LONG   M
                        PHY
                        PHD
                        PEA    $CECC
                        PEA    $ACAA
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
; MARK: BOMBER_006A
BOMBER_006A             ENTRY
                        CLC                              ; 28x9, 279 bytes, 451 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CACC                    ; Pattern #1 : 4
                        LDY    #$AACC                    ; Pattern #2 : 4
                        LDA    #$ACAA                    ; Pattern #3 : 3
                        TCD
;--
                        LDA    $0B,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $0B,S
                        LDA    $AB,S
                        AND    #$0F00
                        ORA    #$A0CC
                        STA    $AB,S
                        SHORT  M
                        LDA    $A8,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A8,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $0B,S
                        SHORT  M
                        LDA    #$11
                        STA    $07,S
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $04,S
                        LDA    $0A,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $0A,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00AC
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $94,S
                        SHORT  M
                        LDA    #$DC
                        STA    $98,S
                        LONG   M
                        PEA    $AACA
                        PEA    $CCCC
                        PEA    $111C
                        PEA    $AACA
                        PEA    $DCCC
                        TSC                              ; Line 4
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A0,S
                        LONG   M
                        PHX
                        PHX
                        PEA    $1C11
                        PEA    $A1AA
                        TSC                              ; Line 5
                        ADC    #$00A7
                        TCS
                        TXA
                        STA    $9E,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $9D,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A0,S
                        LONG   M
                        PHY
                        PEA    $1CC1
                        PEA    $1111
                        PEA    $C1AA
                        PEA    $CCCC
                        PHD
                        TSC                              ; Line 6
                        ADC    #$00A8
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $99,S
                        PEA    $11CC
                        PEA    $ACEA
                        PEA    $CCAC
                        PEA    $AAAA
                        TSC                              ; Line 7
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $9B,S
                        LONG   M
                        PEA    $CC11
                        PHD
                        PEA    $CCEC
                        PEA    $CCCC
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
; MARK: BOMBER_006B
BOMBER_006B             ENTRY
                        CLC                              ; 28x9, 292 bytes, 469 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CACC                    ; Pattern #1 : 4
                        LDY    #$CCAA                    ; Pattern #2 : 3
                        LDA    #$CCCC                    ; Pattern #3 : 3
                        TCD
;--
                        LDA    $AB,S                     ; Line 0
                        AND    #$00F0
                        ORA    #$CA0C
                        STA    $AB,S
                        SHORT  M
                        LDA    #$CC
                        STA    $0C,S
                        LDA    $A8,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A8,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $0B,S
                        LDA    $07,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $07,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $04,S
                        LDA    $0D,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $0D,S
                        LDA    $AD,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $AD,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00AC
                        TCS
                        LDA    $95,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $95,S
                        LDA    $98,S
                        AND    #$00F0
                        ORA    #$CA0D
                        STA    $98,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$A0CC
                        STA    $A0,S
                        PEA    $AACC
                        PEA    $CC1C
                        PEA    $C1A1
                        PEA    $AACC
                        PEA    $CDCC
                        TSC                              ; Line 4
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $95,S
                        LONG   M
                        PEA    $ACCC
                        PEA    $CC11
                        PEA    $11AA
                        TSC                              ; Line 5
                        ADC    #$00A7
                        TCS
                        LDA    #$AACC
                        STA    $9E,S
                        SHORT  M
                        LDA    $94,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $94,S
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $9D,S
                        LONG   M
                        PEA    $AACA
                        PEA    $CC11
                        PEA    $1C11
                        PEA    $11AC
                        PHX
                        PHY
                        TSC                              ; Line 6
                        ADC    #$00A8
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$C01C
                        STA    $A1,S
                        PEA    $1CC1
                        PHY
                        PEA    $CECC
                        PEA    $AAAA
                        TSC                              ; Line 7
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $9C,S
                        LONG   M
                        PEA    $C1AA
                        PHX
                        PEA    $CECC
                        PEA    $ACAA
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
; MARK: BOMBER_007A
BOMBER_007A             ENTRY
                        CLC                              ; 28x9, 299 bytes, 475 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 4
                        LDY    #$CCAC                    ; Pattern #2 : 3
                        LDA    #$A1AA                    ; Pattern #3 : 3
                        TCD
;--
                        LDA    $0B,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $0B,S
                        LDA    $AB,S
                        AND    #$0F00
                        ORA    #$A0CC
                        STA    $AB,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$CC1C
                        STA    $0A,S
                        LDA    $08,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $08,S
                        SHORT  M
                        LDA    #$AA
                        STA    $0C,S
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $04,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00AC
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $94,S
                        SHORT  M
                        LDA    #$CA
                        STA    $A0,S
                        LONG   M
                        PEA    $AACA
                        PEA    $CC1C
                        PEA    $C1A1
                        PEA    $AACA
                        PEA    $DCCC
                        TSC                              ; Line 4
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A1,S
                        LONG   M
                        PEA    $CCCA
                        PHX
                        PEA    $11A1
                        PEA    $AADC
                        TSC                              ; Line 5
                        ADC    #$00A8
                        TCS
                        TXA
                        STA    $9E,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9D,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LONG   M
                        PEA    $AA1C
                        PEA    $1C1C
                        PHX
                        PEA    $C1AA
                        PEA    $CCCC
                        PEA    $ACAA
                        TSC                              ; Line 6
                        ADC    #$00A8
                        TCS
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$10CC
                        STA    $A2,S
                        SHORT  M
                        LDA    $99,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $99,S
                        LONG   M
                        PEA    $11CC
                        PEA    $ACEA
                        PHY
                        PEA    $AAAA
                        TSC                              ; Line 7
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $A1,S
                        LDA    $9C,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $9C,S
                        LDA    $9F,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9F,S
                        LONG   M
                        PEA    $C1A1
                        PEA    $AACC
                        PEA    $ECCC
                        PEA    $CCAA
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
; MARK: BOMBER_007B
BOMBER_007B             ENTRY
                        CLC                              ; 28x9, 291 bytes, 472 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 5
                        LDY    #$CCAA                    ; Pattern #2 : 3
                        LDA    #$AACC                    ; Pattern #3 : 2
                        TCD
;--
                        LDA    $AB,S                     ; Line 0
                        AND    #$00F0
                        ORA    #$CA0C
                        STA    $AB,S
                        SHORT  M
                        LDA    #$CC
                        STA    $0C,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$CC11
                        STA    $0A,S
                        LDA    $0C,S
                        AND    #$0F00
                        ORA    #$A0CA
                        STA    $0C,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $04,S
                        LDA    $08,S
                        AND    #$F0
                        ORA    #$01
                        STA    $08,S
                        LDA    $AD,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $AD,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00AC
                        TCS
                        LDA    $95,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $95,S
                        LDA    $98,S
                        AND    #$00F0
                        ORA    #$CA0D
                        STA    $98,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$A0CC
                        STA    $A0,S
                        PHD
                        PEA    $CC11
                        PEA    $1CAA
                        PHD
                        PEA    $CDCC
                        TSC                              ; Line 4
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $95,S
                        LONG   M
                        PEA    $AC1C
                        PHX
                        PEA    $11AA
                        TSC                              ; Line 5
                        ADC    #$00A7
                        TCS
                        TXA
                        STA    $9E,S
                        SHORT  M
                        LDA    $94,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $94,S
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9D,S
                        LONG   M
                        PEA    $AACA
                        PEA    $C1C1
                        PHX
                        PEA    $11AC
                        PEA    $CACC
                        PHY
                        TSC                              ; Line 6
                        ADC    #$00A8
                        TCS
                        PEA    $11C1
                        PHY
                        PEA    $CECC
                        PEA    $AAAA
                        TSC                              ; Line 7
                        ADC    #$00AA
                        TCS
                        LDA    $9E,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $9E,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $9A,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LONG   M
                        PEA    $C11C
                        PEA    $1CAA
                        PEA    $CACC
                        PEA    $CECC
                        PEA    $ACAA
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
; MARK: BOSS1_000A
BOSS1_000A              ENTRY
                        CLC                              ; 32x9, 275 bytes, 466 cycles
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
                        LDY    #$9999                    ; Pattern #2 : 7
                        LDA    #$A9AA                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $00,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$900A
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$990A
                        STA    $A0,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $00,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$9009
                        STA    $A6,S
                        SHORT  M
                        LDA    #$DD
                        STA    $AB,S
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$90
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A3
                        TCS
                        PEA    $99A9
                        PEA    $9AA9
                        TSC                              ; Line 4
                        ADC    #$00AE
                        TCS
                        LDA    #$99D9
                        STA    $9E,S
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $93,S
                        SHORT  M
                        LDA    #$99
                        STA    $A1,S
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $9D,S
                        LONG   M
                        PHY
                        PEA    $D999
                        PHY
                        PEA    $1911
                        PEA    $9A99
                        PHY
                        PHD
                        TSC                              ; Line 5
                        ADC    #$00AA
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$9A09
                        STA    $99,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $A5,S
                        PHX
                        PEA    $AA99
                        PHX
                        PEA    $9A99
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$10AA
                        STA    $A1,S
                        PHY
                        PEA    $E9AA
                        PHX
                        PEA    $99AA
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AA
                        TCS
                        LDA    $97,S
                        AND    #$0FF0
                        ORA    #$9009
                        STA    $97,S
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $99,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A1,S
                        PEA    $AA9A
                        PEA    $E9A9
                        PHX
                        PHD
                        PEA    $1A11
                        TSC                              ; Line 8
                        ADC    #$00AA
                        TCS
                        PHX
                        PEA    $EAAA
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
; MARK: BOSS1_000B
BOSS1_000B              ENTRY
                        CLC                              ; 32x9, 289 bytes, 481 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$AAAA                    ; Pattern #1 : 10
                        LDY    #$9999                    ; Pattern #2 : 7
                        LDA    #$AA9A                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $A1,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$90A9
                        STA    $A1,S
                        SHORT  M
                        LDA    #$A9
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$99AA
                        STA    $01,S
                        STA    $A2,S
                        LDA    #$AA99
                        STA    $A1,S
                        LDA    $A4,S
                        AND    #$FF0F
                        ORA    #$0090
                        STA    $A4,S
                        LDA    $AB,S
                        AND    #$0FF0
                        ORA    #$D00D
                        STA    $AB,S
                        SHORT  M
                        LDA    #$99
                        STA    $A7,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $00,S
                        LDA    $AC,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $AC,S
                        LDA    $AE,S
                        AND    #$0FF0
                        ORA    #$9009
                        STA    $AE,S
                        SHORT  M
                        LDA    $0E,S
                        AND    #$0F
                        ORA    #$90
                        STA    $0E,S
                        LDA    $AB,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $AB,S
                        LONG   M
                        TSC
                        ADC    #$000D
                        TCS
                        PHY
                        PEA    $9D99
                        PHY
                        PEA    $11A1
                        PHY
                        PHY
                        TSC                              ; Line 5
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    #$99
                        STA    $99,S
                        LONG   M
                        PHX
                        PHD
                        PEA    $A9AA
                        PEA    $AA99
                        PEA    $A9AA
                        TSC                              ; Line 6
                        ADC    #$00AF
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $95,S
                        PHD
                        PHY
                        PEA    $AEAA
                        PHD
                        PEA    $A9AA
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AC
                        TCS
                        SHORT  M
                        LDA    #$99
                        STA    $96,S
                        LDA    #$AA
                        STA    $98,S
                        LONG   M
                        PEA    $A1AA
                        PEA    $AA99
                        PEA    $9EAA
                        PHD
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00AA
                        TCS
                        PEA    $11A1
                        PHX
                        PEA    $AE9A
                        PEA    $99A9
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
; MARK: BOSS1_001A
BOSS1_001A              ENTRY
                        CLC                              ; 32x9, 311 bytes, 516 cycles
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
                        LDY    #$9999                    ; Pattern #2 : 5
                        LDA    #$A9AA                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $00,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$900A
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$990A
                        STA    $A0,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $00,S
                        LDA    $02,S
                        AND    #$F00F
                        ORA    #$0190
                        STA    $02,S
                        LDA    $04,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A4,S
                        SHORT  M
                        LDA    #$19
                        STA    $A6,S
                        LDA    $AB,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $AB,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A3
                        TCS
                        LDA    $A9,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $A9,S
                        PEA    $99A9
                        PEA    $9AA9
                        TSC                              ; Line 4
                        ADC    #$00AC
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $95,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$90D9
                        STA    $A0,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A3,S
                        LONG   M
                        PEA    $D999
                        PHY
                        PEA    $1911
                        PEA    $9A99
                        PHY
                        PHD
                        TSC                              ; Line 5
                        ADC    #$00AA
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$9A09
                        STA    $99,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $A5,S
                        PHX
                        PEA    $AA99
                        PHX
                        PEA    $9A99
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$10AA
                        STA    $A1,S
                        PHY
                        PEA    $E9AA
                        PHX
                        PEA    $99AA
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AA
                        TCS
                        LDA    #$99AA
                        STA    $9A,S
                        LDA    $9C,S
                        AND    #$000F
                        ORA    #$AA90
                        STA    $9C,S
                        SHORT  M
                        LDA    $97,S
                        AND    #$F0
                        ORA    #$09
                        STA    $97,S
                        LDA    $99,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $99,S
                        LONG   M
                        PEA    $AA9A
                        PEA    $E9A9
                        PHX
                        PHD
                        PEA    $1A11
                        TSC                              ; Line 8
                        ADC    #$00AB
                        TCS
                        PEA    $11AA
                        PEA    $AAEA
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
; MARK: BOSS1_001B
BOSS1_001B              ENTRY
                        CLC                              ; 32x9, 310 bytes, 508 cycles
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
                        LDY    #$9999                    ; Pattern #2 : 7
                        LDA    #$AA9A                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $A1,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$90A9
                        STA    $A1,S
                        SHORT  M
                        LDA    #$A9
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$99AA
                        STA    $01,S
                        STA    $A2,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$990A
                        STA    $A0,S
                        LDA    $A4,S
                        AND    #$000F
                        ORA    #$1190
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$9001
                        STA    $A6,S
                        SHORT  M
                        LDA    #$11
                        STA    $04,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $00,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$10
                        STA    $06,S
                        LDA    $AB,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $AB,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $00,S
                        LDA    $AA,S
                        AND    #$F00F
                        ORA    #$0DA0
                        STA    $AA,S
                        SHORT  M
                        LDA    #$AA
                        STA    $A1,S
                        LDA    #$99
                        STA    $AC,S
                        LDA    $AE,S
                        AND    #$F0
                        ORA    #$09
                        STA    $AE,S
                        LONG   M
                        TSC
                        ADC    #$000D
                        TCS
                        PHY
                        PEA    $9D99
                        PHY
                        PEA    $11A1
                        PHY
                        PHY
                        TSC                              ; Line 5
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    #$99
                        STA    $9A,S
                        LONG   M
                        PHX
                        PEA    $9AA9
                        PHX
                        PEA    $99A9
                        TSC                              ; Line 6
                        ADC    #$00AE
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $95,S
                        PHD
                        PHY
                        PEA    $AEAA
                        PHD
                        PEA    $A9AA
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AC
                        TCS
                        LDA    #$99A9
                        STA    $99,S
                        SHORT  M
                        LDA    #$AA
                        STA    $98,S
                        LDA    $96,S
                        AND    #$0F
                        ORA    #$90
                        STA    $96,S
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9B,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LONG   M
                        PEA    $A1AA
                        PEA    $AA99
                        PEA    $9EAA
                        PHD
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A9
                        TCS
                        PEA    $A1AA
                        PEA    $AAAE
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
; MARK: BOSS1_002A
BOSS1_002A              ENTRY
                        CLC                              ; 32x9, 346 bytes, 562 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 5
                        LDY    #$AAAA                    ; Pattern #2 : 5
                        LDA    #$1191                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $00,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$900A
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $02,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$990A
                        STA    $A0,S
                        LDA    $A3,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A3,S
                        TSC                              ; Line 2
                        ADC    #$0143
                        TCS
                        LDA    $01,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $01,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A2,S
                        SHORT  M
                        LDA    #$A9
                        STA    $9D,S
                        LDA    $A8,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $A8,S
                        LONG   M
                        PHD
                        PEA    $A9AA
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    $A8,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $A8,S
                        PHX
                        PHD
                        TSC                              ; Line 4
                        ADC    #$00AB
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $95,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$90D9
                        STA    $A0,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A3,S
                        LONG   M
                        PEA    $D999
                        PEA    $9999
                        PHX
                        PHX
                        PEA    $9199
                        PEA    $A9AA
                        TSC                              ; Line 5
                        ADC    #$00AA
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$9A09
                        STA    $99,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $A5,S
                        PEA    $AA1A
                        PHD
                        PEA    $11AA
                        PEA    $9A99
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$A90A
                        STA    $9C,S
                        SHORT  M
                        LDA    #$11
                        STA    $97,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        PEA    $9999
                        PEA    $E9AA
                        PHY
                        PEA    $19AA
                        PEA    $AAA1
                        TSC                              ; Line 7
                        ADC    #$00A5
                        TCS
                        LDA    #$99AA
                        STA    $9F,S
                        LDA    $A1,S
                        AND    #$000F
                        ORA    #$AA90
                        STA    $A1,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$09
                        STA    $9C,S
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9E,S
                        LONG   M
                        PEA    $99A9
                        PEA    $AA1A
                        TSC
                        ADC    #$000A
                        TCS
                        PHY
                        PEA    $9AE9
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        PEA    $11AA
                        PEA    $AAEA
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
; MARK: BOSS1_002B
BOSS1_002B              ENTRY
                        CLC                              ; 32x9, 337 bytes, 544 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 7
                        LDY    #$A1AA                    ; Pattern #2 : 4
                        LDA    #$9999                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $A1,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$90A9
                        STA    $A1,S
                        LDA    $A4,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A4,S
                        SHORT  M
                        LDA    #$A9
                        STA    $01,S
                        LDA    #$11
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $05,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $A5,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $A0,S
                        LDA    $AB,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $AB,S
                        LONG   M
                        TSC
                        ADC    #$0004
                        TCS
                        PHX
                        PEA    $99AA
                        TSC                              ; Line 3
                        ADC    #$00A4
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $9C,S
                        PHX
                        PEA    $1199
                        TSC                              ; Line 4
                        ADC    #$00AD
                        TCS
                        LDA    $9D,S
                        AND    #$F00F
                        ORA    #$0DA0
                        STA    $9D,S
                        SHORT  M
                        LDA    #$AA
                        STA    $94,S
                        LDA    #$99
                        STA    $9F,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$09
                        STA    $A1,S
                        LONG   M
                        PHD
                        PEA    $9D99
                        PEA    $9919
                        PHX
                        PHX
                        PHD
                        TSC                              ; Line 5
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    #$99
                        STA    $9A,S
                        LONG   M
                        PEA    $AA11
                        PEA    $1119
                        PHY
                        PEA    $99A9
                        TSC                              ; Line 6
                        ADC    #$00AE
                        TCS
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$01
                        STA    $95,S
                        LDA    $9A,S
                        AND    #$0F
                        ORA    #$90
                        STA    $9A,S
                        LONG   M
                        PEA    $AA9A
                        PHD
                        PEA    $AEAA
                        PEA    $AA9A
                        PHY
                        PEA    $1AAA
                        TSC                              ; Line 7
                        ADC    #$00A5
                        TCS
                        LDA    #$99A9
                        STA    $A0,S
                        SHORT  M
                        LDA    #$AA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$90
                        STA    $9D,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $A2,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A7,S
                        LONG   M
                        PEA    $99AA
                        PEA    $AA11
                        TSC
                        ADC    #$000B
                        TCS
                        PHY
                        PEA    $AA99
                        PEA    $9EAA
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        PHY
                        PEA    $AAAE
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
; MARK: BOSS1_003A
BOSS1_003A              ENTRY
                        CLC                              ; 32x9, 362 bytes, 588 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 8
                        LDY    #$AAAA                    ; Pattern #2 : 4
                        LDA    #$9999                    ; Pattern #3 : 3
                        TCD
;--
                        TXA                              ; Line 0
                        STA    $A0,S
                        LDA    $00,S
                        AND    #$0FF0
                        ORA    #$900A
                        STA    $00,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$11A9
                        STA    $01,S
                        LDA    $A5,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $A5,S
                        SHORT  M
                        LDA    #$AA
                        STA    $00,S
                        LDA    #$A9
                        STA    $A0,S
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$10
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$10
                        STA    $06,S
                        LDA    $AB,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $AB,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A4
                        TCS
                        LDA    $A8,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $A8,S
                        PHX
                        PEA    $A111
                        TSC                              ; Line 4
                        ADC    #$00AB
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $95,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$90D9
                        STA    $A0,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A3,S
                        LONG   M
                        PEA    $D999
                        PHD
                        PHX
                        PEA    $9111
                        PHX
                        PEA    $A9AA
                        TSC                              ; Line 5
                        ADC    #$00AA
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$9109
                        STA    $99,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $A5,S
                        PEA    $AA1A
                        PHX
                        PHX
                        PEA    $9A91
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $94,S
                        LDA    $96,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $96,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$A90A
                        STA    $9C,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        PHD
                        PEA    $E9AA
                        PHY
                        PEA    $191A
                        PEA    $1AAA
                        TSC                              ; Line 7
                        ADC    #$00A5
                        TCS
                        LDA    #$99AA
                        STA    $9F,S
                        LDA    $A1,S
                        AND    #$000F
                        ORA    #$AA90
                        STA    $A1,S
                        SHORT  M
                        LDA    $99,S
                        AND    #$0F
                        ORA    #$10
                        STA    $99,S
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$09
                        STA    $9C,S
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9E,S
                        LONG   M
                        PEA    $99A9
                        PEA    $1A1A
                        TSC
                        ADC    #$000A
                        TCS
                        PHY
                        PEA    $9AE9
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        PEA    $11AA
                        PEA    $AAEA
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
; MARK: BOSS1_003B
BOSS1_003B              ENTRY
                        CLC                              ; 32x9, 364 bytes, 575 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 8
                        LDY    #$AAAA                    ; Pattern #2 : 3
                        LDA    #$9999                    ; Pattern #3 : 3
                        TCD
;--
                        LDA    $A0,S                     ; Line 0
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A0,S
                        SHORT  M
                        LDA    #$A9
                        STA    $01,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$91AA
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $03,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$910A
                        STA    $A0,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $00,S
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$01
                        STA    $06,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A7,S
                        LDA    $AB,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $AB,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $9B,S
                        PHX
                        PEA    $111A
                        TSC                              ; Line 4
                        ADC    #$00AC
                        TCS
                        LDA    $9D,S
                        AND    #$F00F
                        ORA    #$0DA0
                        STA    $9D,S
                        SHORT  M
                        LDA    #$AA
                        STA    $94,S
                        LDA    #$99
                        STA    $9F,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$09
                        STA    $A1,S
                        LONG   M
                        PHD
                        PEA    $9D99
                        PEA    $9919
                        PHX
                        PEA    $1911
                        PEA    $1191
                        TSC                              ; Line 5
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    #$AA
                        STA    $A6,S
                        LONG   M
                        PEA    $AA11
                        PHX
                        PEA    $11A1
                        PEA    $19A9
                        TSC                              ; Line 6
                        ADC    #$00AD
                        TCS
                        TXA
                        STA    $94,S
                        SHORT  M
                        LDA    $96,S
                        AND    #$F0
                        ORA    #$01
                        STA    $96,S
                        LDA    $9B,S
                        AND    #$0F
                        ORA    #$90
                        STA    $9B,S
                        LONG   M
                        PEA    $9A99
                        PEA    $99AE
                        PHY
                        PEA    $9AA1
                        PEA    $A1A1
                        PEA    $1A99
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        LDA    #$99A9
                        STA    $A0,S
                        SHORT  M
                        LDA    #$AA
                        STA    $9F,S
                        LDA    $99,S
                        AND    #$F0
                        ORA    #$01
                        STA    $99,S
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$90
                        STA    $9D,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $A2,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A7,S
                        LONG   M
                        PEA    $99AA
                        PEA    $A111
                        TSC
                        ADC    #$000B
                        TCS
                        PEA    $A1AA
                        PEA    $AA99
                        PEA    $9EAA
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        PEA    $A1AA
                        PEA    $AAAE
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
; MARK: BOSS1_004A
BOSS1_004A              ENTRY
                        CLC                              ; 32x9, 289 bytes, 476 cycles
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
                        LDY    #$9999                    ; Pattern #2 : 7
                        LDA    #$AA9A                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $AD,S                     ; Line 0
                        AND    #$00F0
                        ORA    #$9A09
                        STA    $AD,S
                        SHORT  M
                        LDA    #$9A
                        STA    $0E,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$AA99
                        STA    $0D,S
                        STA    $AC,S
                        LDA    $AE,S
                        AND    #$0F00
                        ORA    #$A099
                        STA    $AE,S
                        SHORT  M
                        LDA    $0F,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $0F,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $A4,S
                        LDA    $A8,S
                        AND    #$F0
                        ORA    #$09
                        STA    $A8,S
                        LDA    $AB,S
                        AND    #$F0
                        ORA    #$09
                        STA    $AB,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$014D
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $01,S
                        LDA    $97,S
                        AND    #$F00F
                        ORA    #$0AD0
                        STA    $97,S
                        SHORT  M
                        LDA    #$99
                        STA    $96,S
                        LDA    #$AA
                        STA    $99,S
                        LDA    $94,S
                        AND    #$0F
                        ORA    #$90
                        STA    $94,S
                        LONG   M
                        PHY
                        PHY
                        PEA    $1A11
                        PHY
                        PEA    $99D9
                        PHY
                        TSC                              ; Line 5
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$99
                        STA    $9E,S
                        LONG   M
                        PHD
                        PEA    $99AA
                        PHD
                        PEA    $A9AA
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $9F,S
                        PHX
                        PHD
                        PEA    $A9AA
                        PEA    $AAEA
                        PHY
                        PEA    $A9AA
                        TSC                              ; Line 7
                        ADC    #$00AA
                        TCS
                        TDC
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$000F
                        ORA    #$99A0
                        STA    $9C,S
                        SHORT  M
                        LDA    $97,S
                        AND    #$F0
                        ORA    #$01
                        STA    $97,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$09
                        STA    $A1,S
                        LONG   M
                        PHX
                        PEA    $A9AA
                        PEA    $AAE9
                        PEA    $99AA
                        PEA    $AA1A
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        PEA    $EAAA
                        PEA    $AA1A
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
; MARK: BOSS1_004B
BOSS1_004B              ENTRY
                        CLC                              ; 32x9, 293 bytes, 487 cycles
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
                        LDY    #$9999                    ; Pattern #2 : 5
                        LDA    #$AA9A                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $0E,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$A009
                        STA    $0E,S
                        LDA    $AE,S
                        AND    #$0F00
                        ORA    #$A099
                        STA    $AE,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $0E,S
                        SHORT  M
                        LDA    $0D,S
                        AND    #$F0
                        ORA    #$09
                        STA    $0D,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $A4,S
                        LDA    $A9,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A9,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00AF
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $93,S
                        PEA    $9AA9
                        PEA    $9A99
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$9D09
                        STA    $94,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $9F,S
                        SHORT  M
                        LDA    $92,S
                        AND    #$F0
                        ORA    #$09
                        STA    $92,S
                        LONG   M
                        PHD
                        PHY
                        PEA    $99A9
                        PEA    $1191
                        PHY
                        PEA    $999D
                        TSC                              ; Line 5
                        ADC    #$00AA
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $93,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$90A9
                        STA    $9F,S
                        PEA    $99A9
                        PHX
                        PEA    $99AA
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A6
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$AA01
                        STA    $95,S
                        PHX
                        PEA    $AA99
                        PHX
                        PEA    $AA9E
                        PHY
                        TSC                              ; Line 7
                        ADC    #$00AA
                        TCS
                        LDA    #$AA99
                        STA    $9C,S
                        SHORT  M
                        LDA    #$11
                        STA    $96,S
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$09
                        STA    $9B,S
                        LDA    $9E,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A0,S
                        LONG   M
                        PEA    $11A1
                        PHD
                        PHX
                        PEA    $9A9E
                        PEA    $A9AA
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        PEA    $AAAE
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
; MARK: BOSS1_005A
BOSS1_005A              ENTRY
                        CLC                              ; 32x9, 329 bytes, 527 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$9999                    ; Pattern #1 : 7
                        LDY    #$AAAA                    ; Pattern #2 : 3
                        LDA    #$AA1A                    ; Pattern #3 : 3
                        TCD
;--
                        LDA    $AD,S                     ; Line 0
                        AND    #$00F0
                        ORA    #$9A09
                        STA    $AD,S
                        SHORT  M
                        LDA    #$9A
                        STA    $0E,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$AA99
                        STA    $0D,S
                        LDA    #$99AA
                        STA    $AD,S
                        LDA    $A8,S
                        AND    #$0FF0
                        ORA    #$1009
                        STA    $A8,S
                        LDA    $AB,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $AB,S
                        SHORT  M
                        LDA    #$11
                        STA    $0B,S
                        STA    $AA,S
                        LDA    $09,S
                        AND    #$F0
                        ORA    #$01
                        STA    $09,S
                        LDA    $0F,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $0F,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $A4,S
                        LDA    $AF,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $AF,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$014D
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $01,S
                        LDA    $97,S
                        AND    #$F00F
                        ORA    #$0AD0
                        STA    $97,S
                        SHORT  M
                        LDA    #$99
                        STA    $96,S
                        LDA    #$AA
                        STA    $99,S
                        LDA    $94,S
                        AND    #$0F
                        ORA    #$90
                        STA    $94,S
                        LONG   M
                        PHX
                        PHX
                        PEA    $1111
                        PHX
                        PEA    $99D9
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$99
                        STA    $9E,S
                        LONG   M
                        PEA    $AA9A
                        PEA    $991A
                        PHD
                        PEA    $11AA
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$09
                        STA    $9B,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LONG   M
                        PEA    $AA11
                        PEA    $A111
                        PEA    $11AA
                        PEA    $AAEA
                        PHX
                        PEA    $A9AA
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        LDA    #$AA9A
                        STA    $A2,S
                        LDA    $A0,S
                        AND    #$000F
                        ORA    #$99A0
                        STA    $A0,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LDA    $A5,S
                        AND    #$F0
                        ORA    #$09
                        STA    $A5,S
                        LONG   M
                        PEA    $AAE9
                        PEA    $99AA
                        PHD
                        TSC
                        ADC    #$000B
                        TCS
                        PEA    $111A
                        PEA    $AA99
                        TSC                              ; Line 8
                        ADC    #$009E
                        TCS
                        PEA    $EAAA
                        PHD
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
; MARK: BOSS1_005B
BOSS1_005B              ENTRY
                        CLC                              ; 32x9, 333 bytes, 539 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$9999                    ; Pattern #1 : 5
                        LDY    #$11A1                    ; Pattern #2 : 3
                        LDA    #$A1AA                    ; Pattern #3 : 3
                        TCD
;--
                        LDA    $0E,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$A009
                        STA    $0E,S
                        LDA    $AE,S
                        AND    #$0F00
                        ORA    #$A099
                        STA    $AE,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$AA9A
                        STA    $0E,S
                        LDA    $0A,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $0A,S
                        LDA    $0C,S
                        AND    #$F00F
                        ORA    #$0910
                        STA    $0C,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AA,S
                        SHORT  M
                        LDA    #$91
                        STA    $A9,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00AF
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $93,S
                        PEA    $9AA9
                        PEA    $9A99
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$9D09
                        STA    $94,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $9F,S
                        SHORT  M
                        LDA    $92,S
                        AND    #$F0
                        ORA    #$09
                        STA    $92,S
                        LONG   M
                        PEA    $AA9A
                        PHX
                        PEA    $9919
                        PEA    $1191
                        PHX
                        PEA    $999D
                        TSC                              ; Line 5
                        ADC    #$00AA
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $93,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$90A9
                        STA    $9F,S
                        PEA    $99A9
                        PHD
                        PHY
                        PEA    $AAAA
                        TSC                              ; Line 6
                        ADC    #$00A6
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$AA01
                        STA    $95,S
                        LDA    $9B,S
                        AND    #$000F
                        ORA    #$99A0
                        STA    $9B,S
                        PEA    $1A11
                        PEA    $1A11
                        PHD
                        PEA    $AA9E
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        LDA    #$AA99
                        STA    $A2,S
                        SHORT  M
                        LDA    #$11
                        STA    $9C,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$09
                        STA    $A1,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A6,S
                        LONG   M
                        PEA    $9A9E
                        PEA    $A9AA
                        TSC
                        ADC    #$000A
                        TCS
                        PHY
                        PEA    $A19A
                        TSC                              ; Line 8
                        ADC    #$009E
                        TCS
                        PEA    $AAAE
                        PEA    $AAAA
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
; MARK: BOSS1_006A
BOSS1_006A              ENTRY
                        CLC                              ; 32x9, 341 bytes, 546 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 7
                        LDY    #$AAAA                    ; Pattern #2 : 4
                        LDA    #$9999                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $AA,S                     ; Line 0
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $AA,S
                        LDA    $AD,S
                        AND    #$00F0
                        ORA    #$9A09
                        STA    $AD,S
                        SHORT  M
                        LDA    #$11
                        STA    $0C,S
                        LDA    #$9A
                        STA    $0E,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $09,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $09,S
                        LDA    $A9,S
                        AND    #$F000
                        ORA    #$0111
                        STA    $A9,S
                        SHORT  M
                        LDA    $0F,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $0F,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $A4,S
                        LDA    $AF,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $AF,S
                        LONG   M
                        TSC
                        ADC    #$000E
                        TCS
                        PEA    $AA99
                        PHX
                        TSC                              ; Line 3
                        ADC    #$00A4
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $A0,S
                        PEA    $9911
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00A3
                        TCS
                        LDA    $97,S
                        AND    #$F00F
                        ORA    #$0AD0
                        STA    $97,S
                        SHORT  M
                        LDA    #$99
                        STA    $96,S
                        LDA    #$AA
                        STA    $99,S
                        LDA    $94,S
                        AND    #$0F
                        ORA    #$90
                        STA    $94,S
                        LONG   M
                        PHD
                        PHX
                        PHX
                        PEA    $9199
                        PEA    $99D9
                        PHD
                        TSC                              ; Line 5
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$99
                        STA    $9E,S
                        LONG   M
                        PEA    $AA9A
                        PEA    $99AA
                        PEA    $1A91
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$09
                        STA    $9B,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LONG   M
                        PEA    $AAA1
                        PEA    $AA1A
                        PEA    $A9AA
                        PEA    $AAEA
                        PHD
                        PEA    $A9AA
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        LDA    #$AA9A
                        STA    $A2,S
                        LDA    $A0,S
                        AND    #$000F
                        ORA    #$99A0
                        STA    $A0,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LDA    $A5,S
                        AND    #$F0
                        ORA    #$09
                        STA    $A5,S
                        LONG   M
                        PEA    $AAE9
                        PEA    $99AA
                        PEA    $AA1A
                        TSC
                        ADC    #$000B
                        TCS
                        PEA    $11AA
                        PEA    $AA99
                        TSC                              ; Line 8
                        ADC    #$009E
                        TCS
                        PEA    $EAAA
                        PEA    $AA1A
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
; MARK: BOSS1_006B
BOSS1_006B              ENTRY
                        CLC                              ; 32x9, 347 bytes, 563 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 5
                        LDY    #$AAAA                    ; Pattern #2 : 4
                        LDA    #$1911                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $0C,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0C,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$A009
                        STA    $0E,S
                        LDA    $AB,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $AB,S
                        LDA    $AE,S
                        AND    #$0F00
                        ORA    #$A099
                        STA    $AE,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $0A,S
                        AND    #$F000
                        ORA    #$0111
                        STA    $0A,S
                        LDA    $A9,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A9,S
                        SHORT  M
                        LDA    #$9A
                        STA    $AF,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $A4,S
                        LONG   M
                        TSC
                        ADC    #$000F
                        TCS
                        PEA    $AA9A
                        PHD
                        TSC                              ; Line 3
                        ADC    #$00A3
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $94,S
                        PHD
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00A5
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$9D09
                        STA    $94,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $9F,S
                        SHORT  M
                        LDA    $92,S
                        AND    #$F0
                        ORA    #$09
                        STA    $92,S
                        LONG   M
                        PEA    $AA9A
                        PEA    $9919
                        PHX
                        PHX
                        PEA    $9999
                        PEA    $999D
                        TSC                              ; Line 5
                        ADC    #$00AA
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $93,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$90A9
                        STA    $9F,S
                        PEA    $99A9
                        PEA    $AA11
                        PHD
                        PEA    $A1AA
                        TSC                              ; Line 6
                        ADC    #$00A6
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$AA01
                        STA    $95,S
                        LDA    $9B,S
                        AND    #$000F
                        ORA    #$99A0
                        STA    $9B,S
                        PEA    $1AAA
                        PEA    $AA91
                        PHY
                        PEA    $AA9E
                        PEA    $9999
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        LDA    #$AA99
                        STA    $A2,S
                        SHORT  M
                        LDA    #$11
                        STA    $9C,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$09
                        STA    $A1,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A6,S
                        LONG   M
                        PEA    $9A9E
                        PEA    $A9AA
                        TSC
                        ADC    #$000A
                        TCS
                        PEA    $11A1
                        PEA    $AA9A
                        TSC                              ; Line 8
                        ADC    #$009E
                        TCS
                        PEA    $AAAE
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
; MARK: BOSS1_007A
BOSS1_007A              ENTRY
                        CLC                              ; 32x9, 360 bytes, 573 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 8
                        LDY    #$AAAA                    ; Pattern #2 : 3
                        LDA    #$9999                    ; Pattern #3 : 3
                        TCD
;--
                        LDA    $AD,S                     ; Line 0
                        AND    #$00F0
                        ORA    #$1101
                        STA    $AD,S
                        SHORT  M
                        LDA    #$9A
                        STA    $0E,S
                        LDA    $AB,S
                        AND    #$F0
                        ORA    #$01
                        STA    $AB,S
                        LDA    $AF,S
                        AND    #$0F
                        ORA    #$10
                        STA    $AF,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$AA19
                        STA    $0D,S
                        LDA    $0B,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $0B,S
                        LDA    $AE,S
                        AND    #$0F00
                        ORA    #$A019
                        STA    $AE,S
                        SHORT  M
                        LDA    $09,S
                        AND    #$0F
                        ORA    #$10
                        STA    $09,S
                        LDA    $0F,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $0F,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $A4,S
                        LDA    $A8,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A8,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00AD
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $A1,S
                        PEA    $A111
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        LDA    $97,S
                        AND    #$F00F
                        ORA    #$0AD0
                        STA    $97,S
                        SHORT  M
                        LDA    #$99
                        STA    $96,S
                        LDA    #$AA
                        STA    $99,S
                        LDA    $94,S
                        AND    #$0F
                        ORA    #$90
                        STA    $94,S
                        LONG   M
                        PEA    $1911
                        PEA    $1191
                        PHX
                        PEA    $9199
                        PEA    $99D9
                        PHD
                        TSC                              ; Line 5
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$99
                        STA    $9E,S
                        LONG   M
                        PEA    $AA9A
                        PEA    $911A
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        TXA
                        STA    $A1,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$09
                        STA    $9B,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LONG   M
                        PEA    $A11A
                        PEA    $1A1A
                        PEA    $A9AA
                        PEA    $AAEA
                        PHD
                        PEA    $A9AA
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        LDA    #$AA9A
                        STA    $A2,S
                        LDA    $A0,S
                        AND    #$000F
                        ORA    #$99A0
                        STA    $A0,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LDA    $A5,S
                        AND    #$F0
                        ORA    #$09
                        STA    $A5,S
                        LDA    $A9,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A9,S
                        LONG   M
                        PEA    $AAE9
                        PEA    $99AA
                        PEA    $AA1A
                        TSC
                        ADC    #$000B
                        TCS
                        PEA    $111A
                        PEA    $AA99
                        TSC                              ; Line 8
                        ADC    #$009E
                        TCS
                        PEA    $EAAA
                        PEA    $AA1A
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
; MARK: BOSS1_007B
BOSS1_007B              ENTRY
                        CLC                              ; 32x9, 364 bytes, 589 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 8
                        LDY    #$AAAA                    ; Pattern #2 : 3
                        LDA    #$9999                    ; Pattern #3 : 3
                        TCD
;--
                        TXA                              ; Line 0
                        STA    $AE,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$A009
                        STA    $0E,S
                        SHORT  M
                        LDA    $AC,S
                        AND    #$0F
                        ORA    #$10
                        STA    $AC,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$9A11
                        STA    $0D,S
                        LDA    $A9,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $A9,S
                        SHORT  M
                        LDA    #$AA
                        STA    $0F,S
                        LDA    #$9A
                        STA    $AF,S
                        LDA    $09,S
                        AND    #$F0
                        ORA    #$01
                        STA    $09,S
                        LDA    $0B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $0B,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00AE
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $94,S
                        PEA    $111A
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00A5
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$9D09
                        STA    $94,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $9F,S
                        SHORT  M
                        LDA    $92,S
                        AND    #$F0
                        ORA    #$09
                        STA    $92,S
                        LONG   M
                        PEA    $AA9A
                        PHX
                        PEA    $1119
                        PHX
                        PHD
                        PEA    $999D
                        TSC                              ; Line 5
                        ADC    #$00AA
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $93,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$9019
                        STA    $9F,S
                        PEA    $19A9
                        PHX
                        PHX
                        PEA    $A1AA
                        TSC                              ; Line 6
                        ADC    #$00A6
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$AA01
                        STA    $95,S
                        LDA    $9B,S
                        AND    #$000F
                        ORA    #$99A0
                        STA    $9B,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A2,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A1,S
                        LONG   M
                        PEA    $AAA1
                        PEA    $A191
                        PHY
                        PEA    $AA9E
                        PHD
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        LDA    #$AA99
                        STA    $A2,S
                        SHORT  M
                        LDA    #$11
                        STA    $9C,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$09
                        STA    $A1,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A6,S
                        LDA    $A9,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A9,S
                        LONG   M
                        PEA    $9A9E
                        PEA    $A9AA
                        TSC
                        ADC    #$000A
                        TCS
                        PEA    $11A1
                        PEA    $A19A
                        TSC                              ; Line 8
                        ADC    #$009E
                        TCS
                        PEA    $AAAE
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
; MARK: ENEMY1_000A
ENEMY1_000A             ENTRY
                        CLC                              ; 20x16, 202 bytes, 333 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 6
                        LDY    #$BBBB                    ; Pattern #2 : 3
                        LDA    #$5B55                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 5
                        ADC    #$0320
                        TCS
                        LDA    #$55B5
                        STA    $A0,S
                        LDA    $00,S
                        AND    #$0FF0
                        ORA    #$5005
                        STA    $00,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$220B
                        STA    $A3,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $07,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A5,S
                        LDA    $A7,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0145
                        TCS
                        LDA    $01,S
                        AND    #$F000
                        ORA    #$0D55
                        STA    $01,S
                        PEA    $2222
                        PHD
                        PEA    $55B5
                        TSC                              ; Line 8
                        ADC    #$00A8
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $99,S
                        PHD
                        PHX
                        PHX
                        PEA    $BB5B
                        TSC                              ; Line 9
                        ADC    #$00A8
                        TCS
                        LDA    $9F,S
                        AND    #$F000
                        ORA    #$0EB5
                        STA    $9F,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$05
                        STA    $9A,S
                        LONG   M
                        PEA    $5E55
                        PHY
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $A2,S
                        LONG   M
                        PHY
                        PEA    $BB55
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
; MARK: ENEMY1_000B
ENEMY1_000B             ENTRY
                        CLC                              ; 20x16, 228 bytes, 365 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 7
                        LDY    #$22B2                    ; Pattern #2 : 2
                        LDA    #$BB5B                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 5
                        ADC    #$0320
                        TCS
                        TYA
                        STA    $A4,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $A0,S
                        SHORT  M
                        LDA    #$55
                        STA    $01,S
                        LDA    $08,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $08,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$50
                        STA    $A2,S
                        LDA    $A8,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $A8,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    $07,S
                        AND    #$0F0F
                        ORA    #$D050
                        STA    $07,S
                        LDA    $A7,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $A7,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$05
                        STA    $A0,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $2522
                        PEA    $B255
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A6
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$E055
                        STA    $A1,S
                        PHX
                        PHX
                        PEA    $B5BB
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        LDA    $A1,S
                        AND    #$0F0F
                        ORA    #$E050
                        STA    $A1,S
                        SHORT  M
                        LDA    #$BB
                        STA    $A0,S
                        LONG   M
                        PEA    $B5BB
                        PEA    $5B55
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $A3,S
                        LONG   M
                        PEA    $BBBB
                        PEA    $5B55
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
; MARK: ENEMY1_001A
ENEMY1_001A             ENTRY
                        CLC                              ; 20x16, 281 bytes, 453 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 5
                        LDY    #$55B5                    ; Pattern #2 : 3
                        LDA    #$BB22                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A1,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$05
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        STA    $A1,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$05
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$5B05
                        STA    $00,S
                        TSC
                        ADC    #$0005
                        TCS
                        PHD
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        LDA    #$2555
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $9D,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $A2,S
                        LONG   M
                        PEA    $2B52
                        PHY
                        TSC                              ; Line 9
                        ADC    #$013F
                        TCS
                        TYA
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F0F
                        ORA    #$D050
                        STA    $06,S
                        SHORT  M
                        LDA    #$BB
                        STA    $03,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A1,S
                        LONG   M
                        PHY
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00A4
                        TCS
                        LDA    #$BE5B
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $9D,S
                        PEA    $5B5B
                        PHX
                        TSC                              ; Line 13
                        ADC    #$013E
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $03,S
                        LDA    $05,S
                        AND    #$F00F
                        ORA    #$0EB0
                        STA    $05,S
                        SHORT  M
                        LDA    #$BB
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $A6,S
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
; MARK: ENEMY1_001B
ENEMY1_001B             ENTRY
                        CLC                              ; 20x16, 299 bytes, 481 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 5
                        LDY    #$55B5                    ; Pattern #2 : 3
                        LDA    #$B555                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $A1,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$50
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $01,S
                        TXA
                        STA    $A1,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$50
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$50
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0144
                        TCS
                        TXA
                        STA    $9F,S
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$B02B
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$B022
                        STA    $A1,S
                        SHORT  M
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9E,S
                        LONG   M
                        PEA    $5255
                        PHD
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $03,S
                        TXA
                        STA    $A5,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$5052
                        STA    $05,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $A3,S
                        SHORT  M
                        LDA    $08,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $08,S
                        LDA    $A7,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 10
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$05
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$05
                        STA    $A3,S
                        LONG   M
                        TSC
                        ADC    #$0007
                        TCS
                        PEA    $5D55
                        PEA    $5B55
                        TSC                              ; Line 11
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$E0BB
                        STA    $9F,S
                        PEA    $BBB5
                        PHX
                        TSC                              ; Line 13
                        ADC    #$013D
                        TCS
                        LDA    #$5BB5
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$0FF0
                        ORA    #$B00B
                        STA    $A4,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $07,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $A6,S
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
; MARK: ENEMY1_002A
ENEMY1_002A             ENTRY
                        CLC                              ; 20x16, 310 bytes, 490 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 3
                        LDY    #$BB55                    ; Pattern #2 : 2
                        LDA    #$55BB                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $A1,S
                        SHORT  M
                        LDA    #$55
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    #$55B5
                        STA    $01,S
                        TDC
                        STA    $A1,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$50
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0145
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A1,S
                        LONG   M
                        PEA    $BBBB
                        PEA    $55B5
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        LDA    #$52B5
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B02B
                        STA    $A0,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9D,S
                        LONG   M
                        PHY
                        PHD
                        TSC                              ; Line 9
                        ADC    #$013F
                        TCS
                        LDA    #$2252
                        STA    $04,S
                        TXA
                        STA    $A3,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $02,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$5022
                        STA    $A5,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$05
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $04,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $02,S
                        LDA    $06,S
                        AND    #$0F0F
                        ORA    #$D050
                        STA    $06,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$05
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$00A6
                        TCS
                        LDA    $9D,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $9F,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9C,S
                        LONG   M
                        PEA    $5DB5
                        PEA    $5B55
                        TSC                              ; Line 14
                        ADC    #$013E
                        TCS
                        SHORT  M
                        LDA    #$BB
                        STA    $03,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $A5,S
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
; MARK: ENEMY1_002B
ENEMY1_002B             ENTRY
                        CLC                              ; 20x16, 279 bytes, 453 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 5
                        LDY    #$55B5                    ; Pattern #2 : 3
                        LDA    #$55BB                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$5005
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A2,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $A2,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $01,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$50
                        STA    $03,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    #$5B55
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $05,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        PEA    $BB5B
                        PHY
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        TYA
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $9F,S
                        PEA    $BB22
                        PHD
                        TSC                              ; Line 10
                        ADC    #$0144
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $A1,S
                        LONG   M
                        PEA    $2552
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHX
                        TSC                              ; Line 12
                        ADC    #$00A4
                        TCS
                        LDA    #$5BB5
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $9F,S
                        PHD
                        PHX
                        TSC                              ; Line 14
                        ADC    #$013E
                        TCS
                        LDA    $03,S
                        AND    #$0FF0
                        ORA    #$B00B
                        STA    $03,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $06,S
                        LDA    $A5,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $A5,S
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
; MARK: ENEMY1_003A
ENEMY1_003A             ENTRY
                        CLC                              ; 20x16, 342 bytes, 546 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BB22                    ; Pattern #1 : 3
                        LDY    #$5555                    ; Pattern #2 : 3
                        LDA    #$22B5                    ; Pattern #3 : 1
                        TCD
;--
                        LDA    #$B5BB                    ; Line 0
                        STA    $A2,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$B50B
                        STA    $02,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$50
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$50
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $A2,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$B05B
                        STA    $A4,S
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $04,S
                        STA    $A4,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $A2,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0145
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $01,S
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9C,S
                        LONG   M
                        PHX
                        PEA    $B5B5
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        TYA
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $9F,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$05
                        STA    $9C,S
                        LONG   M
                        PEA    $5B52
                        PHY
                        TSC                              ; Line 11
                        ADC    #$0143
                        TCS
                        LDA    #$55B5
                        STA    $9D,S
                        LDA    #$BDBB
                        STA    $A0,S
                        LDA    $01,S
                        AND    #$F00F
                        ORA    #$0D50
                        STA    $01,S
                        SHORT  M
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $9F,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $A2,S
                        LONG   M
                        PEA    $5B5B
                        PHY
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $01,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$B0EE
                        STA    $04,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $A3,S
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
; MARK: ENEMY1_003B
ENEMY1_003B             ENTRY
                        CLC                              ; 20x16, 283 bytes, 450 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 5
                        LDY    #$2B52                    ; Pattern #2 : 3
                        LDA    #$BB2B                    ; Pattern #3 : 3
                        TCD
;--
                        LDA    #$55BB                    ; Line 0
                        STA    $03,S
                        STA    $A3,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$50B5
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A3,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    #$55B5
                        STA    $A3,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $03,S
                        SHORT  M
                        LDA    #$BB
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0146
                        TCS
                        PHD
                        PEA    $52B5
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9C,S
                        LONG   M
                        PHD
                        PEA    $52B5
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A0,S
                        LONG   M
                        PHD
                        PEA    $525B
                        TSC                              ; Line 9
                        ADC    #$00A3
                        TCS
                        PEA    $2555
                        PEA    $55B5
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$05
                        STA    $9C,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $A2,S
                        LONG   M
                        PHX
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00A4
                        TCS
                        LDA    #$5B55
                        STA    $9D,S
                        LDA    #$DDBB
                        STA    $A0,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9C,S
                        LDA    $9F,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9F,S
                        LONG   M
                        PEA    $B5B5
                        PHX
                        TSC                              ; Line 13
                        ADC    #$013F
                        TCS
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0EB0
                        STA    $03,S
                        SHORT  M
                        LDA    #$BB
                        STA    $02,S
                        LDA    #$EB
                        STA    $05,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $A4,S
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
; MARK: ENEMY1_004A
ENEMY1_004A             ENTRY
                        CLC                              ; 20x16, 265 bytes, 430 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 3
                        LDY    #$5525                    ; Pattern #2 : 2
                        LDA    #$5BBB                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        TDC
                        STA    $A2,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$505B
                        STA    $03,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A4,S
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    #$55BB
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$50B5
                        STA    $A3,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $A3,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$50B5
                        STA    $03,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$05
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0144
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$50B5
                        STA    $01,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $A2,S
                        PEA    $55B2
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A1,S
                        PHY
                        PEA    $225B
                        PEA    $55B5
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9B,S
                        LONG   M
                        PHY
                        PEA    $225B
                        PEA    $55B5
                        TSC                              ; Line 10
                        ADC    #$00A7
                        TCS
                        LDA    $9D,S
                        AND    #$0F00
                        ORA    #$50BB
                        STA    $9D,S
                        PHX
                        PEA    $55B2
                        PEA    $BBBB
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    #$EBEE
                        STA    $A2,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$50BB
                        STA    $03,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$D0DD
                        STA    $A4,S
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
; MARK: ENEMY1_004B
ENEMY1_004B             ENTRY
                        CLC                              ; 20x16, 274 bytes, 439 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 4
                        LDY    #$22B2                    ; Pattern #2 : 2
                        LDA    #$5522                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    #$55B5
                        STA    $A4,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$B505
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$B50B
                        STA    $A2,S
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    #$B5BB
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $A3,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$50
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    #$B55B
                        STA    $A3,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $03,S
                        SHORT  M
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $01,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $A0,S
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $555B
                        PEA    $255B
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $99,S
                        PEA    $5B55
                        PHD
                        PEA    $B255
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$50
                        STA    $A0,S
                        LONG   M
                        PHX
                        PHD
                        PEA    $B255
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$B50B
                        STA    $9D,S
                        PHX
                        PEA    $25BB
                        PEA    $BBBB
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    #$DDBD
                        STA    $A4,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$B50B
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$EE0E
                        STA    $A2,S
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
; MARK: ENEMY1_005A
ENEMY1_005A             ENTRY
                        CLC                              ; 20x16, 350 bytes, 559 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$22BB                    ; Pattern #1 : 3
                        LDY    #$5555                    ; Pattern #2 : 3
                        LDA    #$5B5B                    ; Pattern #3 : 1
                        TCD
;--
                        LDA    #$BB5B                    ; Line 0
                        STA    $A4,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$5B05
                        STA    $03,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $05,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$05
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A4,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $04,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$B50B
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $A4,S
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        STA    $A2,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $A4,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $01,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A6,S
                        LONG   M
                        TSC
                        ADC    #$0005
                        TCS
                        PHD
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        TYA
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A0,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$05
                        STA    $9D,S
                        LONG   M
                        PHY
                        PEA    $25B5
                        TSC                              ; Line 11
                        ADC    #$013F
                        TCS
                        LDA    #$BBEB
                        STA    $A2,S
                        LDA    #$5B55
                        STA    $A5,S
                        LDA    $01,S
                        AND    #$F00F
                        ORA    #$05E0
                        STA    $01,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $A1,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A4,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PHY
                        PEA    $B5B5
                        TSC                              ; Line 13
                        ADC    #$013E
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$DD0B
                        STA    $02,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $05,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $A4,S
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
; MARK: ENEMY1_005B
ENEMY1_005B             ENTRY
                        CLC                              ; 20x16, 283 bytes, 450 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 5
                        LDY    #$B2BB                    ; Pattern #2 : 3
                        LDA    #$25B2                    ; Pattern #3 : 3
                        TCD
;--
                        LDA    #$BB55                    ; Line 0
                        STA    $04,S
                        STA    $A4,S
                        SHORT  M
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$5B05
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $A4,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    #$55BB
                        STA    $A3,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $04,S
                        SHORT  M
                        LDA    #$5B
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0145
                        TCS
                        PEA    $5B25
                        PHY
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A1,S
                        LONG   M
                        PEA    $5B25
                        PHY
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9D,S
                        LONG   M
                        PEA    $B525
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A5
                        TCS
                        PEA    $5B55
                        PEA    $5552
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$50
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00A4
                        TCS
                        LDA    #$BBEE
                        STA    $9C,S
                        LDA    #$55B5
                        STA    $9F,S
                        SHORT  M
                        LDA    $9E,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $9E,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A1,S
                        LONG   M
                        PHX
                        PEA    $5B5B
                        TSC                              ; Line 13
                        ADC    #$013E
                        TCS
                        LDA    $04,S
                        AND    #$F00F
                        ORA    #$0BD0
                        STA    $04,S
                        SHORT  M
                        LDA    #$BD
                        STA    $03,S
                        LDA    #$BB
                        STA    $06,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $A4,S
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
; MARK: ENEMY1_006A
ENEMY1_006A             ENTRY
                        CLC                              ; 20x16, 310 bytes, 490 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 3
                        LDY    #$BB55                    ; Pattern #2 : 2
                        LDA    #$55BB                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A5,S
                        SHORT  M
                        LDA    #$55
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    #$5B55
                        STA    $05,S
                        TYA
                        STA    $A5,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$05
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0145
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9C,S
                        LONG   M
                        PEA    $5B55
                        PEA    $BBBB
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        LDA    #$25B2
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$B05B
                        STA    $9F,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9C,S
                        LONG   M
                        PHY
                        PHD
                        TSC                              ; Line 9
                        ADC    #$013F
                        TCS
                        LDA    #$2522
                        STA    $02,S
                        TXA
                        STA    $A3,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $04,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$2205
                        STA    $A1,S
                        SHORT  M
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$50
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        LDA    $00,S
                        AND    #$F0F0
                        ORA    #$050E
                        STA    $00,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $04,S
                        SHORT  M
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$50
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$00A4
                        TCS
                        LDA    $9E,S
                        AND    #$F000
                        ORA    #$0BBB
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $A0,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9D,S
                        LONG   M
                        PEA    $55B5
                        PEA    $5BE5
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$BB
                        STA    $04,S
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $A2,S
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
; MARK: ENEMY1_006B
ENEMY1_006B             ENTRY
                        CLC                              ; 20x16, 279 bytes, 453 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 5
                        LDY    #$5B55                    ; Pattern #2 : 3
                        LDA    #$B5BB                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $05,S
                        AND    #$0FF0
                        ORA    #$5005
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $A5,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $A5,S
                        LDA    $05,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $05,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $07,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $05,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $02,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A5
                        TCS
                        PHY
                        PHD
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        TYA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $9D,S
                        PEA    $BB55
                        PEA    $22BB
                        TSC                              ; Line 10
                        ADC    #$0144
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $9C,S
                        LONG   M
                        PHX
                        PEA    $2552
                        TSC                              ; Line 11
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $9C,S
                        LONG   M
                        PHX
                        PHX
                        TSC                              ; Line 12
                        ADC    #$00A4
                        TCS
                        LDA    #$5BB5
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $9D,S
                        PHX
                        PEA    $BB55
                        TSC                              ; Line 14
                        ADC    #$013F
                        TCS
                        LDA    $04,S
                        AND    #$0FF0
                        ORA    #$B00B
                        STA    $04,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $02,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $A3,S
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
; MARK: ENEMY1_007A
ENEMY1_007A             ENTRY
                        CLC                              ; 20x16, 278 bytes, 447 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 5
                        LDY    #$5B55                    ; Pattern #2 : 3
                        LDA    #$5522                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $A5,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $A5,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$50
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $05,S
                        STA    $A5,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $07,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$50
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0145
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$50B5
                        STA    $01,S
                        PHX
                        PEA    $22BB
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        LDA    #$5552
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $9F,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $9B,S
                        LONG   M
                        PHY
                        PEA    $25B2
                        TSC                              ; Line 9
                        ADC    #$013F
                        TCS
                        TYA
                        STA    $02,S
                        LDA    $00,S
                        AND    #$F0F0
                        ORA    #$050E
                        STA    $00,S
                        SHORT  M
                        LDA    #$BB
                        STA    $04,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9C,S
                        LONG   M
                        PHX
                        PHY
                        TSC                              ; Line 11
                        ADC    #$00A4
                        TCS
                        LDA    #$B5DB
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $9F,S
                        PHX
                        PEA    $B5B5
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$F00F
                        ORA    #$0BD0
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $03,S
                        SHORT  M
                        LDA    #$BB
                        STA    $A3,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $A1,S
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
; MARK: ENEMY1_007B
ENEMY1_007B             ENTRY
                        CLC                              ; 20x16, 299 bytes, 481 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 5
                        LDY    #$5B55                    ; Pattern #2 : 3
                        LDA    #$555B                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A6,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$05
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $06,S
                        TXA
                        STA    $A6,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$05
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$F0
                        ORA    #$05
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A4,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$B20B
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$220B
                        STA    $A2,S
                        SHORT  M
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A6,S
                        LONG   M
                        TSC
                        ADC    #$0007
                        TCS
                        PHD
                        PEA    $5525
                        TSC                              ; Line 8
                        ADC    #$013D
                        TCS
                        TYA
                        STA    $04,S
                        TXA
                        STA    $A2,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$2505
                        STA    $02,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A4,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $00,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 10
                        ADC    #$0144
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$50
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$50
                        STA    $A1,S
                        LONG   M
                        PEA    $55B5
                        PEA    $55E5
                        TSC                              ; Line 11
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$BB0D
                        STA    $9D,S
                        PHX
                        PEA    $5BBB
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    #$5BB5
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$F00F
                        ORA    #$0BD0
                        STA    $A2,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $01,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A4,S
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
; MARK: ENEMY1_008A
ENEMY1_008A             ENTRY
                        CLC                              ; 20x16, 207 bytes, 340 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 6
                        LDY    #$BBBB                    ; Pattern #2 : 3
                        LDA    #$55B5                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 5
                        ADC    #$0320
                        TCS
                        LDA    #$5B55
                        STA    $A6,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$5005
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $A2,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $A0,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$000F
                        ORA    #$55E0
                        STA    $00,S
                        TSC
                        ADC    #$0007
                        TCS
                        PEA    $5B55
                        PHD
                        PEA    $2222
                        TSC                              ; Line 8
                        ADC    #$00A6
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $9F,S
                        PEA    $B5BB
                        PHX
                        PHX
                        PHD
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A0,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $9B,S
                        LONG   M
                        PHX
                        PHY
                        PEA    $55D5
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $9C,S
                        LONG   M
                        PHY
                        PEA    $BB5B
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
; MARK: ENEMY1_008B
ENEMY1_008B             ENTRY
                        CLC                              ; 20x16, 226 bytes, 364 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 8
                        LDY    #$BBBB                    ; Pattern #2 : 2
                        LDA    #$B5BB                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 5
                        ADC    #$0320
                        TCS
                        LDA    #$2B22
                        STA    $A3,S
                        LDA    $A6,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $A6,S
                        SHORT  M
                        LDA    #$55
                        STA    $07,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $A0,S
                        LDA    $A8,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A8,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$F0F0
                        ORA    #$050E
                        STA    $00,S
                        LDA    $A7,S
                        AND    #$0F00
                        ORA    #$50BB
                        STA    $A7,S
                        SHORT  M
                        LDA    $08,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $08,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A0,S
                        LONG   M
                        TSC
                        ADC    #$0007
                        TCS
                        PHX
                        PEA    $552B
                        PEA    $2252
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$550D
                        STA    $9A,S
                        PEA    $5B55
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A7
                        TCS
                        LDA    $99,S
                        AND    #$F0F0
                        ORA    #$050D
                        STA    $99,S
                        SHORT  M
                        LDA    #$55
                        STA    $9F,S
                        LONG   M
                        PHX
                        PEA    $55B5
                        PEA    $BB5B
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $9B,S
                        LONG   M
                        PHD
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
; MARK: ENEMY1_009A
ENEMY1_009A             ENTRY
                        CLC                              ; 20x16, 265 bytes, 429 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 6
                        LDY    #$5B55                    ; Pattern #2 : 2
                        LDA    #$BBBB                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A3,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    #$55E5
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $03,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$BB0D
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A0,S
                        SHORT  M
                        LDA    #$55
                        STA    $A3,S
                        LONG   M
                        PEA    $2252
                        PHX
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$F00F
                        ORA    #$0BD0
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$F00F
                        ORA    #$05D0
                        STA    $A0,S
                        TSC
                        ADC    #$0007
                        TCS
                        PHX
                        PHX
                        PEA    $B5B5
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    #$5B
                        STA    $A0,S
                        LONG   M
                        PEA    $5BB5
                        PEA    $55B5
                        PHY
                        TSC                              ; Line 11
                        ADC    #$00A5
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $9A,S
                        LDA    $9C,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A0,S
                        PHD
                        PEA    $BB5B
                        PHX
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $01,S
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
; MARK: ENEMY1_009B
ENEMY1_009B             ENTRY
                        CLC                              ; 20x16, 274 bytes, 439 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 7
                        LDY    #$55B5                    ; Pattern #2 : 2
                        LDA    #$555B                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        LDA    $A2,S
                        AND    #$F00F
                        ORA    #$0BE0
                        STA    $A2,S
                        SHORT  M
                        LDA    #$BB
                        STA    $A4,S
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    #$2252
                        STA    $03,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$550E
                        STA    $01,S
                        SHORT  M
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        LDA    $A3,S
                        AND    #$0FF0
                        ORA    #$5005
                        STA    $A3,S
                        SHORT  M
                        LDA    #$DB
                        STA    $9D,S
                        LONG   M
                        PEA    $2255
                        PHY
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $9B,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$50
                        STA    $A3,S
                        LONG   M
                        PHX
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $99,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $99,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHX
                        PEA    $5BBB
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $9A,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0B5
                        STA    $A0,S
                        PHD
                        PEA    $55BB
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00A5
                        TCS
                        LDA    #$5B55
                        STA    $9B,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $A0,S
                        SHORT  M
                        LDA    #$BB
                        STA    $9D,S
                        LONG   M
                        PEA    $BBBB
                        PEA    $BB55
                        TSC                              ; Line 13
                        ADC    #$013E
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $01,S
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
; MARK: ENEMY1_010A
ENEMY1_010A             ENTRY
                        CLC                              ; 20x16, 299 bytes, 482 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 6
                        LDY    #$5B55                    ; Pattern #2 : 3
                        LDA    #$55B5                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$05
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$505B
                        STA    $04,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $01,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        LDA    #$22B5
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$F0F0
                        ORA    #$0B0D
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B02B
                        STA    $A0,S
                        PEA    $BB22
                        PEA    $55DB
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    #$52B5
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$B022
                        STA    $04,S
                        SHORT  M
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$50
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $9C,S
                        PHX
                        PEA    $55BB
                        TSC                              ; Line 9
                        ADC    #$00A5
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A1,S
                        PHX
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9C,S
                        STA    $A1,S
                        LDA    $9E,S
                        AND    #$F00F
                        ORA    #$0BB0
                        STA    $9E,S
                        SHORT  M
                        LDA    #$BB
                        STA    $9B,S
                        LDA    #$B5
                        STA    $A0,S
                        LONG   M
                        PHD
                        PHY
                        PHD
                        TSC                              ; Line 12
                        ADC    #$0141
                        TCS
                        LDA    $05,S
                        AND    #$00F0
                        ORA    #$5B0B
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $A5,S
                        SHORT  M
                        LDA    #$BB
                        STA    $01,S
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$50
                        STA    $07,S
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
; MARK: ENEMY1_010B
ENEMY1_010B             ENTRY
                        CLC                              ; 20x16, 270 bytes, 439 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 6
                        LDY    #$55B5                    ; Pattern #2 : 3
                        LDA    #$B5B5                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $A2,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$50
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0145
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $9C,S
                        LONG   M
                        PHD
                        PHY
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $9C,S
                        LONG   M
                        PEA    $BB2B
                        PEA    $52B5
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        LDA    #$2B22
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $9D,S
                        PEA    $BB22
                        PEA    $52BB
                        TSC                              ; Line 8
                        ADC    #$013F
                        TCS
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A5,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $01,S
                        LONG   M
                        TSC
                        ADC    #$0005
                        TCS
                        PHX
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A3
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $9C,S
                        PEA    $B555
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A7
                        TCS
                        LDA    #$5B55
                        STA    $9B,S
                        LDA    #$55BB
                        STA    $9E,S
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$B50B
                        STA    $99,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A0,S
                        PHX
                        PEA    $55BB
                        PHX
                        TSC                              ; Line 12
                        ADC    #$013F
                        TCS
                        TDC
                        STA    $06,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$B00B
                        STA    $01,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A6,S
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
; MARK: ENEMY1_011A
ENEMY1_011A             ENTRY
                        CLC                              ; 20x16, 315 bytes, 508 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 6
                        LDY    #$55B5                    ; Pattern #2 : 3
                        LDA    #$BB2B                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $03,S
                        AND    #$0FF0
                        ORA    #$E00E
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$E0DB
                        STA    $A2,S
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    #$5B55
                        STA    $A3,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $02,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A5,S
                        SHORT  M
                        LDA    #$DD
                        STA    $01,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0145
                        TCS
                        SHORT  M
                        LDA    #$BB
                        STA    $A0,S
                        LONG   M
                        PHD
                        PEA    $52BB
                        TSC                              ; Line 6
                        ADC    #$00A3
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B022
                        STA    $A0,S
                        PEA    $2252
                        PEA    $B5BB
                        TSC                              ; Line 8
                        ADC    #$0143
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$5052
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A1,S
                        PHX
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$B50B
                        STA    $9D,S
                        PEA    $B555
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        TYA
                        STA    $9F,S
                        SHORT  M
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9E,S
                        LONG   M
                        PHX
                        PEA    $BB55
                        TSC                              ; Line 12
                        ADC    #$013F
                        TCS
                        TXA
                        STA    $A5,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $04,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$50
                        STA    $06,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$05
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$5B05
                        STA    $04,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$50
                        STA    $06,S
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
; MARK: ENEMY1_011B
ENEMY1_011B             ENTRY
                        CLC                              ; 20x16, 296 bytes, 476 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 5
                        LDY    #$55BB                    ; Pattern #2 : 2
                        LDA    #$5B55                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$BE0D
                        STA    $A2,S
                        SHORT  M
                        LDA    #$EE
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$D00D
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$50B5
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $05,S
                        TSC                              ; Line 4
                        ADC    #$00A6
                        TCS
                        LDA    #$22B5
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $9F,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9C,S
                        LONG   M
                        PEA    $BBBB
                        PEA    $55B5
                        TSC                              ; Line 6
                        ADC    #$013E
                        TCS
                        LDA    #$2255
                        STA    $03,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $01,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$B02B
                        STA    $05,S
                        SHORT  M
                        LDA    #$B5
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A5
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $9B,S
                        PEA    $2B52
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $9B,S
                        PEA    $2555
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A0,S
                        PHX
                        PHD
                        TSC                              ; Line 10
                        ADC    #$00A3
                        TCS
                        TYA
                        STA    $A0,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$50
                        STA    $A2,S
                        LONG   M
                        PEA    $B55B
                        PHY
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    #$55B5
                        STA    $05,S
                        TXA
                        STA    $A5,S
                        SHORT  M
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$50
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        LDA    #$B555
                        STA    $05,S
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
; MARK: ENEMY1_012A
ENEMY1_012A             ENTRY
                        CLC                              ; 20x16, 274 bytes, 439 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 3
                        LDY    #$2522                    ; Pattern #2 : 2
                        LDA    #$55B2                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$DBDD
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$E0EE
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$50BB
                        STA    $A3,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$50BB
                        STA    $03,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$00A6
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A0,S
                        PHX
                        PHD
                        PEA    $BBBB
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $A1,S
                        PEA    $5525
                        PEA    $225B
                        PEA    $55B5
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$50B5
                        STA    $A0,S
                        PEA    $5525
                        PEA    $225B
                        PEA    $55B5
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        LDA    #$5BBB
                        STA    $9F,S
                        SHORT  M
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$05
                        STA    $9E,S
                        LONG   M
                        PHD
                        PHX
                        TSC                              ; Line 10
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$50B5
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$50B5
                        STA    $A3,S
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    #$55BB
                        STA    $03,S
                        LDA    #$5BBB
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A4,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$505B
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
; MARK: ENEMY1_012B
ENEMY1_012B             ENTRY
                        CLC                              ; 20x16, 274 bytes, 439 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 4
                        LDY    #$22B2                    ; Pattern #2 : 2
                        LDA    #$B255                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$EEBE
                        STA    $04,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$DD0D
                        STA    $02,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$B50B
                        STA    $A3,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$B50B
                        STA    $03,S
                        SHORT  M
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$50
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$00A6
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $9A,S
                        PHX
                        PEA    $25BB
                        PEA    $BBBB
                        TSC                              ; Line 6
                        ADC    #$00A7
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $99,S
                        PHX
                        PEA    $5522
                        PHD
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $9A,S
                        PEA    $5B55
                        PEA    $5522
                        PHD
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        LDA    #$B55B
                        STA    $9D,S
                        SHORT  M
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $9F,S
                        LONG   M
                        PEA    $555B
                        PEA    $255B
                        TSC                              ; Line 10
                        ADC    #$013E
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$550B
                        STA    $A3,S
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    #$B5BB
                        STA    $03,S
                        LDA    #$55B5
                        STA    $A4,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$B50B
                        STA    $A2,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$50
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$B505
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
; MARK: ENEMY1_013A
ENEMY1_013A             ENTRY
                        CLC                              ; 20x16, 320 bytes, 515 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 6
                        LDY    #$5B55                    ; Pattern #2 : 3
                        LDA    #$BB25                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $03,S
                        AND    #$0FF0
                        ORA    #$D00D
                        STA    $03,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$BE0D
                        STA    $A4,S
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    #$B5BB
                        STA    $A2,S
                        LDA    $03,S
                        AND    #$000F
                        ORA    #$55B0
                        STA    $03,S
                        LDA    $05,S
                        AND    #$000F
                        ORA    #$EEB0
                        STA    $05,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $A4,S
                        SHORT  M
                        LDA    #$BB
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0145
                        TCS
                        SHORT  M
                        LDA    #$BB
                        STA    $A1,S
                        LONG   M
                        PHD
                        PEA    $B2BB
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$220B
                        STA    $9D,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $A1,S
                        PEA    $5B25
                        PEA    $22BB
                        TSC                              ; Line 8
                        ADC    #$013F
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$2505
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $A2,S
                        TSC
                        ADC    #$0007
                        TCS
                        PHY
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$B05B
                        STA    $9F,S
                        PHY
                        PEA    $555B
                        TSC                              ; Line 10
                        ADC    #$00A2
                        TCS
                        TYA
                        STA    $9D,S
                        SHORT  M
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $9F,S
                        LONG   M
                        PEA    $55BB
                        PHX
                        TSC                              ; Line 12
                        ADC    #$013F
                        TCS
                        TXA
                        STA    $A1,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $01,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$50
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$B505
                        STA    $01,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$50
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
; MARK: ENEMY1_013B
ENEMY1_013B             ENTRY
                        CLC                              ; 20x16, 296 bytes, 476 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 5
                        LDY    #$55B5                    ; Pattern #2 : 2
                        LDA    #$5B55                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$E0DB
                        STA    $A5,S
                        SHORT  M
                        LDA    #$DD
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $02,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$5B05
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$E00E
                        STA    $06,S
                        TSC                              ; Line 4
                        ADC    #$00A5
                        TCS
                        LDA    #$22BB
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B05B
                        STA    $A0,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9D,S
                        LONG   M
                        PHD
                        PEA    $BBBB
                        TSC                              ; Line 6
                        ADC    #$013F
                        TCS
                        LDA    #$5522
                        STA    $04,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$B20B
                        STA    $02,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $06,S
                        SHORT  M
                        LDA    #$5B
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $A1,S
                        PHX
                        PEA    $25B2
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $A1,S
                        PHX
                        PEA    $5552
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $9C,S
                        PHY
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        LDA    #$BB55
                        STA    $9C,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$05
                        STA    $9B,S
                        LONG   M
                        PEA    $BB55
                        PEA    $B55B
                        TSC                              ; Line 12
                        ADC    #$013D
                        TCS
                        TDC
                        STA    $02,S
                        TXA
                        STA    $A2,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$05
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        LDA    #$555B
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
; MARK: ENEMY1_014A
ENEMY1_014A             ENTRY
                        CLC                              ; 20x16, 300 bytes, 483 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 4
                        LDY    #$55B5                    ; Pattern #2 : 3
                        LDA    #$5B55                    ; Pattern #3 : 3
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $05,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$50
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $04,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$B505
                        STA    $02,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$00A6
                        TCS
                        LDA    #$5B22
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$B20B
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F0F
                        ORA    #$E0B0
                        STA    $A0,S
                        PEA    $BE55
                        PEA    $22BB
                        TSC                              ; Line 7
                        ADC    #$013E
                        TCS
                        LDA    #$5B25
                        STA    $04,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$220B
                        STA    $02,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$05
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$00A6
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $A0,S
                        PEA    $BB55
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A3
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $9B,S
                        PHY
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        TDC
                        STA    $9A,S
                        LDA    #$BB55
                        STA    $9F,S
                        LDA    $9C,S
                        AND    #$F00F
                        ORA    #$0BB0
                        STA    $9C,S
                        SHORT  M
                        LDA    #$55
                        STA    $99,S
                        STA    $9E,S
                        LONG   M
                        PHD
                        PHY
                        PHD
                        TSC                              ; Line 12
                        ADC    #$013F
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$B505
                        STA    $00,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A1,S
                        SHORT  M
                        LDA    #$BB
                        STA    $06,S
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $02,S
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
; MARK: ENEMY1_014B
ENEMY1_014B             ENTRY
                        CLC                              ; 20x16, 267 bytes, 433 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 6
                        LDY    #$5B55                    ; Pattern #2 : 3
                        LDA    #$555B                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $05,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$05
                        STA    $A3,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0146
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $A1,S
                        LONG   M
                        PHY
                        PEA    $5B5B
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $A1,S
                        LONG   M
                        PEA    $5B25
                        PEA    $B2BB
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        LDA    #$22B2
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $9F,S
                        PEA    $BB25
                        PEA    $22BB
                        TSC                              ; Line 8
                        ADC    #$0144
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $9C,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $01,S
                        LONG   M
                        PHY
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A5
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B055
                        STA    $A0,S
                        PHY
                        PHD
                        TSC                              ; Line 10
                        ADC    #$00A3
                        TCS
                        LDA    #$BB55
                        STA    $9C,S
                        LDA    #$55B5
                        STA    $9F,S
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $9A,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$B05B
                        STA    $A1,S
                        PHX
                        PEA    $BB55
                        PHX
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    #$5B5B
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$B00B
                        STA    $06,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $A1,S
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
; MARK: ENEMY1_015A
ENEMY1_015A             ENTRY
                        CLC                              ; 20x16, 260 bytes, 422 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 6
                        LDY    #$5B55                    ; Pattern #2 : 2
                        LDA    #$55B5                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $A3,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    #$5D55
                        STA    $05,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $03,S
                        SHORT  M
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$5505
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$E0BB
                        STA    $A0,S
                        SHORT  M
                        LDA    #$55
                        STA    $9A,S
                        LONG   M
                        PHX
                        PEA    $2522
                        TSC                              ; Line 9
                        ADC    #$0143
                        TCS
                        LDA    $01,S
                        AND    #$F00F
                        ORA    #$0EB0
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$F00F
                        ORA    #$0E50
                        STA    $A1,S
                        PEA    $5B5B
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    #$B5
                        STA    $9B,S
                        LONG   M
                        PHD
                        PHY
                        PEA    $5BB5
                        TSC                              ; Line 11
                        ADC    #$00A7
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $9A,S
                        LDA    $9E,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A0,S
                        PHX
                        PEA    $B5BB
                        PEA    $BBBB
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    $05,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $05,S
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
; MARK: ENEMY1_015B
ENEMY1_015B             ENTRY
                        CLC                              ; 20x16, 276 bytes, 440 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$5555                    ; Pattern #1 : 7
                        LDY    #$B555                    ; Pattern #2 : 2
                        LDA    #$BBBB                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        LDA    $A5,S
                        AND    #$F00F
                        ORA    #$0DB0
                        STA    $A5,S
                        SHORT  M
                        LDA    #$BB
                        STA    $A4,S
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    #$2522
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$D055
                        STA    $06,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A7
                        TCS
                        LDA    $99,S
                        AND    #$0FF0
                        ORA    #$5005
                        STA    $99,S
                        SHORT  M
                        LDA    #$BE
                        STA    $A0,S
                        LONG   M
                        PEA    $5B55
                        PEA    $5522
                        TSC                              ; Line 8
                        ADC    #$00A3
                        TCS
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$05
                        STA    $9A,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $A2,S
                        LONG   M
                        PEA    $5B55
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9A,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $A2,S
                        LONG   M
                        PEA    $BBB5
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$5B0B
                        STA    $9A,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$5055
                        STA    $A0,S
                        PHX
                        PEA    $BB55
                        PHY
                        TSC                              ; Line 11
                        ADC    #$00A5
                        TCS
                        LDA    #$B5BB
                        STA    $A0,S
                        LDA    $9C,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $9C,S
                        SHORT  M
                        LDA    #$55
                        STA    $A2,S
                        LONG   M
                        PEA    $55BB
                        PHD
                        TSC                              ; Line 13
                        ADC    #$013F
                        TCS
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $06,S
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
