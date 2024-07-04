                        MCOPY  src/sprites/SPRSHARE.mac

SPRSHARE                START  SHARE

                        USING  VARIABLES

; MARK: NUMBER_000A
NUMBER_000A             ENTRY
                        CLC                              ; 16x8, 329 bytes, 524 cycles
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
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A6,S
                        SHORT  M
                        LDA    #$11
                        STA    $A0,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A6,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A6,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$1011
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
; MARK: NUMBER_000B
NUMBER_000B             ENTRY
                        CLC                              ; 16x8, 331 bytes, 528 cycles
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
                        LDA    $01,S                     ; Line 0
                        AND    #$F00F
                        ORA    #$0110
                        STA    $01,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $04,S
                        LDA    $06,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $06,S
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A0,S
                        LDA    $A2,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A6,S
                        SHORT  M
                        LDA    #$11
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $03,S
                        LDA    $05,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $05,S
                        LDA    $A1,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A5,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$F0
                        ORA    #$01
                        STA    $07,S
                        LDA    $A7,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $03,S
                        LDA    $05,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $05,S
                        LDA    $A1,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A5,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$F0
                        ORA    #$01
                        STA    $07,S
                        LDA    $A7,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $00,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $02,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $04,S
                        LDA    $06,S
                        AND    #$00F0
                        ORA    #$1101
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
; MARK: NUMBER_001A
NUMBER_001A             ENTRY
                        CLC                              ; 16x8, 337 bytes, 539 cycles
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
                        AND    #$0F00
                        ORA    #$1011
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $06,S
                        LDA    $A1,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A5,S
                        SHORT  M
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $05,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A6,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$10
                        STA    $07,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A6,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$0F
                        ORA    #$10
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$1011
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
; MARK: NUMBER_001B
NUMBER_001B             ENTRY
                        CLC                              ; 16x8, 337 bytes, 539 cycles
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
                        AND    #$00F0
                        ORA    #$1101
                        STA    $00,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $02,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $04,S
                        LDA    $06,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $06,S
                        LDA    $A1,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A5,S
                        SHORT  M
                        LDA    $A7,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $03,S
                        LDA    $05,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $05,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A0,S
                        LDA    $A2,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A6,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$F0
                        ORA    #$01
                        STA    $07,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $02,S
                        LDA    $04,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $04,S
                        LDA    $06,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A6,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $00,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $02,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $04,S
                        LDA    $06,S
                        AND    #$00F0
                        ORA    #$1101
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
; MARK: NUMBER_002A
NUMBER_002A             ENTRY
                        CLC                              ; 16x8, 337 bytes, 539 cycles
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
                        AND    #$0F00
                        ORA    #$1011
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $06,S
                        LDA    $A1,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A5,S
                        SHORT  M
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $05,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A6,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$10
                        STA    $07,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $05,S
                        LDA    $A1,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A5,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$10
                        STA    $07,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$1011
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
; MARK: NUMBER_002B
NUMBER_002B             ENTRY
                        CLC                              ; 16x8, 337 bytes, 539 cycles
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
                        AND    #$00F0
                        ORA    #$1101
                        STA    $00,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $02,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $04,S
                        LDA    $06,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $06,S
                        LDA    $A1,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A5,S
                        SHORT  M
                        LDA    $A7,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $03,S
                        LDA    $05,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $05,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A0,S
                        LDA    $A2,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A6,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$F0
                        ORA    #$01
                        STA    $07,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $03,S
                        LDA    $05,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $05,S
                        LDA    $A1,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A5,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$F0
                        ORA    #$01
                        STA    $07,S
                        LDA    $A7,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $00,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $02,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $04,S
                        LDA    $06,S
                        AND    #$00F0
                        ORA    #$1101
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
; MARK: NUMBER_003A
NUMBER_003A             ENTRY
                        CLC                              ; 16x8, 339 bytes, 541 cycles
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
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A6,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$0F
                        ORA    #$10
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $06,S
                        LDA    $A0,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A0,S
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A6,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$0F
                        ORA    #$10
                        STA    $00,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $06,S
                        LDA    $A1,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A5,S
                        SHORT  M
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $06,S
                        SHORT  M
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
; MARK: NUMBER_003B
NUMBER_003B             ENTRY
                        CLC                              ; 16x8, 335 bytes, 534 cycles
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
                        AND    #$00F0
                        ORA    #$1101
                        STA    $02,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $04,S
                        LDA    $06,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A6,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $02,S
                        LDA    $04,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $04,S
                        LDA    $06,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $06,S
                        LDA    $A0,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A0,S
                        LDA    $A2,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A6,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $00,S
                        LDA    $02,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $02,S
                        LDA    $04,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $04,S
                        LDA    $06,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $06,S
                        LDA    $A1,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A5,S
                        SHORT  M
                        LDA    $A7,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $01,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $04,S
                        LDA    $06,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $06,S
                        SHORT  M
                        LDA    #$11
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
; MARK: NUMBER_004A
NUMBER_004A             ENTRY
                        CLC                              ; 16x8, 337 bytes, 539 cycles
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
                        AND    #$0F00
                        ORA    #$1011
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A6,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $06,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A6,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$0F
                        ORA    #$10
                        STA    $00,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $05,S
                        LDA    $A1,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A5,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$10
                        STA    $07,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$1011
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
; MARK: NUMBER_004B
NUMBER_004B             ENTRY
                        CLC                              ; 16x8, 337 bytes, 539 cycles
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
                        AND    #$00F0
                        ORA    #$1101
                        STA    $00,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $02,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $04,S
                        LDA    $06,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A6,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $02,S
                        LDA    $04,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $04,S
                        LDA    $06,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $06,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A0,S
                        LDA    $A2,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A6,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $03,S
                        LDA    $05,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $05,S
                        LDA    $A1,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A5,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$F0
                        ORA    #$01
                        STA    $07,S
                        LDA    $A7,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $00,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $02,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $04,S
                        LDA    $06,S
                        AND    #$00F0
                        ORA    #$1101
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
; MARK: NUMBER_005A
NUMBER_005A             ENTRY
                        CLC                              ; 16x8, 321 bytes, 508 cycles
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
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $06,S
                        LDA    $A4,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A6,S
                        SHORT  M
                        LDA    #$11
                        STA    $A0,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A6,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$10
                        STA    $02,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $05,S
                        LDA    $A3,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F0F
                        ORA    #$1010
                        STA    $A5,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$01
                        STA    $00,S
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$10
                        STA    $07,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A0,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$1011
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
; MARK: NUMBER_005B
NUMBER_005B             ENTRY
                        CLC                              ; 16x8, 313 bytes, 497 cycles
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
                        LDA    $01,S                     ; Line 0
                        AND    #$F00F
                        ORA    #$0110
                        STA    $01,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $04,S
                        LDA    $06,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $06,S
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A0,S
                        LDA    $A4,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A6,S
                        SHORT  M
                        LDA    #$11
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $01,S
                        LDA    $04,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $04,S
                        LDA    $06,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $06,S
                        LDA    $A1,S
                        AND    #$F00F
                        ORA    #$0110
                        STA    $A1,S
                        LDA    $A4,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A6,S
                        SHORT  M
                        LDA    #$11
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $03,S
                        LDA    $05,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $05,S
                        LDA    $A3,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$F0F0
                        ORA    #$0101
                        STA    $A5,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$10
                        STA    $01,S
                        LDA    $07,S
                        AND    #$F0
                        ORA    #$01
                        STA    $07,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LDA    $A7,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $00,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $02,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $04,S
                        LDA    $06,S
                        AND    #$00F0
                        ORA    #$1101
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
; MARK: PARACHUTE_000A
PARACHUTE_000A          ENTRY
                        CLC                              ; 20x16, 459 bytes, 731 cycles
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
                        LDY    #$2222                    ; Pattern #2 : 2
                        LDA    #$2211                    ; Pattern #3 : 1
                        TCD
;--
                        LDA    #$2111                    ; Line 0
                        STA    $A4,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $05,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A2,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$1021
                        STA    $A6,S
                        TSC                              ; Line 2
                        ADC    #$0147
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9A,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1021
                        STA    $A0,S
                        PEA    $1122
                        PHD
                        PHX
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    #$2112
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9D,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1021
                        STA    $A1,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LONG   M
                        PEA    $2212
                        PHX
                        TSC                              ; Line 5
                        ADC    #$013E
                        TCS
                        TXA
                        STA    $A7,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A5,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$02
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A1,S
                        LONG   M
                        TSC
                        ADC    #$0008
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$013C
                        TCS
                        TXA
                        STA    $07,S
                        LDA    $02,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $02,S
                        LDA    $05,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $05,S
                        LDA    $A2,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A2,S
                        LDA    $A7,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A7,S
                        SHORT  M
                        LDA    #$11
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        LDA    #$2277
                        STA    $A4,S
                        LDA    $02,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $02,S
                        LDA    $04,S
                        AND    #$F00F
                        ORA    #$0270
                        STA    $04,S
                        LDA    $A2,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A2,S
                        SHORT  M
                        LDA    #$11
                        STA    $08,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LDA    $A8,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A8,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        LDA    #$1721
                        STA    $A3,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$7102
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$2072
                        STA    $04,S
                        LDA    $A6,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $A6,S
                        SHORT  M
                        LDA    $08,S
                        AND    #$0F
                        ORA    #$20
                        STA    $08,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $04,S
                        SHORT  M
                        LDA    #$77
                        STA    $02,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 15
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$77
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
; MARK: PARACHUTE_000B
PARACHUTE_000B          ENTRY
                        CLC                              ; 20x16, 447 bytes, 710 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 12
                        LDY    #$1211                    ; Pattern #2 : 2
                        LDA    #$2222                    ; Pattern #3 : 2
                        TCD
;--
                        TXA                              ; Line 0
                        STA    $04,S
                        SHORT  M
                        LDA    #$11
                        STA    $06,S
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 1
                        ADC    #$00A6
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1021
                        STA    $A1,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9C,S
                        LONG   M
                        PEA    $1212
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $A2,S
                        LONG   M
                        PEA    $2212
                        PHX
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $A1,S
                        LDA    $9B,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9B,S
                        LONG   M
                        PHD
                        PHX
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00A6
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A1,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$0F
                        ORA    #$20
                        STA    $9B,S
                        LONG   M
                        PEA    $1222
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9F,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A1,S
                        SHORT  M
                        LDA    #$11
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$0F
                        ORA    #$20
                        STA    $9B,S
                        LONG   M
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$013D
                        TCS
                        TXA
                        STA    $06,S
                        LDA    $08,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $08,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A6,S
                        LDA    $A8,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A8,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$02
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$20
                        STA    $04,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        LDA    #$7227
                        STA    $A4,S
                        LDA    $08,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $08,S
                        SHORT  M
                        LDA    #$27
                        STA    $04,S
                        LDA    #$22
                        STA    $06,S
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$02
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A6,S
                        LDA    $A9,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A9,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        LDA    #$1727
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$F00F
                        ORA    #$0270
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$7011
                        STA    $A4,S
                        LDA    $A7,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A7,S
                        SHORT  M
                        LDA    #$22
                        STA    $05,S
                        LDA    $08,S
                        AND    #$F0
                        ORA    #$02
                        STA    $08,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $05,S
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $02,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$02
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 15
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$0FF0
                        ORA    #$7007
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
; MARK: PARACHUTE_001A
PARACHUTE_001A          ENTRY
                        CLC                              ; 20x16, 419 bytes, 670 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 9
                        LDY    #$2211                    ; Pattern #2 : 4
                        LDA    #$2222                    ; Pattern #3 : 2
                        TCD
;--
                        LDA    #$1211                    ; Line 0
                        STA    $A4,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $05,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A2,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A6,S
                        TSC                              ; Line 2
                        ADC    #$0147
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9A,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        PEA    $1121
                        PHD
                        PHX
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A1,S
                        PHD
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $9B,S
                        LONG   M
                        PEA    $1122
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00A6
                        TCS
                        TXA
                        STA    $9F,S
                        LDA    $9B,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $9B,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9D,S
                        SHORT  M
                        LDA    $99,S
                        AND    #$0F
                        ORA    #$20
                        STA    $99,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$013E
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $06,S
                        STA    $08,S
                        STA    $A8,S
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$02
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$02
                        STA    $03,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A3,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F000
                        ORA    #$0277
                        STA    $A4,S
                        SHORT  M
                        LDA    #$22
                        STA    $A8,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LDA    $08,S
                        AND    #$F0
                        ORA    #$01
                        STA    $08,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        LDA    #$1127
                        STA    $A3,S
                        LDA    $02,S
                        AND    #$F0F0
                        ORA    #$0202
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$2077
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$000F
                        ORA    #$2270
                        STA    $A5,S
                        SHORT  M
                        LDA    #$22
                        STA    $07,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$F00F
                        ORA    #$0770
                        STA    $A3,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$02
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 15
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$77
                        STA    $02,S
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
; MARK: PARACHUTE_001B
PARACHUTE_001B          ENTRY
                        CLC                              ; 20x16, 473 bytes, 750 cycles
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
                        LDY    #$1211                    ; Pattern #2 : 3
                        LDA    #$1121                    ; Pattern #3 : 2
                        TCD
;--
                        TXA                              ; Line 0
                        STA    $04,S
                        SHORT  M
                        LDA    #$11
                        STA    $06,S
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 1
                        ADC    #$00A7
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LONG   M
                        PHD
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00A3
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $A2,S
                        LONG   M
                        PEA    $2222
                        PHY
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $9B,S
                        LONG   M
                        PEA    $2122
                        PHY
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00A7
                        TCS
                        LDA    $99,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $99,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LONG   M
                        PHX
                        PEA    $2112
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00A5
                        TCS
                        TXA
                        STA    $9F,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A1,S
                        SHORT  M
                        LDA    #$11
                        STA    $9D,S
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9A,S
                        LONG   M
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$013D
                        TCS
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $06,S
                        LDA    $08,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $08,S
                        LDA    $A8,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A8,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$20
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$20
                        STA    $04,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        LDA    $A5,S
                        AND    #$0F0F
                        ORA    #$2070
                        STA    $A5,S
                        LDA    $A8,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A8,S
                        SHORT  M
                        LDA    #$27
                        STA    $A4,S
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$02
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$20
                        STA    $04,S
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$02
                        STA    $06,S
                        LDA    $09,S
                        AND    #$0F
                        ORA    #$10
                        STA    $09,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        LDA    #$7227
                        STA    $04,S
                        LDA    #$1771
                        STA    $A4,S
                        LDA    $07,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $07,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A6,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$20
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    #$1221
                        STA    $04,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 15
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $02,S
                        LDA    $05,S
                        AND    #$0FF0
                        ORA    #$7007
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
; MARK: PARACHUTE_002A
PARACHUTE_002A          ENTRY
                        CLC                              ; 20x16, 419 bytes, 670 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 9
                        LDY    #$1122                    ; Pattern #2 : 4
                        LDA    #$2222                    ; Pattern #3 : 2
                        TCD
;--
                        LDA    #$1121                    ; Line 0
                        STA    $A4,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $05,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A2,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A6,S
                        TSC                              ; Line 2
                        ADC    #$0147
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9A,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        PHX
                        PHD
                        PEA    $1211
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A1,S
                        PHX
                        PHD
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $A2,S
                        LONG   M
                        PHX
                        PEA    $2211
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9B,S
                        LDA    $9D,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $9F,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LONG   M
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $01,S
                        STA    $03,S
                        STA    $A1,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LDA    $08,S
                        AND    #$0F
                        ORA    #$20
                        STA    $08,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A3,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A6,S
                        LDA    $A8,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A8,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        LDA    $06,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $06,S
                        LDA    $A4,S
                        AND    #$000F
                        ORA    #$7720
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A6,S
                        SHORT  M
                        LDA    #$22
                        STA    $A1,S
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$10
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$02
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        LDA    #$7211
                        STA    $A5,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$7702
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F0F
                        ORA    #$2020
                        STA    $06,S
                        LDA    $A3,S
                        AND    #$F000
                        ORA    #$0722
                        STA    $A3,S
                        SHORT  M
                        LDA    #$22
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$F00F
                        ORA    #$0770
                        STA    $A5,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 15
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$77
                        STA    $04,S
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
; MARK: PARACHUTE_002B
PARACHUTE_002B          ENTRY
                        CLC                              ; 20x16, 473 bytes, 750 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 9
                        LDY    #$1211                    ; Pattern #2 : 3
                        LDA    #$1121                    ; Pattern #3 : 3
                        TCD
;--
                        TXA                              ; Line 0
                        STA    $04,S
                        SHORT  M
                        LDA    #$11
                        STA    $06,S
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 1
                        ADC    #$00A6
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9C,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        PHX
                        PHY
                        TSC                              ; Line 2
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $A1,S
                        LONG   M
                        PHD
                        PEA    $2222
                        TSC                              ; Line 3
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $A1,S
                        LONG   M
                        PHX
                        PEA    $2122
                        PHY
                        TSC                              ; Line 4
                        ADC    #$00A6
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $9F,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A1,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9A,S
                        LONG   M
                        PHX
                        PEA    $2112
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9C,S
                        SHORT  M
                        LDA    #$11
                        STA    $A1,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A4,S
                        LONG   M
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$013F
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $03,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A1,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$02
                        STA    $06,S
                        LDA    $08,S
                        AND    #$F0
                        ORA    #$02
                        STA    $08,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A6,S
                        LDA    $A8,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A8,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A1,S
                        LDA    $A4,S
                        AND    #$F0F0
                        ORA    #$0702
                        STA    $A4,S
                        SHORT  M
                        LDA    #$72
                        STA    $A6,S
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$01
                        STA    $01,S
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$20
                        STA    $04,S
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$02
                        STA    $06,S
                        LDA    $08,S
                        AND    #$0F
                        ORA    #$20
                        STA    $08,S
                        LDA    $A8,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A8,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        LDA    #$7227
                        STA    $05,S
                        LDA    #$1771
                        STA    $A5,S
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $02,S
                        LDA    $A3,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A3,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$F0
                        ORA    #$02
                        STA    $07,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    #$1221
                        STA    $05,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$02
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A5,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 15
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $04,S
                        LDA    $07,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $07,S
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
; MARK: PARACHUTE_003A
PARACHUTE_003A          ENTRY
                        CLC                              ; 20x16, 454 bytes, 724 cycles
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
                        LDY    #$2222                    ; Pattern #2 : 2
                        LDA    #$1122                    ; Pattern #3 : 1
                        TCD
;--
                        LDA    #$1112                    ; Line 0
                        STA    $A4,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $05,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1201
                        STA    $A2,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A6,S
                        TSC                              ; Line 2
                        ADC    #$0147
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$1201
                        STA    $9A,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        PHX
                        PHD
                        PEA    $2211
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    #$2112
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$1201
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $9F,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        PHX
                        PEA    $2122
                        TSC                              ; Line 5
                        ADC    #$0142
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $01,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $9F,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A1,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$20
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A4,S
                        LONG   M
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $03,S
                        LDA    $06,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$000F
                        ORA    #$1110
                        STA    $A2,S
                        LDA    $A6,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A6,S
                        SHORT  M
                        LDA    #$11
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        LDA    #$7722
                        STA    $A4,S
                        LDA    $03,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0FF0
                        ORA    #$2007
                        STA    $05,S
                        LDA    $A6,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A6,S
                        SHORT  M
                        LDA    #$11
                        STA    $01,S
                        LDA    $07,S
                        AND    #$F0
                        ORA    #$02
                        STA    $07,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        LDA    #$1271
                        STA    $A5,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$2702
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$2017
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A2,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$02
                        STA    $01,S
                        LDA    $A8,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A8,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $04,S
                        SHORT  M
                        LDA    #$77
                        STA    $07,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$02
                        STA    $03,S
                        LDA    $A5,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 15
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$77
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
; MARK: PARACHUTE_003B
PARACHUTE_003B          ENTRY
                        CLC                              ; 20x16, 451 bytes, 712 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 12
                        LDY    #$1122                    ; Pattern #2 : 2
                        LDA    #$1121                    ; Pattern #3 : 2
                        TCD
;--
                        TXA                              ; Line 0
                        STA    $04,S
                        SHORT  M
                        LDA    #$11
                        STA    $06,S
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 1
                        ADC    #$00A7
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$1201
                        STA    $9B,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
                        PHX
                        PEA    $2121
                        TSC                              ; Line 2
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $9B,S
                        LONG   M
                        PHX
                        PEA    $2122
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$11
                        STA    $9A,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A0,S
                        LONG   M
                        PHX
                        PHX
                        PEA    $2222
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9B,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LONG   M
                        PHX
                        PEA    $2221
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9B,S
                        SHORT  M
                        LDA    #$11
                        STA    $A0,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LONG   M
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$013E
                        TCS
                        TXA
                        STA    $03,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $A3,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$02
                        STA    $06,S
                        LDA    $08,S
                        AND    #$0F
                        ORA    #$20
                        STA    $08,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A6,S
                        LDA    $A8,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A8,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        LDA    #$7227
                        STA    $A5,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        SHORT  M
                        LDA    #$22
                        STA    $04,S
                        LDA    #$72
                        STA    $06,S
                        LDA    $08,S
                        AND    #$0F
                        ORA    #$20
                        STA    $08,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A1,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A4,S
                        LDA    $A8,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A8,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        LDA    #$7122
                        STA    $05,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $A2,S
                        LDA    $A5,S
                        AND    #$00F0
                        ORA    #$1107
                        STA    $A5,S
                        LDA    $A7,S
                        AND    #$F00F
                        ORA    #$0720
                        STA    $A7,S
                        SHORT  M
                        LDA    #$72
                        STA    $07,S
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$20
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    #$2222
                        STA    $04,S
                        LDA    $07,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $07,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 15
                        ADC    #$0140
                        TCS
                        LDA    $05,S
                        AND    #$0FF0
                        ORA    #$7007
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
; MARK: PLAYER_000A
PLAYER_000A             ENTRY
                        CLC                              ; 16x16, 196 bytes, 319 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 6
                        LDY    #$4444                    ; Pattern #2 : 2
                        LDA    #$1144                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        LDA    $00,S
                        AND    #$0FF0
                        ORA    #$1004
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $A0,S
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $03,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$04
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    #$41
                        STA    $9B,S
                        LONG   M
                        PHX
                        PEA    $6616
                        PEA    $4114
                        TSC                              ; Line 8
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A0,S
                        LONG   M
                        PHX
                        PHX
                        PEA    $4411
                        TSC                              ; Line 9
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$60
                        STA    $9F,S
                        LONG   M
                        PHY
                        PEA    $4411
                        PHD
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        LDA    $9E,S
                        AND    #$0F00
                        ORA    #$4044
                        STA    $9E,S
                        PEA    $6614
                        PEA    $1164
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
; MARK: PLAYER_001A
PLAYER_001A             ENTRY
                        CLC                              ; 16x16, 212 bytes, 347 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 6
                        LDY    #$1141                    ; Pattern #2 : 3
                        LDA    #$6616                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        TXA
                        STA    $A1,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $00,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$04
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $03,S
                        SHORT  M
                        LDA    #$11
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A3,S
                        LONG   M
                        PHD
                        PEA    $1114
                        TSC                              ; Line 8
                        ADC    #$00A6
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$4106
                        STA    $9A,S
                        PHX
                        PEA    $4114
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A7
                        TCS
                        LDA    #$4411
                        STA    $9B,S
                        LDA    #$4444
                        STA    $9E,S
                        SHORT  M
                        LDA    #$41
                        STA    $9A,S
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$40
                        STA    $9D,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A0,S
                        LONG   M
                        PHX
                        PHY
                        PHX
                        TSC                              ; Line 11
                        ADC    #$013F
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$4404
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$6066
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
; MARK: PLAYER_002A
PLAYER_002A             ENTRY
                        CLC                              ; 16x16, 244 bytes, 394 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 6
                        LDY    #$1141                    ; Pattern #2 : 3
                        LDA    #$4114                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        LDA    #$1441
                        STA    $A1,S
                        SHORT  M
                        LDA    #$41
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A3,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$40
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    #$1641
                        STA    $02,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$4406
                        STA    $00,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$1066
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A5,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$04
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A3,S
                        LONG   M
                        PHD
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$04
                        STA    $9B,S
                        LONG   M
                        PHX
                        PEA    $4111
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A7
                        TCS
                        LDA    $9E,S
                        AND    #$00F0
                        ORA    #$4404
                        STA    $9E,S
                        SHORT  M
                        LDA    #$66
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A0,S
                        LONG   M
                        PHX
                        PHD
                        PEA    $4444
                        TSC                              ; Line 12
                        ADC    #$013F
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$60
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
; MARK: PLAYER_003A
PLAYER_003A             ENTRY
                        CLC                              ; 16x16, 244 bytes, 399 cycles
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
                        LDY    #$1141                    ; Pattern #2 : 3
                        LDA    #$4144                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        LDA    #$4411
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$4014
                        STA    $A3,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$04
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    #$6616
                        STA    $03,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $01,S
                        SHORT  M
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$1106
                        STA    $9C,S
                        PEA    $6614
                        PHD
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$4104
                        STA    $9B,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
                        PEA    $6144
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        TYA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$F000
                        ORA    #$0466
                        STA    $9D,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A1,S
                        LONG   M
                        PHX
                        PEA    $4114
                        PHD
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$4004
                        STA    $A6,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$04
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
; MARK: PLAYER_004A
PLAYER_004A             ENTRY
                        CLC                              ; 16x16, 258 bytes, 418 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1141                    ; Pattern #1 : 4
                        LDY    #$1144                    ; Pattern #2 : 3
                        LDA    #$4611                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$4411
                        STA    $A2,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$60
                        STA    $03,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    #$4614
                        STA    $A3,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$4014
                        STA    $03,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $A1,S
                        TSC                              ; Line 6
                        ADC    #$0144
                        TCS
                        SHORT  M
                        LDA    #$64
                        STA    $A0,S
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$60
                        STA    $01,S
                        LONG   M
                        PEA    $6446
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A3
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1066
                        STA    $A1,S
                        PHD
                        PEA    $1164
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$4404
                        STA    $9D,S
                        PEA    $1411
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        TYA
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$06
                        STA    $9C,S
                        LONG   M
                        PHX
                        PHY
                        TSC                              ; Line 11
                        ADC    #$013F
                        TCS
                        TXA
                        STA    $04,S
                        STA    $A5,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$60
                        STA    $02,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$10
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    $05,S
                        AND    #$00F0
                        ORA    #$4104
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
; MARK: PLAYER_005A
PLAYER_005A             ENTRY
                        CLC                              ; 16x16, 287 bytes, 462 cycles
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
                        LDY    #$1141                    ; Pattern #2 : 2
                        LDA    #$4414                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $A3,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$1601
                        STA    $02,S
                        SHORT  M
                        LDA    #$11
                        STA    $A2,S
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$40
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A2,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $A0,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$6064
                        STA    $A4,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$0F
                        ORA    #$60
                        STA    $00,S
                        LONG   M
                        TSC
                        ADC    #$0004
                        TCS
                        PHD
                        PEA    $4144
                        TSC                              ; Line 6
                        ADC    #$0143
                        TCS
                        LDA    $01,S
                        AND    #$F000
                        ORA    #$0666
                        STA    $01,S
                        SHORT  M
                        LDA    #$41
                        STA    $9D,S
                        LONG   M
                        PEA    $1611
                        PHY
                        TSC                              ; Line 7
                        ADC    #$00A5
                        TCS
                        LDA    #$1444
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$4404
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1046
                        STA    $A0,S
                        PEA    $6644
                        PHX
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A4,S
                        LDA    $02,S
                        AND    #$000F
                        ORA    #$4460
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $04,S
                        LDA    $A2,S
                        AND    #$F0F0
                        ORA    #$0406
                        STA    $A2,S
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $A4,S
                        SHORT  M
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$1041
                        STA    $05,S
                        SHORT  M
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$10
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
; MARK: PLAYER_006A
PLAYER_006A             ENTRY
                        CLC                              ; 16x16, 291 bytes, 471 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1141                    ; Pattern #1 : 6
                        LDY    #$1411                    ; Pattern #2 : 2
                        LDA    #$1111                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        TXA
                        STA    $A2,S
                        LDA    $03,S
                        AND    #$0F0F
                        ORA    #$6010
                        STA    $03,S
                        SHORT  M
                        LDA    #$44
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        STA    $A2,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$4406
                        STA    $00,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$4044
                        STA    $04,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $A0,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$4044
                        STA    $A4,S
                        TSC                              ; Line 5
                        ADC    #$0145
                        TCS
                        PEA    $1664
                        PHY
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A6
                        TCS
                        LDA    #$1441
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$4404
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$4066
                        STA    $9F,S
                        PEA    $4666
                        PHY
                        PHX
                        TSC                              ; Line 8
                        ADC    #$0141
                        TCS
                        LDA    #$1641
                        STA    $03,S
                        LDA    $01,S
                        AND    #$F0F0
                        ORA    #$0406
                        STA    $01,S
                        LDA    $A2,S
                        AND    #$000F
                        ORA    #$4460
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A4,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$10
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 10
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A4,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $03,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$10
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $04,S
                        SHORT  M
                        LDA    #$41
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$01
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
; MARK: PLAYER_007A
PLAYER_007A             ENTRY
                        CLC                              ; 16x16, 260 bytes, 426 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1141                    ; Pattern #1 : 6
                        LDY    #$4611                    ; Pattern #2 : 3
                        LDA    #$1144                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    #$4411
                        STA    $A3,S
                        LDA    $03,S
                        AND    #$0F0F
                        ORA    #$6010
                        STA    $03,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A0,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0144
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$4044
                        STA    $A0,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$40
                        STA    $01,S
                        LONG   M
                        PEA    $4411
                        PEA    $4144
                        TSC                              ; Line 4
                        ADC    #$00A3
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$6064
                        STA    $A1,S
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        TYA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $9D,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$6064
                        STA    $A1,S
                        PHY
                        PHX
                        TSC                              ; Line 7
                        ADC    #$0145
                        TCS
                        PEA    $6446
                        PHD
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$F0F0
                        ORA    #$0406
                        STA    $9D,S
                        PEA    $6144
                        PEA    $4464
                        TSC                              ; Line 10
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $03,S
                        TDC
                        STA    $A3,S
                        LDA    $01,S
                        AND    #$F0F0
                        ORA    #$0406
                        STA    $01,S
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $A3,S
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$41
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
; MARK: PLAYER_008A
PLAYER_008A             ENTRY
                        CLC                              ; 16x16, 310 bytes, 500 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1441                    ; Pattern #1 : 4
                        LDY    #$6411                    ; Pattern #2 : 3
                        LDA    #$6616                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A3,S
                        LDA    $A6,S
                        AND    #$0FF0
                        ORA    #$4004
                        STA    $A6,S
                        SHORT  M
                        LDA    #$44
                        STA    $A1,S
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$06
                        STA    $01,S
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$10
                        STA    $04,S
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$06
                        STA    $06,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0146
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9B,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$40
                        STA    $01,S
                        LONG   M
                        PEA    $1111
                        PHX
                        PEA    $4411
                        TSC                              ; Line 5
                        ADC    #$00A6
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$1106
                        STA    $9B,S
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        TDC
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$F0F0
                        ORA    #$0406
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$F000
                        ORA    #$0644
                        STA    $9F,S
                        PEA    $4641
                        PHY
                        TSC                              ; Line 8
                        ADC    #$013E
                        TCS
                        TDC
                        STA    $03,S
                        TYA
                        STA    $A3,S
                        LDA    $05,S
                        AND    #$F00F
                        ORA    #$0640
                        STA    $05,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$06
                        STA    $01,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 10
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$1401
                        STA    $A3,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$40
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$1401
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$1401
                        STA    $A3,S
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$10
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$10
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
; MARK: PLAYER_009A
PLAYER_009A             ENTRY
                        CLC                              ; 16x16, 265 bytes, 433 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1411                    ; Pattern #1 : 6
                        LDY    #$1164                    ; Pattern #2 : 3
                        LDA    #$4411                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    #$1144
                        STA    $A3,S
                        LDA    $03,S
                        AND    #$F0F0
                        ORA    #$0106
                        STA    $03,S
                        SHORT  M
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A5,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$4404
                        STA    $A2,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$04
                        STA    $02,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $4414
                        PEA    $1144
                        TSC                              ; Line 4
                        ADC    #$00A5
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$4606
                        STA    $9B,S
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        TYA
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$4606
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $9F,S
                        PHX
                        PHY
                        TSC                              ; Line 7
                        ADC    #$0143
                        TCS
                        PHD
                        PEA    $6446
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F0F
                        ORA    #$6040
                        STA    $9F,S
                        PEA    $4644
                        PEA    $4416
                        TSC                              ; Line 10
                        ADC    #$013E
                        TCS
                        TXA
                        STA    $03,S
                        TDC
                        STA    $A3,S
                        LDA    $05,S
                        AND    #$0F0F
                        ORA    #$6040
                        STA    $05,S
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $A3,S
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$14
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
; MARK: PLAYER_010A
PLAYER_010A             ENTRY
                        CLC                              ; 16x16, 291 bytes, 471 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1411                    ; Pattern #1 : 6
                        LDY    #$1111                    ; Pattern #2 : 2
                        LDA    #$1141                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        TXA
                        STA    $A4,S
                        LDA    $03,S
                        AND    #$F0F0
                        ORA    #$0106
                        STA    $03,S
                        SHORT  M
                        LDA    #$44
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $04,S
                        STA    $A4,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$4404
                        STA    $02,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$6044
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$4404
                        STA    $A2,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $A6,S
                        TSC                              ; Line 5
                        ADC    #$0147
                        TCS
                        PHX
                        PHD
                        PEA    $4661
                        TSC                              ; Line 6
                        ADC    #$00A6
                        TCS
                        LDA    #$1441
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$6604
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$4044
                        STA    $9F,S
                        PHX
                        PHD
                        PEA    $6664
                        TSC                              ; Line 8
                        ADC    #$013F
                        TCS
                        LDA    #$1461
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F0F
                        ORA    #$6040
                        STA    $05,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F000
                        ORA    #$0644
                        STA    $A4,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$01
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 10
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A2,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $02,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$40
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $02,S
                        SHORT  M
                        LDA    #$14
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 14
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
; MARK: PLAYER_011A
PLAYER_011A             ENTRY
                        CLC                              ; 16x16, 287 bytes, 462 cycles
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
                        LDY    #$1411                    ; Pattern #2 : 2
                        LDA    #$4144                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $A3,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$6104
                        STA    $03,S
                        SHORT  M
                        LDA    #$11
                        STA    $A5,S
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$10
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0146
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$4606
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $A0,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$06
                        STA    $01,S
                        LONG   M
                        PEA    $4414
                        PHD
                        TSC                              ; Line 6
                        ADC    #$013E
                        TCS
                        LDA    $02,S
                        AND    #$000F
                        ORA    #$6660
                        STA    $02,S
                        SHORT  M
                        LDA    #$14
                        STA    $A7,S
                        LONG   M
                        TSC
                        ADC    #$0007
                        TCS
                        PHY
                        PEA    $1161
                        TSC                              ; Line 7
                        ADC    #$00A3
                        TCS
                        LDA    #$4441
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$6401
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$4044
                        STA    $A0,S
                        PHX
                        PEA    $4466
                        TSC                              ; Line 9
                        ADC    #$013E
                        TCS
                        TXA
                        STA    $A2,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $02,S
                        LDA    $04,S
                        AND    #$F000
                        ORA    #$0644
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$0F0F
                        ORA    #$6040
                        STA    $A4,S
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A1,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$1401
                        STA    $01,S
                        SHORT  M
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
; MARK: PLAYER_012A
PLAYER_012A             ENTRY
                        CLC                              ; 16x16, 265 bytes, 426 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1411                    ; Pattern #1 : 4
                        LDY    #$4411                    ; Pattern #2 : 3
                        LDA    #$1164                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$1144
                        STA    $A4,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$06
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$04
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    #$4164
                        STA    $A3,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$4104
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $A5,S
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$46
                        STA    $A7,S
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$06
                        STA    $02,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PHX
                        PEA    $6446
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$6601
                        STA    $9C,S
                        PEA    $1111
                        PEA    $6446
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$4044
                        STA    $9F,S
                        PHY
                        PEA    $1141
                        TSC                              ; Line 9
                        ADC    #$00A2
                        TCS
                        TYA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9C,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A1,S
                        LONG   M
                        PHY
                        PHX
                        TSC                              ; Line 11
                        ADC    #$013F
                        TCS
                        TXA
                        STA    $02,S
                        STA    $A1,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$01
                        STA    $01,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$06
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$4014
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
; MARK: PLAYER_013A
PLAYER_013A             ENTRY
                        CLC                              ; 16x16, 246 bytes, 400 cycles
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
                        LDY    #$1411                    ; Pattern #2 : 3
                        LDA    #$1144                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        TDC
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$4104
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $A5,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$40
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    #$6166
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $05,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6011
                        STA    $A0,S
                        PEA    $4414
                        PEA    $4166
                        TSC                              ; Line 8
                        ADC    #$00A3
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$4014
                        STA    $A1,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9C,S
                        LONG   M
                        PHX
                        PEA    $4416
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        TYA
                        STA    $9B,S
                        LDA    $9D,S
                        AND    #$000F
                        ORA    #$6640
                        STA    $9D,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9A,S
                        LONG   M
                        PEA    $4414
                        PEA    $4114
                        PHX
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$4004
                        STA    $A0,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$40
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
; MARK: PLAYER_014A
PLAYER_014A             ENTRY
                        CLC                              ; 16x16, 244 bytes, 394 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 6
                        LDY    #$1411                    ; Pattern #2 : 3
                        LDA    #$4114                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        LDA    #$1441
                        STA    $A5,S
                        SHORT  M
                        LDA    #$14
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $05,S
                        STA    $A5,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $A3,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$04
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    #$1461
                        STA    $04,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$6601
                        STA    $02,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$6044
                        STA    $06,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A1,S
                        SHORT  M
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9A,S
                        LONG   M
                        PHX
                        PHD
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A0,S
                        LONG   M
                        PHY
                        PEA    $1114
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$4404
                        STA    $9B,S
                        SHORT  M
                        LDA    #$66
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$40
                        STA    $9D,S
                        LONG   M
                        PEA    $4444
                        PHD
                        PHX
                        TSC                              ; Line 12
                        ADC    #$0141
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$06
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
; MARK: PLAYER_015A
PLAYER_015A             ENTRY
                        CLC                              ; 16x16, 208 bytes, 345 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 6
                        LDY    #$1411                    ; Pattern #2 : 4
                        LDA    #$1161                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        TXA
                        STA    $A5,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $06,S
                        SHORT  M
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $05,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $03,S
                        SHORT  M
                        LDA    #$41
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LONG   M
                        PHD
                        PEA    $6611
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6014
                        STA    $A0,S
                        PHY
                        PEA    $4114
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A5
                        TCS
                        LDA    #$4444
                        STA    $9C,S
                        TYA
                        STA    $A0,S
                        LDA    $9E,S
                        AND    #$00F0
                        ORA    #$4404
                        STA    $9E,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$04
                        STA    $9B,S
                        LONG   M
                        PHX
                        PHY
                        PHX
                        TSC                              ; Line 11
                        ADC    #$0141
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$4044
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
; MARK: PLAYER_016A
PLAYER_016A             ENTRY
                        CLC                              ; 16x16, 194 bytes, 318 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 6
                        LDY    #$4444                    ; Pattern #2 : 2
                        LDA    #$1144                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$4001
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $A6,S
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $05,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $03,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$40
                        STA    $07,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    #$14
                        STA    $A0,S
                        LONG   M
                        PEA    $4114
                        PEA    $6166
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$04
                        STA    $9B,S
                        LONG   M
                        PHD
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$06
                        STA    $9C,S
                        LONG   M
                        PEA    $4411
                        PHD
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        LDA    $9E,S
                        AND    #$00F0
                        ORA    #$4404
                        STA    $9E,S
                        PEA    $4611
                        PEA    $4166
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
; MARK: PLAYER_017A
PLAYER_017A             ENTRY
                        CLC                              ; 16x16, 188 bytes, 302 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1141                    ; Pattern #1 : 3
                        LDY    #$1111                    ; Pattern #2 : 3
                        LDA    #$1144                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 5
                        ADC    #$0320
                        TCS
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A6,S
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $A1,S
                        PEA    $4166
                        PEA    $1611
                        PHY
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        PEA    $1161
                        PEA    $6611
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        PEA    $4111
                        PEA    $4411
                        PEA    $4144
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        PEA    $1411
                        PHD
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9E,S
                        SHORT  M
                        LDA    #$46
                        STA    $A0,S
                        LONG   M
                        PEA    $1411
                        PEA    $4166
                        TSC                              ; Line 12
                        ADC    #$013E
                        TCS
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$4404
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
; MARK: PLAYER_018A
PLAYER_018A             ENTRY
                        CLC                              ; 16x16, 199 bytes, 320 cycles
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
                        LDY    #$1144                    ; Pattern #2 : 3
                        LDA    #$4444                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 5
                        ADC    #$0320
                        TCS
                        TXA
                        STA    $00,S
                        SHORT  M
                        LDA    #$11
                        STA    $02,S
                        LDA    #$66
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$00A3
                        TCS
                        PEA    $1611
                        PHY
                        TSC                              ; Line 7
                        ADC    #$00A7
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        PEA    $1161
                        PEA    $6611
                        PEA    $4144
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        PHY
                        PHD
                        TSC                              ; Line 9
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$06
                        STA    $9C,S
                        LONG   M
                        PEA    $4111
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$4104
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $9F,S
                        PEA    $1411
                        PEA    $1164
                        TSC                              ; Line 12
                        ADC    #$013E
                        TCS
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$4104
                        STA    $04,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$06
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
; MARK: PLAYER_019A
PLAYER_019A             ENTRY
                        CLC                              ; 16x16, 222 bytes, 359 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1144                    ; Pattern #1 : 3
                        LDY    #$1111                    ; Pattern #2 : 3
                        LDA    #$1141                    ; Pattern #3 : 3
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TDC
                        STA    $A0,S
                        SHORT  M
                        LDA    #$11
                        STA    $00,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0143
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$60
                        STA    $01,S
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$04
                        STA    $9D,S
                        LONG   M
                        PEA    $6611
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A7
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$4104
                        STA    $9B,S
                        PEA    $4444
                        PEA    $6646
                        PHD
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A0,S
                        PHY
                        PEA    $4444
                        TSC                              ; Line 8
                        ADC    #$00A3
                        TCS
                        PHY
                        PEA    $4144
                        TSC                              ; Line 9
                        ADC    #$00A5
                        TCS
                        LDA    #$1164
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $9F,S
                        PEA    $1114
                        PHX
                        TSC                              ; Line 11
                        ADC    #$013E
                        TCS
                        LDA    #$1441
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$1044
                        STA    $A4,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$06
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$4604
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
; MARK: PLAYER_020A
PLAYER_020A             ENTRY
                        CLC                              ; 16x16, 315 bytes, 496 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 2
                        LDY    #$1141                    ; Pattern #2 : 2
                        LDA    #$6616                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $A0,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $01,S
                        LDA    #$1611
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$6064
                        STA    $A4,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$10
                        STA    $03,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$04
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0145
                        TCS
                        LDA    #$1466
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$1404
                        STA    $9D,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$4044
                        STA    $A1,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$40
                        STA    $01,S
                        LONG   M
                        PEA    $4466
                        PEA    $1641
                        TSC                              ; Line 8
                        ADC    #$013F
                        TCS
                        LDA    #$1144
                        STA    $04,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$4404
                        STA    $02,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$4014
                        STA    $06,S
                        SHORT  M
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        LDA    #$1411
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$F0F0
                        ORA    #$0406
                        STA    $9C,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A0,S
                        LONG   M
                        PHX
                        PHY
                        TSC                              ; Line 11
                        ADC    #$013E
                        TCS
                        LDA    #$1164
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$4014
                        STA    $05,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $A3,S
                        SHORT  M
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$41
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$60
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
; MARK: PLAYER_021A
PLAYER_021A             ENTRY
                        CLC                              ; 16x16, 297 bytes, 470 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1141                    ; Pattern #1 : 3
                        LDY    #$1111                    ; Pattern #2 : 2
                        LDA    #$1411                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $A1,S
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $A1,S
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
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        LDA    #$1641
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$6064
                        STA    $A4,S
                        TSC                              ; Line 7
                        ADC    #$0145
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A1,S
                        LONG   M
                        PEA    $4464
                        PEA    $4641
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    #$44
                        STA    $A1,S
                        LONG   M
                        PEA    $4466
                        PEA    $4444
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $9C,S
                        AND    #$000F
                        ORA    #$4160
                        STA    $9C,S
                        PEA    $1441
                        PEA    $1444
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$4106
                        STA    $9B,S
                        PEA    $4411
                        PHY
                        TSC                              ; Line 11
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A0,S
                        LONG   M
                        PHD
                        PEA    $4111
                        TSC                              ; Line 12
                        ADC    #$00A3
                        TCS
                        LDA    #$1144
                        STA    $9D,S
                        SHORT  M
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$10
                        STA    $9F,S
                        LONG   M
                        PEA    $1114
                        PHX
                        TSC                              ; Line 14
                        ADC    #$013F
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$4404
                        STA    $02,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$06
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
; MARK: PLAYER_022A
PLAYER_022A             ENTRY
                        CLC                              ; 16x16, 284 bytes, 456 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1144                    ; Pattern #1 : 3
                        LDY    #$1141                    ; Pattern #2 : 3
                        LDA    #$1111                    ; Pattern #3 : 2
                        TCD
;--
                        LDA    $A2,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$1041
                        STA    $A2,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$01
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $02,S
                        TXA
                        STA    $A2,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $A2,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$10
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    #$6141
                        STA    $03,S
                        LDA    #$4666
                        STA    $A4,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$4404
                        STA    $A2,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$04
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        LDA    #$6644
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$4044
                        STA    $05,S
                        LDA    $A1,S
                        AND    #$F0F0
                        ORA    #$0406
                        STA    $A1,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$04
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        LDA    $9B,S
                        AND    #$F0F0
                        ORA    #$0406
                        STA    $9B,S
                        PEA    $4414
                        PEA    $4614
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    #$16
                        STA    $A0,S
                        LONG   M
                        PEA    $4411
                        PHD
                        TSC                              ; Line 11
                        ADC    #$00A3
                        TCS
                        PHY
                        PHX
                        TSC                              ; Line 12
                        ADC    #$00A4
                        TCS
                        LDA    #$1441
                        STA    $9D,S
                        SHORT  M
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$40
                        STA    $9F,S
                        LONG   M
                        PEA    $1114
                        PHY
                        TSC                              ; Line 14
                        ADC    #$013F
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$6004
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
; MARK: PLAYER_023A
PLAYER_023A             ENTRY
                        CLC                              ; 16x16, 303 bytes, 482 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1411                    ; Pattern #1 : 3
                        LDY    #$4114                    ; Pattern #2 : 2
                        LDA    #$1114                    ; Pattern #3 : 2
                        TCD
;--
                        LDA    $A2,S                     ; Line 0
                        AND    #$00F0
                        ORA    #$1104
                        STA    $A2,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$10
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $A2,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    #$6111
                        STA    $A3,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $02,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$10
                        STA    $04,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$04
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    #$6641
                        STA    $03,S
                        LDA    #$1666
                        STA    $A4,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$4604
                        STA    $A2,S
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        LDA    #$6644
                        STA    $03,S
                        TYA
                        STA    $A3,S
                        LDA    $01,S
                        AND    #$000F
                        ORA    #$4460
                        STA    $01,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$6011
                        STA    $05,S
                        LDA    $A1,S
                        AND    #$000F
                        ORA    #$4160
                        STA    $A1,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A5,S
                        TSC                              ; Line 10
                        ADC    #$0146
                        TCS
                        PEA    $1141
                        PHD
                        PEA    $1164
                        TSC                              ; Line 11
                        ADC    #$00A6
                        TCS
                        LDA    $9F,S
                        AND    #$F00F
                        ORA    #$0610
                        STA    $9F,S
                        PEA    $4414
                        PHD
                        PEA    $1144
                        TSC                              ; Line 12
                        ADC    #$00A4
                        TCS
                        LDA    $9F,S
                        AND    #$00F0
                        ORA    #$4104
                        STA    $9F,S
                        SHORT  M
                        LDA    #$44
                        STA    $9D,S
                        LONG   M
                        PHY
                        PEA    $4144
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
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
; MARK: PLAYER_024A
PLAYER_024A             ENTRY
                        CLC                              ; 16x16, 314 bytes, 506 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1441                    ; Pattern #1 : 4
                        LDY    #$1146                    ; Pattern #2 : 3
                        LDA    #$6166                    ; Pattern #3 : 2
                        TCD
;--
                        SHORT  M                         ; Line 0
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$01
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$1041
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$1041
                        STA    $A3,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $A3,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$1041
                        STA    $03,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$04
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $03,S
                        TDC
                        STA    $A3,S
                        LDA    $A1,S
                        AND    #$F00F
                        ORA    #$0460
                        STA    $A1,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$04
                        STA    $02,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $03,S
                        LDA    $01,S
                        AND    #$000F
                        ORA    #$4460
                        STA    $01,S
                        LDA    $05,S
                        AND    #$0F0F
                        ORA    #$6040
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$6011
                        STA    $A5,S
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$1011
                        STA    $A1,S
                        PHY
                        PEA    $1464
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$04
                        STA    $9C,S
                        LONG   M
                        PHX
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00A6
                        TCS
                        TXA
                        STA    $9D,S
                        LDA    $9A,S
                        AND    #$0FF0
                        ORA    #$4004
                        STA    $9A,S
                        SHORT  M
                        LDA    #$44
                        STA    $A0,S
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$04
                        STA    $9C,S
                        LONG   M
                        PEA    $1144
                        PHX
                        PEA    $1111
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$60
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$01
                        STA    $03,S
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
; MARK: PLAYER_025A
PLAYER_025A             ENTRY
                        CLC                              ; 16x16, 303 bytes, 482 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1141                    ; Pattern #1 : 3
                        LDY    #$4114                    ; Pattern #2 : 2
                        LDA    #$4111                    ; Pattern #3 : 2
                        TCD
;--
                        LDA    $A4,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$4011
                        STA    $A4,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$01
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A3,S
                        SHORT  M
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    #$1116
                        STA    $A3,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $03,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$40
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    #$1466
                        STA    $03,S
                        LDA    #$6661
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$4064
                        STA    $A4,S
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        LDA    #$4466
                        STA    $03,S
                        TYA
                        STA    $A3,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$1106
                        STA    $01,S
                        LDA    $05,S
                        AND    #$F000
                        ORA    #$0644
                        STA    $05,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A1,S
                        LDA    $A5,S
                        AND    #$F000
                        ORA    #$0614
                        STA    $A5,S
                        TSC                              ; Line 10
                        ADC    #$0146
                        TCS
                        PEA    $4611
                        PHD
                        PEA    $1411
                        TSC                              ; Line 11
                        ADC    #$00A6
                        TCS
                        LDA    $9B,S
                        AND    #$F00F
                        ORA    #$0160
                        STA    $9B,S
                        PEA    $4411
                        PHD
                        PEA    $4144
                        TSC                              ; Line 12
                        ADC    #$00A6
                        TCS
                        LDA    $9D,S
                        AND    #$0F00
                        ORA    #$4014
                        STA    $9D,S
                        SHORT  M
                        LDA    #$44
                        STA    $A0,S
                        LONG   M
                        PEA    $4414
                        PHY
                        TSC                              ; Line 14
                        ADC    #$013E
                        TCS
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
; MARK: PLAYER_026A
PLAYER_026A             ENTRY
                        CLC                              ; 16x16, 284 bytes, 456 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$4411                    ; Pattern #1 : 3
                        LDY    #$1411                    ; Pattern #2 : 3
                        LDA    #$1111                    ; Pattern #3 : 2
                        TCD
;--
                        LDA    $A4,S                     ; Line 0
                        AND    #$00F0
                        ORA    #$1401
                        STA    $A4,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$10
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $04,S
                        TXA
                        STA    $A4,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A3,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$01
                        STA    $03,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    #$1416
                        STA    $03,S
                        LDA    #$6664
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$4044
                        STA    $A4,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$40
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        LDA    #$6644
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$4044
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$0F0F
                        ORA    #$6040
                        STA    $A5,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$04
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    $A1,S
                        AND    #$0F0F
                        ORA    #$6040
                        STA    $A1,S
                        PEA    $4164
                        PEA    $4144
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    #$61
                        STA    $9D,S
                        LONG   M
                        PHD
                        PEA    $1144
                        TSC                              ; Line 11
                        ADC    #$00A5
                        TCS
                        PHX
                        PHY
                        TSC                              ; Line 12
                        ADC    #$00A4
                        TCS
                        LDA    #$1441
                        STA    $9F,S
                        SHORT  M
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$04
                        STA    $9E,S
                        LONG   M
                        PHY
                        PEA    $4111
                        TSC                              ; Line 14
                        ADC    #$013F
                        TCS
                        LDA    $04,S
                        AND    #$0FF0
                        ORA    #$4006
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
; MARK: PLAYER_027A
PLAYER_027A             ENTRY
                        CLC                              ; 16x16, 297 bytes, 470 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1411                    ; Pattern #1 : 3
                        LDY    #$1111                    ; Pattern #2 : 2
                        LDA    #$1141                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $05,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $A5,S
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A4,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$40
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $04,S
                        LDA    #$1461
                        STA    $A4,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$4606
                        STA    $A2,S
                        TSC                              ; Line 7
                        ADC    #$0145
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$04
                        STA    $9C,S
                        LONG   M
                        PEA    $1464
                        PEA    $4644
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    #$44
                        STA    $A0,S
                        LONG   M
                        PEA    $4444
                        PEA    $6644
                        TSC                              ; Line 9
                        ADC    #$00A3
                        TCS
                        LDA    $A1,S
                        AND    #$F000
                        ORA    #$0614
                        STA    $A1,S
                        PEA    $4114
                        PEA    $4144
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$6014
                        STA    $A1,S
                        PHY
                        PEA    $1144
                        TSC                              ; Line 11
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$60
                        STA    $9D,S
                        LONG   M
                        PEA    $1114
                        PHD
                        TSC                              ; Line 12
                        ADC    #$00A5
                        TCS
                        LDA    #$4411
                        STA    $9F,S
                        SHORT  M
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9E,S
                        LONG   M
                        PHX
                        PEA    $4111
                        TSC                              ; Line 14
                        ADC    #$013F
                        TCS
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$4044
                        STA    $04,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$60
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
; MARK: PLAYER_028A
PLAYER_028A             ENTRY
                        CLC                              ; 16x16, 320 bytes, 503 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 2
                        LDY    #$1411                    ; Pattern #2 : 2
                        LDA    #$6166                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $06,S
                        LDA    $A5,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A5,S
                        SHORT  M
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $05,S
                        LDA    #$6146
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $A5,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$01
                        STA    $04,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    #$6641
                        STA    $A2,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$4404
                        STA    $A0,S
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$4041
                        STA    $A4,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$04
                        STA    $01,S
                        LONG   M
                        TSC
                        ADC    #$0005
                        TCS
                        PEA    $1461
                        PEA    $6644
                        TSC                              ; Line 8
                        ADC    #$013F
                        TCS
                        LDA    #$4411
                        STA    $02,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$4104
                        STA    $00,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$4044
                        STA    $04,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    #$1141
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F0F
                        ORA    #$6040
                        STA    $A0,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9D,S
                        LONG   M
                        PHY
                        PHX
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        LDA    #$4611
                        STA    $03,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$4104
                        STA    $01,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $A2,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$14
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$06
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
; MARK: PLAYER_029A
PLAYER_029A             ENTRY
                        CLC                              ; 16x16, 227 bytes, 366 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$4411                    ; Pattern #1 : 3
                        LDY    #$1111                    ; Pattern #2 : 3
                        LDA    #$1411                    ; Pattern #3 : 3
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TDC
                        STA    $A6,S
                        SHORT  M
                        LDA    #$11
                        STA    $07,S
                        LDA    $A5,S
                        AND    #$F0
                        ORA    #$01
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$06
                        STA    $03,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$40
                        STA    $A7,S
                        LONG   M
                        TSC
                        ADC    #$0007
                        TCS
                        PHX
                        PEA    $1166
                        TSC                              ; Line 6
                        ADC    #$00A3
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$4014
                        STA    $9F,S
                        PHD
                        PEA    $6466
                        PEA    $4444
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9C,S
                        PEA    $4444
                        PHY
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        PEA    $4414
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A3
                        TCS
                        LDA    #$4611
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $9D,S
                        PHX
                        PEA    $4111
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        LDA    #$1441
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$4401
                        STA    $A2,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$60
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$4064
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
; MARK: PLAYER_030A
PLAYER_030A             ENTRY
                        CLC                              ; 16x16, 199 bytes, 320 cycles
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
                        LDY    #$4411                    ; Pattern #2 : 2
                        LDA    #$4444                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 5
                        ADC    #$0320
                        TCS
                        TXA
                        STA    $05,S
                        SHORT  M
                        LDA    #$11
                        STA    $07,S
                        LDA    #$44
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$00A6
                        TCS
                        PHX
                        PEA    $6166
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9A,S
                        PEA    $4414
                        PEA    $1166
                        PEA    $1611
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LONG   M
                        PHD
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00A3
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A1,S
                        LONG   M
                        PHY
                        PEA    $1114
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$4014
                        STA    $9F,S
                        PEA    $4611
                        PEA    $1141
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$000F
                        ORA    #$1460
                        STA    $01,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$40
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
; MARK: PLAYER_031A
PLAYER_031A             ENTRY
                        CLC                              ; 16x16, 190 bytes, 303 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 3
                        LDY    #$4411                    ; Pattern #2 : 2
                        LDA    #$1411                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 5
                        ADC    #$0320
                        TCS
                        LDA    $00,S
                        AND    #$0FF0
                        ORA    #$1001
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A0,S
                        TSC                              ; Line 6
                        ADC    #$00A7
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$1104
                        STA    $99,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$4011
                        STA    $9F,S
                        PHX
                        PEA    $1161
                        PEA    $6614
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$01
                        STA    $9B,S
                        LONG   M
                        PEA    $1166
                        PEA    $1611
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        PEA    $4414
                        PEA    $1144
                        PEA    $1114
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        PHY
                        PEA    $1141
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        LDA    #$1164
                        STA    $9D,S
                        SHORT  M
                        LDA    #$14
                        STA    $9F,S
                        LONG   M
                        PEA    $6614
                        PEA    $1141
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$4044
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
; MARK: PROGRESS_000A
PROGRESS_000A           ENTRY
                        CLC                              ; 16x8, 225 bytes, 362 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$8666                    ; Pattern #1 : 2
                        LDY    #$6366                    ; Pattern #2 : 2
                        LDA    #$3366                    ; Pattern #3 : 1
                        TCD
;--
                        LDA    $00,S                     ; Line 0
                        AND    #$000F
                        ORA    #$8880
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $02,S
                        LDA    $A0,S
                        AND    #$F00F
                        ORA    #$0880
                        STA    $A0,S
                        SHORT  M
                        LDA    #$66
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$6886
                        STA    $00,S
                        TXA
                        STA    $A1,S
                        TDC
                        STA    $A5,S
                        LDA    $05,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $05,S
                        LDA    $A3,S
                        AND    #$000F
                        ORA    #$6660
                        STA    $A3,S
                        SHORT  M
                        LDA    #$66
                        STA    $02,S
                        LDA    #$36
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0145
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $01,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A1,S
                        LONG   M
                        PHY
                        PEA    $6686
                        PEA    $6683
                        TSC                              ; Line 5
                        ADC    #$00A6
                        TCS
                        LDA    #$6668
                        STA    $9D,S
                        LDA    $9B,S
                        AND    #$000F
                        ORA    #$3680
                        STA    $9B,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$3033
                        STA    $9F,S
                        PHY
                        PEA    $3338
                        PEA    $3383
                        TSC                              ; Line 7
                        ADC    #$0141
                        TCS
                        LDA    #$3333
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$3033
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
; MARK: STAGE_000A
STAGE_000A              ENTRY
                        CLC                              ; 8x8, 151 bytes, 249 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$6666                    ; Pattern #1 : 6
                        LDY    #$6626                    ; Pattern #2 : 1
                        LDA    #$3333                    ; Pattern #3 : 1
                        TCD
;--
                        SHORT  M                         ; Line 0
                        LDA    $00,S
                        AND    #$0F
                        ORA    #$20
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A0,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$3326
                        STA    $00,S
                        LDA    $02,S
                        AND    #$000F
                        ORA    #$6630
                        STA    $02,S
                        TSC                              ; Line 3
                        ADC    #$00A3
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        TYA
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $9F,S
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$0141
                        TCS
                        TDC
                        STA    $01,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$0F
                        ORA    #$20
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A0,S
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
; MARK: TIMEPILOT_000A
TIMEPILOT_000A          ENTRY
                        CLC                              ; 170x20, 3242 bytes, 5685 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$7777                    ; Pattern #1 : 268
                        LDY    #$2222                    ; Pattern #2 : 112
                        LDA    #$7787                    ; Pattern #3 : 54
                        TCD
;--
                        TXA                              ; Line 0
                        STA    $12,S
                        STA    $44,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $03,S
                        LDA    $10,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $10,S
                        LDA    $1C,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $1C,S
                        LDA    $32,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $32,S
                        LDA    $46,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $46,S
                        LDA    $B7,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $B7,S
                        LDA    $C3,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $C3,S
                        LDA    $E2,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $E2,S
                        LDA    $F0,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $F0,S
                        SHORT  M
                        LDA    $0B,S
                        AND    #$F0
                        ORA    #$07
                        STA    $0B,S
                        LDA    $14,S
                        AND    #$0F
                        ORA    #$70
                        STA    $14,S
                        LDA    $17,S
                        AND    #$F0
                        ORA    #$07
                        STA    $17,S
                        LDA    $24,S
                        AND    #$0F
                        ORA    #$70
                        STA    $24,S
                        LDA    $2B,S
                        AND    #$F0
                        ORA    #$08
                        STA    $2B,S
                        LDA    $39,S
                        AND    #$0F
                        ORA    #$70
                        STA    $39,S
                        LDA    $3E,S
                        AND    #$0F
                        ORA    #$70
                        STA    $3E,S
                        LDA    $CB,S
                        AND    #$F0
                        ORA    #$08
                        STA    $CB,S
                        LDA    $D4,S
                        AND    #$0F
                        ORA    #$70
                        STA    $D4,S
                        LONG   M
                        TSC
                        ADC    #$000A
                        TCS
                        PHX
                        PHX
                        PHX
                        TSC
                        ADC    #$000B
                        TCS
                        PHX
                        PHX
                        TSC
                        ADC    #$0010
                        TCS
                        PHX
                        PHX
                        TSC
                        ADC    #$000C
                        TCS
                        PHX
                        PHX
                        PHX
                        TSC
                        ADC    #$0014
                        TCS
                        PHX
                        PHX
                        PHX
                        TSC
                        ADC    #$000D
                        TCS
                        PHX
                        PHD
                        TSC
                        ADC    #$0009
                        TCS
                        PHX
                        PHX
                        TSC
                        ADC    #$0017
                        TCS
                        PHX
                        PHX
                        PHX
                        PHD
                        TSC                              ; Line 1
                        ADC    #$006C
                        TCS
                        LDA    $AF,S
                        AND    #$0F00
                        ORA    #$8077
                        STA    $AF,S
                        LDA    $B7,S
                        AND    #$00F0
                        ORA    #$2208
                        STA    $B7,S
                        LDA    $C9,S
                        AND    #$0F00
                        ORA    #$2077
                        STA    $C9,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A1,S
                        LONG   M
                        PEA    $7877
                        PHX
                        PEA    $8778
                        PHX
                        PHX
                        PEA    $7877
                        PHX
                        PHX
                        PHX
                        TSC
                        ADC    #$0020
                        TCS
                        PHX
                        PHX
                        PHX
                        PEA    $8778
                        PHX
                        TSC
                        ADC    #$001B
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC
                        ADC    #$0013
                        TCS
                        PHX
                        PHX
                        PEA    $8778
                        PHX
                        PHD
                        TSC
                        ADC    #$001B
                        TCS
                        PHX
                        PHX
                        PHX
                        PEA    $8877
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$0071
                        TCS
                        LDA    $A1,S
                        AND    #$F00F
                        ORA    #$0780
                        STA    $A1,S
                        LDA    $A8,S
                        AND    #$000F
                        ORA    #$7780
                        STA    $A8,S
                        LDA    $B7,S
                        AND    #$00F0
                        ORA    #$2208
                        STA    $B7,S
                        LDA    $CD,S
                        AND    #$00F0
                        ORA    #$8708
                        STA    $CD,S
                        LDA    $DD,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $DD,S
                        SHORT  M
                        LDA    #$77
                        STA    $A3,S
                        LDA    $8E,S
                        AND    #$F0
                        ORA    #$07
                        STA    $8E,S
                        LDA    $B0,S
                        AND    #$0F
                        ORA    #$80
                        STA    $B0,S
                        LDA    $C5,S
                        AND    #$F0
                        ORA    #$08
                        STA    $C5,S
                        LONG   M
                        PEA    $7877
                        PHX
                        PEA    $8828
                        PHX
                        PHX
                        PEA    $7877
                        PEA    $2772
                        PHD
                        PEA    $8877
                        TSC
                        ADC    #$0020
                        TCS
                        PHY
                        PEA    $2282
                        PHX
                        PEA    $8228
                        PEA    $7277
                        PHX
                        TSC
                        ADC    #$0026
                        TCS
                        PHX
                        PEA    $8228
                        PHX
                        PEA    $7782
                        PHX
                        PEA    $2722
                        PEA    $2272
                        PHX
                        TSC
                        ADC    #$0025
                        TCS
                        PHD
                        PEA    $8877
                        PEA    $2722
                        PHX
                        PEA    $7877
                        PEA    $7722
                        PEA    $2277
                        PHD
                        TSC                              ; Line 3
                        ADC    #$0073
                        TCS
                        LDA    $A1,S
                        AND    #$F00F
                        ORA    #$0780
                        STA    $A1,S
                        LDA    $A8,S
                        AND    #$000F
                        ORA    #$7780
                        STA    $A8,S
                        LDA    $B7,S
                        AND    #$00F0
                        ORA    #$2208
                        STA    $B7,S
                        LDA    $CD,S
                        AND    #$00F0
                        ORA    #$8708
                        STA    $CD,S
                        LDA    $DD,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $DD,S
                        SHORT  M
                        LDA    #$77
                        STA    $A3,S
                        LDA    $8E,S
                        AND    #$F0
                        ORA    #$07
                        STA    $8E,S
                        LDA    $B0,S
                        AND    #$0F
                        ORA    #$80
                        STA    $B0,S
                        LDA    $C5,S
                        AND    #$F0
                        ORA    #$08
                        STA    $C5,S
                        LONG   M
                        PEA    $7877
                        PHX
                        PEA    $8822
                        PEA    $8877
                        PEA    $7788
                        PEA    $8877
                        PEA    $2778
                        PHX
                        PEA    $8878
                        TSC
                        ADC    #$0019
                        TCS
                        PEA    $2282
                        PHX
                        TSC
                        ADC    #$000C
                        TCS
                        PEA    $7722
                        PHY
                        PEA    $8277
                        TSC
                        ADC    #$001B
                        TCS
                        PHX
                        PEA    $8882
                        PHX
                        PEA    $2822
                        PEA    $2272
                        PHD
                        TSC
                        ADC    #$0011
                        TCS
                        PHX
                        PEA    $8822
                        TSC
                        ADC    #$0017
                        TCS
                        PEA    $8877
                        PEA    $7788
                        PEA    $2877
                        PEA    $8877
                        PEA    $7727
                        PHY
                        PEA    $7277
                        TSC                              ; Line 4
                        ADC    #$0072
                        TCS
                        LDA    #$8877
                        STA    $AA,S
                        TDC
                        STA    $B9,S
                        TXA
                        STA    $BF,S
                        STA    $C3,S
                        STA    $C8,S
                        LDA    $8E,S
                        AND    #$00F0
                        ORA    #$2802
                        STA    $8E,S
                        LDA    $AC,S
                        AND    #$000F
                        ORA    #$7780
                        STA    $AC,S
                        LDA    $AF,S
                        AND    #$0F00
                        ORA    #$8022
                        STA    $AF,S
                        LDA    $C1,S
                        AND    #$00F0
                        ORA    #$8802
                        STA    $C1,S
                        LDA    $C6,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $C6,S
                        LDA    $CD,S
                        AND    #$00F0
                        ORA    #$8708
                        STA    $CD,S
                        LDA    $CF,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $CF,S
                        SHORT  M
                        LDA    #$77
                        STA    $A9,S
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$07
                        STA    $9C,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A7,S
                        LDA    $BB,S
                        AND    #$0F
                        ORA    #$70
                        STA    $BB,S
                        LDA    $BE,S
                        AND    #$F0
                        ORA    #$08
                        STA    $BE,S
                        LDA    $DE,S
                        AND    #$0F
                        ORA    #$20
                        STA    $DE,S
                        LONG   M
                        PEA    $7877
                        PHX
                        PEA    $8822
                        PEA    $8878
                        PHD
                        PEA    $8877
                        PEA    $2778
                        PHX
                        PEA    $8878
                        TSC
                        ADC    #$0019
                        TCS
                        PEA    $2288
                        PHX
                        TSC
                        ADC    #$000C
                        TCS
                        PEA    $7722
                        PHY
                        PEA    $8277
                        TSC
                        ADC    #$001B
                        TCS
                        PHX
                        PEA    $8882
                        PHX
                        PEA    $2822
                        PEA    $2272
                        PHD
                        TSC
                        ADC    #$0011
                        TCS
                        PHX
                        PEA    $8828
                        TSC
                        ADC    #$0017
                        TCS
                        PEA    $8877
                        PEA    $7788
                        PEA    $2877
                        PEA    $8877
                        PEA    $7727
                        PHY
                        PEA    $7277
                        TSC                              ; Line 5
                        ADC    #$006D
                        TCS
                        TDC
                        STA    $BE,S
                        STA    $CD,S
                        TXA
                        STA    $C4,S
                        STA    $C8,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $A1,S
                        LDA    $AB,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $AB,S
                        LDA    $B4,S
                        AND    #$0F00
                        ORA    #$8022
                        STA    $B4,S
                        LDA    $D2,S
                        AND    #$00F0
                        ORA    #$8708
                        STA    $D2,S
                        LDA    $D4,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $D4,S
                        LDA    $DC,S
                        AND    #$000F
                        ORA    #$8820
                        STA    $DC,S
                        SHORT  M
                        LDA    #$77
                        STA    $B2,S
                        LDA    #$88
                        STA    $C7,S
                        STA    $CC,S
                        LDA    $C0,S
                        AND    #$0F
                        ORA    #$70
                        STA    $C0,S
                        LDA    $C3,S
                        AND    #$F0
                        ORA    #$07
                        STA    $C3,S
                        LDA    $D7,S
                        AND    #$F0
                        ORA    #$08
                        STA    $D7,S
                        LONG   M
                        PEA    $8288
                        PEA    $7877
                        PEA    $8728
                        PEA    $2282
                        PEA    $8878
                        PEA    $7788
                        TSC
                        ADC    #$0017
                        TCS
                        PEA    $8877
                        PHX
                        PHD
                        PEA    $7877
                        PHX
                        TSC
                        ADC    #$0041
                        TCS
                        PEA    $2288
                        PHX
                        PEA    $8888
                        PHY
                        PHX
                        PEA    $8722
                        TSC                              ; Line 6
                        ADC    #$0069
                        TCS
                        LDA    #$7788
                        STA    $C8,S
                        LDA    #$8788
                        STA    $CD,S
                        TXA
                        STA    $D5,S
                        LDA    $CA,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $CA,S
                        LDA    $CF,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $CF,S
                        LDA    $D3,S
                        AND    #$00F0
                        ORA    #$8708
                        STA    $D3,S
                        SHORT  M
                        LDA    #$22
                        STA    $9C,S
                        LDA    #$78
                        STA    $B3,S
                        LDA    $9A,S
                        AND    #$0F
                        ORA    #$80
                        STA    $9A,S
                        LDA    $AC,S
                        AND    #$0F
                        ORA    #$80
                        STA    $AC,S
                        LDA    $D8,S
                        AND    #$F0
                        ORA    #$08
                        STA    $D8,S
                        LDA    $DE,S
                        AND    #$F0
                        ORA    #$08
                        STA    $DE,S
                        LONG   M
                        PEA    $8888
                        PHD
                        PHY
                        PEA    $8888
                        PEA    $7877
                        PEA    $2722
                        TSC
                        ADC    #$0017
                        TCS
                        PHX
                        PHX
                        PEA    $8778
                        PHD
                        TSC
                        ADC    #$000F
                        TCS
                        PEA    $8788
                        PHX
                        TSC
                        ADC    #$002E
                        TCS
                        PHX
                        PEA    $8788
                        TSC
                        ADC    #$000A
                        TCS
                        PEA    $7277
                        PEA    $8788
                        TSC                              ; Line 7
                        ADC    #$005B
                        TCS
                        LDA    #$7877
                        STA    $A4,S
                        LDA    #$8788
                        STA    $CF,S
                        STA    $D4,S
                        TDC
                        STA    $DC,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A6,S
                        LDA    $B5,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $B5,S
                        LDA    $D1,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $D1,S
                        LDA    $D6,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $D6,S
                        LDA    $DA,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $DA,S
                        LDA    $E4,S
                        AND    #$F00F
                        ORA    #$0870
                        STA    $E4,S
                        SHORT  M
                        LDA    $B3,S
                        AND    #$0F
                        ORA    #$80
                        STA    $B3,S
                        LONG   M
                        PEA    $8888
                        PHX
                        TSC
                        ADC    #$000B
                        TCS
                        PEA    $8888
                        PHX
                        TSC
                        ADC    #$000F
                        TCS
                        PEA    $7877
                        PEA    $8777
                        PEA    $7778
                        PHD
                        PHX
                        TSC
                        ADC    #$0011
                        TCS
                        PHX
                        PHX
                        TSC
                        ADC    #$0018
                        TCS
                        PEA    $7277
                        PHX
                        PHX
                        PHD
                        TSC
                        ADC    #$001E
                        TCS
                        PHX
                        PEA    $8788
                        TSC
                        ADC    #$000A
                        TCS
                        PHX
                        PEA    $8888
                        TSC                              ; Line 8
                        ADC    #$005B
                        TCS
                        LDA    #$7877
                        STA    $9D,S
                        STA    $A4,S
                        LDA    #$8788
                        STA    $CF,S
                        STA    $D4,S
                        TDC
                        STA    $DC,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $9F,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A6,S
                        LDA    $B5,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $B5,S
                        LDA    $D1,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $D1,S
                        LDA    $D6,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $D6,S
                        LDA    $DA,S
                        AND    #$00F0
                        ORA    #$8808
                        STA    $DA,S
                        LDA    $E4,S
                        AND    #$F00F
                        ORA    #$0870
                        STA    $E4,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$07
                        STA    $9C,S
                        LDA    $B3,S
                        AND    #$0F
                        ORA    #$80
                        STA    $B3,S
                        LONG   M
                        PEA    $8888
                        PHX
                        TSC
                        ADC    #$0016
                        TCS
                        PEA    $7877
                        PEA    $8778
                        PEA    $7778
                        PHD
                        PHX
                        TSC
                        ADC    #$0012
                        TCS
                        PEA    $7877
                        PHX
                        TSC
                        ADC    #$0017
                        TCS
                        PEA    $2272
                        PHX
                        PHX
                        PHD
                        TSC
                        ADC    #$001E
                        TCS
                        PHX
                        PEA    $8888
                        TSC
                        ADC    #$000A
                        TCS
                        PHX
                        PEA    $8888
                        TSC                              ; Line 9
                        ADC    #$006D
                        TCS
                        LDA    #$8877
                        STA    $8B,S
                        LDA    #$8878
                        STA    $93,S
                        LDA    #$8788
                        STA    $C2,S
                        LDA    #$8888
                        STA    $D5,S
                        LDA    $8D,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $8D,S
                        LDA    $91,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $91,S
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $96,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$8078
                        STA    $A0,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $A3,S
                        LDA    $BA,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $BA,S
                        LDA    $BD,S
                        AND    #$00F0
                        ORA    #$8708
                        STA    $BD,S
                        LDA    $BF,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $BF,S
                        LDA    $C4,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $C4,S
                        LDA    $D7,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $D7,S
                        SHORT  M
                        LDA    $8A,S
                        AND    #$F0
                        ORA    #$07
                        STA    $8A,S
                        LDA    $C8,S
                        AND    #$F0
                        ORA    #$07
                        STA    $C8,S
                        LDA    $D2,S
                        AND    #$0F
                        ORA    #$70
                        STA    $D2,S
                        LDA    $D4,S
                        AND    #$F0
                        ORA    #$08
                        STA    $D4,S
                        LONG   M
                        PEA    $7877
                        PEA    $8778
                        PEA    $7778
                        PHD
                        PHX
                        TSC
                        ADC    #$0012
                        TCS
                        PEA    $7877
                        PHX
                        TSC
                        ADC    #$0017
                        TCS
                        PEA    $2272
                        PHX
                        PHX
                        PHD
                        TSC
                        ADC    #$001E
                        TCS
                        PHX
                        PEA    $8888
                        TSC
                        ADC    #$000A
                        TCS
                        PHX
                        PEA    $8888
                        TSC                              ; Line 10
                        ADC    #$006C
                        TCS
                        LDA    #$8878
                        STA    $94,S
                        TXA
                        STA    $C5,S
                        LDA    #$8888
                        STA    $D6,S
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $92,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $A4,S
                        LDA    $BE,S
                        AND    #$00F0
                        ORA    #$8708
                        STA    $BE,S
                        LDA    $C0,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $C0,S
                        LDA    $D8,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $D8,S
                        SHORT  M
                        LDA    #$88
                        STA    $C4,S
                        LDA    #$87
                        STA    $C9,S
                        LDA    $97,S
                        AND    #$F0
                        ORA    #$07
                        STA    $97,S
                        LDA    $BB,S
                        AND    #$0F
                        ORA    #$20
                        STA    $BB,S
                        LDA    $CF,S
                        AND    #$F0
                        ORA    #$08
                        STA    $CF,S
                        LDA    $D5,S
                        AND    #$F0
                        ORA    #$08
                        STA    $D5,S
                        LONG   M
                        PHD
                        PEA    $7877
                        PHX
                        PEA    $8778
                        TSC
                        ADC    #$0011
                        TCS
                        PEA    $7877
                        PEA    $8778
                        TSC
                        ADC    #$0015
                        TCS
                        PHY
                        PEA    $2272
                        PHD
                        TSC
                        ADC    #$0019
                        TCS
                        PHX
                        PEA    $8788
                        TSC
                        ADC    #$0009
                        TCS
                        PHX
                        PEA    $8888
                        TSC                              ; Line 11
                        ADC    #$0060
                        TCS
                        LDA    #$7877
                        STA    $9D,S
                        TXA
                        STA    $A4,S
                        STA    $D7,S
                        TDC
                        STA    $C7,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $9F,S
                        LDA    $A6,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A6,S
                        LDA    $B6,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $B6,S
                        LDA    $D0,S
                        AND    #$00F0
                        ORA    #$8708
                        STA    $D0,S
                        LDA    $D2,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $D2,S
                        LDA    $E0,S
                        AND    #$F00F
                        ORA    #$0870
                        STA    $E0,S
                        SHORT  M
                        LDA    #$28
                        STA    $B3,S
                        LDA    #$88
                        STA    $D6,S
                        LDA    #$87
                        STA    $DB,S
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$07
                        STA    $9C,S
                        LDA    $C9,S
                        AND    #$0F
                        ORA    #$70
                        STA    $C9,S
                        LDA    $EC,S
                        AND    #$0F
                        ORA    #$70
                        STA    $EC,S
                        LONG   M
                        PEA    $8888
                        PHX
                        TSC
                        ADC    #$0017
                        TCS
                        PEA    $8877
                        PEA    $7788
                        PEA    $7877
                        PHD
                        PEA    $7877
                        TSC
                        ADC    #$0012
                        TCS
                        PEA    $7827
                        PEA    $8278
                        TSC
                        ADC    #$0015
                        TCS
                        PHY
                        PEA    $2272
                        PHD
                        TSC
                        ADC    #$0019
                        TCS
                        PHX
                        PEA    $8788
                        TSC
                        ADC    #$000A
                        TCS
                        PHX
                        PEA    $8788
                        TSC                              ; Line 12
                        ADC    #$0071
                        TCS
                        LDA    #$2277
                        STA    $8B,S
                        LDA    #$7877
                        STA    $A5,S
                        STA    $AA,S
                        TXA
                        STA    $B5,S
                        STA    $C0,S
                        STA    $C5,S
                        STA    $D2,S
                        LDA    $89,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $89,S
                        LDA    $8D,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $8D,S
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $9A,S
                        LDA    $A7,S
                        AND    #$F00F
                        ORA    #$0280
                        STA    $A7,S
                        LDA    $BE,S
                        AND    #$00F0
                        ORA    #$8708
                        STA    $BE,S
                        LDA    $D0,S
                        AND    #$00F0
                        ORA    #$7708
                        STA    $D0,S
                        SHORT  M
                        LDA    #$77
                        STA    $A4,S
                        STA    $B7,S
                        LDA    #$28
                        STA    $A9,S
                        LDA    #$88
                        STA    $C4,S
                        STA    $D6,S
                        LDA    $95,S
                        AND    #$0F
                        ORA    #$80
                        STA    $95,S
                        LONG   M
                        PHX
                        PEA    $8888
                        PHX
                        PEA    $8778
                        PHX
                        TSC
                        ADC    #$0015
                        TCS
                        PEA    $7877
                        PEA    $2822
                        PEA    $8278
                        TSC
                        ADC    #$0028
                        TCS
                        PHX
                        PEA    $8878
                        TSC
                        ADC    #$000A
                        TCS
                        PHX
                        PEA    $8788
                        TSC
                        ADC    #$000A
                        TCS
                        PHX
                        PEA    $8888
                        TSC                              ; Line 13
                        ADC    #$005F
                        TCS
                        LDA    #$7877
                        STA    $B1,S
                        STA    $B6,S
                        TXA
                        STA    $C1,S
                        STA    $CC,S
                        STA    $D1,S
                        STA    $DE,S
                        LDA    $A6,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $A6,S
                        LDA    $B3,S
                        AND    #$F00F
                        ORA    #$0280
                        STA    $B3,S
                        LDA    $CA,S
                        AND    #$00F0
                        ORA    #$8708
                        STA    $CA,S
                        LDA    $DC,S
                        AND    #$00F0
                        ORA    #$7708
                        STA    $DC,S
                        SHORT  M
                        LDA    #$77
                        STA    $B0,S
                        STA    $C3,S
                        LDA    #$28
                        STA    $B5,S
                        LDA    #$88
                        STA    $D0,S
                        STA    $E2,S
                        LDA    $95,S
                        AND    #$F0
                        ORA    #$07
                        STA    $95,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$80
                        STA    $A1,S
                        LONG   M
                        PEA    $2872
                        PHX
                        TSC
                        ADC    #$0009
                        TCS
                        PEA    $2272
                        PHX
                        TSC
                        ADC    #$000C
                        TCS
                        PEA    $2277
                        PHD
                        PEA    $8877
                        TSC
                        ADC    #$0033
                        TCS
                        PHX
                        PEA    $7788
                        PEA    $7877
                        TSC
                        ADC    #$0012
                        TCS
                        PHX
                        PEA    $2788
                        TSC                              ; Line 14
                        ADC    #$0057
                        TCS
                        TXA
                        STA    $C8,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $9B,S
                        LDA    $B5,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $B5,S
                        LDA    $C6,S
                        AND    #$00F0
                        ORA    #$7708
                        STA    $C6,S
                        LDA    $CA,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $CA,S
                        LDA    $E5,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $E5,S
                        LDA    $E9,S
                        AND    #$00F0
                        ORA    #$8802
                        STA    $E9,S
                        SHORT  M
                        LDA    #$22
                        STA    $D1,S
                        LONG   M
                        PEA    $2822
                        PHX
                        TSC
                        ADC    #$000B
                        TCS
                        PEA    $2272
                        PHX
                        TSC
                        ADC    #$0009
                        TCS
                        PEA    $7277
                        PHX
                        TSC
                        ADC    #$000C
                        TCS
                        PEA    $2277
                        PHD
                        PEA    $8877
                        TSC
                        ADC    #$0033
                        TCS
                        PHX
                        PEA    $7788
                        PEA    $7877
                        TSC
                        ADC    #$0012
                        TCS
                        PHX
                        PEA    $2722
                        TSC                              ; Line 15
                        ADC    #$0057
                        TCS
                        TXA
                        STA    $C8,S
                        LDA    $A1,S
                        AND    #$F00F
                        ORA    #$0720
                        STA    $A1,S
                        LDA    $C6,S
                        AND    #$00F0
                        ORA    #$7708
                        STA    $C6,S
                        LDA    $CA,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $CA,S
                        LDA    $D0,S
                        AND    #$00F0
                        ORA    #$8802
                        STA    $D0,S
                        SHORT  M
                        LDA    #$87
                        STA    $D7,S
                        LDA    $E9,S
                        AND    #$F0
                        ORA    #$08
                        STA    $E9,S
                        LONG   M
                        PEA    $8277
                        PHX
                        TSC
                        ADC    #$0018
                        TCS
                        PHX
                        PHX
                        PEA    $7778
                        PHD
                        PHX
                        PHX
                        PEA    $2778
                        PHX
                        PHX
                        TSC
                        ADC    #$001C
                        TCS
                        PEA    $7877
                        PHX
                        PHX
                        PHX
                        TSC
                        ADC    #$001F
                        TCS
                        PHX
                        PHX
                        TSC
                        ADC    #$0013
                        TCS
                        PHX
                        PHX
                        PHD
                        PEA    $8878
                        PHX
                        PHX
                        PHX
                        TSC
                        ADC    #$0018
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 16
                        ADC    #$0056
                        TCS
                        TYA
                        STA    $C8,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$8088
                        STA    $A0,S
                        LDA    $C6,S
                        AND    #$00F0
                        ORA    #$2208
                        STA    $C6,S
                        LDA    $CA,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $CA,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9B,S
                        LDA    $D0,S
                        AND    #$F0
                        ORA    #$08
                        STA    $D0,S
                        LDA    $EF,S
                        AND    #$0F
                        ORA    #$20
                        STA    $EF,S
                        LONG   M
                        PEA    $8878
                        PHX
                        PHX
                        TSC
                        ADC    #$0024
                        TCS
                        PEA    $7877
                        PHX
                        PHX
                        PHX
                        PHD
                        PHX
                        PHX
                        PEA    $7788
                        PHD
                        PEA    $7877
                        PHX
                        PEA    $7788
                        PHX
                        PHX
                        TSC
                        ADC    #$0033
                        TCS
                        PHX
                        PHX
                        TSC
                        ADC    #$0014
                        TCS
                        PHX
                        PHX
                        PEA    $7722
                        PEA    $8878
                        PHX
                        PHX
                        PHX
                        TSC
                        ADC    #$0018
                        TCS
                        PHX
                        PHX
                        PEA    $8788
                        TSC                              ; Line 17
                        ADC    #$0056
                        TCS
                        TYA
                        STA    $AF,S
                        STA    $B4,S
                        STA    $C9,S
                        STA    $EC,S
                        LDA    $B1,S
                        AND    #$F00F
                        ORA    #$0280
                        STA    $B1,S
                        LDA    $B6,S
                        AND    #$F00F
                        ORA    #$0280
                        STA    $B6,S
                        LDA    $C7,S
                        AND    #$00F0
                        ORA    #$2208
                        STA    $C7,S
                        LDA    $CB,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $CB,S
                        LDA    $D6,S
                        AND    #$000F
                        ORA    #$8820
                        STA    $D6,S
                        LDA    $EA,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $EA,S
                        LDA    $EE,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $EE,S
                        SHORT  M
                        LDA    #$22
                        STA    $A1,S
                        STA    $A5,S
                        STA    $B3,S
                        LDA    $AE,S
                        AND    #$0F
                        ORA    #$20
                        STA    $AE,S
                        LDA    $D1,S
                        AND    #$F0
                        ORA    #$08
                        STA    $D1,S
                        LDA    $E0,S
                        AND    #$F0
                        ORA    #$08
                        STA    $E0,S
                        LONG   M
                        PHY
                        PHY
                        TSC
                        ADC    #$0023
                        TCS
                        PEA    $2822
                        PHY
                        PHY
                        PHY
                        PEA    $2282
                        PHY
                        PHY
                        PEA    $8228
                        PEA    $2282
                        PHY
                        PHY
                        PEA    $8228
                        PHY
                        PHY
                        TSC
                        ADC    #$0042
                        TCS
                        PHY
                        PHY
                        PEA    $8882
                        PEA    $2822
                        PHY
                        PHY
                        PEA    $2282
                        PEA    $8822
                        PHY
                        PEA    $2288
                        TSC
                        ADC    #$001E
                        TCS
                        PHY
                        PHY
                        PEA    $8888
                        TSC                              ; Line 18
                        ADC    #$0057
                        TCS
                        TYA
                        STA    $AF,S
                        STA    $B4,S
                        STA    $C9,S
                        STA    $EC,S
                        LDA    $B1,S
                        AND    #$F00F
                        ORA    #$0280
                        STA    $B1,S
                        LDA    $B6,S
                        AND    #$F00F
                        ORA    #$0280
                        STA    $B6,S
                        LDA    $C7,S
                        AND    #$00F0
                        ORA    #$2208
                        STA    $C7,S
                        LDA    $CB,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $CB,S
                        LDA    $D6,S
                        AND    #$000F
                        ORA    #$8820
                        STA    $D6,S
                        LDA    $EA,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $EA,S
                        LDA    $EE,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $EE,S
                        SHORT  M
                        LDA    #$22
                        STA    $A1,S
                        STA    $A5,S
                        STA    $B3,S
                        LDA    $AE,S
                        AND    #$0F
                        ORA    #$20
                        STA    $AE,S
                        LDA    $D1,S
                        AND    #$F0
                        ORA    #$08
                        STA    $D1,S
                        LDA    $E0,S
                        AND    #$F0
                        ORA    #$08
                        STA    $E0,S
                        LONG   M
                        PHY
                        PHY
                        TSC
                        ADC    #$0011
                        TCS
                        PHY
                        PHY
                        PEA    $8822
                        PHY
                        TSC
                        ADC    #$001A
                        TCS
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC
                        ADC    #$001E
                        TCS
                        PHY
                        PHY
                        TSC
                        ADC    #$000C
                        TCS
                        PHY
                        PHY
                        PHY
                        TSC
                        ADC    #$000D
                        TCS
                        PHY
                        PHY
                        TSC                              ; Line 19
                        ADC    #$0060
                        TCS
                        PHY
                        PHY
                        TSC
                        ADC    #$0011
                        TCS
                        PHY
                        PHY
                        PEA    $8822
                        PHY
                        TSC
                        ADC    #$001A
                        TCS
                        PHY
                        PHY
                        PHY
                        PHY
                        TSC
                        ADC    #$001E
                        TCS
                        PHY
                        PHY
                        TSC
                        ADC    #$000C
                        TCS
                        PHY
                        PHY
                        PHY
                        TSC
                        ADC    #$000D
                        TCS
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
; MARK: TPSMALL_000A
TPSMALL_000A            ENTRY
                        CLC                              ; 96x11, 1417 bytes, 2326 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$7777                    ; Pattern #1 : 33
                        LDY    #$2222                    ; Pattern #2 : 23
                        LDA    #$7787                    ; Pattern #3 : 11
                        TCD
;--
                        TXA                              ; Line 0
                        STA    $07,S
                        STA    $1E,S
                        STA    $21,S
                        LDA    $0A,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $0A,S
                        LDA    $0D,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $0D,S
                        LDA    $13,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $13,S
                        LDA    $27,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $27,S
                        LDA    $B3,S
                        AND    #$0F00
                        ORA    #$7022
                        STA    $B3,S
                        LDA    $B8,S
                        AND    #$00F0
                        ORA    #$2708
                        STA    $B8,S
                        LDA    $C2,S
                        AND    #$0F00
                        ORA    #$2077
                        STA    $C2,S
                        LDA    $C5,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $C5,S
                        LDA    $CD,S
                        AND    #$0F00
                        ORA    #$7087
                        STA    $CD,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$07
                        STA    $06,S
                        LDA    $09,S
                        AND    #$F0
                        ORA    #$07
                        STA    $09,S
                        LDA    $18,S
                        AND    #$F0
                        ORA    #$08
                        STA    $18,S
                        LDA    $20,S
                        AND    #$0F
                        ORA    #$70
                        STA    $20,S
                        LDA    $23,S
                        AND    #$0F
                        ORA    #$70
                        STA    $23,S
                        LDA    $26,S
                        AND    #$F0
                        ORA    #$07
                        STA    $26,S
                        LDA    $2D,S
                        AND    #$0F
                        ORA    #$70
                        STA    $2D,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A1,S
                        LONG   M
                        TSC
                        ADC    #$0005
                        TCS
                        PHX
                        PHX
                        TSC
                        ADC    #$0011
                        TCS
                        PHX
                        PHX
                        TSC
                        ADC    #$000E
                        TCS
                        PHX
                        PHX
                        TSC
                        ADC    #$0014
                        TCS
                        PHX
                        PHD
                        TSC                              ; Line 1
                        ADC    #$0083
                        TCS
                        LDA    #$2278
                        STA    $A3,S
                        TYA
                        STA    $A7,S
                        LDA    #$7788
                        STA    $B6,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $A1,S
                        LDA    $A5,S
                        AND    #$00F0
                        ORA    #$7807
                        STA    $A5,S
                        LDA    $AD,S
                        AND    #$00F0
                        ORA    #$2708
                        STA    $AD,S
                        LDA    $C2,S
                        AND    #$0F00
                        ORA    #$7087
                        STA    $C2,S
                        SHORT  M
                        LDA    $96,S
                        AND    #$F0
                        ORA    #$07
                        STA    $96,S
                        LDA    $A9,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A9,S
                        LDA    $B5,S
                        AND    #$F0
                        ORA    #$08
                        STA    $B5,S
                        LONG   M
                        PEA    $7877
                        PEA    $8772
                        PHX
                        PEA    $7722
                        PEA    $7778
                        TSC
                        ADC    #$0011
                        TCS
                        PEA    $2278
                        PEA    $2728
                        PHX
                        TSC
                        ADC    #$0015
                        TCS
                        PEA    $2728
                        PEA    $7727
                        PEA    $7727
                        PEA    $2277
                        TSC
                        ADC    #$0013
                        TCS
                        PEA    $7822
                        PEA    $7778
                        PEA    $7722
                        TSC                              ; Line 2
                        ADC    #$0085
                        TCS
                        LDA    #$8778
                        STA    $A6,S
                        LDA    #$7788
                        STA    $BD,S
                        LDA    #$8788
                        STA    $C0,S
                        LDA    $9D,S
                        AND    #$F00F
                        ORA    #$0780
                        STA    $9D,S
                        LDA    $A4,S
                        AND    #$F00F
                        ORA    #$0780
                        STA    $A4,S
                        LDA    $AE,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $AE,S
                        LDA    $B1,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $B1,S
                        LDA    $B3,S
                        AND    #$00F0
                        ORA    #$7708
                        STA    $B3,S
                        LDA    $B6,S
                        AND    #$00F0
                        ORA    #$7708
                        STA    $B6,S
                        LDA    $BA,S
                        AND    #$0F00
                        ORA    #$7087
                        STA    $BA,S
                        SHORT  M
                        LDA    #$87
                        STA    $9F,S
                        LDA    $96,S
                        AND    #$F0
                        ORA    #$02
                        STA    $96,S
                        LDA    $A9,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A9,S
                        LDA    $BF,S
                        AND    #$0F
                        ORA    #$70
                        STA    $BF,S
                        LDA    $C2,S
                        AND    #$0F
                        ORA    #$70
                        STA    $C2,S
                        LONG   M
                        PEA    $7877
                        PEA    $8782
                        PEA    $7887
                        PEA    $7882
                        PEA    $7788
                        TSC
                        ADC    #$001E
                        TCS
                        PEA    $7728
                        PEA    $7728
                        PEA    $2277
                        TSC
                        ADC    #$0013
                        TCS
                        PEA    $7788
                        PEA    $8777
                        PEA    $2722
                        PEA    $7287
                        TSC                              ; Line 3
                        ADC    #$0083
                        TCS
                        LDA    #$8877
                        STA    $9F,S
                        TXA
                        STA    $A9,S
                        LDA    #$7788
                        STA    $BE,S
                        STA    $C1,S
                        LDA    #$8788
                        STA    $C4,S
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$7807
                        STA    $9B,S
                        LDA    $B7,S
                        AND    #$00F0
                        ORA    #$8708
                        STA    $B7,S
                        LDA    $B9,S
                        AND    #$F00F
                        ORA    #$0870
                        STA    $B9,S
                        LDA    $BB,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $BB,S
                        SHORT  M
                        LDA    #$77
                        STA    $AB,S
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$80
                        STA    $9D,S
                        LDA    $B2,S
                        AND    #$F0
                        ORA    #$07
                        STA    $B2,S
                        LDA    $C3,S
                        AND    #$0F
                        ORA    #$70
                        STA    $C3,S
                        LDA    $C6,S
                        AND    #$0F
                        ORA    #$70
                        STA    $C6,S
                        LONG   M
                        PEA    $7887
                        PEA    $2288
                        PEA    $7827
                        TSC
                        ADC    #$000D
                        TCS
                        PEA    $7877
                        PEA    $7778
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        LDA    #$8877
                        STA    $94,S
                        STA    $98,S
                        LDA    #$7788
                        STA    $A3,S
                        STA    $BA,S
                        STA    $BE,S
                        TYA
                        STA    $AD,S
                        LDA    #$7778
                        STA    $B7,S
                        LDA    $AB,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $AB,S
                        LDA    $B2,S
                        AND    #$F00F
                        ORA    #$0870
                        STA    $B2,S
                        LDA    $B4,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $B4,S
                        SHORT  M
                        LDA    #$77
                        STA    $A2,S
                        LDA    #$87
                        STA    $B1,S
                        LDA    $AF,S
                        AND    #$0F
                        ORA    #$20
                        STA    $AF,S
                        LDA    $B9,S
                        AND    #$0F
                        ORA    #$70
                        STA    $B9,S
                        LDA    $BC,S
                        AND    #$0F
                        ORA    #$70
                        STA    $BC,S
                        LONG   M
                        PEA    $7887
                        PEA    $7878
                        PEA    $8777
                        TSC
                        ADC    #$0015
                        TCS
                        PEA    $2277
                        PHX
                        TSC                              ; Line 5
                        ADC    #$0095
                        TCS
                        LDA    #$8877
                        STA    $94,S
                        STA    $98,S
                        STA    $A2,S
                        TYA
                        STA    $AD,S
                        LDA    #$7778
                        STA    $B7,S
                        TDC
                        STA    $BB,S
                        LDA    #$7788
                        STA    $BE,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$8077
                        STA    $9F,S
                        LDA    $AB,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $AB,S
                        LDA    $B1,S
                        AND    #$0F00
                        ORA    #$7087
                        STA    $B1,S
                        LDA    $B5,S
                        AND    #$F00F
                        ORA    #$0870
                        STA    $B5,S
                        LDA    $B9,S
                        AND    #$F00F
                        ORA    #$0870
                        STA    $B9,S
                        SHORT  M
                        LDA    #$27
                        STA    $A4,S
                        LDA    #$87
                        STA    $B4,S
                        LDA    $93,S
                        AND    #$F0
                        ORA    #$07
                        STA    $93,S
                        LONG   M
                        PEA    $7887
                        PEA    $7877
                        PEA    $8777
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        LDA    #$7277
                        STA    $95,S
                        STA    $99,S
                        STA    $9C,S
                        TDC
                        STA    $A0,S
                        STA    $B3,S
                        STA    $BA,S
                        LDA    #$8877
                        STA    $A4,S
                        TXA
                        STA    $BD,S
                        LDA    #$2788
                        STA    $C0,S
                        LDA    $9E,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $9E,S
                        LDA    $A7,S
                        AND    #$0F00
                        ORA    #$8077
                        STA    $A7,S
                        LDA    $AD,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $AD,S
                        LDA    $B7,S
                        AND    #$F00F
                        ORA    #$0770
                        STA    $B7,S
                        SHORT  M
                        LDA    #$87
                        STA    $B6,S
                        LDA    #$78
                        STA    $B9,S
                        LDA    #$77
                        STA    $C2,S
                        LDA    $97,S
                        AND    #$0F
                        ORA    #$80
                        STA    $97,S
                        LDA    $9B,S
                        AND    #$0F
                        ORA    #$80
                        STA    $9B,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A2,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A6,S
                        LONG   M
                        PEA    $8877
                        PEA    $8777
                        TSC                              ; Line 8
                        ADC    #$0138
                        TCS
                        TXA
                        STA    $01,S
                        STA    $1F,S
                        TYA
                        STA    $A1,S
                        STA    $CD,S
                        LDA    #$2288
                        STA    $CC,S
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0720
                        STA    $03,S
                        LDA    $0E,S
                        AND    #$000F
                        ORA    #$7770
                        STA    $0E,S
                        LDA    $18,S
                        AND    #$00F0
                        ORA    #$7708
                        STA    $18,S
                        LDA    $1A,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $1A,S
                        LDA    $2C,S
                        AND    #$00F0
                        ORA    #$7708
                        STA    $2C,S
                        LDA    $2E,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $2E,S
                        LDA    $A3,S
                        AND    #$F00F
                        ORA    #$0280
                        STA    $A3,S
                        LDA    $B8,S
                        AND    #$00F0
                        ORA    #$2208
                        STA    $B8,S
                        LDA    $BA,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $BA,S
                        LDA    $CF,S
                        AND    #$F00F
                        ORA    #$0F20
                        STA    $CF,S
                        SHORT  M
                        LDA    #$77
                        STA    $05,S
                        LDA    #$22
                        STA    $A5,S
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$07
                        STA    $00,S
                        LDA    $14,S
                        AND    #$0F
                        ORA    #$80
                        STA    $14,S
                        LDA    $1E,S
                        AND    #$F0
                        ORA    #$02
                        STA    $1E,S
                        LDA    $21,S
                        AND    #$0F
                        ORA    #$70
                        STA    $21,S
                        LDA    $2A,S
                        AND    #$0F
                        ORA    #$70
                        STA    $2A,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A0,S
                        LDA    $B4,S
                        AND    #$0F
                        ORA    #$80
                        STA    $B4,S
                        LONG   M
                        TSC
                        ADC    #$000D
                        TCS
                        PHX
                        PEA    $7887
                        PHX
                        PEA    $8777
                        TSC
                        ADC    #$000E
                        TCS
                        PHX
                        PHX
                        TSC
                        ADC    #$001A
                        TCS
                        PHX
                        PHD
                        PEA    $7877
                        PHX
                        TSC                              ; Line 9
                        ADC    #$0092
                        TCS
                        LDA    #$2822
                        STA    $8F,S
                        STA    $9A,S
                        TYA
                        STA    $AC,S
                        STA    $B0,S
                        STA    $B4,S
                        STA    $BA,S
                        LDA    $8E,S
                        AND    #$0000
                        ORA    #$2222
                        STA    $8E,S
                        LDA    $A5,S
                        AND    #$00F0
                        ORA    #$2208
                        STA    $A5,S
                        LDA    $A7,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A7,S
                        LDA    $AE,S
                        AND    #$00F0
                        ORA    #$2208
                        STA    $AE,S
                        LDA    $B2,S
                        AND    #$F00F
                        ORA    #$0820
                        STA    $B2,S
                        SHORT  M
                        LDA    #$22
                        STA    $92,S
                        LDA    #$82
                        STA    $AB,S
                        LDA    $99,S
                        AND    #$F0
                        ORA    #$02
                        STA    $99,S
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9C,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A1,S
                        LDA    $B9,S
                        AND    #$F0
                        ORA    #$02
                        STA    $B9,S
                        LONG   M
                        PHY
                        PHY
                        PEA    $2228
                        PHY
                        PEA    $2882
                        PHY
                        PEA    $8222
                        TSC
                        ADC    #$0024
                        TCS
                        PHY
                        PEA    $8282
                        PHY
                        PHY
                        PEA    $2822
                        PEA    $2288
                        TSC                              ; Line 10
                        ADC    #$008E
                        TCS
                        PEA    $2282
                        PHY
                        PEA    $2822
                        TSC
                        ADC    #$000E
                        TCS
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
; MARK: TIMEWARP_000A
TIMEWARP_000A           ENTRY
                        CLC                              ; 16x16, 59 bytes, 117 cycles
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
;--
                        TSC                              ; Line 7
                        ADC    #$0467
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A8
                        TCS
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
; MARK: TIMEWARP_001A
TIMEWARP_001A           ENTRY
                        CLC                              ; 16x16, 77 bytes, 163 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 28
;--
                        TSC                              ; Line 6
                        ADC    #$03C7
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A8
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A8
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A8
                        TCS
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
; MARK: TIMEWARP_002A
TIMEWARP_002A           ENTRY
                        CLC                              ; 16x16, 113 bytes, 255 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 56
;--
                        TSC                              ; Line 4
                        ADC    #$0287
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
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A8
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A8
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A8
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
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
; MARK: TIMEWARP_003A
TIMEWARP_003A           ENTRY
                        CLC                              ; 16x16, 177 bytes, 407 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$1111                    ; Pattern #1 : 96
;--
                        TSC
                        ADC    #$0005
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 1
                        ADC    #$00A4
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 2
                        ADC    #$00A6
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 3
                        ADC    #$00A8
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00A8
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
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A8
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A8
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A8
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
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
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 12
                        ADC    #$00A8
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 13
                        ADC    #$00A8
                        TCS
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 14
                        ADC    #$00A6
                        TCS
                        PHX
                        PHX
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

THISISAFORMATTINGLABEL  ANOP
                        END
