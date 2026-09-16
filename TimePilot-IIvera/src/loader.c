/* TPILOT.SYSTEM — ProDOS SYS loader. Replaces BASIC.SYSTEM + STARTUP + BRUN.
 *
 * ProDOS loads this at $2000. We detect the VERA slot, optionally wait for
 * floppy disk 2, then copy a trampoline to $300 which READ_BLOCKs MAIN.BIN
 * (or MAIN4.BIN) to $0800 and jumps there. The trampoline lives below the
 * game image so the load may overlay this SYS.
 */
#include <stdint.h>

extern uint8_t mli_unit;
extern uint8_t mli_buf_lo, mli_buf_hi;
extern uint8_t mli_blk_lo, mli_blk_hi;
extern uint8_t mli_status;
extern void mlib_read_block(void);
extern const uint8_t trampoline_src[];
extern const uint8_t trampoline_src_end[];
extern void launch_game(void);

#define BLOCK_BYTES 512

/* MLI READ_BLOCK dest must be a page the ProDOS bitmap still marks free.
 * llvm-mos apple2 crt0 paints $20-$BF used, so SYS BSS at $2000+ is illegal.
 * $0400-$07FF is the visible 40-col splash (stays on screen under VERA).
 * $0C00 is below the SYS and off the text screen. */
static uint8_t * const mli_buf = (uint8_t *)0x0C00;
static uint8_t * const idx_buf = (uint8_t *)0xB800;

static uint8_t *line_ptr(uint8_t row) {
    return (uint8_t *)(uint16_t)(0x0400u + ((uint16_t)(row & 7) << 7)
                                 + (uint16_t)(row & 0x18) * 5u);
}

static void home(void) {
    for (uint8_t r = 0; r < 24; r++) {
        uint8_t *p = line_ptr(r);
        for (uint8_t c = 0; c < 40; c++)
            p[c] = 0xA0;
    }
}

static void put_line(uint8_t row, uint8_t col, const char *s) {
    uint8_t *p = line_ptr(row) + col;
    while (*s)
        *p++ = (uint8_t)(*s++ | 0x80);
}

static void text40(void) {
    *(volatile uint8_t *)0xC051 = 0; /* text */
    *(volatile uint8_t *)0xC054 = 0; /* page 1 */
    *(volatile uint8_t *)0xC00C = 0; /* 40-column */
    *(volatile uint8_t *)0xC00E = 0; /* primary charset */
}

static void wait_key(void) {
    *(volatile uint8_t *)0xC010 = 0;
    while (*(volatile uint8_t *)0xC000 < 128) {}
    *(volatile uint8_t *)0xC010 = 0;
}

static void wait_start(void) {
    /* ~5s busy-wait at 1 MHz, or first key. Inner 65535 loops ≈ 1s. */
    *(volatile uint8_t *)0xC010 = 0;
    for (uint8_t i = 0; i < 5; i++) {
        for (uint16_t j = 0; j < 0xFFFFu; j++) {
            if (*(volatile uint8_t *)0xC000 >= 128) {
                *(volatile uint8_t *)0xC010 = 0;
                return;
            }
        }
    }
    *(volatile uint8_t *)0xC010 = 0;
}

static void hang(const char *msg) {
    put_line(22, 0, msg);
    for (;;) {}
}

static uint8_t probe_vera(uint16_t base) {
    volatile uint8_t *r = (volatile uint8_t *)base;
    r[5] = 1;
    if (r[5] != 1) return 0;
    r[5] = 0;
    if (r[5] != 0) return 0;
    r[0] = 0; r[1] = 0; r[2] = 0;
    r[3] = 222;
    r[0] = 0; r[1] = 0; r[2] = 0;
    if (r[3] != 222) return 0;
    r[3] = 111;
    r[0] = 0; r[1] = 0; r[2] = 0;
    return r[3] == 111;
}

static void mli_read(uint8_t unit, uint16_t blk, uint8_t *dest) {
    mli_unit = unit;
    mli_buf_lo = (uint8_t)(uint16_t)dest;
    mli_buf_hi = (uint8_t)((uint16_t)dest >> 8);
    mli_blk_lo = (uint8_t)blk;
    mli_blk_hi = (uint8_t)(blk >> 8);
    mlib_read_block();
}

static void prompt_disk2(void) {
    put_line(20, 4, "PLEASE INSERT DISK 2 IN DRIVE 2");
    put_line(21, 6, "PRESS ANY KEY TO CONTINUE...");
    wait_key();
    put_line(20, 0, "                                        ");
    put_line(21, 0, "                                        ");
}

static uint8_t name_eq(const uint8_t *ent, const char *want) {
    uint8_t n = ent[0] & 0x0F;
    uint8_t i;
    for (i = 0; want[i]; i++) {
        if (i >= n) return 0;
        uint8_t c = ent[1 + i] & 0x7F;
        if (c >= 0x60) c = (uint8_t)(c - 0x20);
        if (c != (uint8_t)want[i]) return 0;
    }
    return i == n;
}

static uint8_t find_file(uint8_t unit, const char *name,
                         uint8_t *st_type, uint16_t *key, uint16_t *eof) {
    uint16_t blk = 2;
    while (blk) {
        mli_read(unit, blk, mli_buf);
        if (mli_status) return 0;
        uint8_t start = (blk == 2) ? 1 : 0;
        for (uint8_t i = start; i < 13; i++) {
            const uint8_t *ent = &mli_buf[4 + i * 39];
            uint8_t st = (uint8_t)(ent[0] >> 4);
            if (st == 0) continue;
            if (!name_eq(ent, name)) continue;
            *st_type = st;
            *key = (uint16_t)ent[0x11] | ((uint16_t)ent[0x12] << 8);
            *eof = (uint16_t)ent[0x15] | ((uint16_t)ent[0x16] << 8);
            return 1;
        }
        blk = (uint16_t)mli_buf[2] | ((uint16_t)mli_buf[3] << 8);
    }
    return 0;
}

int main(void) {
    uint8_t slot = 0;
    uint8_t boot, unit, floppy;
    uint8_t st;
    uint16_t key, eof, nblocks, total;
    const char *fname;
    uint8_t *tp;
    uint8_t n;

    text40();
    home();
    put_line(0, 0, "TIME PILOT FOR APPLE II VERA v1.9");
    put_line(1, 0, "BY ANOMIXER https://github.com/anomixer");
    put_line(2, 0, "---------------------------------------");

    if (probe_vera(0xC200)) slot = 2;
    else if (probe_vera(0xC400)) slot = 4;
    if (!slot) {
        put_line(5, 0, "STATUS: NO VERA CARD DETECTED!");
        hang("ERROR: INSTALL VERA IN SLOT 2 OR 4.");
    }
    if (slot == 2)
        put_line(4, 0, "STATUS: VERA CARD DETECTED IN SLOT 2");
    else
        put_line(4, 0, "STATUS: VERA CARD DETECTED IN SLOT 4");

    put_line(6, 0, "CONTROLS:");
    put_line(8, 4, "STEER  : [W],[S],[A],[D]  SPIN: Q/E");
    put_line(9, 4, "FIRE   : [SPACE]");
    put_line(10, 4, "START  : [1]-UP / [2]-UP");
    put_line(11, 4, "CONTROL: [J]OYSTICK / [K]EYBOARD");
    put_line(12, 4, "SPECIAL: [P]AUSE / [I]NFINITE LIVES");
    put_line(14, 0, "HIT ANY KEY OR WAIT 5 SECS TO START...");
    wait_start();
    put_line(16, 0, "RUNNING TIME PILOT...");

    boot = *(volatile uint8_t *)0xBF30;
    mli_read(boot, 2, mli_buf);
    if (mli_status)
        hang("ERROR: CANNOT READ BOOT VOLUME.");
    total = (uint16_t)mli_buf[0x29] | ((uint16_t)mli_buf[0x2A] << 8);
    floppy = (total <= 280);
    unit = boot;
    fname = "MAIN.BIN";
    if (slot == 4) {
        fname = "MAIN4.BIN";
        if (floppy)
            unit = (uint8_t)(boot | 0x80);
    }

    if (floppy && slot == 4) {
        for (;;) {
            mli_read(unit, 2, mli_buf);
            if (mli_status == 0)
                break;
            prompt_disk2();
        }
    }

    if (!find_file(unit, fname, &st, &key, &eof) || eof == 0)
        hang("ERROR: CANNOT FIND GAME FILE.");

    nblocks = (uint16_t)((eof + (BLOCK_BYTES - 1)) / BLOCK_BYTES);
    if (nblocks == 0 || nblocks > 255)
        hang("ERROR: GAME FILE TOO LARGE.");

    if (st == 1) {
        /* Seedling: the key block is the data. Synthesize a 1-entry index. */
        for (uint16_t i = 0; i < BLOCK_BYTES; i++)
            idx_buf[i] = 0;
        idx_buf[0] = (uint8_t)key;
        idx_buf[256] = (uint8_t)(key >> 8);
        nblocks = 1;
    } else if (st == 2) {
        /* Index via $0C00 (MLI-legal), then CPU-copy to $B800. Do not MLI
         * into $0400 — that is the splash, still visible under VERA. */
        mli_read(unit, key, mli_buf);
        if (mli_status)
            hang("ERROR: CANNOT READ GAME INDEX.");
        for (uint16_t i = 0; i < BLOCK_BYTES; i++)
            idx_buf[i] = mli_buf[i];
    } else {
        hang("ERROR: UNSUPPORTED GAME FILE.");
    }

    /* crt0 marked $20-$BF used, so the trampoline's READ_BLOCK into $2000+
     * would also be refused. Free $08-$B7 for the game; leave $00-$07 and
     * $B8-$BF (zp/text1/stack/ProDOS) alone. */
    {
        volatile uint8_t *bm = (volatile uint8_t *)0xBF58;
        for (uint8_t i = 1; i < 23; i++)
            bm[i] = 0;
    }

    n = (uint8_t)(trampoline_src_end - trampoline_src);
    tp = (uint8_t *)0x0300;
    for (uint8_t i = 0; i < n; i++)
        tp[i] = trampoline_src[i];

    *(volatile uint8_t *)0x3C1 = unit;
    *(volatile uint8_t *)0x3C8 = (uint8_t)nblocks;
    launch_game();
    return 0;
}
