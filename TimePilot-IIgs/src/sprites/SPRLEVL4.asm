                        MCOPY  src/sprites/SPRLEVL4.mac

SPRLEVL4                START  LEVL4

                        USING  VARIABLES

; MARK: BOOMERANG_000A
BOOMERANG_000A          ENTRY
                        CLC                              ; 8x6, 100 bytes, 164 cycles
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
                        LDA    $00,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $A0,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $00,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $A1,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$70
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
; MARK: BOOMERANG_000B
BOOMERANG_000B          ENTRY
                        CLC                              ; 8x6, 72 bytes, 117 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$7777                    ; Pattern #1 : 1
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$77
                        STA    $01,S
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        SHORT  M
                        LDA    #$77
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
; MARK: BOOMERANG_001A
BOOMERANG_001A          ENTRY
                        CLC                              ; 8x6, 96 bytes, 155 cycles
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
                        LDA    #$77
                        STA    $01,S
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $A1,S
                        SHORT  M
                        LDA    #$77
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$7007
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
; MARK: BOOMERANG_001B
BOOMERANG_001B          ENTRY
                        CLC                              ; 8x6, 96 bytes, 155 cycles
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
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $A1,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $01,S
                        SHORT  M
                        LDA    #$77
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$77
                        STA    $02,S
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
; MARK: BOOMERANG_002A
BOOMERANG_002A          ENTRY
                        CLC                              ; 8x6, 112 bytes, 182 cycles
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
                        ORA    #$7707
                        STA    $A1,S
                        SHORT  M
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
                        ORA    #$7707
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $A0,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$70
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$0FF0
                        ORA    #$7007
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
; MARK: BOOMERANG_002B
BOOMERANG_002B          ENTRY
                        CLC                              ; 8x6, 92 bytes, 148 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$7777                    ; Pattern #1 : 1
;--
                        LDA    $A2,S                     ; Line 0
                        AND    #$0F00
                        ORA    #$7077
                        STA    $A2,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$70
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        SHORT  M
                        LDA    #$77
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$77
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
; MARK: BOOMERANG_003A
BOOMERANG_003A          ENTRY
                        CLC                              ; 8x6, 81 bytes, 134 cycles
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
                        ORA    #$7707
                        STA    $A1,S
                        SHORT  M
                        LDA    #$77
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$7007
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
; MARK: BOOMERANG_003B
BOOMERANG_003B          ENTRY
                        CLC                              ; 8x6, 81 bytes, 134 cycles
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
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $A2,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $01,S
                        SHORT  M
                        LDA    #$77
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
; MARK: BOOMERANG_004A
BOOMERANG_004A          ENTRY
                        CLC                              ; 8x6, 73 bytes, 121 cycles
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
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $A1,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$77
                        STA    $02,S
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
; MARK: BOOMERANG_004B
BOOMERANG_004B          ENTRY
                        CLC                              ; 8x6, 81 bytes, 134 cycles
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
                        ORA    #$7077
                        STA    $A2,S
                        SHORT  M
                        LDA    #$77
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$7007
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
; MARK: BOOMERANG_005A
BOOMERANG_005A          ENTRY
                        CLC                              ; 8x6, 86 bytes, 137 cycles
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
                        LDA    #$77
                        STA    $02,S
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $A1,S
                        SHORT  M
                        LDA    #$77
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$77
                        STA    $01,S
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
; MARK: BOOMERANG_005B
BOOMERANG_005B          ENTRY
                        CLC                              ; 8x6, 106 bytes, 173 cycles
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
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $A2,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $02,S
                        SHORT  M
                        LDA    #$77
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$0FF0
                        ORA    #$7007
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
; MARK: BOOMERANG_006A
BOOMERANG_006A          ENTRY
                        CLC                              ; 8x6, 97 bytes, 154 cycles
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
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $A1,S
                        SHORT  M
                        LDA    #$77
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $01,S
                        SHORT  M
                        LDA    #$77
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$77
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
; MARK: BOOMERANG_006B
BOOMERANG_006B          ENTRY
                        CLC                              ; 8x6, 99 bytes, 159 cycles
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
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $02,S
                        SHORT  M
                        LDA    #$77
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $A2,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $A2,S
                        SHORT  M
                        LDA    #$77
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $02,S
                        AND    #$0FF0
                        ORA    #$7007
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
; MARK: BOOMERANG_007A
BOOMERANG_007A          ENTRY
                        CLC                              ; 8x6, 72 bytes, 119 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$7777                    ; Pattern #1 : 1
;--
                        TSC                              ; Line 3
                        ADC    #$01E0
                        TCS
                        TXA
                        STA    $A1,S
                        SHORT  M
                        LDA    #$77
                        STA    $02,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$7077
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
; MARK: BOOMERANG_007B
BOOMERANG_007B          ENTRY
                        CLC                              ; 8x6, 90 bytes, 148 cycles
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
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $A1,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$7707
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
; MARK: BOSS4_000A
BOSS4_000A              ENTRY
                        CLC                              ; 32x16, 380 bytes, 699 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$6666                    ; Pattern #1 : 52
                        LDY    #$DDDD                    ; Pattern #2 : 16
                        LDA    #$66DD                    ; Pattern #3 : 8
                        TCD
;--
                        LDA    $06,S                     ; Line 0
                        AND    #$00F0
                        ORA    #$6606
                        STA    $06,S
                        LDA    $08,S
                        AND    #$0F00
                        ORA    #$B06B
                        STA    $08,S
                        TSC                              ; Line 1
                        ADC    #$00A9
                        TCS
                        TXA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A0,S
                        PEA    $BB66
                        PHX
                        TSC                              ; Line 3
                        ADC    #$0146
                        TCS
                        LDA    $98,S
                        AND    #$00F0
                        ORA    #$DD0D
                        STA    $98,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A0,S
                        PHX
                        PHY
                        PEA    $DD6D
                        PHY
                        TSC                              ; Line 4
                        ADC    #$00A7
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$6D0D
                        STA    $99,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A1,S
                        PEA    $D66D
                        PEA    $DD6D
                        PEA    $DD6D
                        TSC                              ; Line 5
                        ADC    #$00A6
                        TCS
                        PEA    $D6DD
                        PEA    $6DDD
                        PHY
                        TSC                              ; Line 6
                        ADC    #$00A8
                        TCS
                        PEA    $BBBB
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AB
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A0,S
                        PEA    $BBBB
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00AB
                        TCS
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A2,S
                        PEA    $6B66
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AD
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A1,S
                        PEA    $6B66
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00AE
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A1,S
                        PEA    $DB66
                        PEA    $DD6D
                        PHD
                        PEA    $DD66
                        PEA    $D6DD
                        PHD
                        PEA    $666D
                        TSC                              ; Line 11
                        ADC    #$00AE
                        TCS
                        SHORT  M
                        LDA    $93,S
                        AND    #$F0
                        ORA    #$06
                        STA    $93,S
                        LONG   M
                        PEA    $DB66
                        PEA    $DD6D
                        PHD
                        PEA    $DD66
                        PEA    $D6DD
                        PHD
                        PEA    $666D
                        TSC                              ; Line 12
                        ADC    #$00AF
                        TCS
                        PEA    $BBBB
                        PEA    $BB66
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 13
                        ADC    #$00AB
                        TCS
                        PHD
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 14
                        ADC    #$00A7
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$DD0D
                        STA    $9C,S
                        LDA    $9E,S
                        AND    #$0F00
                        ORA    #$60D6
                        STA    $9E,S
                        PEA    $66D6
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
; MARK: BOSS4_000B
BOSS4_000B              ENTRY
                        CLC                              ; 32x16, 439 bytes, 784 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$6666                    ; Pattern #1 : 50
                        LDY    #$DDDD                    ; Pattern #2 : 14
                        LDA    #$D6DD                    ; Pattern #3 : 9
                        TCD
;--
                        TXA                              ; Line 0
                        STA    $07,S
                        STA    $A7,S
                        LDA    $A9,S
                        AND    #$0F00
                        ORA    #$B06B
                        STA    $A9,S
                        SHORT  M
                        LDA    #$BB
                        STA    $09,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0149
                        TCS
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A2,S
                        SHORT  M
                        LDA    #$BB
                        STA    $01,S
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $9B,S
                        LONG   M
                        PEA    $6B66
                        PHX
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        SHORT  M
                        LDA    #$DD
                        STA    $9A,S
                        LONG   M
                        PHD
                        PHY
                        PHD
                        TSC                              ; Line 4
                        ADC    #$00A8
                        TCS
                        SHORT  M
                        LDA    #$D6
                        STA    $98,S
                        LONG   M
                        LDA    #$DDD6
                        PHX
                        PHA
                        PHA
                        PHA
                        TSC                              ; Line 5
                        ADC    #$00A8
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A0,S
                        SHORT  M
                        LDA    $97,S
                        AND    #$F0
                        ORA    #$06
                        STA    $97,S
                        LONG   M
                        PHX
                        PHY
                        PHD
                        PHY
                        TSC                              ; Line 6
                        ADC    #$00A7
                        TCS
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A2,S
                        SHORT  M
                        LDA    $97,S
                        AND    #$F0
                        ORA    #$06
                        STA    $97,S
                        LONG   M
                        PEA    $6B66
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A9
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $95,S
                        PEA    $6B66
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00AC
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $92,S
                        PEA    $BBBB
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AD
                        TCS
                        LDA    $91,S
                        AND    #$00F0
                        ORA    #$D606
                        STA    $91,S
                        PEA    $BBBB
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00AE
                        TCS
                        LDA    $91,S
                        AND    #$00F0
                        ORA    #$D606
                        STA    $91,S
                        PEA    $BBBB
                        PEA    $6DD6
                        PEA    $DD66
                        PHD
                        PEA    $6D66
                        PEA    $DD6D
                        PEA    $D66D
                        TSC                              ; Line 11
                        ADC    #$00AE
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A0,S
                        LONG   M
                        PEA    $BBBB
                        PEA    $6DD6
                        PEA    $DD66
                        PHD
                        PEA    $6D66
                        PEA    $DD6D
                        PEA    $D66D
                        TSC                              ; Line 12
                        ADC    #$00AD
                        TCS
                        LDA    $9D,S
                        AND    #$0F00
                        ORA    #$60D6
                        STA    $9D,S
                        SHORT  M
                        LDA    $96,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $96,S
                        LONG   M
                        PEA    $BBBB
                        PEA    $6B66
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 13
                        ADC    #$00AA
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A0,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $9B,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 14
                        ADC    #$00A5
                        TCS
                        TYA
                        STA    $9E,S
                        SHORT  M
                        LDA    #$66
                        STA    $A0,S
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
; MARK: BOSS4_001A
BOSS4_001A              ENTRY
                        CLC                              ; 32x16, 390 bytes, 704 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$6666                    ; Pattern #1 : 48
                        LDY    #$DDDD                    ; Pattern #2 : 14
                        LDA    #$66DD                    ; Pattern #3 : 8
                        TCD
;--
                        LDA    $06,S                     ; Line 0
                        AND    #$00F0
                        ORA    #$6606
                        STA    $06,S
                        LDA    $08,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $08,S
                        TSC                              ; Line 1
                        ADC    #$00A9
                        TCS
                        LDA    #$6B66
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $9C,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A0,S
                        PEA    $BB6B
                        PHX
                        TSC                              ; Line 3
                        ADC    #$0146
                        TCS
                        LDA    $98,S
                        AND    #$00F0
                        ORA    #$DD0D
                        STA    $98,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A0,S
                        PHX
                        PEA    $D66D
                        PHY
                        PEA    $DD6D
                        TSC                              ; Line 4
                        ADC    #$00A7
                        TCS
                        LDA    $99,S
                        AND    #$00F0
                        ORA    #$DD0D
                        STA    $99,S
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A1,S
                        PEA    $666D
                        PEA    $DD6D
                        PEA    $DD6D
                        TSC                              ; Line 5
                        ADC    #$00A6
                        TCS
                        PHD
                        PHY
                        PEA    $6DDD
                        TSC                              ; Line 6
                        ADC    #$00A8
                        TCS
                        PEA    $BBBB
                        PEA    $6B66
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00AB
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A0,S
                        PEA    $BBBB
                        PEA    $6B66
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00AB
                        TCS
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A2,S
                        PEA    $BB66
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AD
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A1,S
                        PEA    $BB66
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00AE
                        TCS
                        LDA    $A1,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A1,S
                        PEA    $BBDD
                        PEA    $6D66
                        PHY
                        PEA    $66D6
                        PEA    $DD66
                        PEA    $DD66
                        PEA    $DDD6
                        TSC                              ; Line 11
                        ADC    #$00AE
                        TCS
                        SHORT  M
                        LDA    $93,S
                        AND    #$F0
                        ORA    #$06
                        STA    $93,S
                        LONG   M
                        PEA    $BBDD
                        PEA    $6D66
                        PHY
                        PEA    $66D6
                        PEA    $DD66
                        PEA    $DD66
                        PEA    $DDD6
                        TSC                              ; Line 12
                        ADC    #$00AF
                        TCS
                        PEA    $BBBB
                        PEA    $BB6B
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 13
                        ADC    #$00AB
                        TCS
                        PEA    $66D6
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 14
                        ADC    #$00A7
                        TCS
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$DD0D
                        STA    $9C,S
                        LDA    $9E,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $9E,S
                        PHX
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
; MARK: BOSS4_001B
BOSS4_001B              ENTRY
                        CLC                              ; 32x16, 455 bytes, 792 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$6666                    ; Pattern #1 : 48
                        LDY    #$DDDD                    ; Pattern #2 : 10
                        LDA    #$D6DD                    ; Pattern #3 : 9
                        TCD
;--
                        LDA    #$6B66                    ; Line 0
                        STA    $07,S
                        TXA
                        STA    $A7,S
                        LDA    $A9,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A9,S
                        SHORT  M
                        LDA    #$BB
                        STA    $09,S
                        LDA    $A6,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A6,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0149
                        TCS
                        LDA    $9B,S
                        AND    #$00F0
                        ORA    #$DD06
                        STA    $9B,S
                        SHORT  M
                        LDA    #$BB
                        STA    $01,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A3,S
                        LONG   M
                        PEA    $BB66
                        PHX
                        TSC                              ; Line 3
                        ADC    #$00A6
                        TCS
                        SHORT  M
                        LDA    #$DD
                        STA    $99,S
                        LONG   M
                        PHX
                        PEA    $DDD6
                        PHY
                        TSC                              ; Line 4
                        ADC    #$00A7
                        TCS
                        SHORT  M
                        LDA    #$DD
                        STA    $98,S
                        LONG   M
                        PHX
                        PEA    $D6D6
                        PEA    $DDD6
                        PEA    $DDD6
                        TSC                              ; Line 5
                        ADC    #$00A8
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A0,S
                        SHORT  M
                        LDA    $97,S
                        AND    #$F0
                        ORA    #$06
                        STA    $97,S
                        LONG   M
                        PHX
                        PHD
                        PHY
                        PHD
                        TSC                              ; Line 6
                        ADC    #$00A7
                        TCS
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$B0BB
                        STA    $A2,S
                        SHORT  M
                        LDA    $97,S
                        AND    #$F0
                        ORA    #$06
                        STA    $97,S
                        LONG   M
                        PEA    $BB66
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 7
                        ADC    #$00A9
                        TCS
                        LDA    $95,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $95,S
                        PEA    $BB66
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 8
                        ADC    #$00AC
                        TCS
                        LDA    $92,S
                        AND    #$00F0
                        ORA    #$6606
                        STA    $92,S
                        PEA    $BBBB
                        PEA    $6B66
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 9
                        ADC    #$00AD
                        TCS
                        LDA    $91,S
                        AND    #$00F0
                        ORA    #$6D0D
                        STA    $91,S
                        PEA    $BBBB
                        PEA    $6B66
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 10
                        ADC    #$00AE
                        TCS
                        LDA    $91,S
                        AND    #$00F0
                        ORA    #$6D0D
                        STA    $91,S
                        PEA    $BBBB
                        PEA    $DBDD
                        PEA    $66D6
                        PEA    $DD6D
                        PEA    $66DD
                        PEA    $6DD6
                        PEA    $6DD6
                        TSC                              ; Line 11
                        ADC    #$00AE
                        TCS
                        SHORT  M
                        LDA    $A0,S
                        AND    #$0F
                        ORA    #$B0
                        STA    $A0,S
                        LONG   M
                        PEA    $BBBB
                        PEA    $DBDD
                        PEA    $66D6
                        PEA    $DD6D
                        PEA    $66DD
                        PEA    $6DD6
                        PEA    $6DD6
                        TSC                              ; Line 12
                        ADC    #$00AD
                        TCS
                        LDA    $9D,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $9D,S
                        SHORT  M
                        LDA    $96,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $96,S
                        LONG   M
                        PEA    $BBBB
                        PEA    $BB66
                        PHX
                        PHX
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 13
                        ADC    #$00AA
                        TCS
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A0,S
                        SHORT  M
                        LDA    $9B,S
                        AND    #$F0
                        ORA    #$0D
                        STA    $9B,S
                        LONG   M
                        PHY
                        PHY
                        PHY
                        TSC                              ; Line 14
                        ADC    #$00A5
                        TCS
                        TDC
                        STA    $9E,S
                        SHORT  M
                        LDA    #$66
                        STA    $A0,S
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
; MARK: ENEMY4_000A
ENEMY4_000A             ENTRY
                        CLC                              ; 20x8, 201 bytes, 338 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 10
                        LDY    #$6611                    ; Pattern #2 : 3
                        LDA    #$1111                    ; Pattern #3 : 2
                        TCD
;--
                        TYA                              ; Line 0
                        STA    $A4,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$1601
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A2,S
                        TSC                              ; Line 2
                        ADC    #$0145
                        TCS
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
                        PHX
                        PHX
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    $A0,S
                        AND    #$F0F0
                        ORA    #$0603
                        STA    $A0,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$03
                        STA    $9A,S
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$03
                        STA    $9C,S
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$03
                        STA    $9E,S
                        LONG   M
                        PEA    $3633
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $00,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A1,S
                        TSC
                        ADC    #$0007
                        TCS
                        PEA    $6636
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        TYA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9C,S
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
; MARK: ENEMY4_000B
ENEMY4_000B             ENTRY
                        CLC                              ; 20x8, 199 bytes, 337 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 11
                        LDY    #$1111                    ; Pattern #2 : 5
                        LDA    #$6633                    ; Pattern #3 : 1
                        TCD
;--
                        TYA                              ; Line 0
                        STA    $A3,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$6011
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$6016
                        STA    $A5,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$03
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A1,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $3633
                        PHX
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    $A0,S
                        AND    #$0F0F
                        ORA    #$6030
                        STA    $A0,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$0F
                        ORA    #$30
                        STA    $9A,S
                        LDA    $9C,S
                        AND    #$0F
                        ORA    #$30
                        STA    $9C,S
                        LDA    $9E,S
                        AND    #$0F
                        ORA    #$30
                        STA    $9E,S
                        LONG   M
                        PHD
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$0145
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $01,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6016
                        STA    $A0,S
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        TYA
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6016
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
; MARK: ENEMY4_001A
ENEMY4_001A             ENTRY
                        CLC                              ; 20x8, 201 bytes, 333 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 9
                        LDY    #$6633                    ; Pattern #2 : 2
                        LDA    #$6616                    ; Pattern #3 : 2
                        TCD
;--
                        LDA    #$6611                    ; Line 0
                        STA    $A4,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$1601
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A2,S
                        TSC                              ; Line 2
                        ADC    #$0145
                        TCS
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
                        PEA    $3633
                        PHX
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    $9A,S
                        AND    #$0FF0
                        ORA    #$3003
                        STA    $9A,S
                        SHORT  M
                        LDA    #$66
                        STA    $A1,S
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$30
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$30
                        STA    $9F,S
                        LONG   M
                        PHY
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $00,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A1,S
                        TSC
                        ADC    #$0007
                        TCS
                        PEA    $6666
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        TDC
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9C,S
                        PHD
                        PEA    $1111
;--
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS             ; Restore Stack
                        TCS
                        PLD                              ; Restore Direct Page
                        CLI                              ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: ENEMY4_001B
ENEMY4_001B             ENTRY
                        CLC                              ; 20x8, 197 bytes, 331 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 9
                        LDY    #$1111                    ; Pattern #2 : 5
                        LDA    #$3633                    ; Pattern #3 : 2
                        TCD
;--
                        TYA                              ; Line 0
                        STA    $A3,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$6011
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$6016
                        STA    $A5,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$03
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A1,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $6633
                        PHX
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    $A0,S
                        AND    #$0FF0
                        ORA    #$6006
                        STA    $A0,S
                        SHORT  M
                        LDA    #$33
                        STA    $9A,S
                        LDA    $9C,S
                        AND    #$F0
                        ORA    #$03
                        STA    $9C,S
                        LDA    $9E,S
                        AND    #$F0
                        ORA    #$03
                        STA    $9E,S
                        LONG   M
                        PEA    $6636
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$0145
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $01,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A0,S
                        PHD
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        TYA
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6066
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
; MARK: ENEMY4_002A
ENEMY4_002A             ENTRY
                        CLC                              ; 20x8, 201 bytes, 338 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 10
                        LDY    #$6611                    ; Pattern #2 : 3
                        LDA    #$1111                    ; Pattern #3 : 2
                        TCD
;--
                        TYA                              ; Line 0
                        STA    $A4,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$1601
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A2,S
                        TSC                              ; Line 2
                        ADC    #$0145
                        TCS
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
                        PHX
                        PHX
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    $9A,S
                        AND    #$F0F0
                        ORA    #$0303
                        STA    $9A,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$03
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$F0
                        ORA    #$03
                        STA    $9F,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$06
                        STA    $A1,S
                        LONG   M
                        PEA    $3633
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $00,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A1,S
                        TSC
                        ADC    #$0007
                        TCS
                        PEA    $6636
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        TYA
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9C,S
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
; MARK: ENEMY4_002B
ENEMY4_002B             ENTRY
                        CLC                              ; 20x8, 199 bytes, 337 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 11
                        LDY    #$1111                    ; Pattern #2 : 5
                        LDA    #$6633                    ; Pattern #3 : 1
                        TCD
;--
                        TYA                              ; Line 0
                        STA    $A3,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$6011
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$6016
                        STA    $A5,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$03
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A1,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $3633
                        PHX
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    $9A,S
                        AND    #$0F0F
                        ORA    #$3030
                        STA    $9A,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$0F
                        ORA    #$30
                        STA    $9D,S
                        LDA    $9F,S
                        AND    #$0F
                        ORA    #$30
                        STA    $9F,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A1,S
                        LONG   M
                        PHD
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$0145
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $01,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6016
                        STA    $A0,S
                        PHX
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        TYA
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6016
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
; MARK: ENEMY4_003A
ENEMY4_003A             ENTRY
                        CLC                              ; 20x8, 205 bytes, 340 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 9
                        LDY    #$6633                    ; Pattern #2 : 2
                        LDA    #$6616                    ; Pattern #3 : 2
                        TCD
;--
                        LDA    #$6611                    ; Line 0
                        STA    $A4,S
                        LDA    $03,S
                        AND    #$00F0
                        ORA    #$6601
                        STA    $03,S
                        LDA    $A2,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A2,S
                        TSC                              ; Line 2
                        ADC    #$0145
                        TCS
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
                        PEA    $3633
                        PHX
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    $A0,S
                        AND    #$000F
                        ORA    #$6630
                        STA    $A0,S
                        SHORT  M
                        LDA    $9A,S
                        AND    #$F0
                        ORA    #$03
                        STA    $9A,S
                        LDA    $9C,S
                        AND    #$0F
                        ORA    #$30
                        STA    $9C,S
                        LDA    $9E,S
                        AND    #$0F
                        ORA    #$30
                        STA    $9E,S
                        LONG   M
                        PHY
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$3303
                        STA    $00,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $A1,S
                        TSC
                        ADC    #$0007
                        TCS
                        PEA    $6666
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        TDC
                        STA    $9E,S
                        LDA    $9C,S
                        AND    #$00F0
                        ORA    #$1101
                        STA    $9C,S
                        PHD
                        PEA    $1111
;--
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 00/
                        AND    #$FFCF
                        STA    $E1C068
                        LDA    >STACKADDRESS             ; Restore Stack
                        TCS
                        PLD                              ; Restore Direct Page
                        CLI                              ; Enable Interrupts
                        RTL

;-----------------------------------
; MARK: ENEMY4_003B
ENEMY4_003B             ENTRY
                        CLC                              ; 20x8, 203 bytes, 342 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3333                    ; Pattern #1 : 9
                        LDY    #$1111                    ; Pattern #2 : 5
                        LDA    #$3633                    ; Pattern #3 : 2
                        TCD
;--
                        TYA                              ; Line 0
                        STA    $A3,S
                        LDA    $04,S
                        AND    #$0F00
                        ORA    #$6016
                        STA    $04,S
                        LDA    $A5,S
                        AND    #$0F00
                        ORA    #$6016
                        STA    $A5,S
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$F0
                        ORA    #$03
                        STA    $02,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A1,S
                        LONG   M
                        TSC
                        ADC    #$0006
                        TCS
                        PEA    $6633
                        PHX
                        TSC                              ; Line 3
                        ADC    #$00A5
                        TCS
                        LDA    $9A,S
                        AND    #$F00F
                        ORA    #$0330
                        STA    $9A,S
                        LDA    $9F,S
                        AND    #$F0F0
                        ORA    #$0603
                        STA    $9F,S
                        SHORT  M
                        LDA    $9D,S
                        AND    #$F0
                        ORA    #$03
                        STA    $9D,S
                        LDA    $A1,S
                        AND    #$0F
                        ORA    #$60
                        STA    $A1,S
                        LONG   M
                        PEA    $6636
                        PHX
                        PHX
                        TSC                              ; Line 5
                        ADC    #$0145
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $01,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6066
                        STA    $A0,S
                        PHD
                        PHX
                        PHX
                        TSC                              ; Line 6
                        ADC    #$00A5
                        TCS
                        TYA
                        STA    $9E,S
                        LDA    $A0,S
                        AND    #$0F00
                        ORA    #$6066
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
; MARK: SBULLET_000A
SBULLET_000A            ENTRY
                        CLC                              ; 8x7, 147 bytes, 244 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3327                    ; Pattern #1 : 3
                        LDY    #$7277                    ; Pattern #2 : 2
;--
                        TYA                              ; Line 0
                        STA    $A1,S
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$2022
                        STA    $01,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $00,S
                        STA    $A0,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$2037
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$2037
                        STA    $A2,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $00,S
                        TYA
                        STA    $A1,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$2037
                        STA    $02,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$2022
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
; MARK: SBULLET_000B
SBULLET_000B            ENTRY
                        CLC                              ; 8x7, 147 bytes, 244 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$7233                    ; Pattern #1 : 3
                        LDY    #$7727                    ; Pattern #2 : 2
;--
                        TYA                              ; Line 0
                        STA    $A1,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$2202
                        STA    $01,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        STA    $A2,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$7302
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$7302
                        STA    $A0,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        TYA
                        STA    $A1,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$7302
                        STA    $00,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$2202
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
; MARK: SBULLET_001A
SBULLET_001A            ENTRY
                        CLC                              ; 8x7, 109 bytes, 178 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$7277                    ; Pattern #1 : 2
                        LDY    #$7227                    ; Pattern #2 : 1
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        TYA
                        STA    $A1,S
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$02
                        STA    $01,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        STA    $A1,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$02
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$02
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$2022
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
; MARK: SBULLET_001B
SBULLET_001B            ENTRY
                        CLC                              ; 8x7, 121 bytes, 196 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$7727                    ; Pattern #1 : 2
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$7702
                        STA    $A1,S
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$20
                        STA    $02,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        STA    $A1,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$20
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$2202
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
; MARK: SBULLET_002A
SBULLET_002A            ENTRY
                        CLC                              ; 8x7, 74 bytes, 124 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2222                    ; Pattern #1 : 1
;--
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A1,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$2002
                        STA    $01,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$2002
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
; MARK: SBULLET_002B
SBULLET_002B            ENTRY
                        CLC                              ; 8x7, 82 bytes, 132 cycles
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
                        AND    #$00F0
                        ORA    #$2202
                        STA    $A1,S
                        SHORT  M
                        LDA    #$22
                        STA    $02,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$22
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
; MARK: SBULLET_003A
SBULLET_003A            ENTRY
                        CLC                              ; 8x7, 114 bytes, 187 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3733                    ; Pattern #1 : 1
                        LDY    #$7777                    ; Pattern #2 : 1
                        LDA    #$3773                    ; Pattern #3 : 1
                        TCD
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        TDC
                        STA    $A1,S
                        LDA    $01,S
                        AND    #$000F
                        ORA    #$7770
                        STA    $01,S
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $A1,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$7307
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$7033
                        STA    $02,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        TYA
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
; MARK: SBULLET_003B
SBULLET_003B            ENTRY
                        CLC                              ; 8x7, 143 bytes, 228 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$7733                    ; Pattern #1 : 1
                        LDY    #$3377                    ; Pattern #2 : 1
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        LDA    $01,S
                        AND    #$F0F0
                        ORA    #$0707
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$3307
                        STA    $A1,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$70
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $01,S
                        TXA
                        STA    $A2,S
                        SHORT  M
                        LDA    #$37
                        STA    $03,S
                        LDA    $A1,S
                        AND    #$F0
                        ORA    #$03
                        STA    $A1,S
                        LONG   M
                        TSC                              ; Line 5
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $01,S
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
; MARK: SBULLET_004A
SBULLET_004A            ENTRY
                        CLC                              ; 8x7, 147 bytes, 244 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2273                    ; Pattern #1 : 3
                        LDY    #$3733                    ; Pattern #2 : 2
;--
                        TYA                              ; Line 0
                        STA    $A1,S
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $01,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $00,S
                        STA    $A0,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$7023
                        STA    $02,S
                        LDA    $A2,S
                        AND    #$0F00
                        ORA    #$7023
                        STA    $A2,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $00,S
                        TYA
                        STA    $A1,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$7023
                        STA    $02,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$7077
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
; MARK: SBULLET_004B
SBULLET_004B            ENTRY
                        CLC                              ; 8x7, 147 bytes, 244 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3722                    ; Pattern #1 : 3
                        LDY    #$3373                    ; Pattern #2 : 2
;--
                        TYA                              ; Line 0
                        STA    $A1,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $01,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        STA    $A2,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$3207
                        STA    $00,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$3207
                        STA    $A0,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $02,S
                        TYA
                        STA    $A1,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$3207
                        STA    $00,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 6
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$7707
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
; MARK: SBULLET_005A
SBULLET_005A            ENTRY
                        CLC                              ; 8x7, 121 bytes, 197 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3733                    ; Pattern #1 : 2
;--
                        TXA                              ; Line 0
                        STA    $A1,S
                        LDA    $01,S
                        AND    #$0F00
                        ORA    #$7077
                        STA    $01,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $A0,S
                        AND    #$00F0
                        ORA    #$3307
                        STA    $A0,S
                        SHORT  M
                        LDA    $00,S
                        AND    #$F0
                        ORA    #$07
                        STA    $00,S
                        LDA    $A2,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A2,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $01,S
                        AND    #$F0
                        ORA    #$07
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
; MARK: SBULLET_005B
SBULLET_005B            ENTRY
                        CLC                              ; 8x7, 109 bytes, 179 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$3373                    ; Pattern #1 : 2
                        LDY    #$3773                    ; Pattern #2 : 1
;--
                        TXA                              ; Line 0
                        STA    $A1,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $01,S
                        SHORT  M
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        TYA
                        STA    $A1,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$70
                        STA    $03,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    $02,S
                        AND    #$0F
                        ORA    #$70
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
; MARK: SBULLET_006A
SBULLET_006A            ENTRY
                        CLC                              ; 8x7, 74 bytes, 124 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$7777                    ; Pattern #1 : 1
;--
                        TSC                              ; Line 1
                        ADC    #$00A0
                        TCS
                        TXA
                        STA    $A1,S
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $01,S
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$7007
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
; MARK: SBULLET_006B
SBULLET_006B            ENTRY
                        CLC                              ; 8x7, 82 bytes, 132 cycles
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
                        ORA    #$7707
                        STA    $A1,S
                        SHORT  M
                        LDA    #$77
                        STA    $02,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 3
                        ADC    #$0140
                        TCS
                        SHORT  M
                        LDA    #$77
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
; MARK: SBULLET_007A
SBULLET_007A            ENTRY
                        CLC                              ; 8x7, 109 bytes, 180 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2272                    ; Pattern #1 : 1
                        LDY    #$2772                    ; Pattern #2 : 1
                        LDA    #$7777                    ; Pattern #3 : 1
                        TCD
;--
                        TDC                              ; Line 0
                        STA    $01,S
                        TXA
                        STA    $A1,S
                        SHORT  M
                        LDA    $A0,S
                        AND    #$F0
                        ORA    #$07
                        STA    $A0,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TYA
                        STA    $A1,S
                        LDA    $00,S
                        AND    #$00F0
                        ORA    #$2207
                        STA    $00,S
                        LDA    $02,S
                        AND    #$0F00
                        ORA    #$7027
                        STA    $02,S
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$F000
                        ORA    #$0777
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
; MARK: SBULLET_007B
SBULLET_007B            ENTRY
                        CLC                              ; 8x7, 138 bytes, 221 cycles
                        SEI                              ; Disable Interrupts
                        PHD                              ; Backup Direct Page
                        TSC                              ; Backup Stack
                        STA    >STACKADDRESS
                        LDA    $E1C068                   ; Direct Page and Stack in Bank 01/
                        ORA    #$0030
                        STA    $E1C068
                        TYA                              ; Y = Sprite Target Screen Address (upper left corner)
                        TCS                              ; New Stack address
                        LDX    #$2272                    ; Pattern #1 : 1
                        LDY    #$2277                    ; Pattern #2 : 1
;--
                        TYA                              ; Line 0
                        STA    $A1,S
                        LDA    $01,S
                        AND    #$00F0
                        ORA    #$7707
                        STA    $01,S
                        SHORT  M
                        LDA    $03,S
                        AND    #$0F
                        ORA    #$70
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$20
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 2
                        ADC    #$0140
                        TCS
                        TXA
                        STA    $01,S
                        LDA    $A1,S
                        AND    #$00F0
                        ORA    #$2207
                        STA    $A1,S
                        SHORT  M
                        LDA    #$77
                        STA    $03,S
                        LDA    $A3,S
                        AND    #$0F
                        ORA    #$70
                        STA    $A3,S
                        LONG   M
                        TSC                              ; Line 4
                        ADC    #$0140
                        TCS
                        LDA    $01,S
                        AND    #$0FF0
                        ORA    #$7007
                        STA    $01,S
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

THISISAFORMATTINGLABEL  ANOP
                        END
