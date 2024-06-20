                        MCOPY  src/sprites/SPRTEXT.mac

SPRTEXT                 START  TEXT

                        USING  VARIABLES

; MARK: TXT1_000A
TXT1_000A               ENTRY
                        CLC                             ; 8x8, 133 bytes, 217 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
;--
                        LDA    $01,S                    ; Line 0
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A1,S
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A1,S
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A1,S
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT2_000A
TXT2_000A               ENTRY
                        CLC                             ; 8x8, 143 bytes, 234 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$1111                   ; Pattern #1 : 3
;--
                        TXA                             ; Line 0
                        STA    $01,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A2,S
                        SHORT  M
                        LDA    #$11
                        STA    $A0,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A1,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$10
                        STA    $02,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT3_000A
TXT3_000A               ENTRY
                        CLC                             ; 8x8, 140 bytes, 226 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$1111                   ; Pattern #1 : 2
;--
                        LDA    $00,S                    ; Line 0
                        AND    #$00F0
                        ORA    #$1101
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
                        SHORT  M
                        LDA    #$11
                        STA    $A2,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A1,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A2,S
                        SHORT  M
                        LDA    #$11
                        STA    $A0,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT4_000A
TXT4_000A               ENTRY
                        CLC                             ; 8x8, 120 bytes, 193 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$1111                   ; Pattern #1 : 2
;--
                        TXA                             ; Line 0
                        STA    $A1,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $01,S
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $00,S
                        SHORT  M
                        LDA    #$11
                        STA    $02,S
                        STA    $A0,S
                        STA    $A2,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
                        SHORT  M
                        LDA    #$11
                        STA    $A2,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $02,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT5_000A
TXT5_000A               ENTRY
                        CLC                             ; 8x8, 133 bytes, 215 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$1111                   ; Pattern #1 : 3
;--
                        TXA                             ; Line 0
                        STA    $00,S
                        SHORT  M
                        LDA    #$11
                        STA    $02,S
                        STA    $A0,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $00,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A2,S
                        SHORT  M
                        LDA    #$11
                        STA    $02,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A2,S
                        SHORT  M
                        LDA    #$11
                        STA    $A0,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT1910_000A
TXT1910_000A            ENTRY
                        CLC                             ; 32x8, 400 bytes, 637 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$1111                   ; Pattern #1 : 2
;--
                        TXA                             ; Line 0
                        STA    $05,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        LDA    $09,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $09,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $0D,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A1,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A6,S
                        LDA    $A9,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A9,S
                        SHORT  M
                        LDA    #$11
                        STA    $A4,S
                        STA    $AE,S
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$01
                        STA    $04,S
                        LDA    $AC,S
                        AND    #$F0
                        ORA    #$01
                        STA    $AC,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $06,S
                        LDA    $09,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $09,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A1,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A6,S
                        LDA    $A9,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A9,S
                        LDA    $AE,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AE,S
                        SHORT  M
                        LDA    #$11
                        STA    $04,S
                        STA    $0C,S
                        STA    $AC,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $06,S
                        LDA    $09,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $09,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A1,S
                        LDA    $A9,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A9,S
                        LDA    $AC,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AC,S
                        SHORT  M
                        LDA    #$11
                        STA    $0C,S
                        STA    $A6,S
                        LDA    $AE,S
                        AND    #$F0
                        ORA    #$01
                        STA    $AE,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $05,S
                        LDA    $08,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $08,S
                        LDA    $0A,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $0A,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $0D,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT1910B_000A
TXT1910B_000A           ENTRY
                        CLC                             ; 32x8, 400 bytes, 637 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$6666                   ; Pattern #1 : 2
;--
                        TXA                             ; Line 0
                        STA    $05,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $01,S
                        LDA    $09,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $09,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $0D,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A1,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A6,S
                        LDA    $A9,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A9,S
                        SHORT  M
                        LDA    #$66
                        STA    $A4,S
                        STA    $AE,S
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$06
                        STA    $04,S
                        LDA    $AC,S
                        AND    #$F0
                        ORA    #$06
                        STA    $AC,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $06,S
                        LDA    $09,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $09,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A1,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A6,S
                        LDA    $A9,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A9,S
                        LDA    $AE,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $AE,S
                        SHORT  M
                        LDA    #$66
                        STA    $04,S
                        STA    $0C,S
                        STA    $AC,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $06,S
                        LDA    $09,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $09,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A1,S
                        LDA    $A9,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A9,S
                        LDA    $AC,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $AC,S
                        SHORT  M
                        LDA    #$66
                        STA    $0C,S
                        STA    $A6,S
                        LDA    $AE,S
                        AND    #$F0
                        ORA    #$06
                        STA    $AE,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0660
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $05,S
                        LDA    $08,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $08,S
                        LDA    $0A,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $0A,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $0D,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$06
                        STA    $00,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT1910R_000A
TXT1910R_000A           ENTRY
                        CLC                             ; 32x8, 400 bytes, 637 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$2222                   ; Pattern #1 : 2
;--
                        TXA                             ; Line 0
                        STA    $05,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $01,S
                        LDA    $09,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $09,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $0D,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A1,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A6,S
                        LDA    $A9,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A9,S
                        SHORT  M
                        LDA    #$22
                        STA    $A4,S
                        STA    $AE,S
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$02
                        STA    $04,S
                        LDA    $AC,S
                        AND    #$F0
                        ORA    #$02
                        STA    $AC,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $06,S
                        LDA    $09,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $09,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A1,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A6,S
                        LDA    $A9,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A9,S
                        LDA    $AE,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AE,S
                        SHORT  M
                        LDA    #$22
                        STA    $04,S
                        STA    $0C,S
                        STA    $AC,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $06,S
                        LDA    $09,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $09,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A1,S
                        LDA    $A9,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A9,S
                        LDA    $AC,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AC,S
                        SHORT  M
                        LDA    #$22
                        STA    $0C,S
                        STA    $A6,S
                        LDA    $AE,S
                        AND    #$F0
                        ORA    #$02
                        STA    $AE,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $05,S
                        LDA    $08,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $08,S
                        LDA    $0A,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $0A,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $0D,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$02
                        STA    $00,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT1940_000A
TXT1940_000A            ENTRY
                        CLC                             ; 32x8, 366 bytes, 586 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$1111                   ; Pattern #1 : 5
;--
                        TXA                             ; Line 0
                        STA    $05,S
                        STA    $A9,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        LDA    $09,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $09,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $0D,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A1,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A6,S
                        SHORT  M
                        LDA    #$11
                        STA    $A4,S
                        STA    $AE,S
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$01
                        STA    $04,S
                        LDA    $AC,S
                        AND    #$F0
                        ORA    #$01
                        STA    $AC,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A5,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $06,S
                        LDA    $08,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $08,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A1,S
                        LDA    $A7,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $A7,S
                        LDA    $AE,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AE,S
                        SHORT  M
                        LDA    #$11
                        STA    $04,S
                        STA    $0A,S
                        STA    $0C,S
                        STA    $AA,S
                        STA    $AC,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A4,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $09,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $06,S
                        LDA    $0B,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $0B,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A1,S
                        LDA    $AC,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AC,S
                        SHORT  M
                        LDA    #$11
                        STA    $08,S
                        STA    $A6,S
                        STA    $AA,S
                        LDA    $AE,S
                        AND    #$F0
                        ORA    #$01
                        STA    $AE,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $05,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $0D,S
                        SHORT  M
                        LDA    #$11
                        STA    $0A,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT1940B_000A
TXT1940B_000A           ENTRY
                        CLC                             ; 32x8, 366 bytes, 586 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$6666                   ; Pattern #1 : 5
;--
                        TXA                             ; Line 0
                        STA    $05,S
                        STA    $A9,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $01,S
                        LDA    $09,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $09,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $0D,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A1,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A6,S
                        SHORT  M
                        LDA    #$66
                        STA    $A4,S
                        STA    $AE,S
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$06
                        STA    $04,S
                        LDA    $AC,S
                        AND    #$F0
                        ORA    #$06
                        STA    $AC,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A5,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $06,S
                        LDA    $08,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $08,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A1,S
                        LDA    $A7,S
                        AND    #$000F
                        ORA    #$6660
                        STA    $A7,S
                        LDA    $AE,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $AE,S
                        SHORT  M
                        LDA    #$66
                        STA    $04,S
                        STA    $0A,S
                        STA    $0C,S
                        STA    $AA,S
                        STA    $AC,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A4,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $09,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $06,S
                        LDA    $0B,S
                        AND    #$000F
                        ORA    #$6660
                        STA    $0B,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A1,S
                        LDA    $AC,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $AC,S
                        SHORT  M
                        LDA    #$66
                        STA    $08,S
                        STA    $A6,S
                        STA    $AA,S
                        LDA    $AE,S
                        AND    #$F0
                        ORA    #$06
                        STA    $AE,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0660
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $05,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $0D,S
                        SHORT  M
                        LDA    #$66
                        STA    $0A,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$06
                        STA    $00,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT1940R_000A
TXT1940R_000A           ENTRY
                        CLC                             ; 32x8, 366 bytes, 586 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$2222                   ; Pattern #1 : 5
;--
                        TXA                             ; Line 0
                        STA    $05,S
                        STA    $A9,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $01,S
                        LDA    $09,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $09,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $0D,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A1,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A6,S
                        SHORT  M
                        LDA    #$22
                        STA    $A4,S
                        STA    $AE,S
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$02
                        STA    $04,S
                        LDA    $AC,S
                        AND    #$F0
                        ORA    #$02
                        STA    $AC,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A5,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $06,S
                        LDA    $08,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $08,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A1,S
                        LDA    $A7,S
                        AND    #$000F
                        ORA    #$2220
                        STA    $A7,S
                        LDA    $AE,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AE,S
                        SHORT  M
                        LDA    #$22
                        STA    $04,S
                        STA    $0A,S
                        STA    $0C,S
                        STA    $AA,S
                        STA    $AC,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A4,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $09,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $06,S
                        LDA    $0B,S
                        AND    #$000F
                        ORA    #$2220
                        STA    $0B,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A1,S
                        LDA    $AC,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AC,S
                        SHORT  M
                        LDA    #$22
                        STA    $08,S
                        STA    $A6,S
                        STA    $AA,S
                        LDA    $AE,S
                        AND    #$F0
                        ORA    #$02
                        STA    $AE,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $05,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $0D,S
                        SHORT  M
                        LDA    #$22
                        STA    $0A,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$02
                        STA    $00,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT1970_000A
TXT1970_000A            ENTRY
                        CLC                             ; 32x8, 364 bytes, 579 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$1111                   ; Pattern #1 : 3
;--
                        TXA                             ; Line 0
                        STA    $05,S
                        STA    $08,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        LDA    $0A,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $0A,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $0D,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A1,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A6,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AA,S
                        SHORT  M
                        LDA    #$11
                        STA    $A4,S
                        STA    $A8,S
                        STA    $AE,S
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$01
                        STA    $04,S
                        LDA    $AC,S
                        AND    #$F0
                        ORA    #$01
                        STA    $AC,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $06,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A1,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A6,S
                        LDA    $A9,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A9,S
                        LDA    $AE,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AE,S
                        SHORT  M
                        LDA    #$11
                        STA    $04,S
                        STA    $0A,S
                        STA    $0C,S
                        STA    $AC,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $06,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A1,S
                        LDA    $AC,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AC,S
                        SHORT  M
                        LDA    #$11
                        STA    $09,S
                        STA    $0C,S
                        STA    $A6,S
                        STA    $A9,S
                        LDA    $AE,S
                        AND    #$F0
                        ORA    #$01
                        STA    $AE,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $05,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $0D,S
                        SHORT  M
                        LDA    #$11
                        STA    $09,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT1970B_000A
TXT1970B_000A           ENTRY
                        CLC                             ; 32x8, 364 bytes, 579 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$6666                   ; Pattern #1 : 3
;--
                        TXA                             ; Line 0
                        STA    $05,S
                        STA    $08,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $01,S
                        LDA    $0A,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $0A,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $0D,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A1,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A6,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $AA,S
                        SHORT  M
                        LDA    #$66
                        STA    $A4,S
                        STA    $A8,S
                        STA    $AE,S
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$06
                        STA    $04,S
                        LDA    $AC,S
                        AND    #$F0
                        ORA    #$06
                        STA    $AC,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $06,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A1,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A6,S
                        LDA    $A9,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A9,S
                        LDA    $AE,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $AE,S
                        SHORT  M
                        LDA    #$66
                        STA    $04,S
                        STA    $0A,S
                        STA    $0C,S
                        STA    $AC,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $06,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A1,S
                        LDA    $AC,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $AC,S
                        SHORT  M
                        LDA    #$66
                        STA    $09,S
                        STA    $0C,S
                        STA    $A6,S
                        STA    $A9,S
                        LDA    $AE,S
                        AND    #$F0
                        ORA    #$06
                        STA    $AE,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0660
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $05,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $0D,S
                        SHORT  M
                        LDA    #$66
                        STA    $09,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$06
                        STA    $00,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT1970R_000A
TXT1970R_000A           ENTRY
                        CLC                             ; 32x8, 364 bytes, 579 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$2222                   ; Pattern #1 : 3
;--
                        TXA                             ; Line 0
                        STA    $05,S
                        STA    $08,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $01,S
                        LDA    $0A,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $0A,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $0D,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A1,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A6,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AA,S
                        SHORT  M
                        LDA    #$22
                        STA    $A4,S
                        STA    $A8,S
                        STA    $AE,S
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$02
                        STA    $04,S
                        LDA    $AC,S
                        AND    #$F0
                        ORA    #$02
                        STA    $AC,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $06,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A1,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A6,S
                        LDA    $A9,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A9,S
                        LDA    $AE,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AE,S
                        SHORT  M
                        LDA    #$22
                        STA    $04,S
                        STA    $0A,S
                        STA    $0C,S
                        STA    $AC,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $06,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A1,S
                        LDA    $AC,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AC,S
                        SHORT  M
                        LDA    #$22
                        STA    $09,S
                        STA    $0C,S
                        STA    $A6,S
                        STA    $A9,S
                        LDA    $AE,S
                        AND    #$F0
                        ORA    #$02
                        STA    $AE,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $05,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $0D,S
                        SHORT  M
                        LDA    #$22
                        STA    $09,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$02
                        STA    $00,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT1982_000A
TXT1982_000A            ENTRY
                        CLC                             ; 32x8, 403 bytes, 648 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$1111                   ; Pattern #1 : 7
;--
                        TXA                             ; Line 0
                        STA    $05,S
                        STA    $0D,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        LDA    $08,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $08,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A1,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A6,S
                        LDA    $AE,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AE,S
                        SHORT  M
                        LDA    #$11
                        STA    $A4,S
                        STA    $A8,S
                        STA    $AC,S
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$01
                        STA    $04,S
                        LDA    $0A,S
                        AND    #$0F
                        ORA    #$10
                        STA    $0A,S
                        LDA    $0C,S
                        AND    #$F0
                        ORA    #$01
                        STA    $0C,S
                        LDA    $AA,S
                        AND    #$F0
                        ORA    #$01
                        STA    $AA,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A5,S
                        STA    $AD,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $06,S
                        LDA    $09,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $09,S
                        LDA    $0E,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A1,S
                        LDA    $A7,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $A7,S
                        LDA    $A9,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A9,S
                        SHORT  M
                        LDA    #$11
                        STA    $04,S
                        STA    $08,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A4,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $06,S
                        LDA    $08,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $08,S
                        LDA    $0B,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $0B,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $0D,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A1,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AA,S
                        LDA    $AC,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $AC,S
                        SHORT  M
                        LDA    #$11
                        STA    $0A,S
                        STA    $A6,S
                        LDA    $A8,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A8,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        STA    $09,S
                        STA    $0C,S
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $05,S
                        LDA    $0E,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $0E,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LDA    $08,S
                        AND    #$F0
                        ORA    #$01
                        STA    $08,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT1982B_000A
TXT1982B_000A           ENTRY
                        CLC                             ; 32x8, 403 bytes, 648 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$6666                   ; Pattern #1 : 7
;--
                        TXA                             ; Line 0
                        STA    $05,S
                        STA    $0D,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $01,S
                        LDA    $08,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $08,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A1,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A6,S
                        LDA    $AE,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $AE,S
                        SHORT  M
                        LDA    #$66
                        STA    $A4,S
                        STA    $A8,S
                        STA    $AC,S
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$06
                        STA    $04,S
                        LDA    $0A,S
                        AND    #$0F
                        ORA    #$60
                        STA    $0A,S
                        LDA    $0C,S
                        AND    #$F0
                        ORA    #$06
                        STA    $0C,S
                        LDA    $AA,S
                        AND    #$F0
                        ORA    #$06
                        STA    $AA,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A5,S
                        STA    $AD,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $06,S
                        LDA    $09,S
                        AND    #$F00F
                        ORA    #$0660
                        STA    $09,S
                        LDA    $0E,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A1,S
                        LDA    $A7,S
                        AND    #$F00F
                        ORA    #$0660
                        STA    $A7,S
                        LDA    $A9,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A9,S
                        SHORT  M
                        LDA    #$66
                        STA    $04,S
                        STA    $08,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A4,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $06,S
                        LDA    $08,S
                        AND    #$F00F
                        ORA    #$0660
                        STA    $08,S
                        LDA    $0B,S
                        AND    #$F00F
                        ORA    #$0660
                        STA    $0B,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $0D,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A1,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $AA,S
                        LDA    $AC,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $AC,S
                        SHORT  M
                        LDA    #$66
                        STA    $0A,S
                        STA    $A6,S
                        LDA    $A8,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A8,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        STA    $09,S
                        STA    $0C,S
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0660
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $05,S
                        LDA    $0E,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $0E,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$06
                        STA    $00,S
                        LDA    $08,S
                        AND    #$F0
                        ORA    #$06
                        STA    $08,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT1982R_000A
TXT1982R_000A           ENTRY
                        CLC                             ; 32x8, 403 bytes, 648 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$2222                   ; Pattern #1 : 7
;--
                        TXA                             ; Line 0
                        STA    $05,S
                        STA    $0D,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $01,S
                        LDA    $08,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $08,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A1,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A6,S
                        LDA    $AE,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AE,S
                        SHORT  M
                        LDA    #$22
                        STA    $A4,S
                        STA    $A8,S
                        STA    $AC,S
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$02
                        STA    $04,S
                        LDA    $0A,S
                        AND    #$0F
                        ORA    #$20
                        STA    $0A,S
                        LDA    $0C,S
                        AND    #$F0
                        ORA    #$02
                        STA    $0C,S
                        LDA    $AA,S
                        AND    #$F0
                        ORA    #$02
                        STA    $AA,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A5,S
                        STA    $AD,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $06,S
                        LDA    $09,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $09,S
                        LDA    $0E,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $0E,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A1,S
                        LDA    $A7,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A7,S
                        LDA    $A9,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A9,S
                        SHORT  M
                        LDA    #$22
                        STA    $04,S
                        STA    $08,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A4,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $06,S
                        LDA    $08,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $08,S
                        LDA    $0B,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $0B,S
                        LDA    $0D,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $0D,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A1,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AA,S
                        LDA    $AC,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $AC,S
                        SHORT  M
                        LDA    #$22
                        STA    $0A,S
                        STA    $A6,S
                        LDA    $A8,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A8,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        STA    $09,S
                        STA    $0C,S
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $05,S
                        LDA    $0E,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $0E,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$02
                        STA    $00,S
                        LDA    $08,S
                        AND    #$F0
                        ORA    #$02
                        STA    $08,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT2001_000A
TXT2001_000A            ENTRY
                        CLC                             ; 32x8, 399 bytes, 636 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$1111                   ; Pattern #1 : 3
;--
                        TXA                             ; Line 0
                        STA    $01,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $05,S
                        LDA    $09,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $09,S
                        LDA    $0D,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0D,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A2,S
                        LDA    $AD,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $AD,S
                        SHORT  M
                        LDA    #$11
                        STA    $A0,S
                        STA    $A6,S
                        STA    $AA,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A4,S
                        LDA    $A8,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A8,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A1,S
                        LDA    $03,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $03,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $06,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0A,S
                        LDA    $0D,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0D,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A6,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AA,S
                        LDA    $AD,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AD,S
                        SHORT  M
                        LDA    #$11
                        STA    $02,S
                        STA    $08,S
                        STA    $A4,S
                        STA    $A8,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $00,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $06,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0A,S
                        LDA    $0D,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0D,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        LDA    $A4,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A4,S
                        LDA    $A8,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A8,S
                        LDA    $AD,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AD,S
                        SHORT  M
                        LDA    #$11
                        STA    $04,S
                        STA    $08,S
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$10
                        STA    $02,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A6,S
                        LDA    $AA,S
                        AND    #$F0
                        ORA    #$01
                        STA    $AA,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $05,S
                        LDA    $09,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $09,S
                        LDA    $0C,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $0C,S
                        LDA    $0E,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $0E,S
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT2001B_000A
TXT2001B_000A           ENTRY
                        CLC                             ; 32x8, 399 bytes, 636 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$6666                   ; Pattern #1 : 3
;--
                        TXA                             ; Line 0
                        STA    $01,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $05,S
                        LDA    $09,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $09,S
                        LDA    $0D,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $0D,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A2,S
                        LDA    $AD,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $AD,S
                        SHORT  M
                        LDA    #$66
                        STA    $A0,S
                        STA    $A6,S
                        STA    $AA,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$06
                        STA    $00,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A4,S
                        LDA    $A8,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A8,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A1,S
                        LDA    $03,S
                        AND    #$000F
                        ORA    #$6660
                        STA    $03,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $06,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $0A,S
                        LDA    $0D,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $0D,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A6,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $AA,S
                        LDA    $AD,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $AD,S
                        SHORT  M
                        LDA    #$66
                        STA    $02,S
                        STA    $08,S
                        STA    $A4,S
                        STA    $A8,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $00,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $06,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $0A,S
                        LDA    $0D,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $0D,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A0,S
                        LDA    $A4,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A4,S
                        LDA    $A8,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A8,S
                        LDA    $AD,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $AD,S
                        SHORT  M
                        LDA    #$66
                        STA    $04,S
                        STA    $08,S
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$60
                        STA    $02,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A6,S
                        LDA    $AA,S
                        AND    #$F0
                        ORA    #$06
                        STA    $AA,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $02,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $05,S
                        LDA    $09,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $09,S
                        LDA    $0C,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $0C,S
                        LDA    $0E,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $0E,S
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXT2001R_000A
TXT2001R_000A           ENTRY
                        CLC                             ; 32x8, 399 bytes, 636 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$2222                   ; Pattern #1 : 3
;--
                        TXA                             ; Line 0
                        STA    $01,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $05,S
                        LDA    $09,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $09,S
                        LDA    $0D,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0D,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A2,S
                        LDA    $AD,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $AD,S
                        SHORT  M
                        LDA    #$22
                        STA    $A0,S
                        STA    $A6,S
                        STA    $AA,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$02
                        STA    $00,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A4,S
                        LDA    $A8,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A8,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A1,S
                        LDA    $03,S
                        AND    #$000F
                        ORA    #$2220
                        STA    $03,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $06,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0A,S
                        LDA    $0D,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0D,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A6,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AA,S
                        LDA    $AD,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AD,S
                        SHORT  M
                        LDA    #$22
                        STA    $02,S
                        STA    $08,S
                        STA    $A4,S
                        STA    $A8,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $00,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $06,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0A,S
                        LDA    $0D,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0D,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A0,S
                        LDA    $A4,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A4,S
                        LDA    $A8,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A8,S
                        LDA    $AD,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AD,S
                        SHORT  M
                        LDA    #$22
                        STA    $04,S
                        STA    $08,S
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$20
                        STA    $02,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A6,S
                        LDA    $AA,S
                        AND    #$F0
                        ORA    #$02
                        STA    $AA,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $02,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $05,S
                        LDA    $09,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $09,S
                        LDA    $0C,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $0C,S
                        LDA    $0E,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $0E,S
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXTAD_000A
TXTAD_000A              ENTRY
                        CLC                             ; 32x8, 269 bytes, 429 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$1111                   ; Pattern #1 : 3
;--
                        TXA                             ; Line 0
                        STA    $08,S
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $01,S
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A0,S
                        SHORT  M
                        LDA    #$11
                        STA    $A2,S
                        STA    $A8,S
                        STA    $AA,S
                        LDA    $0A,S
                        AND    #$0F
                        ORA    #$10
                        STA    $0A,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $02,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0A,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A2,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AA,S
                        SHORT  M
                        LDA    #$11
                        STA    $00,S
                        STA    $08,S
                        STA    $A0,S
                        STA    $A8,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0A,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A2,S
                        LDA    $A5,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A5,S
                        LDA    $AD,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AD,S
                        SHORT  M
                        LDA    #$11
                        STA    $08,S
                        STA    $A0,S
                        STA    $A8,S
                        STA    $AA,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $08,S
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $02,S
                        LDA    $05,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $05,S
                        LDA    $0D,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0D,S
                        SHORT  M
                        LDA    #$11
                        STA    $00,S
                        LDA    $0A,S
                        AND    #$0F
                        ORA    #$10
                        STA    $0A,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXTADB_000A
TXTADB_000A             ENTRY
                        CLC                             ; 32x8, 269 bytes, 429 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$6666                   ; Pattern #1 : 3
;--
                        TXA                             ; Line 0
                        STA    $08,S
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $01,S
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A0,S
                        SHORT  M
                        LDA    #$66
                        STA    $A2,S
                        STA    $A8,S
                        STA    $AA,S
                        LDA    $0A,S
                        AND    #$0F
                        ORA    #$60
                        STA    $0A,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $02,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $0A,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A2,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $AA,S
                        SHORT  M
                        LDA    #$66
                        STA    $00,S
                        STA    $08,S
                        STA    $A0,S
                        STA    $A8,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $02,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $0A,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A2,S
                        LDA    $A5,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A5,S
                        LDA    $AD,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $AD,S
                        SHORT  M
                        LDA    #$66
                        STA    $08,S
                        STA    $A0,S
                        STA    $A8,S
                        STA    $AA,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $08,S
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $02,S
                        LDA    $05,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $05,S
                        LDA    $0D,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $0D,S
                        SHORT  M
                        LDA    #$66
                        STA    $00,S
                        LDA    $0A,S
                        AND    #$0F
                        ORA    #$60
                        STA    $0A,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXTADR_000A
TXTADR_000A             ENTRY
                        CLC                             ; 32x8, 269 bytes, 429 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$2222                   ; Pattern #1 : 3
;--
                        TXA                             ; Line 0
                        STA    $08,S
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $01,S
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A0,S
                        SHORT  M
                        LDA    #$22
                        STA    $A2,S
                        STA    $A8,S
                        STA    $AA,S
                        LDA    $0A,S
                        AND    #$0F
                        ORA    #$20
                        STA    $0A,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $02,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0A,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A2,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AA,S
                        SHORT  M
                        LDA    #$22
                        STA    $00,S
                        STA    $08,S
                        STA    $A0,S
                        STA    $A8,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $02,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0A,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A2,S
                        LDA    $A5,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A5,S
                        LDA    $AD,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AD,S
                        SHORT  M
                        LDA    #$22
                        STA    $08,S
                        STA    $A0,S
                        STA    $A8,S
                        STA    $AA,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $08,S
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $02,S
                        LDA    $05,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $05,S
                        LDA    $0D,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0D,S
                        SHORT  M
                        LDA    #$22
                        STA    $00,S
                        LDA    $0A,S
                        AND    #$0F
                        ORA    #$20
                        STA    $0A,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXTPAUSE_000A
TXTPAUSE_000A           ENTRY
                        CLC                             ; 40x8, 398 bytes, 642 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$2222                   ; Pattern #1 : 9
;--
                        TXA                             ; Line 0
                        STA    $00,S
                        STA    $10,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $05,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0A,S
                        LDA    $0C,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $0C,S
                        LDA    $12,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $12,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A4,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AA,S
                        SHORT  M
                        LDA    #$22
                        STA    $02,S
                        STA    $08,S
                        STA    $A0,S
                        STA    $A6,S
                        STA    $A8,S
                        STA    $AC,S
                        STA    $AE,S
                        STA    $B0,S
                        LDA    $0E,S
                        AND    #$0F
                        ORA    #$20
                        STA    $0E,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $AD,S
                        STA    $B0,S
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $02,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $06,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0A,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A2,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A6,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AA,S
                        SHORT  M
                        LDA    #$22
                        STA    $00,S
                        STA    $04,S
                        STA    $08,S
                        STA    $0C,S
                        STA    $10,S
                        STA    $A0,S
                        STA    $A4,S
                        STA    $A8,S
                        STA    $B2,S
                        LDA    $AC,S
                        AND    #$F0
                        ORA    #$02
                        STA    $AC,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $00,S
                        STA    $05,S
                        LDA    $07,S
                        AND    #$000F
                        ORA    #$2220
                        STA    $07,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0A,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0E,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A6,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AA,S
                        LDA    $AE,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AE,S
                        SHORT  M
                        LDA    #$22
                        STA    $02,S
                        STA    $04,S
                        STA    $10,S
                        STA    $A0,S
                        STA    $A4,S
                        STA    $A8,S
                        STA    $AC,S
                        STA    $B0,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $09,S
                        STA    $0D,S
                        STA    $10,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $06,S
                        LDA    $12,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $12,S
                        SHORT  M
                        LDA    #$22
                        STA    $00,S
                        STA    $04,S
                        LDA    $08,S
                        AND    #$F0
                        ORA    #$02
                        STA    $08,S
                        LDA    $0C,S
                        AND    #$F0
                        ORA    #$02
                        STA    $0C,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXTGAMEOVER_000A
TXTGAMEOVER_000A        ENTRY
                        CLC                             ; 72x8, 652 bytes, 1057 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$2222                   ; Pattern #1 : 16
;--
                        TXA                             ; Line 0
                        STA    $01,S
                        STA    $0C,S
                        STA    $15,S
                        STA    $1D,S
                        STA    $21,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $05,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0A,S
                        LDA    $0E,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $0E,S
                        LDA    $1A,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $1A,S
                        LDA    $1F,S
                        AND    #$000F
                        ORA    #$2220
                        STA    $1F,S
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A0,S
                        LDA    $A4,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A4,S
                        LDA    $A9,S
                        AND    #$000F
                        ORA    #$2220
                        STA    $A9,S
                        LDA    $AB,S
                        AND    #$000F
                        ORA    #$2220
                        STA    $AB,S
                        LDA    $B6,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $B6,S
                        LDA    $BA,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $BA,S
                        LDA    $C2,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $C2,S
                        SHORT  M
                        LDA    #$22
                        STA    $08,S
                        STA    $18,S
                        STA    $1C,S
                        STA    $A6,S
                        STA    $A8,S
                        STA    $B4,S
                        STA    $B8,S
                        STA    $BC,S
                        STA    $C0,S
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$20
                        STA    $03,S
                        LDA    $14,S
                        AND    #$F0
                        ORA    #$02
                        STA    $14,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $09,S
                        STA    $A9,S
                        STA    $AD,S
                        STA    $BD,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $06,S
                        LDA    $0B,S
                        AND    #$000F
                        ORA    #$2220
                        STA    $0B,S
                        LDA    $16,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $16,S
                        LDA    $1A,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $1A,S
                        LDA    $22,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $22,S
                        LDA    $A3,S
                        AND    #$000F
                        ORA    #$2220
                        STA    $A3,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A6,S
                        LDA    $AB,S
                        AND    #$000F
                        ORA    #$2220
                        STA    $AB,S
                        LDA    $B6,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $B6,S
                        LDA    $B9,S
                        AND    #$000F
                        ORA    #$2220
                        STA    $B9,S
                        LDA    $BB,S
                        AND    #$000F
                        ORA    #$2220
                        STA    $BB,S
                        LDA    $C2,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $C2,S
                        SHORT  M
                        LDA    #$22
                        STA    $00,S
                        STA    $04,S
                        STA    $08,S
                        STA    $14,S
                        STA    $18,S
                        STA    $1C,S
                        STA    $20,S
                        STA    $A0,S
                        STA    $A2,S
                        STA    $A8,S
                        STA    $B4,S
                        STA    $B8,S
                        STA    $C0,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $05,S
                        STA    $19,S
                        STA    $20,S
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $02,S
                        LDA    $08,S
                        AND    #$F000
                        ORA    #$0222
                        STA    $08,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0A,S
                        LDA    $16,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $16,S
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A0,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A2,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A6,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AA,S
                        LDA    $B6,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $B6,S
                        LDA    $B9,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $B9,S
                        LDA    $C1,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $C1,S
                        SHORT  M
                        LDA    #$22
                        STA    $00,S
                        STA    $04,S
                        STA    $0C,S
                        STA    $14,S
                        STA    $1C,S
                        STA    $A4,S
                        STA    $A8,S
                        STA    $AC,S
                        STA    $B4,S
                        STA    $BC,S
                        STA    $C0,S
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$20
                        STA    $07,S
                        LDA    $18,S
                        AND    #$F0
                        ORA    #$02
                        STA    $18,S
                        LDA    $22,S
                        AND    #$0F
                        ORA    #$20
                        STA    $22,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        STA    $0C,S
                        STA    $15,S
                        STA    $1D,S
                        LDA    $03,S
                        AND    #$000F
                        ORA    #$2220
                        STA    $03,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $06,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0A,S
                        LDA    $0E,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $0E,S
                        LDA    $1F,S
                        AND    #$000F
                        ORA    #$2220
                        STA    $1F,S
                        LDA    $22,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $22,S
                        SHORT  M
                        LDA    #$22
                        STA    $08,S
                        STA    $1C,S
                        LDA    $14,S
                        AND    #$F0
                        ORA    #$02
                        STA    $14,S
                        LDA    $19,S
                        AND    #$F0
                        ORA    #$02
                        STA    $19,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXTPLAYER_000A
TXTPLAYER_000A          ENTRY
                        CLC                             ; 48x8, 440 bytes, 713 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$1111                   ; Pattern #1 : 10
;--
                        TXA                             ; Line 0
                        STA    $00,S
                        STA    $11,S
                        STA    $15,S
                        LDA    $09,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $09,S
                        LDA    $0C,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0C,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0E,S
                        LDA    $13,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $13,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A2,S
                        LDA    $A8,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A8,S
                        LDA    $AC,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AC,S
                        LDA    $AE,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AE,S
                        LDA    $B6,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $B6,S
                        SHORT  M
                        LDA    #$11
                        STA    $02,S
                        STA    $04,S
                        STA    $10,S
                        STA    $A0,S
                        STA    $A4,S
                        STA    $AA,S
                        STA    $B0,S
                        STA    $B4,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $AD,S
                        STA    $B0,S
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $02,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0A,S
                        LDA    $0C,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0C,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0E,S
                        LDA    $16,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $16,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A2,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AA,S
                        LDA    $B6,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $B6,S
                        SHORT  M
                        LDA    #$11
                        STA    $00,S
                        STA    $04,S
                        STA    $08,S
                        STA    $10,S
                        STA    $14,S
                        STA    $A0,S
                        STA    $A4,S
                        STA    $A8,S
                        STA    $B2,S
                        STA    $B4,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $00,S
                        STA    $08,S
                        STA    $14,S
                        LDA    $0A,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $0A,S
                        LDA    $0D,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0D,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AA,S
                        LDA    $AD,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AD,S
                        LDA    $B5,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $B5,S
                        SHORT  M
                        LDA    #$11
                        STA    $02,S
                        STA    $04,S
                        STA    $10,S
                        STA    $A0,S
                        STA    $A4,S
                        STA    $A8,S
                        STA    $B0,S
                        STA    $B4,S
                        LDA    $16,S
                        AND    #$0F
                        ORA    #$10
                        STA    $16,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $05,S
                        STA    $11,S
                        LDA    $07,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $07,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0A,S
                        LDA    $0D,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0D,S
                        LDA    $13,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $13,S
                        LDA    $16,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $16,S
                        SHORT  M
                        LDA    #$11
                        STA    $00,S
                        STA    $04,S
                        STA    $10,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXTREADY_000A
TXTREADY_000A           ENTRY
                        CLC                             ; 40x8, 432 bytes, 698 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$1111                   ; Pattern #1 : 9
;--
                        TXA                             ; Line 0
                        STA    $00,S
                        STA    $04,S
                        STA    $0C,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $06,S
                        LDA    $09,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $09,S
                        LDA    $10,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $10,S
                        LDA    $12,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $12,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A2,S
                        LDA    $A8,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A8,S
                        LDA    $B0,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $B0,S
                        LDA    $B2,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $B2,S
                        SHORT  M
                        LDA    #$11
                        STA    $02,S
                        STA    $A0,S
                        STA    $A4,S
                        STA    $AA,S
                        STA    $AC,S
                        STA    $AE,S
                        LDA    $0E,S
                        AND    #$0F
                        ORA    #$10
                        STA    $0E,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A5,S
                        STA    $B1,S
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $02,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0A,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0E,S
                        LDA    $10,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $10,S
                        LDA    $12,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $12,S
                        LDA    $A3,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $A3,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AA,S
                        LDA    $AE,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AE,S
                        SHORT  M
                        LDA    #$11
                        STA    $00,S
                        STA    $04,S
                        STA    $08,S
                        STA    $0C,S
                        STA    $A0,S
                        STA    $A2,S
                        STA    $A8,S
                        STA    $AC,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $00,S
                        STA    $09,S
                        LDA    $0B,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $0B,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0E,S
                        LDA    $11,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $11,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A1,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AA,S
                        LDA    $B1,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $B1,S
                        SHORT  M
                        LDA    #$11
                        STA    $04,S
                        STA    $08,S
                        STA    $A0,S
                        STA    $A4,S
                        STA    $A8,S
                        STA    $AC,S
                        STA    $AE,S
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$10
                        STA    $02,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $05,S
                        STA    $0C,S
                        LDA    $03,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $03,S
                        LDA    $07,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $07,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0A,S
                        LDA    $11,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $11,S
                        SHORT  M
                        LDA    #$11
                        STA    $00,S
                        STA    $02,S
                        LDA    $0E,S
                        AND    #$0F
                        ORA    #$10
                        STA    $0E,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: TXTSTAGE_000A
TXTSTAGE_000A           ENTRY
                        CLC                             ; 40x8, 360 bytes, 581 cycles
                        SEI                             ; Disable Interrupts
                        PHD                             ; Backup Direct Page
                        TSC                             ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                             ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                             ; New Stack address
                        LDX    #$1111                   ; Pattern #1 : 9
;--
                        TXA                             ; Line 0
                        STA    $04,S
                        STA    $0D,S
                        STA    $11,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $00,S
                        LDA    $09,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $09,S
                        LDA    $0F,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $0F,S
                        LDA    $A8,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A8,S
                        LDA    $AC,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AC,S
                        SHORT  M
                        LDA    #$11
                        STA    $06,S
                        STA    $A0,S
                        STA    $A2,S
                        STA    $A5,S
                        STA    $AA,S
                        STA    $B0,S
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$10
                        STA    $02,S
                        LDA    $13,S
                        AND    #$0F
                        ORA    #$10
                        STA    $13,S
                        LONG   M
                        TSC                             ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A1,S
                        STA    $B1,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0A,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AA,S
                        LDA    $AF,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $AF,S
                        SHORT  M
                        LDA    #$11
                        STA    $00,S
                        STA    $05,S
                        STA    $08,S
                        STA    $0C,S
                        STA    $10,S
                        STA    $A5,S
                        STA    $A8,S
                        STA    $AC,S
                        STA    $AE,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A0,S
                        LONG   M
                        TSC                             ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $09,S
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $02,S
                        LDA    $0B,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $0B,S
                        LDA    $0E,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0E,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A2,S
                        LDA    $AA,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AA,S
                        LDA    $AC,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AC,S
                        LDA    $AE,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $AE,S
                        SHORT  M
                        LDA    #$11
                        STA    $05,S
                        STA    $08,S
                        STA    $10,S
                        STA    $A0,S
                        STA    $A5,S
                        STA    $A8,S
                        STA    $B0,S
                        LONG   M
                        TSC                             ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        STA    $0D,S
                        STA    $11,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $0A,S
                        LDA    $0F,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $0F,S
                        SHORT  M
                        LDA    #$11
                        STA    $05,S
                        STA    $08,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LDA    $13,S
                        AND    #$0F
                        ORA    #$10
                        STA    $13,S
                        LONG   M
;--
                        LDA    $E1C068                  ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS            ; Restore Stack
                        TCS
                        PLD                             ; Restore Direct Page
                        CLI                             ; Enable Interrupts
                        RTL

;-----------------------------------

THISISAFORMATTINGLABEL  ANOP
                        END
