                        MCOPY  src/sprites/SPRLEVL3.mac

SPRLEVL3                START  LEVL3

                        USING  VARIABLES

; MARK: BOSS3_000A
BOSS3_000A              ENTRY
                        CLC                              ; 32x13, 254 bytes, 460 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 33
                        LDY    #$3333                    ; Pattern #2 : 9
                        LDA    #$33B3                    ; Pattern #3 : 3
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $A0,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A2,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $A0,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $0B,S
                        AND    #$0F00
                        ORA    #$10B1
                        STA    $0B,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $A0,S
                        LDA    $AC,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $AC,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $00,S
                        LONG   M
                        TSC
                        ADC    #$000A
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AB
                        TCS
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $95,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $BB33
                        TSC                              ; Line 8
                        ADC    #$00AD
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A0,S
                        PHX
                        PHX
                        PEA    $BB3B
                        PHY
                        PHY
                        PEA    $B3BB
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AD
                        TCS
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $96,S
                        PHX
                        PEA    $BB3B
                        PHY
                        PHY
                        PHY
                        PHD
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00AF
                        TCS
                        PHX
                        PHD
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
; MARK: BOSS3_000B
BOSS3_000B              ENTRY
                        CLC                              ; 32x13, 201 bytes, 379 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 37
                        LDY    #$3333                    ; Pattern #2 : 11
                        LDA    #$33BB                    ; Pattern #3 : 3
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $00,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A1,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A3,S
                        TSC                              ; Line 6
                        ADC    #$014C
                        TCS
                        SHORT  M
                        LDA    #$33
                        STA    $95,S
                        LONG   M
                        PEA    $11BB
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A2,S
                        LONG   M
                        PEA    $11B1
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $3B33
                        TSC                              ; Line 8
                        ADC    #$00AD
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $92,S
                        PHX
                        PHX
                        PEA    $BB33
                        PHY
                        PHY
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AF
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $9F,S
                        PHX
                        PHX
                        PEA    $BB33
                        PHY
                        PHY
                        PHY
                        PHD
                        TSC                              ; Line 10
                        ADC    #$00AC
                        TCS
                        PEA    $3B33
                        PHX
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
; MARK: BOSS3_001A
BOSS3_001A              ENTRY
                        CLC                              ; 32x13, 306 bytes, 520 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 23
                        LDY    #$11BB                    ; Pattern #2 : 3
                        LDA    #$1111                    ; Pattern #3 : 3
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $A0,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A1,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $00,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$10B1
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A5,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $02,S
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$10
                        STA    $05,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $0B,S
                        AND    #$0F00
                        ORA    #$10B1
                        STA    $0B,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $A0,S
                        LDA    $AC,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $AC,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $00,S
                        LONG   M
                        TSC
                        ADC    #$000A
                        TCS
                        PHX
                        PHX
                        PEA    $B111
                        PHY
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AB
                        TCS
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $95,S
                        LONG   M
                        PHX
                        PHX
                        PEA    $1B11
                        PHY
                        PEA    $B133
                        TSC                              ; Line 8
                        ADC    #$00AD
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A0,S
                        PHX
                        PHX
                        PEA    $BB3B
                        PEA    $1311
                        PEA    $1113
                        PHY
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AD
                        TCS
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$B10B
                        STA    $96,S
                        PHX
                        PEA    $BB3B
                        PEA    $3333
                        PEA    $1313
                        PEA    $1311
                        PEA    $31B3
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00AF
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $96,S
                        LONG   M
                        PHX
                        PEA    $33B3
                        PHX
                        PHX
                        PEA    $BBB1
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
; MARK: BOSS3_001B
BOSS3_001B              ENTRY
                        CLC                              ; 32x13, 252 bytes, 435 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 25
                        LDY    #$11B1                    ; Pattern #2 : 4
                        LDA    #$B1BB                    ; Pattern #3 : 3
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $00,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A1,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $A6,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A6,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$01
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        PEA    $11BB
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00AC
                        TCS
                        SHORT  M
                        LDA    #$33
                        STA    $95,S
                        LONG   M
                        PEA    $11BB
                        PHX
                        PEA    $BB1B
                        PEA    $1B11
                        PHD
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A2,S
                        LONG   M
                        PHY
                        PHX
                        PHX
                        PEA    $1111
                        PEA    $B11B
                        PEA    $3B33
                        TSC                              ; Line 8
                        ADC    #$00AD
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $92,S
                        PHX
                        PHX
                        PEA    $BB33
                        PEA    $1111
                        PEA    $3111
                        PHD
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AF
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $9F,S
                        PHX
                        PHX
                        PEA    $BB33
                        PEA    $3333
                        PEA    $3131
                        PEA    $1111
                        PEA    $33BB
                        TSC                              ; Line 10
                        ADC    #$00AC
                        TCS
                        LDA    $97,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $97,S
                        PEA    $3B33
                        PHX
                        PHX
                        PEA    $BB1B
                        PEA    $1BBB
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
; MARK: BOSS3_002A
BOSS3_002A              ENTRY
                        CLC                              ; 32x13, 322 bytes, 545 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 19
                        LDY    #$1111                    ; Pattern #2 : 4
                        LDA    #$111B                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $A0,S
                        LDA    $A3,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A3,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $00,S
                        LDA    $02,S
                        AND    #$000F
                        ORA    #$11B0
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $A5,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        LDA    $A7,S
                        AND    #$0F00
                        ORA    #$10B1
                        STA    $A7,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $9C,S
                        LONG   M
                        PHD
                        PEA    $11BB
                        TSC                              ; Line 6
                        ADC    #$00AA
                        TCS
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $96,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A2,S
                        PHX
                        PHX
                        PEA    $B111
                        PHY
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AB
                        TCS
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $95,S
                        LONG   M
                        PHX
                        PHX
                        PHY
                        PEA    $1BB1
                        PEA    $1B31
                        TSC                              ; Line 8
                        ADC    #$00AD
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A0,S
                        PHX
                        PHX
                        PEA    $BB3B
                        PEA    $1311
                        PEA    $1131
                        PEA    $13B1
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AD
                        TCS
                        PHX
                        PEA    $BB3B
                        PEA    $3333
                        PEA    $3331
                        PEA    $1331
                        PEA    $11B1
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00AF
                        TCS
                        SHORT  M
                        LDA    $94,S
                        AND    #$F0
                        ORA    #$01
                        STA    $94,S
                        LONG   M
                        PHX
                        PEA    $33B3
                        PHX
                        PHX
                        PEA    $1BBB
                        PEA    $B11B
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
; MARK: BOSS3_002B
BOSS3_002B              ENTRY
                        CLC                              ; 32x13, 280 bytes, 481 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 21
                        LDY    #$11B1                    ; Pattern #2 : 5
                        LDA    #$11BB                    ; Pattern #3 : 4
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $00,S
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$10B0
                        STA    $A2,S
                        SHORT  M
                        LDA    #$BB
                        STA    $A1,S
                        LDA    #$11
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $03,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A6,S
                        SHORT  M
                        LDA    #$11
                        STA    $05,S
                        LDA    #$BB
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$00A5
                        TCS
                        PHY
                        PHY
                        TSC                              ; Line 6
                        ADC    #$00AB
                        TCS
                        SHORT  M
                        LDA    #$33
                        STA    $95,S
                        LONG   M
                        PHD
                        PHX
                        PEA    $BB1B
                        PEA    $1B11
                        PHY
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A2,S
                        LONG   M
                        PHY
                        PHX
                        PEA    $BB1B
                        PHY
                        PHD
                        PEA    $1133
                        TSC                              ; Line 8
                        ADC    #$00AD
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $92,S
                        PHX
                        PHX
                        PEA    $BB33
                        PEA    $1111
                        PEA    $1133
                        PHD
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AF
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $9F,S
                        SHORT  M
                        LDA    $94,S
                        AND    #$F0
                        ORA    #$01
                        STA    $94,S
                        LONG   M
                        PHX
                        PHX
                        PEA    $BB33
                        PEA    $3333
                        PEA    $1333
                        PEA    $1113
                        PHD
                        TSC                              ; Line 10
                        ADC    #$00AC
                        TCS
                        SHORT  M
                        LDA    $96,S
                        AND    #$0F
                        ORA    #$10
                        STA    $96,S
                        LONG   M
                        PEA    $3B33
                        PHX
                        PHX
                        PEA    $BBB1
                        PEA    $1BBB
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
; MARK: BOSS3_003A
BOSS3_003A              ENTRY
                        CLC                              ; 32x13, 376 bytes, 629 cycles
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
                        LDY    #$1111                    ; Pattern #2 : 11
                        LDA    #$11B1                    ; Pattern #3 : 4
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
                        TDC
                        STA    $00,S
                        STA    $A1,S
                        LDA    $02,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $02,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A0,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $A5,S
                        SHORT  M
                        LDA    #$11
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        LDA    $A7,S
                        AND    #$0F00
                        ORA    #$10B1
                        STA    $A7,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9C,S
                        LONG   M
                        PEA    $111B
                        PEA    $111B
                        TSC                              ; Line 6
                        ADC    #$00AA
                        TCS
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $96,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A2,S
                        PHX
                        PHX
                        PEA    $B1B1
                        PHY
                        PEA    $B111
                        TSC                              ; Line 7
                        ADC    #$00AB
                        TCS
                        SHORT  M
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$01
                        STA    $95,S
                        LONG   M
                        PHX
                        PHX
                        PEA    $1B11
                        PHY
                        PEA    $BB31
                        TSC                              ; Line 8
                        ADC    #$00AD
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A0,S
                        PHX
                        PHX
                        PEA    $BB3B
                        PEA    $1311
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $93,S
                        LONG   M
                        PHX
                        PEA    $BB3B
                        PEA    $3333
                        PEA    $3311
                        PEA    $1311
                        PEA    $31B3
                        PEA    $11BB
                        TSC                              ; Line 10
                        ADC    #$00AF
                        TCS
                        LDA    $95,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $95,S
                        SHORT  M
                        LDA    $93,S
                        AND    #$0F
                        ORA    #$10
                        STA    $93,S
                        LONG   M
                        PHX
                        PEA    $33B3
                        PHX
                        PHX
                        PEA    $1BBB
                        PEA    $B111
                        PHY
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $02,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
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
; MARK: BOSS3_003B
BOSS3_003B              ENTRY
                        CLC                              ; 32x13, 350 bytes, 595 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 18
                        LDY    #$1111                    ; Pattern #2 : 13
                        LDA    #$11B1                    ; Pattern #3 : 4
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
                        TYA
                        STA    $01,S
                        LDA    #$11BB
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $A3,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $00,S
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$10
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    #$111B
                        STA    $01,S
                        LDA    $03,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $03,S
                        LDA    $05,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $05,S
                        SHORT  M
                        LDA    #$B1
                        STA    $A1,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$00A5
                        TCS
                        PHD
                        PHD
                        TSC                              ; Line 6
                        ADC    #$00AB
                        TCS
                        SHORT  M
                        LDA    #$33
                        STA    $95,S
                        LONG   M
                        PEA    $11BB
                        PHX
                        PEA    $BB1B
                        PEA    $1B1B
                        PHY
                        PEA    $1B11
                        TSC                              ; Line 7
                        ADC    #$00AD
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A2,S
                        LONG   M
                        PHD
                        PHX
                        PHX
                        PHY
                        PHD
                        PEA    $1B33
                        TSC                              ; Line 8
                        ADC    #$00AD
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$B10B
                        STA    $92,S
                        PHX
                        PHX
                        PEA    $BB33
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00AF
                        TCS
                        LDA    $91,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $91,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $9F,S
                        PHX
                        PHX
                        PEA    $BB33
                        PEA    $3333
                        PEA    $1331
                        PHY
                        PEA    $331B
                        TSC                              ; Line 10
                        ADC    #$00AC
                        TCS
                        LDA    $96,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $96,S
                        SHORT  M
                        LDA    $94,S
                        AND    #$F0
                        ORA    #$01
                        STA    $94,S
                        LONG   M
                        PEA    $3B33
                        PHX
                        PHX
                        PEA    $BBB1
                        PEA    $1B1B
                        PHY
                        TSC                              ; Line 12
                        ADC    #$013F
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $03,S
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$10
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
; MARK: BOSS3_004A
BOSS3_004A              ENTRY
                        CLC                              ; 32x13, 201 bytes, 379 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 37
                        LDY    #$3333                    ; Pattern #2 : 11
                        LDA    #$BB33                    ; Pattern #3 : 3
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $0E,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $0E,S
                        LDA    $AD,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $AD,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $0D,S
                        STA    $AD,S
                        LDA    $AB,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $AB,S
                        TSC                              ; Line 6
                        ADC    #$014E
                        TCS
                        SHORT  M
                        LDA    #$33
                        STA    $A0,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $BB11
                        TSC                              ; Line 7
                        ADC    #$00AB
                        TCS
                        SHORT  M
                        LDA    $93,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $93,S
                        LONG   M
                        PEA    $33B3
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $1B11
                        TSC                              ; Line 8
                        ADC    #$00AD
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A0,S
                        PHX
                        PHX
                        PHY
                        PHY
                        PEA    $33BB
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $93,S
                        PHD
                        PHY
                        PHY
                        PHY
                        PEA    $33BB
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00AC
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        PEA    $33B3
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
; MARK: BOSS3_004B
BOSS3_004B              ENTRY
                        CLC                              ; 32x13, 254 bytes, 460 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 33
                        LDY    #$3333                    ; Pattern #2 : 9
                        LDA    #$3B33                    ; Pattern #3 : 3
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $0E,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $0E,S
                        LDA    $AE,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $AE,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $AC,S
                        LDA    $0D,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $0D,S
                        LDA    $AE,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $AE,S
                        SHORT  M
                        LDA    $0F,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $0F,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$1B01
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A2,S
                        LDA    $AE,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $AE,S
                        SHORT  M
                        LDA    $0F,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $0F,S
                        LONG   M
                        TSC
                        ADC    #$000E
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A2,S
                        LONG   M
                        PEA    $33BB
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00AB
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $92,S
                        PHX
                        PEA    $BB3B
                        PHY
                        PHY
                        PEA    $B3BB
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AF
                        TCS
                        LDA    $9C,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $9C,S
                        PHX
                        PHD
                        PHY
                        PHY
                        PHY
                        PEA    $B3BB
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A9
                        TCS
                        PHX
                        PHX
                        PHX
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
; MARK: BOSS3_005A
BOSS3_005A              ENTRY
                        CLC                              ; 32x13, 252 bytes, 435 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 25
                        LDY    #$1B11                    ; Pattern #2 : 4
                        LDA    #$BB1B                    ; Pattern #3 : 3
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $0E,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $0E,S
                        LDA    $AD,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $AD,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $0D,S
                        LDA    $A8,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A8,S
                        SHORT  M
                        LDA    $0A,S
                        AND    #$0F
                        ORA    #$10
                        STA    $0A,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$00AE
                        TCS
                        PHX
                        PEA    $BB11
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    #$33
                        STA    $A0,S
                        LONG   M
                        PHX
                        PHD
                        PEA    $11B1
                        PEA    $B1BB
                        PHX
                        PEA    $BB11
                        TSC                              ; Line 7
                        ADC    #$00AB
                        TCS
                        SHORT  M
                        LDA    $93,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $93,S
                        LONG   M
                        PEA    $33B3
                        PEA    $B11B
                        PEA    $1111
                        PHX
                        PHX
                        PHY
                        TSC                              ; Line 8
                        ADC    #$00AD
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A0,S
                        PHX
                        PHD
                        PEA    $1113
                        PEA    $1111
                        PEA    $33BB
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $93,S
                        PEA    $BB33
                        PEA    $1111
                        PEA    $1313
                        PEA    $3333
                        PEA    $33BB
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00AC
                        TCS
                        LDA    $9F,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $9F,S
                        PEA    $BBB1
                        PEA    $B1BB
                        PHX
                        PHX
                        PEA    $33B3
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
; MARK: BOSS3_005B
BOSS3_005B              ENTRY
                        CLC                              ; 32x13, 306 bytes, 520 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 23
                        LDY    #$1BBB                    ; Pattern #2 : 3
                        LDA    #$1131                    ; Pattern #3 : 3
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $0E,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $0E,S
                        LDA    $AE,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $AE,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $AD,S
                        LDA    $0D,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $0D,S
                        LDA    $A9,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A9,S
                        LDA    $AB,S
                        AND    #$00F0
                        ORA    #$1B01
                        STA    $AB,S
                        SHORT  M
                        LDA    $0A,S
                        AND    #$F0
                        ORA    #$01
                        STA    $0A,S
                        LDA    $0F,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $0F,S
                        LDA    $AF,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $AF,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$1B01
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A2,S
                        LDA    $AE,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $AE,S
                        SHORT  M
                        LDA    $0F,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $0F,S
                        LONG   M
                        TSC
                        ADC    #$000E
                        TCS
                        PHX
                        PEA    $BB11
                        PEA    $111B
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A2,S
                        LONG   M
                        PEA    $331B
                        PEA    $BB11
                        PEA    $11B1
                        PHX
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00AB
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $92,S
                        PHX
                        PEA    $BB11
                        PEA    $3111
                        PHD
                        PEA    $B3BB
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AF
                        TCS
                        LDA    $9C,S
                        AND    #$0F00
                        ORA    #$B01B
                        STA    $9C,S
                        PHX
                        PEA    $3B13
                        PHD
                        PEA    $3131
                        PEA    $3333
                        PEA    $B3BB
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $A1,S
                        LONG   M
                        PHY
                        PHX
                        PHX
                        PEA    $3B33
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
; MARK: BOSS3_006A
BOSS3_006A              ENTRY
                        CLC                              ; 32x13, 280 bytes, 481 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 21
                        LDY    #$1B11                    ; Pattern #2 : 5
                        LDA    #$BB11                    ; Pattern #3 : 4
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $0E,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $0E,S
                        LDA    $AC,S
                        AND    #$F0F0
                        ORA    #$0B01
                        STA    $AC,S
                        SHORT  M
                        LDA    #$11
                        STA    $AB,S
                        LDA    #$BB
                        STA    $AE,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $0D,S
                        LDA    $0B,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0B,S
                        LDA    $A8,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A8,S
                        SHORT  M
                        LDA    #$11
                        STA    $0A,S
                        LDA    #$BB
                        STA    $AE,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$00AD
                        TCS
                        PHY
                        PHY
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$33
                        STA    $A0,S
                        LONG   M
                        PHX
                        PHY
                        PEA    $11B1
                        PEA    $B1BB
                        PHX
                        PHD
                        TSC                              ; Line 7
                        ADC    #$00AB
                        TCS
                        SHORT  M
                        LDA    $93,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $93,S
                        LONG   M
                        PEA    $3311
                        PHD
                        PHY
                        PEA    $B1BB
                        PHX
                        PHY
                        TSC                              ; Line 8
                        ADC    #$00AD
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A0,S
                        PHX
                        PHD
                        PEA    $3311
                        PEA    $1111
                        PEA    $33BB
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AD
                        TCS
                        LDA    $9E,S
                        AND    #$0F00
                        ORA    #$10BB
                        STA    $9E,S
                        SHORT  M
                        LDA    $93,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $93,S
                        LONG   M
                        PHD
                        PEA    $3111
                        PEA    $3331
                        PEA    $3333
                        PEA    $33BB
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00AB
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A2,S
                        LONG   M
                        PEA    $B11B
                        PHX
                        PHX
                        PEA    $BB33
                        PEA    $B3BB
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
; MARK: BOSS3_006B
BOSS3_006B              ENTRY
                        CLC                              ; 32x13, 322 bytes, 545 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 19
                        LDY    #$1111                    ; Pattern #2 : 4
                        LDA    #$BB11                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $0E,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $0E,S
                        LDA    $AB,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AB,S
                        LDA    $AD,S
                        AND    #$000F
                        ORA    #$BB10
                        STA    $AD,S
                        SHORT  M
                        LDA    $AF,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $AF,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0A,S
                        LDA    $0C,S
                        AND    #$F000
                        ORA    #$0B11
                        STA    $0C,S
                        LDA    $0E,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $0E,S
                        LDA    $A9,S
                        AND    #$F000
                        ORA    #$0111
                        STA    $A9,S
                        SHORT  M
                        LDA    $AF,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $AF,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$00AE
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$1B01
                        STA    $95,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A1,S
                        LONG   M
                        PHD
                        PEA    $B111
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $94,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $A0,S
                        PHX
                        PHY
                        PEA    $111B
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A2,S
                        LONG   M
                        PEA    $13B1
                        PEA    $1BB1
                        PHY
                        PHX
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00AB
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $92,S
                        PHX
                        PEA    $1B31
                        PEA    $1311
                        PEA    $1131
                        PEA    $B3BB
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AF
                        TCS
                        PHX
                        PEA    $1B11
                        PEA    $1331
                        PEA    $1333
                        PEA    $3333
                        PEA    $B3BB
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00AB
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
                        PEA    $B11B
                        PEA    $BBB1
                        PHX
                        PHX
                        PEA    $3B33
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
; MARK: BOSS3_007A
BOSS3_007A              ENTRY
                        CLC                              ; 32x13, 350 bytes, 595 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$BBBB                    ; Pattern #1 : 18
                        LDY    #$1111                    ; Pattern #2 : 13
                        LDA    #$1B11                    ; Pattern #3 : 4
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
                        TYA
                        STA    $0D,S
                        LDA    #$BB11
                        STA    $AD,S
                        LDA    $AB,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $AB,S
                        SHORT  M
                        LDA    $0B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $0B,S
                        LDA    $0F,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $0F,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    #$B111
                        STA    $0D,S
                        LDA    $09,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $09,S
                        LDA    $0B,S
                        AND    #$F000
                        ORA    #$0111
                        STA    $0B,S
                        SHORT  M
                        LDA    #$1B
                        STA    $AE,S
                        LDA    $0F,S
                        AND    #$0F
                        ORA    #$10
                        STA    $0F,S
                        LDA    $A8,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A8,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$00AD
                        TCS
                        PHD
                        PHD
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$33
                        STA    $A0,S
                        LONG   M
                        PEA    $11B1
                        PHY
                        PEA    $B1B1
                        PEA    $B1BB
                        PHX
                        PEA    $BB11
                        TSC                              ; Line 7
                        ADC    #$00AB
                        TCS
                        SHORT  M
                        LDA    $93,S
                        AND    #$F0
                        ORA    #$0B
                        STA    $93,S
                        LONG   M
                        PEA    $33B1
                        PHD
                        PHY
                        PHX
                        PHX
                        PHD
                        TSC                              ; Line 8
                        ADC    #$00AD
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B01B
                        STA    $A0,S
                        PHY
                        PHY
                        PHY
                        PHY
                        PEA    $33BB
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AD
                        TCS
                        LDA    $93,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $93,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A1,S
                        PEA    $B133
                        PHY
                        PEA    $1331
                        PEA    $3333
                        PEA    $33BB
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00AE
                        TCS
                        LDA    $9E,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $9E,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
                        PHY
                        PEA    $B1B1
                        PEA    $1BBB
                        PHX
                        PHX
                        PEA    $33B3
                        TSC                              ; Line 12
                        ADC    #$013F
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $0C,S
                        LDA    $0E,S
                        AND    #$F0
                        ORA    #$01
                        STA    $0E,S
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
; MARK: BOSS3_007B
BOSS3_007B              ENTRY
                        CLC                              ; 32x13, 376 bytes, 629 cycles
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
                        LDY    #$1111                    ; Pattern #2 : 11
                        LDA    #$1B11                    ; Pattern #3 : 4
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
                        TDC
                        STA    $0E,S
                        STA    $AD,S
                        LDA    $0C,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $0C,S
                        SHORT  M
                        LDA    $AB,S
                        AND    #$F0
                        ORA    #$01
                        STA    $AB,S
                        LDA    $AF,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $AF,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $0D,S
                        LDA    $09,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $09,S
                        LDA    $0B,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0B,S
                        LDA    $A9,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $A9,S
                        SHORT  M
                        LDA    #$11
                        STA    $0F,S
                        LDA    $AF,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $AF,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$00AE
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$1B01
                        STA    $95,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
                        PEA    $B111
                        PEA    $B111
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        LDA    $94,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $94,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $A0,S
                        PEA    $111B
                        PHY
                        PEA    $1B1B
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        PEA    $13BB
                        PHY
                        PEA    $11B1
                        PHX
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00AB
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$BB0B
                        STA    $92,S
                        PHY
                        PHY
                        PHY
                        PEA    $1131
                        PEA    $B3BB
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AF
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $A0,S
                        LONG   M
                        PEA    $BB11
                        PEA    $3B13
                        PEA    $1131
                        PEA    $1133
                        PEA    $3333
                        PEA    $B3BB
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00AD
                        TCS
                        LDA    $9D,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $9D,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A0,S
                        LONG   M
                        PHY
                        PEA    $111B
                        PEA    $BBB1
                        PHX
                        PHX
                        PEA    $3B33
                        PHX
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    $0C,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0C,S
                        SHORT  M
                        LDA    $0F,S
                        AND    #$0F
                        ORA    #$10
                        STA    $0F,S
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
; MARK: ENEMY3_000A
ENEMY3_000A             ENTRY
                        CLC                              ; 20x16, 183 bytes, 301 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 3
                        LDY    #$3366                    ; Pattern #2 : 2
                        LDA    #$6636                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$3063
                        STA    $A0,S
                        SHORT  M
                        LDA    #$66
                        STA    $00,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0143
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$3073
                        STA    $A1,S
                        PEA    $7737
                        PHY
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$06
                        STA    $9D,S
                        LONG   M
                        PEA    $7733
                        PEA    $6666
                        TSC                              ; Line 8
                        ADC    #$00A7
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $9A,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$3063
                        STA    $A0,S
                        PHX
                        PEA    $6366
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A5
                        TCS
                        TDC
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $9B,S
                        PHD
                        PHX
                        TSC                              ; Line 11
                        ADC    #$013F
                        TCS
                        LDA    #$7767
                        STA    $02,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$6607
                        STA    $00,S
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
; MARK: ENEMY3_000B
ENEMY3_000B             ENTRY
                        CLC                              ; 20x16, 195 bytes, 321 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 4
                        LDY    #$3363                    ; Pattern #2 : 3
                        LDA    #$3377                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        LDA    $00,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $A0,S
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $03,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $A0,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$06
                        STA    $00,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A2,S
                        LONG   M
                        PHD
                        PEA    $3763
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$33
                        STA    $A1,S
                        LONG   M
                        PHX
                        PEA    $6636
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        TYA
                        STA    $9B,S
                        LDA    $9D,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $9D,S
                        PEA    $6666
                        PHX
                        PHX
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        LDA    #$6676
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$7077
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
; MARK: ENEMY3_001A
ENEMY3_001A             ENTRY
                        CLC                              ; 20x16, 250 bytes, 403 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 7
                        LDY    #$6333                    ; Pattern #2 : 2
                        LDA    #$3363                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$3603
                        STA    $A0,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$60
                        STA    $01,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    #$6633
                        STA    $01,S
                        LDA    #$7737
                        STA    $A2,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $A0,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$03
                        STA    $00,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    #$6633
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $03,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$06
                        STA    $00,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$73
                        STA    $9B,S
                        LONG   M
                        PHX
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A7
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $A0,S
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        LDA    #$6736
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $A0,S
                        SHORT  M
                        LDA    $9E,S
                        AND    #$0F
                        ORA    #$70
                        STA    $9E,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A2,S
                        LONG   M
                        PEA    $6366
                        PEA    $6636
                        PHX
                        TSC                              ; Line 12
                        ADC    #$0141
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$07
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
; MARK: ENEMY3_001B
ENEMY3_001B             ENTRY
                        CLC                              ; 20x16, 238 bytes, 388 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 5
                        LDY    #$3633                    ; Pattern #2 : 2
                        LDA    #$6633                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TDC
                        STA    $A1,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$06
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $01,S
                        LDA    #$3363
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $A3,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$60
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0144
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$3603
                        STA    $9C,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A2,S
                        LONG   M
                        PEA    $7767
                        PEA    $3663
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$3307
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $A1,S
                        PHX
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $9B,S
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        LDA    #$7766
                        STA    $9B,S
                        LDA    $A0,S
                        AND    #$0F0F
                        ORA    #$3060
                        STA    $A0,S
                        SHORT  M
                        LDA    #$66
                        STA    $9F,S
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$03
                        STA    $9A,S
                        LONG   M
                        PHX
                        PEA    $6666
                        PHD
                        TSC                              ; Line 12
                        ADC    #$013F
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$70
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
; MARK: ENEMY3_002A
ENEMY3_002A             ENTRY
                        CLC                              ; 20x16, 288 bytes, 459 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 3
                        LDY    #$3363                    ; Pattern #2 : 3
                        LDA    #$3733                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $A2,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$07
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$6603
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$6063
                        STA    $03,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$3603
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$6063
                        STA    $A3,S
                        TSC                              ; Line 5
                        ADC    #$0144
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$07
                        STA    $9C,S
                        LONG   M
                        PEA    $3763
                        PHY
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$06
                        STA    $9C,S
                        LONG   M
                        PEA    $7337
                        PHY
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$3077
                        STA    $A0,S
                        PEA    $7737
                        PHX
                        TSC                              ; Line 9
                        ADC    #$0144
                        TCS
                        TYA
                        STA    $A0,S
                        SHORT  M
                        LDA    #$33
                        STA    $01,S
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$07
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$F0
                        ORA    #$06
                        STA    $9F,S
                        LONG   M
                        PHX
                        PEA    $6666
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$3063
                        STA    $A5,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$70
                        STA    $02,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$30
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$63
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
; MARK: ENEMY3_002B
ENEMY3_002B             ENTRY
                        CLC                              ; 20x16, 274 bytes, 436 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3363                    ; Pattern #1 : 4
                        LDY    #$3333                    ; Pattern #2 : 3
                        LDA    #$7733                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$3063
                        STA    $A3,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$70
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    #$6636
                        STA    $02,S
                        LDA    #$6633
                        STA    $A2,S
                        SHORT  M
                        LDA    #$36
                        STA    $04,S
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    #$3633
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$7033
                        STA    $04,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$06
                        STA    $01,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A1,S
                        LONG   M
                        PHD
                        PEA    $3376
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    #$73
                        STA    $A1,S
                        LONG   M
                        PHD
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $9D,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $A1,S
                        PEA    $3733
                        PHX
                        TSC                              ; Line 10
                        ADC    #$0140
                        TCS
                        LDA    #$3366
                        STA    $04,S
                        TXA
                        STA    $A5,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$70
                        STA    $02,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$30
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    $05,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $05,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$3006
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
; MARK: ENEMY3_003A
ENEMY3_003A             ENTRY
                        CLC                              ; 20x16, 267 bytes, 432 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3363                    ; Pattern #1 : 5
                        LDY    #$6633                    ; Pattern #2 : 2
                        LDA    #$3366                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        TXA
                        STA    $A3,S
                        SHORT  M
                        LDA    #$66
                        STA    $A5,S
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$30
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0145
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A0,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$60
                        STA    $01,S
                        LONG   M
                        PHY
                        PEA    $6366
                        TSC                              ; Line 4
                        ADC    #$00A3
                        TCS
                        PHX
                        PHD
                        TSC                              ; Line 5
                        ADC    #$00A6
                        TCS
                        TYA
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$6077
                        STA    $9F,S
                        PEA    $6376
                        PEA    $3633
                        PHX
                        TSC                              ; Line 7
                        ADC    #$0145
                        TCS
                        LDA    #$6666
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$3067
                        STA    $A0,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$60
                        STA    $01,S
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$07
                        STA    $9D,S
                        LONG   M
                        PEA    $7736
                        PHD
                        TSC                              ; Line 9
                        ADC    #$013F
                        TCS
                        LDA    $03,S
                        AND    #$000F
                        ORA    #$6670
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $05,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $A4,S
                        SHORT  M
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $A5,S
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$63
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
; MARK: ENEMY3_003B
ENEMY3_003B             ENTRY
                        CLC                              ; 20x16, 282 bytes, 449 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3363                    ; Pattern #1 : 4
                        LDY    #$3633                    ; Pattern #2 : 3
                        LDA    #$6733                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$6036
                        STA    $A5,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$03
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$6306
                        STA    $A1,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$06
                        STA    $02,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $6636
                        PEA    $3366
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$3066
                        STA    $A0,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$06
                        STA    $9B,S
                        LONG   M
                        PEA    $6636
                        PEA    $3336
                        TSC                              ; Line 5
                        ADC    #$00A3
                        TCS
                        SHORT  M
                        LDA    #$76
                        STA    $A1,S
                        LONG   M
                        PHD
                        PEA    $3333
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$06
                        STA    $9D,S
                        LONG   M
                        PEA    $6736
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A5
                        TCS
                        PEA    $7667
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$F0F0
                        ORA    #$0607
                        STA    $9D,S
                        PEA    $7366
                        PEA    $6676
                        TSC                              ; Line 10
                        ADC    #$013E
                        TCS
                        TXA
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $A5,S
                        SHORT  M
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$3063
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$3006
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
; MARK: ENEMY3_004A
ENEMY3_004A             ENTRY
                        CLC                              ; 20x16, 285 bytes, 452 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 3
                        LDY    #$6337                    ; Pattern #2 : 3
                        LDA    #$6666                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $04,S
                        AND    #$F00F
                        ORA    #$0760
                        STA    $04,S
                        SHORT  M
                        LDA    #$63
                        STA    $03,S
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$07
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$00A5
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6036
                        STA    $A0,S
                        PHD
                        PEA    $6363
                        TSC                              ; Line 3
                        ADC    #$00A3
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $A1,S
                        PEA    $6333
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$03
                        STA    $9D,S
                        LONG   M
                        PEA    $3336
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$07
                        STA    $9C,S
                        LONG   M
                        PEA    $3363
                        PEA    $3733
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        TYA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$F0F0
                        ORA    #$0307
                        STA    $9C,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A0,S
                        LONG   M
                        PEA    $3776
                        PEA    $7733
                        TSC                              ; Line 8
                        ADC    #$013F
                        TCS
                        TYA
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $A3,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$06
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 10
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $A3,S
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$03
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$03
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
; MARK: ENEMY3_004B
ENEMY3_004B             ENTRY
                        CLC                              ; 20x16, 287 bytes, 453 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3633                    ; Pattern #1 : 2
                        LDY    #$7633                    ; Pattern #2 : 2
                        LDA    #$6636                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $02,S
                        AND    #$F00F
                        ORA    #$0670
                        STA    $02,S
                        SHORT  M
                        LDA    #$36
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$70
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$00A5
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $9C,S
                        PHD
                        PEA    $3666
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $9B,S
                        PEA    $6633
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A0,S
                        LONG   M
                        PHX
                        PEA    $6333
                        TSC                              ; Line 5
                        ADC    #$00A3
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A1,S
                        LONG   M
                        PEA    $3376
                        PEA    $3333
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        TYA
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F0F
                        ORA    #$7030
                        STA    $A0,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$70
                        STA    $9D,S
                        LONG   M
                        PEA    $6377
                        PEA    $3773
                        TSC                              ; Line 8
                        ADC    #$013F
                        TCS
                        LDA    #$7663
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$3603
                        STA    $A3,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$30
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 10
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$3603
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$3603
                        STA    $A3,S
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$30
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$30
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
; MARK: ENEMY3_005A
ENEMY3_005A             ENTRY
                        CLC                              ; 20x16, 279 bytes, 447 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3633                    ; Pattern #1 : 5
                        LDY    #$3363                    ; Pattern #2 : 2
                        LDA    #$6633                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        TXA
                        STA    $A3,S
                        SHORT  M
                        LDA    #$66
                        STA    $A2,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$03
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $A1,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$06
                        STA    $01,S
                        LONG   M
                        TSC
                        ADC    #$0005
                        TCS
                        PEA    $6636
                        PEA    $3366
                        TSC                              ; Line 4
                        ADC    #$00A5
                        TCS
                        PHD
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        LDA    #$3366
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$7706
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $9F,S
                        PHX
                        PHY
                        PEA    $6736
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    #$6676
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$7066
                        STA    $A4,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$06
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A1,S
                        LONG   M
                        TSC
                        ADC    #$0005
                        TCS
                        PHD
                        PEA    $6377
                        TSC                              ; Line 9
                        ADC    #$013F
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F000
                        ORA    #$0766
                        STA    $03,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $A1,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $A1,S
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$36
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
; MARK: ENEMY3_005B
ENEMY3_005B             ENTRY
                        CLC                              ; 20x16, 275 bytes, 441 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3363                    ; Pattern #1 : 3
                        LDY    #$3633                    ; Pattern #2 : 3
                        LDA    #$7667                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$6306
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $A4,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$30
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0145
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$6036
                        STA    $A1,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$60
                        STA    $01,S
                        LONG   M
                        PEA    $6633
                        PEA    $6366
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $A1,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$03
                        STA    $9C,S
                        LONG   M
                        PEA    $6333
                        PEA    $6366
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    #$36
                        STA    $A1,S
                        LONG   M
                        PEA    $3333
                        PEA    $7666
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHD
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        PHY
                        PHD
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        TYA
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F0F
                        ORA    #$7060
                        STA    $9F,S
                        PEA    $6766
                        PEA    $6637
                        TSC                              ; Line 10
                        ADC    #$013F
                        TCS
                        TYA
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $A1,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$3603
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$6003
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
; MARK: ENEMY3_006A
ENEMY3_006A             ENTRY
                        CLC                              ; 20x16, 273 bytes, 435 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3633                    ; Pattern #1 : 4
                        LDY    #$3333                    ; Pattern #2 : 3
                        LDA    #$3377                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$3603
                        STA    $A3,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$07
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    #$6663
                        STA    $03,S
                        STA    $A3,S
                        SHORT  M
                        LDA    #$63
                        STA    $05,S
                        LDA    #$33
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    #$6333
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $05,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$07
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$07
                        STA    $9C,S
                        LONG   M
                        PEA    $6733
                        PHD
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    #$37
                        STA    $9C,S
                        LONG   M
                        PHX
                        PHD
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $9F,S
                        PHX
                        PEA    $3373
                        TSC                              ; Line 10
                        ADC    #$013E
                        TCS
                        LDA    #$6633
                        STA    $02,S
                        TXA
                        STA    $A1,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$03
                        STA    $01,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$07
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $01,S
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$6003
                        STA    $A0,S
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
; MARK: ENEMY3_006B
ENEMY3_006B             ENTRY
                        CLC                              ; 20x16, 288 bytes, 459 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 4
                        LDY    #$3633                    ; Pattern #2 : 3
                        LDA    #$3373                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $A4,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$70
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$3606
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$3066
                        STA    $05,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$3606
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$3063
                        STA    $A5,S
                        TSC                              ; Line 5
                        ADC    #$0146
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A1,S
                        LONG   M
                        PHY
                        PEA    $3673
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A1,S
                        LONG   M
                        PHY
                        PEA    $7337
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$7703
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $A0,S
                        PHX
                        PEA    $7377
                        TSC                              ; Line 9
                        ADC    #$0143
                        TCS
                        TYA
                        STA    $9D,S
                        SHORT  M
                        LDA    #$66
                        STA    $01,S
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$60
                        STA    $9F,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A1,S
                        LONG   M
                        PEA    $6633
                        PHX
                        TSC                              ; Line 11
                        ADC    #$013F
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$3603
                        STA    $A1,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$60
                        STA    $03,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$07
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$36
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
; MARK: ENEMY3_007A
ENEMY3_007A             ENTRY
                        CLC                              ; 20x16, 250 bytes, 403 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 7
                        LDY    #$3336                    ; Pattern #2 : 2
                        LDA    #$3633                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        LDA    $A5,S
                        AND    #$00F0
                        ORA    #$6306
                        STA    $A5,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$06
                        STA    $06,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    #$3366
                        STA    $05,S
                        LDA    #$7377
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $A6,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$30
                        STA    $07,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    #$3366
                        STA    $05,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $03,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$60
                        STA    $07,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    #$37
                        STA    $A0,S
                        LONG   M
                        PHY
                        PHY
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A5
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $9A,S
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A7
                        TCS
                        LDA    #$6376
                        STA    $9E,S
                        LDA    $99,S
                        AND    #$000F
                        ORA    #$6630
                        STA    $99,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$0F
                        ORA    #$60
                        STA    $9B,S
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$07
                        STA    $9D,S
                        LONG   M
                        PHX
                        PEA    $6366
                        PEA    $6636
                        TSC                              ; Line 12
                        ADC    #$013F
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$70
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
; MARK: ENEMY3_007B
ENEMY3_007B             ENTRY
                        CLC                              ; 20x16, 238 bytes, 388 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 5
                        LDY    #$3363                    ; Pattern #2 : 2
                        LDA    #$3366                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TDC
                        STA    $A6,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$60
                        STA    $07,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $06,S
                        LDA    #$3633
                        STA    $A6,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $A4,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$06
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0147
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$3063
                        STA    $A0,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$03
                        STA    $9B,S
                        LONG   M
                        PEA    $3663
                        PEA    $7677
                        TSC                              ; Line 8
                        ADC    #$00A3
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$7033
                        STA    $A1,S
                        PHY
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $A1,S
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        LDA    #$6677
                        STA    $9F,S
                        LDA    $9A,S
                        AND    #$F0F0
                        ORA    #$0603
                        STA    $9A,S
                        SHORT  M
                        LDA    #$66
                        STA    $9C,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A1,S
                        LONG   M
                        PHD
                        PEA    $6666
                        PHX
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$07
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
; MARK: ENEMY3_008A
ENEMY3_008A             ENTRY
                        CLC                              ; 20x16, 195 bytes, 321 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 4
                        LDY    #$3633                    ; Pattern #2 : 3
                        LDA    #$3673                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $A6,S
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $05,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $03,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A6,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$60
                        STA    $07,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$03
                        STA    $9B,S
                        LONG   M
                        PHD
                        PEA    $7733
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$33
                        STA    $9A,S
                        LONG   M
                        PHY
                        PEA    $6366
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        TYA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $9D,S
                        PHX
                        PHX
                        PEA    $6666
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        LDA    #$6766
                        STA    $05,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$7707
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
; MARK: ENEMY3_008B
ENEMY3_008B             ENTRY
                        CLC                              ; 20x16, 183 bytes, 301 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 3
                        LDY    #$6366                    ; Pattern #2 : 2
                        LDA    #$6633                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        LDA    $A6,S
                        AND    #$00F0
                        ORA    #$3603
                        STA    $A6,S
                        SHORT  M
                        LDA    #$66
                        STA    $07,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0147
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$3703
                        STA    $9B,S
                        PHD
                        PEA    $7377
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A0,S
                        LONG   M
                        PEA    $6666
                        PEA    $3377
                        TSC                              ; Line 8
                        ADC    #$00A3
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$3603
                        STA    $9A,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $A0,S
                        PHX
                        PEA    $6636
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A5
                        TCS
                        TYA
                        STA    $9F,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $A1,S
                        PHX
                        PHY
                        TSC                              ; Line 11
                        ADC    #$013F
                        TCS
                        LDA    #$7677
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$7066
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
; MARK: ENEMY3_009A
ENEMY3_009A             ENTRY
                        CLC                              ; 20x16, 212 bytes, 348 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 4
                        LDY    #$3633                    ; Pattern #2 : 3
                        LDA    #$3363                    ; Pattern #3 : 3
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TXA
                        STA    $00,S
                        TSC                              ; Line 4
                        ADC    #$00A3
                        TCS
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$6306
                        STA    $9D,S
                        PHY
                        PHD
                        TSC                              ; Line 5
                        ADC    #$00A6
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $9C,S
                        PEA    $3376
                        PEA    $7733
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$7063
                        STA    $A0,S
                        PHX
                        PEA    $7737
                        TSC                              ; Line 7
                        ADC    #$00A3
                        TCS
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$06
                        STA    $9D,S
                        LONG   M
                        PEA    $6666
                        PEA    $3366
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        TDC
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $9F,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$07
                        STA    $9C,S
                        LONG   M
                        PEA    $6636
                        PHD
                        TSC                              ; Line 10
                        ADC    #$013E
                        TCS
                        TXA
                        STA    $04,S
                        TYA
                        STA    $A4,S
                        SHORT  M
                        LDA    #$73
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$6703
                        STA    $04,S
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
; MARK: ENEMY3_009B
ENEMY3_009B             ENTRY
                        CLC                              ; 20x16, 239 bytes, 384 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 4
                        LDY    #$3366                    ; Pattern #2 : 2
                        LDA    #$3733                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TXA
                        STA    $A1,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $00,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $A3,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$30
                        STA    $02,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0144
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$3063
                        STA    $01,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $A2,S
                        PEA    $7737
                        PHY
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$6306
                        STA    $9D,S
                        PEA    $7377
                        PEA    $3363
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A0,S
                        LONG   M
                        PEA    $3766
                        PEA    $6636
                        TSC                              ; Line 8
                        ADC    #$00A3
                        TCS
                        PEA    $6633
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$3307
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $9F,S
                        PEA    $3633
                        PEA    $3376
                        TSC                              ; Line 11
                        ADC    #$013E
                        TCS
                        TXA
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$7036
                        STA    $A5,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$60
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
; MARK: ENEMY3_010A
ENEMY3_010A             ENTRY
                        CLC                              ; 20x16, 261 bytes, 417 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 5
                        LDY    #$6633                    ; Pattern #2 : 2
                        LDA    #$3777                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $A0,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$03
                        STA    $00,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    #$3363
                        STA    $A1,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $03,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $01,S
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A1,S
                        LONG   M
                        PEA    $6673
                        PEA    $7763
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        LDA    #$3633
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$3066
                        STA    $A0,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$03
                        STA    $9D,S
                        LONG   M
                        PEA    $3373
                        PEA    $3763
                        TSC                              ; Line 9
                        ADC    #$013F
                        TCS
                        TXA
                        STA    $A3,S
                        LDA    $A1,S
                        AND    #$F0F0
                        ORA    #$0607
                        STA    $A1,S
                        SHORT  M
                        LDA    #$36
                        STA    $A5,S
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$06
                        STA    $02,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $6766
                        PHX
                        TSC                              ; Line 11
                        ADC    #$0143
                        TCS
                        TYA
                        STA    $9E,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$06
                        STA    $9D,S
                        LONG   M
                        PHX
                        PEA    $3376
                        TSC                              ; Line 13
                        ADC    #$013F
                        TCS
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$7066
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
; MARK: ENEMY3_010B
ENEMY3_010B             ENTRY
                        CLC                              ; 20x16, 297 bytes, 475 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 5
                        LDY    #$3763                    ; Pattern #2 : 1
                        LDA    #$7737                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$3063
                        STA    $A1,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$30
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A2,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $01,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$30
                        STA    $03,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $02,S
                        TDC
                        STA    $A3,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$7073
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$6036
                        STA    $A5,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$06
                        STA    $02,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PHX
                        PEA    $7733
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A1,S
                        LONG   M
                        PEA    $6366
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$000F
                        ORA    #$6370
                        STA    $9C,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A0,S
                        LONG   M
                        PEA    $6636
                        PEA    $3363
                        TSC                              ; Line 11
                        ADC    #$013E
                        TCS
                        TXA
                        STA    $04,S
                        LDA    #$3663
                        STA    $A3,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$6307
                        STA    $02,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$30
                        STA    $06,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$6706
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
; MARK: ENEMY3_011A
ENEMY3_011A             ENTRY
                        CLC                              ; 20x16, 308 bytes, 489 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 2
                        LDY    #$3763                    ; Pattern #2 : 1
                        LDA    #$7763                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$3003
                        STA    $A1,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$30
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $A1,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        TYA
                        STA    $A2,S
                        SHORT  M
                        LDA    #$37
                        STA    $A4,S
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$06
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$7073
                        STA    $04,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        LDA    #$7333
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$6607
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $A0,S
                        PEA    $3377
                        PEA    $6766
                        TSC                              ; Line 10
                        ADC    #$013F
                        TCS
                        LDA    #$6633
                        STA    $03,S
                        LDA    #$3633
                        STA    $A3,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$6307
                        STA    $01,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$3063
                        STA    $05,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $A1,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$7063
                        STA    $A5,S
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$6036
                        STA    $04,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $A1,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$06
                        STA    $01,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$70
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
; MARK: ENEMY3_011B
ENEMY3_011B             ENTRY
                        CLC                              ; 20x16, 236 bytes, 379 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3363                    ; Pattern #1 : 4
                        LDY    #$3333                    ; Pattern #2 : 3
                        LDA    #$3763                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        SHORT  M
                        LDA    #$33
                        STA    $A2,S
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$03
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A2,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$3063
                        STA    $02,S
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$7073
                        STA    $A4,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$30
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    #$3777
                        STA    $04,S
                        LDA    #$7766
                        STA    $A3,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$3706
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$F0F0
                        ORA    #$0607
                        STA    $A1,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$3073
                        STA    $A5,S
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$76
                        STA    $02,S
                        LDA    #$33
                        STA    $A6,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PHY
                        PHD
                        TSC                              ; Line 10
                        ADC    #$00A3
                        TCS
                        SHORT  M
                        LDA    #$37
                        STA    $A1,S
                        LONG   M
                        PEA    $6636
                        PEA    $3376
                        TSC                              ; Line 11
                        ADC    #$00A4
                        TCS
                        PEA    $6633
                        PHX
                        TSC                              ; Line 12
                        ADC    #$00A4
                        TCS
                        TDC
                        STA    $9D,S
                        PEA    $6633
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
; MARK: ENEMY3_012A
ENEMY3_012A             ENTRY
                        CLC                              ; 20x16, 287 bytes, 453 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3367                    ; Pattern #1 : 2
                        LDY    #$3363                    ; Pattern #2 : 2
                        LDA    #$7736                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$03
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$3063
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$3063
                        STA    $A3,S
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    #$3667
                        STA    $A3,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$3063
                        STA    $03,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $03,S
                        LDA    $01,S
                        AND    #$F0F0
                        ORA    #$0307
                        STA    $01,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$07
                        STA    $05,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$03
                        STA    $9C,S
                        LONG   M
                        PEA    $3773
                        PHD
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $A0,S
                        PEA    $3333
                        PEA    $6733
                        TSC                              ; Line 10
                        ADC    #$00A3
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $A1,S
                        PEA    $3336
                        PHY
                        TSC                              ; Line 11
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$06
                        STA    $9D,S
                        LONG   M
                        PHY
                        PEA    $3366
                        TSC                              ; Line 12
                        ADC    #$00A5
                        TCS
                        LDA    $9F,S
                        AND    #$F00F
                        ORA    #$0760
                        STA    $9F,S
                        SHORT  M
                        LDA    #$63
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$07
                        STA    $9C,S
                        LONG   M
                        PEA    $6663
                        PEA    $6366
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
; MARK: ENEMY3_012B
ENEMY3_012B             ENTRY
                        CLC                              ; 20x16, 285 bytes, 452 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$7336                    ; Pattern #1 : 3
                        LDY    #$3333                    ; Pattern #2 : 3
                        LDA    #$3377                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$30
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $A3,S
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A3,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $03,S
                        SHORT  M
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F0F
                        ORA    #$7030
                        STA    $05,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$70
                        STA    $02,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A1,S
                        LONG   M
                        PHD
                        PEA    $6773
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $9C,S
                        PEA    $3373
                        PEA    $3633
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$6306
                        STA    $9B,S
                        PHY
                        PEA    $6333
                        TSC                              ; Line 11
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A0,S
                        LONG   M
                        PHY
                        PEA    $3336
                        TSC                              ; Line 12
                        ADC    #$00A3
                        TCS
                        LDA    $9D,S
                        AND    #$F00F
                        ORA    #$0670
                        STA    $9D,S
                        SHORT  M
                        LDA    #$36
                        STA    $9F,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A1,S
                        LONG   M
                        PEA    $3636
                        PEA    $6666
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
; MARK: ENEMY3_013A
ENEMY3_013A             ENTRY
                        CLC                              ; 20x16, 229 bytes, 370 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3633                    ; Pattern #1 : 4
                        LDY    #$3333                    ; Pattern #2 : 3
                        LDA    #$3673                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        SHORT  M
                        LDA    #$33
                        STA    $A5,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$30
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A4,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$3603
                        STA    $04,S
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $04,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$3707
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $A4,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$03
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    #$7773
                        STA    $02,S
                        LDA    #$6677
                        STA    $A3,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$6073
                        STA    $04,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$3703
                        STA    $A1,S
                        LDA    $A5,S
                        AND    #$0F0F
                        ORA    #$7060
                        STA    $A5,S
                        TSC                              ; Line 9
                        ADC    #$0144
                        TCS
                        SHORT  M
                        LDA    #$67
                        STA    $01,S
                        STA    $A1,S
                        LONG   M
                        PHD
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    #$73
                        STA    $9D,S
                        LONG   M
                        PEA    $3363
                        PEA    $6633
                        TSC                              ; Line 11
                        ADC    #$00A5
                        TCS
                        PHX
                        PEA    $3366
                        TSC                              ; Line 12
                        ADC    #$00A4
                        TCS
                        TDC
                        STA    $9F,S
                        PHX
                        PEA    $3366
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
; MARK: ENEMY3_013B
ENEMY3_013B             ENTRY
                        CLC                              ; 20x16, 308 bytes, 489 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 2
                        LDY    #$7373                    ; Pattern #2 : 1
                        LDA    #$3677                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A5,S
                        AND    #$0FF0
                        ORA    #$3003
                        STA    $A5,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$03
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $05,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $A4,S
                        SHORT  M
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $04,S
                        TYA
                        STA    $A3,S
                        SHORT  M
                        LDA    #$36
                        STA    $A5,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$60
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $04,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$3707
                        STA    $02,S
                        SHORT  M
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        LDA    #$3337
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$7066
                        STA    $A0,S
                        PEA    $6676
                        PEA    $7733
                        TSC                              ; Line 10
                        ADC    #$013F
                        TCS
                        LDA    #$3366
                        STA    $03,S
                        LDA    #$3363
                        STA    $A3,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$3603
                        STA    $01,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$7036
                        STA    $05,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$3607
                        STA    $A1,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $A5,S
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $04,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$6306
                        STA    $02,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$3307
                        STA    $A4,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$60
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$60
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
; MARK: ENEMY3_014A
ENEMY3_014A             ENTRY
                        CLC                              ; 20x16, 292 bytes, 468 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 5
                        LDY    #$3673                    ; Pattern #2 : 1
                        LDA    #$7763                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A5,S
                        AND    #$00F0
                        ORA    #$3603
                        STA    $A5,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$03
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A4,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $04,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$30
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $04,S
                        TDC
                        STA    $A2,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$3707
                        STA    $02,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$6073
                        STA    $A4,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0144
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$60
                        STA    $01,S
                        LONG   M
                        PEA    $3377
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$07
                        STA    $9C,S
                        LONG   M
                        PHX
                        PEA    $6636
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$F000
                        ORA    #$0736
                        STA    $A0,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$06
                        STA    $9D,S
                        LONG   M
                        PEA    $3633
                        PEA    $6366
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        LDA    #$3663
                        STA    $A3,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$7036
                        STA    $04,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$03
                        STA    $01,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$6076
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
; MARK: ENEMY3_014B
ENEMY3_014B             ENTRY
                        CLC                              ; 20x16, 256 bytes, 410 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 5
                        LDY    #$3366                    ; Pattern #2 : 2
                        LDA    #$7773                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $A6,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$30
                        STA    $07,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $05,S
                        LDA    #$3633
                        STA    $A5,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $05,S
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$03
                        STA    $9C,S
                        LONG   M
                        PEA    $3677
                        PEA    $3766
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        LDA    #$6366
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $9F,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$03
                        STA    $9C,S
                        LONG   M
                        PEA    $3673
                        PEA    $3733
                        TSC                              ; Line 9
                        ADC    #$0143
                        TCS
                        TXA
                        STA    $9F,S
                        LDA    $A1,S
                        AND    #$0F0F
                        ORA    #$7060
                        STA    $A1,S
                        SHORT  M
                        LDA    #$63
                        STA    $9E,S
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$60
                        STA    $01,S
                        LONG   M
                        PHX
                        PEA    $6676
                        TSC                              ; Line 11
                        ADC    #$0145
                        TCS
                        TYA
                        STA    $9E,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A0,S
                        LONG   M
                        PEA    $6733
                        PHX
                        TSC                              ; Line 13
                        ADC    #$013F
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$6607
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
; MARK: ENEMY3_015A
ENEMY3_015A             ENTRY
                        CLC                              ; 20x16, 244 bytes, 391 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 4
                        LDY    #$6633                    ; Pattern #2 : 2
                        LDA    #$3373                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TXA
                        STA    $A4,S
                        LDA    $05,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $05,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $A6,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$30
                        STA    $07,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$3603
                        STA    $01,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $A0,S
                        TSC
                        ADC    #$0006
                        TCS
                        PHY
                        PEA    $7377
                        TSC                              ; Line 6
                        ADC    #$00A3
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$6036
                        STA    $9F,S
                        PEA    $3633
                        PEA    $7737
                        TSC                              ; Line 7
                        ADC    #$00A2
                        TCS
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$06
                        STA    $9D,S
                        LONG   M
                        PEA    $6366
                        PEA    $6673
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        PHY
                        PEA    $3366
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$7033
                        STA    $9F,S
                        PEA    $6733
                        PEA    $3363
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$6307
                        STA    $A1,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$06
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
; MARK: ENEMY3_015B
ENEMY3_015B             ENTRY
                        CLC                              ; 20x16, 212 bytes, 348 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 4
                        LDY    #$3633                    ; Pattern #2 : 3
                        LDA    #$3363                    ; Pattern #3 : 3
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TXA
                        STA    $06,S
                        TSC                              ; Line 4
                        ADC    #$00A7
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$6036
                        STA    $9F,S
                        PHY
                        PHD
                        TSC                              ; Line 5
                        ADC    #$00A2
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6033
                        STA    $A0,S
                        PEA    $3377
                        PEA    $6733
                        TSC                              ; Line 6
                        ADC    #$00A3
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$3607
                        STA    $9C,S
                        PEA    $7377
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A0,S
                        LONG   M
                        PEA    $6633
                        PEA    $6666
                        TSC                              ; Line 8
                        ADC    #$00A3
                        TCS
                        TYA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$3306
                        STA    $9D,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A1,S
                        LONG   M
                        PHY
                        PEA    $6366
                        TSC                              ; Line 10
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        TDC
                        STA    $A2,S
                        SHORT  M
                        LDA    #$37
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$3076
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

THISISAFORMATTINGLABEL  ANOP
                        END
