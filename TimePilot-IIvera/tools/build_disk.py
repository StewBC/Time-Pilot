#!/usr/bin/env python3
"""build_disk.py - Package Time Pilot IIvera into two 140KB ProDOS floppies.

Disk 1 (TimePilot-IIvera-D1.po; volume TIME.PILOT):
  - PRODOS (preserved from the 140kb.po template)
  - TPILOT.SYSTEM (slot detect + loader)
  - MAIN.BIN (Slot 2 binary)
  - ART      (art.blob at fixed block 128)

Disk 2 (TimePilot-IIvera-D2.po; volume TIME.PILOT.2):
  - PCM       (pcm.blob audio at fixed block 7)
  - MAIN4.BIN (Slot 4 binary)

Boot sequence:
  1. Apple II boots Disk 1 in Drive 1.
  2. TPILOT.SYSTEM detects the VERA slot (Slot 2 or 4).
  3. Slot 2 -> load MAIN.BIN to $0800; Slot 4 -> Disk 2, load MAIN4.BIN to $0800.
  4. In game, disk_init detects 140KB floppy mode: ART streams from Drive 1
     (block 128), PCM streams from Drive 2 (block 7).

The floppy images use fixed-block loading and are intended for a dual-floppy
setup. Use the HDV image for hard-disk installations.
"""

import argparse
from datetime import datetime
import os
import sys

BLOCK = 512
TOTAL_BLOCKS = 280
ART_BASE_BLOCK = 128    # Disk 1, fixed
PCM_BASE_BLOCK = 7      # Disk 2, fixed
DISK1_VOLUME_NAME = "TIME.PILOT"
DISK2_VOLUME_NAME = "TIME.PILOT.2"
BUILD_DATETIME = datetime.now()


def prodos_datetime(value):
    """Pack local build time using ProDOS's Y2K date and time fields."""
    full_year = value.year
    year = full_year - 2000 if full_year >= 2000 else full_year - 1900
    if year < 0 or year > 99:
        raise ValueError(f"ProDOS timestamps cannot represent year {full_year}")
    date = ((year & 0x7F) << 9) | ((value.month & 0x0F) << 5) | (value.day & 0x1F)
    time = ((value.hour & 0x1F) << 8) | (value.minute & 0x3F)
    return (date & 0xFF, date >> 8, time & 0xFF, time >> 8)


BUILD_PRODOS_DATETIME = prodos_datetime(BUILD_DATETIME)


class DiskFull(SystemExit):
    pass


class Disk:
    def __init__(self, image, first_free, used):
        self.data = bytearray(image)
        self.used = set(used)
        self.next_free = first_free

    def allocate(self):
        while self.next_free in self.used:
            self.next_free += 1
        if self.next_free >= TOTAL_BLOCKS:
            raise DiskFull("error: disk full")
        b = self.next_free
        self.next_free += 1
        self.used.add(b)
        return b

    def place_blob(self, data, base_block):
        """Copy a blob to a fixed block range, zero-padding the last block."""
        n = (len(data) + BLOCK - 1) // BLOCK
        start = base_block * BLOCK
        self.data[start:start + len(data)] = data
        for i in range(start + len(data), (base_block + n) * BLOCK):
            self.data[i] = 0
        for b in range(base_block, base_block + n):
            self.used.add(b)
        return n

    def write_file(self, name, file_type, aux, data):
        size = len(data)
        if size <= BLOCK:
            st_type = 1
            key_block = self.allocate()
            self.data[key_block * BLOCK:key_block * BLOCK + size] = data
            total_blocks = 1
        else:
            st_type = 2
            key_block = self.allocate()
            idx = bytearray(BLOCK)
            n = (size + BLOCK - 1) // BLOCK
            for i in range(n):
                db = self.allocate()
                chunk = data[i * BLOCK:min(size, (i + 1) * BLOCK)]
                self.data[db * BLOCK:db * BLOCK + len(chunk)] = chunk
                idx[i] = db & 0xFF
                idx[i + 256] = (db >> 8) & 0xFF
            self.data[key_block * BLOCK:(key_block + 1) * BLOCK] = idx
            total_blocks = 1 + n
        return dict(name=name, st_type=st_type, file_type=file_type,
                    key_block=key_block, total_blocks=total_blocks,
                    eof=size, aux=aux)

    def index_fixed_blob(self, name, base_block, num_blocks, size):
        """Build a sapling index over already-placed fixed blocks."""
        idx_block = self.allocate()
        idx = bytearray(BLOCK)
        for i in range(num_blocks):
            db = base_block + i
            idx[i] = db & 0xFF
            idx[i + 256] = (db >> 8) & 0xFF
        self.data[idx_block * BLOCK:(idx_block + 1) * BLOCK] = idx
        return dict(name=name, st_type=2, file_type=0x06,
                    key_block=idx_block, total_blocks=1 + num_blocks,
                    eof=size, aux=0x2000)

    # ---- volume directory (block 2) ----
    def _vol(self):
        return memoryview(self.data)[2 * BLOCK:3 * BLOCK]

    def preserved_entries(self, names):
        vol = self._vol()
        out = []
        for i in range(1, 13):
            off = 4 + i * 39
            if vol[off] == 0:
                continue
            n = vol[off] & 0x0F
            name = bytes(vol[off + 1:off + 1 + n]).decode("ascii", "replace")
            if name in names:
                out.append(bytes(vol[off:off + 39]))
        return out

    def clear_dir_entries(self):
        vol = self._vol()
        for i in range(1, 13):
            for j in range(4 + i * 39, 4 + (i + 1) * 39):
                vol[j] = 0

    def put_raw_entry(self, entry_idx, raw):
        vol = self._vol()
        off = 4 + entry_idx * 39
        vol[off:off + 39] = raw

    def write_dir_entry(self, entry_idx, e):
        vol = self._vol()
        off = 4 + entry_idx * 39
        for j in range(off, off + 39):
            vol[j] = 0
        vol[off] = (e["st_type"] << 4) | (len(e["name"]) & 0x0F)
        for i in range(15):
            vol[off + 1 + i] = ord(e["name"][i]) if i < len(e["name"]) else 0
        vol[off + 0x10] = e["file_type"]
        vol[off + 0x11] = e["key_block"] & 0xFF
        vol[off + 0x12] = (e["key_block"] >> 8) & 0xFF
        vol[off + 0x13] = e["total_blocks"] & 0xFF
        vol[off + 0x14] = (e["total_blocks"] >> 8) & 0xFF
        vol[off + 0x15] = e["eof"] & 0xFF
        vol[off + 0x16] = (e["eof"] >> 8) & 0xFF
        vol[off + 0x17] = (e["eof"] >> 16) & 0xFF
        vol[off + 0x18:off + 0x1C] = bytes(BUILD_PRODOS_DATETIME)
        vol[off + 0x1E] = 0xC3
        vol[off + 0x1F] = e["aux"] & 0xFF
        vol[off + 0x20] = (e["aux"] >> 8) & 0xFF
        vol[off + 0x21:off + 0x25] = bytes(BUILD_PRODOS_DATETIME)
        vol[off + 0x25] = 2          # parent = volume directory block 2
        vol[off + 0x26] = 0

    def set_volume_header(self, name):
        vol = self._vol()
        name_len = min(15, len(name))
        vol[4] = 0xF0 | name_len
        for i in range(15):
            vol[5 + i] = ord(name[i]) if i < name_len else 0
        vol[0x29] = TOTAL_BLOCKS & 0xFF
        vol[0x2A] = (TOTAL_BLOCKS >> 8) & 0xFF

    def set_file_count(self, count):
        vol = self._vol()
        vol[0x25] = count & 0xFF
        vol[0x26] = (count >> 8) & 0xFF

    def mark_bitmap(self):
        """Block 6 holds the volume bitmap: bit set = free, clear = used."""
        base = 6 * BLOCK
        for i in range(35):
            self.data[base + i] = 0xFF
        for i in range(35, BLOCK):
            self.data[base + i] = 0
        for b in self.used:
            self.data[base + (b // 8)] &= ~(1 << (7 - (b % 8))) & 0xFF


def split_bin(raw):
    """Strip the 4-byte ProDOS BIN header, returning (load_addr, code)."""
    return raw[0] | (raw[1] << 8), raw[4:]


def main():
    here = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(here)

    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--src-dir", default=os.path.join(project_root, "src"))
    ap.add_argument("--assets-dir", default=os.path.join(project_root, "assets"))
    ap.add_argument("--build-dir", default=os.path.join(project_root, "build"))
    ap.add_argument("--out-dir", default=os.path.join(project_root, "disks"))
    args = ap.parse_args()

    base_po = os.path.join(args.assets_dir, "140kb.po")
    pcm_path = os.path.join(args.assets_dir, "pcm.blob")
    art_path = os.path.join(args.build_dir, "art.blob")
    sys_path = os.path.join(args.build_dir, "tpilot.sys")
    main_path = os.path.join(args.build_dir, "main.bin")
    main4_path = os.path.join(args.build_dir, "main4.bin")

    for p, what in ((base_po, "base 140KB PO template"),
                    (pcm_path, "PCM audio asset"),
                    (art_path, "art.blob (run tools/mkart.py)"),
                    (sys_path, "compiled tpilot.sys"),
                    (main_path, "compiled main.bin"),
                    (main4_path, "compiled main4.bin")):
        if not os.path.exists(p):
            raise SystemExit(f"error: {what} not found: {p}")

    with open(base_po, "rb") as f:
        base_image = f.read()
    with open(pcm_path, "rb") as f:
        pcm = f.read()
    with open(art_path, "rb") as f:
        art = f.read()
    with open(sys_path, "rb") as f:
        sys_raw = f.read()
    if sys_raw[:4] == b"\x7fELF":
        raise SystemExit("error: tpilot.sys looks like an ELF, not a ProDOS SYS image")
    # mos-apple2-clang emits a 4-byte ProDOS BIN header ($2000 + length).
    # ProDOS SYS (file type $FF) files are loaded directly at $2000 without a header.
    if len(sys_raw) >= 4 and (sys_raw[0] | (sys_raw[1] << 8)) == 0x2000:
        sys_raw = sys_raw[4:]
    with open(main_path, "rb") as f:
        main_load_addr, main_bin = split_bin(f.read())
    with open(main4_path, "rb") as f:
        main4_load_addr, main4_bin = split_bin(f.read())

    os.makedirs(args.out_dir, exist_ok=True)

    # ---------------- Disk 1 ----------------
    print("Building Disk 1: TimePilot-IIvera-D1.po ...")
    # Blocks 0..61 hold the system and PRODOS (and leftover BASIC.SYSTEM data
    # we no longer catalog). TPILOT.SYSTEM is the first *.SYSTEM in the dir.
    d1 = Disk(base_image, first_free=62, used=range(0, 62))
    preserved = d1.preserved_entries(("PRODOS",))
    art_blocks = d1.place_blob(art, ART_BASE_BLOCK)

    f_sys = d1.write_file("TPILOT.SYSTEM", 0xFF, 0x2000, sys_raw)
    f_main = d1.write_file("MAIN.BIN", 0x06, main_load_addr, main_bin)
    f_art = d1.index_fixed_blob("ART", ART_BASE_BLOCK, art_blocks, len(art))

    d1.clear_dir_entries()
    entry_idx = 1
    for raw in preserved:
        d1.put_raw_entry(entry_idx, raw)
        entry_idx += 1
    app_files = [f_sys, f_main, f_art]
    for e in app_files:
        d1.write_dir_entry(entry_idx, e)
        entry_idx += 1

    d1.set_volume_header(DISK1_VOLUME_NAME)
    d1.set_file_count(len(preserved) + len(app_files))
    d1.mark_bitmap()

    out_d1 = os.path.join(args.out_dir, "TimePilot-IIvera-D1.po")
    with open(out_d1, "wb") as f:
        f.write(d1.data)
    print(f"  OK: TimePilot-IIvera-D1.po ({len(d1.used)}/{TOTAL_BLOCKS} blocks "
          f"used, {TOTAL_BLOCKS - len(d1.used)} free)")
    print(f"      TPILOT.SYSTEM ({f_sys['total_blocks']} blk), "
          f"MAIN.BIN ({f_main['total_blocks']} blk), "
          f"ART ({f_art['total_blocks']} blk at block {ART_BASE_BLOCK})")

    # ---------------- Disk 2 ----------------
    print("\nBuilding Disk 2: TimePilot-IIvera-D2.po ...")
    d2 = Disk(base_image, first_free=0, used=range(0, 7))
    d2.clear_dir_entries()
    pcm_blocks = d2.place_blob(pcm, PCM_BASE_BLOCK)
    d2.next_free = PCM_BASE_BLOCK + pcm_blocks

    f_pcm = d2.index_fixed_blob("PCM", PCM_BASE_BLOCK, pcm_blocks, len(pcm))
    f_main4 = d2.write_file("MAIN4.BIN", 0x06, main4_load_addr, main4_bin)

    entry_idx = 1
    for e in (f_pcm, f_main4):
        d2.write_dir_entry(entry_idx, e)
        entry_idx += 1

    d2.set_volume_header(DISK2_VOLUME_NAME)
    d2.set_file_count(2)
    d2.mark_bitmap()

    out_d2 = os.path.join(args.out_dir, "TimePilot-IIvera-D2.po")
    with open(out_d2, "wb") as f:
        f.write(d2.data)
    print(f"  OK: TimePilot-IIvera-D2.po ({len(d2.used)}/{TOTAL_BLOCKS} blocks "
          f"used, {TOTAL_BLOCKS - len(d2.used)} free)")
    print(f"      PCM ({f_pcm['total_blocks']} blk at block {PCM_BASE_BLOCK}), "
          f"MAIN4.BIN ({f_main4['total_blocks']} blk)")
    print("\nDual 140KB floppy disks built successfully!")
    return 0


if __name__ == "__main__":
    sys.exit(main())
