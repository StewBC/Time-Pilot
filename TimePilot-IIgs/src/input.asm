;-----------------------------------------------------------------------------
; input.asm
; Part of Time Pilot, the 1982 arcade game remake for the Apple IIgs
;
; Stefan Wessels, 2024
; This is free and unencumbered software released into the public domain.
;-----------------------------------------------------------------------------

                        copy   src/globals.s
                        mcopy  src/input.mac

;-----------------------------------------------------------------------------
INPUT                   START

                        using  GAMEDATA
                        using  VARIABLES

;-----------------------------------------------------------------------------
; setting RECORD_REPLAY in globals.s will enable recording a replay
                        lcla   &R_RECORD
&R_RECORD               seta   RECORD_REPLAY

;-----------------------------------------------------------------------------
; MARK: inputCheckForJoy
inputCheckForJoy        entry
                        stz    zInputUsingJoystick
                        jsr    inputReadJoystick           ; returns $8000 if POTS timed out
                        bmi    icfjDone
                        inc    zInputUsingJoystick         ; Got a value, so turn JoyStick on
icfjDone                rts

;-----------------------------------------------------------------------------
; MARK: inputInGame
inputInGame             entry
                        dec    zReadFrameStall
                        beq    iigProcInputs
                        rts
iigProcInputs           lda    #KEY_READ_RATE
                        sta    zReadFrameStall
                        jsr    inputReadGameKeyboard       ; read the keyboard
                        ldx    zInputUsingJoystick         ; see if Joystick needs to be read
                        beq    iigPostRead
                        and    #$FFFF-INPUT_MASK_ROTATE    ; Clear rotation that
                        sta    zInputMask                  ; fire may have added in keyboard
                        jsr    inputReadJoystick
                        ora    zInputMask                  ; Blend joystick and keyboard
iigPostRead             sta    zInputMask
                        aif    &R_RECORD>0,.iigRecordDemo
                        ago    .iigSkipDemoRecord
.iigRecordDemo
                        ldx    demoRecordMode              ; is recording active?
                        beq    iigSkipDemoRecord
                        ldx    zDemoAttractLength          ; save lower 8 bits of mask
                        short  m
                        sta    dt_demo_buffer,x
                        long   m
                        inx
                        cpx    #DEMO_ATTRACT_LENGTH        ; buffer full?
                        bne    iigDemoBufOkay
                        lda    #INPUT_QUIT                 ; quit demo recording
                        sta    zInputMask
iigDemoBufOkay          stx    zDemoAttractLength          ; update recorded length
iigSkipDemoRecord       anop
.iigSkipDemoRecord
                        ldx    zDemoAttractMode            ; is demo playback active
                        beq    iigDebounce
                        lda    zInputMask                  ; see if user is aborting playback
                        bne    iigDemoBreak
                        inc    zDemoAttractIndex
                        ldx    zDemoAttractIndex           ; at end of playback
                        cpx    zDemoAttractLength
                        beq    iigDemoBreak
                        dex                                ; get the byte to "send"
                        lda    #0                          ; make a hi 0
                        short  m
                        lda    dt_demo_buffer,x            ; load a lo
                        long   m
                        sta    zInputMask                  ; set as the mask (lower 8 bits only matter here)
                        bra    iigDebounce
iigDemoBreak            lda    #INPUT_QUIT                 ; force a quit to end demo playback
                        sta    zInputMask
iigDebounce             eor    zInputMaskPrev              ; turn off something that was on already
                        and    zInputMask                  ; and don't set it again - but allow new ones through
                        sta    zInputMaskDebounced         ; this is now debounced
                        lda    zInputMask
                        sta    zInputMaskPrev              ; make prev mask the last read mask
                        bit    #INPUT_MASK_MOVEMENT        ; is user moving (U|D|L|R)
                        beq    iigNoMovement
iigMovement             and    #INPUT_MASK_MOVEMENT
                        asl    a                           ; * 2 for 16-bit lookup
                        tax
                        lda    dt_angles_joystick,x        ; Based on Joy angle, get a desired player angle
                        bpl    iigMove                     ; only positive numbers valid
                        cmp    zPlayerAngle                ; invalid direction -restore mask
                        beq    iigNoMovement
iigMove                 sec                                ; subtract angle from desired
                        sbc    zPlayerAngle
                        beq    iigChkQuit                  ; if already facing desired, no movement
                        and    #$20                        ; split into closest half
                        beq    iigSetRotRight
                        lda    #INPUT_ROTATE_LEFT          ; one half is closest to left
                        bra    iigSetRotInMask
iigSetRotRight          lda    #INPUT_ROTATE_RIGHT         ; other half closest to right
iigSetRotInMask         ora    zInputMask                  ; Add to the input mask
                        sta    zInputMask
iigNoMovement           bit    #INPUT_ROTATE_LEFT          ; See if rotating left
                        beq    iigChkRotRight
                        lda    zPlayerAngle                ; playerAngle = (playerAngle-1) & 31
                        dea
                        dea
                        and    #$3F                        ; for wrapping on underflow
                        sta    zPlayerAngle
                        bra    iigChkQuit
iigChkRotRight          bit    #INPUT_ROTATE_RIGHT         ; see if rotating right
                        beq    iigNotRotRight
                        lda    zPlayerAngle                ; playerAngle = (playerAngle+1) & 31
                        ina
                        ina
                        and    #$3f
                        sta    zPlayerAngle
iigChkQuit              lda    zInputMask                  ; restore mask in A
iigNotRotRight          bit    #INPUT_QUIT                 ; test for ESC
                        beq    iigNotQuit
                        lda    #EXIT_USER_QUIT             ; mark in exitGameMask
                        ora    zExitGameMask
                        sta    zExitGameMask
iigNotQuit              lda    zInputMaskDebounced         ; Fire/pause on debounced
                        bit    #INPUT_FIRE                 ; test for FIRE
                        beq    iigNotFire
                        ldx    zBulletTimer                ; if no bullet timer active
                        bne    iigNotFire
                        ldx    #PLAYER_BULLET_FIRE_TIMER   ; start a bullet timer
                        stx    zBulletTimer
iigNotFire              bit    #INPUT_PAUSE                ; check for pause
                        beq    iigDone
                        jmp    uiPause                     ; go paus through ui
iigDone                 rts

;-----------------------------------------------------------------------------
; MARK: inputInUI
inputInUI               entry
                        jsr    inputReadUIKeyboard         ; get the inputMask for keys
                        clc
                        ldx    zInputUsingJoystick         ; if using JoyStick, add that
                        beq    iiuProcess
                        sta    zInputMask
                        jsr    inputReadJoystick
                        ora    zInputMask
iiuProcess              sta    zInputMask
                        eor    zInputMaskPrev              ; turn off something that was on already
                        and    zInputMask                  ; and don't set it again - but allow new on through
                        sta    zInputMaskDebounced         ; this is now debounced
                        lda    zInputMask
                        beq    iiuSetDelay
                        lda    zInputRepeatRate
                        beq    iiuSetRepMask
                        stz    zInputMaskRepeat
                        dec    zInputRepeatRate
                        bra    iiuSetPrevMask
iiuSetDelay             sta    zInputRepeatRate
                        stz    zInputMaskRepeat
                        bra    iiuSetPrevMask
iiuSetRepMask           lda    zInputMask
                        sta    zInputMaskRepeat
                        lda    #INPUT_REPEAT_RATE
                        sta    zInputRepeatRate
iiuSetPrevMask          lda    zInputMask
                        sta    zInputMaskPrev
                        rts

;-----------------------------------------------------------------------------
; MARK: inputReadGameKeyboard
inputReadGameKeyboard   entry
                        ldx    #0                          ; inputMask is in X for ease
                        lda    KBD
                        bpl    irgkButtons                 ; no key - go check Apple KBD buttons that map to fire
                        sta    KBDSTRB
                        cmp    #($8D)|8+($8D)              ; scan code in lo/hi with hi bit set - space = fire
                        beq    irgkFire
                        cmp    #(' '+$80)|8+(' '+$80)      ; scan code in lo/hi with hi bit set - space = fire
                        bne    irgkChkQuit
irgkFire                ldx    #INPUT_FIRE
                        bra    irgkButtons
irgkChkQuit             cmp    #($1b+$80)|8+($1b+$80)      ; $1b = ESC = quit
                        bne    irgkChkPause
                        lda    #INPUT_QUIT
                        rts
irgkChkPause            and    #$5F                        ; remove case - all letters now uppercase
                        cmp    #'P'                        ; P = Pause
                        bne    irgkButtons
                        lda    #INPUT_PAUSE
                        rts
irgkButtons             lda    BUTN0                       ; read the "joystick" buttons (both)
                        bpl    irgkChkClock                ; If 16 bit positive then not pressed
                        pha
                        txa
                        ora    #INPUT_ROTATE_LEFT          ; pressed so rotate left
                        tax
                        pla
irgkChkClock            and    #$FF                        ; get 8-bit component
                        cmp    #$80                        ; if < 128 then not pressed
                        bcc    irgkDone
                        txa
                        ora    #INPUT_ROTATE_RIGHT         ; pressed so rotate right
                        rts
irgkDone                txa
                        rts                                ; inputMask returned in A

;-----------------------------------------------------------------------------
; MARK: inputReadJoystick
inputReadJoystick       entry
                        lda    #$0
                        tax                                ; start the x counter at 0
                        tay                                ; start the y counter at 0
                        lda    PTRIG                       ; trigger the fact that the joystick will be read
                        phb
                        phx
                        plb
                        plb
irjReadLoop             lda    |PADDL0
                        bit    #$80
                        beq    irjXDone
                        bmi    irjBoth
                        inx
                        bra    irjReadLoop
irjBoth                 inx
                        iny
                        cpy    #$180                       ; Is there a better way to know there's no joystick
                        bcc    irjReadLoop                 ; than timing out on the axis read?
                        plb
                        lda    #$8000                      ; No joystick attached - loop timed out
                        rts
irjXDone                bpl    irjScanDone
                        iny
                        bra    irjReadLoop
irjScanDone             lda    #0                          ; start the mask empty
                        cpx    #$10                        ; compare to the low end dead zone
                        bcs    irjChkR                     ; if greater than, then not left
                        ora    #INPUT_LEFT                 ; the joystick is left
                        bne    irjChkY                     ; branch always as acc is now non-zero
irjChkR                 cpx    #$FF                        ; check the upper bound of the dead-zone
                        bcc    irjChkY                     ; if less than, then not right
                        ora    #INPUT_RIGHT                ; gt high end of dead zone so joystick is right
irjChkY                 cpy    #$10                        ; do the same for the Y axis as for the X axis
                        bcs    irjChkDn
                        ora    #INPUT_UP
                        bra    irjButtons
irjChkDn                cpy    #$FF
                        bcc    irjButtons
                        ora    #INPUT_DOWN
irjButtons              short  i
                        ldx    |BUTN0                      ; read the button 0 state
                        bpl    irjChkBtn1
                        ora    #INPUT_FIRE                 ; mark the button as down
irjChkBtn1              ldx    |BUTN1                      ; do the same for button 1 as for button 0
                        bpl    joyDone
                        ora    #INPUT_PAUSE
joyDone                 long   i
                        plb
                        rts                                ; exit with inputMask also in A

;-----------------------------------------------------------------------------
; MARK: inputReadUIKeyboard
inputReadUIKeyboard     entry
                        ldx    #0
                        lda    KBD
                        bpl    irukButtons                 ; no key - check rotate buttons
                        sta    KBDSTRB
                        cmp    #('1'+$80)|8+('1'+$80)      ; 1 player on 1
                        beq    irukOne
                        cmp    #(' '+$80)|8+(' '+$80)      ; also 1 player on fire (SPACE)
                        beq    irukOne
                        cmp    #('2'+$80)|8+('2'+$80)      ; 2 player on 2
                        beq    irukTwo
                        cmp    #($1b+$80)|8+($1b+$80)      ; Quit on ESC
                        beq    irukQuit
                        and    #$5F
                        cmp    #'P'
                        beq    irukPause
                        cmp    #'J'
                        beq    irukScan
                        cmp    #'K'
                        beq    irukKeys
irukButtons             lda    BUTN0                       ; read the rotate buttons
                        bpl    irukChkClock                ; If 16 bit positive then not pressed
                        lda    #INPUT_LEFT                 ; pressed so rotate left
                        rts
irukChkClock            and    #$FF                        ; get 8-bit component
                        cmp    #$80
                        bcc    irukDone
                        lda    #INPUT_RIGHT                ; pressed so rotate RIGHT
                        rts
irukDone                lda    #0
                        rts
irukQuit                lda    #INPUT_QUIT
                        rts
irukOne                 lda    #INPUT_FIRE
                        rts
irukTwo                 lda    #INPUT_2P
                        rts
irukPause               lda    #INPUT_PAUSE
                        rts
irukScan                lda    #INPUT_SCAN
                        rts
irukKeys                lda    #INPUT_KEYBOARD
                        rts

thisisaformattinglabel  anop
                        END
