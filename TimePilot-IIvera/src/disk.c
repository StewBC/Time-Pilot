//-----------------------------------------------------------------------------
// disk.c — MLI READ_BLOCK streaming supporting dual 140KB floppy drives (D1/D2)
// and 800KB ProDOS HDV images transparently.
//
// Dual 140KB Floppy Layout:
//   - Drive 1 (Disk 1): PRODOS, TPILOT.SYSTEM, MAIN.BIN, ART (block 128)
//   - Drive 2 (Disk 2): PCM Audio (block 7), MAIN4.BIN
//
// 800KB HDV Layout:
//   - Boot Drive: PCM Audio (block 200), ART (block 900)
//-----------------------------------------------------------------------------
#include <stdint.h>
#include "disk.h"

// MLI interface (mli.s).
extern uint8_t mli_unit;
extern uint8_t mli_buf_lo, mli_buf_hi;
extern uint8_t mli_blk_lo, mli_blk_hi;
extern uint8_t mli_status;
extern uint8_t mli_open_params[], mli_close_params[], mli_read_params[];
extern uint8_t mli_mark_params[], mli_prefix_params[];
extern void mlib_read_block(void);
extern void mlib_open(void), mlib_close(void), mlib_read(void);
extern void mlib_set_mark(void), mlib_get_prefix(void);

#define BLOCK_BYTES 512

/* 512-byte MLI window at $B800. Must not be text page 1 ($0400, splash still
 * visible under VERA), must not be in the $0800 load image, and the dest
 * pages must be unmarked — crt0 paints $20-$BF used, which would make a BSS
 * buffer illegal the same way the loader's first READ_BLOCK was. */
static uint8_t * const diskBuf = (uint8_t *)0xB800;
static uint16_t cached_abs_block = 0xFFFF;
static uint8_t  cached_unit = 0xFF;

static uint8_t boot_unit = 0;
static uint8_t drive1_unit = 0;
static uint8_t drive2_unit = 0;
static uint8_t is_floppy = 0;

static uint16_t art_base_block = 900;
static uint8_t  art_unit = 0;
static uint16_t pcm_base_block = 200;
static uint8_t  pcm_unit = 0;
static uint8_t file_mode = 0;
static uint8_t art_ref = 0, pcm_ref = 0;
static uint8_t file_path[65];
static uint8_t prefix_path[65];
static uint8_t art_io_buffer[1024] __attribute__((aligned(256)));
static uint8_t pcm_io_buffer[1024] __attribute__((aligned(256)));

static uint8_t path_for(const char *leaf) {
    uint8_t n = prefix_path[0];
    uint8_t i = 0;
    if (n > 63) return 0;
    file_path[0] = n;
    while (i < n) { file_path[i + 1] = prefix_path[i + 1]; i++; }
    if (n && file_path[n] != '/') {
        if (n >= 63) return 0;
        file_path[++n] = '/';
    }
    for (i = 0; leaf[i]; i++) {
        if (n >= 64) return 0;
        file_path[++n] = (uint8_t)leaf[i];
    }
    file_path[0] = n;
    return 1;
}

static uint8_t open_asset(const char *leaf, uint8_t *ref, uint8_t *io_buffer) {
    uintptr_t p;
    if (!path_for(leaf)) return 0;
    p = (uintptr_t)file_path;
    mli_open_params[1] = (uint8_t)p;
    mli_open_params[2] = (uint8_t)(p >> 8);
    p = (uintptr_t)io_buffer;
    mli_open_params[3] = (uint8_t)p;
    mli_open_params[4] = (uint8_t)(p >> 8);
    mli_open_params[5] = 0;
    mlib_open();
    if (mli_status) return 0;
    *ref = mli_open_params[5];
    return 1;
}

static uint8_t has_game_marker(void) {
    uint8_t ref = 0;
    if (!open_asset("TIME.PILOT", &ref, art_io_buffer)) return 0;
    mli_close_params[1] = ref;
    mlib_close();
    return mli_status == 0;
}

static uint8_t read_asset_block(uint8_t ref, uint32_t offset, uint16_t count) {
    mli_mark_params[1] = ref;
    mli_mark_params[2] = (uint8_t)offset;
    mli_mark_params[3] = (uint8_t)(offset >> 8);
    mli_mark_params[4] = (uint8_t)(offset >> 16);
    mlib_set_mark();
    if (mli_status) return 0;
    mli_read_params[1] = ref;
    mli_read_params[2] = 0x00;
    mli_read_params[3] = 0xB8;
    mli_read_params[4] = (uint8_t)count;
    mli_read_params[5] = (uint8_t)(count >> 8);
    mli_read_params[6] = mli_read_params[7] = 0;
    mlib_read();
    return mli_status == 0 && mli_read_params[6] == (uint8_t)count
        && mli_read_params[7] == (uint8_t)(count >> 8);
}

static void prompt_disk2(void) {
    const char *m1 = "PLEASE INSERT DISK 2 IN DRIVE 2";
    const char *m2 = "PRESS ANY KEY TO CONTINUE...";
    volatile uint8_t *t10 = (volatile uint8_t *)0x0428;
    volatile uint8_t *t12 = (volatile uint8_t *)0x0528;

    // HOME: clear the full Apple II text page before prompting for disk 2.
    for (uint8_t r = 0; r < 24; r++) {
        uint16_t addr = (uint16_t)(0x0400u + ((uint16_t)(r & 7) << 7)
                                   + (uint16_t)(r & 0x18) * 5u);
        volatile uint8_t *row = (volatile uint8_t *)addr;
        for (uint8_t c = 0; c < 40; c++) row[c] = 0xA0;
    }

    for (uint8_t i = 0; m1[i]; i++) t10[i + 4] = (uint8_t)(m1[i] | 0x80);
    for (uint8_t i = 0; m2[i]; i++) t12[i + 6] = (uint8_t)(m2[i] | 0x80);

    // Clear strobe, wait for key, clear strobe
    *(volatile uint8_t *)0xC010 = 0;
    while ((*(volatile uint8_t *)0xC000) < 128) {}
    *(volatile uint8_t *)0xC010 = 0;

    for (uint8_t i = 0; i < 40; i++) {
        t10[i] = 0xA0;
        t12[i] = 0xA0;
    }
}

static void mli_read_unit(uint8_t unit, uint16_t abs_block, uint8_t *dest) {
    mli_unit = unit;
    mli_buf_lo = (uint8_t)((uint32_t)(unsigned long)dest);
    mli_buf_hi = (uint8_t)(((uint32_t)(unsigned long)dest) >> 8);
    mli_blk_lo = (uint8_t)abs_block;
    mli_blk_hi = (uint8_t)(abs_block >> 8);
    mlib_read_block();

    // If reading from Drive 2 in floppy mode fails, prompt and retry
    while (mli_status != 0 && unit == drive2_unit && is_floppy) {
        prompt_disk2();
        mli_unit = unit;
        mli_buf_lo = (uint8_t)((uint32_t)(unsigned long)dest);
        mli_buf_hi = (uint8_t)(((uint32_t)(unsigned long)dest) >> 8);
        mli_blk_lo = (uint8_t)abs_block;
        mli_blk_hi = (uint8_t)(abs_block >> 8);
        mlib_read_block();
    }
}

void disk_init(void) {
    /* crt0 marked $20-$BF used. Protect the $0800-$1FFF code, then free the
     * $B800 disk window (pages $B8-$B9) so READ_BLOCK may write it. */
    ((volatile uint8_t *)0xBF58)[1] = 0xFF;
    ((volatile uint8_t *)0xBF58)[2] = 0xFF;
    ((volatile uint8_t *)0xBF58)[3] = 0xFF;
    *(volatile uint8_t *)0xBF6F &= 0x3F;

    boot_unit = *(volatile uint8_t *)0xBF30;

    // Read Key Block of Volume Directory (block 2) on the boot drive to inspect volume size
    mli_read_unit(boot_unit, 2, diskBuf);
    uint16_t total_blocks = (uint16_t)diskBuf[0x29] | ((uint16_t)diskBuf[0x2A] << 8);

    if (total_blocks <= 280) {
        // Dual 140KB Floppy Mode (Disk 1 in Drive 1, Disk 2 in Drive 2 of same slot)
        is_floppy = 1;
        drive1_unit = boot_unit & 0x7F;
        drive2_unit = boot_unit | 0x80;
        art_unit = drive1_unit;
        art_base_block = 128;
        pcm_unit = drive2_unit;
        pcm_base_block = 7;
    } else {
        // HDV / Hard Drive Mode: art & pcm live on the boot volume (Drive 1, Drive 2, or any drive n)
        is_floppy = 0;
        drive1_unit = boot_unit;
        drive2_unit = boot_unit;
        art_unit = boot_unit;
        art_base_block = 900;
        pcm_unit = boot_unit;
        pcm_base_block = 200;
        /* HDV assets are ordinary ProDOS files. Retain fixed-block fallback
         * for older images; file-level copies work because these files are
         * opened by name and their ProDOS allocation may differ. */
        uintptr_t p = (uintptr_t)prefix_path;
        mli_prefix_params[1] = (uint8_t)p;
        mli_prefix_params[2] = (uint8_t)(p >> 8);
        mlib_get_prefix();
        if (mli_status || prefix_path[0] > 63) prefix_path[0] = 0;
        if (has_game_marker()
            && open_asset("ART", &art_ref, art_io_buffer)
            && open_asset("PCM", &pcm_ref, pcm_io_buffer)) {
            file_mode = 1;
        } else {
            if (art_ref) {
                mli_close_params[1] = art_ref;
                mlib_close();
                art_ref = 0;
            }
            if (pcm_ref) {
                mli_close_params[1] = pcm_ref;
                mlib_close();
                pcm_ref = 0;
            }
        }
    }

    cached_abs_block = 0xFFFF;
    cached_unit = 0xFF;
}

uint8_t *disk_ensure(uint32_t base_block, uint32_t total, uint32_t offset) {
    uint16_t block_idx = (uint16_t)(offset / BLOCK_BYTES);
    uint8_t unit;
    uint16_t abs_block;

    if (file_mode && (base_block == 200 || base_block == 900)) {
        uint8_t ref = (base_block == 200) ? pcm_ref : art_ref;
        uint8_t cache_key = (base_block == 200) ? 0xFE : 0xFD;
        uint32_t aligned_offset = (uint32_t)block_idx * BLOCK_BYTES;
        uint16_t count = (uint16_t)((total - aligned_offset) < BLOCK_BYTES
            ? (total - aligned_offset) : BLOCK_BYTES);
        if (cache_key != cached_unit || block_idx != cached_abs_block) {
            if (!read_asset_block(ref, aligned_offset, count)) return diskBuf;
            cached_abs_block = block_idx;
            cached_unit = cache_key;
        }
        return &diskBuf[offset & (BLOCK_BYTES - 1)];
    }

    if (base_block == 200) {        // PCM Audio stream (legacy fixed-block/floppy)
        unit = pcm_unit;
        abs_block = pcm_base_block + block_idx;
    } else if (base_block == 900) {  // Sprite / pattern art stream
        unit = art_unit;
        abs_block = art_base_block + block_idx;
    } else {
        unit = boot_unit;
        abs_block = (uint16_t)base_block + block_idx;
    }

    if (abs_block != cached_abs_block || unit != cached_unit) {
        mli_read_unit(unit, abs_block, diskBuf);
        cached_abs_block = abs_block;
        cached_unit = unit;
    }
    return &diskBuf[offset & (BLOCK_BYTES - 1)];
}
