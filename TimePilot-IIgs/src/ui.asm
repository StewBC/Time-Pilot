;-----------------------------------------------------------------------------
; ui.asm
; Part of Time Pilot, the 1982 arcade game remake for the Apple IIgs
;
; Stefan Wessels, 2024
; This is free and unencumbered software released into the public domain.
;-----------------------------------------------------------------------------

                        copy      src/globals.s
                        mcopy     src/ui.mac

UI                      START
                        using     GAMEDATA
                        using     SOUNDDATAAREA
                        using     TEXT
                        using     VARIABLES

ptTimer                 equ       zTemp00
ptState                 equ       zTemp01
ptBCDIndex              equ       zTemp02

;-----------------------------------------------------------------------------
; A the 2 bytes to convert. X, the address of the destination memory
; Works like a typical hex print
; MARK: uiBCD2String
uiBCD2String            entry
                        stx       ptBCDIndex
                        clc
                        ldy       #0
                        short     m
                        jsr       ub2sCvt
                        ldy       #0
ub2sRemLead             lda       (ptBCDIndex),y
                        cmp       #$30
                        bne       ub2sDone
                        lda       #$20
                        sta       (ptBCDIndex),y
                        iny
                        cpy       #4
                        bne       ub2sRemLead
ub2sDone                long      m
                        rts
                        longa     off
ub2sCvt                 xba
                        jsr       ub2sByte
                        xba
ub2sByte                pha
                        lsr       a
                        lsr       a
                        lsr       a
                        lsr       a
                        jsr       ub2sWrite
                        pla
                        and       #$0f
ub2sWrite               clc
                        adc       #'0'
                        sta       (ptBCDIndex),y
                        iny
                        rts
                        longa     on

;-----------------------------------------------------------------------------
; MARK: uiGameOver
uiGameOver              entry
tInitialsColor          equ       zTemp03
tInsertRow              equ       zTemp04
tJoyStatus              equ       zTemp05
tLetter                 equ       zTemp06
tLetterIndex            equ       zTemp07
tRepeatRate             equ       zTemp08
tRowsToMove             equ       zTemp09

                        LDSCRNXY  10,10
                        jsl       TXTPLAYER_000A
                        ldx       zActivePlayer
                        lda       st_text,x
                        sta       ugoShowNum+1
                        LDSCRNXY  17,10
ugoShowNum              jsl       TXT1_000A
                        LDSCRNXY  10,13
                        jsl       TXTGAMEOVER_000A
                        lda       #UI_GAME_OVER_TIMER
                        sta       ptTimer
                        sta       KBDSTRB                      ; clear key strobe
ugoKeyLoop              jsr       screenDelay
                        dec       ptTimer
                        beq       ugoHaveKey                   ; time out when counter runs out
                        cmp       #UI_GAME_OVER_TIMER-60       ; hold for at least one second
                        bcs       ugoKeyLoop
                        lda       KBD                          ; check for key
                        bmi       ugoHaveKey                   ; handle if key pressed
                        lda       zInputUsingJoystick
                        beq       ugoKeyLoop
                        jsr       inputReadJoystick
                        bit       #INPUT_FIRE
                        beq       ugoKeyLoop
ugoHaveKey              entry
                        sta       KBDSTRB                      ; clear key
                        lda       zPlayerScore                 ; get the users' score
                        ldx       #8                           ; compare it to the scores in the high-score table
ugoChkLoop              cmp       highScore1,x
                        bcc       ugolower                     ; exit if lower
                        beq       ugolower                     ; exit if equal (eqal means lower here)
                        dex
                        dex
                        bpl       ugoChkLoop                   ; check against all lower scores
ugolower                cpx       #8                           ; is the user in the table
                        bne       ugoUserInTable
                        rts

; The user made it into the table, make room
ugoUserInTable          inx                                    ; step to the position where the score goes
                        inx
                        stx       tInsertRow                   ; save that
                        phx                                    ; also save it to be used after screenWipe
                        lda       #8
                        sec
                        sbc       tInsertRow                   ; see how many scores "move down"
                        beq       ugoSetScore
                        sta       tRowsToMove                  ; save the move down number

; move "row" in table down
                        asl       a                            ; move the text scores down
                        tax
                        ldy       #4*8-2
ugoCpyTxtScores         lda       TEXT_HIGHSCORES1,y
                        sta       TEXT_HIGHSCORES2,y
                        dey
                        dey
                        dex
                        bne       ugoCpyTxtScores

                        ldx       tRowsToMove                  ; move the initials down
                        ldy       #4*4-2
ugoCpyInitials          lda       TEXT_INITIALS1,y
                        sta       TEXT_INITIALS2,y
                        dey
                        dey
                        dex
                        bne       ugoCpyInitials

                        lda       tRowsToMove                  ; move the BCD scores down
                        lsr       a
                        tax
                        ldy       #4*2-2
ugoCpyScores            lda       highScore1,y
                        sta       highScore2,y
                        dey
                        dey
                        dex
                        bne       ugoCpyScores

; Add the player score to the numeric score table
ugoSetScore             ldx       tInsertRow                   ; get the position the user score slots in (counted in 2's)
                        lda       zPlayerScore
                        sta       highScore1,x

; print the score into the row string for scores
                        lda       tInsertRow                   ; get the position the user score slots in (counted in 2's)
                        asl       a
                        asl       a                            ; now *8 since each score is 8 bytes wide
                        adc       #TEXT_HIGHSCORES1
                        tax
                        lda       zPlayerScore
                        jsr       uiBCD2String                 ; put the score into the string
                        ldy       #4
                        lda       #'00'                        ; overwrite the initial scores' last 2 digits
                        sta       (ptBCDIndex),y

; Show the table
                        lda       tInsertRow                   ; save this index into initials variable
                        asl       a                            ; *2 (so 4) for initials width
                        tay
                        lda       #$2041                       ; A and space
                        sta       TEXT_INITIALS1,y             ; replace initials
                        lda       #$0020                       ; and space \00
                        sta       TEXT_INITIALS1+2,y
                        lda       #AUDIO_HIGHSCORE             ; start high-score audio
                        jsr       audioPlaySource
                        LDAPAL    COLOR_BLACK                  ; wipe game to UI screen
                        sta       zSkyColor
                        jsr       screenWipe
                        jsr       uiShowCommonLabels           ; show the table
                        jsr       uiShowHighScoreTable
                        PRINTSZ   TEXT_ENTER_INITIALS,5,0

; prepare to ask for initials
                        pla                                    ; get the uiInsetPos back
                        sta       tInsertRow
                        stz       tLetterIndex                 ; editing 1st initial
                        stz       ptTimer                      ; init color animation timer
                        stz       tJoyStatus                   ; direction Joystick is in
                        lda       #$41
                        sta       tLetter                      ; the letter currently selected
                        lda       #$7777
                        sta       tInitialsColor               ; the color cycle color index
                        lda       KBDSTRB

; Loop till 3 initials entered
ugoInitialsLoop         ldy       #26                          ; snd2OSC[AUDIO_HIGHSCORE]
                        lda       oscPAGE,y
                        bne       ugoAudioFine                 ; non-zero means stll playing
                        lda       #AUDIO_HIGHSCORE             ; restart the looping highscore audio
                        jsr       audioPlaySource
ugoAudioFine            dec       ptTimer
                        bpl       ugoPastAnim
                        lda       #UI_COLORCYCLE_TIMER         ; animation timer fires
                        sta       ptTimer                      ; reset the timer
                        lda       #$7777                       ; switch between red and white
                        eor       tInitialsColor
                        ora       #$1111
                        sta       tInitialsColor
                        sta       >printFontColor              ; set the font color
                        jsr       ugoShowInitials              ; and show the initials in the animated color

; deal with input and timing
ugoPastAnim             jsr       screenDelay                  ; wait for a vblank
                        lda       KBD                          ; check for a key since we need alpha + '.'
                        bmi       ugoHasKey
                        jsr       inputInUI                    ; check the joystick (mainly)
                        lda       zInputMaskRepeat
                        bit       #INPUT_FIRE                  ; fire advances to next initial
                        beq       ugoCheckStick
; accept the current letter
ugoConfirm              inc       tLetterIndex
                        lda       tLetterIndex
                        cmp       #3                           ; after 3 initials all done
                        bcs       ugoDone
                        lda       #$41                         ; not done, start at A again
                        jsr       ugoSetInitial
                        bra       ugoInitialsLoop
ugoDone                 lda       #AUDIO_HIGHSCORE
                        jmp       audioStopSource

; Check left/right for letter changes
ugoCheckStick           bit       #INPUT_RIGHT                 ; if right, advance the character digit
                        beq       ugoChkLeft
                        lda       tLetter
                        ina
                        cmp       #65                          ; < A (65) set to A - coming from '.'
                        bcs       ugoAOk
                        lda       #65
ugoAOk                  cmp       #91                          ; > Z (90) set to '.' (46)
                        bcc       ugoCharOk
                        lda       #46
                        bra       ugoCharOk
ugoChkLeft              bit       #INPUT_LEFT                  ; if left, back up the character digit
                        beq       ugoInitialsLoop
                        lda       tLetter
                        dea
                        cmp       #46                          ; < then '.' (46) set to Z (90)
                        bcs       ugoPerOk
                        lda       #90
                        bra       ugoCharOk
ugoPerOk                cmp       #65                          ; < A (65) ugo to '.' (46)
                        bcs       ugoCharOk
                        lda       #46
ugoCharOk               jsr       ugoSetInitial                ; chance to this character in acc
                        jmp       ugoInitialsLoop

; Check if the user pressed . or A-Z and accept that as input. SPACE = accept (Fire)
ugoHasKey               sta       KBDSTRB                      ; clear the key
                        and       #$7F                         ; take hi bit off
                        cmp       #$0D                         ; is it ENTER (fire alternative)
                        beq       ugoConfirm
                        cmp       #$20                         ; is it space (fire)
                        beq       ugoConfirm
                        cmp       #$2e                         ; is it a period '.'
                        beq       ugoSetInitialKbd             ; yes, accept
                        and       #$5F                         ; make uppercase
                        cmp       #'A'                         ; A-Z is accepted
                        bcc       ugoNotValid
                        cmp       #'Z'+1
                        bcs       ugoNotValid                  ; not A-Z or . is invalid
ugoSetInitialKbd        jsr       ugoSetInitial                ; make character in acc the initial
                        jmp       ugoConfirm                   ; and advance to the next initial

ugoNotValid             jmp       ugoInitialsLoop

; Puts char in acc into initials at current pos, and shows the character on the screen
ugoSetInitial           sta       tLetter                      ; save the letter
                        lda       tInsertRow                   ; get the row
                        asl       a                            ; * 4 now so index into initials table
                        adc       tLetterIndex                 ; add the index of the letter being edited
                        tay
                        lda       tLetter                      ; get the letter
                        short     m
                        sta       TEXT_INITIALS1,y             ; put it in the initials string
                        long      m
ugoShowInitials         ldx       tInsertRow                   ; based on insert row
                        lda       dt_ui_initials_y,x           ; get the position where the initials are displayed
                        tax                                    ; into X
                        lda       tInsertRow                   ; add the offset to the initials
                        asl       a
                        adc       #|TEXT_INITIALS1             ; to the start if the initials table
                        tay                                    ; into Y
                        lda       #^TEXT_INITIALS1             ; and the bank in A
                        jsl       printZString                 ; and print the initials in alternating red/white
                        lda       zCheatActive                 ; don't save scores if cheat active
                        beq       sf_save
                        rts
sf_save                 jsl       GSOS                         ; Save the high-scores
                        dc        i2'$2002'
                        dc        a4'proDESTROYHS'
                        jsl       GSOS
                        dc        i2'$2001'
                        dc        a4'proCREATEHS'
                        bcs       sf_err
                        jsl       GSOS
                        dc        i2'$2010'
                        dc        a4'proOPENHS'
                        bcs       sf_err
                        lda       proOPENHS+2
                        sta       proREADHS1+2
                        sta       proREADHS2+2
                        sta       proCLOSEHS+2
                        jsl       GSOS
                        dc        i2'$2013'
                        dc        a4'proREADHS1'
                        jsl       GSOS
                        dc        i2'$2013'
                        dc        a4'proREADHS2'
sf_err                  jsl       GSOS
                        dc        i2'$2014'
                        dc        a4'proCLOSEHS'
                        rts

;-----------------------------------------------------------------------------
; MARK: uiInit
uiInit                  entry
                        jsl       GSOS                         ; Load high-scores
                        dc        i2'$2010'
                        dc        a4'proOPENHS'
                        bcs       uiErr
                        lda       proOPENHS+2                  ; get file ID
                        sta       proREADHS1+2
                        sta       proREADHS2+2
                        sta       proCLOSEHS+2
                        jsl       GSOS
                        dc        i2'$2012'
                        dc        a4'proREADHS1'
                        jsl       GSOS
                        dc        i2'$2012'
                        dc        a4'proREADHS2'
uiErr                   jsl       GSOS
                        dc        i2'$2014'
                        dc        a4'proCLOSEHS'
                        lda       #0
                        jsr       screenClear                  ; set entire screen area to 0 (overwrites palettes)
                        LDAPAL    COLOR_RED
                        sta       >printFontColor
                        PRINTSZ   TEXT_HIGH,29,3               ; show the always on-screen labels
                        PRINTSZ   TEXT_1UP,35,6
                        LDAPAL    COLOR_WHITE                  ; and show the last 0 on the score
                        sta       >printFontColor              ; stored scores are 10x smaller than "appears"
                        PRINTSZ   TEXT_HIGHSCORES1,33,4
                        PRINTSZ   TEXT_SCORE00,37,7            ; P1 00
                        jmp       uiShowP2Playing

;-----------------------------------------------------------------------------
; MARK: uiMain
uiMain                  entry
tIterations             equ       zTemp03
                        lda       #6
                        sta       tIterations                  ; iterations till demo mode
                        stz       ptState                      ; high scores table or text
                        lda       zDemoAttractMode             ; coming back from demo?
                        beq       umSkipDemoReset
                        lda       zDemoAttractScore            ; set P1 score to saved score
                        sta       zPlayerScore
                        beq       umSkipShow                   ; if not 0 - show score
                        jsr       uiShowP1Score
umSkipShow              stz       zSkyColor                    ; ui on black background
                        LDBOX     PLAYFIELDW,7,9,1             ; clear P1 score bits (post demo)
                        jsr       screenClearSection
                        stz       zDemoAttractMode             ; Reset demo mode
umSkipDemoReset         jsr       uiShowCommonLabels           ; Konami, me etc
                        sta       KBDSTRB                      ; clear KBD
                        stz       zInputMask
umSwitchStateLoop       lda       #UI_STATE_TIMER
                        sta       ptTimer
                        lda       ptState
                        beq       umTitle
                        jsr       uiShowHighScoreTable
                        bra       umHoldStateLoop
umTitle                 jsr       uiShowTitle
umHoldStateLoop         dec       ptTimer                      ; hold this state till timer < 0
                        bpl       umTimeOkay
                        dec       tIterations                  ; after 6 iterations
                        bne       umSkipAttract
                        lda       zPlayerScore                 ; save the last player 1 score
                        sta       zDemoAttractScore
                        lda       #1
                        sta       zDemoAttractMode             ; demo mode on
                        lda       #0                           ; single player
                        jmp       umSetupPlay                  ; start the demo
umSkipAttract           LDBOX     5,6,20,11                    ; Clear scores table/text section
                        jsr       screenClearSection
                        lda       #1
                        eor       ptState                      ; Switch state (scores/text)
                        sta       ptState
                        bra       umSwitchStateLoop            ; Redraw UI scores / text
umTimeOkay              jsr       inputInUI                    ; Read user input
                        bit       #INPUT_QUIT
                        beq       umChk1P
                        sec                                    ; carry set on return quits
                        rts
umChk1P                 bit       #INPUT_FIRE
                        beq       umChk2P
                        lda       #0                           ; 1 player game
                        bra       umSetupPlay
umChk2P                 bit       #INPUT_2P+INPUT_PAUSE
                        beq       umChkCheat
                        lda       #1                           ; 2 player game
umSetupPlay             sta       zNumberOfPlayers             ; init for a game to start
                        sta       zNumberOfPlayersAlive
                        rts
umChkCheat              bit       #INPUT_CHEAT
                        beq       umChkScan
                        lda       #AUDIO_COINDROP
                        jsr       audioPlaySource
                        lda       zCheatActive
                        eor       #1
                        sta       zCheatActive
                        bne       umkShowCheat
                        LDBOX     36,21,4,1                    ; remove the word CHEAT
                        jsr       screenClearSection
                        bra       umMkTitle
umkShowCheat            LDSCRNXY  36,21
                        jsl       TXTCHEAT_000A                ; show the word CHEAT
                        bra       umMkTitle
umChkScan               bit       #INPUT_SCAN
                        beq       umChkKbd
                        lda       #AUDIO_COINDROP
                        jsr       audioPlaySource
                        jsr       inputCheckForJoy             ; check if there's a joystick
                        bra       umMkTitle                    ; force title screen on
umChkKbd                bit       #INPUT_KEYBOARD
                        beq       umWaitFrame
                        lda       #AUDIO_COINDROP
                        jsr       audioPlaySource
                        stz       zInputUsingJoystick          ; turn off using joystick
umMkTitle               lda       #6                           ; reset time to demo mode
                        sta       tIterations
                        lda       ptState                      ; which screen is in front
                        bne       umBranchFar
                        jmp       umSwitchStateLoop            ; title - so just redraw
umBranchFar             jmp       umSkipAttract                ; if scores, clear and flip
umWaitFrame             jsr       screenDelay
                        brl       umHoldStateLoop

;-----------------------------------------------------------------------------
; MARK: uiPause
uiPause                 entry
                        LDSCRNXY  11,8
                        jsl       TXTPAUSE_000A
upLoop                  jsr       screenDelay
                        jsr       inputInUI
                        lda       zInputMaskDebounced
                        bit       #INPUT_PAUSE+INPUT_QUIT
                        beq       upLoop
                        LDSCRNXY  11,8
                        jmp       blank48x8
                        rts

;-----------------------------------------------------------------------------
; MARK: uiShowCommonLabels
uiShowCommonLabels      entry
                        LDBOX     PLAYFIELDW,0,12,2            ; remove small TP logo
                        jsr       screenClearSection
                        LDSCRNXY  4,2
                        jsl       TIMEPILOT_000A
                        LDAPAL    COLOR_WHITE
                        sta       >printFontColor
                        PRINTSZ   TEXT_KONAMI,8,19
                        LDAPAL    COLOR_BLUE
                        sta       >printFontColor
                        PRINTSZ   TEXT_VERSION,3,22
                        LDAPAL    COLOR_YELLOW
                        sta       >printFontColor
                        PRINTSZ   TEXT_STEFAN,6,23
                        LDAPAL    COLOR_RED
                        sta       >printFontColor
                        PRINTSZ   TEXT_AND,21,23
                        LDAPAL    COLOR_ORANGE
                        sta       >printFontColor
                        PRINTSZ   TEXT_BRUTALDELUXE,4,24
                        rts

;-----------------------------------------------------------------------------
; MARK: uiShowHighScore
uiShowHighScore         entry
                        LDAPAL    COLOR_WHITE
                        sta       >printFontColor
                        lda       #'00'                        ; overwrite the 16 from 65816 if there
                        sta       TEXT_HIGHSCOREDISPLAY+4
                        ldx       #TEXT_HIGHSCOREDISPLAY
                        lda       highScoresDisplay
                        jsr       uiBCD2String
                        PRINTSZ   TEXT_HIGHSCOREDISPLAY,33,4
                        rts

;-----------------------------------------------------------------------------
; MARK: uiShowHighScoreTable
uiShowHighScoreTable    entry
                        LDAPAL    COLOR_MAGENTA
                        sta       >printFontColor
                        PRINTSZ   TEXT_RANKING,5,6

                        LDAPAL    COLOR_RED
                        sta       >printFontColor
                        PRINTSZ   TEXT_1ST,5,8
                        PRINTSZ   TEXT_HIGHSCORES1,11,8
                        PRINTSZ   TEXT_INITIALS1,20,8

                        LDAPAL    COLOR_ORANGE
                        sta       >printFontColor
                        PRINTSZ   TEXT_2ND,5,10
                        PRINTSZ   TEXT_HIGHSCORES2,11,10
                        PRINTSZ   TEXT_INITIALS2,20,10

                        LDAPAL    COLOR_YELLOW
                        sta       >printFontColor
                        PRINTSZ   TEXT_3RD,5,12
                        PRINTSZ   TEXT_HIGHSCORES3,11,12
                        PRINTSZ   TEXT_INITIALS3,20,12

                        LDAPAL    COLOR_GREEN
                        sta       >printFontColor
                        PRINTSZ   TEXT_4TH,5,14
                        PRINTSZ   TEXT_HIGHSCORES4,11,14
                        PRINTSZ   TEXT_INITIALS4,20,14

                        LDAPAL    COLOR_CYAN
                        sta       >printFontColor
                        PRINTSZ   TEXT_5TH,5,16
                        PRINTSZ   TEXT_HIGHSCORES5,11,16
                        PRINTSZ   TEXT_INITIALS5,20,16
                        rts

;-----------------------------------------------------------------------------
; MARK: uiShowP1Score
uiShowP1Score           entry
                        LDAPAL    COLOR_WHITE
                        sta       >printFontColor
                        ldx       #TEXT_P1SCORE
                        lda       zPlayerScore
                        jsr       uiBCD2String
                        PRINTSZ   TEXT_P1SCORE,33,7
                        rts

;-----------------------------------------------------------------------------
; MARK: uiShowP2Playing
uiShowP2Playing         entry
                        LDAPAL    COLOR_RED                    ; show the scores - always on-screen
                        sta       >printFontColor
                        PRINTSZ   TEXT_2UP,35,9
                        LDAPAL    COLOR_WHITE                  ; and show the last 0 on the score
                        sta       >printFontColor              ; stored scores are 10x smaller than "appears"
                        PRINTSZ   TEXT_SCORE00,37,10           ; P2 00
                        rts

;-----------------------------------------------------------------------------
; MARK: uiShowP2Score
uiShowP2Score           entry
                        LDAPAL    COLOR_WHITE
                        sta       >printFontColor
                        ldx       #TEXT_P2SCORE
                        lda       zPlayerScore
                        jsr       uiBCD2String
                        PRINTSZ   TEXT_P2SCORE,33,10
                        rts

;-----------------------------------------------------------------------------
; MARK: uiShowPlayerShips
uiShowPlayerShips       entry
tuspOffset              equ       zTemp12
tuspsLives              equ       zTemp11
                        lda       zSkyColor                    ; save the sky color
                        pha
                        stz       zSkyColor
                        LDBOX     PLAYFIELDW,19,12,2
                        jsr       screenClearSection           ; clear the whole ships area
                        lda       zPlayerLives
                        beq       uspsDone
                        cmp       #6
                        bcc       uspsLivesOk
                        lda       #6
uspsLivesOk             sta       tuspsLives
                        lda       #$7F00+(320-16)/2
uspsLoop                sta       tuspOffset
                        tay
                        jsl       PLAYER_024A
                        dec       tuspsLives
                        beq       uspsDone
                        lda       tuspOffset
                        sec
                        sbc       #8
                        bra       uspsLoop
uspsDone                pla
                        sta       zSkyColor
                        rts

;-----------------------------------------------------------------------------
; MARK: uiShowPreGameLabels
uiShowPreGameLabels     entry
                        LDSCRNXY  28,0
                        jsl       TPSMALL_000A
                        ldy       #LAYER_TEXT                  ; Player
                        jsr       thingsAdd
                        lda       #10*8
                        sta       activeMinX,x
                        sta       activeMinY,x
                        lda       #TEXTF_PLAYER
                        sta       activeFrame,x
                        lda       #-1
                        sta       activeExtra,x
                        stz       activeEID,x

                        ldy       #LAYER_TEXT                  ; Player #
                        jsr       thingsAdd
                        lda       #17*8
                        sta       activeMinX,x
                        lda       #10*8
                        sta       activeMinY,x
                        lda       zActivePlayer
                        adc       #TEXTF_1
                        sta       activeFrame,x
                        lda       #-1
                        sta       activeExtra,x
                        stz       activeEID,x

                        lda       zStageIntroState             ; 1st time in stage
                        beq       uspglAD                      ; yes
                        jmp       uspglReady                   ; no - only show ready

uspglAD                 ldy       #LAYER_TEXT                  ; A.D.
                        jsr       thingsAdd
                        lda       #10*8
                        sta       activeMinX,x
                        lda       #14*8
                        sta       activeMinY,x
                        lda       #TEXTF_AD
                        sta       activeFrame,x
                        sta       activeMaxX,x                 ; MaxX is the frame (color)
                        lda       #INTRO_COLOR_CYCLE_TIME      ; have to set gt 0 to animate
                        sta       activeExtra,x
                        stz       activeEID,x

                        ldy       #LAYER_TEXT                  ; era date
                        jsr       thingsAdd
                        lda       #15*8
                        sta       activeMinX,x
                        lda       #14*8
                        sta       activeMinY,x
                        lda       zActiveStage
                        asl       a
                        adc       zActiveStage
                        adc       #TEXTF_1910
                        sta       activeFrame,x
                        sta       activeMaxX,x
                        lda       #INTRO_COLOR_CYCLE_TIME
                        sta       activeExtra,x
                        stz       activeEID,x

                        ldy       #LAYER_TEXT                  ; stage
                        jsr       thingsAdd
                        lda       #10*8
                        sta       activeMinX,x
                        lda       #18*8
                        sta       activeMinY,x
                        lda       #TEXTF_STAGE
                        sta       activeFrame,x
                        lda       #-1
                        sta       activeExtra,x
                        stz       activeEID,x

                        ldy       #LAYER_TEXT                  ; stage #
                        jsr       thingsAdd
                        lda       #16*8
                        sta       activeMinX,x
                        lda       #18*8
                        sta       activeMinY,x
                        lda       zActiveStage
                        adc       #TEXTF_1
                        sta       activeFrame,x
                        lda       #-1
                        sta       activeExtra,x
                        stz       activeEID,x
                        rts

uspglReady              ldy       #LAYER_TEXT                  ; READY
                        jsr       thingsAdd
                        lda       #11*8
                        sta       activeMinX,x
                        lda       #14*8
                        sta       activeMinY,x
                        lda       zActivePlayer
                        adc       #TEXTF_READY
                        sta       activeFrame,x
                        lda       #-1
                        sta       activeExtra,x
                        stz       activeEID,x
                        rts

;-----------------------------------------------------------------------------
; MARK: uiShowStageIcon
uiShowStageIcon         entry
tussiOffset             equ       zTemp12
tussiStage              equ       zTemp11
                        lda       zSkyColor                    ; save current sky color
                        pha
                        stz       zSkyColor                    ; install black
                        LDBOX     PLAYFIELDW,16,12,1
                        jsr       screenClearSection           ; clear the stage icon area
                        lda       zActiveStage                 ; 1 icon per stage
                        lsr       a                            ; count in 1's for this
                        sta       tussiStage
                        lda       #$7000+(320-8)/2             ; offset line 16, to the right - 8 pixels in
ussiLoop                sta       tussiOffset
                        tay
                        jsl       STAGE_000A                   ; draw the stage icon
                        dec       tussiStage
                        bmi       ussiDone                     ; stop when all drawn
                        lda       tussiOffset                  ; move to prev icon pos
                        sec
                        sbc       #4
                        bra       ussiLoop
ussiDone                pla                                    ; restore the sky color
                        sta       zSkyColor
                        rts

;-----------------------------------------------------------------------------
; MARK: uiShowStageProgress
uiShowStageProgress     entry
tusspOffset             equ       zTemp12
tusspProgress           equ       zTemp11
                        lda       zSkyColor                    ; save current sky color
                        pha
                        stz       zSkyColor                    ; install black
                        LDBOX     PLAYFIELDW,24,12,1
                        jsr       screenClearSection           ; clear the progress icon area
                        lda       #5                           ; 6 progress planes (6 * 8 = 48 enemies to kill)
                        sta       tusspProgress
                        lda       zActiveStage                 ; 2001 gets space ships for progress
                        cmp       #TIME_PERIOD4_2001
                        bne       usspPlanes
                        lda       #$9800+(320-16)/2            ; offset line 24, to the right - 16 pixels in
usspLoopSDraw           sta       tusspOffset
                        tay
                        jsl       ENEMY4_000A                  ; draw the progress icon
                        dec       tusspProgress
                        bmi       usspDoneDraw                 ; stop when all drawn
                        lda       tusspOffset                  ; move to prev icon pos
                        sec
                        sbc       #8
                        bra       usspLoopSDraw
usspPlanes              lda       #$9800+(320-16)/2            ; offset line 24, to the right - 16 pixels in
usspLoopDraw            sta       tusspOffset
                        tay
                        jsl       PROGRESS_000A                ; draw the progress icon
                        dec       tusspProgress
                        bmi       usspDoneDraw                 ; stop when all drawn
                        lda       tusspOffset                  ; move to prev icon pos
                        sec
                        sbc       #8
                        bra       usspLoopDraw
usspDoneDraw            pla                                    ; restore the sky color
                        sta       zSkyColor
                        lda       zEnemiesKilled
                        beq       usspDoneErase
                        pha
esspEraseLoop           pha
                        jsr       uiUpdateStageProgress
                        pla
                        dea
                        sta       zEnemiesKilled
                        bne       esspEraseLoop
                        pla
                        sta       zEnemiesKilled
usspDoneErase           rts

;-----------------------------------------------------------------------------
; MARK: uiShowTitle
uiShowTitle             entry
                        LDAPAL    COLOR_CYAN                   ; show the main text
                        sta       >printFontColor
                        PRINTSZ   TEXT_PLAY,12,0
                        PRINTSZ   TEXT_DEPOSIT,5,6
                        PRINTSZ   TEXT_BONUS1,5,14
                        PRINTSZ   TEXT_BONUS2,5,16
                        LDAPAL    COLOR_RED
                        sta       >printFontColor
                        PRINTSZ   TEXT_TRY_GAME,6,8
                        LDAPAL    COLOR_YELLOW
                        sta       >printFontColor
                        PRINTSZ   TEXT_CONTROLSK,6,10
                        PRINTSZ   TEXT_CONTROLSJ,6,12
                        LDAPAL    COLOR_GREEN
                        sta       >printFontColor
                        lda       zInputUsingJoystick
                        bne       uistJoy
                        PRINTSZ   TEXT_K,14,10
                        rts
uistJoy                 PRINTSZ   TEXT_J,14,12
                        rts

;-----------------------------------------------------------------------------
; MARK: uiUpdateStageProgress
uiUpdateStageProgress   entry
                        lda       zEnemiesKilled               ; calc which next 2 pixels to erase
                        cmp       #ENEMIES_TO_KILL_TO_CLEAR+1
                        bcs       uuspdone                     ; don't overflow stage timer erase
                        adc       #(SCREEN_PRIGHT/2)-1         ; from the end of the play area
                        tax                                    ; offset in x
                        LDAPAL    COLOR_BLACK                  ; erase in black
                        short     m
                        sta       SCREEN_BASE+(24*8+0)*160,x   ; write the 8x2 pixels
                        sta       SCREEN_BASE+(24*8+1)*160,x
                        sta       SCREEN_BASE+(24*8+2)*160,x
                        sta       SCREEN_BASE+(24*8+3)*160,x
                        sta       SCREEN_BASE+(24*8+4)*160,x
                        sta       SCREEN_BASE+(24*8+5)*160,x
                        sta       SCREEN_BASE+(24*8+6)*160,x
                        sta       SCREEN_BASE+(24*8+7)*160,x
                        long      m
uuspdone                rts

thisisaformattinglabel  anop
                        END
