#!/usr/bin/env python3
"""build_hdv.py - Package Time Pilot IIvera into a bootable ProDOS 8 HDV.

Boot chain: ProDOS -> CLOCK.SYSTEM -> TPILOT.SYSTEM -> MAIN.BIN at $0800.

The HDV volume is created with Cadius. PCM and ART are ordinary ProDOS files
read by name during HDV startup; their data blocks can be allocated anywhere.
The separate floppy images retain the legacy fixed-block streaming path.
"""

import argparse
from datetime import datetime
import os
import subprocess
import sys

BLOCK = 512
SYSTEM_RESERVE = 100    # blocks 0..99 belong to ProDOS + system files
KEEP_FILES = ("PRODOS", "CLOCK.SYSTEM")
VOLUME_NAME = "TIME.PILOT"
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


class Allocator:
    """ProDOS block allocator that skips the system-reserved low blocks."""

    def __init__(self, reserved):
        self.used = set(reserved)
        self.newly_allocated = []
        self.next_free = SYSTEM_RESERVE

    def allocate(self):
        while self.next_free in self.used:
            self.next_free += 1
        b = self.next_free
        self.next_free += 1
        self.used.add(b)
        self.newly_allocated.append(b)
        return b


def write_file(disk, alloc, name, file_type, aux, data):
    """Write a ProDOS file: seedling (1 block) or sapling (index + data)."""
    size = len(data)
    if size > 256 * BLOCK:
        raise ValueError(f"{name} exceeds the ProDOS sapling file limit: {size} bytes")
    if size <= BLOCK:
        st_type = 1
        key_block = alloc.allocate()
        disk[key_block * BLOCK:key_block * BLOCK + size] = data
        total_blocks = 1
    else:
        st_type = 2
        key_block = alloc.allocate()
        idx = bytearray(BLOCK)
        n = (size + BLOCK - 1) // BLOCK
        for i in range(n):
            db = alloc.allocate()
            chunk = data[i * BLOCK:min(size, (i + 1) * BLOCK)]
            disk[db * BLOCK:db * BLOCK + len(chunk)] = chunk
            idx[i] = db & 0xFF
            idx[i + 256] = (db >> 8) & 0xFF
        disk[key_block * BLOCK:(key_block + 1) * BLOCK] = idx
        total_blocks = 1 + n
    return dict(name=name, st_type=st_type, file_type=file_type,
                key_block=key_block, total_blocks=total_blocks,
                eof=size, aux=aux)


def write_dir_entry(vol, off, e):
    vol[off] = (e["st_type"] << 4) | (len(e["name"]) & 0x0F)
    for i, ch in enumerate(e["name"]):
        vol[off + 1 + i] = ord(ch)
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


def main():
    here = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(here)

    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--src-dir", default=os.path.join(project_root, "src"))
    ap.add_argument("--assets-dir", default=os.path.join(project_root, "assets"))
    ap.add_argument("--build-dir", default=os.path.join(project_root, "build"))
    ap.add_argument("--out-dir", default=os.path.join(project_root, "disks"))
    ap.add_argument("--out-name", default="TimePilot-IIvera.hdv")
    ap.add_argument("--cadius-path", default=os.path.join(here, "cadius.exe"))
    args = ap.parse_args()

    base_hdv = os.path.join(args.build_dir, "system-base.hdv")
    system_dir = os.path.join(args.assets_dir, "prodos-system")
    prodos_path = os.path.join(system_dir, "PRODOS#FF0000")
    clock_path = os.path.join(system_dir, "CLOCK.SYSTEM#FF0000")
    pcm_path = os.path.join(args.assets_dir, "pcm.blob")
    art_path = os.path.join(args.build_dir, "art.blob")
    sys_path = os.path.join(args.build_dir, "tpilot.sys")
    main_path = os.path.join(args.build_dir, "main.bin")
    main4_path = os.path.join(args.build_dir, "main4.bin")

    for p, what in ((args.cadius_path, "Cadius executable"),
                    (prodos_path, "ProDOS system file"),
                    (clock_path, "CLOCK.SYSTEM file"),
                    (pcm_path, "PCM audio asset"),
                    (art_path, "sprite art asset"),
                    (sys_path, "compiled tpilot.sys"),
                    (main_path, "compiled main.bin")):
        if not os.path.exists(p):
            raise SystemExit(f"error: {what} not found: {p}")

    os.makedirs(args.build_dir, exist_ok=True)
    if os.path.exists(base_hdv):
        os.remove(base_hdv)
    subprocess.run([args.cadius_path, "CREATEVOLUME", base_hdv,
                    VOLUME_NAME, "800KB"], check=True)
    for system_file in (prodos_path, clock_path):
        subprocess.run([args.cadius_path, "ADDFILE", base_hdv,
                        f"/{VOLUME_NAME}", system_file], check=True)

    with open(base_hdv, "rb") as f:
        disk = bytearray(f.read())
    if len(disk) != 1600 * BLOCK:
        raise SystemExit(f"error: Cadius created unexpected HDV size: {len(disk)} bytes")
    with open(pcm_path, "rb") as f:
        pcm = f.read()
    with open(main_path, "rb") as f:
        main_raw = f.read()

    # Strip the 4-byte ProDOS BIN header (load addr LE + length LE).
    # TPILOT.SYSTEM streams the raw payload to $0800; aux_type records that.
    main_bin = main_raw[4:]
    main_load_addr = main_raw[0] | (main_raw[1] << 8)

    reserved = set(range(SYSTEM_RESERVE))
    alloc = Allocator(reserved)

    with open(art_path, "rb") as f:
        art = f.read()

    with open(sys_path, "rb") as f:
        sys_raw = f.read()
    # llvm-mos may write a sibling .elf; the -o path is the raw SYS image.
    if sys_raw[:4] == b"\x7fELF":
        raise SystemExit("error: tpilot.sys looks like an ELF, not a ProDOS SYS image")
    # mos-apple2-clang emits a 4-byte ProDOS BIN header ($2000 + length).
    # ProDOS SYS (file type $FF) files are loaded directly at $2000 without a header.
    if len(sys_raw) >= 4 and (sys_raw[0] | (sys_raw[1] << 8)) == 0x2000:
        sys_raw = sys_raw[4:]

    f_marker = write_file(disk, alloc, "TIME.PILOT", 0x06, 0x2000,
                          b"Time Pilot for Apple II VERA\r\n")
    f_sys = write_file(disk, alloc, "TPILOT.SYSTEM", 0xFF, 0x2000, sys_raw)
    f_main = write_file(disk, alloc, "MAIN.BIN", 0x06, main_load_addr, main_bin)
    print(f"  TPILOT.SYSTEM {len(sys_raw)}B (key={f_sys['key_block']}, "
          f"{f_sys['total_blocks']} blocks)")
    print(f"  MAIN.BIN  {len(main_bin)}B (load=${main_load_addr:X}, "
          f"key={f_main['key_block']}, {f_main['total_blocks']} blocks)")

    app_files = [f_marker, f_sys, f_main]
    if os.path.exists(main4_path):
        with open(main4_path, "rb") as f:
            raw4 = f.read()
        main4_load_addr = raw4[0] | (raw4[1] << 8)
        f_main4 = write_file(disk, alloc, "MAIN4.BIN", 0x06,
                             main4_load_addr, raw4[4:])
        app_files.append(f_main4)
        print(f"  MAIN4.BIN {len(raw4) - 4}B (load=${main4_load_addr:X}, "
              f"key={f_main4['key_block']}, {f_main4['total_blocks']} blocks)")

    data_files = [write_file(disk, alloc, "PCM", 0x06, 0x2000, pcm),
                  write_file(disk, alloc, "ART", 0x06, 0x2000, art)]
    for e in data_files:
        print(f"  {e['name']:<8}  {e['eof']}B ({e['total_blocks']} blocks, "
              f"key={e['key_block']})")

    # ---- Rewrite the root directory (block 2) ----
    vol = memoryview(disk)[2 * BLOCK:3 * BLOCK]
    volume_name = b"TIME.PILOT"
    vol[4] = 0xF0 | len(volume_name)
    vol[5:20] = volume_name.ljust(15, b"\0")
    # Preserve the volume header structure created by Cadius. Generated
    # ordinary file entries are timestamped below.
    keep = []
    for i in range(1, 13):
        off = 4 + i * 39
        if vol[off] == 0:
            continue
        name_len = vol[off] & 0x0F
        name = bytes(vol[off + 1:off + 1 + name_len]).decode("ascii", "replace")
        if name in KEEP_FILES:
            keep.append(bytes(vol[off:off + 39]))
    for i in range(1, 13):
        for j in range(4 + i * 39, 4 + (i + 1) * 39):
            vol[j] = 0

    idx = 1
    for raw in keep:
        vol[4 + idx * 39:4 + idx * 39 + 39] = raw
        idx += 1
    for e in app_files + data_files:
        write_dir_entry(vol, 4 + idx * 39, e)
        idx += 1

    entry_count = len(keep) + len(app_files) + len(data_files)
    vol[0x25] = entry_count & 0xFF
    vol[0x26] = (entry_count >> 8) & 0xFF

    # ---- Mark used blocks in the ProDOS volume bitmap (block 6) ----
    # Bit set = free, bit clear = used.
    def set_used(b):
        disk[6 * BLOCK + (b // 8)] &= ~(1 << (7 - (b % 8))) & 0xFF

    for b in alloc.newly_allocated:
        set_used(b)
    os.makedirs(args.out_dir, exist_ok=True)
    out_path = os.path.join(args.out_dir, args.out_name)
    with open(out_path, "wb") as f:
        f.write(disk)
    print(f"\n  Built {out_path} ({len(disk)} bytes = {len(disk) // 1024} KB)")
    print(f"  Root files: {len(keep)} system + "
          + " + ".join(f["name"] for f in app_files))
    return 0


if __name__ == "__main__":
    sys.exit(main())
