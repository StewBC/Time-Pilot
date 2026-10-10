# TimePilot-IIvera Developer & AI Agent Guide

Comprehensive architecture, memory layout, build system, and engineering guidelines for the Apple IIe / IIgs VERA port of Konami's **Time Pilot** (1982).

---

## 1. Executive Summary & Architecture

Time Pilot for Apple II + VERA (`TimePilot-IIvera`) ports Stefan Wessels' 2024 CX16/IIgs implementation to the 65C02 Apple II architecture equipped with a VERA (Versatile Embedded Retro Adapter) FPGA expansion card (Slot 2 at `$C200` or Slot 4 at `$C400`).

### Key Highlights
* **Zero-Disk Runtime Engine**: All 15 arcade PCM samples (VRAM Bank 0) and 33 sprite arrays (VRAM Bank 1) reside in 128KB dual-bank VRAM after boot. Drive seek latency is 0 during all gameplay.
* **ProDOS SYS Direct Loader (`TPILOT.SYSTEM`)**:
  - Replaces the legacy `BASIC.SYSTEM + STARTUP.BAS` boot chain.
  - ProDOS loads `TPILOT.SYSTEM` directly at `$2000`.
  - The loader probes Slot 2 (`$C200`) and Slot 4 (`$C400`), presents a 40-column hardware status screen on Text Page 1 (`$0400`), and copies a 40-byte loader trampoline to Page 3 (`$0300`).
  - On HDV/file-level installs, the file-read trampoline streams `MAIN.BIN` (or `MAIN4.BIN`) to `$0800` via ProDOS MLI `OPEN`/`READ`/`CLOSE`; a separate block-read trampoline uses `READ_BLOCK` for 140KB floppies and legacy HDVs.
  - **Memory Headroom**: With the old `$9600` HIMEM ceiling removed, program RAM spans `$0800..$B7FF` (45,056 bytes maximum), providing over 10 KB of headroom below the ProDOS MLI buffer at `$B800`.
* **Cross-Platform CMake + Python Pipeline**:
  - Native builds on macOS, Linux, and Windows using CMake 3.20+ and Python 3.8+.
  - Fully self-contained inside `TimePilot-IIvera/` (no external Node.js runtime required).

---

## 2. Memory Map & Layout

### Host RAM (`$0000..$FFFF`)
| Address Range | Allocation | Description |
| :--- | :--- | :--- |
| `$0000–$0001` | Apple II Monitor / Zero Page | Reserved by system hardware |
| `$0002–$0021` | llvm-mos Imaginary Registers | `__rc0` through `__rc31` (32 pseudo-registers) |
| `$0022–$00BE` | Compiler Zero Page Variables | 157 bytes total (`MOS_LTO_ZP=157`) |
| `$00C0–$00FF` | Apple II Monitor / System ZP | Reserved for ROM routines |
| `$0100–$01FF` | 65C02 Hardware Stack | CPU call stack & interrupts |
| `$0200–$02FF` | Apple II Input Buffer | Keyboard strobe buffer / ProDOS vectors |
| `$0300–$03FF` | Loader Trampoline (`loader.s`) | Page-3 MLI `READ` loop and parameter blocks |
| `$0400–$07FF` | Text Page 1 | 40-column text splash screen (persists under VERA display) |
| `$0800–$B7FF` | **Game Binary RAM (`MAIN.BIN`)** | 45,056 bytes capacity; current payload ~34.8 KB |
| `$B800–$B9FF` | ProDOS MLI buffers | 1 KB loader `OPEN` buffer; game uses first 512 B as `diskBuf` |
| `$BA00–$BDFF` | C Runtime Soft Stack | Soft stack growing downward from `$BE00` |
| `$BE00`       | Initial C Soft Stack Pointer | `__stack = 0xBE00` |
| `$BF00–$BFFF` | ProDOS Global Page | MLI entry point (`$BF00`), volume bitmap (`$BF58`), unit table |
| `$C000–$CFFF` | Hardware I/O & Slot ROM | Apple II softswitches, Slot 2 (`$C200`), Slot 4 (`$C400`) |

### VERA 128KB Dual-Bank VRAM
* **Bank 0 (`0x00000–0x1FFFF`)**:
  - `0x00000–0x01FFF`: Layer 0 tilemap (320×240 3-tier parallax background, sky, clouds, asteroids).
  - `0x02000–0x0D7EF`: 15 resident arcade PCM samples (pre-loaded during boot).
  - `0x0D7F0–0x0DBEF`: 4-voice high score ranking BGM VGM loop (`SPEEDUP=1.06`).
  - `0x1F000–0x1F7FF`: 128 hardware sprite attributes (4 registers per sprite).
  - `0x1FA00–0x1FBFF`: 256-color palette (12-bit RGB, dynamic stage palette & propeller cycling).
  - `0x1F9C0–0x1F9FF`: 16-channel stereo PSG hardware registers.
* **Bank 1 (`0x10000–0x1FFFF`)**:
  - `0x10000–0x1DBBF`: Entire 56KB `art.blob` containing 33 sprite arrays (rotations, bosses, projectiles).

---

## 3. Toolchain & Build System

### Requirements
* **CMake**: 3.20 or newer
* **Python**: 3.8 or newer
* **llvm-mos SDK**: `mos-apple2e-clang` target ([llvm-mos-sdk releases](https://github.com/llvm-mos/llvm-mos-sdk/releases))

### Invoking Build
Set `LLVM_MOS_SDK` to the SDK root directory containing `bin/`:
```bash
# Windows
cmake -B build -DLLVM_MOS_SDK=C:/dev/llvm-mos-sdk/install
cmake --build build

# Linux / macOS
cmake -B build -DLLVM_MOS_SDK=/path/to/llvm-mos
cmake --build build
```

### Build Artifacts (`disks/`)
* **`TimePilot-IIvera.hdv`**: 800 KB bootable ProDOS Hard Disk image (volume name `TIME.PILOT`; auto-boots via `TPILOT.SYSTEM` on Drive 1, 2, or n).
* **`TimePilot-IIvera-D1.po`**: 140 KB 5.25" Floppy Disk 1 (volume name `TIME.PILOT`; Boot + `TPILOT.SYSTEM` + `MAIN.BIN` + Sprite Art). For floppy hardware only.
* **`TimePilot-IIvera-D2.po`**: 140 KB 5.25" Floppy Disk 2 (volume name `TIME.PILOT.2`; PCM Audio + `MAIN4.BIN`). Used with D1 in a dual-floppy setup only.

---

## 4. Critical Engineering Gotchas

### 1. ProDOS SYS Header Stripping
* `mos-apple2-clang`'s default linker script emits a 4-byte DOS 3.3 / ProDOS BIN header (`SHORT(0x2000) SHORT(length)`).
* While `BRUN` parses this header for `.BIN` files, ProDOS loads `.SYSTEM` (type `$FF`) files **directly at `$2000`** and jumps straight to `JMP $2000`.
* If the 4-byte header is not stripped by the disk packagers (`build_hdv.py` / `build_disk.py`), the byte at `$2000` is `0x00` (`BRK`), causing an immediate crash to the monitor (`2002- BRK`).
* Both packagers automatically strip the 4-byte header when packaging `TPILOT.SYSTEM`.

### 2. ProDOS MLI Register Volatility
* ProDOS MLI calls (`JSR $BF00`) **do not preserve the X and Y registers**.
* In `src/loader.s`, the loop counter in `X` must be preserved to `$3C9` before calling `JSR $BF00` and restored via `LDX $3C9` afterwards.

### 3. ProDOS Memory Bitmap
* llvm-mos `crt0` marks pages `$20`..`$BF` as allocated in the ProDOS memory bitmap (`$BF58`).
* Before jumping to the Page 3 trampoline, `loader.c` explicitly frees pages `$08` through `$B7` (`bm[1..22] = 0`), allowing the legacy `READ_BLOCK` path to load into `$0800..$B7FF`.

### File-level HDV loading
* HDV installs read `MAIN.BIN`/`MAIN4.BIN`, `ART`, and `PCM` through ProDOS file calls using the active prefix. Their ProDOS block allocation may differ from the packaged HDV.
* `TIME.PILOT` is the game-directory marker. The loader requires it before pathname-loading the game, and `disk.c` checks it before opening named assets.
* `tools/build_hdv.py` renames the HDV volume to `TIME.PILOT`, creates a `TIME.PILOT` marker file in its root, and stamps generated file entries with local build date/time using Y2K year encoding. Preserve the volume header's special structure and date fields when renaming it; ordinary file-entry offsets do not apply to the volume header. File-level installs must copy the marker with the game files (only `PRODOS` is excluded).
* `tools/build_disk.py` names the two floppy volumes `TIME.PILOT` and `TIME.PILOT.2`, and stamps newly generated file entries with local build date/time. The HDV marker file is not needed by the fixed-block floppy loader.
* Do not install the two floppy images as separate hard-disk directories: their assets use fixed block locations and the HDV file loader expects `MAIN.BIN`/`MAIN4.BIN`, `ART`, `PCM`, and `TIME.PILOT` together under one prefix. For hard-disk installation, use `TimePilot-IIvera.hdv` and copy all files except `PRODOS` into one target directory.
* `TPILOT.SYSTEM` loads the game with a Page-3 MLI `READ` trampoline so its own `$2000` code can be overwritten safely. The MLI file is closed before jumping to `$0800`.
* `disk.c` keeps the original fixed-block path for dual 140KB floppy disks and legacy HDV images that cannot open named asset files.
* Current software version is `v1.91`; the loader splash and README must stay in sync.

---

## 5. Repository History & Upstream Parity

* **Upstream Repository**: [StewBC/Time-Pilot](https://github.com/StewBC/Time-Pilot) (Author: Stefan Wessels)
* **Port Origin**: Initiated by `anomixer` (September 2026), officially integrated into upstream `master` in commit `0870564`.
* **Snapshot Branch**: `my-pr-snapshot` preserves the initial squashed PR commit (`9548e85`).
* **Current software version**: `v1.91` (loader splash and README).
* **Previous release**: Tag `v1.8-iivera` on GitHub releases.
