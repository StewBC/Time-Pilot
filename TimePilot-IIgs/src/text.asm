;-----------------------------------------------------------------------------
; text.asm
; Part of Time Pilot, the 1982 arcade game remake for the Apple IIgs
;
; Stefan Wessels, 2024
; This is free and unencumbered software released into the public domain.
;-----------------------------------------------------------------------------

TEXT                    DATA

TEXT_1ST                dc    c'1ST',h'00'
TEXT_1UP                dc    c'1-UP',h'00'
TEXT_2ND                dc    c'2ND',h'00'
TEXT_2UP                dc    c'2-UP',h'00'
TEXT_3RD                dc    c'3RD',h'00'
TEXT_4TH                dc    c'4TH',h'00'
TEXT_5TH                dc    c'5TH',h'00'
TEXT_BRUTALDELUXE       dc    c'BRUTAL DELUXE SOFTWARE',h'00'
TEXT_BLANK              dc    h'6060606060606060',h'00'
TEXT_BONUS1             dc    c'1ST BONUS 10000 PTS.',h'00'
TEXT_BONUS2             dc    c'AND EVERY 50000 PTS.',h'00'
TEXT_CONTROLSJ          dc    c'    OR [J]OYSTICK',h'00'
TEXT_CONTROLSK          dc    c'SELECT [K]EYBOARD',h'00'
TEXT_DEPOSIT            dc    c'PLEASE PRESS 1 OR 2',h'00'
TEXT_ENTER_INITIALS     dc    c'INPUT YOUR INITIALS',h'00'
TEXT_GAME_OVER          dc    c'GAME OVER',h'00'
TEXT_HIGH               dc    c'HIGH SCORE',h'00'
TEXT_HIGH_AV            entry
TEXT_HIGHSCOREDISPLAY   dc    c' 65816',h'00'
TEXT_HIGHSCORES1        dc    c' 65816',h'0000'
TEXT_HIGHSCORES2        dc    c'  8086',h'0000'
TEXT_HIGHSCORES3        dc    c'  6809',h'0000'
TEXT_HIGHSCORES4        dc    c'  6502',h'0000'
TEXT_HIGHSCORES5        dc    c'  4040',h'0000'
TEXT_INITIALS1          dc    c'K.O',h'00'
TEXT_INITIALS2          dc    c'N.A',h'00'
TEXT_INITIALS3          dc    c'M.I',h'00'
TEXT_INITIALS4          dc    c'O.O',h'00'
TEXT_INITIALS5          dc    c'Y.A',h'00'
TEXT_J                  dc    c'J',h'00'
TEXT_K                  dc    c'K',h'00'
TEXT_KONAMI             dc    h'5E',c' KONAMI 1982',h'00'
TEXT_P1SCORE            dc    c'    ',h'00'
TEXT_P2SCORE            dc    c'    ',h'00'
TEXT_PAUSE              dc    c'PAUSED',h'00'
TEXT_PLAY               dc    c'PLAY',h'00'
TEXT_PRESS_BUTTON       dc    c'THEN PRESS FIRE BUTTON',h'00'
TEXT_RANKING            dc    c'SCORE RANKING TABLE',h'00'
TEXT_READY              dc    c'READY',h'00'
TEXT_SCORE00            dc    c'00',h'00'
TEXT_STEFAN             dc    c'STEFAN WESSELS',h'00'
TEXT_AND                dc    c'AND',h'00'
TEXT_TRY_GAME           dc    c'AND TRY THIS GAME',h'00'
TEXT_VERSION            dc    c'2024 IIGS VERSION 1.5.A BY',h'00'

thisisformattextdata__  anop
                        END
