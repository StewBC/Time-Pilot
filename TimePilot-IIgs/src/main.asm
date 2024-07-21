;-----------------------------------------------------------------------------
; main.asm
; Part of Time Pilot, the 1982 arcade game remake for the Apple IIgs
;
; Stefan Wessels, 2024
; This is free and unencumbered software released into the public domain.
;-----------------------------------------------------------------------------

                        copy          src/globals.s
                        mcopy         src/main.mac

;-----------------------------------------------------------------------------
MAIN                    START

                        using         VARIABLES

;-----------------------------------------------------------------------------
main                    phb

                        lda           #$E1
                        sta           SHR                            ; graphics ON
                        jsr           mainInit
                        bcs           mfail
                        jsr           audioInit
                        jsr           screenInit
                        jsr           uiInit

mLoop                   anop
                        jsr           uiMain
                        bcs           mShutdown
                        jsr           gameStart
                        jmp           mLoop

mShutdown               short         m                              ; shut Down
                        lda           #$41
                        sta           SHR                            ; graphics OFF
                        lda           originalBorder
                        sta           BORDER
                        long          m

mfail                   lda           originalKeyRepRate             ; reset key Repeat rate
                        pha
                        ph2           #44
                        ldx           #$0B03
                        jsl           TOOLBOXROM
                        lda           originalKeyDelayRate           ; reset key Repeat delay rate
                        pha
                        ph2           #45
                        ldx           #$0B03
                        jsl           TOOLBOXROM

                        ~MMShutDown   zMemID
                        ~TLShutDown
                        jsr           audioShutdown
                        plb
                        _QuitGS       mQuitParameters

mQuitParameters         dc            h'00000000'

;-----------------------------------------------------------------------------
; MARK: mainInit
mainInit                entry

tiHandleL               equ           zTemp00
tiHandleH               equ           zTemp01
tiUserID                equ           zTemp02

                        ldx           #$FE                           ; clear all of dp
miClearZPVars           stz           $00,x
                        dex
                        dex
                        bne           miClearZPVars

                        phk
                        plb

                        ~TLStartUp
                        ph2           #0                             ; read key Repeat rate
                        ~ReadBParam   #44
                        pla
                        sta           originalKeyRepRate
                        ph2           #0                             ; read key Repeat delay rate
                        ~ReadBParam   #45
                        pla
                        sta           originalKeyDelayRate

                        ~WriteBParam  #5,#44                         ; set key rate to 5
                        ~WriteBParam  #0,#45                         ; set delay rate to 0

                        pha
                        ~MMStartUp
                        pla
                        sta           zMemID
                        ora           #$0100
                        sta           tiUserID                       ; userID

                        pha
                        pha
                        ~NewHandle    #$12,tiUserID,#$8001,#$010000  ; get 18 bytes of memory as direct page work space
                        pla
                        sta           tiHandleL                      ; handle Lo
                        pla
                        sta           tiHandleH                      ; handle Hi
                        bcc           miGotMem
                        rts

miGotMem                lda           [tiHandleL]                    ; get address of memory allocated
                        sta           zImageAddressPdpB1
                        adc           #2
                        sta           zImageDataWidthPdpB1
                        adc           #2
                        sta           zImageVisHeightPdpB1
                        adc           #2
                        sta           zImageVisWidthPdpB1
                        adc           #2
                        sta           zMaskAddressPdpB1
                        adc           #2
                        sta           zScreenAddressPdpB1
                        adc           #2
                        ldy           #2
                        lda           [tiHandleL],y                  ; get the bank part (has to be 01)
                        cmp           #1
                        beq           miGotbank1                     ; something went wrong, not a bank 1 address
                        sec
                        rts

miGotbank1              short         m
                        sta           zImageAddressPdpB1+2
                        sta           zImageDataWidthPdpB1+2
                        sta           zImageVisHeightPdpB1+2
                        sta           zImageVisWidthPdpB1+2
                        sta           zMaskAddressPdpB1+2
                        sta           zScreenAddressPdpB1+2
                        sta           [zScreenAddressPdpB1],y
                        long          m

                        stz           zInputUsingJoystick            ; one-time global zVars init
                        stz           zCheatActive
                        lda           #DEMO_ATTRACT_LENGTH
                        sta           zDemoAttractLength
                        lda           #-1
                        sta           zRandomSeed
                        clc
                        rts

thisisaformattinglabel  anop
                        END
