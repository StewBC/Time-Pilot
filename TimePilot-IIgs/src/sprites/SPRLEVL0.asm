                        MCOPY  src/sprites/SPRLEVL0.mac

SPRLEVL0                START  LEVL0

                        USING  VARIABLES

; MARK: BOMB_000A
BOMB_000A               ENTRY
                        CLC                              ; 8x3, 97 bytes, 158 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2277                    ; Pattern #1 : 1
;--
                        TXA                              ; Line 0
                        STA    $A0,S
                        LDA    $00,S
                        AND    #$000F
                        ORA    #$2270
                        STA    $00,S
                        SHORT  M
                        LDA    #$11
                        STA    $A2,S
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$10
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$000F
                        ORA    #$2270
                        STA    $00,S
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
; MARK: BOMB_000B
BOMB_000B               ENTRY
                        CLC                              ; 8x3, 99 bytes, 161 cycles
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
                        LDA    $00,S                     ; Line 0
                        AND    #$F0F0
                        ORA    #$0207
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$7207
                        STA    $A0,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$1021
                        STA    $A2,S
                        SHORT  M
                        LDA    #$21
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$F0F0
                        ORA    #$0207
                        STA    $00,S
                        SHORT  M
                        LDA    #$21
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
; MARK: BOMB_001A
BOMB_001A               ENTRY
                        CLC                              ; 8x3, 97 bytes, 158 cycles
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
                        TXA                              ; Line 0
                        STA    $A0,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$2201
                        STA    $00,S
                        SHORT  M
                        LDA    #$77
                        STA    $A2,S
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$07
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$2201
                        STA    $00,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$07
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
; MARK: BOMB_001B
BOMB_001B               ENTRY
                        CLC                              ; 8x3, 99 bytes, 161 cycles
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
                        ORA    #$7020
                        STA    $02,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$1201
                        STA    $A0,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$7027
                        STA    $A2,S
                        SHORT  M
                        LDA    #$12
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F0F
                        ORA    #$7020
                        STA    $02,S
                        SHORT  M
                        LDA    #$12
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
; MARK: BOSS0_000A
BOSS0_000A              ENTRY
                        CLC                              ; 32x16, 440 bytes, 802 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 60
                        LDY    #$9999                    ; Pattern #2 : 29
                        LDA    #$9989                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $0A,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$8088
                        STA    $0A,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $A0,S
                        SHORT  M
                        LDA    #$99
                        STA    $00,S
                        LDA    #$88
                        STA    $AC,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$08
                        STA    $05,S
                        LONG   M
                        TSC
                        ADC    #$0009
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 1
                        ADC    #$00A6
                        TCS
                        TYA
                        STA    $95,S
                        LDA    $97,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $97,S
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHY
                        PHY
                        PHY
                        PHD
                        TSC                              ; Line 3
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    #$98
                        STA    $93,S
                        LONG   M
                        PEA    $9899
                        PHX
                        PHX
                        PHX
                        PEA    $8898
                        PEA    $9988
                        PEA    $9899
                        TSC                              ; Line 4
                        ADC    #$00AF
                        TCS
                        SHORT  M
                        LDA    #$89
                        STA    $A0,S
                        LONG   M
                        PEA    $9889
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9988
                        TSC                              ; Line 5
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$99
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHD
                        TSC                              ; Line 6
                        ADC    #$00AE
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9889
                        TSC                              ; Line 7
                        ADC    #$00AE
                        TCS
                        TXA
                        STA    $93,S
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $95,S
                        PHD
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $8899
                        PEA    $8988
                        TSC                              ; Line 8
                        ADC    #$00AE
                        TCS
                        LDA    $93,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $93,S
                        SHORT  M
                        LDA    #$99
                        STA    $9F,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    #$88
                        STA    $95,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A0,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9B,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LONG   M
                        PHY
                        PHY
                        PEA    $9919
                        TSC                              ; Line 12
                        ADC    #$013C
                        TCS
                        TYA
                        STA    $A5,S
                        STA    $A9,S
                        LDA    $A7,S
                        AND    #$F00F
                        ORA    #$0990
                        STA    $A7,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$01
                        STA    $05,S
                        LDA    $09,S
                        AND    #$F0
                        ORA    #$01
                        STA    $09,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$08
                        STA    $A4,S
                        LDA    $AB,S
                        AND    #$0F
                        ORA    #$80
                        STA    $AB,S
                        LONG   M
                        TSC                              ; Line 14
                        ADC    #$014A
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $9F,S
                        PEA    $9988
                        PHX
                        PEA    $9899
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
; MARK: BOSS0_000B
BOSS0_000B              ENTRY
                        CLC                              ; 32x16, 516 bytes, 923 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 59
                        LDY    #$9999                    ; Pattern #2 : 28
                        LDA    #$8898                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $00,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$9009
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $A0,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $A4,S
                        LDA    $AC,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $AC,S
                        TSC
                        ADC    #$000B
                        TCS
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 1
                        ADC    #$00A6
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $95,S
                        LDA    $97,S
                        AND    #$000F
                        ORA    #$8890
                        STA    $97,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A3,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $93,S
                        AND    #$F0
                        ORA    #$09
                        STA    $93,S
                        LONG   M
                        PHD
                        PHY
                        PHY
                        PHY
                        PEA    $9988
                        TSC                              ; Line 3
                        ADC    #$00AB
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$8809
                        STA    $92,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$8099
                        STA    $A0,S
                        PEA    $8899
                        PEA    $8988
                        PHX
                        PHX
                        PHX
                        PEA    $9989
                        PEA    $8899
                        TSC                              ; Line 4
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9908
                        STA    $93,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$9088
                        STA    $A1,S
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9889
                        TSC                              ; Line 5
                        ADC    #$00AC
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9908
                        STA    $93,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$9089
                        STA    $A1,S
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHD
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        SHORT  M
                        LDA    $93,S
                        AND    #$F0
                        ORA    #$08
                        STA    $93,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AD
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $92,S
                        LDA    $94,S
                        AND    #$000F
                        ORA    #$9980
                        STA    $94,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A0,S
                        LONG   M
                        PHY
                        PHX
                        PHX
                        PHX
                        PHX
                        PHD
                        PEA    $9988
                        TSC                              ; Line 8
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $93,S
                        LDA    $97,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $97,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $9F,S
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A8
                        TCS
                        LDA    $95,S
                        AND    #$0FF0
                        ORA    #$8008
                        STA    $95,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9A,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9A,S
                        LDA    $9F,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9F,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 12
                        ADC    #$013B
                        TCS
                        TYA
                        STA    $A6,S
                        STA    $A9,S
                        SHORT  M
                        LDA    #$89
                        STA    $A5,S
                        LDA    #$98
                        STA    $AB,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$10
                        STA    $06,S
                        LDA    $0A,S
                        AND    #$0F
                        ORA    #$10
                        STA    $0A,S
                        LONG   M
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        LDA    $05,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $05,S
                        SHORT  M
                        LDA    #$88
                        STA    $AA,S
                        LDA    $0B,S
                        AND    #$0F
                        ORA    #$90
                        STA    $0B,S
                        LONG   M
                        TSC
                        ADC    #$000A
                        TCS
                        PEA    $8988
                        PHX
                        TSC                              ; Line 15
                        ADC    #$00A3
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
; MARK: BOSS0_001A
BOSS0_001A              ENTRY
                        CLC                              ; 32x16, 455 bytes, 815 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 60
                        LDY    #$9999                    ; Pattern #2 : 24
                        LDA    #$8899                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $0A,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$8088
                        STA    $0A,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $A0,S
                        SHORT  M
                        LDA    #$99
                        STA    $00,S
                        LDA    #$88
                        STA    $AC,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$08
                        STA    $05,S
                        LONG   M
                        TSC
                        ADC    #$0009
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 1
                        ADC    #$00A6
                        TCS
                        TYA
                        STA    $95,S
                        LDA    $97,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $97,S
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHY
                        PHY
                        PHY
                        PEA    $9989
                        TSC                              ; Line 3
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    #$98
                        STA    $93,S
                        LONG   M
                        PEA    $9899
                        PHX
                        PHX
                        PHX
                        PEA    $8898
                        PEA    $9988
                        PEA    $9899
                        TSC                              ; Line 4
                        ADC    #$00AF
                        TCS
                        SHORT  M
                        LDA    #$89
                        STA    $A0,S
                        LONG   M
                        PEA    $9889
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9988
                        TSC                              ; Line 5
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$99
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9989
                        TSC                              ; Line 6
                        ADC    #$00AE
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9889
                        TSC                              ; Line 7
                        ADC    #$00AE
                        TCS
                        TXA
                        STA    $93,S
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $95,S
                        PEA    $9989
                        PHX
                        PHX
                        PHX
                        PHX
                        PHD
                        PEA    $8988
                        TSC                              ; Line 8
                        ADC    #$00AE
                        TCS
                        LDA    $93,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $93,S
                        SHORT  M
                        LDA    #$99
                        STA    $97,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    #$88
                        STA    $94,S
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$90
                        STA    $9F,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PEA    $1991
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        LDA    #$1111
                        STA    $9B,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9D,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LONG   M
                        PHY
                        PHY
                        PEA    $1119
                        TSC                              ; Line 12
                        ADC    #$013C
                        TCS
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$9908
                        STA    $A4,S
                        LDA    $AA,S
                        AND    #$0F00
                        ORA    #$8099
                        STA    $AA,S
                        SHORT  M
                        LDA    #$11
                        STA    $07,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$01
                        STA    $05,S
                        LDA    $09,S
                        AND    #$F0
                        ORA    #$01
                        STA    $09,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$00A9
                        TCS
                        PEA    $9919
                        PEA    $1111
                        TSC                              ; Line 14
                        ADC    #$00A5
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $9F,S
                        PEA    $9988
                        PHX
                        PEA    $1891
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
; MARK: BOSS0_001B
BOSS0_001B              ENTRY
                        CLC                              ; 32x16, 544 bytes, 964 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 59
                        LDY    #$9999                    ; Pattern #2 : 24
                        LDA    #$8898                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $00,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$9009
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $A0,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $A4,S
                        LDA    $AC,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $AC,S
                        TSC
                        ADC    #$000B
                        TCS
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 1
                        ADC    #$00A6
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $95,S
                        LDA    $97,S
                        AND    #$000F
                        ORA    #$8890
                        STA    $97,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A3,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $93,S
                        AND    #$F0
                        ORA    #$09
                        STA    $93,S
                        LONG   M
                        PHD
                        PHY
                        PHY
                        PHY
                        PEA    $9988
                        TSC                              ; Line 3
                        ADC    #$00AB
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$8809
                        STA    $92,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$8099
                        STA    $A0,S
                        PEA    $8899
                        PEA    $8988
                        PHX
                        PHX
                        PHX
                        PEA    $9989
                        PEA    $8899
                        TSC                              ; Line 4
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9908
                        STA    $93,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$9088
                        STA    $A1,S
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9889
                        TSC                              ; Line 5
                        ADC    #$00AC
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9908
                        STA    $93,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$9089
                        STA    $A1,S
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHD
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        SHORT  M
                        LDA    $93,S
                        AND    #$F0
                        ORA    #$08
                        STA    $93,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AD
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $92,S
                        LDA    $94,S
                        AND    #$000F
                        ORA    #$9980
                        STA    $94,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A0,S
                        LONG   M
                        PHY
                        PHX
                        PHX
                        PHX
                        PHX
                        PHD
                        PEA    $9988
                        TSC                              ; Line 8
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $93,S
                        LDA    $97,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $97,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $9F,S
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A8
                        TCS
                        LDA    $95,S
                        AND    #$0FF0
                        ORA    #$8008
                        STA    $95,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9A,S
                        LONG   M
                        PHY
                        PHY
                        PEA    $9911
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9A,S
                        LDA    $9C,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $9C,S
                        SHORT  M
                        LDA    $9F,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9F,S
                        LONG   M
                        PHY
                        PHY
                        PEA    $1991
                        TSC                              ; Line 12
                        ADC    #$013B
                        TCS
                        LDA    $06,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $06,S
                        SHORT  M
                        LDA    #$98
                        STA    $AB,S
                        LDA    $08,S
                        AND    #$0F
                        ORA    #$10
                        STA    $08,S
                        LDA    $0A,S
                        AND    #$0F
                        ORA    #$10
                        STA    $0A,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$00AA
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$1109
                        STA    $9B,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A1,S
                        LONG   M
                        PHY
                        PEA    $1111
                        PEA    $9189
                        TSC                              ; Line 14
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    #$88
                        STA    $A0,S
                        LONG   M
                        PEA    $8988
                        PHX
                        TSC                              ; Line 15
                        ADC    #$00A3
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
; MARK: BOSS0_002A
BOSS0_002A              ENTRY
                        CLC                              ; 32x16, 520 bytes, 921 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 60
                        LDY    #$9999                    ; Pattern #2 : 26
                        LDA    #$8899                    ; Pattern #3 : 5
                        TCD
;--
                        LDA    $0A,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$8088
                        STA    $0A,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $A0,S
                        SHORT  M
                        LDA    #$99
                        STA    $00,S
                        LDA    #$88
                        STA    $AC,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$08
                        STA    $05,S
                        LONG   M
                        TSC
                        ADC    #$0009
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 1
                        ADC    #$00A6
                        TCS
                        TYA
                        STA    $95,S
                        LDA    $97,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $97,S
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 3
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    #$98
                        STA    $93,S
                        LONG   M
                        PEA    $9899
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9988
                        PEA    $9899
                        TSC                              ; Line 4
                        ADC    #$00AF
                        TCS
                        SHORT  M
                        LDA    #$89
                        STA    $A0,S
                        LONG   M
                        PEA    $9889
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9988
                        TSC                              ; Line 5
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$99
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9989
                        TSC                              ; Line 6
                        ADC    #$00AE
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9889
                        TSC                              ; Line 7
                        ADC    #$00AE
                        TCS
                        TXA
                        STA    $93,S
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $95,S
                        PEA    $9989
                        PHX
                        PHX
                        PHX
                        PHX
                        PHD
                        PEA    $8988
                        TSC                              ; Line 8
                        ADC    #$00AE
                        TCS
                        LDA    $93,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $93,S
                        LDA    $95,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $95,S
                        SHORT  M
                        LDA    #$91
                        STA    $97,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A9
                        TCS
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $96,S
                        SHORT  M
                        LDA    #$88
                        STA    $94,S
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$90
                        STA    $9F,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PEA    $9991
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        LDA    $99,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $99,S
                        LDA    $9C,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $9C,S
                        SHORT  M
                        LDA    #$11
                        STA    $9B,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LONG   M
                        PHY
                        PHY
                        PEA    $9111
                        TSC                              ; Line 12
                        ADC    #$013C
                        TCS
                        LDA    #$1111
                        STA    $04,S
                        LDA    $02,S
                        AND    #$F000
                        ORA    #$0111
                        STA    $02,S
                        LDA    $06,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A2,S
                        LDA    $AA,S
                        AND    #$0F00
                        ORA    #$8099
                        STA    $AA,S
                        SHORT  M
                        LDA    $09,S
                        AND    #$F0
                        ORA    #$01
                        STA    $09,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $99,S
                        AND    #$0F
                        ORA    #$10
                        STA    $99,S
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LONG   M
                        PEA    $9919
                        PEA    $1111
                        PEA    $9118
                        TSC                              ; Line 14
                        ADC    #$00A7
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $9F,S
                        PEA    $9988
                        PEA    $8818
                        PEA    $9819
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
; MARK: BOSS0_002B
BOSS0_002B              ENTRY
                        CLC                              ; 32x16, 576 bytes, 1009 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 58
                        LDY    #$9999                    ; Pattern #2 : 24
                        LDA    #$8898                    ; Pattern #3 : 5
                        TCD
;--
                        LDA    $00,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$9009
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $A0,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $A4,S
                        LDA    $AC,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $AC,S
                        TSC
                        ADC    #$000B
                        TCS
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 1
                        ADC    #$00A6
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $95,S
                        LDA    $97,S
                        AND    #$000F
                        ORA    #$8890
                        STA    $97,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A3,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $93,S
                        AND    #$F0
                        ORA    #$09
                        STA    $93,S
                        LONG   M
                        PHD
                        PHY
                        PHY
                        PHY
                        PEA    $9989
                        TSC                              ; Line 3
                        ADC    #$00AB
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$8809
                        STA    $92,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$8099
                        STA    $A0,S
                        PEA    $8899
                        PEA    $8988
                        PHX
                        PHX
                        PHX
                        PEA    $9889
                        PEA    $8899
                        TSC                              ; Line 4
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9908
                        STA    $93,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$9088
                        STA    $A1,S
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9889
                        TSC                              ; Line 5
                        ADC    #$00AC
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9908
                        STA    $93,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$9089
                        STA    $A1,S
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHD
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        SHORT  M
                        LDA    $93,S
                        AND    #$F0
                        ORA    #$08
                        STA    $93,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AD
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $92,S
                        LDA    $94,S
                        AND    #$000F
                        ORA    #$9980
                        STA    $94,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A0,S
                        LONG   M
                        PHY
                        PHX
                        PHX
                        PHX
                        PHX
                        PHD
                        PEA    $9988
                        TSC                              ; Line 8
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $93,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $9F,S
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$01
                        STA    $95,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A8
                        TCS
                        LDA    $95,S
                        AND    #$0FF0
                        ORA    #$8008
                        STA    $95,S
                        LDA    $99,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $99,S
                        SHORT  M
                        LDA    #$11
                        STA    $98,S
                        LONG   M
                        PHY
                        PHY
                        PEA    $9919
                        PEA    $1919
                        TSC                              ; Line 10
                        ADC    #$00A8
                        TCS
                        LDA    $98,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $98,S
                        LDA    $9A,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $9A,S
                        SHORT  M
                        LDA    #$11
                        STA    $9C,S
                        LDA    $9F,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9F,S
                        LONG   M
                        PHY
                        PHY
                        PEA    $1919
                        TSC                              ; Line 12
                        ADC    #$013B
                        TCS
                        LDA    #$1111
                        STA    $04,S
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $02,S
                        LDA    $07,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $07,S
                        SHORT  M
                        LDA    #$11
                        STA    $06,S
                        LDA    #$98
                        STA    $AB,S
                        LDA    $0A,S
                        AND    #$0F
                        ORA    #$10
                        STA    $0A,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $98,S
                        AND    #$F0
                        ORA    #$01
                        STA    $98,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A1,S
                        LONG   M
                        PHY
                        PEA    $1111
                        PEA    $1189
                        PEA    $1111
                        TSC                              ; Line 14
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    #$88
                        STA    $A0,S
                        LONG   M
                        PEA    $8988
                        PEA    $8881
                        PEA    $9911
                        TSC                              ; Line 15
                        ADC    #$00A5
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
; MARK: BOSS0_003A
BOSS0_003A              ENTRY
                        CLC                              ; 32x16, 520 bytes, 921 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 60
                        LDY    #$9999                    ; Pattern #2 : 26
                        LDA    #$8899                    ; Pattern #3 : 5
                        TCD
;--
                        LDA    $0A,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$8088
                        STA    $0A,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $A0,S
                        SHORT  M
                        LDA    #$99
                        STA    $00,S
                        LDA    #$88
                        STA    $AC,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$08
                        STA    $05,S
                        LONG   M
                        TSC
                        ADC    #$0009
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 1
                        ADC    #$00A6
                        TCS
                        TYA
                        STA    $95,S
                        LDA    $97,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $97,S
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 3
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    #$98
                        STA    $93,S
                        LONG   M
                        PEA    $9899
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9988
                        PEA    $9899
                        TSC                              ; Line 4
                        ADC    #$00AF
                        TCS
                        SHORT  M
                        LDA    #$89
                        STA    $A0,S
                        LONG   M
                        PEA    $9889
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9988
                        TSC                              ; Line 5
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$99
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9989
                        TSC                              ; Line 6
                        ADC    #$00AE
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9889
                        TSC                              ; Line 7
                        ADC    #$00AE
                        TCS
                        TXA
                        STA    $93,S
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $95,S
                        PEA    $9989
                        PHX
                        PHX
                        PHX
                        PHX
                        PHD
                        PEA    $8988
                        TSC                              ; Line 8
                        ADC    #$00AE
                        TCS
                        LDA    $93,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $93,S
                        LDA    $95,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $95,S
                        SHORT  M
                        LDA    #$91
                        STA    $97,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A9
                        TCS
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $96,S
                        SHORT  M
                        LDA    #$88
                        STA    $94,S
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$90
                        STA    $9F,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PEA    $9991
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        LDA    $99,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $99,S
                        LDA    $9C,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $9C,S
                        SHORT  M
                        LDA    #$11
                        STA    $9B,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LONG   M
                        PHY
                        PHY
                        PEA    $9111
                        TSC                              ; Line 12
                        ADC    #$013C
                        TCS
                        LDA    #$1111
                        STA    $04,S
                        LDA    $02,S
                        AND    #$F000
                        ORA    #$0111
                        STA    $02,S
                        LDA    $06,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A2,S
                        LDA    $AA,S
                        AND    #$0F00
                        ORA    #$8099
                        STA    $AA,S
                        SHORT  M
                        LDA    $09,S
                        AND    #$F0
                        ORA    #$01
                        STA    $09,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $99,S
                        AND    #$0F
                        ORA    #$10
                        STA    $99,S
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LONG   M
                        PEA    $9919
                        PEA    $1111
                        PEA    $9118
                        TSC                              ; Line 14
                        ADC    #$00A7
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $9F,S
                        PEA    $9988
                        PEA    $8818
                        PEA    $9819
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
; MARK: BOSS0_003B
BOSS0_003B              ENTRY
                        CLC                              ; 32x16, 576 bytes, 1009 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 58
                        LDY    #$9999                    ; Pattern #2 : 24
                        LDA    #$8898                    ; Pattern #3 : 5
                        TCD
;--
                        LDA    $00,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$9009
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $A0,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $A4,S
                        LDA    $AC,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $AC,S
                        TSC
                        ADC    #$000B
                        TCS
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 1
                        ADC    #$00A6
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $95,S
                        LDA    $97,S
                        AND    #$000F
                        ORA    #$8890
                        STA    $97,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A3,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $93,S
                        AND    #$F0
                        ORA    #$09
                        STA    $93,S
                        LONG   M
                        PHD
                        PHY
                        PHY
                        PHY
                        PEA    $9989
                        TSC                              ; Line 3
                        ADC    #$00AB
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$8809
                        STA    $92,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$8099
                        STA    $A0,S
                        PEA    $8899
                        PEA    $8988
                        PHX
                        PHX
                        PHX
                        PEA    $9889
                        PEA    $8899
                        TSC                              ; Line 4
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9908
                        STA    $93,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$9088
                        STA    $A1,S
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9889
                        TSC                              ; Line 5
                        ADC    #$00AC
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9908
                        STA    $93,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$9089
                        STA    $A1,S
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHD
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        SHORT  M
                        LDA    $93,S
                        AND    #$F0
                        ORA    #$08
                        STA    $93,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AD
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $92,S
                        LDA    $94,S
                        AND    #$000F
                        ORA    #$9980
                        STA    $94,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A0,S
                        LONG   M
                        PHY
                        PHX
                        PHX
                        PHX
                        PHX
                        PHD
                        PEA    $9988
                        TSC                              ; Line 8
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $93,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $9F,S
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$01
                        STA    $95,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A8
                        TCS
                        LDA    $95,S
                        AND    #$0FF0
                        ORA    #$8008
                        STA    $95,S
                        LDA    $99,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $99,S
                        SHORT  M
                        LDA    #$11
                        STA    $98,S
                        LONG   M
                        PHY
                        PHY
                        PEA    $9919
                        PEA    $1919
                        TSC                              ; Line 10
                        ADC    #$00A8
                        TCS
                        LDA    $98,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $98,S
                        LDA    $9A,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $9A,S
                        SHORT  M
                        LDA    #$11
                        STA    $9C,S
                        LDA    $9F,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9F,S
                        LONG   M
                        PHY
                        PHY
                        PEA    $1919
                        TSC                              ; Line 12
                        ADC    #$013B
                        TCS
                        LDA    #$1111
                        STA    $04,S
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $02,S
                        LDA    $07,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $07,S
                        SHORT  M
                        LDA    #$11
                        STA    $06,S
                        LDA    #$98
                        STA    $AB,S
                        LDA    $0A,S
                        AND    #$0F
                        ORA    #$10
                        STA    $0A,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $98,S
                        AND    #$F0
                        ORA    #$01
                        STA    $98,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A1,S
                        LONG   M
                        PHY
                        PEA    $1111
                        PEA    $1189
                        PEA    $1111
                        TSC                              ; Line 14
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    #$88
                        STA    $A0,S
                        LONG   M
                        PEA    $8988
                        PEA    $8881
                        PEA    $9911
                        TSC                              ; Line 15
                        ADC    #$00A5
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
; MARK: BOSS0_004A
BOSS0_004A              ENTRY
                        CLC                              ; 32x16, 456 bytes, 818 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 59
                        LDY    #$9999                    ; Pattern #2 : 29
                        LDA    #$9988                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $08,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$8088
                        STA    $08,S
                        LDA    $AD,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $AD,S
                        SHORT  M
                        LDA    #$99
                        STA    $0E,S
                        LDA    #$88
                        STA    $AA,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$08
                        STA    $03,S
                        LONG   M
                        TSC
                        ADC    #$0007
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 1
                        ADC    #$00A6
                        TCS
                        TYA
                        STA    $A4,S
                        SHORT  M
                        LDA    #$88
                        STA    $98,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A3,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$08
                        STA    $95,S
                        LONG   M
                        PEA    $8898
                        PHY
                        PHY
                        PHY
                        PHD
                        TSC                              ; Line 3
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$89
                        STA    $A0,S
                        LONG   M
                        PEA    $9989
                        PEA    $8899
                        PEA    $8988
                        PHX
                        PHX
                        PHX
                        PEA    $9989
                        TSC                              ; Line 4
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$98
                        STA    $93,S
                        LONG   M
                        PEA    $8899
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9889
                        TSC                              ; Line 5
                        ADC    #$00AF
                        TCS
                        SHORT  M
                        LDA    #$99
                        STA    $92,S
                        LONG   M
                        PEA    $9899
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00AE
                        TCS
                        SHORT  M
                        LDA    $92,S
                        AND    #$F0
                        ORA    #$09
                        STA    $92,S
                        LONG   M
                        PEA    $9889
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AE
                        TCS
                        TXA
                        STA    $9F,S
                        SHORT  M
                        LDA    #$99
                        STA    $93,S
                        LDA    $9E,S
                        AND    #$0F
                        ORA    #$90
                        STA    $9E,S
                        LONG   M
                        PEA    $8898
                        PHD
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9899
                        TSC                              ; Line 8
                        ADC    #$00AB
                        TCS
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $A2,S
                        SHORT  M
                        LDA    #$99
                        STA    $9F,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    #$88
                        STA    $A5,S
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$09
                        STA    $9A,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A0,S
                        LONG   M
                        PEA    $9199
                        PHY
                        PHY
                        TSC                              ; Line 12
                        ADC    #$013D
                        TCS
                        TYA
                        STA    $A4,S
                        STA    $A8,S
                        LDA    $A6,S
                        AND    #$F00F
                        ORA    #$0990
                        STA    $A6,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$10
                        STA    $05,S
                        LDA    $09,S
                        AND    #$0F
                        ORA    #$10
                        STA    $09,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$08
                        STA    $A3,S
                        LDA    $AA,S
                        AND    #$0F
                        ORA    #$80
                        STA    $AA,S
                        LONG   M
                        TSC                              ; Line 14
                        ADC    #$0149
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $9F,S
                        PEA    $9989
                        PHX
                        PEA    $8899
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
; MARK: BOSS0_004B
BOSS0_004B              ENTRY
                        CLC                              ; 32x16, 514 bytes, 922 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 60
                        LDY    #$9999                    ; Pattern #2 : 28
                        LDA    #$9988                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $0E,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$9009
                        STA    $0E,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $A2,S
                        LDA    $AA,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $AA,S
                        LDA    $AE,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $AE,S
                        TSC
                        ADC    #$0009
                        TCS
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 1
                        ADC    #$00A6
                        TCS
                        LDA    $98,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $98,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $A5,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$09
                        STA    $A4,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A3,S
                        LONG   M
                        PHX
                        PHY
                        PHY
                        PHY
                        PEA    $9989
                        TSC                              ; Line 3
                        ADC    #$00AC
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$9908
                        STA    $92,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$9088
                        STA    $A0,S
                        PHD
                        PEA    $9899
                        PHX
                        PHX
                        PHX
                        PEA    $8898
                        PHD
                        TSC                              ; Line 4
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$8809
                        STA    $93,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$8099
                        STA    $A1,S
                        PEA    $9889
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00AC
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9809
                        STA    $93,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$8099
                        STA    $A1,S
                        PEA    $8988
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A2,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $93,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A0,S
                        SHORT  M
                        LDA    $9F,S
                        AND    #$F0
                        ORA    #$08
                        STA    $9F,S
                        LONG   M
                        PEA    $8899
                        PEA    $8988
                        PHX
                        PHX
                        PHX
                        PHX
                        PHY
                        TSC                              ; Line 8
                        ADC    #$00AC
                        TCS
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $96,S
                        LDA    $9E,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $9E,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A2,S
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A7
                        TCS
                        LDA    $A5,S
                        AND    #$0FF0
                        ORA    #$8008
                        STA    $A5,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9C,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 12
                        ADC    #$013D
                        TCS
                        TYA
                        STA    $A5,S
                        STA    $A8,S
                        SHORT  M
                        LDA    #$89
                        STA    $A4,S
                        LDA    #$98
                        STA    $AA,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$01
                        STA    $05,S
                        LDA    $09,S
                        AND    #$F0
                        ORA    #$01
                        STA    $09,S
                        LONG   M
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$9809
                        STA    $04,S
                        SHORT  M
                        LDA    #$88
                        STA    $A9,S
                        LDA    $0A,S
                        AND    #$0F
                        ORA    #$90
                        STA    $0A,S
                        LONG   M
                        TSC
                        ADC    #$0009
                        TCS
                        PHD
                        PHX
                        TSC                              ; Line 15
                        ADC    #$00A3
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
; MARK: BOSS0_005A
BOSS0_005A              ENTRY
                        CLC                              ; 32x16, 467 bytes, 829 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 59
                        LDY    #$9999                    ; Pattern #2 : 24
                        LDA    #$9899                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $08,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$8088
                        STA    $08,S
                        LDA    $AD,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $AD,S
                        SHORT  M
                        LDA    #$99
                        STA    $0E,S
                        LDA    #$88
                        STA    $AA,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$08
                        STA    $03,S
                        LONG   M
                        TSC
                        ADC    #$0007
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 1
                        ADC    #$00A6
                        TCS
                        TYA
                        STA    $A4,S
                        SHORT  M
                        LDA    #$88
                        STA    $98,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A3,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$08
                        STA    $95,S
                        LONG   M
                        PEA    $8898
                        PHY
                        PHY
                        PHY
                        PEA    $9988
                        TSC                              ; Line 3
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$89
                        STA    $A0,S
                        LONG   M
                        PEA    $9989
                        PEA    $8899
                        PEA    $8988
                        PHX
                        PHX
                        PHX
                        PEA    $9989
                        TSC                              ; Line 4
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$98
                        STA    $93,S
                        LONG   M
                        PEA    $8899
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9889
                        TSC                              ; Line 5
                        ADC    #$00AF
                        TCS
                        SHORT  M
                        LDA    #$99
                        STA    $92,S
                        LONG   M
                        PHD
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00AE
                        TCS
                        SHORT  M
                        LDA    $92,S
                        AND    #$F0
                        ORA    #$09
                        STA    $92,S
                        LONG   M
                        PEA    $9889
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AE
                        TCS
                        TXA
                        STA    $9F,S
                        SHORT  M
                        LDA    #$99
                        STA    $93,S
                        LDA    $9E,S
                        AND    #$0F
                        ORA    #$90
                        STA    $9E,S
                        LONG   M
                        PEA    $8898
                        PEA    $9988
                        PHX
                        PHX
                        PHX
                        PHX
                        PHD
                        TSC                              ; Line 8
                        ADC    #$00AB
                        TCS
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $A2,S
                        SHORT  M
                        LDA    #$99
                        STA    $9F,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    #$88
                        STA    $A5,S
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$09
                        STA    $9A,S
                        LONG   M
                        PEA    $1991
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A8
                        TCS
                        LDA    #$1111
                        STA    $9F,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LDA    $9E,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9E,S
                        LONG   M
                        PEA    $9111
                        PHY
                        PHY
                        TSC                              ; Line 12
                        ADC    #$013D
                        TCS
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$9908
                        STA    $A3,S
                        LDA    $A9,S
                        AND    #$0F00
                        ORA    #$8099
                        STA    $A9,S
                        SHORT  M
                        LDA    #$11
                        STA    $07,S
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$10
                        STA    $05,S
                        LDA    $09,S
                        AND    #$0F
                        ORA    #$10
                        STA    $09,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$00A8
                        TCS
                        PEA    $1111
                        PEA    $9199
                        TSC                              ; Line 14
                        ADC    #$00A5
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $9F,S
                        PEA    $1981
                        PHX
                        PEA    $8899
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
; MARK: BOSS0_005B
BOSS0_005B              ENTRY
                        CLC                              ; 32x16, 544 bytes, 964 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 60
                        LDY    #$9999                    ; Pattern #2 : 24
                        LDA    #$8988                    ; Pattern #3 : 3
                        TCD
;--
                        LDA    $0E,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$9009
                        STA    $0E,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $A2,S
                        LDA    $AA,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $AA,S
                        LDA    $AE,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $AE,S
                        TSC
                        ADC    #$0009
                        TCS
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 1
                        ADC    #$00A6
                        TCS
                        LDA    $98,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $98,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $A5,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$09
                        STA    $A4,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A3,S
                        LONG   M
                        PHX
                        PHY
                        PHY
                        PHY
                        PEA    $9989
                        TSC                              ; Line 3
                        ADC    #$00AC
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$9908
                        STA    $92,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$9088
                        STA    $A0,S
                        PEA    $9988
                        PEA    $9899
                        PHX
                        PHX
                        PHX
                        PEA    $8898
                        PEA    $9988
                        TSC                              ; Line 4
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$8809
                        STA    $93,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$8099
                        STA    $A1,S
                        PEA    $9889
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00AC
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9809
                        STA    $93,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$8099
                        STA    $A1,S
                        PHD
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A2,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $93,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A0,S
                        SHORT  M
                        LDA    $9F,S
                        AND    #$F0
                        ORA    #$08
                        STA    $9F,S
                        LONG   M
                        PEA    $8899
                        PHD
                        PHX
                        PHX
                        PHX
                        PHX
                        PHY
                        TSC                              ; Line 8
                        ADC    #$00AC
                        TCS
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $96,S
                        LDA    $9E,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $9E,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A2,S
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A7
                        TCS
                        LDA    $A5,S
                        AND    #$0FF0
                        ORA    #$8008
                        STA    $A5,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
                        PEA    $1199
                        PHY
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        LDA    $9E,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9C,S
                        LONG   M
                        PEA    $1991
                        PHY
                        PHY
                        TSC                              ; Line 12
                        ADC    #$013D
                        TCS
                        LDA    $07,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $07,S
                        SHORT  M
                        LDA    #$89
                        STA    $A4,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$01
                        STA    $05,S
                        LDA    $09,S
                        AND    #$F0
                        ORA    #$01
                        STA    $09,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$00AA
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$9011
                        STA    $9F,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$09
                        STA    $9A,S
                        LONG   M
                        PEA    $9819
                        PEA    $1111
                        PHY
                        TSC                              ; Line 14
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    #$88
                        STA    $A1,S
                        LONG   M
                        PHX
                        PEA    $8898
                        TSC                              ; Line 15
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
; MARK: BOSS0_006A
BOSS0_006A              ENTRY
                        CLC                              ; 32x16, 473 bytes, 840 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 59
                        LDY    #$9999                    ; Pattern #2 : 24
                        LDA    #$9899                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $08,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$8088
                        STA    $08,S
                        LDA    $AD,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $AD,S
                        SHORT  M
                        LDA    #$99
                        STA    $0E,S
                        LDA    #$88
                        STA    $AA,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$08
                        STA    $03,S
                        LONG   M
                        TSC
                        ADC    #$0007
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 1
                        ADC    #$00A6
                        TCS
                        TYA
                        STA    $A4,S
                        SHORT  M
                        LDA    #$88
                        STA    $98,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A3,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$08
                        STA    $95,S
                        LONG   M
                        PEA    $8898
                        PHY
                        PHY
                        PHY
                        PEA    $9988
                        TSC                              ; Line 3
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$89
                        STA    $A0,S
                        LONG   M
                        PEA    $9989
                        PEA    $8899
                        PEA    $8988
                        PHX
                        PHX
                        PHX
                        PEA    $9989
                        TSC                              ; Line 4
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$98
                        STA    $93,S
                        LONG   M
                        PEA    $8899
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9889
                        TSC                              ; Line 5
                        ADC    #$00AF
                        TCS
                        SHORT  M
                        LDA    #$99
                        STA    $92,S
                        LONG   M
                        PHD
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00AE
                        TCS
                        SHORT  M
                        LDA    $92,S
                        AND    #$F0
                        ORA    #$09
                        STA    $92,S
                        LONG   M
                        PEA    $9889
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AE
                        TCS
                        TXA
                        STA    $9F,S
                        SHORT  M
                        LDA    #$99
                        STA    $93,S
                        LDA    $9E,S
                        AND    #$0F
                        ORA    #$90
                        STA    $9E,S
                        LONG   M
                        PEA    $8898
                        PEA    $9988
                        PHX
                        PHX
                        PHX
                        PHX
                        PHD
                        TSC                              ; Line 8
                        ADC    #$00AB
                        TCS
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $A2,S
                        SHORT  M
                        LDA    #$19
                        STA    $9F,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    #$88
                        STA    $A5,S
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$09
                        STA    $9A,S
                        LONG   M
                        PEA    $9191
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A8
                        TCS
                        LDA    #$1111
                        STA    $A0,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9E,S
                        LONG   M
                        PEA    $1119
                        PHY
                        PHY
                        TSC                              ; Line 12
                        ADC    #$013D
                        TCS
                        LDA    $07,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $07,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$9908
                        STA    $A3,S
                        LDA    $A9,S
                        AND    #$0F00
                        ORA    #$9091
                        STA    $A9,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$10
                        STA    $05,S
                        LDA    $09,S
                        AND    #$0F
                        ORA    #$10
                        STA    $09,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$00A8
                        TCS
                        PEA    $1911
                        PEA    $9199
                        TSC                              ; Line 14
                        ADC    #$00A5
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $9F,S
                        PEA    $1911
                        PHX
                        PEA    $8899
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
; MARK: BOSS0_006B
BOSS0_006B              ENTRY
                        CLC                              ; 32x16, 542 bytes, 958 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 59
                        LDY    #$9999                    ; Pattern #2 : 24
                        LDA    #$8899                    ; Pattern #3 : 3
                        TCD
;--
                        LDA    $0E,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$9009
                        STA    $0E,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $A2,S
                        LDA    $AA,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $AA,S
                        LDA    $AE,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $AE,S
                        TSC
                        ADC    #$0009
                        TCS
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 1
                        ADC    #$00A6
                        TCS
                        LDA    $98,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $98,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $A5,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$09
                        STA    $A4,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A3,S
                        LONG   M
                        PHX
                        PHY
                        PHY
                        PHY
                        PEA    $9989
                        TSC                              ; Line 3
                        ADC    #$00AC
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$9908
                        STA    $92,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$9088
                        STA    $A0,S
                        PEA    $9988
                        PEA    $9899
                        PHX
                        PHX
                        PHX
                        PEA    $8898
                        PEA    $9988
                        TSC                              ; Line 4
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$8809
                        STA    $93,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$8099
                        STA    $A1,S
                        PEA    $9889
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00AC
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9809
                        STA    $93,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$8099
                        STA    $A1,S
                        PEA    $8988
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A2,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $93,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A0,S
                        SHORT  M
                        LDA    $9F,S
                        AND    #$F0
                        ORA    #$08
                        STA    $9F,S
                        LONG   M
                        PHD
                        PEA    $8988
                        PHX
                        PHX
                        PHX
                        PHX
                        PHY
                        TSC                              ; Line 8
                        ADC    #$00AC
                        TCS
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $96,S
                        LDA    $9E,S
                        AND    #$0F00
                        ORA    #$9011
                        STA    $9E,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A2,S
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A7
                        TCS
                        LDA    $A5,S
                        AND    #$0FF0
                        ORA    #$8008
                        STA    $A5,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
                        PEA    $1999
                        PHY
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        LDA    $9F,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $9F,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A1,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9C,S
                        LONG   M
                        PEA    $9191
                        PHY
                        PHY
                        TSC                              ; Line 12
                        ADC    #$013D
                        TCS
                        LDA    $07,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $07,S
                        SHORT  M
                        LDA    #$11
                        STA    $09,S
                        LDA    #$89
                        STA    $A4,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$01
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$00AA
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$9809
                        STA    $9A,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A0,S
                        LONG   M
                        PEA    $1999
                        PEA    $1111
                        PHY
                        TSC                              ; Line 14
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$88
                        STA    $A0,S
                        LONG   M
                        PEA    $1181
                        PHX
                        TSC                              ; Line 15
                        ADC    #$00A3
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
; MARK: BOSS0_007A
BOSS0_007A              ENTRY
                        CLC                              ; 32x16, 532 bytes, 935 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 59
                        LDY    #$9999                    ; Pattern #2 : 25
                        LDA    #$8899                    ; Pattern #3 : 5
                        TCD
;--
                        LDA    $08,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$8088
                        STA    $08,S
                        LDA    $AD,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $AD,S
                        SHORT  M
                        LDA    #$99
                        STA    $0E,S
                        LDA    #$88
                        STA    $AA,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$08
                        STA    $03,S
                        LONG   M
                        TSC
                        ADC    #$0007
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 1
                        ADC    #$00A6
                        TCS
                        TYA
                        STA    $A4,S
                        SHORT  M
                        LDA    #$88
                        STA    $98,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A3,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$08
                        STA    $95,S
                        LONG   M
                        PHD
                        PHY
                        PHY
                        PHY
                        PEA    $9988
                        TSC                              ; Line 3
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$89
                        STA    $A0,S
                        LONG   M
                        PEA    $9989
                        PHD
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9989
                        TSC                              ; Line 4
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$98
                        STA    $93,S
                        LONG   M
                        PHD
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9889
                        TSC                              ; Line 5
                        ADC    #$00AF
                        TCS
                        SHORT  M
                        LDA    #$99
                        STA    $92,S
                        LONG   M
                        PEA    $9899
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00AE
                        TCS
                        SHORT  M
                        LDA    $92,S
                        AND    #$F0
                        ORA    #$09
                        STA    $92,S
                        LONG   M
                        PEA    $9889
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AE
                        TCS
                        TXA
                        STA    $9F,S
                        SHORT  M
                        LDA    #$99
                        STA    $93,S
                        LDA    $9E,S
                        AND    #$0F
                        ORA    #$90
                        STA    $9E,S
                        LONG   M
                        PEA    $8898
                        PEA    $9988
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $9899
                        TSC                              ; Line 8
                        ADC    #$00AB
                        TCS
                        LDA    $A1,S
                        AND    #$F0F0
                        ORA    #$0801
                        STA    $A1,S
                        SHORT  M
                        LDA    #$99
                        STA    $97,S
                        LDA    #$88
                        STA    $A3,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A9
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A1,S
                        SHORT  M
                        LDA    #$88
                        STA    $A4,S
                        LDA    $99,S
                        AND    #$F0
                        ORA    #$09
                        STA    $99,S
                        LONG   M
                        PEA    $1919
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A7
                        TCS
                        LDA    $9E,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $9E,S
                        LDA    $A1,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A1,S
                        SHORT  M
                        LDA    #$11
                        STA    $A0,S
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LONG   M
                        PEA    $1119
                        PHY
                        PHY
                        TSC                              ; Line 12
                        ADC    #$013D
                        TCS
                        LDA    #$1111
                        STA    $09,S
                        LDA    $07,S
                        AND    #$F000
                        ORA    #$0111
                        STA    $07,S
                        LDA    $0B,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $0B,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$9908
                        STA    $A3,S
                        LDA    $AB,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $AB,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$10
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$00AA
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A2,S
                        LONG   M
                        PEA    $8119
                        PEA    $1111
                        PEA    $9199
                        TSC                              ; Line 14
                        ADC    #$00A5
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $9F,S
                        PEA    $9189
                        PEA    $8188
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
; MARK: BOSS0_007B
BOSS0_007B              ENTRY
                        CLC                              ; 32x16, 578 bytes, 1010 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8888                    ; Pattern #1 : 58
                        LDY    #$9999                    ; Pattern #2 : 24
                        LDA    #$8988                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $0E,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$9009
                        STA    $0E,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $A2,S
                        LDA    $AA,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $AA,S
                        LDA    $AE,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $AE,S
                        TSC
                        ADC    #$0009
                        TCS
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 1
                        ADC    #$00A6
                        TCS
                        LDA    $98,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $98,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$9099
                        STA    $A5,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$09
                        STA    $A4,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$90
                        STA    $A3,S
                        LONG   M
                        PEA    $8898
                        PHY
                        PHY
                        PHY
                        PEA    $9989
                        TSC                              ; Line 3
                        ADC    #$00AC
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$9908
                        STA    $92,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$9088
                        STA    $A0,S
                        PEA    $9988
                        PEA    $9889
                        PHX
                        PHX
                        PHX
                        PEA    $8898
                        PEA    $9988
                        TSC                              ; Line 4
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$8809
                        STA    $93,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$8099
                        STA    $A1,S
                        PEA    $9889
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00AC
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9809
                        STA    $93,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$8099
                        STA    $A1,S
                        PHD
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A2,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $93,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A0,S
                        SHORT  M
                        LDA    $9F,S
                        AND    #$F0
                        ORA    #$08
                        STA    $9F,S
                        LONG   M
                        PEA    $8899
                        PHD
                        PHX
                        PHX
                        PHX
                        PHX
                        PHY
                        TSC                              ; Line 8
                        ADC    #$00AC
                        TCS
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$9909
                        STA    $96,S
                        LDA    $A1,S
                        AND    #$000F
                        ORA    #$8810
                        STA    $A1,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A3,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A9
                        TCS
                        LDA    $9F,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $9F,S
                        LDA    $A3,S
                        AND    #$0FF0
                        ORA    #$8008
                        STA    $A3,S
                        SHORT  M
                        LDA    #$11
                        STA    $A1,S
                        LONG   M
                        PEA    $9191
                        PEA    $9199
                        PHY
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A0,S
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A2,S
                        SHORT  M
                        LDA    #$11
                        STA    $9F,S
                        LDA    $9C,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9C,S
                        LONG   M
                        PEA    $9191
                        PHY
                        PHY
                        TSC                              ; Line 12
                        ADC    #$013D
                        TCS
                        LDA    #$1111
                        STA    $09,S
                        LDA    $07,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $07,S
                        LDA    $0C,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0C,S
                        SHORT  M
                        LDA    #$11
                        STA    $0B,S
                        LDA    #$89
                        STA    $A4,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$01
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$00AC
                        TCS
                        SHORT  M
                        LDA    $98,S
                        AND    #$F0
                        ORA    #$09
                        STA    $98,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
                        PEA    $1111
                        PEA    $9811
                        PEA    $1111
                        PHY
                        TSC                              ; Line 14
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    #$88
                        STA    $9F,S
                        LONG   M
                        PEA    $1199
                        PEA    $1888
                        PEA    $8898
                        TSC                              ; Line 15
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
; MARK: ENEMY0_000A
ENEMY0_000A             ENTRY
                        CLC                              ; 20x16, 220 bytes, 355 cycles
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
                        LDY    #$CBCC                    ; Pattern #2 : 2
                        LDA    #$CCAC                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        LDA    #$BBBB
                        STA    $05,S
                        LDA    $A6,S
                        AND    #$F0F0
                        ORA    #$0D0B
                        STA    $A6,S
                        SHORT  M
                        LDA    #$BD
                        STA    $07,S
                        LDA    #$CC
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $05,S
                        TXA
                        STA    $A2,S
                        LDA    #$CABC
                        STA    $A6,S
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $01,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $A4,S
                        SHORT  M
                        LDA    #$CD
                        STA    $07,S
                        LDA    #$AA
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $00,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $A1,S
                        LONG   M
                        TSC
                        ADC    #$0007
                        TCS
                        PEA    $AEBC
                        PHX
                        PHD
                        TSC                              ; Line 8
                        ADC    #$00A6
                        TCS
                        TYA
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$F000
                        ORA    #$0ECA
                        STA    $9F,S
                        PEA    $AEAA
                        PEA    $ABAA
                        PHD
                        TSC                              ; Line 10
                        ADC    #$013F
                        TCS
                        LDA    #$AAAA
                        STA    $05,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$AA0A
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
; MARK: ENEMY0_000B
ENEMY0_000B             ENTRY
                        CLC                              ; 20x16, 250 bytes, 400 cycles
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
                        LDY    #$CCAC                    ; Pattern #2 : 2
                        LDA    #$CCBA                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        LDA    $05,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $05,S
                        LDA    $07,S
                        AND    #$0F00
                        ORA    #$D0BB
                        STA    $07,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $A1,S
                        LDA    $A7,S
                        AND    #$0F0F
                        ORA    #$D0B0
                        STA    $A7,S
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $A2,S
                        LDA    #$CCCB
                        STA    $A6,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $01,S
                        LDA    $05,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $05,S
                        LDA    $07,S
                        AND    #$0F00
                        ORA    #$D0BC
                        STA    $07,S
                        LDA    $A4,S
                        AND    #$000F
                        ORA    #$CCC0
                        STA    $A4,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $A1,S
                        LDA    $A8,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A8,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0146
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$E0CA
                        STA    $01,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $A2,S
                        LONG   M
                        PEA    $CBCC
                        PHX
                        PEA    $BABB
                        TSC                              ; Line 8
                        ADC    #$00A7
                        TCS
                        LDA    $A0,S
                        AND    #$0F0F
                        ORA    #$E0A0
                        STA    $A0,S
                        PEA    $AABA
                        PEA    $AACA
                        PEA    $CCAA
                        TSC                              ; Line 9
                        ADC    #$00A5
                        TCS
                        LDA    #$AAAA
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $A0,S
                        PEA    $BCCC
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
; MARK: ENEMY0_001A
ENEMY0_001A             ENTRY
                        CLC                              ; 20x16, 267 bytes, 426 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 5
                        LDY    #$CCCC                    ; Pattern #2 : 2
                        LDA    #$BCBB                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        LDA    #$CCAC
                        STA    $A0,S
                        LDA    $00,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $00,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $A3,S
                        SHORT  M
                        LDA    #$BB
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0145
                        TCS
                        LDA    #$CCAC
                        STA    $9C,S
                        TXA
                        STA    $9F,S
                        SHORT  M
                        LDA    #$AA
                        STA    $9B,S
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9E,S
                        LONG   M
                        PHX
                        PEA    $ABCC
                        PHY
                        TSC                              ; Line 8
                        ADC    #$0145
                        TCS
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $9D,S
                        SHORT  M
                        LDA    #$BB
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $03,S
                        LONG   M
                        PHX
                        PEA    $CCAA
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9C,S
                        LONG   M
                        PEA    $CDBC
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        LDA    #$BBCB
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0BA
                        STA    $9F,S
                        PEA    $CDBC
                        PHX
                        TSC                              ; Line 12
                        ADC    #$013E
                        TCS
                        LDA    #$ABAA
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F0F
                        ORA    #$E0A0
                        STA    $05,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $A3,S
                        SHORT  M
                        LDA    $A5,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$0E
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
; MARK: ENEMY0_001B
ENEMY0_001B             ENTRY
                        CLC                              ; 20x16, 309 bytes, 493 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 6
                        LDY    #$BBAB                    ; Pattern #2 : 2
                        LDA    #$CCAA                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        TXA
                        STA    $A4,S
                        LDA    $04,S
                        AND    #$0FF0
                        ORA    #$B00B
                        STA    $04,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $A0,S
                        SHORT  M
                        LDA    #$CC
                        STA    $01,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $A1,S
                        TXA
                        STA    $A4,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $00,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $06,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $A0,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A3,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A6,S
                        LONG   M
                        TSC
                        ADC    #$0005
                        TCS
                        PHX
                        PEA    $CACC
                        TSC                              ; Line 8
                        ADC    #$013F
                        TCS
                        LDA    $06,S
                        AND    #$F00F
                        ORA    #$0DB0
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$D0CC
                        STA    $A6,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $01,S
                        LONG   M
                        TSC
                        ADC    #$0005
                        TCS
                        PHX
                        PEA    $CBAC
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $A2,S
                        LONG   M
                        PHX
                        PEA    $ABAA
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        LDA    #$AABB
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$BB0C
                        STA    $9D,S
                        PEA    $CCBB
                        PHY
                        TSC                              ; Line 12
                        ADC    #$013E
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $03,S
                        LDA    $05,S
                        AND    #$F000
                        ORA    #$0EBA
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F0F
                        ORA    #$E0A0
                        STA    $A5,S
                        SHORT  M
                        LDA    #$AA
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$E0
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
; MARK: ENEMY0_002A
ENEMY0_002A             ENTRY
                        CLC                              ; 20x16, 304 bytes, 491 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 6
                        LDY    #$BBAB                    ; Pattern #2 : 3
                        LDA    #$CCAC                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$CCBA
                        STA    $A1,S
                        SHORT  M
                        LDA    #$CC
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    #$CCBB
                        STA    $01,S
                        LDA    #$ACAB
                        STA    $A1,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $02,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$B0AB
                        STA    $05,S
                        SHORT  M
                        LDA    #$AA
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        TXA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$F000
                        ORA    #$0BCC
                        STA    $9D,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9C,S
                        LONG   M
                        PHX
                        PEA    $CACC
                        TSC                              ; Line 9
                        ADC    #$013E
                        TCS
                        TXA
                        STA    $04,S
                        STA    $A4,S
                        TYA
                        STA    $A3,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$AC0A
                        STA    $02,S
                        LDA    $A6,S
                        AND    #$FF0F
                        ORA    #$00B0
                        STA    $A6,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $04,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$BB0A
                        STA    $02,S
                        LDA    $06,S
                        AND    #$0F0F
                        ORA    #$D0C0
                        STA    $06,S
                        SHORT  M
                        LDA    #$AB
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A0,S
                        LONG   M
                        PEA    $CDBC
                        PHX
                        TSC                              ; Line 13
                        ADC    #$00A3
                        TCS
                        TYA
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$F00F
                        ORA    #$0EB0
                        STA    $9F,S
                        PEA    $ACBB
                        PHY
                        TSC                              ; Line 15
                        ADC    #$013F
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$BB0A
                        STA    $02,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$E0
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
; MARK: ENEMY0_002B
ENEMY0_002B             ENTRY
                        CLC                              ; 20x16, 345 bytes, 552 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 7
                        LDY    #$ABCC                    ; Pattern #2 : 1
                        LDA    #$CCBA                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$AC0B
                        STA    $A1,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $A2,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$BC0B
                        STA    $01,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $03,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $A4,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $02,S
                        LDA    $04,S
                        AND    #$F00F
                        ORA    #$0AC0
                        STA    $04,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$AC0A
                        STA    $A2,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A6,S
                        SHORT  M
                        LDA    #$BB
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $05,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$C0AC
                        STA    $03,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $07,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        TXA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$BB0A
                        STA    $9D,S
                        PHX
                        PEA    $CBAA
                        TSC                              ; Line 11
                        ADC    #$0144
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$BB0A
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$D0CC
                        STA    $A0,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $01,S
                        LONG   M
                        PEA    $BCBB
                        PEA    $BBAB
                        TSC                              ; Line 13
                        ADC    #$013E
                        TCS
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
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $A6,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $CABA
                        PHX
                        TSC                              ; Line 15
                        ADC    #$013E
                        TCS
                        LDA    $04,S
                        AND    #$F00F
                        ORA    #$0EB0
                        STA    $04,S
                        SHORT  M
                        LDA    #$AB
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
; MARK: ENEMY0_003A
ENEMY0_003A             ENTRY
                        CLC                              ; 20x16, 324 bytes, 536 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 16
                        LDY    #$BBAB                    ; Pattern #2 : 2
                        LDA    #$CCAC                    ; Pattern #3 : 2
                        TCD
;--
                        TDC                              ; Line 0
                        STA    $A2,S
                        LDA    $02,S
                        AND    #$F00F
                        ORA    #$0AA0
                        STA    $02,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $02,S
                        LDA    #$CAAA
                        STA    $A2,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $A4,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $05,S
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$C00A
                        STA    $02,S
                        SHORT  M
                        LDA    #$AA
                        STA    $A2,S
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$CB0A
                        STA    $9B,S
                        PHX
                        PHY
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$BB0A
                        STA    $9A,S
                        PHX
                        PHX
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$BB0A
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$C0BB
                        STA    $9F,S
                        PHX
                        PHX
                        TSC                              ; Line 12
                        ADC    #$0143
                        TCS
                        LDA    #$DDAA
                        STA    $A0,S
                        LDA    $01,S
                        AND    #$0F0F
                        ORA    #$D0C0
                        STA    $01,S
                        LDA    $9E,S
                        AND    #$F000
                        ORA    #$0ABB
                        STA    $9E,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9D,S
                        LONG   M
                        PEA    $ACBB
                        PHX
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0FF0
                        ORA    #$E00E
                        STA    $03,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$E0
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
; MARK: ENEMY0_003B
ENEMY0_003B             ENTRY
                        CLC                              ; 20x16, 347 bytes, 556 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 10
                        LDY    #$BBAB                    ; Pattern #2 : 2
                        LDA    #$CCAA                    ; Pattern #3 : 2
                        TCD
;--
                        TDC                              ; Line 0
                        STA    $A2,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$AC0A
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
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    #$CAAC
                        STA    $03,S
                        LDA    #$CCAC
                        STA    $A3,S
                        SHORT  M
                        LDA    #$CC
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    #$BBCB
                        STA    $05,S
                        TXA
                        STA    $A4,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $A2,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A6,S
                        SHORT  M
                        LDA    #$AC
                        STA    $03,S
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $07,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0145
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A1,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9C,S
                        LONG   M
                        PHX
                        PEA    $BBAC
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A0,S
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A3
                        TCS
                        SHORT  M
                        LDA    #$BC
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHY
                        TSC                              ; Line 11
                        ADC    #$00A4
                        TCS
                        LDA    #$BABB
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $9D,S
                        LDA    $A1,S
                        AND    #$F000
                        ORA    #$0DCC
                        STA    $A1,S
                        PHX
                        PHY
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    #$ADAA
                        STA    $04,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $02,S
                        SHORT  M
                        LDA    #$EE
                        STA    $A4,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 15
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$0E
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
; MARK: ENEMY0_004A
ENEMY0_004A             ENTRY
                        CLC                              ; 20x16, 235 bytes, 405 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 22
                        LDY    #$CAAC                    ; Pattern #2 : 2
                        LDA    #$CCAA                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0CC0
                        STA    $03,S
                        TSC                              ; Line 2
                        ADC    #$00A5
                        TCS
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$CA0A
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $9F,S
                        PEA    $CCCC
                        PHY
                        TSC                              ; Line 4
                        ADC    #$013F
                        TCS
                        TDC
                        STA    $03,S
                        LDA    #$CAAA
                        STA    $A3,S
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $03,S
                        LDA    #$CCAC
                        STA    $A3,S
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        LDA    #$AAAC
                        STA    $01,S
                        LDA    #$ACCC
                        STA    $05,S
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0CA0
                        STA    $03,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $00,S
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $07,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$00A7
                        TCS
                        PEA    $BCBB
                        PHX
                        PHX
                        PEA    $BBAB
                        TSC                              ; Line 10
                        ADC    #$00A8
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00A8
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $99,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $9F,S
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 12
                        ADC    #$00A6
                        TCS
                        TDC
                        STA    $9E,S
                        PHX
                        PHX
                        TSC                              ; Line 14
                        ADC    #$0144
                        TCS
                        PEA    $DDCD
                        PEA    $EAEE
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
; MARK: ENEMY0_004B
ENEMY0_004B             ENTRY
                        CLC                              ; 20x16, 377 bytes, 612 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 20
                        LDY    #$CCAC                    ; Pattern #2 : 2
                        LDA    #$CACC                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        TYA
                        STA    $A4,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $A2,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $05,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$AC0A
                        STA    $A3,S
                        SHORT  M
                        LDA    #$AC
                        STA    $03,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$AC0A
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $A3,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    #$AACA
                        STA    $A2,S
                        TDC
                        STA    $A5,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $03,S
                        SHORT  M
                        LDA    #$AA
                        STA    $A1,S
                        LDA    #$CC
                        STA    $A7,S
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        LDA    $07,S
                        AND    #$0F00
                        ORA    #$C0BB
                        STA    $07,S
                        LDA    $A7,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A7,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A0,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A1,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9A,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    #$BB
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 12
                        ADC    #$00A6
                        TCS
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$AC0A
                        STA    $9D,S
                        SHORT  M
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $9F,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        LDA    #$ACEE
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$D0DD
                        STA    $05,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0E
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
; MARK: ENEMY0_005A
ENEMY0_005A             ENTRY
                        CLC                              ; 20x16, 329 bytes, 543 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 16
                        LDY    #$BABB                    ; Pattern #2 : 2
                        LDA    #$CACC                    ; Pattern #3 : 2
                        TCD
;--
                        TDC                              ; Line 0
                        STA    $A4,S
                        LDA    $04,S
                        AND    #$F00F
                        ORA    #$0AA0
                        STA    $04,S
                        SHORT  M
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $04,S
                        LDA    #$AAAC
                        STA    $A4,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$A0CC
                        STA    $A4,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $04,S
                        AND    #$0FF0
                        ORA    #$A00C
                        STA    $04,S
                        SHORT  M
                        LDA    #$AA
                        STA    $A5,S
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$A0BC
                        STA    $A1,S
                        PHY
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$A0BB
                        STA    $A0,S
                        PHY
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        TXA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$BB0C
                        STA    $9D,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$A0BB
                        STA    $A1,S
                        PHX
                        PHX
                        TSC                              ; Line 12
                        ADC    #$013F
                        TCS
                        LDA    #$AAEE
                        STA    $A2,S
                        LDA    $01,S
                        AND    #$F0F0
                        ORA    #$0C0E
                        STA    $01,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A5,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A4,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PHX
                        PEA    $BBCA
                        TSC                              ; Line 14
                        ADC    #$013E
                        TCS
                        LDA    $03,S
                        AND    #$0FF0
                        ORA    #$D00D
                        STA    $03,S
                        SHORT  M
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
; MARK: ENEMY0_005B
ENEMY0_005B             ENTRY
                        CLC                              ; 20x16, 352 bytes, 563 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 10
                        LDY    #$BABB                    ; Pattern #2 : 2
                        LDA    #$AACC                    ; Pattern #3 : 2
                        TCD
;--
                        TDC                              ; Line 0
                        STA    $A5,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $06,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $05,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$CA0A
                        STA    $A4,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $04,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    #$CAAC
                        STA    $04,S
                        LDA    #$CCCC
                        STA    $A3,S
                        SHORT  M
                        LDA    #$CA
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    #$BCBB
                        STA    $02,S
                        TXA
                        STA    $A3,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $A1,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $A5,S
                        SHORT  M
                        LDA    #$CA
                        STA    $05,S
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $01,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$A0BB
                        STA    $A6,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A1,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $CABB
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A3
                        TCS
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $9D,S
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    #$CB
                        STA    $9C,S
                        LONG   M
                        PHY
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00A4
                        TCS
                        LDA    #$BBAB
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$000F
                        ORA    #$CCE0
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $9F,S
                        PHY
                        PHX
                        TSC                              ; Line 13
                        ADC    #$013D
                        TCS
                        LDA    #$AAEA
                        STA    $03,S
                        LDA    $05,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $05,S
                        SHORT  M
                        LDA    #$DD
                        STA    $A4,S
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 15
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$D0
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
; MARK: ENEMY0_006A
ENEMY0_006A             ENTRY
                        CLC                              ; 20x16, 312 bytes, 500 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 6
                        LDY    #$BABB                    ; Pattern #2 : 3
                        LDA    #$CACC                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$ABCC
                        STA    $A5,S
                        SHORT  M
                        LDA    #$CC
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    #$BBCC
                        STA    $05,S
                        LDA    #$BACA
                        STA    $A5,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $04,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$BA0B
                        STA    $01,S
                        SHORT  M
                        LDA    #$AA
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$A0CC
                        STA    $A0,S
                        SHORT  M
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $9F,S
                        LONG   M
                        PEA    $CCAC
                        PHX
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        TYA
                        STA    $A3,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$A0CA
                        STA    $04,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $A1,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        LDA    $00,S
                        AND    #$F0F0
                        ORA    #$0C0E
                        STA    $00,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$A0BB
                        STA    $04,S
                        SHORT  M
                        LDA    #$BA
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9D,S
                        LONG   M
                        PHX
                        PEA    $CBEC
                        TSC                              ; Line 13
                        ADC    #$00A5
                        TCS
                        TYA
                        STA    $9F,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $9C,S
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9E,S
                        LONG   M
                        PHY
                        PEA    $BBCA
                        TSC                              ; Line 15
                        ADC    #$013F
                        TCS
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$A0BB
                        STA    $04,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$D0
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
; MARK: ENEMY0_006B
ENEMY0_006B             ENTRY
                        CLC                              ; 20x16, 349 bytes, 559 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 7
                        LDY    #$CCBA                    ; Pattern #2 : 1
                        LDA    #$ABCC                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $05,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$00F0
                        ORA    #$CA0C
                        STA    $A5,S
                        SHORT  M
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $A5,S
                        LDA    $05,S
                        AND    #$00F0
                        ORA    #$CB0C
                        STA    $05,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $07,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $A3,S
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0CA0
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$A0CC
                        STA    $05,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $A1,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$A0CA
                        STA    $A5,S
                        SHORT  M
                        LDA    #$BB
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$CA0C
                        STA    $04,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$00A5
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0BB
                        STA    $9F,S
                        PEA    $AABC
                        PHX
                        TSC                              ; Line 11
                        ADC    #$013F
                        TCS
                        TXA
                        STA    $A3,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$CC0E
                        STA    $A1,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$A0BB
                        STA    $A5,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $01,S
                        LONG   M
                        TSC
                        ADC    #$0005
                        TCS
                        PEA    $BABB
                        PEA    $BBCB
                        TSC                              ; Line 13
                        ADC    #$0144
                        TCS
                        TXA
                        STA    $9F,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $01,S
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $9D,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A1,S
                        LONG   M
                        PHX
                        PEA    $ABAC
                        TSC                              ; Line 15
                        ADC    #$013F
                        TCS
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$BA0B
                        STA    $04,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0D
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
; MARK: ENEMY0_007A
ENEMY0_007A             ENTRY
                        CLC                              ; 20x16, 264 bytes, 425 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 6
                        LDY    #$CCCC                    ; Pattern #2 : 2
                        LDA    #$BCBB                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        LDA    #$CACC
                        STA    $A6,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $A2,S
                        SHORT  M
                        LDA    #$BB
                        STA    $03,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0147
                        TCS
                        TXA
                        STA    $9B,S
                        LDA    #$AACA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$000F
                        ORA    #$CCB0
                        STA    $9D,S
                        PHY
                        PEA    $CCBC
                        PHX
                        TSC                              ; Line 8
                        ADC    #$013F
                        TCS
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $A5,S
                        SHORT  M
                        LDA    #$AA
                        STA    $06,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $00,S
                        LONG   M
                        TSC
                        ADC    #$0005
                        TCS
                        PEA    $CCBB
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A3
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A1,S
                        LONG   M
                        PHX
                        PEA    $CBEC
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        TDC
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$AB0A
                        STA    $9D,S
                        PHX
                        PEA    $CBEC
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    #$AABA
                        STA    $03,S
                        LDA    $01,S
                        AND    #$F0F0
                        ORA    #$0A0D
                        STA    $01,S
                        LDA    $A2,S
                        AND    #$000F
                        ORA    #$AAD0
                        STA    $A2,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$D0
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
; MARK: ENEMY0_007B
ENEMY0_007B             ENTRY
                        CLC                              ; 20x16, 309 bytes, 493 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 6
                        LDY    #$BABB                    ; Pattern #2 : 2
                        LDA    #$AACC                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        TXA
                        STA    $A3,S
                        LDA    $03,S
                        AND    #$0FF0
                        ORA    #$B00B
                        STA    $03,S
                        LDA    $A6,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $A6,S
                        SHORT  M
                        LDA    #$CC
                        STA    $07,S
                        LDA    $A8,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A8,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A3,S
                        TDC
                        STA    $A6,S
                        LDA    $07,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $07,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A2,S
                        LDA    $A5,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A5,S
                        LDA    $A8,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A8,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $CCCC
                        PHX
                        TSC                              ; Line 8
                        ADC    #$013E
                        TCS
                        LDA    $01,S
                        AND    #$F00F
                        ORA    #$0BE0
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$CC0E
                        STA    $A1,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $07,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $CABC
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $9B,S
                        LONG   M
                        PEA    $AABA
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A3
                        TCS
                        LDA    #$BBAA
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$C0BB
                        STA    $9F,S
                        PHY
                        PEA    $BBCC
                        TSC                              ; Line 12
                        ADC    #$013F
                        TCS
                        LDA    $02,S
                        AND    #$000F
                        ORA    #$ABD0
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $04,S
                        LDA    $A2,S
                        AND    #$F0F0
                        ORA    #$0A0D
                        STA    $A2,S
                        SHORT  M
                        LDA    #$AA
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0D
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
; MARK: ENEMY0_008A
ENEMY0_008A             ENTRY
                        CLC                              ; 20x16, 219 bytes, 350 cycles
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
                        LDY    #$CCCB                    ; Pattern #2 : 2
                        LDA    #$CACC                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        LDA    #$BBEB
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$0F0F
                        ORA    #$B0E0
                        STA    $A0,S
                        SHORT  M
                        LDA    #$BB
                        STA    $02,S
                        LDA    #$CC
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    #$BCEC
                        STA    $00,S
                        TYA
                        STA    $A1,S
                        LDA    #$AACC
                        STA    $A5,S
                        LDA    $05,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $05,S
                        LDA    $A3,S
                        AND    #$000F
                        ORA    #$CCC0
                        STA    $A3,S
                        SHORT  M
                        LDA    #$CC
                        STA    $02,S
                        LDA    #$AC
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0145
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $01,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A1,S
                        LONG   M
                        PHD
                        PHX
                        PEA    $CBDA
                        TSC                              ; Line 8
                        ADC    #$00A6
                        TCS
                        LDA    #$CCBC
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$000F
                        ORA    #$ACD0
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $9F,S
                        PHD
                        PEA    $AABA
                        PEA    $AADA
                        TSC                              ; Line 10
                        ADC    #$0141
                        TCS
                        LDA    #$AAAA
                        STA    $01,S
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
; MARK: ENEMY0_008B
ENEMY0_008B             ENTRY
                        CLC                              ; 20x16, 251 bytes, 405 cycles
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
                        LDY    #$CCCC                    ; Pattern #2 : 2
                        LDA    #$CCBC                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$BB0E
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $02,S
                        LDA    $A0,S
                        AND    #$F0F0
                        ORA    #$0B0E
                        STA    $A0,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $A6,S
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $A2,S
                        TXA
                        STA    $A5,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$CB0E
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $02,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $06,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $A0,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A4,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$AC0D
                        STA    $00,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $A0,S
                        LONG   M
                        TSC
                        ADC    #$0007
                        TCS
                        PEA    $BBAB
                        PHY
                        PHD
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        LDA    $9A,S
                        AND    #$F0F0
                        ORA    #$0A0D
                        STA    $9A,S
                        PEA    $AACC
                        PEA    $ACAA
                        PEA    $ABAA
                        TSC                              ; Line 9
                        ADC    #$00A5
                        TCS
                        LDA    #$AAAA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $9C,S
                        PEA    $AACA
                        PEA    $CCCB
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
; MARK: ENEMY0_009A
ENEMY0_009A             ENTRY
                        CLC                              ; 20x16, 263 bytes, 426 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 5
                        LDY    #$CCCC                    ; Pattern #2 : 2
                        LDA    #$BCBB                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TXA
                        STA    $A3,S
                        SHORT  M
                        LDA    #$BB
                        STA    $04,S
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $A1,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0144
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$C0BB
                        STA    $A0,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $01,S
                        LONG   M
                        PHX
                        PEA    $CBEC
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$AB0D
                        STA    $00,S
                        LDA    $04,S
                        AND    #$F00F
                        ORA    #$0CB0
                        STA    $04,S
                        LDA    $A0,S
                        AND    #$000F
                        ORA    #$ABD0
                        STA    $A0,S
                        SHORT  M
                        LDA    #$CC
                        STA    $07,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$00A7
                        TCS
                        LDA    $99,S
                        AND    #$F00F
                        ORA    #$0AD0
                        STA    $99,S
                        PHY
                        PEA    $CCBC
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A6
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
                        PEA    $BAAB
                        PEA    $AAAA
                        PHD
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        LDA    $9D,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $9D,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$A00A
                        STA    $A1,S
                        PEA    $AACA
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
; MARK: ENEMY0_009B
ENEMY0_009B             ENTRY
                        CLC                              ; 20x16, 258 bytes, 416 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 8
                        LDY    #$AAAA                    ; Pattern #2 : 4
                        LDA    #$CCCC                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TXA
                        STA    $A4,S
                        LDA    $04,S
                        AND    #$0FF0
                        ORA    #$B00B
                        STA    $04,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$BC
                        STA    $A5,S
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $01,S
                        LONG   M
                        TSC
                        ADC    #$0005
                        TCS
                        PHX
                        PEA    $BBCC
                        TSC                              ; Line 6
                        ADC    #$00A3
                        TCS
                        LDA    $A2,S
                        AND    #$F00F
                        ORA    #$0CC0
                        STA    $A2,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A4,S
                        LONG   M
                        PHX
                        PEA    $CBCC
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        LDA    $9C,S
                        AND    #$F0F0
                        ORA    #$0A0D
                        STA    $9C,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A4,S
                        LONG   M
                        PHX
                        PEA    $BBDA
                        TSC                              ; Line 8
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    $99,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $99,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A1,S
                        LONG   M
                        PHD
                        PEA    $CCBB
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        PEA    $BBAA
                        PEA    $AACA
                        PEA    $BBAB
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $9B,S
                        SHORT  M
                        LDA    #$AA
                        STA    $A0,S
                        LONG   M
                        PHY
                        PEA    $AAAC
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
; MARK: ENEMY0_010A
ENEMY0_010A             ENTRY
                        CLC                              ; 20x16, 281 bytes, 455 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 9
                        LDY    #$BBAB                    ; Pattern #2 : 2
                        LDA    #$BABB                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A3,S
                        AND    #$0FF0
                        ORA    #$B00B
                        STA    $A3,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0144
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $9C,S
                        LONG   M
                        PHX
                        PEA    $CBAC
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $9C,S
                        LONG   M
                        PHX
                        PEA    $BBCC
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0BB
                        STA    $9F,S
                        PHD
                        PHY
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F0F
                        ORA    #$C0B0
                        STA    $03,S
                        SHORT  M
                        LDA    #$CC
                        STA    $A4,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $00,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$00A3
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $A1,S
                        PEA    $CCBB
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        TYA
                        STA    $9D,S
                        SHORT  M
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $9F,S
                        LONG   M
                        PEA    $ACBA
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A7
                        TCS
                        LDA    #$ACAA
                        STA    $9E,S
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $9A,S
                        SHORT  M
                        LDA    #$CC
                        STA    $A0,S
                        LONG   M
                        PEA    $CCCC
                        PEA    $ACAA
                        TSC                              ; Line 12
                        ADC    #$013E
                        TCS
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$C0BB
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$B0CB
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
; MARK: ENEMY0_010B
ENEMY0_010B             ENTRY
                        CLC                              ; 20x16, 323 bytes, 522 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 4
                        LDY    #$BABB                    ; Pattern #2 : 2
                        LDA    #$CCCC                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        SHORT  M
                        LDA    #$BB
                        STA    $A4,S
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $03,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $01,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$F0F0
                        ORA    #$0A0D
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$A0BB
                        STA    $A0,S
                        PHX
                        PEA    $CBDC
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $03,S
                        TXA
                        STA    $A1,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $01,S
                        LDA    $A3,S
                        AND    #$F000
                        ORA    #$0CBB
                        STA    $A3,S
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        LDA    #$BCBB
                        STA    $02,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $00,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $04,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $A0,S
                        TSC                              ; Line 9
                        ADC    #$00A5
                        TCS
                        TYA
                        STA    $9C,S
                        TDC
                        STA    $A0,S
                        LDA    $9E,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $9E,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9B,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A2,S
                        LONG   M
                        PHD
                        PEA    $AABB
                        TSC                              ; Line 11
                        ADC    #$013F
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $01,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $06,S
                        LDA    $A5,S
                        AND    #$00F0
                        ORA    #$BC0B
                        STA    $A5,S
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    $05,S
                        AND    #$00F0
                        ORA    #$BB0C
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
; MARK: ENEMY0_011A
ENEMY0_011A             ENTRY
                        CLC                              ; 20x16, 305 bytes, 498 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 16
                        LDY    #$CCAC                    ; Pattern #2 : 2
                        LDA    #$AABB                    ; Pattern #3 : 2
                        TCD
;--
                        SHORT  M                         ; Line 0
                        LDA    #$EE
                        STA    $03,S
                        LDA    #$AE
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$ACDD
                        STA    $01,S
                        TXA
                        STA    $04,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $03,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $A0,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A0,S
                        PHX
                        PEA    $BBAA
                        TSC                              ; Line 5
                        ADC    #$013F
                        TCS
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$A0BB
                        STA    $05,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $00,S
                        LONG   M
                        TSC
                        ADC    #$0004
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$AA
                        STA    $9F,S
                        LONG   M
                        PHD
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $A1,S
                        PEA    $ACBB
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        TYA
                        STA    $A1,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $9D,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $A0,S
                        LONG   M
                        PEA    $AAAA
                        PEA    $BBAB
                        TSC                              ; Line 11
                        ADC    #$0141
                        TCS
                        LDA    #$CAAA
                        STA    $04,S
                        STA    $A4,S
                        SHORT  M
                        LDA    #$AC
                        STA    $A6,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $04,S
                        SHORT  M
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$A0
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
; MARK: ENEMY0_011B
ENEMY0_011B             ENTRY
                        CLC                              ; 20x16, 353 bytes, 575 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 13
                        LDY    #$BABB                    ; Pattern #2 : 2
                        LDA    #$BBAB                    ; Pattern #3 : 1
                        TCD
;--
                        LDA    $03,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$E00E
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$E00A
                        STA    $A2,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$CCDA
                        STA    $02,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $05,S
                        LDA    $A1,S
                        AND    #$F00F
                        ORA    #$0AD0
                        STA    $A1,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $01,S
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    #$BB
                        STA    $A0,S
                        LONG   M
                        PHX
                        PHD
                        TSC                              ; Line 4
                        ADC    #$00A3
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00A5
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0BA
                        STA    $9F,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9A,S
                        LONG   M
                        PHY
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$A0BA
                        STA    $A0,S
                        PHX
                        PHX
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $02,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $00,S
                        LDA    $04,S
                        AND    #$0F0F
                        ORA    #$C0C0
                        STA    $04,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$BB0A
                        STA    $A0,S
                        TSC                              ; Line 9
                        ADC    #$00A5
                        TCS
                        LDA    #$CCAA
                        STA    $9F,S
                        LDA    $9C,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $9C,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A1,S
                        LONG   M
                        PEA    $CCAC
                        PEA    $AABA
                        TSC                              ; Line 11
                        ADC    #$013F
                        TCS
                        LDA    #$AAAC
                        STA    $05,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$AC0A
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$C0AA
                        STA    $A6,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $04,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $06,S
                        LDA    $A5,S
                        AND    #$F0
                        ORA    #$0A
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
; MARK: ENEMY0_012A
ENEMY0_012A             ENTRY
                        CLC                              ; 20x16, 235 bytes, 405 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 22
                        LDY    #$CCAA                    ; Pattern #2 : 2
                        LDA    #$CAAC                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A5
                        TCS
                        TYA
                        STA    $9E,S
                        PEA    $EECE
                        PEA    $DADD
                        TSC                              ; Line 3
                        ADC    #$013F
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $00,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $06,S
                        TSC
                        ADC    #$0005
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00A6
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00A8
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A8
                        TCS
                        LDA    #$AAAC
                        STA    $9A,S
                        LDA    #$ACCC
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$F00F
                        ORA    #$0CA0
                        STA    $9C,S
                        SHORT  M
                        LDA    $99,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $99,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A0,S
                        LONG   M
                        PEA    $BCBB
                        PHX
                        PHX
                        PEA    $BBAB
                        TSC                              ; Line 8
                        ADC    #$0141
                        TCS
                        LDA    #$CCAC
                        STA    $03,S
                        TDC
                        STA    $A3,S
                        TSC                              ; Line 10
                        ADC    #$0140
                        TCS
                        LDA    #$CAAA
                        STA    $03,S
                        TYA
                        STA    $A3,S
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$CA0A
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $04,S
                        TSC                              ; Line 13
                        ADC    #$00A5
                        TCS
                        LDA    $9E,S
                        AND    #$F00F
                        ORA    #$0CC0
                        STA    $9E,S
                        PEA    $CCCC
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
; MARK: ENEMY0_012B
ENEMY0_012B             ENTRY
                        CLC                              ; 20x16, 371 bytes, 603 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 20
                        LDY    #$CCAC                    ; Pattern #2 : 2
                        LDA    #$CACC                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    #$ACDD
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$E0EE
                        STA    $05,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$AC0A
                        STA    $A3,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $02,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0146
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A1,S
                        SHORT  M
                        LDA    #$BB
                        STA    $01,S
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9A,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00A6
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A1,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9A,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00A6
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$C0BB
                        STA    $A1,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9A,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A6
                        TCS
                        LDA    #$AACA
                        STA    $9C,S
                        TDC
                        STA    $9F,S
                        SHORT  M
                        LDA    #$AA
                        STA    $9B,S
                        LDA    #$CC
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $A3,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 10
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$AC0A
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$AC0A
                        STA    $A3,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $04,S
                        STA    $A4,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$CC0A
                        STA    $A2,S
                        SHORT  M
                        LDA    #$AC
                        STA    $03,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$C0
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
; MARK: ENEMY0_013A
ENEMY0_013A             ENTRY
                        CLC                              ; 20x16, 306 bytes, 501 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 16
                        LDY    #$BBAA                    ; Pattern #2 : 2
                        LDA    #$CACC                    ; Pattern #3 : 2
                        TCD
;--
                        SHORT  M                         ; Line 0
                        LDA    #$DD
                        STA    $04,S
                        LDA    #$DA
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        LDA    #$EECA
                        STA    $05,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $04,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A1,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A0,S
                        PEA    $AABB
                        PHX
                        TSC                              ; Line 5
                        ADC    #$013F
                        TCS
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $06,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $01,S
                        LONG   M
                        TSC
                        ADC    #$0005
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    #$AA
                        STA    $9C,S
                        LONG   M
                        PHX
                        PHX
                        PHY
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$0F
                        ORA    #$C0
                        STA    $9C,S
                        LONG   M
                        PHX
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $9B,S
                        PHX
                        PEA    $BBCA
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        TDC
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $9F,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $9D,S
                        LONG   M
                        PEA    $BABB
                        PEA    $AAAA
                        TSC                              ; Line 11
                        ADC    #$013D
                        TCS
                        LDA    #$AAAC
                        STA    $02,S
                        STA    $A2,S
                        LDA    #$ACCA
                        STA    $A1,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $02,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0A
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
; MARK: ENEMY0_013B
ENEMY0_013B             ENTRY
                        CLC                              ; 20x16, 353 bytes, 575 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 13
                        LDY    #$BBAB                    ; Pattern #2 : 2
                        LDA    #$BABB                    ; Pattern #3 : 1
                        TCD
;--
                        LDA    $04,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$D00D
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$0FF0
                        ORA    #$A00D
                        STA    $A5,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$AECC
                        STA    $05,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $03,S
                        LDA    $A6,S
                        AND    #$F00F
                        ORA    #$0EA0
                        STA    $A6,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $02,S
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $07,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$BB
                        STA    $A1,S
                        LONG   M
                        PHD
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00A6
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$AB0A
                        STA    $9B,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHX
                        PHY
                        TSC                              ; Line 6
                        ADC    #$00A6
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$AB0A
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A0,S
                        PHX
                        PHX
                        TSC                              ; Line 8
                        ADC    #$013D
                        TCS
                        TYA
                        STA    $05,S
                        LDA    $03,S
                        AND    #$F0F0
                        ORA    #$0C0C
                        STA    $03,S
                        LDA    $07,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $07,S
                        LDA    $A7,S
                        AND    #$0F00
                        ORA    #$A0BB
                        STA    $A7,S
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        LDA    #$AACC
                        STA    $9D,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $A0,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $9C,S
                        LONG   M
                        PEA    $ABAA
                        PEA    $CACC
                        TSC                              ; Line 11
                        ADC    #$013E
                        TCS
                        LDA    #$CAAA
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$AA0C
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$A0CA
                        STA    $A3,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $02,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$A0
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
; MARK: ENEMY0_014A
ENEMY0_014A             ENTRY
                        CLC                              ; 20x16, 281 bytes, 455 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 8
                        LDY    #$CACC                    ; Pattern #2 : 2
                        LDA    #$CCCC                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A3,S
                        AND    #$0FF0
                        ORA    #$B00B
                        STA    $A3,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $05,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0146
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $A1,S
                        LONG   M
                        PEA    $CABC
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$0E
                        STA    $A1,S
                        LONG   M
                        PEA    $CCBB
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$BB0A
                        STA    $9D,S
                        PEA    $BABB
                        PEA    $BBAB
                        TSC                              ; Line 7
                        ADC    #$013E
                        TCS
                        TXA
                        STA    $05,S
                        LDA    $03,S
                        AND    #$F0F0
                        ORA    #$0B0C
                        STA    $03,S
                        SHORT  M
                        LDA    #$BB
                        STA    $A7,S
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $07,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$00A6
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $9C,S
                        PHX
                        PHD
                        TSC                              ; Line 9
                        ADC    #$00A5
                        TCS
                        LDA    #$BABB
                        STA    $9F,S
                        SHORT  M
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9E,S
                        LONG   M
                        PHX
                        PEA    $ABCA
                        TSC                              ; Line 10
                        ADC    #$00A1
                        TCS
                        TYA
                        STA    $9D,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $A2,S
                        SHORT  M
                        LDA    #$AA
                        STA    $9F,S
                        LONG   M
                        PEA    $AACA
                        PHD
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$BB0C
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$BC0B
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
; MARK: ENEMY0_014B
ENEMY0_014B             ENTRY
                        CLC                              ; 20x16, 325 bytes, 523 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 4
                        LDY    #$BBAB                    ; Pattern #2 : 2
                        LDA    #$AACC                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        SHORT  M
                        LDA    #$BB
                        STA    $A4,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$A0CC
                        STA    $06,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$00A7
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$BB0A
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F0F
                        ORA    #$E0A0
                        STA    $A0,S
                        PEA    $CEBC
                        PHX
                        TSC                              ; Line 6
                        ADC    #$013D
                        TCS
                        TYA
                        STA    $04,S
                        TXA
                        STA    $A6,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $06,S
                        LDA    $A4,S
                        AND    #$000F
                        ORA    #$BBC0
                        STA    $A4,S
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        LDA    #$BBCB
                        STA    $05,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $03,S
                        LDA    $07,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $07,S
                        LDA    $A7,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A7,S
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        TDC
                        STA    $9D,S
                        TYA
                        STA    $A0,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $9B,S
                        SHORT  M
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $9F,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$A0
                        STA    $A2,S
                        LONG   M
                        PEA    $BBAA
                        PEA    $CCCC
                        TSC                              ; Line 11
                        ADC    #$013E
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$CC0C
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $03,S
                        LDA    $06,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$B0CB
                        STA    $A2,S
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$C0BB
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
; MARK: ENEMY0_015A
ENEMY0_015A             ENTRY
                        CLC                              ; 20x16, 266 bytes, 432 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 5
                        LDY    #$BBCB                    ; Pattern #2 : 2
                        LDA    #$AAAA                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TXA
                        STA    $A3,S
                        SHORT  M
                        LDA    #$BB
                        STA    $03,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A2,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A4,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$BB0C
                        STA    $A2,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$C0CC
                        STA    $A6,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $02,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $CDBC
                        PHX
                        TSC                              ; Line 7
                        ADC    #$013E
                        TCS
                        TXA
                        STA    $04,S
                        LDA    $02,S
                        AND    #$F00F
                        ORA    #$0BC0
                        STA    $02,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$E0BA
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$F000
                        ORA    #$0EBA
                        STA    $A6,S
                        SHORT  M
                        LDA    #$CC
                        STA    $00,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        LDA    $A1,S
                        AND    #$F00F
                        ORA    #$0EA0
                        STA    $A1,S
                        PHX
                        PEA    $CBCC
                        PEA    $CCCC
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $A0,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9B,S
                        LONG   M
                        PHY
                        PHD
                        PEA    $BAAB
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        LDA    $9C,S
                        AND    #$0FF0
                        ORA    #$A00A
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$AA0A
                        STA    $A0,S
                        PEA    $AAAC
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
; MARK: ENEMY0_015B
ENEMY0_015B             ENTRY
                        CLC                              ; 20x16, 253 bytes, 409 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 8
                        LDY    #$AAAA                    ; Pattern #2 : 4
                        LDA    #$CCCC                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TXA
                        STA    $A3,S
                        LDA    $03,S
                        AND    #$0FF0
                        ORA    #$B00B
                        STA    $03,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $06,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A5,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0146
                        TCS
                        SHORT  M
                        LDA    #$CB
                        STA    $9D,S
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$D0
                        STA    $01,S
                        LONG   M
                        PEA    $CCBB
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        LDA    $99,S
                        AND    #$0FF0
                        ORA    #$C00C
                        STA    $99,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $9B,S
                        LONG   M
                        PEA    $CCBC
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        LDA    $A0,S
                        AND    #$0F0F
                        ORA    #$E0A0
                        STA    $A0,S
                        SHORT  M
                        LDA    $99,S
                        AND    #$F0
                        ORA    #$0C
                        STA    $99,S
                        LONG   M
                        PEA    $AEBB
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A3
                        TCS
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$0A
                        STA    $9A,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$E0
                        STA    $A2,S
                        LONG   M
                        PHX
                        PEA    $BBCC
                        PHD
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        PEA    $BABB
                        PEA    $ACAA
                        PEA    $AABB
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$A0AA
                        STA    $9F,S
                        SHORT  M
                        LDA    #$AA
                        STA    $9B,S
                        LONG   M
                        PHY
                        PEA    $CAAA
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
