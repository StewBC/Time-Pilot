; =============================================================================
; mli.s — ProDOS MLI READ_BLOCK primitive for Time Pilot IIvera
;
; C calls mlib_read_block() after setting the globals below. It issues:
;     JSR $BF00
;     $80                 ; READ_BLOCK
;     <param block>
; and copies the status byte back to mli_status.
;
; Verified to assemble + link under mos-apple2e-clang (a separate .s file;
; inline asm in C crashes the 6502 backend). BYTE/WORD are ca65 — use .byte/.word.
; =============================================================================
        .section .bss
        .global mli_unit
        .global mli_buf_lo
        .global mli_buf_hi
        .global mli_blk_lo
        .global mli_blk_hi
        .global mli_status
mli_unit:   .byte 0          ; MLI unit number (from ProDOS global page $BF30)
mli_buf_lo: .byte 0          ; 512-byte buffer address (low)
mli_buf_hi: .byte 0          ; (high)
mli_blk_lo: .byte 0          ; block number (low)
mli_blk_hi: .byte 0          ; (high)
mli_status: .byte 0          ; $00 = success, $27 = I/O error, ...
mli_zp_save: .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

        .section .data
        .global mli_open_params
mli_open_params: .byte 3,0,0,0,0,0
        .global mli_close_params
mli_close_params: .byte 1,0
        .global mli_read_params
mli_read_params: .byte 4,0,0,0,0,0,0,0
        .global mli_mark_params
mli_mark_params: .byte 2,0,0,0,0
        .global mli_prefix_params
mli_prefix_params: .byte 1,0,0

        .section .bss
        .global mlib_params
mlib_params:                  ; MLI READ_BLOCK param block (count set at runtime)
        .byte 0               ; +0 param count (mlib_read_block writes 3)
        .byte 0               ; +1 unit (patched)
        .word 0               ; +2 buffer addr (patched)
        .word 0               ; +4 block number (patched)
        .byte 0               ; +6 status (written by MLI)
        .byte 0               ; +7 padding

        .section .text
        .global mlib_read_block
mlib_read_block:
        LDA #3                ; param count
        STA mlib_params+0
        LDA mli_unit
        STA mlib_params+1
        LDA mli_buf_lo
        STA mlib_params+2
        LDA mli_buf_hi
        STA mlib_params+3
        LDA mli_blk_lo
        STA mlib_params+4
        LDA mli_blk_hi
        STA mlib_params+5
        JSR $BF00
        .byte $80             ; READ_BLOCK
        .word mlib_params
        STA mli_status
        RTS

        .macro CALL_MLI name, opcode, params
        .global \name
\name:
        LDX #15
.Lsave\@:
        LDA $40,X
        STA mli_zp_save,X
        DEX
        BPL .Lsave\@
        JSR $BF00
        .byte \opcode
        .word \params
        STA mli_status
        LDX #15
.Lrest\@:
        LDA mli_zp_save,X
        STA $40,X
        DEX
        BPL .Lrest\@
        RTS
        .endmacro

        CALL_MLI mlib_open, $C8, mli_open_params
        CALL_MLI mlib_close, $CC, mli_close_params
        CALL_MLI mlib_read, $CA, mli_read_params
        CALL_MLI mlib_set_mark, $CE, mli_mark_params
        CALL_MLI mlib_get_prefix, $C7, mli_prefix_params
