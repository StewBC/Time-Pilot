; =============================================================================
; loader.s — HDV file-read and floppy block-read trampolines for TPILOT.SYSTEM
;
; Each trampoline is copied to $0300 before use. Internal control flow is
; relative (safe after the copy).
; =============================================================================
        .section .rodata
        .global file_trampoline_src
        .global file_trampoline_src_end
file_trampoline_src:
; $3C0 READ param: refnum, dest, request count, transfer count
; $3D0 CLOSE param: refnum
        LDA #4
        STA $3C0
        LDX #0
load_loop:
        STX $3C9
        JSR $BF00
        .byte $CA               ; READ
        .word $3C0
        BCS read_error
        LDX $3C9
        LDA $3C6
        ORA $3C7
        BEQ load_done
        ; MLI READ transfers at most 512 bytes. Continue only for a full block.
        LDA $3C7
        CMP #2
        BNE load_done
        INC $3C3
        INC $3C3
        INX
        CPX #88                 ; $0800..$B7FF is the maximum load window
        BCC load_loop
        JMP load_done
read_error:
        CMP #$4C                ; EOF is expected after an exact 512-byte multiple
        BNE hang
        LDA $3C6
        ORA $3C7
        BNE hang
load_done:
        LDA #1
        STA $3D0
        LDA $3C1
        STA $3D1
        JSR $BF00
        .byte $CC               ; CLOSE
        .word $3D0
        JMP $0800
hang:
        SEC
        BCS hang
file_trampoline_src_end:

        .global block_trampoline_src
        .global block_trampoline_src_end
block_trampoline_src:
; $3C0 READ_BLOCK param: count, unit, buffer, block
; $3C8 block count; $B800/$B900 contain the sapling index
        LDA #3
        STA $3C0
        LDX #0
block_load_loop:
        LDA $B800,X
        STA $3C4
        LDA $B900,X
        STA $3C5
        LDA #0
        STA $3C2
        TXA
        ASL A
        CLC
        ADC #$08
        STA $3C3
        STX $3C9
        JSR $BF00
        .byte $80               ; READ_BLOCK
        .word $3C0
        BCS block_hang
        LDX $3C9
        INX
        CPX $3C8
        BCC block_load_loop
        JMP $0800
block_hang:
        SEC
        BCS block_hang
block_trampoline_src_end:

        .section .text
        .global launch_game
launch_game:
        JMP $0300
