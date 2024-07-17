;-----------------------------------------------------------------------------
; main.asm
; Part of Time Pilot, the 1982 arcade game remake for the Apple IIgs
;
; Stefan Wessels, 2024
; This is free and unencumbered software released into the public domain.
;-----------------------------------------------------------------------------

                        copy         src/globals.s
                        mcopy        src/main.mac

;-----------------------------------------------------------------------------
MAIN                    START

                        using        VARIABLES

;-----------------------------------------------------------------------------
main                    phb
                        lda          #$E1
                        sta          SHR                            ; Graphics ON
                        jsr          mainInit
                        bcs          mfail
                        jsr          audioInit
                        jsr          screenInit
                        jsr          uiInit

mLoop                   anop
                        jsr          uiMain
                        bcs          mShutdown
                        jsr          gameStart
                        jmp          mLoop

mShutdown               short        m                              ; Shut Down
                        lda          #$41
                        sta          SHR                            ; Graphics OFF
                        lda          originalBorder
                        sta          BORDER
                        long         m

mfail                   ~MMShutDown  zMemID
                        ~TLShutDown
                        jsr          audioShutdown
                        plb
                        _QuitGS      mQuitParameters

mQuitParameters         dc           h'00000000'

;-----------------------------------------------------------------------------
; MARK: mainInit
mainInit                entry

tiHandleL               equ          zTemp00
tiHandleH               equ          zTemp01
tiUserID                equ          zTemp02

                        ldx          #$FE                           ; Clear all of dp
miClearZPVars           stz          $00,x
                        dex
                        dex
                        bne          miClearZPVars

                        phk
                        plb

                        ~TLStartUp
                        pha
                        ~MMStartUp
                        pla
                        sta          zMemID
                        ora          #$0100
                        sta          tiUserID                       ; userID

                        pha
                        pha
                        ~NewHandle   #$12,tiUserID,#$8001,#$010000  ; get 18 bytes of memory as direct page work space
                        pla
                        sta          tiHandleL                      ; Handle Lo
                        pla
                        sta          tiHandleH                      ; Handle Hi
                        bcc          miGotMem
                        rts

miGotMem                lda          [tiHandleL]                    ; Get address of memory allocated
                        sta          zImageAddressPdpB1
                        adc          #2
                        sta          zImageDataWidthPdpB1
                        adc          #2
                        sta          zImageVisHeightPdpB1
                        adc          #2
                        sta          zImageVisWidthPdpB1
                        adc          #2
                        sta          zMaskAddressPdpB1
                        adc          #2
                        sta          zScreenAddressPdpB1
                        adc          #2
                        ldy          #2
                        lda          [tiHandleL],y                  ; get the bank part (has to be 01)
                        cmp          #1
                        beq          miGotbank1                     ; something went wrong, not a bank 1 address
                        sec
                        rts

miGotbank1              short        m
                        sta          zImageAddressPdpB1+2
                        sta          zImageDataWidthPdpB1+2
                        sta          zImageVisHeightPdpB1+2
                        sta          zImageVisWidthPdpB1+2
                        sta          zMaskAddressPdpB1+2
                        sta          zScreenAddressPdpB1+2
                        sta          [zScreenAddressPdpB1],y
                        long         m

                        stz          zInputUsingJoystick            ; One-time global zVars init
                        stz          cheatModeActive
                        lda          #DEMO_ATTRACT_LENGTH
                        sta          zDemoAttractLength
                        lda          #-1
                        sta          zRandomSeed
                        clc
                        rts

thisisaformattinglabel  anop
                        END
