                        MCOPY  src/sprites/SPREXPLD.mac

SPREXPLD                START  EXPLD

                        USING  VARIABLES

; MARK: EXLBM_000A
EXLBM_000A              ENTRY
                        CLC                              ; 16x11, 187 bytes, 295 cycles
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
                        AND    #$F00F
                        ORA    #$0270
                        STA    $A1,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$07
                        STA    $02,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$F0F0
                        ORA    #$0302
                        STA    $01,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$02
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$2307
                        STA    $00,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$2703
                        STA    $03,S
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$F0F0
                        ORA    #$0302
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$F00F
                        ORA    #$0270
                        STA    $A1,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$02
                        STA    $03,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
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
; MARK: EXLBM_000B
EXLBM_000B              ENTRY
                        CLC                              ; 16x11, 187 bytes, 295 cycles
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
                        AND    #$F00F
                        ORA    #$0720
                        STA    $A3,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$70
                        STA    $03,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F0F
                        ORA    #$3020
                        STA    $02,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$20
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$3072
                        STA    $01,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$7032
                        STA    $04,S
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F0F
                        ORA    #$3020
                        STA    $02,S
                        LDA    $A3,S
                        AND    #$F00F
                        ORA    #$0720
                        STA    $A3,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$20
                        STA    $04,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$70
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
; MARK: EXLBM_001A
EXLBM_001A              ENTRY
                        CLC                              ; 16x11, 238 bytes, 372 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3772                    ; Pattern #1 : 1
;--
                        SHORT  M                         ; Line 0
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$07
                        STA    $02,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A0,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$F00F
                        ORA    #$0320
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$F0F0
                        ORA    #$0703
                        STA    $A1,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$20
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$01E0
                        TCS
                        TXA
                        STA    $00,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$3207
                        STA    $03,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$70
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$F0F0
                        ORA    #$0703
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$F00F
                        ORA    #$0320
                        STA    $A1,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$03
                        STA    $03,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$07
                        STA    $00,S
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$02
                        STA    $02,S
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$07
                        STA    $04,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$07
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
; MARK: EXLBM_001B
EXLBM_001B              ENTRY
                        CLC                              ; 16x11, 238 bytes, 372 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2773                    ; Pattern #1 : 1
;--
                        SHORT  M                         ; Line 0
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$70
                        STA    $03,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0230
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$7030
                        STA    $A2,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$02
                        STA    $01,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$01E0
                        TCS
                        TXA
                        STA    $04,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$2307
                        STA    $00,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$70
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F0F
                        ORA    #$7030
                        STA    $02,S
                        LDA    $A3,S
                        AND    #$F00F
                        ORA    #$0230
                        STA    $A3,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$30
                        STA    $04,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$70
                        STA    $01,S
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$20
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$70
                        STA    $05,S
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
; MARK: EXLBM_002A
EXLBM_002A              ENTRY
                        CLC                              ; 16x11, 162 bytes, 258 cycles
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
                        LDA    $A1,S
                        AND    #$F0F0
                        ORA    #$0207
                        STA    $A1,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$07
                        STA    $02,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F0F
                        ORA    #$2020
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$F000
                        ORA    #$0372
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$0FF0
                        ORA    #$7002
                        STA    $A3,S
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F0F
                        ORA    #$2020
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$F0F0
                        ORA    #$0207
                        STA    $A1,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
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
; MARK: EXLBM_002B
EXLBM_002B              ENTRY
                        CLC                              ; 16x11, 162 bytes, 258 cycles
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
                        ORA    #$2070
                        STA    $A2,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$70
                        STA    $03,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$F0F0
                        ORA    #$0202
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$2007
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$000F
                        ORA    #$2730
                        STA    $A3,S
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$F0F0
                        ORA    #$0202
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$2070
                        STA    $A2,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$70
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
; MARK: EXLBM_003A
EXLBM_003A              ENTRY
                        CLC                              ; 16x11, 127 bytes, 203 cycles
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
                        LDA    $A1,S
                        AND    #$F0F0
                        ORA    #$0207
                        STA    $A1,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$07
                        STA    $02,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0F0F
                        ORA    #$2020
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$F0F0
                        ORA    #$0207
                        STA    $A1,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
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
; MARK: EXLBM_003B
EXLBM_003B              ENTRY
                        CLC                              ; 16x11, 127 bytes, 203 cycles
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
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$2070
                        STA    $A2,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$70
                        STA    $03,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$F0F0
                        ORA    #$0202
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$2070
                        STA    $A2,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$70
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
; MARK: EXLLG_000A
EXLLG_000A              ENTRY
                        CLC                              ; 32x16, 202 bytes, 345 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2222                    ; Pattern #1 : 4
                        LDY    #$7177                    ; Pattern #2 : 3
                        LDA    #$7717                    ; Pattern #3 : 3
                        TCD
;--
                        TSC                              ; Line 5
                        ADC    #$0320
                        TCS
                        LDA    #$7777
                        STA    $A7,S
                        LDA    $06,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $06,S
                        LDA    $08,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $08,S
                        LDA    $A5,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $A5,S
                        LDA    $A9,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A9,S
                        TSC                              ; Line 7
                        ADC    #$014B
                        TCS
                        LDA    $96,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $96,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A2,S
                        PHX
                        PHD
                        PHY
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A9
                        TCS
                        PEA    $2272
                        PHD
                        PEA    $1111
                        PHY
                        PEA    $2722
                        TSC                              ; Line 9
                        ADC    #$00A9
                        TCS
                        LDA    #$7777
                        STA    $9C,S
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $9A,S
                        LDA    $9E,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $9E,S
                        PHX
                        PHD
                        PHY
                        PHX
                        TSC                              ; Line 11
                        ADC    #$013D
                        TCS
                        LDA    $06,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $06,S
                        LDA    $08,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $08,S
;--
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS             ; Restore Stack
                        TCS
                        PLD                              ; Restore Direct Page
                        CLI                              ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: EXLLG_000B
EXLLG_000B              ENTRY
                        CLC                              ; 32x16, 198 bytes, 324 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2222                    ; Pattern #1 : 5
                        LDY    #$7727                    ; Pattern #2 : 4
                        LDA    #$7277                    ; Pattern #3 : 4
                        TCD
;--
                        TSC                              ; Line 5
                        ADC    #$0320
                        TCS
                        TXA
                        STA    $07,S
                        SHORT  M
                        LDA    #$22
                        STA    $09,S
                        STA    $AA,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$00A9
                        TCS
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A2,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9B,S
                        LONG   M
                        PHD
                        PEA    $2722
                        TSC                              ; Line 7
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$22
                        STA    $A4,S
                        LONG   M
                        PHD
                        PEA    $1177
                        PEA    $2722
                        TSC                              ; Line 8
                        ADC    #$00A9
                        TCS
                        LDA    $9E,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $9E,S
                        SHORT  M
                        LDA    $97,S
                        AND    #$F0
                        ORA    #$02
                        STA    $97,S
                        LONG   M
                        PHX
                        PEA    $7777
                        PEA    $1111
                        PEA    $1177
                        PEA    $7722
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    #$22
                        STA    $A0,S
                        LONG   M
                        PHD
                        PEA    $1177
                        PEA    $2722
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        TXA
                        STA    $9E,S
                        SHORT  M
                        LDA    #$22
                        STA    $A0,S
                        LONG   M
                        PHD
                        PEA    $2722
;--
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS             ; Restore Stack
                        TCS
                        PLD                              ; Restore Direct Page
                        CLI                              ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: EXLLG_001A
EXLLG_001A              ENTRY
                        CLC                              ; 32x16, 162 bytes, 289 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2722                    ; Pattern #1 : 7
                        LDY    #$2272                    ; Pattern #2 : 7
                        LDA    #$1111                    ; Pattern #3 : 5
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        LDA    #$2222
                        STA    $07,S
                        TSC                              ; Line 5
                        ADC    #$00A9
                        TCS
                        PHY
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        PHY
                        PEA    $1771
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A7
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $95,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A3,S
                        PHY
                        PEA    $7711
                        PEA    $1177
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00AA
                        TCS
                        PEA    $2222
                        PEA    $7277
                        PHD
                        PHD
                        PEA    $7727
                        PEA    $2222
                        TSC                              ; Line 9
                        ADC    #$00AA
                        TCS
                        PHY
                        PEA    $7711
                        PEA    $1177
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A7
                        TCS
                        PHY
                        PEA    $1771
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00A5
                        TCS
                        LDA    #$2222
                        STA    $9E,S
                        PHY
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
; MARK: EXLLG_001B
EXLLG_001B              ENTRY
                        CLC                              ; 32x16, 303 bytes, 496 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$7722                    ; Pattern #1 : 7
                        LDY    #$2222                    ; Pattern #2 : 5
                        LDA    #$7717                    ; Pattern #3 : 3
                        TCD
;--
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        TXA
                        STA    $A7,S
                        LDA    $07,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $07,S
                        LDA    $A9,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A9,S
                        SHORT  M
                        LDA    $09,S
                        AND    #$0F
                        ORA    #$20
                        STA    $09,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $0A,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $0A,S
                        LDA    $AB,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $AB,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$02
                        STA    $05,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A4,S
                        LONG   M
                        TSC
                        ADC    #$0009
                        TCS
                        PEA    $7711
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$22
                        STA    $A5,S
                        LONG   M
                        PHD
                        PEA    $1171
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00AA
                        TCS
                        LDA    $9D,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $9D,S
                        SHORT  M
                        LDA    $96,S
                        AND    #$F0
                        ORA    #$02
                        STA    $96,S
                        LONG   M
                        PHY
                        PEA    $2277
                        PEA    $1711
                        PEA    $1111
                        PEA    $7177
                        PHY
                        PHY
                        TSC                              ; Line 9
                        ADC    #$00AA
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A0,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9B,S
                        LONG   M
                        PHD
                        PEA    $1171
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A0,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9D,S
                        LONG   M
                        PEA    $7711
                        PHX
                        TSC                              ; Line 12
                        ADC    #$013B
                        TCS
                        LDA    $07,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $07,S
                        SHORT  M
                        LDA    $09,S
                        AND    #$0F
                        ORA    #$20
                        STA    $09,S
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
; MARK: EXLLG_002A
EXLLG_002A              ENTRY
                        CLC                              ; 32x16, 473 bytes, 747 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2222                    ; Pattern #1 : 7
                        LDY    #$1111                    ; Pattern #2 : 6
                        LDA    #$2277                    ; Pattern #3 : 4
                        TCD
;--
                        SHORT  M                         ; Line 0
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$20
                        STA    $07,S
                        LDA    $0A,S
                        AND    #$0F
                        ORA    #$20
                        STA    $0A,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A4,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A7,S
                        LDA    $A9,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A9,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$2272
                        STA    $A7,S
                        LDA    $A4,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A4,S
                        LDA    $A9,S
                        AND    #$0F00
                        ORA    #$2027
                        STA    $A9,S
                        LDA    $AB,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AB,S
                        SHORT  M
                        LDA    #$22
                        STA    $07,S
                        STA    $09,S
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$02
                        STA    $04,S
                        LDA    $0C,S
                        AND    #$F0
                        ORA    #$02
                        STA    $0C,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$22
                        STA    $05,S
                        LDA    #$72
                        STA    $AB,S
                        LONG   M
                        TSC
                        ADC    #$000B
                        TCS
                        PHX
                        PEA    $7722
                        PEA    $7722
                        TSC                              ; Line 5
                        ADC    #$00A5
                        TCS
                        PEA    $2777
                        PEA    $7217
                        PEA    $7722
                        TSC                              ; Line 6
                        ADC    #$00A7
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$2072
                        STA    $A0,S
                        PEA    $7277
                        PEA    $7177
                        PEA    $1171
                        PEA    $2722
                        TSC                              ; Line 7
                        ADC    #$00A7
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $99,S
                        PHY
                        PHY
                        PEA    $1177
                        PEA    $7722
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00AE
                        TCS
                        LDA    $9D,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $9D,S
                        SHORT  M
                        LDA    $96,S
                        AND    #$F0
                        ORA    #$02
                        STA    $96,S
                        LONG   M
                        PHX
                        PHD
                        PEA    $7711
                        PHY
                        PEA    $7777
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9A,S
                        LONG   M
                        PEA    $7271
                        PEA    $1771
                        PEA    $2777
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        LDA    $9A,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $9A,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9C,S
                        LONG   M
                        PEA    $7227
                        PEA    $7771
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00A6
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$2702
                        STA    $9C,S
                        LDA    $9E,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $9E,S
                        SHORT  M
                        LDA    #$22
                        STA    $9A,S
                        STA    $A0,S
                        LONG   M
                        PEA    $7222
                        PHD
                        TSC                              ; Line 13
                        ADC    #$013A
                        TCS
                        SHORT  M
                        LDA    #$22
                        STA    $07,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$02
                        STA    $03,S
                        LDA    $0A,S
                        AND    #$F0
                        ORA    #$02
                        STA    $0A,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A3,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A7,S
                        LDA    $AB,S
                        AND    #$0F
                        ORA    #$20
                        STA    $AB,S
                        LONG   M
                        TSC                              ; Line 15
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$20
                        STA    $07,S
                        LDA    $0B,S
                        AND    #$F0
                        ORA    #$02
                        STA    $0B,S
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
; MARK: EXLLG_002B
EXLLG_002B              ENTRY
                        CLC                              ; 32x16, 469 bytes, 751 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$7227                    ; Pattern #1 : 5
                        LDY    #$1111                    ; Pattern #2 : 4
                        LDA    #$2722                    ; Pattern #3 : 4
                        TCD
;--
                        SHORT  M                         ; Line 0
                        LDA    $07,S
                        AND    #$F0
                        ORA    #$02
                        STA    $07,S
                        LDA    $0A,S
                        AND    #$F0
                        ORA    #$02
                        STA    $0A,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A4,S
                        LDA    $A7,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A7,S
                        LDA    $AA,S
                        AND    #$0F
                        ORA    #$20
                        STA    $AA,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $07,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $07,S
                        LDA    $09,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $09,S
                        SHORT  M
                        LDA    #$22
                        STA    $A5,S
                        STA    $AC,S
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$20
                        STA    $05,S
                        LDA    $0D,S
                        AND    #$0F
                        ORA    #$20
                        STA    $0D,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00AA
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A1,S
                        PEA    $7222
                        PEA    $2227
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$2702
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$2077
                        STA    $A1,S
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00A4
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$2077
                        STA    $A1,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9A,S
                        LONG   M
                        PHX
                        PEA    $7771
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        LDA    $97,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $97,S
                        PEA    $1777
                        PEA    $1711
                        PEA    $7722
                        TSC                              ; Line 7
                        ADC    #$00A8
                        TCS
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A2,S
                        PEA    $2217
                        PHY
                        PHY
                        PEA    $7177
                        PHD
                        TSC                              ; Line 8
                        ADC    #$00AB
                        TCS
                        PEA    $2272
                        PEA    $7717
                        PHY
                        PEA    $7177
                        PHD
                        TSC                              ; Line 9
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$20
                        STA    $9F,S
                        LONG   M
                        PEA    $2222
                        PEA    $1777
                        PEA    $1177
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    #$22
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A1,S
                        LONG   M
                        PEA    $7772
                        PEA    $1727
                        PEA    $2222
                        TSC                              ; Line 11
                        ADC    #$00A6
                        TCS
                        LDA    #$7222
                        STA    $9D,S
                        LDA    $9A,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $9A,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A0,S
                        PHD
                        PHX
                        TSC                              ; Line 13
                        ADC    #$013A
                        TCS
                        LDA    $07,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $07,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$20
                        STA    $04,S
                        LDA    $0B,S
                        AND    #$0F
                        ORA    #$20
                        STA    $0B,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A3,S
                        LDA    $A7,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A7,S
                        LDA    $AB,S
                        AND    #$F0
                        ORA    #$02
                        STA    $AB,S
                        LONG   M
                        TSC                              ; Line 15
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $07,S
                        AND    #$F0
                        ORA    #$02
                        STA    $07,S
                        LDA    $0C,S
                        AND    #$0F
                        ORA    #$20
                        STA    $0C,S
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
; MARK: EXLLG_003A
EXLLG_003A              ENTRY
                        CLC                              ; 32x16, 506 bytes, 806 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2222                    ; Pattern #1 : 6
                        LDY    #$1111                    ; Pattern #2 : 5
                        LDA    #$2722                    ; Pattern #3 : 5
                        TCD
;--
                        SHORT  M                         ; Line 0
                        LDA    #$22
                        STA    $AA,S
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$02
                        STA    $02,S
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$20
                        STA    $07,S
                        LDA    $0A,S
                        AND    #$F0
                        ORA    #$02
                        STA    $0A,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A3,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    #$2227
                        STA    $A6,S
                        LDA    #$7222
                        STA    $A9,S
                        LDA    $03,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $03,S
                        LDA    $06,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $06,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $A3,S
                        SHORT  M
                        LDA    #$22
                        STA    $0A,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$7202
                        STA    $03,S
                        SHORT  M
                        LDA    #$22
                        STA    $A3,S
                        LONG   M
                        TSC
                        ADC    #$000A
                        TCS
                        PEA    $7227
                        PEA    $2272
                        PHD
                        TSC                              ; Line 5
                        ADC    #$00A7
                        TCS
                        LDA    $97,S
                        AND    #$00F0
                        ORA    #$2702
                        STA    $97,S
                        LDA    $A3,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A3,S
                        PEA    $2272
                        PEA    $7172
                        PEA    $1777
                        PEA    $2277
                        TSC                              ; Line 6
                        ADC    #$00AA
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$2077
                        STA    $9F,S
                        PHX
                        PEA    $7277
                        PEA    $7177
                        PEA    $1171
                        PEA    $7777
                        TSC                              ; Line 7
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    #$22
                        STA    $A1,S
                        LONG   M
                        PEA    $7711
                        PEA    $1117
                        PHY
                        PEA    $1777
                        PEA    $7722
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00AC
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$2077
                        STA    $A0,S
                        PEA    $1711
                        PHY
                        PEA    $1711
                        PEA    $1127
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00A9
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$7702
                        STA    $99,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$2077
                        STA    $A1,S
                        PEA    $7711
                        PEA    $7177
                        PEA    $7177
                        PEA    $7722
                        TSC                              ; Line 10
                        ADC    #$00A8
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$7202
                        STA    $99,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$2027
                        STA    $A1,S
                        PEA    $7217
                        PEA    $7772
                        PEA    $7122
                        TSC                              ; Line 11
                        ADC    #$00A6
                        TCS
                        TXA
                        STA    $A1,S
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $99,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A0,S
                        LONG   M
                        PEA    $2277
                        PEA    $2772
                        PHD
                        TSC                              ; Line 12
                        ADC    #$00A5
                        TCS
                        LDA    $A3,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A3,S
                        SHORT  M
                        LDA    #$22
                        STA    $9A,S
                        STA    $9D,S
                        STA    $A0,S
                        LONG   M
                        PHD
                        PEA    $2227
                        TSC                              ; Line 14
                        ADC    #$013B
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$02
                        STA    $02,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LDA    $09,S
                        AND    #$F0
                        ORA    #$02
                        STA    $09,S
                        LDA    $0D,S
                        AND    #$F0
                        ORA    #$02
                        STA    $0D,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A2,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A6,S
                        LDA    $A9,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A9,S
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
; MARK: EXLLG_003B
EXLLG_003B              ENTRY
                        CLC                              ; 32x16, 541 bytes, 858 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2222                    ; Pattern #1 : 7
                        LDY    #$7717                    ; Pattern #2 : 5
                        LDA    #$1111                    ; Pattern #3 : 4
                        TCD
;--
                        LDA    $AA,S                     ; Line 0
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $AA,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$20
                        STA    $03,S
                        LDA    $07,S
                        AND    #$F0
                        ORA    #$02
                        STA    $07,S
                        LDA    $0B,S
                        AND    #$0F
                        ORA    #$20
                        STA    $0B,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A3,S
                        LDA    $A7,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $03,S
                        LDA    $0A,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $0A,S
                        LDA    $A5,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A5,S
                        LDA    $A8,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A8,S
                        LDA    $AA,S
                        AND    #$0F00
                        ORA    #$2027
                        STA    $AA,S
                        SHORT  M
                        LDA    #$22
                        STA    $07,S
                        STA    $A4,S
                        LDA    #$72
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0149
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$2077
                        STA    $01,S
                        LDA    $9A,S
                        AND    #$00F0
                        ORA    #$2702
                        STA    $9A,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A2,S
                        PHX
                        PEA    $7722
                        PEA    $2227
                        TSC                              ; Line 5
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    #$22
                        STA    $99,S
                        LONG   M
                        PEA    $1727
                        PEA    $7771
                        PEA    $2772
                        TSC                              ; Line 6
                        ADC    #$00AB
                        TCS
                        LDA    $91,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $91,S
                        PHX
                        PHX
                        PHY
                        PHY
                        PEA    $1177
                        PEA    $7777
                        TSC                              ; Line 7
                        ADC    #$00AA
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $95,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$2072
                        STA    $9F,S
                        PEA    $7277
                        PEA    $1711
                        PEA    $7111
                        PEA    $1171
                        PEA    $7177
                        PEA    $2722
                        TSC                              ; Line 8
                        ADC    #$00AA
                        TCS
                        LDA    $98,S
                        AND    #$00F0
                        ORA    #$2702
                        STA    $98,S
                        PHD
                        PEA    $1171
                        PHD
                        PEA    $7122
                        TSC                              ; Line 9
                        ADC    #$00A9
                        TCS
                        SHORT  M
                        LDA    #$72
                        STA    $A0,S
                        LONG   M
                        PEA    $7277
                        PEA    $1711
                        PHY
                        PEA    $7777
                        TSC                              ; Line 10
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    #$72
                        STA    $A1,S
                        LONG   M
                        PEA    $2777
                        PEA    $7127
                        PEA    $1727
                        PEA    $7227
                        TSC                              ; Line 11
                        ADC    #$00A8
                        TCS
                        LDA    $9A,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $9A,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A1,S
                        SHORT  M
                        LDA    #$22
                        STA    $99,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A0,S
                        LONG   M
                        PEA    $2272
                        PEA    $7722
                        PEA    $7722
                        PEA    $2227
                        TSC                              ; Line 12
                        ADC    #$00A7
                        TCS
                        LDA    $99,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $99,S
                        LDA    $9C,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $9C,S
                        LDA    $9F,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $9F,S
                        SHORT  M
                        LDA    #$22
                        STA    $A3,S
                        LONG   M
                        PEA    $7222
                        PEA    $2272
                        TSC                              ; Line 14
                        ADC    #$013A
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$20
                        STA    $03,S
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$02
                        STA    $06,S
                        LDA    $0A,S
                        AND    #$0F
                        ORA    #$20
                        STA    $0A,S
                        LDA    $0E,S
                        AND    #$0F
                        ORA    #$20
                        STA    $0E,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A6,S
                        LDA    $AA,S
                        AND    #$0F
                        ORA    #$20
                        STA    $AA,S
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
; MARK: EXLSB_000A
EXLSB_000A              ENTRY
                        CLC                              ; 16x13, 270 bytes, 414 cycles
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
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$02
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$07
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$07
                        STA    $03,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$07
                        STA    $05,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$F00F
                        ORA    #$0320
                        STA    $A2,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$30
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$30
                        STA    $06,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$20
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$07
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$07
                        STA    $03,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$07
                        STA    $05,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$03
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
; MARK: EXLSB_000B
EXLSB_000B              ENTRY
                        CLC                              ; 16x13, 270 bytes, 414 cycles
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
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$20
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$70
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$70
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$70
                        STA    $06,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $A4,S
                        AND    #$F00F
                        ORA    #$0730
                        STA    $A4,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$03
                        STA    $01,S
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$03
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$02
                        STA    $01,S
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$02
                        STA    $06,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$70
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$70
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$70
                        STA    $06,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$30
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
; MARK: EXLSB_001A
EXLSB_001A              ENTRY
                        CLC                              ; 16x13, 318 bytes, 488 cycles
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
                        ORA    #$07
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$03
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$03
                        STA    $03,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$03
                        STA    $05,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$F00F
                        ORA    #$0720
                        STA    $A2,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$20
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0F0F
                        ORA    #$2020
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$F00F
                        ORA    #$0770
                        STA    $A2,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$03
                        STA    $00,S
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$07
                        STA    $06,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$70
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 10
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$02
                        STA    $01,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$02
                        STA    $03,S
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$02
                        STA    $05,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$02
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
; MARK: EXLSB_001B
EXLSB_001B              ENTRY
                        CLC                              ; 16x13, 318 bytes, 488 cycles
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
                        ORA    #$70
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$30
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$30
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$30
                        STA    $06,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $A4,S
                        AND    #$F00F
                        ORA    #$0770
                        STA    $A4,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$02
                        STA    $01,S
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$02
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$F0F0
                        ORA    #$0202
                        STA    $03,S
                        LDA    $A4,S
                        AND    #$F00F
                        ORA    #$0370
                        STA    $A4,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$30
                        STA    $01,S
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$70
                        STA    $07,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$07
                        STA    $01,S
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$02
                        STA    $06,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 10
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$20
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$20
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$30
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$20
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
; MARK: EXLSB_002A
EXLSB_002A              ENTRY
                        CLC                              ; 16x13, 104 bytes, 166 cycles
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
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$03
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$01E0
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$03
                        STA    $02,S
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$07
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$02
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
; MARK: EXLSB_002B
EXLSB_002B              ENTRY
                        CLC                              ; 16x13, 104 bytes, 166 cycles
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
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$30
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$01E0
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$30
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$70
                        STA    $05,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$20
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
; MARK: EXLSB_003A
EXLSB_003A              ENTRY
                        CLC                              ; 16x13, 97 bytes, 155 cycles
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
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$07
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$03
                        STA    $02,S
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$03
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
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
; MARK: EXLSB_003B
EXLSB_003B              ENTRY
                        CLC                              ; 16x13, 97 bytes, 155 cycles
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
                        TSC                              ; Line 4
                        ADC    #$0280
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$70
                        STA    $04,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$30
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$30
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$0140
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
; MARK: EXLSM_000A
EXLSM_000A              ENTRY
                        CLC                              ; 20x16, 215 bytes, 341 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2222                    ; Pattern #1 : 2
                        LDY    #$7722                    ; Pattern #2 : 2
                        LDA    #$2227                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$02
                        STA    $03,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $A4,S
                        LDA    $04,S
                        AND    #$F000
                        ORA    #$0222
                        STA    $04,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0145
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$20
                        STA    $01,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A2,S
                        LONG   M
                        PEA    $2277
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        TDC
                        STA    $9E,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9D,S
                        LONG   M
                        PEA    $2272
                        PHY
                        TSC                              ; Line 10
                        ADC    #$013E
                        TCS
                        TXA
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A5,S
                        SHORT  M
                        LDA    #$22
                        STA    $A3,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$02
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
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
; MARK: EXLSM_000B
EXLSM_000B              ENTRY
                        CLC                              ; 20x16, 228 bytes, 360 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2222                    ; Pattern #1 : 2
                        LDY    #$7222                    ; Pattern #2 : 2
                        LDA    #$2272                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$20
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $A4,S
                        LDA    $04,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $04,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$02
                        STA    $02,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A3,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PHD
                        PEA    $2722
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        TYA
                        STA    $9D,S
                        SHORT  M
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$20
                        STA    $9F,S
                        LONG   M
                        PHX
                        PEA    $7727
                        TSC                              ; Line 10
                        ADC    #$013D
                        TCS
                        TXA
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A3,S
                        SHORT  M
                        LDA    #$22
                        STA    $A6,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$02
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
; MARK: EXLSM_001A
EXLSM_001A              ENTRY
                        CLC                              ; 20x16, 269 bytes, 433 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2222                    ; Pattern #1 : 5
                        LDY    #$7222                    ; Pattern #2 : 2
                        LDA    #$2277                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$02
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $A4,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A4,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$02
                        STA    $04,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A1,S
                        LDA    $A7,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0145
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $01,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9D,S
                        LONG   M
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        PHX
                        PEA    $2722
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        PHD
                        PEA    $7727
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9C,S
                        LONG   M
                        PHD
                        PEA    $7722
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        TYA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A0,S
                        PEA    $7277
                        PHY
                        TSC                              ; Line 11
                        ADC    #$013E
                        TCS
                        TXA
                        STA    $06,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A4,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$20
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$22
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
; MARK: EXLSM_001B
EXLSM_001B              ENTRY
                        CLC                              ; 20x16, 294 bytes, 471 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2222                    ; Pattern #1 : 6
                        LDY    #$7727                    ; Pattern #2 : 2
                        LDA    #$2722                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$20
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $A4,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$20
                        STA    $05,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A2,S
                        LDA    $A8,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A8,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $02,S
                        SHORT  M
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A7,S
                        LONG   M
                        TSC
                        ADC    #$0007
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A3
                        TCS
                        LDA    #$7777
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$2072
                        STA    $A0,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9D,S
                        LONG   M
                        PEA    $2272
                        PHX
                        TSC                              ; Line 8
                        ADC    #$013E
                        TCS
                        TYA
                        STA    $04,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$2072
                        STA    $06,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$02
                        STA    $03,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    #$22
                        STA    $9D,S
                        LONG   M
                        PHY
                        PHD
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A0,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9B,S
                        LONG   M
                        PHX
                        PHD
                        TSC                              ; Line 12
                        ADC    #$013D
                        TCS
                        LDA    $A4,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A4,S
                        SHORT  M
                        LDA    #$22
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
; MARK: EXLSM_002A
EXLSM_002A              ENTRY
                        CLC                              ; 20x16, 337 bytes, 535 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2222                    ; Pattern #1 : 5
                        LDY    #$7777                    ; Pattern #2 : 3
                        LDA    #$2722                    ; Pattern #3 : 3
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$20
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A4,S
                        LDA    $04,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $04,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0147
                        TCS
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$2072
                        STA    $9F,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$20
                        STA    $01,S
                        LONG   M
                        PHX
                        PEA    $2227
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A4
                        TCS
                        TYA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $9D,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A1,S
                        PEA    $2227
                        PHX
                        TSC                              ; Line 8
                        ADC    #$013F
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$02
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $2277
                        PEA    $7727
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        LDA    #$2772
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$2702
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A0,S
                        PEA    $7277
                        PEA    $7722
                        TSC                              ; Line 11
                        ADC    #$013E
                        TCS
                        TDC
                        STA    $04,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $02,S
                        LDA    $06,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $06,S
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A6,S
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$22
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 15
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$20
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
; MARK: EXLSM_002B
EXLSM_002B              ENTRY
                        CLC                              ; 20x16, 318 bytes, 503 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2222                    ; Pattern #1 : 5
                        LDY    #$2272                    ; Pattern #2 : 4
                        LDA    #$7222                    ; Pattern #3 : 4
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        SHORT  M
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$02
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $A4,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $A4,S
                        SHORT  M
                        LDA    #$22
                        STA    $05,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A2,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $A2,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$02
                        STA    $02,S
                        LONG   M
                        TSC
                        ADC    #$0008
                        TCS
                        PHX
                        PHY
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$22
                        STA    $9C,S
                        LONG   M
                        PEA    $2227
                        PHD
                        TSC                              ; Line 7
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A0,S
                        LONG   M
                        PHY
                        PEA    $7727
                        TSC                              ; Line 8
                        ADC    #$00A3
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A1,S
                        LONG   M
                        PEA    $7277
                        PEA    $7722
                        TSC                              ; Line 9
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    #$22
                        STA    $9D,S
                        LONG   M
                        PEA    $7777
                        PEA    $2722
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$22
                        STA    $9C,S
                        LONG   M
                        PHY
                        PEA    $2277
                        TSC                              ; Line 11
                        ADC    #$00A4
                        TCS
                        TXA
                        STA    $9E,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9B,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A1,S
                        LONG   M
                        PHY
                        PHX
                        TSC                              ; Line 13
                        ADC    #$013D
                        TCS
                        LDA    $05,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $05,S
                        SHORT  M
                        LDA    $A5,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 15
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$02
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
; MARK: EXLSM_003A
EXLSM_003A              ENTRY
                        CLC                              ; 20x16, 372 bytes, 597 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2222                    ; Pattern #1 : 8
                        LDY    #$2722                    ; Pattern #2 : 4
                        LDA    #$7722                    ; Pattern #3 : 3
                        TCD
;--
                        SHORT  M                         ; Line 0
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$02
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A4,S
                        LDA    $A8,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A8,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $04,S
                        LDA    $07,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $07,S
                        SHORT  M
                        LDA    #$22
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A1,S
                        LONG   M
                        PHX
                        PHX
                        TSC                              ; Line 4
                        ADC    #$00A4
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$2072
                        STA    $A0,S
                        PEA    $2777
                        PEA    $2227
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00A5
                        TCS
                        PEA    $1177
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A6
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A0,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9B,S
                        LONG   M
                        PEA    $2217
                        PEA    $1111
                        PHY
                        TSC                              ; Line 7
                        ADC    #$00A5
                        TCS
                        LDA    $A1,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A1,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9C,S
                        LONG   M
                        PEA    $7211
                        PEA    $7127
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$2072
                        STA    $A0,S
                        PEA    $1711
                        PEA    $1177
                        TSC                              ; Line 9
                        ADC    #$00A3
                        TCS
                        SHORT  M
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A2,S
                        LONG   M
                        PEA    $7117
                        PHY
                        TSC                              ; Line 10
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A1,S
                        LONG   M
                        PEA    $7222
                        PHD
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00A6
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A0,S
                        PHY
                        PEA    $7222
                        TSC                              ; Line 13
                        ADC    #$013E
                        TCS
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $04,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$20
                        STA    $07,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A4,S
                        LDA    $A7,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 15
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$20
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
; MARK: EXLSM_003B
EXLSM_003B              ENTRY
                        CLC                              ; 20x16, 379 bytes, 602 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2222                    ; Pattern #1 : 6
                        LDY    #$2217                    ; Pattern #2 : 3
                        LDA    #$7227                    ; Pattern #3 : 2
                        TCD
;--
                        SHORT  M                         ; Line 0
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$20
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A5,S
                        LDA    $A9,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A9,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A5,S
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $A3,S
                        LDA    $A7,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $A7,S
                        SHORT  M
                        LDA    #$22
                        STA    $08,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $A2,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$02
                        STA    $01,S
                        LONG   M
                        TSC
                        ADC    #$0007
                        TCS
                        PEA    $7272
                        PEA    $2772
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00A6
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$2072
                        STA    $A0,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9B,S
                        LONG   M
                        PHY
                        PEA    $7127
                        TSC                              ; Line 6
                        ADC    #$00A3
                        TCS
                        PEA    $1111
                        PEA    $7122
                        TSC                              ; Line 7
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    #$72
                        STA    $9F,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A1,S
                        LONG   M
                        PHX
                        PEA    $1711
                        PEA    $7722
                        TSC                              ; Line 8
                        ADC    #$00A4
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $9C,S
                        PEA    $1111
                        PEA    $7127
                        TSC                              ; Line 9
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9A,S
                        LONG   M
                        PHY
                        PEA    $7771
                        TSC                              ; Line 10
                        ADC    #$00A4
                        TCS
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9C,S
                        LONG   M
                        PEA    $2227
                        PHD
                        PHX
                        TSC                              ; Line 11
                        ADC    #$00A6
                        TCS
                        TXA
                        STA    $9F,S
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $9D,S
                        PEA    $7222
                        PEA    $2227
                        TSC                              ; Line 13
                        ADC    #$013D
                        TCS
                        LDA    $04,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $04,S
                        SHORT  M
                        LDA    $07,S
                        AND    #$F0
                        ORA    #$02
                        STA    $07,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A4,S
                        LDA    $A8,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A8,S
                        LONG   M
                        TSC                              ; Line 15
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$02
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
; MARK: EXLWE_000A
EXLWE_000A              ENTRY
                        CLC                              ; 16x16, 239 bytes, 375 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2722                    ; Pattern #1 : 1
                        LDY    #$7727                    ; Pattern #2 : 1
                        LDA    #$2277                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        LDA    $A2,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A2,S
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$20
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $02,S
                        LDA    $A3,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $A3,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$20
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        LDA    #$7222
                        STA    $03,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$02
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        LDA    $9D,S
                        AND    #$00F0
                        ORA    #$7702
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $9F,S
                        PHD
                        PHX
                        TSC                              ; Line 10
                        ADC    #$013F
                        TCS
                        LDA    $02,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $02,S
                        LDA    $04,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $04,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$20
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
; MARK: EXLWE_000B
EXLWE_000B              ENTRY
                        CLC                              ; 16x16, 230 bytes, 357 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$7722                    ; Pattern #1 : 1
                        LDY    #$2272                    ; Pattern #2 : 1
                        LDA    #$2222                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$02
                        STA    $04,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $A4,S
                        LDA    $04,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $04,S
                        SHORT  M
                        LDA    #$22
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A3,S
                        LDA    $02,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $02,S
                        LDA    $05,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $05,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$2072
                        STA    $A5,S
                        SHORT  M
                        LDA    #$27
                        STA    $04,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $04,S
                        SHORT  M
                        LDA    #$27
                        STA    $03,S
                        LDA    #$22
                        STA    $A4,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$0F
                        ORA    #$20
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
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
; MARK: EXLWE_001A
EXLWE_001A              ENTRY
                        CLC                              ; 16x16, 263 bytes, 416 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$7727                    ; Pattern #1 : 1
                        LDY    #$2272                    ; Pattern #2 : 1
                        LDA    #$7227                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$20
                        STA    $05,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $03,S
                        LDA    $A1,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A1,S
                        LDA    $A3,S
                        AND    #$F000
                        ORA    #$0222
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A5,S
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        TDC
                        STA    $03,S
                        TXA
                        STA    $A3,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $01,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $05,S
                        TSC                              ; Line 8
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $04,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$7702
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$F000
                        ORA    #$0722
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A4,S
                        TSC                              ; Line 10
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $03,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$02
                        STA    $01,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LDA    $A3,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$20
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
; MARK: EXLWE_001B
EXLWE_001B              ENTRY
                        CLC                              ; 16x16, 273 bytes, 421 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$7722                    ; Pattern #1 : 1
                        LDY    #$2277                    ; Pattern #2 : 1
                        LDA    #$7727                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$02
                        STA    $05,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $A4,S
                        AND    #$000F
                        ORA    #$2220
                        STA    $A4,S
                        SHORT  M
                        LDA    #$22
                        STA    $A3,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$02
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$20
                        STA    $05,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A1,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A7,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0145
                        TCS
                        LDA    $9E,S
                        AND    #$00F0
                        ORA    #$7702
                        STA    $9E,S
                        SHORT  M
                        LDA    #$22
                        STA    $01,S
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A0,S
                        LONG   M
                        PHY
                        PEA    $2222
                        TSC                              ; Line 8
                        ADC    #$013F
                        TCS
                        TDC
                        STA    $03,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $05,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A2,S
                        SHORT  M
                        LDA    #$72
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 10
                        ADC    #$0140
                        TCS
                        LDA    $05,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $05,S
                        LDA    $A4,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A4,S
                        SHORT  M
                        LDA    #$22
                        STA    $04,S
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$20
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$02
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
; MARK: EXLWE_002A
EXLWE_002A              ENTRY
                        CLC                              ; 16x16, 327 bytes, 510 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2722                    ; Pattern #1 : 2
                        LDY    #$7122                    ; Pattern #2 : 1
                        LDA    #$1171                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$02
                        STA    $04,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0F0F
                        ORA    #$2020
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$000F
                        ORA    #$2220
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$000F
                        ORA    #$2220
                        STA    $A4,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$02
                        STA    $05,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        LDA    #$1727
                        STA    $A3,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$2072
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$2072
                        STA    $A5,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$02
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 7
                        ADC    #$0145
                        TCS
                        LDA    #$7171
                        STA    $9E,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$02
                        STA    $01,S
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9D,S
                        LONG   M
                        PEA    $2211
                        PHY
                        TSC                              ; Line 9
                        ADC    #$013F
                        TCS
                        TXA
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$2072
                        STA    $04,S
                        LDA    $A4,S
                        AND    #$000F
                        ORA    #$2270
                        STA    $A4,S
                        SHORT  M
                        LDA    #$22
                        STA    $A3,S
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$02
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 11
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$0F0F
                        ORA    #$2020
                        STA    $03,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$02
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
; MARK: EXLWE_002B
EXLWE_002B              ENTRY
                        CLC                              ; 16x16, 294 bytes, 468 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2277                    ; Pattern #1 : 3
                        LDY    #$7722                    ; Pattern #2 : 2
                        LDA    #$2222                    ; Pattern #3 : 2
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A3,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A3,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$20
                        STA    $05,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$F0F0
                        ORA    #$0202
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$F0F0
                        ORA    #$0202
                        STA    $A2,S
                        LDA    $A5,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A5,S
                        SHORT  M
                        LDA    #$22
                        STA    $A4,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0145
                        TCS
                        TXA
                        STA    $A0,S
                        LDA    $9E,S
                        AND    #$00F0
                        ORA    #$7102
                        STA    $9E,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9C,S
                        LONG   M
                        PHX
                        PHD
                        TSC                              ; Line 7
                        ADC    #$013F
                        TCS
                        LDA    #$1211
                        STA    $04,S
                        LDA    #$1727
                        STA    $A3,S
                        LDA    $02,S
                        AND    #$00F0
                        ORA    #$2702
                        STA    $02,S
                        LDA    $06,S
                        AND    #$0F0F
                        ORA    #$2020
                        STA    $06,S
                        SHORT  M
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$10
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 9
                        ADC    #$0145
                        TCS
                        LDA    $9E,S
                        AND    #$00F0
                        ORA    #$2702
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A0,S
                        PHX
                        PHD
                        TSC                              ; Line 11
                        ADC    #$013F
                        TCS
                        LDA    $03,S
                        AND    #$F0F0
                        ORA    #$0202
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A3,S
                        SHORT  M
                        LDA    $06,S
                        AND    #$F0
                        ORA    #$02
                        STA    $06,S
                        LONG   M
                        TSC                              ; Line 13
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$20
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
; MARK: EXLWE_003A
EXLWE_003A              ENTRY
                        CLC                              ; 16x16, 400 bytes, 628 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2222                    ; Pattern #1 : 4
                        LDY    #$2722                    ; Pattern #2 : 1
                        LDA    #$7227                    ; Pattern #3 : 1
                        TCD
;--
                        SHORT  M                         ; Line 0
                        LDA    $04,S
                        AND    #$F0
                        ORA    #$02
                        STA    $04,S
                        LDA    $A2,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A2,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $03,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $03,S
                        LDA    $05,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $05,S
                        LDA    $A2,S
                        AND    #$000F
                        ORA    #$2220
                        STA    $A2,S
                        SHORT  M
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A4,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $03,S
                        LDA    $01,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $01,S
                        LDA    $05,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $05,S
                        SHORT  M
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$00A5
                        TCS
                        LDA    #$7127
                        STA    $9D,S
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $A0,S
                        SHORT  M
                        LDA    #$77
                        STA    $9F,S
                        LONG   M
                        PEA    $2272
                        PHY
                        TSC                              ; Line 7
                        ADC    #$0143
                        TCS
                        LDA    $9C,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $9C,S
                        SHORT  M
                        LDA    #$27
                        STA    $9E,S
                        LDA    $01,S
                        AND    #$0F
                        ORA    #$20
                        STA    $01,S
                        LONG   M
                        PEA    $1211
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00A6
                        TCS
                        LDA    #$7217
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$2702
                        STA    $9C,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$0F
                        ORA    #$20
                        STA    $9A,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A1,S
                        LONG   M
                        PHX
                        PEA    $1771
                        TSC                              ; Line 10
                        ADC    #$013E
                        TCS
                        TXA
                        STA    $02,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$2072
                        STA    $04,S
                        LDA    $A3,S
                        AND    #$0F0F
                        ORA    #$2020
                        STA    $A3,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$02
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A1,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 12
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$F0F0
                        ORA    #$0202
                        STA    $A1,S
                        SHORT  M
                        LDA    $05,S
                        AND    #$F0
                        ORA    #$02
                        STA    $05,S
                        LDA    $A4,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A4,S
                        LONG   M
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$20
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
; MARK: EXLWE_003B
EXLWE_003B              ENTRY
                        CLC                              ; 16x16, 382 bytes, 595 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2222                    ; Pattern #1 : 5
                        LDY    #$7722                    ; Pattern #2 : 1
                        LDA    #$2277                    ; Pattern #3 : 1
                        TCD
;--
                        SHORT  M                         ; Line 0
                        LDA    $05,S
                        AND    #$0F
                        ORA    #$20
                        STA    $05,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A3,S
                        LDA    $A5,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$F0F0
                        ORA    #$0202
                        STA    $A2,S
                        LDA    $A4,S
                        AND    #$0F0F
                        ORA    #$2020
                        STA    $A4,S
                        SHORT  M
                        LDA    #$22
                        STA    $05,S
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$02
                        STA    $03,S
                        LDA    $07,S
                        AND    #$0F
                        ORA    #$20
                        STA    $07,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$02
                        STA    $01,S
                        LDA    $A6,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A6,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$00A3
                        TCS
                        LDA    #$1777
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$000F
                        ORA    #$2270
                        STA    $A0,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9D,S
                        LONG   M
                        PHD
                        PHX
                        TSC                              ; Line 7
                        ADC    #$013F
                        TCS
                        LDA    $A1,S
                        AND    #$F000
                        ORA    #$0222
                        STA    $A1,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$02
                        STA    $01,S
                        LDA    $A7,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A7,S
                        LONG   M
                        TSC
                        ADC    #$0005
                        TCS
                        PEA    $2211
                        PEA    $2122
                        TSC                              ; Line 8
                        ADC    #$00A5
                        TCS
                        LDA    #$7122
                        STA    $9D,S
                        LDA    $A0,S
                        AND    #$F00F
                        ORA    #$0220
                        STA    $A0,S
                        SHORT  M
                        LDA    #$77
                        STA    $9F,S
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9A,S
                        LONG   M
                        PEA    $2272
                        PEA    $1177
                        TSC                              ; Line 10
                        ADC    #$0143
                        TCS
                        LDA    $9E,S
                        AND    #$F0F0
                        ORA    #$0202
                        STA    $9E,S
                        SHORT  M
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$02
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A0,S
                        LONG   M
                        PEA    $2227
                        PHX
                        TSC                              ; Line 12
                        ADC    #$013F
                        TCS
                        LDA    $A2,S
                        AND    #$0F0F
                        ORA    #$2020
                        STA    $A2,S
                        SHORT  M
                        LDA    #$22
                        STA    $03,S
                        LDA    $06,S
                        AND    #$0F
                        ORA    #$20
                        STA    $06,S
                        LDA    $A5,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A5,S
                        LONG   M
                        TSC                              ; Line 14
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $03,S
                        AND    #$F0
                        ORA    #$02
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
