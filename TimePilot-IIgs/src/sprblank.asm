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
; Incoming values:   Y = Screen Address (upper left corner)
blank2x2                entry
                        tyx
                        lda    zSkyColor
                        short  m
                        sta    >SCREEN_ROW_BASE,x
                        sta    >SCREEN_ROW_BASE+160,x
                        long   m
                        rts

;-----------------------------------------------------------------------------
; MARK: blank8x8
; Incoming values:   X = Rows to Erase, Y = Screen Address (upper left corner)
; at_blank_rowXX tables are in data.asm
blank8x8                entry
                        ldx    zRowsToErase            ; 2x the actual rows (this is for address lookup)
                        lda    at_blank_row8,x         ; get the address
                        ldx    zSkyColor               ; Pattern #1 : 240
                        sta    skip8x8+1               ; self modify so only so many rows are cleared
                        clc                            ; 16x16, 185 bytes, 439 cycles
                        sei                            ; Disable Interrupts
                        phd                            ; Backup Direct Page
                        tsc                            ; Backup Stack
                        sta    blank8x8Stack+1         ; Fill in Place Holder
                        lda    STATEREG                ; Direct Page and Stack in Bank 01/
                        ora    #$0030
                        sta    STATEREG
                        tya                            ; Y = Sprite Target Screen Address (upper left corner)
                        adc    #$0003                  ; Width/2-1
                        tcs                            ; New Stack address
skip8x8                 entry
                        jmp    skip8l0
;--
skip8l0                 phx
                        phx
                        adc    #$00A0                  ; Line 1
                        tcs
                        phx
                        phx
                        adc    #$00A0                  ; Line 2
                        tcs
                        phx
                        phx
                        adc    #$00A0                  ; Line 3
                        tcs
                        phx
                        phx
                        adc    #$00A0                  ; Line 4
                        tcs
                        phx
                        phx
                        adc    #$00A0                  ; Line 5
                        tcs
                        phx
                        phx
                        adc    #$00A0                  ; Line 6
                        tcs
                        phx
                        phx
                        adc    #$00A0                  ; Line 7
                        tcs
                        phx
                        phx
;--
blank8x8FailSafe        entry
                        lda    STATEREG                ; Direct Page and Stack in Bank 00/
                        and    #$FFCF
                        sta    STATEREG
blank8x8Stack           lda    #$FFFF                  ; Restore Stack
                        tcs
                        pld                            ; Restore Direct Page
                        cli                            ; Enable Interrupts
                        rts

;-----------------------------------------------------------------------------
; MARK: blank12x16
; Incoming values:   X = Rows to Erase, Y = Screen Address (upper left corner)
; at_blank_rowXX tables are in data.asm
blank12x16              entry
                        ldx    zRowsToErase            ; 2x the actual rows (this is for address lookup)
                        lda    at_blank_row12,x        ; get the address
                        ldx    zSkyColor               ; Pattern #1 : 240
                        sta    skip12x16+1             ; self modify so only so many rows are cleared
                        clc                            ; 16x16, 185 bytes, 439 cycles
                        sei                            ; Disable Interrupts
                        phd                            ; Backup Direct Page
                        tsc                            ; Backup Stack
                        sta    blank12x16Stack+1       ; Fill in Place Holder
                        lda    STATEREG                ; Direct Page and Stack in Bank 01/
                        ora    #$0030
                        sta    STATEREG
                        tya                            ; Y = Sprite Target Screen Address (upper left corner)
                        adc    #$0005                  ; Width/2-1
                        tcs                            ; New Stack address
skip12x16               entry
                        jmp    skip12l0
;--
skip12l0                phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 1
                        tcs
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 2
                        tcs
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 3
                        tcs
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 4
                        tcs
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 5
                        tcs
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 6
                        tcs
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 7
                        tcs
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 8
                        tcs
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 9
                        tcs
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 10
                        tcs
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 11
                        tcs
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 12
                        tcs
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 13
                        tcs
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 14
                        tcs
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 15
                        tcs
                        phx
                        phx
                        phx
;--
blank12x16FailSafe      entry
                        lda    STATEREG                ; Direct Page and Stack in Bank 00/
                        and    #$FFCF
                        sta    STATEREG
blank12x16Stack         lda    #$FFFF                  ; Restore Stack
                        tcs
                        pld                            ; Restore Direct Page
                        cli                            ; Enable Interrupts
                        rts

;-----------------------------------------------------------------------------
; MARK: blank16x16
; Incoming values:   X = Rows to Erase, Y = Screen Address (upper left corner)
; at_blank_rowXX tables are in data.asm
blank16x16              entry
                        ldx    zRowsToErase            ; 2x the actual rows (this is for address lookup)
                        lda    at_blank_row16,x        ; get the address
                        ldx    zSkyColor               ; Pattern #1 : 240
                        sta    skip16x16+1             ; self modify so only so many rows are cleared
                        clc                            ; 16x16, 185 bytes, 439 cycles
                        sei                            ; Disable Interrupts
                        phd                            ; Backup Direct Page
                        tsc                            ; Backup Stack
                        sta    blank16x16Stack+1       ; Fill in Place Holder
                        lda    STATEREG                ; Direct Page and Stack in Bank 01/
                        ora    #$0030
                        sta    STATEREG
                        tya                            ; Y = Sprite Target Screen Address (upper left corner)
                        adc    #$0007                  ; Width/2-1
                        tcs                            ; New Stack address
skip16x16               entry
                        jmp    skip16l0
;--
skip16l0                phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 1
                        tcs
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 2
                        tcs
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 3
                        tcs
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 4
                        tcs
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 5
                        tcs
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 6
                        tcs
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 7
                        tcs
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 9
                        tcs
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 10
                        tcs
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 11
                        tcs
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 12
                        tcs
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 13
                        tcs
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 14
                        tcs
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 15
                        tcs
                        phx
                        phx
                        phx
                        phx
;--
blank16x16FailSafe      entry
                        lda    STATEREG                ; Direct Page and Stack in Bank 00/
                        and    #$FFCF
                        sta    STATEREG
blank16x16Stack         lda    #$FFFF                  ; Restore Stack
                        tcs
                        pld                            ; Restore Direct Page
                        cli                            ; Enable Interrupts
                        rts

;-----------------------------------------------------------------------------
; MARK: blank20x16
; Incoming values:   X = Rows to Erase, Y = Screen Address (upper left corner)
; at_blank_rowXX tables are in data.asm
blank20x16              entry
                        ldx    zRowsToErase            ; 2x the actual rows (this is for address lookup)
                        lda    at_blank_row20,x        ; get the address
                        ldx    zSkyColor               ; Pattern #1 : 240
                        sta    skip20x16+1             ; self modify so only so many rows are cleared
                        clc                            ; 16x16, 185 bytes, 439 cycles
                        sei                            ; Disable Interrupts
                        phd                            ; Backup Direct Page
                        tsc                            ; Backup Stack
                        sta    blank20x16Stack+1       ; Fill in Place Holder
                        lda    STATEREG                ; Direct Page and Stack in Bank 01/
                        ora    #$0030
                        sta    STATEREG
                        tya                            ; Y = Sprite Target Screen Address (upper left corner)
                        adc    #$0009                  ; Width/2-1
                        tcs                            ; New Stack address
skip20x16               entry
                        jmp    skip20l0
;--
skip20l0                phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 1
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 2
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 3
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 4
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 5
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 6
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 7
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 9
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 10
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 11
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 12
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 13
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 14
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 15
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
;--
blank20x16FailSafe      entry
                        lda    STATEREG                ; Direct Page and Stack in Bank 00/
                        and    #$FFCF
                        sta    STATEREG
blank20x16Stack         lda    #$FFFF                  ; Restore Stack
                        tcs
                        pld                            ; Restore Direct Page
                        cli                            ; Enable Interrupts
                        rts

;-----------------------------------------------------------------------------
; MARK: blank28x16
; Incoming values:   X = Rows to Erase, Y = Screen Address (upper left corner)
; at_blank_rowXX tables are in data.asm
blank28x16              entry
                        ldx    zRowsToErase
                        lda    at_blank_row28,x
                        ldx    zSkyColor               ; Pattern #1 : 240
                        sta    skip28x16+1
                        clc                            ; 32x16, 249 bytes, 695 cycles
                        sei                            ; Disable Interrupts
                        phd                            ; Backup Direct Page
                        tsc                            ; Backup Stack
                        sta    blank28x16Stack+1       ; Fill in Place Holder
                        lda    STATEREG                ; Direct Page and Stack in Bank 01/
                        ora    #$0030
                        sta    STATEREG
                        tya                            ; Y = Sprite Target Screen Address (upper left corner)
                        adc    #$000D                  ; Width/2-1
                        tcs                            ; New Stack address
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
                        adc    #$00A0                  ; Line 1
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 2
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 3
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 4
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 5
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 6
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 7
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 9
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 10
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 11
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 12
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 13
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 14
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 15
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
;--
blank28x16FailSafe      entry
                        lda    STATEREG                ; Direct Page and Stack in Bank 00/
                        and    #$FFCF
                        sta    STATEREG
blank28x16Stack         lda    #$FFFF                  ; Restore Stack
                        tcs
                        pld                            ; Restore Direct Page
                        cli                            ; Enable Interrupts
                        rts

;-----------------------------------------------------------------------------
; MARK: blank32x16
; Incoming values:   X = Rows to Erase, Y = Screen Address (upper left corner)
; at_blank_rowXX tables are in data.asm
blank32x16              entry
                        ldx    zRowsToErase
                        lda    at_blank_row32,x
                        ldx    zSkyColor               ; Pattern #1 : 240
                        sta    skip32x16+1
                        clc                            ; 32x16, 249 bytes, 695 cycles
                        sei                            ; Disable Interrupts
                        phd                            ; Backup Direct Page
                        tsc                            ; Backup Stack
                        sta    blank32x16Stack+1       ; Fill in Place Holder
                        lda    STATEREG                ; Direct Page and Stack in Bank 01/
                        ora    #$0030
                        sta    STATEREG
                        tya                            ; Y = Sprite Target Screen Address (upper left corner)
                        adc    #$000F                  ; Width/2-1
                        tcs                            ; New Stack address
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
                        adc    #$00A0                  ; Line 1
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 2
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 3
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 4
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 5
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 6
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 7
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 8
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 9
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 10
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 11
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 12
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 13
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 14
                        tcs
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        phx
                        adc    #$00A0                  ; Line 15
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
blank32x16FailSafe      entry
                        lda    STATEREG                ; Direct Page and Stack in Bank 00/
                        and    #$FFCF
                        sta    STATEREG
blank32x16Stack         lda    #$FFFF                  ; Restore Stack
                        tcs
                        pld                            ; Restore Direct Page
                        cli                            ; Enable Interrupts
                        rts

;-----------------------------------------------------------------------------
; MARK: blank48x8
blank48x8               entry
                        ldx    zSkyColor               ; Pattern #1 : 368
                        clc                            ; 48x16, 313 bytes, 951 cycles
                        sei                            ; Disable Interrupts
                        phd                            ; Backup Direct Page
                        tsc                            ; Backup Stack
                        sta    blank48x8Stack+1
                        lda    STATEREG                ; Direct Page and Stack in Bank 01/
                        ora    #$0030
                        sta    STATEREG
                        tya                            ; Y = Sprite Target Screen Address (upper left corner)
                        adc    #$0017                  ; Width/2-1
                        tcs                            ; New Stack address
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
                        adc    #$00A0                  ; Line 1
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
                        adc    #$00A0                  ; Line 2
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
                        adc    #$00A0                  ; Line 3
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
                        adc    #$00A0                  ; Line 4
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
                        adc    #$00A0                  ; Line 5
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
                        adc    #$00A0                  ; Line 6
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
                        adc    #$00A0                  ; Line 7
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
                        tsc                            ; Line 8
;--
                        lda    STATEREG                ; Direct Page and Stack in Bank 00/
                        and    #$FFCF
                        sta    STATEREG
blank48x8Stack          lda    #$FFFF                  ; Restore Stack
                        tcs
                        pld                            ; Restore Direct Page
                        cli                            ; Enable Interrupts
                        rts

;-----------------------------------------------------------------------------
; MARK: blank48x16
blank48x16              entry
                        ldx    zSkyColor               ; Pattern #1 : 368
                        clc                            ; 48x16, 313 bytes, 951 cycles
                        sei                            ; Disable Interrupts
                        phd                            ; Backup Direct Page
                        tsc                            ; Backup Stack
                        sta    blank48x16Stack+1
                        lda    STATEREG                ; Direct Page and Stack in Bank 01/
                        ora    #$0030
                        sta    STATEREG
                        tya                            ; Y = Sprite Target Screen Address (upper left corner)
                        adc    #$0017                  ; Width/2-1
                        tcs                            ; New Stack address
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
                        adc    #$00A0                  ; Line 1
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
                        adc    #$00A0                  ; Line 2
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
                        adc    #$00A0                  ; Line 3
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
                        adc    #$00A0                  ; Line 4
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
                        adc    #$00A0                  ; Line 5
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
                        adc    #$00A0                  ; Line 6
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
                        adc    #$00A0                  ; Line 7
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
                        adc    #$00A0                  ; Line 8
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
                        adc    #$00A0                  ; Line 9
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
                        adc    #$00A0                  ; Line 10
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
                        adc    #$00A0                  ; Line 11
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
                        adc    #$00A0                  ; Line 12
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
                        adc    #$00A0                  ; Line 13
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
                        adc    #$00A0                  ; Line 14
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
                        adc    #$00A0                  ; Line 15
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
                        lda    STATEREG                ; Direct Page and Stack in Bank 00/
                        and    #$FFCF
                        sta    STATEREG
blank48x16Stack         lda    #$FFFF                  ; Restore Stack
                        tcs
                        pld                            ; Restore Direct Page
                        cli                            ; Enable Interrupts
                        rts

;-------------------------------

thisisaformattinglabel  anop
                        END
