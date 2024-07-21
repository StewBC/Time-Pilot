;-----------------------------------------------------------------------------
; print.asm
; Part of Time Pilot, the 1982 arcade game remake for the Apple IIgs
;
; Stefan Wessels, 2024
; This is free and unencumbered software released into the public domain.
;-----------------------------------------------------------------------------

                        copy   src/globals.s
                        mcopy  src/print.mac

PRINT                   START  PRINT

                        using  TEXT

;-----------------------------------------------------------------------------
; screen location (rel to $e12000) in X, |STRADDR in Y, ^STRADDR in A
; MARK: printZString
printZString            entry
                        phb
                        phk
                        plb
                        short  m
                        sta    pzsReadChar+3
                        sty    pzsReadChar+1
pzsReadChar             lda    >$ffffff
                        bne    pzsPrintChar
                        long   m
                        plb
                        rtl
pzsPrintChar            long   m
                        inc    pzsReadChar+1
                        sec
                        sbc    #32                 ; relative to space character (1st font character)
                        asl    a                   ; * 32 for bytes/character
                        asl    a
                        asl    a
                        asl    a
                        asl    a
                        tay

                        lda    font,y              ; get 4 pixels, line 1
                        and    printFontColor      ; mask for color
                        sta    SCREEN_BASE+$000,x  ; write into screen
                        lda    font+$2,y           ; get second 4 pixels, line 1
                        and    printFontColor
                        sta    SCREEN_BASE+$002,x

                        lda    font+$4,y           ; line 2, manually increase both font & SCREEN_BASE for speed ;-p
                        and    printFontColor
                        sta    SCREEN_BASE+$0A0,x
                        lda    font+$6,y
                        and    printFontColor
                        sta    SCREEN_BASE+$0A2,x

                        lda    font+$8,y           ; line 3
                        and    printFontColor
                        sta    SCREEN_BASE+$140,x
                        lda    font+$a,y
                        and    printFontColor
                        sta    SCREEN_BASE+$142,x

                        lda    font+$c,y           ; line 4
                        and    printFontColor
                        sta    SCREEN_BASE+$1E0,x
                        lda    font+$e,y
                        and    printFontColor
                        sta    SCREEN_BASE+$1E2,x

                        lda    font+$10,y          ; line 5
                        and    printFontColor
                        sta    SCREEN_BASE+$280,x
                        lda    font+$12,y
                        and    printFontColor
                        sta    SCREEN_BASE+$282,x

                        lda    font+$14,y          ; line 6
                        and    printFontColor
                        sta    SCREEN_BASE+$320,x
                        lda    font+$16,y
                        and    printFontColor
                        sta    SCREEN_BASE+$322,x

                        lda    font+$18,y          ; line 7
                        and    printFontColor
                        sta    SCREEN_BASE+$3C0,x
                        lda    font+$1a,y
                        and    printFontColor
                        sta    SCREEN_BASE+$3C2,x

                        lda    font+$1c,y          ; line 8
                        and    printFontColor
                        sta    SCREEN_BASE+$460,x
                        lda    font+$1e,y
                        and    printFontColor
                        sta    SCREEN_BASE+$462,x

                        inx                        ; move to next character on screen (8 pixels right)
                        inx
                        inx
                        inx

                        lda    #0                  ; get the high byte in a to 0
                        short  m
                        jmp    pzsReadChar

thisisaformattinglabel  anop
                        END

;-----------------------------------------------------------------------------
FONTDATA                DATA   PRINT

;-----------------------------------------------------------------------------
; MARK: font
font                    entry
                        dc     h'00000000'         ; 0
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'

                        dc     h'00FFF000'         ; 1
                        dc     h'00FFF000'
                        dc     h'00FFF000'
                        dc     h'00FF0000'
                        dc     h'00FF0000'
                        dc     h'00000000'
                        dc     h'00FF0000'
                        dc     h'00000000'

                        dc     h'0FF0FF00'         ; 2
                        dc     h'0FF0FF00'
                        dc     h'0F00F000'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'

                        dc     h'0FF0FF00'         ; 3
                        dc     h'0FF0FF00'
                        dc     h'FFFFFFF0'
                        dc     h'0FF0FF00'
                        dc     h'FFFFFFF0'
                        dc     h'0FF0FF00'
                        dc     h'0FF0FF00'
                        dc     h'00000000'

                        dc     h'000F0000'         ; 4
                        dc     h'0FFFFF00'
                        dc     h'FF0F0000'
                        dc     h'0FFFFF00'
                        dc     h'000F0FF0'
                        dc     h'0FFFFF00'
                        dc     h'000F0000'
                        dc     h'00000000'

                        dc     h'0F0000F0'         ; 5
                        dc     h'F0F00F00'
                        dc     h'0F00F000'
                        dc     h'000F0000'
                        dc     h'00F00F00'
                        dc     h'0F00F0F0'
                        dc     h'F0000F00'
                        dc     h'00000000'

                        dc     h'00FF0000'         ; 6
                        dc     h'0F00F000'
                        dc     h'0FF0F000'
                        dc     h'0FFF0000'
                        dc     h'F00FF0F0'
                        dc     h'F000FF00'
                        dc     h'0FFFF0F0'
                        dc     h'00000000'

                        dc     h'00FF0000'         ; 7
                        dc     h'00FF0000'
                        dc     h'000F0000'
                        dc     h'00F00000'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'

                        dc     h'0000FF00'         ; 8
                        dc     h'000FF000'
                        dc     h'00FF0000'
                        dc     h'00FF0000'
                        dc     h'00FF0000'
                        dc     h'000FF000'
                        dc     h'0000FF00'
                        dc     h'00000000'

                        dc     h'000FF000'         ; 9
                        dc     h'0000FF00'
                        dc     h'00000FF0'
                        dc     h'00000FF0'
                        dc     h'00000FF0'
                        dc     h'0000FF00'
                        dc     h'000FF000'
                        dc     h'00000000'

                        dc     h'00000000'         ; 10
                        dc     h'00F000F0'
                        dc     h'000F0F00'
                        dc     h'0000F000'
                        dc     h'000F0F00'
                        dc     h'00F000F0'
                        dc     h'00000000'
                        dc     h'00000000'

                        dc     h'00000000'         ; 11
                        dc     h'0000F000'
                        dc     h'0000F000'
                        dc     h'00FFFFF0'
                        dc     h'0000F000'
                        dc     h'0000F000'
                        dc     h'00000000'
                        dc     h'00000000'

                        dc     h'00000000'         ; 12
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'000FF000'
                        dc     h'000FF000'
                        dc     h'00FF0000'
                        dc     h'00000000'

                        dc     h'00000000'         ; 13
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00FFFFF0'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'

                        dc     h'00000000'         ; 14
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'000FF000'
                        dc     h'000FF000'
                        dc     h'00000000'

                        dc     h'000000F0'         ; 15
                        dc     h'00000F00'
                        dc     h'0000F000'
                        dc     h'000F0000'
                        dc     h'00F00000'
                        dc     h'0F000000'
                        dc     h'F0000000'
                        dc     h'00000000'

                        dc     h'00FFF000'         ; 16
                        dc     h'0F00FF00'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'0FF00F00'
                        dc     h'00FFF000'
                        dc     h'00000000'

                        dc     h'000FF000'         ; 17
                        dc     h'00FFF000'
                        dc     h'000FF000'
                        dc     h'000FF000'
                        dc     h'000FF000'
                        dc     h'000FF000'
                        dc     h'0FFFFFF0'
                        dc     h'00000000'

                        dc     h'0FFFFF00'         ; 18
                        dc     h'FF000FF0'
                        dc     h'0000FFF0'
                        dc     h'00FFFF00'
                        dc     h'0FFFF000'
                        dc     h'FFF00000'
                        dc     h'FFFFFFF0'
                        dc     h'00000000'

                        dc     h'0FFFFFF0'         ; 19
                        dc     h'0000FF00'
                        dc     h'000FF000'
                        dc     h'00FFFF00'
                        dc     h'00000FF0'
                        dc     h'FF000FF0'
                        dc     h'0FFFFF00'
                        dc     h'00000000'

                        dc     h'000FFF00'         ; 20
                        dc     h'00FFFF00'
                        dc     h'0FF0FF00'
                        dc     h'FF00FF00'
                        dc     h'FFFFFFF0'
                        dc     h'0000FF00'
                        dc     h'0000FF00'
                        dc     h'00000000'

                        dc     h'FFFFFF00'         ; 21
                        dc     h'FF000000'
                        dc     h'FFFFFF00'
                        dc     h'00000FF0'
                        dc     h'00000FF0'
                        dc     h'FF000FF0'
                        dc     h'0FFFFF00'
                        dc     h'00000000'

                        dc     h'00FFFF00'         ; 22
                        dc     h'0FF00000'
                        dc     h'FF000000'
                        dc     h'FFFFFF00'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'0FFFFF00'
                        dc     h'00000000'

                        dc     h'FFFFFFF0'         ; 23
                        dc     h'FF000FF0'
                        dc     h'0000FF00'
                        dc     h'000FF000'
                        dc     h'00FF0000'
                        dc     h'00FF0000'
                        dc     h'00FF0000'
                        dc     h'00000000'

                        dc     h'0FFFF000'         ; 24
                        dc     h'FF000F00'
                        dc     h'FFF00F00'
                        dc     h'0FFFF000'
                        dc     h'F00FFFF0'
                        dc     h'F0000FF0'
                        dc     h'0FFFFF00'
                        dc     h'00000000'

                        dc     h'0FFFFF00'         ; 25
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'0FFFFFF0'
                        dc     h'00000FF0'
                        dc     h'0000FF00'
                        dc     h'0FFFF000'
                        dc     h'00000000'

                        dc     h'00000000'         ; 26
                        dc     h'00FF0000'
                        dc     h'00FF0000'
                        dc     h'00000000'
                        dc     h'00FF0000'
                        dc     h'00FF0000'
                        dc     h'00000000'
                        dc     h'00000000'

                        dc     h'00000000'         ; 27
                        dc     h'00FF0000'
                        dc     h'00FF0000'
                        dc     h'00000000'
                        dc     h'00FF0000'
                        dc     h'00FF0000'
                        dc     h'0FF00000'
                        dc     h'00000000'

                        dc     h'0000FF00'         ; 28
                        dc     h'000FF000'
                        dc     h'00FF0000'
                        dc     h'0FF00000'
                        dc     h'00FF0000'
                        dc     h'000FF000'
                        dc     h'0000FF00'
                        dc     h'00000000'

                        dc     h'00000000'         ; 29
                        dc     h'00000000'
                        dc     h'0FFFFF00'
                        dc     h'00000000'
                        dc     h'0FFFFF00'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'

                        dc     h'0FF00000'         ; 30
                        dc     h'00FF0000'
                        dc     h'000FF000'
                        dc     h'0000FF00'
                        dc     h'000FF000'
                        dc     h'00FF0000'
                        dc     h'0FF00000'
                        dc     h'00000000'

                        dc     h'0FFFFF00'         ; 31
                        dc     h'FFFFFFF0'
                        dc     h'FF000FF0'
                        dc     h'0000FF00'
                        dc     h'00FFF000'
                        dc     h'00000000'
                        dc     h'00FFF000'
                        dc     h'00000000'

                        dc     h'00FFFF00'         ; 32
                        dc     h'0FF00FF0'
                        dc     h'FF00FFF0'
                        dc     h'FF00FFF0'
                        dc     h'FF000000'
                        dc     h'0FF00FF0'
                        dc     h'00FFFF00'
                        dc     h'00000000'

                        dc     h'00FFF000'         ; 33
                        dc     h'0FF0FF00'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FFFFFFF0'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'00000000'

                        dc     h'FFFFFF00'         ; 34
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FFFFFF00'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FFFFFF00'
                        dc     h'00000000'

                        dc     h'00FFFF00'         ; 35
                        dc     h'0FF00FF0'
                        dc     h'FF000000'
                        dc     h'FF000000'
                        dc     h'FF000000'
                        dc     h'0FF00FF0'
                        dc     h'00FFFF00'
                        dc     h'00000000'

                        dc     h'FFFFF000'         ; 36
                        dc     h'FF00FF00'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FF00FF00'
                        dc     h'FFFFF000'
                        dc     h'00000000'

                        dc     h'FFFFFFF0'         ; 37
                        dc     h'FF000000'
                        dc     h'FF000000'
                        dc     h'FFFFFF00'
                        dc     h'FF000000'
                        dc     h'FF000000'
                        dc     h'FFFFFFF0'
                        dc     h'00000000'

                        dc     h'FFFFFFF0'         ; 38
                        dc     h'FF000000'
                        dc     h'FF000000'
                        dc     h'FFFFFF00'
                        dc     h'FF000000'
                        dc     h'FF000000'
                        dc     h'FF000000'
                        dc     h'00000000'

                        dc     h'00FFFFF0'         ; 39
                        dc     h'0FF00000'
                        dc     h'FF000000'
                        dc     h'FF00FFF0'
                        dc     h'FF000FF0'
                        dc     h'0FF00FF0'
                        dc     h'00FFFFF0'
                        dc     h'00000000'

                        dc     h'FF000FF0'         ; 40
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FFFFFFF0'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'00000000'

                        dc     h'0FFFFFF0'         ; 41
                        dc     h'000FF000'
                        dc     h'000FF000'
                        dc     h'000FF000'
                        dc     h'000FF000'
                        dc     h'000FF000'
                        dc     h'0FFFFFF0'
                        dc     h'00000000'

                        dc     h'00000FF0'         ; 42
                        dc     h'00000FF0'
                        dc     h'00000FF0'
                        dc     h'00000FF0'
                        dc     h'00000FF0'
                        dc     h'FF000FF0'
                        dc     h'0FFFFF00'
                        dc     h'00000000'

                        dc     h'FF000FF0'         ; 43
                        dc     h'FF00FF00'
                        dc     h'FF0FF000'
                        dc     h'FFFF0000'
                        dc     h'FFFFF000'
                        dc     h'FF0FFF00'
                        dc     h'FF00FFF0'
                        dc     h'00000000'

                        dc     h'FF000000'         ; 44
                        dc     h'FF000000'
                        dc     h'FF000000'
                        dc     h'FF000000'
                        dc     h'FF000000'
                        dc     h'FF000000'
                        dc     h'FFFFFFF0'
                        dc     h'00000000'

                        dc     h'FF000FF0'         ; 45
                        dc     h'FFF0FFF0'
                        dc     h'FFFFFFF0'
                        dc     h'FFFFFFF0'
                        dc     h'FF0F0FF0'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'00000000'

                        dc     h'FF000FF0'         ; 46
                        dc     h'FFF00FF0'
                        dc     h'FFFF0FF0'
                        dc     h'FFFFFFF0'
                        dc     h'FF0FFFF0'
                        dc     h'FF00FFF0'
                        dc     h'FF000FF0'
                        dc     h'00000000'

                        dc     h'0FFFFF00'         ; 47
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'0FFFFF00'
                        dc     h'00000000'

                        dc     h'FFFFFF00'         ; 48
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FFFFFF00'
                        dc     h'FF000000'
                        dc     h'FF000000'
                        dc     h'00000000'

                        dc     h'0FFFFF00'         ; 49
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FF0FFFF0'
                        dc     h'FF00FF00'
                        dc     h'0FFFF0F0'
                        dc     h'00000000'

                        dc     h'FFFFFF00'         ; 50
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FF00FFF0'
                        dc     h'FFFFF000'
                        dc     h'FF0FFF00'
                        dc     h'FF00FFF0'
                        dc     h'00000000'

                        dc     h'0FFFF000'         ; 51
                        dc     h'FF00FF00'
                        dc     h'FF000000'
                        dc     h'0FFFFF00'
                        dc     h'00000FF0'
                        dc     h'FF000FF0'
                        dc     h'0FFFFF00'
                        dc     h'00000000'

                        dc     h'FFFFFF00'         ; 52
                        dc     h'00FF0000'
                        dc     h'00FF0000'
                        dc     h'00FF0000'
                        dc     h'00FF0000'
                        dc     h'00FF0000'
                        dc     h'00FF0000'
                        dc     h'00000000'

                        dc     h'FF000FF0'         ; 53
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'0FFFFF00'
                        dc     h'00000000'

                        dc     h'FF000FF0'         ; 54
                        dc     h'FF000FF0'
                        dc     h'FF000FF0'
                        dc     h'FFF0FFF0'
                        dc     h'0FFFFF00'
                        dc     h'00FFF000'
                        dc     h'000F0000'
                        dc     h'00000000'

                        dc     h'FF000FF0'         ; 55
                        dc     h'FF000FF0'
                        dc     h'FF0F0FF0'
                        dc     h'FFFFFFF0'
                        dc     h'FFFFFFF0'
                        dc     h'FFF0FFF0'
                        dc     h'FF000FF0'
                        dc     h'00000000'

                        dc     h'FF000FF0'         ; 56
                        dc     h'FFF0FFF0'
                        dc     h'0FFFFF00'
                        dc     h'00FFF000'
                        dc     h'0FFFFF00'
                        dc     h'FFF0FFF0'
                        dc     h'FF000FF0'
                        dc     h'00000000'

                        dc     h'0FF00FF0'         ; 57
                        dc     h'0FF00FF0'
                        dc     h'0FF00FF0'
                        dc     h'00FFFF00'
                        dc     h'000FF000'
                        dc     h'000FF000'
                        dc     h'000FF000'
                        dc     h'00000000'

                        dc     h'FFFFFFF0'         ; 58
                        dc     h'0000FFF0'
                        dc     h'000FFF00'
                        dc     h'00FFF000'
                        dc     h'0FFF0000'
                        dc     h'FFF00000'
                        dc     h'FFFFFFF0'
                        dc     h'00000000'

                        dc     h'00FFFF00'         ; 59
                        dc     h'00FF0000'
                        dc     h'00FF0000'
                        dc     h'00FF0000'
                        dc     h'00FF0000'
                        dc     h'00FF0000'
                        dc     h'00FFFF00'
                        dc     h'00000000'

                        dc     h'F0000000'         ; 60
                        dc     h'0F000000'
                        dc     h'00F00000'
                        dc     h'000F0000'
                        dc     h'0000F000'
                        dc     h'00000F00'
                        dc     h'000000F0'
                        dc     h'00000000'

                        dc     h'0FFFF000'         ; 61
                        dc     h'000FF000'
                        dc     h'000FF000'
                        dc     h'000FF000'
                        dc     h'000FF000'
                        dc     h'000FF000'
                        dc     h'0FFFF000'
                        dc     h'00000000'

                        dc     h'00FFFF00'         ; 62
                        dc     h'0F0000F0'
                        dc     h'F00FF00F'
                        dc     h'F0F0000F'
                        dc     h'F0F0000F'
                        dc     h'F00FF00F'
                        dc     h'0F0000F0'
                        dc     h'00FFFF00'

                        dc     h'00000000'         ; 63
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'FFFFFFFF'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'

                        dc     h'FFFFFFFF'         ; 64
                        dc     h'FFFFFFFF'
                        dc     h'FFFFFFFF'
                        dc     h'FFFFFFFF'
                        dc     h'FFFFFFFF'
                        dc     h'FFFFFFFF'
                        dc     h'FFFFFFFF'
                        dc     h'FFFFFFFF'

;-----------------------------------------------------------------------------
; MARK: fontMask
fontMask                entry
                        dc     h'ffffffff'         ; 0
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'

                        dc     h'ff000fff'         ; 1
                        dc     h'ff000fff'
                        dc     h'ff000fff'
                        dc     h'ff00ffff'
                        dc     h'ff00ffff'
                        dc     h'ffffffff'
                        dc     h'ff00ffff'
                        dc     h'ffffffff'

                        dc     h'f00f00ff'         ; 2
                        dc     h'f00f00ff'
                        dc     h'f0ff0fff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'

                        dc     h'f00f00ff'         ; 3
                        dc     h'f00f00ff'
                        dc     h'0000000f'
                        dc     h'f00f00ff'
                        dc     h'0000000f'
                        dc     h'f00f00ff'
                        dc     h'f00f00ff'
                        dc     h'ffffffff'

                        dc     h'fff0ffff'         ; 4
                        dc     h'f00000ff'
                        dc     h'00f0ffff'
                        dc     h'f00000ff'
                        dc     h'fff0f00f'
                        dc     h'f00000ff'
                        dc     h'fff0ffff'
                        dc     h'ffffffff'

                        dc     h'f0ffff0f'         ; 5
                        dc     h'0f0ff0ff'
                        dc     h'f0ff0fff'
                        dc     h'fff0ffff'
                        dc     h'ff0ff0ff'
                        dc     h'f0ff0f0f'
                        dc     h'0ffff0ff'
                        dc     h'ffffffff'

                        dc     h'ff00ffff'         ; 6
                        dc     h'f0ff0fff'
                        dc     h'f00f0fff'
                        dc     h'f000ffff'
                        dc     h'0ff00f0f'
                        dc     h'0fff00ff'
                        dc     h'f0000f0f'
                        dc     h'ffffffff'

                        dc     h'ff00ffff'         ; 7
                        dc     h'ff00ffff'
                        dc     h'fff0ffff'
                        dc     h'ff0fffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'

                        dc     h'ffff00ff'         ; 8
                        dc     h'fff00fff'
                        dc     h'ff00ffff'
                        dc     h'ff00ffff'
                        dc     h'ff00ffff'
                        dc     h'fff00fff'
                        dc     h'ffff00ff'
                        dc     h'ffffffff'

                        dc     h'fff00fff'         ; 9
                        dc     h'ffff00ff'
                        dc     h'fffff00f'
                        dc     h'fffff00f'
                        dc     h'fffff00f'
                        dc     h'ffff00ff'
                        dc     h'fff00fff'
                        dc     h'ffffffff'

                        dc     h'ffffffff'         ; 10
                        dc     h'ff0fff0f'
                        dc     h'fff0f0ff'
                        dc     h'ffff0fff'
                        dc     h'fff0f0ff'
                        dc     h'ff0fff0f'
                        dc     h'ffffffff'
                        dc     h'ffffffff'

                        dc     h'ffffffff'         ; FF
                        dc     h'ffff0fff'
                        dc     h'ffff0fff'
                        dc     h'ff00000f'
                        dc     h'ffff0fff'
                        dc     h'ffff0fff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'

                        dc     h'ffffffff'         ; 12
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'fff00fff'
                        dc     h'fff00fff'
                        dc     h'ff00ffff'
                        dc     h'ffffffff'

                        dc     h'ffffffff'         ; 13
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ff00000f'
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'

                        dc     h'ffffffff'         ; 14
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'fff00fff'
                        dc     h'fff00fff'
                        dc     h'ffffffff'

                        dc     h'ffffff0f'         ; 15
                        dc     h'fffff0ff'
                        dc     h'ffff0fff'
                        dc     h'fff0ffff'
                        dc     h'ff0fffff'
                        dc     h'f0ffffff'
                        dc     h'0fffffff'
                        dc     h'ffffffff'

                        dc     h'ff000fff'         ; 16
                        dc     h'f0ff00ff'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'f00ff0ff'
                        dc     h'ff000fff'
                        dc     h'ffffffff'

                        dc     h'fff00fff'         ; 17
                        dc     h'ff000fff'
                        dc     h'fff00fff'
                        dc     h'fff00fff'
                        dc     h'fff00fff'
                        dc     h'fff00fff'
                        dc     h'f000000f'
                        dc     h'ffffffff'

                        dc     h'f00000ff'         ; 18
                        dc     h'00fff00f'
                        dc     h'ffff000f'
                        dc     h'ff0000ff'
                        dc     h'f0000fff'
                        dc     h'000fffff'
                        dc     h'0000000f'
                        dc     h'ffffffff'

                        dc     h'f000000f'         ; 19
                        dc     h'ffff00ff'
                        dc     h'fff00fff'
                        dc     h'ff0000ff'
                        dc     h'fffff00f'
                        dc     h'00fff00f'
                        dc     h'f00000ff'
                        dc     h'ffffffff'

                        dc     h'fff000ff'         ; 20
                        dc     h'ff0000ff'
                        dc     h'f00f00ff'
                        dc     h'00ff00ff'
                        dc     h'0000000f'
                        dc     h'ffff00ff'
                        dc     h'ffff00ff'
                        dc     h'ffffffff'

                        dc     h'000000ff'         ; 21
                        dc     h'00ffffff'
                        dc     h'000000ff'
                        dc     h'fffff00f'
                        dc     h'fffff00f'
                        dc     h'00fff00f'
                        dc     h'f00000ff'
                        dc     h'ffffffff'

                        dc     h'ff0000ff'         ; 22
                        dc     h'f00fffff'
                        dc     h'00ffffff'
                        dc     h'000000ff'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'f00000ff'
                        dc     h'ffffffff'

                        dc     h'0000000f'         ; 23
                        dc     h'00fff00f'
                        dc     h'ffff00ff'
                        dc     h'fff00fff'
                        dc     h'ff00ffff'
                        dc     h'ff00ffff'
                        dc     h'ff00ffff'
                        dc     h'ffffffff'

                        dc     h'f0000fff'         ; 24
                        dc     h'00fff0ff'
                        dc     h'000ff0ff'
                        dc     h'f0000fff'
                        dc     h'0ff0000f'
                        dc     h'0ffff00f'
                        dc     h'f00000ff'
                        dc     h'ffffffff'

                        dc     h'f00000ff'         ; 25
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'f000000f'
                        dc     h'fffff00f'
                        dc     h'ffff00ff'
                        dc     h'f0000fff'
                        dc     h'ffffffff'

                        dc     h'ffffffff'         ; 26
                        dc     h'ff00ffff'
                        dc     h'ff00ffff'
                        dc     h'ffffffff'
                        dc     h'ff00ffff'
                        dc     h'ff00ffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'

                        dc     h'ffffffff'         ; 27
                        dc     h'ff00ffff'
                        dc     h'ff00ffff'
                        dc     h'ffffffff'
                        dc     h'ff00ffff'
                        dc     h'ff00ffff'
                        dc     h'f00fffff'
                        dc     h'ffffffff'

                        dc     h'ffff00ff'         ; 28
                        dc     h'fff00fff'
                        dc     h'ff00ffff'
                        dc     h'f00fffff'
                        dc     h'ff00ffff'
                        dc     h'fff00fff'
                        dc     h'ffff00ff'
                        dc     h'ffffffff'

                        dc     h'ffffffff'         ; 29
                        dc     h'ffffffff'
                        dc     h'f00000ff'
                        dc     h'ffffffff'
                        dc     h'f00000ff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'

                        dc     h'f00fffff'         ; 30
                        dc     h'ff00ffff'
                        dc     h'fff00fff'
                        dc     h'ffff00ff'
                        dc     h'fff00fff'
                        dc     h'ff00ffff'
                        dc     h'f00fffff'
                        dc     h'ffffffff'

                        dc     h'f00000ff'         ; 31
                        dc     h'0000000f'
                        dc     h'00fff00f'
                        dc     h'ffff00ff'
                        dc     h'ff000fff'
                        dc     h'ffffffff'
                        dc     h'ff000fff'
                        dc     h'ffffffff'

                        dc     h'ff0000ff'         ; 32
                        dc     h'f00ff00f'
                        dc     h'00ff000f'
                        dc     h'00ff000f'
                        dc     h'00ffffff'
                        dc     h'f00ff00f'
                        dc     h'ff0000ff'
                        dc     h'ffffffff'

                        dc     h'ff000fff'         ; 33
                        dc     h'f00f00ff'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'0000000f'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'ffffffff'

                        dc     h'000000ff'         ; 34
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'000000ff'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'000000ff'
                        dc     h'ffffffff'

                        dc     h'ff0000ff'         ; 35
                        dc     h'f00ff00f'
                        dc     h'00ffffff'
                        dc     h'00ffffff'
                        dc     h'00ffffff'
                        dc     h'f00ff00f'
                        dc     h'ff0000ff'
                        dc     h'ffffffff'

                        dc     h'00000fff'         ; 36
                        dc     h'00ff00ff'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'00ff00ff'
                        dc     h'00000fff'
                        dc     h'ffffffff'

                        dc     h'0000000f'         ; 37
                        dc     h'00ffffff'
                        dc     h'00ffffff'
                        dc     h'000000ff'
                        dc     h'00ffffff'
                        dc     h'00ffffff'
                        dc     h'0000000f'
                        dc     h'ffffffff'

                        dc     h'0000000f'         ; 38
                        dc     h'00ffffff'
                        dc     h'00ffffff'
                        dc     h'000000ff'
                        dc     h'00ffffff'
                        dc     h'00ffffff'
                        dc     h'00ffffff'
                        dc     h'ffffffff'

                        dc     h'ff00000f'         ; 39
                        dc     h'f00fffff'
                        dc     h'00ffffff'
                        dc     h'00ff000f'
                        dc     h'00fff00f'
                        dc     h'f00ff00f'
                        dc     h'ff00000f'
                        dc     h'ffffffff'

                        dc     h'00fff00f'         ; 40
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'0000000f'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'ffffffff'

                        dc     h'f000000f'         ; 41
                        dc     h'fff00fff'
                        dc     h'fff00fff'
                        dc     h'fff00fff'
                        dc     h'fff00fff'
                        dc     h'fff00fff'
                        dc     h'f000000f'
                        dc     h'ffffffff'

                        dc     h'fffff00f'         ; 42
                        dc     h'fffff00f'
                        dc     h'fffff00f'
                        dc     h'fffff00f'
                        dc     h'fffff00f'
                        dc     h'00fff00f'
                        dc     h'f00000ff'
                        dc     h'ffffffff'

                        dc     h'00fff00f'         ; 43
                        dc     h'00ff00ff'
                        dc     h'00f00fff'
                        dc     h'0000ffff'
                        dc     h'00000fff'
                        dc     h'00f000ff'
                        dc     h'00ff000f'
                        dc     h'ffffffff'

                        dc     h'00ffffff'         ; 44
                        dc     h'00ffffff'
                        dc     h'00ffffff'
                        dc     h'00ffffff'
                        dc     h'00ffffff'
                        dc     h'00ffffff'
                        dc     h'0000000f'
                        dc     h'ffffffff'

                        dc     h'00fff00f'         ; 45
                        dc     h'000f000f'
                        dc     h'0000000f'
                        dc     h'0000000f'
                        dc     h'00f0f00f'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'ffffffff'

                        dc     h'00fff00f'         ; 46
                        dc     h'000ff00f'
                        dc     h'0000f00f'
                        dc     h'0000000f'
                        dc     h'00f0000f'
                        dc     h'00ff000f'
                        dc     h'00fff00f'
                        dc     h'ffffffff'

                        dc     h'f00000ff'         ; 47
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'f00000ff'
                        dc     h'ffffffff'

                        dc     h'000000ff'         ; 48
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'000000ff'
                        dc     h'00ffffff'
                        dc     h'00ffffff'
                        dc     h'ffffffff'

                        dc     h'f00000ff'         ; 49
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'00f0000f'
                        dc     h'00ff00ff'
                        dc     h'f0000f0f'
                        dc     h'ffffffff'

                        dc     h'000000ff'         ; 50
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'00ff000f'
                        dc     h'00000fff'
                        dc     h'00f000ff'
                        dc     h'00ff000f'
                        dc     h'ffffffff'

                        dc     h'f0000fff'         ; 51
                        dc     h'00ff00ff'
                        dc     h'00ffffff'
                        dc     h'f00000ff'
                        dc     h'fffff00f'
                        dc     h'00fff00f'
                        dc     h'f00000ff'
                        dc     h'ffffffff'

                        dc     h'000000ff'         ; 52
                        dc     h'ff00ffff'
                        dc     h'ff00ffff'
                        dc     h'ff00ffff'
                        dc     h'ff00ffff'
                        dc     h'ff00ffff'
                        dc     h'ff00ffff'
                        dc     h'ffffffff'

                        dc     h'00fff00f'         ; 53
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'f00000ff'
                        dc     h'ffffffff'

                        dc     h'00fff00f'         ; 54
                        dc     h'00fff00f'
                        dc     h'00fff00f'
                        dc     h'000f000f'
                        dc     h'f00000ff'
                        dc     h'ff000fff'
                        dc     h'fff0ffff'
                        dc     h'ffffffff'

                        dc     h'00fff00f'         ; 55
                        dc     h'00fff00f'
                        dc     h'00f0f00f'
                        dc     h'0000000f'
                        dc     h'0000000f'
                        dc     h'000f000f'
                        dc     h'00fff00f'
                        dc     h'ffffffff'

                        dc     h'00fff00f'         ; 56
                        dc     h'000f000f'
                        dc     h'f00000ff'
                        dc     h'ff000fff'
                        dc     h'f00000ff'
                        dc     h'000f000f'
                        dc     h'00fff00f'
                        dc     h'ffffffff'

                        dc     h'f00ff00f'         ; 57
                        dc     h'f00ff00f'
                        dc     h'f00ff00f'
                        dc     h'ff0000ff'
                        dc     h'fff00fff'
                        dc     h'fff00fff'
                        dc     h'fff00fff'
                        dc     h'ffffffff'

                        dc     h'0000000f'         ; 58
                        dc     h'ffff000f'
                        dc     h'fff000ff'
                        dc     h'ff000fff'
                        dc     h'f000ffff'
                        dc     h'000fffff'
                        dc     h'0000000f'
                        dc     h'ffffffff'

                        dc     h'ff0000ff'         ; 59
                        dc     h'ff00ffff'
                        dc     h'ff00ffff'
                        dc     h'ff00ffff'
                        dc     h'ff00ffff'
                        dc     h'ff00ffff'
                        dc     h'ff0000ff'
                        dc     h'ffffffff'

                        dc     h'0fffffff'         ; 60
                        dc     h'f0ffffff'
                        dc     h'ff0fffff'
                        dc     h'fff0ffff'
                        dc     h'ffff0fff'
                        dc     h'fffff0ff'
                        dc     h'ffffff0f'
                        dc     h'ffffffff'

                        dc     h'f0000fff'         ; 61
                        dc     h'fff00fff'
                        dc     h'fff00fff'
                        dc     h'fff00fff'
                        dc     h'fff00fff'
                        dc     h'fff00fff'
                        dc     h'f0000fff'
                        dc     h'ffffffff'

                        dc     h'ff0000ff'         ; 62
                        dc     h'f0ffff0f'
                        dc     h'0ff00ff0'
                        dc     h'0f0ffff0'
                        dc     h'0f0ffff0'
                        dc     h'0ff00ff0'
                        dc     h'f0ffff0f'
                        dc     h'ff0000ff'

                        dc     h'ffffffff'         ; 63
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'00000000'
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'
                        dc     h'ffffffff'

                        dc     h'00000000'         ; 64
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'
                        dc     h'00000000'

;-----------------------------------------------------------------------------
; These variables are here so they are in the same bank as the print code
printFontBytes          entry
                        dc     i2'0'

printFontColor          entry
                        dc     i2'0'

thisisformatfontdata__  anop
                        END
