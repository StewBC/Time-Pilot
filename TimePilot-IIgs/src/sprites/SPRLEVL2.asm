                        MCOPY  src/sprites/SPRLEVL2.mac

SPRLEVL2                START  LEVL2

                        USING  VARIABLES

; MARK: BOSS2_000A
BOSS2_000A              ENTRY
                        CLC                              ; 32x13, 388 bytes, 650 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 15
                        LDY    #$6666                    ; Pattern #2 : 13
                        LDA    #$8688                    ; Pattern #3 : 4
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        LDA    $07,S
                        AND    #$F00F
                        ORA    #$0ED0
                        STA    $07,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $A2,S
                        LDA    $AB,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $AB,S
                        SHORT  M
                        LDA    #$EE
                        STA    $00,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A4,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $DD1D
                        PEA    $1116
                        PEA    $11EE
                        TSC
                        ADC    #$000E
                        TCS
                        PEA    $DD1D
                        PEA    $1116
                        PEA    $11EE
                        TSC                              ; Line 5
                        ADC    #$0138
                        TCS
                        TXA
                        STA    $02,S
                        STA    $0B,S
                        LDA    #$6886
                        STA    $A2,S
                        TDC
                        STA    $AA,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A4,S
                        LDA    $AC,S
                        AND    #$0F00
                        ORA    #$1061
                        STA    $AC,S
                        SHORT  M
                        LDA    #$88
                        STA    $04,S
                        LDA    $0A,S
                        AND    #$F0
                        ORA    #$08
                        STA    $0A,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$08
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $AD,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $01,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$6011
                        STA    $0D,S
                        LDA    $A6,S
                        AND    #$000F
                        ORA    #$6660
                        STA    $A6,S
                        LDA    $A8,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A8,S
                        LDA    $AB,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $AB,S
                        SHORT  M
                        LDA    #$66
                        STA    $AA,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A1,S
                        LDA    $AF,S
                        AND    #$0F
                        ORA    #$60
                        STA    $AF,S
                        LONG   M
                        TSC
                        ADC    #$000C
                        TCS
                        PEA    $6166
                        PHX
                        PHY
                        PHY
                        PHD
                        TSC                              ; Line 8
                        ADC    #$00A3
                        TCS
                        LDA    $A9,S
                        AND    #$0F00
                        ORA    #$6086
                        STA    $A9,S
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00AC
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$8068
                        STA    $A0,S
                        PEA    $8866
                        PHY
                        PHY
                        PHY
                        PHD
                        PEA    $8868
                        TSC                              ; Line 10
                        ADC    #$00AB
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $99,S
                        SHORT  M
                        LDA    #$88
                        STA    $98,S
                        LDA    $9F,S
                        AND    #$F0
                        ORA    #$08
                        STA    $9F,S
                        LONG   M
                        PHD
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
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
; MARK: BOSS2_000B
BOSS2_000B              ENTRY
                        CLC                              ; 32x13, 349 bytes, 592 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$6666                    ; Pattern #1 : 15
                        LDY    #$8888                    ; Pattern #2 : 14
                        LDA    #$6688                    ; Pattern #3 : 5
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TYA
                        STA    $A3,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$EE0E
                        STA    $00,S
                        LDA    $AB,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $AB,S
                        SHORT  M
                        LDA    $0F,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $0F,S
                        LONG   M
                        TSC
                        ADC    #$0007
                        TCS
                        PEA    $DDDD
                        PEA    $1161
                        PEA    $11E1
                        TSC
                        ADC    #$000D
                        TCS
                        PEA    $DD11
                        PEA    $6111
                        PEA    $E1EE
                        TSC                              ; Line 5
                        ADC    #$0138
                        TCS
                        TYA
                        STA    $0B,S
                        LDA    #$1166
                        STA    $AC,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $04,S
                        LDA    $AA,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $AA,S
                        SHORT  M
                        LDA    $0D,S
                        AND    #$0F
                        ORA    #$80
                        STA    $0D,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $9D,S
                        LONG   M
                        PHY
                        PHD
                        TSC                              ; Line 7
                        ADC    #$00AD
                        TCS
                        LDA    $99,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $99,S
                        LDA    $9C,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $9C,S
                        SHORT  M
                        LDA    #$66
                        STA    $94,S
                        STA    $9B,S
                        LONG   M
                        PEA    $1611
                        PEA    $6686
                        PEA    $8868
                        PHX
                        PHX
                        PEA    $8818
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$8806
                        STA    $9C,S
                        PHX
                        PHX
                        TSC
                        ADC    #$000D
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $94,S
                        PHD
                        PEA    $6866
                        PHX
                        PHX
                        PHX
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00AB
                        TCS
                        LDA    $96,S
                        AND    #$0FF0
                        ORA    #$8008
                        STA    $96,S
                        LDA    $9D,S
                        AND    #$0F0F
                        ORA    #$8080
                        STA    $9D,S
                        SHORT  M
                        LDA    #$88
                        STA    $9C,S
                        LONG   M
                        PEA    $8866
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 11
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9C,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A2,S
                        LONG   M
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
; MARK: BOSS2_001A
BOSS2_001A              ENTRY
                        CLC                              ; 32x13, 395 bytes, 650 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 11
                        LDY    #$6666                    ; Pattern #2 : 5
                        LDA    #$1111                    ; Pattern #3 : 3
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        LDA    $07,S
                        AND    #$F00F
                        ORA    #$0ED0
                        STA    $07,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F00F
                        ORA    #$0180
                        STA    $A4,S
                        LDA    $AB,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $AB,S
                        SHORT  M
                        LDA    #$EE
                        STA    $00,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $DD1D
                        PEA    $1116
                        PEA    $11EE
                        TSC
                        ADC    #$000E
                        TCS
                        PEA    $DD1D
                        PEA    $1116
                        PEA    $11EE
                        TSC                              ; Line 5
                        ADC    #$0138
                        TCS
                        TXA
                        STA    $02,S
                        STA    $0B,S
                        LDA    #$8688
                        STA    $AA,S
                        LDA    $06,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A6,S
                        LDA    $AC,S
                        AND    #$0F00
                        ORA    #$1061
                        STA    $AC,S
                        SHORT  M
                        LDA    #$11
                        STA    $04,S
                        LDA    $0A,S
                        AND    #$F0
                        ORA    #$08
                        STA    $0A,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$08
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9C,S
                        LDA    $A8,S
                        AND    #$0F00
                        ORA    #$6011
                        STA    $A8,S
                        PEA    $1181
                        PEA    $6886
                        TSC                              ; Line 7
                        ADC    #$00AB
                        TCS
                        TYA
                        STA    $A1,S
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $95,S
                        LDA    $9D,S
                        AND    #$000F
                        ORA    #$6660
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $9F,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A3,S
                        LONG   M
                        PEA    $6166
                        PHX
                        PEA    $6611
                        PEA    $1161
                        PEA    $1688
                        TSC                              ; Line 8
                        ADC    #$00A6
                        TCS
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$6086
                        STA    $A6,S
                        PHD
                        PEA    $6111
                        PEA    $6166
                        TSC                              ; Line 9
                        ADC    #$00AB
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$8068
                        STA    $A0,S
                        PEA    $8866
                        PHY
                        PHY
                        PEA    $6161
                        PHD
                        PEA    $8868
                        TSC                              ; Line 10
                        ADC    #$00AB
                        TCS
                        LDA    $9E,S
                        AND    #$F000
                        ORA    #$0888
                        STA    $9E,S
                        PEA    $8688
                        PHX
                        PHX
                        PEA    $1818
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9C,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        PHX
                        PHX
                        PEA    $1881
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
; MARK: BOSS2_001B
BOSS2_001B              ENTRY
                        CLC                              ; 32x13, 378 bytes, 621 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 11
                        LDY    #$6666                    ; Pattern #2 : 8
                        LDA    #$1611                    ; Pattern #3 : 4
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TXA
                        STA    $A3,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$EE0E
                        STA    $00,S
                        LDA    $AB,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $AB,S
                        SHORT  M
                        LDA    $0F,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $0F,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A6,S
                        LONG   M
                        TSC
                        ADC    #$0007
                        TCS
                        PEA    $DDDD
                        PEA    $1161
                        PEA    $11E1
                        TSC
                        ADC    #$000D
                        TCS
                        PEA    $DD11
                        PEA    $6111
                        PEA    $E1EE
                        TSC                              ; Line 5
                        ADC    #$0138
                        TCS
                        TXA
                        STA    $0B,S
                        LDA    #$1166
                        STA    $AC,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$1081
                        STA    $04,S
                        LDA    $06,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$F000
                        ORA    #$0111
                        STA    $A6,S
                        LDA    $AA,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $AA,S
                        SHORT  M
                        LDA    $0D,S
                        AND    #$0F
                        ORA    #$80
                        STA    $0D,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$16
                        STA    $A9,S
                        LONG   M
                        PEA    $1188
                        PEA    $6688
                        TSC                              ; Line 7
                        ADC    #$00AC
                        TCS
                        LDA    $9D,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $9D,S
                        PEA    $1166
                        PEA    $8688
                        PEA    $6816
                        PEA    $1111
                        PEA    $6681
                        PEA    $1811
                        TSC                              ; Line 8
                        ADC    #$00A8
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$8806
                        STA    $99,S
                        PHD
                        PEA    $1116
                        PEA    $1166
                        PHY
                        TSC
                        ADC    #$000E
                        TCS
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $94,S
                        PEA    $6688
                        PEA    $6866
                        PHY
                        PEA    $6616
                        PEA    $1616
                        PEA    $1181
                        TSC                              ; Line 10
                        ADC    #$00AB
                        TCS
                        LDA    $9D,S
                        AND    #$0F0F
                        ORA    #$8080
                        STA    $9D,S
                        SHORT  M
                        LDA    $96,S
                        AND    #$F0
                        ORA    #$08
                        STA    $96,S
                        LONG   M
                        PEA    $8866
                        PHX
                        PHX
                        PHX
                        PEA    $8181
                        TSC                              ; Line 11
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHX
                        PEA    $8811
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
; MARK: BOSS2_002A
BOSS2_002A              ENTRY
                        CLC                              ; 32x13, 448 bytes, 734 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 11
                        LDY    #$8888                    ; Pattern #2 : 10
                        LDA    #$6666                    ; Pattern #3 : 5
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $A7,S
                        AND    #$F00F
                        ORA    #$0ED0
                        STA    $A7,S
                        SHORT  M
                        LDA    #$EE
                        STA    $A0,S
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$01
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A6
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9C,S
                        LDA    $9E,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $9E,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A5,S
                        PEA    $DD1D
                        PEA    $1116
                        PEA    $11EE
                        TSC
                        ADC    #$000E
                        TCS
                        PEA    $DD1D
                        PEA    $1116
                        PEA    $11EE
                        TSC                              ; Line 5
                        ADC    #$0138
                        TCS
                        TYA
                        STA    $0B,S
                        LDA    #$8688
                        STA    $AA,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A6,S
                        LDA    $AC,S
                        AND    #$0F00
                        ORA    #$1061
                        STA    $AC,S
                        SHORT  M
                        LDA    #$11
                        STA    $01,S
                        LDA    $0A,S
                        AND    #$F0
                        ORA    #$08
                        STA    $0A,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A1,S
                        LONG   M
                        TSC
                        ADC    #$0005
                        TCS
                        PEA    $1118
                        PHY
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        LDA    $A8,S
                        AND    #$0F00
                        ORA    #$6011
                        STA    $A8,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LONG   M
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AB
                        TCS
                        TDC
                        STA    $A1,S
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$1106
                        STA    $95,S
                        LDA    $9D,S
                        AND    #$000F
                        ORA    #$6660
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $9F,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A3,S
                        LONG   M
                        PEA    $6166
                        PHY
                        PEA    $6611
                        PHX
                        PEA    $8118
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A8
                        TCS
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$6086
                        STA    $A6,S
                        PHX
                        PHX
                        PEA    $1166
                        TSC                              ; Line 9
                        ADC    #$00AB
                        TCS
                        LDA    $95,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $95,S
                        SHORT  M
                        LDA    #$11
                        STA    $94,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A1,S
                        LONG   M
                        PEA    $8866
                        PHD
                        PHD
                        PEA    $1661
                        PEA    $1611
                        PEA    $1161
                        TSC                              ; Line 10
                        ADC    #$00AC
                        TCS
                        LDA    $95,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $95,S
                        LDA    $98,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $98,S
                        SHORT  M
                        LDA    #$81
                        STA    $97,S
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$08
                        STA    $9E,S
                        LONG   M
                        PEA    $6886
                        PHY
                        PHY
                        PEA    $8811
                        PEA    $8881
                        TSC                              ; Line 11
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
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
; MARK: BOSS2_002B
BOSS2_002B              ENTRY
                        CLC                              ; 32x13, 384 bytes, 639 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 14
                        LDY    #$8888                    ; Pattern #2 : 8
                        LDA    #$6666                    ; Pattern #3 : 7
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$EE0E
                        STA    $A0,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$10
                        STA    $03,S
                        LDA    $AF,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $AF,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A7
                        TCS
                        TXA
                        STA    $9C,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $A4,S
                        SHORT  M
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9E,S
                        LONG   M
                        PEA    $DDDD
                        PEA    $1161
                        PEA    $11E1
                        TSC
                        ADC    #$000D
                        TCS
                        PEA    $DD11
                        PEA    $6111
                        PEA    $E1EE
                        TSC                              ; Line 5
                        ADC    #$0138
                        TCS
                        TYA
                        STA    $0B,S
                        LDA    #$1166
                        STA    $AC,S
                        LDA    $06,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $06,S
                        LDA    $AA,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $AA,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$01
                        STA    $01,S
                        LDA    $0D,S
                        AND    #$0F
                        ORA    #$80
                        STA    $0D,S
                        LONG   M
                        TSC
                        ADC    #$0005
                        TCS
                        PEA    $8181
                        PEA    $8818
                        TSC                              ; Line 6
                        ADC    #$00A6
                        TCS
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AD
                        TCS
                        LDA    $9C,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $9C,S
                        PEA    $1611
                        PEA    $6686
                        PEA    $8868
                        PEA    $1611
                        PHX
                        PEA    $8811
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A9
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$1106
                        STA    $99,S
                        PEA    $1611
                        PHX
                        PEA    $1161
                        PEA    $1661
                        TSC
                        ADC    #$000E
                        TCS
                        PHD
                        PHD
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $92,S
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$1801
                        STA    $94,S
                        PEA    $6688
                        PEA    $6866
                        PHD
                        PHD
                        PEA    $1166
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00AB
                        TCS
                        LDA    $96,S
                        AND    #$0FF0
                        ORA    #$1008
                        STA    $96,S
                        LDA    $9D,S
                        AND    #$0F0F
                        ORA    #$8080
                        STA    $9D,S
                        SHORT  M
                        LDA    #$11
                        STA    $95,S
                        LDA    #$88
                        STA    $98,S
                        LONG   M
                        PEA    $8866
                        PHY
                        PHY
                        PEA    $8818
                        PEA    $8118
                        TSC                              ; Line 11
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A1,S
                        LONG   M
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
; MARK: BOSS2_003A
BOSS2_003A              ENTRY
                        CLC                              ; 32x13, 515 bytes, 838 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 13
                        LDY    #$8888                    ; Pattern #2 : 9
                        LDA    #$6666                    ; Pattern #3 : 5
                        TCD
;--
                        SHORT  M                         ; Line 0
                        LDA    #$11
                        STA    $A1,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $00,S
                        LDA    $02,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $02,S
                        LDA    $A7,S
                        AND    #$F00F
                        ORA    #$0ED0
                        STA    $A7,S
                        SHORT  M
                        LDA    #$EE
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A6
                        TCS
                        LDA    #$8111
                        STA    $9C,S
                        LDA    $9A,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $9A,S
                        LDA    $9F,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $9F,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A5,S
                        SHORT  M
                        LDA    #$11
                        STA    $9E,S
                        LONG   M
                        PEA    $DD1D
                        PEA    $1116
                        PEA    $11EE
                        TSC
                        ADC    #$000E
                        TCS
                        PEA    $DD1D
                        PEA    $1116
                        PEA    $11EE
                        TSC                              ; Line 5
                        ADC    #$0138
                        TCS
                        TYA
                        STA    $0B,S
                        LDA    #$1181
                        STA    $A2,S
                        LDA    #$8688
                        STA    $AA,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A0,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A6,S
                        LDA    $AC,S
                        AND    #$0F00
                        ORA    #$1061
                        STA    $AC,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$10
                        STA    $01,S
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$10
                        STA    $07,S
                        LDA    $0A,S
                        AND    #$F0
                        ORA    #$08
                        STA    $0A,S
                        LONG   M
                        TSC
                        ADC    #$0005
                        TCS
                        PEA    $1181
                        PEA    $1811
                        TSC                              ; Line 7
                        ADC    #$013F
                        TCS
                        TDC
                        STA    $AD,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $01,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$6011
                        STA    $0D,S
                        LDA    $A9,S
                        AND    #$000F
                        ORA    #$6660
                        STA    $A9,S
                        LDA    $AB,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $AB,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A0,S
                        LDA    $AF,S
                        AND    #$0F
                        ORA    #$60
                        STA    $AF,S
                        LONG   M
                        TSC
                        ADC    #$000C
                        TCS
                        PEA    $6166
                        PHY
                        PEA    $6611
                        PHX
                        PEA    $8188
                        TSC                              ; Line 8
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A7,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AE
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A0,S
                        LONG   M
                        PEA    $8688
                        PHD
                        PHD
                        PEA    $6616
                        PEA    $6111
                        PEA    $1188
                        PEA    $6811
                        TSC                              ; Line 10
                        ADC    #$00AD
                        TCS
                        LDA    $96,S
                        AND    #$000F
                        ORA    #$8110
                        STA    $96,S
                        LDA    $98,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $98,S
                        SHORT  M
                        LDA    $94,S
                        AND    #$0F
                        ORA    #$10
                        STA    $94,S
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$08
                        STA    $9E,S
                        LONG   M
                        PEA    $6886
                        PHY
                        PHY
                        PEA    $8881
                        PEA    $1818
                        PHX
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00AB
                        TCS
                        SHORT  M
                        LDA    $96,S
                        AND    #$F0
                        ORA    #$01
                        STA    $96,S
                        LDA    $98,S
                        AND    #$F0
                        ORA    #$01
                        STA    $98,S
                        LDA    $9B,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
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
; MARK: BOSS2_003B
BOSS2_003B              ENTRY
                        CLC                              ; 32x13, 482 bytes, 789 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 13
                        LDY    #$8888                    ; Pattern #2 : 8
                        LDA    #$6666                    ; Pattern #3 : 7
                        TCD
;--
                        LDA    $A1,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A1,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$10
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$EE0E
                        STA    $A0,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$10
                        STA    $04,S
                        LDA    $AF,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $AF,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A7
                        TCS
                        LDA    #$1811
                        STA    $9B,S
                        LDA    $9D,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $9F,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $A4,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9A,S
                        LONG   M
                        PEA    $DDDD
                        PEA    $1161
                        PEA    $11E1
                        TSC
                        ADC    #$000D
                        TCS
                        PEA    $DD11
                        PEA    $6111
                        PEA    $E1EE
                        TSC                              ; Line 5
                        ADC    #$0138
                        TCS
                        LDA    #$8811
                        STA    $03,S
                        TYA
                        STA    $0B,S
                        LDA    #$1166
                        STA    $AC,S
                        LDA    $01,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $01,S
                        LDA    $06,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A6,S
                        LDA    $AA,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $AA,S
                        SHORT  M
                        LDA    #$11
                        STA    $05,S
                        STA    $A5,S
                        LDA    $0D,S
                        AND    #$0F
                        ORA    #$80
                        STA    $0D,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    #$16
                        STA    $AA,S
                        LONG   M
                        PHX
                        PEA    $1811
                        TSC                              ; Line 7
                        ADC    #$00AD
                        TCS
                        LDA    $9D,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $9D,S
                        SHORT  M
                        LDA    #$11
                        STA    $94,S
                        LONG   M
                        PEA    $1166
                        PEA    $8688
                        PEA    $6816
                        PHX
                        PEA    $1188
                        PEA    $1811
                        TSC                              ; Line 8
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $98,S
                        AND    #$F0
                        ORA    #$01
                        STA    $98,S
                        LONG   M
                        PEA    $1611
                        PHX
                        PHX
                        PHX
                        TSC
                        ADC    #$000E
                        TCS
                        PHD
                        PHD
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $91,S
                        AND    #$F0
                        ORA    #$01
                        STA    $91,S
                        LONG   M
                        PEA    $6688
                        PEA    $6866
                        PHD
                        PHD
                        PEA    $1116
                        PEA    $1181
                        PEA    $8816
                        TSC                              ; Line 10
                        ADC    #$00AD
                        TCS
                        LDA    $95,S
                        AND    #$F0F0
                        ORA    #$0801
                        STA    $95,S
                        LDA    $97,S
                        AND    #$000F
                        ORA    #$8810
                        STA    $97,S
                        LDA    $9D,S
                        AND    #$0F0F
                        ORA    #$8080
                        STA    $9D,S
                        SHORT  M
                        LDA    $93,S
                        AND    #$F0
                        ORA    #$01
                        STA    $93,S
                        LONG   M
                        PEA    $8866
                        PHY
                        PHY
                        PEA    $8818
                        PEA    $8881
                        PHX
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $97,S
                        AND    #$0F
                        ORA    #$10
                        STA    $97,S
                        LDA    $99,S
                        AND    #$0F
                        ORA    #$10
                        STA    $99,S
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A1,S
                        LONG   M
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
; MARK: BOSS2_004A
BOSS2_004A              ENTRY
                        CLC                              ; 32x13, 349 bytes, 592 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$6666                    ; Pattern #1 : 15
                        LDY    #$8888                    ; Pattern #2 : 14
                        LDA    #$8866                    ; Pattern #3 : 5
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TYA
                        STA    $AB,S
                        LDA    $0E,S
                        AND    #$0F00
                        ORA    #$E0EE
                        STA    $0E,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A3,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $00,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $EE1E
                        PEA    $1116
                        PEA    $11DD
                        TSC
                        ADC    #$000D
                        TCS
                        PEA    $1E11
                        PEA    $1611
                        PEA    $DDDD
                        TSC                              ; Line 5
                        ADC    #$0139
                        TCS
                        TYA
                        STA    $03,S
                        LDA    #$6611
                        STA    $A2,S
                        LDA    $0A,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $0A,S
                        LDA    $0C,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $0C,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A4,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$08
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $A0,S
                        LONG   M
                        PHD
                        PHY
                        TSC                              ; Line 7
                        ADC    #$00A3
                        TCS
                        LDA    $98,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $98,S
                        LDA    $9B,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $9B,S
                        SHORT  M
                        LDA    #$66
                        STA    $9A,S
                        STA    $9D,S
                        LONG   M
                        PEA    $8188
                        PHX
                        PHX
                        PEA    $8688
                        PEA    $6866
                        PEA    $1161
                        TSC                              ; Line 8
                        ADC    #$00A3
                        TCS
                        LDA    $A9,S
                        AND    #$0F00
                        ORA    #$6088
                        STA    $A9,S
                        PHX
                        PHX
                        TSC
                        ADC    #$000E
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A2
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A0,S
                        PHY
                        PHX
                        PHX
                        PHX
                        PEA    $6686
                        PHD
                        TSC                              ; Line 10
                        ADC    #$00AB
                        TCS
                        LDA    $99,S
                        AND    #$F0F0
                        ORA    #$0808
                        STA    $99,S
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$8008
                        STA    $A0,S
                        SHORT  M
                        LDA    #$88
                        STA    $9F,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PHY
                        PEA    $6688
                        TSC                              ; Line 11
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9C,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
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
; MARK: BOSS2_004B
BOSS2_004B              ENTRY
                        CLC                              ; 32x13, 375 bytes, 635 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 15
                        LDY    #$6666                    ; Pattern #2 : 13
                        LDA    #$8868                    ; Pattern #3 : 4
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E6
                        TCS
                        LDA    $01,S
                        AND    #$F00F
                        ORA    #$0DE0
                        STA    $01,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $9D,S
                        LDA    $A5,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $A5,S
                        SHORT  M
                        LDA    #$DD
                        STA    $03,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A7,S
                        LONG   M
                        PEA    $EE11
                        PEA    $6111
                        PEA    $D1DD
                        TSC
                        ADC    #$000F
                        TCS
                        PEA    $EEEE
                        PEA    $1161
                        PEA    $11D1
                        TSC                              ; Line 5
                        ADC    #$0137
                        TCS
                        TXA
                        STA    $03,S
                        STA    $0B,S
                        TDC
                        STA    $A4,S
                        LDA    #$8688
                        STA    $AB,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1601
                        STA    $A2,S
                        LDA    $AD,S
                        AND    #$0F00
                        ORA    #$8068
                        STA    $AD,S
                        SHORT  M
                        LDA    #$88
                        STA    $0D,S
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$80
                        STA    $05,S
                        LDA    $AA,S
                        AND    #$F0
                        ORA    #$08
                        STA    $AA,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $A2,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$1106
                        STA    $01,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $0D,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $A0,S
                        LDA    $A4,S
                        AND    #$000F
                        ORA    #$6660
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A6,S
                        LDA    $A8,S
                        AND    #$F000
                        ORA    #$0666
                        STA    $A8,S
                        SHORT  M
                        LDA    $AE,S
                        AND    #$0F
                        ORA    #$60
                        STA    $AE,S
                        LONG   M
                        TSC
                        ADC    #$000C
                        TCS
                        PHD
                        PHY
                        PHY
                        PHX
                        PEA    $6616
                        TSC                              ; Line 8
                        ADC    #$00AB
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$6806
                        STA    $93,S
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$8608
                        STA    $94,S
                        PEA    $8688
                        PHD
                        PHY
                        PHY
                        PHY
                        PEA    $6688
                        TSC                              ; Line 10
                        ADC    #$00AB
                        TCS
                        LDA    $98,S
                        AND    #$000F
                        ORA    #$8880
                        STA    $98,S
                        LDA    $9E,S
                        AND    #$000F
                        ORA    #$8880
                        STA    $9E,S
                        PHX
                        PHX
                        PHX
                        PHX
                        PHD
                        TSC                              ; Line 11
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A1,S
                        LONG   M
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
; MARK: BOSS2_005A
BOSS2_005A              ENTRY
                        CLC                              ; 32x13, 374 bytes, 619 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 11
                        LDY    #$6666                    ; Pattern #2 : 8
                        LDA    #$1161                    ; Pattern #3 : 5
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TXA
                        STA    $AB,S
                        LDA    $0E,S
                        AND    #$0F00
                        ORA    #$E0EE
                        STA    $0E,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A3,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $00,S
                        LDA    $A9,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A9,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $EE1E
                        PEA    $1116
                        PEA    $11DD
                        TSC
                        ADC    #$000D
                        TCS
                        PEA    $1E11
                        PEA    $1611
                        PEA    $DDDD
                        TSC                              ; Line 5
                        ADC    #$0139
                        TCS
                        TXA
                        STA    $03,S
                        LDA    #$6611
                        STA    $A2,S
                        LDA    $08,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $08,S
                        LDA    $0A,S
                        AND    #$00F0
                        ORA    #$1801
                        STA    $0A,S
                        LDA    $0C,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $0C,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A4,S
                        LDA    $A8,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $A8,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$08
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $A0,S
                        LONG   M
                        PEA    $8866
                        PEA    $8811
                        TSC                              ; Line 7
                        ADC    #$00A3
                        TCS
                        LDA    $98,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $98,S
                        PEA    $8118
                        PEA    $6611
                        PHD
                        PEA    $8688
                        PEA    $6866
                        PHD
                        TSC                              ; Line 8
                        ADC    #$00A3
                        TCS
                        LDA    $A9,S
                        AND    #$0F00
                        ORA    #$6088
                        STA    $A9,S
                        PHY
                        PHY
                        TSC
                        ADC    #$000E
                        TCS
                        PHY
                        PEA    $6611
                        PEA    $6111
                        PHD
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A0,S
                        PEA    $1811
                        PEA    $6161
                        PEA    $6166
                        PHY
                        PEA    $6686
                        PEA    $8866
                        TSC                              ; Line 10
                        ADC    #$00AB
                        TCS
                        LDA    $99,S
                        AND    #$F0F0
                        ORA    #$0808
                        STA    $99,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A1,S
                        LONG   M
                        PEA    $1818
                        PHX
                        PHX
                        PHX
                        PEA    $6688
                        TSC                              ; Line 11
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $9A,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9A,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LONG   M
                        PEA    $1188
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
; MARK: BOSS2_005B
BOSS2_005B              ENTRY
                        CLC                              ; 32x13, 386 bytes, 641 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 11
                        LDY    #$6666                    ; Pattern #2 : 6
                        LDA    #$1611                    ; Pattern #3 : 3
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E6
                        TCS
                        LDA    $01,S
                        AND    #$F00F
                        ORA    #$0DE0
                        STA    $01,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $9D,S
                        LDA    $A4,S
                        AND    #$F00F
                        ORA    #$0810
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A6,S
                        SHORT  M
                        LDA    #$DD
                        STA    $03,S
                        LONG   M
                        PEA    $EE11
                        PEA    $6111
                        PEA    $D1DD
                        TSC
                        ADC    #$000F
                        TCS
                        PEA    $EEEE
                        PEA    $1161
                        PEA    $11D1
                        TSC                              ; Line 5
                        ADC    #$0137
                        TCS
                        TXA
                        STA    $03,S
                        STA    $0C,S
                        LDA    #$8868
                        STA    $A4,S
                        LDA    $08,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $08,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1601
                        STA    $A2,S
                        LDA    $A8,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A8,S
                        SHORT  M
                        LDA    #$11
                        STA    $0B,S
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$80
                        STA    $05,S
                        LDA    $AE,S
                        AND    #$0F
                        ORA    #$80
                        STA    $AE,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$00AD
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$1106
                        STA    $94,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        PEA    $6886
                        PEA    $1811
                        TSC                              ; Line 7
                        ADC    #$00A3
                        TCS
                        TYA
                        STA    $96,S
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $94,S
                        LDA    $98,S
                        AND    #$000F
                        ORA    #$6660
                        STA    $98,S
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$1106
                        STA    $9A,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A2,S
                        LONG   M
                        PEA    $8861
                        PHD
                        PEA    $1166
                        PHX
                        PEA    $6616
                        TSC                              ; Line 8
                        ADC    #$00AB
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$6806
                        STA    $93,S
                        PHY
                        PHD
                        PHD
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$8608
                        STA    $94,S
                        PEA    $8688
                        PEA    $1111
                        PEA    $1616
                        PHY
                        PHY
                        PEA    $6688
                        TSC                              ; Line 10
                        ADC    #$00AB
                        TCS
                        LDA    $98,S
                        AND    #$000F
                        ORA    #$8880
                        STA    $98,S
                        PHX
                        PEA    $8181
                        PHX
                        PHX
                        PEA    $8868
                        TSC                              ; Line 11
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $99,S
                        AND    #$F0
                        ORA    #$01
                        STA    $99,S
                        LDA    $9F,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9F,S
                        LONG   M
                        PEA    $1881
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
; MARK: BOSS2_006A
BOSS2_006A              ENTRY
                        CLC                              ; 32x13, 390 bytes, 646 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 14
                        LDY    #$8888                    ; Pattern #2 : 8
                        LDA    #$6666                    ; Pattern #3 : 7
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $AE,S
                        AND    #$0F00
                        ORA    #$E0EE
                        STA    $AE,S
                        SHORT  M
                        LDA    $0C,S
                        AND    #$F0
                        ORA    #$01
                        STA    $0C,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A6
                        TCS
                        TXA
                        STA    $A5,S
                        LDA    $9D,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $9D,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A4,S
                        LONG   M
                        PEA    $EE1E
                        PEA    $1116
                        PEA    $11DD
                        TSC
                        ADC    #$000D
                        TCS
                        PEA    $1E11
                        PEA    $1611
                        PEA    $DDDD
                        TSC                              ; Line 5
                        ADC    #$0139
                        TCS
                        TYA
                        STA    $03,S
                        LDA    #$6611
                        STA    $A2,S
                        LDA    $08,S
                        AND    #$F000
                        ORA    #$0111
                        STA    $08,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A4,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$08
                        STA    $02,S
                        LDA    $0E,S
                        AND    #$0F
                        ORA    #$10
                        STA    $0E,S
                        LONG   M
                        TSC
                        ADC    #$000D
                        TCS
                        PEA    $8188
                        PEA    $1818
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A7
                        TCS
                        LDA    $96,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $96,S
                        PHX
                        PEA    $1188
                        PHX
                        PEA    $1161
                        PEA    $8688
                        PEA    $6866
                        PEA    $1161
                        TSC                              ; Line 8
                        ADC    #$00A3
                        TCS
                        LDA    $A9,S
                        AND    #$0F00
                        ORA    #$6011
                        STA    $A9,S
                        PHD
                        PHD
                        TSC
                        ADC    #$000E
                        TCS
                        PEA    $1661
                        PEA    $1611
                        PHX
                        PEA    $1161
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A2,S
                        SHORT  M
                        LDA    #$88
                        STA    $96,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
                        PHX
                        PEA    $6611
                        PHD
                        PHD
                        PEA    $6686
                        PEA    $8866
                        TSC                              ; Line 10
                        ADC    #$00AC
                        TCS
                        LDA    $98,S
                        AND    #$F0F0
                        ORA    #$0808
                        STA    $98,S
                        LDA    $9F,S
                        AND    #$0FF0
                        ORA    #$8001
                        STA    $9F,S
                        SHORT  M
                        LDA    #$88
                        STA    $9A,S
                        LDA    #$11
                        STA    $A1,S
                        LONG   M
                        PEA    $8181
                        PEA    $1881
                        PHY
                        PHY
                        PEA    $8866
                        TSC                              ; Line 11
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
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
; MARK: BOSS2_006B
BOSS2_006B              ENTRY
                        CLC                              ; 32x13, 436 bytes, 720 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 10
                        LDY    #$8888                    ; Pattern #2 : 10
                        LDA    #$6666                    ; Pattern #3 : 5
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $A7,S
                        AND    #$F00F
                        ORA    #$0DE0
                        STA    $A7,S
                        SHORT  M
                        LDA    #$DD
                        STA    $A9,S
                        LDA    $0D,S
                        AND    #$0F
                        ORA    #$10
                        STA    $0D,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A6
                        TCS
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $9D,S
                        LDA    $A4,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A6,S
                        PEA    $EE11
                        PEA    $6111
                        PEA    $D1DD
                        TSC
                        ADC    #$000F
                        TCS
                        PEA    $EEEE
                        PEA    $1161
                        PEA    $11D1
                        TSC                              ; Line 5
                        ADC    #$0137
                        TCS
                        TYA
                        STA    $03,S
                        LDA    #$8868
                        STA    $A4,S
                        LDA    $08,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $08,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1601
                        STA    $A2,S
                        LDA    $AD,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $AD,S
                        SHORT  M
                        LDA    #$11
                        STA    $0E,S
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$80
                        STA    $05,S
                        LDA    $A8,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A8,S
                        LONG   M
                        TSC
                        ADC    #$000D
                        TCS
                        PHY
                        PEA    $8111
                        TSC                              ; Line 6
                        ADC    #$00A3
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$1106
                        STA    $95,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A3,S
                        LONG   M
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        TDC
                        STA    $94,S
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $92,S
                        LDA    $96,S
                        AND    #$000F
                        ORA    #$6660
                        STA    $96,S
                        LDA    $98,S
                        AND    #$00F0
                        ORA    #$1106
                        STA    $98,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A0,S
                        LONG   M
                        PHX
                        PEA    $8118
                        PHX
                        PEA    $1166
                        PHY
                        PEA    $6616
                        TSC                              ; Line 8
                        ADC    #$00AB
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$6806
                        STA    $93,S
                        PEA    $1166
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$8608
                        STA    $94,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A0,S
                        PEA    $1611
                        PEA    $1161
                        PEA    $1661
                        PHD
                        PHD
                        PEA    $6688
                        TSC                              ; Line 10
                        ADC    #$00AB
                        TCS
                        LDA    $98,S
                        AND    #$000F
                        ORA    #$8880
                        STA    $98,S
                        LDA    $9E,S
                        AND    #$000F
                        ORA    #$1880
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A0,S
                        PEA    $1118
                        PEA    $8811
                        PHY
                        PHY
                        PEA    $8868
                        TSC                              ; Line 11
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A1,S
                        LONG   M
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
; MARK: BOSS2_007A
BOSS2_007A              ENTRY
                        CLC                              ; 32x13, 480 bytes, 788 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 15
                        LDY    #$8888                    ; Pattern #2 : 8
                        LDA    #$6666                    ; Pattern #3 : 7
                        TCD
;--
                        LDA    $AD,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AD,S
                        SHORT  M
                        LDA    $0E,S
                        AND    #$F0
                        ORA    #$01
                        STA    $0E,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $0D,S
                        LDA    $AE,S
                        AND    #$0F00
                        ORA    #$E0EE
                        STA    $AE,S
                        SHORT  M
                        LDA    $0B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $0B,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A6
                        TCS
                        LDA    #$8111
                        STA    $A5,S
                        LDA    $9D,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $9D,S
                        LDA    $A2,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A2,S
                        LDA    $A7,S
                        AND    #$F000
                        ORA    #$0111
                        STA    $A7,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A4,S
                        LONG   M
                        PEA    $EE1E
                        PEA    $1116
                        PEA    $11DD
                        TSC
                        ADC    #$000D
                        TCS
                        PEA    $1E11
                        PEA    $1611
                        PEA    $DDDD
                        TSC                              ; Line 5
                        ADC    #$0139
                        TCS
                        TYA
                        STA    $03,S
                        LDA    #$8811
                        STA    $0A,S
                        LDA    #$6611
                        STA    $A2,S
                        LDA    $08,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $08,S
                        LDA    $0D,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $0D,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A4,S
                        LDA    $A8,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A8,S
                        SHORT  M
                        LDA    #$11
                        STA    $0C,S
                        STA    $AE,S
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$08
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $A0,S
                        LONG   M
                        PEA    $8111
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A3
                        TCS
                        LDA    $98,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $98,S
                        SHORT  M
                        LDA    #$61
                        STA    $9A,S
                        LONG   M
                        PEA    $8188
                        PHX
                        PEA    $1161
                        PEA    $8688
                        PEA    $6866
                        PEA    $1161
                        TSC                              ; Line 8
                        ADC    #$00A3
                        TCS
                        SHORT  M
                        LDA    $AB,S
                        AND    #$0F
                        ORA    #$10
                        STA    $AB,S
                        LONG   M
                        PHD
                        PHD
                        TSC
                        ADC    #$000F
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        PEA    $6188
                        PEA    $1811
                        PEA    $6111
                        PHD
                        PHD
                        PEA    $6686
                        PEA    $8866
                        TSC                              ; Line 10
                        ADC    #$00AF
                        TCS
                        LDA    $95,S
                        AND    #$F0F0
                        ORA    #$0808
                        STA    $95,S
                        LDA    $9B,S
                        AND    #$F000
                        ORA    #$0188
                        STA    $9B,S
                        LDA    $9D,S
                        AND    #$0F0F
                        ORA    #$1080
                        STA    $9D,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LONG   M
                        PHX
                        PHX
                        PEA    $1888
                        PEA    $8188
                        PHY
                        PHY
                        PEA    $6688
                        TSC                              ; Line 11
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9C,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A6,S
                        LONG   M
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
; MARK: BOSS2_007B
BOSS2_007B              ENTRY
                        CLC                              ; 32x13, 515 bytes, 838 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 13
                        LDY    #$8888                    ; Pattern #2 : 9
                        LDA    #$6666                    ; Pattern #3 : 5
                        TCD
;--
                        SHORT  M                         ; Line 0
                        LDA    #$11
                        STA    $AE,S
                        LDA    $0F,S
                        AND    #$0F
                        ORA    #$10
                        STA    $0F,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $0C,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $0C,S
                        LDA    $0E,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $0E,S
                        LDA    $A7,S
                        AND    #$F00F
                        ORA    #$0DE0
                        STA    $A7,S
                        SHORT  M
                        LDA    #$DD
                        STA    $A9,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A6
                        TCS
                        LDA    #$1811
                        STA    $A5,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $9D,S
                        LDA    $A3,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A3,S
                        LDA    $A8,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A8,S
                        SHORT  M
                        LDA    #$11
                        STA    $A7,S
                        LONG   M
                        PEA    $EE11
                        PEA    $6111
                        PEA    $D1DD
                        TSC
                        ADC    #$000F
                        TCS
                        PEA    $EEEE
                        PEA    $1161
                        PEA    $11D1
                        TSC                              ; Line 5
                        ADC    #$0137
                        TCS
                        TYA
                        STA    $03,S
                        LDA    #$8868
                        STA    $A4,S
                        LDA    #$1811
                        STA    $AC,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1601
                        STA    $A2,S
                        LDA    $A8,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A8,S
                        LDA    $AA,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $AA,S
                        LDA    $AE,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $AE,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$80
                        STA    $05,S
                        LDA    $08,S
                        AND    #$F0
                        ORA    #$01
                        STA    $08,S
                        LDA    $0E,S
                        AND    #$F0
                        ORA    #$01
                        STA    $0E,S
                        LONG   M
                        TSC
                        ADC    #$000D
                        TCS
                        PEA    $1181
                        PEA    $1811
                        TSC                              ; Line 7
                        ADC    #$0137
                        TCS
                        TDC
                        STA    $A2,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$1106
                        STA    $01,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $0D,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $A0,S
                        LDA    $A5,S
                        AND    #$F000
                        ORA    #$0666
                        STA    $A5,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A4,S
                        LDA    $AF,S
                        AND    #$0F
                        ORA    #$10
                        STA    $AF,S
                        LONG   M
                        TSC
                        ADC    #$000C
                        TCS
                        PEA    $8818
                        PHX
                        PEA    $1166
                        PHY
                        PEA    $6616
                        TSC                              ; Line 8
                        ADC    #$00AC
                        TCS
                        SHORT  M
                        LDA    $92,S
                        AND    #$F0
                        ORA    #$06
                        STA    $92,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $93,S
                        AND    #$F0
                        ORA    #$08
                        STA    $93,S
                        LONG   M
                        PEA    $1186
                        PEA    $8811
                        PEA    $1116
                        PEA    $6166
                        PHD
                        PHD
                        PEA    $8868
                        TSC                              ; Line 10
                        ADC    #$00AF
                        TCS
                        LDA    $95,S
                        AND    #$000F
                        ORA    #$8880
                        STA    $95,S
                        LDA    $9C,S
                        AND    #$F000
                        ORA    #$0118
                        STA    $9C,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$0F
                        ORA    #$80
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9F,S
                        LONG   M
                        PHX
                        PHX
                        PEA    $8181
                        PEA    $1888
                        PHY
                        PHY
                        PEA    $6886
                        TSC                              ; Line 11
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A1,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A6,S
                        LONG   M
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
; MARK: ENEMY2_000A
ENEMY2_000A             ENTRY
                        CLC                              ; 20x9, 210 bytes, 342 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCCC                    ; Pattern #1 : 3
                        LDY    #$ACCA                    ; Pattern #2 : 2
                        LDA    #$AAAA                    ; Pattern #3 : 2
                        TCD
;--
                        LDA    #$EEEE                    ; Line 0
                        STA    $02,S
                        LDA    #$DDDD
                        STA    $06,S
                        LDA    $04,S
                        AND    #$000F
                        ORA    #$DDE0
                        STA    $04,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $01,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$30A3
                        STA    $05,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $A6,S
                        SHORT  M
                        LDA    #$CC
                        STA    $00,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$CA0C
                        STA    $9B,S
                        PEA    $CACC
                        PHY
                        PHY
                        TSC                              ; Line 4
                        ADC    #$00A8
                        TCS
                        LDA    #$AACA
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$C0AC
                        STA    $9F,S
                        PEA    $CCAA
                        PEA    $AACC
                        PHD
                        TSC                              ; Line 6
                        ADC    #$013F
                        TCS
                        LDA    $04,S
                        AND    #$F00F
                        ORA    #$0CC0
                        STA    $04,S
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
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
; MARK: ENEMY2_000B
ENEMY2_000B             ENTRY
                        CLC                              ; 20x9, 227 bytes, 362 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$AAAA                    ; Pattern #1 : 3
                        LDY    #$AACC                    ; Pattern #2 : 3
                        LDA    #$CCAA                    ; Pattern #3 : 2
                        TCD
;--
                        LDA    #$EEEE                    ; Line 0
                        STA    $03,S
                        LDA    #$DDDD
                        STA    $06,S
                        SHORT  M
                        LDA    #$EE
                        STA    $02,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $05,S
                        LDA    $08,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $08,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $04,S
                        LDA    $00,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$AA0C
                        STA    $A0,S
                        SHORT  M
                        LDA    #$33
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A7
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$C0AC
                        STA    $A0,S
                        PEA    $33A3
                        PEA    $CCCC
                        PHY
                        TSC                              ; Line 4
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$AC
                        STA    $9D,S
                        LONG   M
                        PEA    $AACA
                        PEA    $ACAA
                        PHY
                        TSC                              ; Line 5
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $9F,S
                        LONG   M
                        PHD
                        PHY
                        TSC                              ; Line 7
                        ADC    #$013D
                        TCS
                        LDA    #$CCCC
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $06,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$0C
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
; MARK: ENEMY2_001A
ENEMY2_001A             ENTRY
                        CLC                              ; 20x9, 180 bytes, 296 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCCC                    ; Pattern #1 : 3
                        LDY    #$CCAC                    ; Pattern #2 : 2
                        LDA    #$CAAC                    ; Pattern #3 : 2
                        TCD
;--
                        LDA    #$EEEE                    ; Line 0
                        STA    $02,S
                        LDA    #$DDDD
                        STA    $06,S
                        LDA    $04,S
                        AND    #$000F
                        ORA    #$DDE0
                        STA    $04,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $01,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$33AA
                        STA    $04,S
                        LDA    $00,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $00,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A1,S
                        LONG   M
                        PEA    $33A3
                        PHY
                        PHD
                        TSC                              ; Line 4
                        ADC    #$00A6
                        TCS
                        PEA    $CCAA
                        PHD
                        PEA    $AACC
                        TSC                              ; Line 5
                        ADC    #$00A6
                        TCS
                        LDA    $9E,S
                        AND    #$F00F
                        ORA    #$0CC0
                        STA    $9E,S
                        PHY
                        PEA    $AAAC
                        TSC                              ; Line 7
                        ADC    #$0144
                        TCS
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
; MARK: ENEMY2_001B
ENEMY2_001B             ENTRY
                        CLC                              ; 20x9, 236 bytes, 373 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCAA                    ; Pattern #1 : 2
                        LDY    #$AACC                    ; Pattern #2 : 2
                        LDA    #$AACA                    ; Pattern #3 : 2
                        TCD
;--
                        LDA    #$EEEE                    ; Line 0
                        STA    $03,S
                        LDA    #$DDDD
                        STA    $06,S
                        SHORT  M
                        LDA    #$EE
                        STA    $02,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $05,S
                        LDA    $08,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $08,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$A30A
                        STA    $04,S
                        SHORT  M
                        LDA    #$CC
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$30
                        STA    $06,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $9B,S
                        LONG   M
                        PEA    $33CA
                        PHX
                        PEA    $CCCA
                        TSC                              ; Line 4
                        ADC    #$00A7
                        TCS
                        TDC
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $9F,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9C,S
                        LONG   M
                        PEA    $CCAC
                        PHY
                        PHD
                        TSC                              ; Line 6
                        ADC    #$013F
                        TCS
                        LDA    #$CCCC
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $A6,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $06,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$0C
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
; MARK: ENEMY2_002A
ENEMY2_002A             ENTRY
                        CLC                              ; 20x9, 194 bytes, 310 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$ACCA                    ; Pattern #1 : 2
                        LDY    #$CACA                    ; Pattern #2 : 1
                        LDA    #$DDDD                    ; Pattern #3 : 1
                        TCD
;--
                        LDA    #$EEEE                    ; Line 0
                        STA    $02,S
                        TDC
                        STA    $06,S
                        LDA    $04,S
                        AND    #$000F
                        ORA    #$DDE0
                        STA    $04,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $01,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$30AA
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $A5,S
                        SHORT  M
                        LDA    #$CC
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A4
                        TCS
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$AA0C
                        STA    $9D,S
                        PEA    $CAAC
                        PHY
                        TSC                              ; Line 4
                        ADC    #$00A6
                        TCS
                        LDA    #$AACA
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $9F,S
                        PEA    $CCAC
                        PEA    $CACC
                        TSC                              ; Line 6
                        ADC    #$013E
                        TCS
                        LDA    #$CCCC
                        STA    $A3,S
                        LDA    $04,S
                        AND    #$0F0F
                        ORA    #$C0C0
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $A5,S
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
; MARK: ENEMY2_002B
ENEMY2_002B             ENTRY
                        CLC                              ; 20x9, 198 bytes, 316 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCAC                    ; Pattern #1 : 2
                        LDY    #$CCAA                    ; Pattern #2 : 1
                        LDA    #$A3CC                    ; Pattern #3 : 1
                        TCD
;--
                        LDA    #$EEEE                    ; Line 0
                        STA    $03,S
                        LDA    #$DDDD
                        STA    $06,S
                        SHORT  M
                        LDA    #$EE
                        STA    $02,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $05,S
                        LDA    $08,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $08,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $01,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$A30A
                        STA    $04,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$AC0C
                        STA    $A1,S
                        TSC                              ; Line 3
                        ADC    #$00A6
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $A0,S
                        PEA    $33A3
                        PHY
                        TSC                              ; Line 4
                        ADC    #$00A3
                        TCS
                        TXA
                        STA    $A0,S
                        LDA    $9E,S
                        AND    #$00F0
                        ORA    #$AA0C
                        STA    $9E,S
                        PEA    $AACC
                        PEA    $ACCA
                        TSC                              ; Line 6
                        ADC    #$013F
                        TCS
                        LDA    #$CCCC
                        STA    $A5,S
                        LDA    $04,S
                        AND    #$F0F0
                        ORA    #$0C0C
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $A3,S
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
; MARK: ENEMY2_003A
ENEMY2_003A             ENTRY
                        CLC                              ; 20x9, 185 bytes, 299 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$ACCA                    ; Pattern #1 : 2
                        LDY    #$CCCC                    ; Pattern #2 : 2
                        LDA    #$33AA                    ; Pattern #3 : 1
                        TCD
;--
                        LDA    #$EEEE                    ; Line 0
                        STA    $02,S
                        LDA    #$DDDD
                        STA    $06,S
                        LDA    $04,S
                        AND    #$000F
                        ORA    #$DDE0
                        STA    $04,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $01,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $04,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $02,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$AA
                        STA    $9D,S
                        LONG   M
                        PEA    $33A3
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00A5
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $9F,S
                        PHY
                        PEA    $AACC
                        TSC                              ; Line 6
                        ADC    #$013E
                        TCS
                        TYA
                        STA    $A4,S
                        LDA    $04,S
                        AND    #$0F0F
                        ORA    #$C0C0
                        STA    $04,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$0C
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
; MARK: ENEMY2_003B
ENEMY2_003B             ENTRY
                        CLC                              ; 20x9, 215 bytes, 341 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCCC                    ; Pattern #1 : 2
                        LDY    #$CAAA                    ; Pattern #2 : 1
                        LDA    #$33CA                    ; Pattern #3 : 1
                        TCD
;--
                        LDA    #$EEEE                    ; Line 0
                        STA    $03,S
                        LDA    #$DDDD
                        STA    $06,S
                        SHORT  M
                        LDA    #$EE
                        STA    $02,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $05,S
                        LDA    $08,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $08,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$A30A
                        STA    $04,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $02,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$30
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A6
                        TCS
                        LDA    #$ACCA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$AC0A
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $A0,S
                        PEA    $3333
                        PHY
                        TSC                              ; Line 5
                        ADC    #$013E
                        TCS
                        TXA
                        STA    $05,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$AA0C
                        STA    $03,S
                        LDA    $A4,S
                        AND    #$F0F0
                        ORA    #$0C0C
                        STA    $A4,S
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $04,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$C0
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
; MARK: ENEMY2_004A
ENEMY2_004A             ENTRY
                        CLC                              ; 20x9, 212 bytes, 336 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$DDDD                    ; Pattern #1 : 1
                        LDY    #$3333                    ; Pattern #2 : 1
                        LDA    #$ACAC                    ; Pattern #3 : 1
                        TCD
;--
                        LDA    #$EEEE                    ; Line 0
                        STA    $02,S
                        TXA
                        STA    $06,S
                        LDA    $04,S
                        AND    #$000F
                        ORA    #$DDE0
                        STA    $04,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $01,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $A4,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $04,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $03,S
                        LDA    #$CCAA
                        STA    $A3,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$A0CC
                        STA    $A5,S
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    #$ACAA
                        STA    $04,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A3,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $03,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$C0
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
; MARK: ENEMY2_004B
ENEMY2_004B             ENTRY
                        CLC                              ; 20x9, 212 bytes, 336 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$AACA                    ; Pattern #1 : 2
                        LDY    #$3333                    ; Pattern #2 : 1
                        LDA    #$DDDD                    ; Pattern #3 : 1
                        TCD
;--
                        LDA    #$EEEE                    ; Line 0
                        STA    $03,S
                        TDC
                        STA    $06,S
                        SHORT  M
                        LDA    #$EE
                        STA    $02,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $05,S
                        LDA    $08,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $08,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $A4,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $04,S
                        SHORT  M
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $05,S
                        LDA    #$CACC
                        STA    $A5,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$CA0A
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$AC0A
                        STA    $A3,S
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $04,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $06,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A3,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $03,S
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$0C
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
; MARK: ENEMY2_005A
ENEMY2_005A             ENTRY
                        CLC                              ; 20x9, 187 bytes, 300 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$ACCA                    ; Pattern #1 : 2
                        LDY    #$CCCC                    ; Pattern #2 : 2
                        LDA    #$3A33                    ; Pattern #3 : 1
                        TCD
;--
                        LDA    #$DDDD                    ; Line 0
                        STA    $01,S
                        LDA    #$EEEE
                        STA    $04,S
                        SHORT  M
                        LDA    #$DD
                        STA    $00,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $03,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $06,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$AA33
                        STA    $02,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $05,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$AA
                        STA    $A0,S
                        LONG   M
                        PHX
                        PHD
                        TSC                              ; Line 4
                        ADC    #$00A3
                        TCS
                        TXA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $9D,S
                        PEA    $CCAA
                        PHY
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $A2,S
                        LDA    $02,S
                        AND    #$F0F0
                        ORA    #$0C0C
                        STA    $02,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$C0
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
; MARK: ENEMY2_005B
ENEMY2_005B             ENTRY
                        CLC                              ; 20x9, 213 bytes, 340 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCCC                    ; Pattern #1 : 2
                        LDY    #$3333                    ; Pattern #2 : 1
                        LDA    #$AC33                    ; Pattern #3 : 1
                        TCD
;--
                        LDA    #$DDDD                    ; Line 0
                        STA    $01,S
                        LDA    #$EEEE
                        STA    $05,S
                        LDA    $03,S
                        AND    #$000F
                        ORA    #$EED0
                        STA    $03,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $00,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$3A03
                        STA    $02,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    #$ACCA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$A0CA
                        STA    $A0,S
                        PEA    $AAAC
                        PHY
                        TSC                              ; Line 5
                        ADC    #$013F
                        TCS
                        TXA
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$C0AA
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$0F0F
                        ORA    #$C0C0
                        STA    $A3,S
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $03,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0C
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
; MARK: ENEMY2_006A
ENEMY2_006A             ENTRY
                        CLC                              ; 20x9, 196 bytes, 311 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$ACCA                    ; Pattern #1 : 2
                        LDY    #$CAAC                    ; Pattern #2 : 1
                        LDA    #$EEEE                    ; Pattern #3 : 1
                        TCD
;--
                        LDA    #$DDDD                    ; Line 0
                        STA    $01,S
                        TDC
                        STA    $04,S
                        SHORT  M
                        LDA    #$DD
                        STA    $00,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $03,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $06,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$AA03
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $A1,S
                        SHORT  M
                        LDA    #$CC
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A6
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$C0AA
                        STA    $9F,S
                        PEA    $ACAC
                        PHY
                        TSC                              ; Line 4
                        ADC    #$00A2
                        TCS
                        LDA    #$ACAA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $9D,S
                        PEA    $CCAC
                        PEA    $CACC
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    #$CCCC
                        STA    $A3,S
                        LDA    $02,S
                        AND    #$F0F0
                        ORA    #$0C0C
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$CC0C
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
; MARK: ENEMY2_006B
ENEMY2_006B             ENTRY
                        CLC                              ; 20x9, 196 bytes, 315 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CACC                    ; Pattern #1 : 2
                        LDY    #$3A33                    ; Pattern #2 : 1
                        LDA    #$CC3A                    ; Pattern #3 : 1
                        TCD
;--
                        LDA    #$DDDD                    ; Line 0
                        STA    $01,S
                        LDA    #$EEEE
                        STA    $05,S
                        LDA    $03,S
                        AND    #$000F
                        ORA    #$EED0
                        STA    $03,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $00,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$A03A
                        STA    $03,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$C0CA
                        STA    $A6,S
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $9C,S
                        PEA    $AACC
                        PHY
                        TSC                              ; Line 4
                        ADC    #$00A5
                        TCS
                        TXA
                        STA    $9C,S
                        LDA    $9E,S
                        AND    #$0F00
                        ORA    #$C0AA
                        STA    $9E,S
                        PEA    $ACCA
                        PEA    $CCAA
                        TSC                              ; Line 6
                        ADC    #$013E
                        TCS
                        LDA    #$CCCC
                        STA    $A2,S
                        LDA    $03,S
                        AND    #$0F0F
                        ORA    #$C0C0
                        STA    $03,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$C0CC
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
; MARK: ENEMY2_007A
ENEMY2_007A             ENTRY
                        CLC                              ; 20x9, 186 bytes, 299 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCCC                    ; Pattern #1 : 3
                        LDY    #$AACA                    ; Pattern #2 : 2
                        LDA    #$CAAC                    ; Pattern #3 : 2
                        TCD
;--
                        LDA    #$DDDD                    ; Line 0
                        STA    $01,S
                        LDA    #$EEEE
                        STA    $04,S
                        SHORT  M
                        LDA    #$DD
                        STA    $00,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $03,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $06,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$AA33
                        STA    $02,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $06,S
                        SHORT  M
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $9A,S
                        LONG   M
                        PHD
                        PEA    $CACC
                        PEA    $3A33
                        TSC                              ; Line 4
                        ADC    #$00A6
                        TCS
                        PEA    $CCAA
                        PHD
                        PEA    $AACC
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        LDA    $9E,S
                        AND    #$F00F
                        ORA    #$0CC0
                        STA    $9E,S
                        PEA    $CAAA
                        PEA    $CACC
                        TSC                              ; Line 7
                        ADC    #$0144
                        TCS
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
; MARK: ENEMY2_007B
ENEMY2_007B             ENTRY
                        CLC                              ; 20x9, 236 bytes, 373 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$AACC                    ; Pattern #1 : 3
                        LDY    #$CCAA                    ; Pattern #2 : 2
                        LDA    #$CCAC                    ; Pattern #3 : 1
                        TCD
;--
                        LDA    #$DDDD                    ; Line 0
                        STA    $01,S
                        LDA    #$EEEE
                        STA    $05,S
                        LDA    $03,S
                        AND    #$000F
                        ORA    #$EED0
                        STA    $03,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $00,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$3A03
                        STA    $02,S
                        SHORT  M
                        LDA    #$CC
                        STA    $07,S
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $04,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A0,S
                        LONG   M
                        PEA    $ACCC
                        PHX
                        PEA    $AC33
                        TSC                              ; Line 4
                        ADC    #$00A5
                        TCS
                        TXA
                        STA    $9C,S
                        LDA    $9E,S
                        AND    #$0F00
                        ORA    #$A0AC
                        STA    $9E,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $9B,S
                        LONG   M
                        PEA    $ACAA
                        PHY
                        PEA    $CACC
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    #$CCCC
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $A4,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $04,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0C
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
; MARK: ENEMY2_008A
ENEMY2_008A             ENTRY
                        CLC                              ; 20x9, 212 bytes, 343 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCCC                    ; Pattern #1 : 3
                        LDY    #$AACC                    ; Pattern #2 : 2
                        LDA    #$ACCA                    ; Pattern #3 : 2
                        TCD
;--
                        LDA    #$DDDD                    ; Line 0
                        STA    $01,S
                        LDA    #$EEEE
                        STA    $04,S
                        SHORT  M
                        LDA    #$DD
                        STA    $00,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $03,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $06,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$3A03
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $03,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $A0,S
                        SHORT  M
                        LDA    #$CC
                        STA    $07,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A7
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$C0AC
                        STA    $9F,S
                        PHD
                        PHD
                        PEA    $CCAC
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        LDA    #$ACAA
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$CA0C
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0CC
                        STA    $9F,S
                        PEA    $AAAA
                        PEA    $CCAA
                        PHY
                        TSC                              ; Line 6
                        ADC    #$0141
                        TCS
                        LDA    $02,S
                        AND    #$F00F
                        ORA    #$0CC0
                        STA    $02,S
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
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
; MARK: ENEMY2_008B
ENEMY2_008B             ENTRY
                        CLC                              ; 20x9, 225 bytes, 361 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$CCAA                    ; Pattern #1 : 3
                        LDY    #$AAAA                    ; Pattern #2 : 3
                        LDA    #$AACC                    ; Pattern #3 : 2
                        TCD
;--
                        LDA    #$DDDD                    ; Line 0
                        STA    $01,S
                        LDA    #$EEEE
                        STA    $05,S
                        LDA    $03,S
                        AND    #$000F
                        ORA    #$EED0
                        STA    $03,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $00,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $03,S
                        LDA    $07,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $07,S
                        LDA    $A7,S
                        AND    #$0F00
                        ORA    #$C0AA
                        STA    $A7,S
                        SHORT  M
                        LDA    #$33
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A6
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$CA0C
                        STA    $9A,S
                        PHX
                        PEA    $CCCC
                        PEA    $3A33
                        TSC                              ; Line 4
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    #$CA
                        STA    $9E,S
                        LONG   M
                        PHX
                        PEA    $AACA
                        PEA    $ACAA
                        TSC                              ; Line 5
                        ADC    #$00A3
                        TCS
                        SHORT  M
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A0,S
                        LONG   M
                        PHX
                        PHD
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    #$CCCC
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $04,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $01,S
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
; MARK: ROCKET_000A
ROCKET_000A             ENTRY
                        CLC                              ; 12x9, 104 bytes, 169 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2112                    ; Pattern #1 : 1
                        LDY    #$1121                    ; Pattern #2 : 1
                        LDA    #$1211                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        LDA    $00,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $00,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        LDA    $9C,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $9C,S
                        SHORT  M
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $9F,S
                        LONG   M
                        PHY
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
; MARK: ROCKET_000B
ROCKET_000B             ENTRY
                        CLC                              ; 12x9, 104 bytes, 166 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2211                    ; Pattern #1 : 1
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TXA
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A4,S
                        SHORT  M
                        LDA    #$CC
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $03,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$CC
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$0C
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
; MARK: ROCKET_001A
ROCKET_001A             ENTRY
                        CLC                              ; 12x9, 102 bytes, 162 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$C010
                        STA    $A2,S
                        SHORT  M
                        LDA    #$CC
                        STA    $01,S
                        LDA    #$11
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$F0F0
                        ORA    #$010C
                        STA    $A2,S
                        SHORT  M
                        LDA    #$CC
                        STA    $01,S
                        LDA    #$11
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
; MARK: ROCKET_001B
ROCKET_001B             ENTRY
                        CLC                              ; 12x9, 116 bytes, 187 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A1,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $01,S
                        LDA    $A3,S
                        AND    #$000F
                        ORA    #$11C0
                        STA    $A3,S
                        SHORT  M
                        LDA    #$22
                        STA    $03,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$10
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
; MARK: ROCKET_002A
ROCKET_002A             ENTRY
                        CLC                              ; 12x9, 134 bytes, 210 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$C0C1
                        STA    $A1,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$100C
                        STA    $01,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$2C
                        STA    $03,S
                        LDA    #$C1
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$10
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$01
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
; MARK: ROCKET_002B
ROCKET_002B             ENTRY
                        CLC                              ; 12x9, 136 bytes, 215 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$1C0C
                        STA    $A1,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$C1
                        STA    $02,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0FF0
                        ORA    #$C002
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0FF0
                        ORA    #$100C
                        STA    $A3,S
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$01
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$10
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
; MARK: ROCKET_003A
ROCKET_003A             ENTRY
                        CLC                              ; 12x9, 158 bytes, 250 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        LDA    $A1,S                     ; Line 0
                        AND    #$00F0
                        ORA    #$1C0C
                        STA    $A1,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$100C
                        STA    $01,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$C002
                        STA    $A2,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$02
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$100C
                        STA    $02,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$01
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
; MARK: ROCKET_003B
ROCKET_003B             ENTRY
                        CLC                              ; 12x9, 140 bytes, 217 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        LDA    $A2,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$C0C1
                        STA    $A2,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$C1
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$2C
                        STA    $A3,S
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$20
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$C1
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$10
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
; MARK: ROCKET_004A
ROCKET_004A             ENTRY
                        CLC                              ; 12x9, 152 bytes, 240 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        LDA    $02,S                     ; Line 0
                        AND    #$0F0F
                        ORA    #$C0C0
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$C0C1
                        STA    $A2,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$01
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$C0C2
                        STA    $A2,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$02
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$01
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$01
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
; MARK: ROCKET_004B
ROCKET_004B             ENTRY
                        CLC                              ; 12x9, 152 bytes, 240 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        LDA    $02,S                     ; Line 0
                        AND    #$F0F0
                        ORA    #$0C0C
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1C0C
                        STA    $A2,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$10
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$2C0C
                        STA    $A2,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$20
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$10
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$10
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
; MARK: ROCKET_005A
ROCKET_005A             ENTRY
                        CLC                              ; 12x9, 140 bytes, 217 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        LDA    $A2,S                     ; Line 0
                        AND    #$00F0
                        ORA    #$1C0C
                        STA    $A2,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$1C
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$C2
                        STA    $A2,S
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$02
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$1C
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$01
                        STA    $01,S
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
; MARK: ROCKET_005B
ROCKET_005B             ENTRY
                        CLC                              ; 12x9, 158 bytes, 250 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        LDA    $A3,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$C0C1
                        STA    $A3,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0FF0
                        ORA    #$C001
                        STA    $03,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$200C
                        STA    $A2,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$20
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$C001
                        STA    $02,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$10
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
; MARK: ROCKET_006A
ROCKET_006A             ENTRY
                        CLC                              ; 12x9, 134 bytes, 210 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$1C0C
                        STA    $A3,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0FF0
                        ORA    #$C001
                        STA    $03,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$C2
                        STA    $02,S
                        LDA    #$1C
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$01
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
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
; MARK: ROCKET_006B
ROCKET_006B             ENTRY
                        CLC                              ; 12x9, 136 bytes, 215 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$C0C1
                        STA    $A4,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$1C
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$200C
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$C001
                        STA    $A2,S
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$10
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$01
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
; MARK: ROCKET_007A
ROCKET_007A             ENTRY
                        CLC                              ; 12x9, 102 bytes, 162 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$F0F0
                        ORA    #$010C
                        STA    $A2,S
                        SHORT  M
                        LDA    #$CC
                        STA    $04,S
                        LDA    #$11
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$C010
                        STA    $A2,S
                        SHORT  M
                        LDA    #$CC
                        STA    $04,S
                        LDA    #$11
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
; MARK: ROCKET_007B
ROCKET_007B             ENTRY
                        CLC                              ; 12x9, 116 bytes, 187 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$000F
                        ORA    #$11C0
                        STA    $A3,S
                        SHORT  M
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $04,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A1,S
                        SHORT  M
                        LDA    #$22
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$0C
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
; MARK: ROCKET_008A
ROCKET_008A             ENTRY
                        CLC                              ; 12x9, 104 bytes, 166 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2211                    ; Pattern #1 : 1
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TXA
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A3,S
                        SHORT  M
                        LDA    #$CC
                        STA    $04,S
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $02,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$CC
                        STA    $04,S
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$C0
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
; MARK: ROCKET_008B
ROCKET_008B             ENTRY
                        CLC                              ; 12x9, 104 bytes, 169 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2112                    ; Pattern #1 : 1
                        LDY    #$1121                    ; Pattern #2 : 1
                        LDA    #$1211                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        LDA    $04,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $04,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $A0,S
                        SHORT  M
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $9E,S
                        LONG   M
                        PHY
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
; MARK: ROCKET_009A
ROCKET_009A             ENTRY
                        CLC                              ; 12x9, 102 bytes, 162 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        LDA    $02,S
                        AND    #$0F0F
                        ORA    #$C010
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A2,S
                        SHORT  M
                        LDA    #$11
                        STA    $01,S
                        LDA    #$CC
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$F0F0
                        ORA    #$010C
                        STA    $02,S
                        SHORT  M
                        LDA    #$11
                        STA    $04,S
                        LDA    #$CC
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
; MARK: ROCKET_009B
ROCKET_009B             ENTRY
                        CLC                              ; 12x9, 116 bytes, 187 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $01,S
                        LDA    $A4,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $A4,S
                        SHORT  M
                        LDA    #$22
                        STA    $A3,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$000F
                        ORA    #$11C0
                        STA    $03,S
                        LDA    $A4,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $A4,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$10
                        STA    $05,S
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
; MARK: ROCKET_010A
ROCKET_010A             ENTRY
                        CLC                              ; 12x9, 129 bytes, 203 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        SHORT  M                         ; Line 0
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$10
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$1C
                        STA    $02,S
                        LDA    #$C2
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $A3,S
                        AND    #$0FF0
                        ORA    #$C001
                        STA    $A3,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$20
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$1C0C
                        STA    $03,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$C0
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
; MARK: ROCKET_010B
ROCKET_010B             ENTRY
                        CLC                              ; 12x9, 131 bytes, 208 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        SHORT  M                         ; Line 0
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$01
                        STA    $01,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$C001
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$200C
                        STA    $A2,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$1C
                        STA    $A4,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$02
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$C0C1
                        STA    $04,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$0C
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
; MARK: ROCKET_011A
ROCKET_011A             ENTRY
                        CLC                              ; 12x9, 140 bytes, 217 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        SHORT  M                         ; Line 0
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$01
                        STA    $01,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$1C
                        STA    $02,S
                        LDA    #$C2
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$02
                        STA    $02,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1C0C
                        STA    $A2,S
                        SHORT  M
                        LDA    #$1C
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$C0
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
; MARK: ROCKET_011B
ROCKET_011B             ENTRY
                        CLC                              ; 12x9, 150 bytes, 238 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        SHORT  M                         ; Line 0
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$10
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$C001
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$200C
                        STA    $A2,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$20
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0FF0
                        ORA    #$C001
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$C0C1
                        STA    $A3,S
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$0C
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
; MARK: ROCKET_012A
ROCKET_012A             ENTRY
                        CLC                              ; 12x9, 152 bytes, 240 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        SHORT  M                         ; Line 0
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$01
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$C0C2
                        STA    $A2,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$01
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$02
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$C0C1
                        STA    $A2,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$01
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F0F
                        ORA    #$C0C0
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
; MARK: ROCKET_012B
ROCKET_012B             ENTRY
                        CLC                              ; 12x9, 152 bytes, 240 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        SHORT  M                         ; Line 0
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$10
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$2C0C
                        STA    $A2,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$10
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$20
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1C0C
                        STA    $A2,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$10
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$F0F0
                        ORA    #$0C0C
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
; MARK: ROCKET_013A
ROCKET_013A             ENTRY
                        CLC                              ; 12x9, 150 bytes, 238 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        SHORT  M                         ; Line 0
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$01
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$100C
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$C002
                        STA    $A2,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$02
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$100C
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$1C0C
                        STA    $A1,S
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$C0
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
; MARK: ROCKET_013B
ROCKET_013B             ENTRY
                        CLC                              ; 12x9, 140 bytes, 217 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        SHORT  M                         ; Line 0
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$10
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$C1
                        STA    $03,S
                        LDA    #$2C
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$20
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$C0C1
                        STA    $A2,S
                        SHORT  M
                        LDA    #$C1
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0C
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
; MARK: ROCKET_014A
ROCKET_014A             ENTRY
                        CLC                              ; 12x9, 129 bytes, 203 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        SHORT  M                         ; Line 0
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$01
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$C1
                        STA    $03,S
                        LDA    #$2C
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$100C
                        STA    $A1,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$02
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$C0C1
                        STA    $01,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0C
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
; MARK: ROCKET_014B
ROCKET_014B             ENTRY
                        CLC                              ; 12x9, 131 bytes, 208 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        SHORT  M                         ; Line 0
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$10
                        STA    $05,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0FF0
                        ORA    #$100C
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0FF0
                        ORA    #$C002
                        STA    $A3,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$C1
                        STA    $A2,S
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$20
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$1C0C
                        STA    $01,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$C0
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
; MARK: ROCKET_015A
ROCKET_015A             ENTRY
                        CLC                              ; 12x9, 102 bytes, 162 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        LDA    $02,S
                        AND    #$F0F0
                        ORA    #$010C
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A2,S
                        SHORT  M
                        LDA    #$11
                        STA    $04,S
                        LDA    #$CC
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F0F
                        ORA    #$C010
                        STA    $02,S
                        SHORT  M
                        LDA    #$11
                        STA    $01,S
                        LDA    #$CC
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
; MARK: ROCKET_015B
ROCKET_015B             ENTRY
                        CLC                              ; 12x9, 116 bytes, 187 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        LDA    $03,S
                        AND    #$000F
                        ORA    #$11C0
                        STA    $03,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $A1,S
                        SHORT  M
                        LDA    #$22
                        STA    $A3,S
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$10
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $A1,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$0C
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

THISISAFORMATTINGLABEL  ANOP
                        END
