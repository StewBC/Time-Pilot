;-----------------------------------------------------------------------------
; sprblank.asm
; Part of Time Pilot, the 1982 arcade game remake for the Apple IIgs
;
; Stefan Wessels, 2024
; This is free and unencumbered software released into the public domain.
;-----------------------------------------------------------------------------

                        copy   src/globals.S
                        mcopy  src/sprblank.mac

SPRBLANK                START

                        using  GAMEDATA
                        using  VARIABLES
;-----------------------------------------------------------------------------

; MARK: blank2x2
blank2x2                entry
                        tyx
                        tya
                        adc    #160
                        tay
                        lda    zSkyColor
                        short  m
                        sta    >SCREEN_ROW_BASE,x
                        tyx
                        sta    >SCREEN_ROW_BASE,x
                        long   m
                        rts

;-----------------------------------------------------------------------------
; MARK: blank8x8
blank8x8                entry
                        ldx    zRowsToErase        ; 2x the actual rows (this is for address lookup)
                        lda    at_blank_row8,x     ; get the address
                        ldx    zSkyColor           ; Pattern #1 : 240
                        sta    skip8x8+1           ; self modify so only so many rows are cleared
                        clc                        ; 16x16, 185 bytes, 439 cycles
                        sei                        ; Disable Interrupts
                        phd                        ; Backup Direct Page
                        tsc                        ; Backup Stack
                        sta    >StackAddress
                        lda    STATEREG            ; Direct Page and Stack in Bank 01/

                        ora    #$0030
                        sta    STATEREG
                        tya                        ; Y = Sprite Target Screen Address (upper left corner)

                        adc    #$0003              ; Width/2-1
                        tcs                        ; New Stack address
skip8x8                 entry
                        jmp    skip8l0
;--

skip8l0                 phx
                        phx
                        tsc                        ; Line 1
                        adc    #$00A4
                        tcs
                        phx
                        phx
                        tsc                        ; Line 2
                        adc    #$00A4
                        tcs
                        phx
                        phx
                        tsc                        ; Line 3
                        adc    #$00A4
                        tcs
                        phx
                        phx
                        tsc                        ; Line 4
                        adc    #$00A4
                        tcs
                        phx
                        phx
                        tsc                        ; Line 5
                        adc    #$00A4
                        tcs
                        phx
                        phx
                        tsc                        ; Line 6
                        adc    #$00A4
                        tcs
                        phx
                        phx
                        tsc                        ; Line 7
                        adc    #$00A4
                        tcs
                        phx
                        phx
;--

                        lda    STATEREG            ; Direct Page and Stack in Bank 00/

                        and    #$FFCF
                        sta    STATEREG
                        lda    >StackAddress       ; Restore Stack
                        tcs
                        pld                        ; Restore Direct Page
                        cli                        ; Enable Interrupts
                        rts

;-----------------------------------------------------------------------------
; MARK: blank12x16
blank12x16              entry
                        ldx    zRowsToErase        ; 2x the actual rows (this is for address lookup)
                        lda    at_blank_row12,x    ; get the address
                        ldx    zSkyColor           ; Pattern #1 : 240
                        sta    skip12x16+1         ; self modify so only so many rows are cleared
                        clc                        ; 16x16, 185 bytes, 439 cycles
                        sei                        ; Disable Interrupts
                        phd                        ; Backup Direct Page
                        tsc                        ; Backup Stack
                        sta    >StackAddress
                        lda    STATEREG            ; Direct Page and Stack in Bank 01/

                        ora    #$0030
                        sta    STATEREG
                        tya                        ; Y = Sprite Target Screen Address (upper left corner)

                        adc    #$0005              ; Width/2-1
                        tcs                        ; New Stack address
skip12x16               entry
                        jmp    skip12l0
;--

skip12l0                phx
                        phx
                        phx
                        tsc                        ; Line 1
                        adc    #$00A6
                        tcs
                        phx
                        phx
                        phx
                        tsc                        ; Line 2
                        adc    #$00A6
                        tcs
                        phx
                        phx
                        phx
                        tsc                        ; Line 3
                        adc    #$00A6
                        tcs
                        phx
                        phx
                        phx
                        tsc                        ; Line 4
                        adc    #$00A6
                        tcs
                        phx
                        phx
                        phx
                        tsc                        ; Line 5
                        adc    #$00A6
                        tcs
                        phx
                        phx
                        phx
                        tsc                        ; Line 6
                        adc    #$00A6
                        tcs
                        phx
                        phx
                        phx
                        tsc                        ; Line 7
                        adc    #$00A6
                        tcs
                        phx
                        phx
                        phx
                        tsc                        ; Line 8
                        adc    #$00A6
                        tcs
                        phx
                        phx
                        phx
                        tsc                        ; Line 9
                        adc    #$00A6
                        tcs
                        phx
                        phx
                        phx
                        tsc                        ; Line 10
                        adc    #$00A6
                        tcs
                        phx
                        phx
                        phx
                        tsc                        ; Line 11
                        adc    #$00A6
                        tcs
                        phx
                        phx
                        phx
                        tsc                        ; Line 12
                        adc    #$00A6
                        tcs
                        phx
                        phx
                        phx
                        tsc                        ; Line 13
                        adc    #$00A6
                        tcs
                        phx
                        phx
                        phx
                        tsc                        ; Line 14
                        adc    #$00A6
                        tcs
                        phx
                        phx
                        phx
                        tsc                        ; Line 15
                        adc    #$00A6
                        tcs
                        phx
                        phx
                        phx
;--

                        lda    STATEREG            ; Direct Page and Stack in Bank 00/

                        and    #$FFCF
                        sta    STATEREG
                        lda    >StackAddress       ; Restore Stack
                        tcs
                        pld                        ; Restore Direct Page
                        cli                        ; Enable Interrupts
                        rts

;-----------------------------------------------------------------------------
; MARK: blank16x16
blank16x16              entry
                        ldx    zRowsToErase        ; 2x the actual rows (this is for address lookup)
                        lda    at_blank_row16,x    ; get the address
                        ldx    zSkyColor           ; Pattern #1 : 240
                        sta    skip16x16+1         ; self modify so only so many rows are cleared
                        clc                        ; 16x16, 185 bytes, 439 cycles
                        sei                        ; Disable Interrupts
                        phd                        ; Backup Direct Page
                        tsc                        ; Backup Stack
                        sta    >StackAddress
                        lda    STATEREG            ; Direct Page and Stack in Bank 01/

                        ora    #$0030
                        sta    STATEREG
                        tya                        ; Y = Sprite Target Screen Address (upper left corner)

                        adc    #$0007              ; Width/2-1
                        tcs                        ; New Stack address
skip16x16               entry
                        jmp    skip16l0
;--

skip16l0                phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 1
                        adc    #$00A8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 2
                        adc    #$00A8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 3
                        adc    #$00A8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 4
                        adc    #$00A8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 5
                        adc    #$00A8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 6
                        adc    #$00A8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 7
                        adc    #$00A8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 8
                        adc    #$00A8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 9
                        adc    #$00A8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 10
                        adc    #$00A8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 11
                        adc    #$00A8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 12
                        adc    #$00A8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 13
                        adc    #$00A8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 14
                        adc    #$00A8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 15
                        adc    #$00A8
                        tcs
                        phx
                        phx
                        phx
                        phx
;--

                        lda    STATEREG            ; Direct Page and Stack in Bank 00/

                        and    #$FFCF
                        sta    STATEREG
                        lda    >StackAddress       ; Restore Stack
                        tcs
                        pld                        ; Restore Direct Page
                        cli                        ; Enable Interrupts
                        rts

;-----------------------------------------------------------------------------
; MARK: blank20x16
blank20x16              entry
                        ldx    zRowsToErase        ; 2x the actual rows (this is for address lookup)
                        lda    at_blank_row20,x    ; get the address
                        ldx    zSkyColor           ; Pattern #1 : 240
                        sta    skip20x16+1         ; self modify so only so many rows are cleared
                        clc                        ; 16x16, 185 bytes, 439 cycles
                        sei                        ; Disable Interrupts
                        phd                        ; Backup Direct Page
                        tsc                        ; Backup Stack
                        sta    >StackAddress
                        lda    STATEREG            ; Direct Page and Stack in Bank 01/

                        ora    #$0030
                        sta    STATEREG
                        tya                        ; Y = Sprite Target Screen Address (upper left corner)

                        adc    #$0009              ; Width/2-1
                        tcs                        ; New Stack address
skip20x16               entry
                        jmp    skip20l0
;--

skip20l0                phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 1
                        adc    #$00AA
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 2
                        adc    #$00AA
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 3
                        adc    #$00AA
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 4
                        adc    #$00AA
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 5
                        adc    #$00AA
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 6
                        adc    #$00AA
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 7
                        adc    #$00AA
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 8
                        adc    #$00AA
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 9
                        adc    #$00AA
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 10
                        adc    #$00AA
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 11
                        adc    #$00AA
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 12
                        adc    #$00AA
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 13
                        adc    #$00AA
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 14
                        adc    #$00AA
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 15
                        adc    #$00AA
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
;--

                        lda    STATEREG            ; Direct Page and Stack in Bank 00/

                        and    #$FFCF
                        sta    STATEREG
                        lda    >StackAddress       ; Restore Stack
                        tcs
                        pld                        ; Restore Direct Page
                        cli                        ; Enable Interrupts
                        rts

;-----------------------------------------------------------------------------
; MARK: blank28x16
blank28x16              entry
                        ldx    zRowsToErase
                        lda    at_blank_row28,x
                        ldx    zSkyColor           ; Pattern #1 : 240
                        sta    skip28x16+1
                        clc                        ; 32x16, 249 bytes, 695 cycles
                        sei                        ; Disable Interrupts
                        phd                        ; Backup Direct Page
                        tsc                        ; Backup Stack
                        sta    >StackAddress
                        lda    STATEREG            ; Direct Page and Stack in Bank 01/

                        ora    #$0030
                        sta    STATEREG
                        tya                        ; Y = Sprite Target Screen Address (upper left corner)

                        adc    #$000D              ; Width/2-1
                        tcs                        ; New Stack address
skip28x16               entry
                        jmp    skip28l1
;--

skip28l1                phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 1
                        adc    #$00AE
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 2
                        adc    #$00AE
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 3
                        adc    #$00AE
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 4
                        adc    #$00AE
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 5
                        adc    #$00AE
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 6
                        adc    #$00AE
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 7
                        adc    #$00AE
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 8
                        adc    #$00AE
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 9
                        adc    #$00AE
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 10
                        adc    #$00AE
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 11
                        adc    #$00AE
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 12
                        adc    #$00AE
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 13
                        adc    #$00AE
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 14
                        adc    #$00AE
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 15
                        adc    #$00AE
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
;--

                        lda    STATEREG            ; Direct Page and Stack in Bank 00/

                        and    #$FFCF
                        sta    STATEREG
                        lda    >StackAddress       ; Restore Stack
                        tcs
                        pld                        ; Restore Direct Page
                        cli                        ; Enable Interrupts
                        rts

;-----------------------------------------------------------------------------
; MARK: blank32x16
blank32x16              entry
                        ldx    zRowsToErase
                        lda    at_blank_row32,x
                        ldx    zSkyColor           ; Pattern #1 : 240
                        sta    skip32x16+1
                        clc                        ; 32x16, 249 bytes, 695 cycles
                        sei                        ; Disable Interrupts
                        phd                        ; Backup Direct Page
                        tsc                        ; Backup Stack
                        sta    >StackAddress
                        lda    STATEREG            ; Direct Page and Stack in Bank 01/

                        ora    #$0030
                        sta    STATEREG
                        tya                        ; Y = Sprite Target Screen Address (upper left corner)

                        adc    #$000F              ; Width/2-1
                        tcs                        ; New Stack address
skip32x16               entry
                        jmp    skip32l1
;--

skip32l1                phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 1
                        adc    #$00B0
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 2
                        adc    #$00B0
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 3
                        adc    #$00B0
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 4
                        adc    #$00B0
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 5
                        adc    #$00B0
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 6
                        adc    #$00B0
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 7
                        adc    #$00B0
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 8
                        adc    #$00B0
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 9
                        adc    #$00B0
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 10
                        adc    #$00B0
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 11
                        adc    #$00B0
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 12
                        adc    #$00B0
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 13
                        adc    #$00B0
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 14
                        adc    #$00B0
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 15
                        adc    #$00B0
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
;--

                        lda    STATEREG            ; Direct Page and Stack in Bank 00/

                        and    #$FFCF
                        sta    STATEREG
                        lda    >StackAddress       ; Restore Stack
                        tcs
                        pld                        ; Restore Direct Page
                        cli                        ; Enable Interrupts
                        rts

;-----------------------------------------------------------------------------
; MARK: blank48x8
blank48x8               entry
                        ldx    zSkyColor           ; Pattern #1 : 368
                        clc                        ; 48x16, 313 bytes, 951 cycles
                        sei                        ; Disable Interrupts
                        phd                        ; Backup Direct Page
                        tsc                        ; Backup Stack
                        sta    >StackAddress
                        lda    STATEREG            ; Direct Page and Stack in Bank 01/

                        ora    #$0030
                        sta    STATEREG
                        tya                        ; Y = Sprite Target Screen Address (upper left corner)

                        adc    #$0017              ; Width/2-1
                        tcs                        ; New Stack address
;--

                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 1
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 2
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 3
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 4
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 5
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 6
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 7
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 8
;--

                        lda    STATEREG            ; Direct Page and Stack in Bank 00/

                        and    #$FFCF
                        sta    STATEREG
                        lda    >StackAddress       ; Restore Stack
                        tcs
                        pld                        ; Restore Direct Page
                        cli                        ; Enable Interrupts
                        rts

;-----------------------------------------------------------------------------
; MARK: blank48x16
blank48x16              entry
                        ldx    zSkyColor           ; Pattern #1 : 368
                        clc                        ; 48x16, 313 bytes, 951 cycles
                        sei                        ; Disable Interrupts
                        phd                        ; Backup Direct Page
                        tsc                        ; Backup Stack
                        sta    >StackAddress
                        lda    STATEREG            ; Direct Page and Stack in Bank 01/

                        ora    #$0030
                        sta    STATEREG
                        tya                        ; Y = Sprite Target Screen Address (upper left corner)

                        adc    #$0017              ; Width/2-1
                        tcs                        ; New Stack address
;--

                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 1
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 2
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 3
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 4
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 5
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 6
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 7
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 8
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 9
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 10
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 11
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 12
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 13
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 14
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        tsc                        ; Line 15
                        adc    #$00B8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
;--

                        lda    STATEREG            ; Direct Page and Stack in Bank 00/

                        and    #$FFCF
                        sta    STATEREG
                        lda    >StackAddress       ; Restore Stack
                        tcs
                        pld                        ; Restore Direct Page
                        cli                        ; Enable Interrupts
                        rts

;-------------------------------

thisisaformattinglabel  anop
                        END
