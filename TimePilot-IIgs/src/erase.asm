;-----------------------------------------------------------------------------
; erase.asm
; Part of Time Pilot, the 1982 arcade game remake for the Apple IIgs
;
; Stefan Wessels, 2024
; This is free and unencumbered software released into the public domain.
;-----------------------------------------------------------------------------

                        copy   src/globals.s
                        mcopy  src/erase.mac

ERASE                   START

                        using  GAMEDATA
                        using  VARIABLES

;-----------------------------------------------------------------------------
; MARK: eraseText
eraseText               entry
                        ldx    zEraseIndex
                        lda    eraseThingIDs,x
                        tax
                        lda    #AF_REMOVE
                        ora    activeFlags,x
                        sta    activeFlags,x
                        ldy    activeScreenAddress,x
                        jmp    blank48x8
; MARK: eraseRts
eraseRts                entry
                        rts

;-----------------------------------------------------------------------------
; MARK: eraseThing
eraseThing              entry
tScreenClips            equ    zTemp00
tImageVisibleWidth      equ    zTemp01
tScreenStartX           equ    zTemp02
tScreenStartY           equ    zTemp03

                        lda    activeFlags,x
                        bit    #AF_CLIPMASK            ; clipped at all?
                        bne    etPartial
etFull                  lda    activeScreenAddress,x   ; screen address is cached
                        tay
                        lda    activeHeight,x          ; height of object to erase
                        asl    a                       ; 2 bytes per address
                        sta    zRowsToErase            ; save for later jump-to in erase functions
                        lda    activeLayer,x           ; what to erase
                        tax
                        jmp    (at_handler_erase,x)    ; erase with an appropriate erase function
etPartial               lda    activeScreenAddress,x
                        sta    [zScreenAddressPdpB1]
                        lda    activeVisibleHeight,x
                        sta    [zImageVisHeightPdpB1]
                        lda    activeVisibleWidth,x
                        bit    #3                      ; Does the width fit 2 bytes
                        beq    noRemainder
                        and    #$FFFC                  ; get the portion that fits 2 bytes
                        lsr    a
                        sta    [zImageVisWidthPdpB1]   ; and set the width to erase in bank 1 DP alloc'd area
                        tay
                        lda    at_col_jump_erase,y     ; see erase - this is an address to jump to for columns
                        sta    ieremainderexit+1
                        lda    #ieremainder            ; this is an address
                        sta    iereturnAddress+1       ; if there is a remainder, jump to the erase section that handles the remainder
                        jmp    screenErasePartial
noRemainder             and    #$FFFC                  ; exactly as above, minus remainder handling
                        lsr    a
                        sta    [zImageVisWidthPdpB1]
                        tay
                        lda    at_col_jump_erase,y
                        sta    iereturnAddress+1
                        jmp    screenErasePartial

thisisaformattinglabel  anop
                        END
