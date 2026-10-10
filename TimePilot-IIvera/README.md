# Time Pilot for Apple IIe (Enhanced) / IIgs + VERA (TimePilot-IIvera)

**Software version: v1.91**

<div align="center">

[English](#english) | [繁體中文](#繁體中文)

</div>

---

<a name="english"></a>
# English

100% authentic, high-fidelity port of Konami's 1982 arcade classic **Time Pilot** for 65C02-based Apple II systems equipped with the **VERA (Versatile Embedded Retro Adapter)** FPGA expansion card.  
Directly adapted from Stefan Wessels' 2024 **TimePilot-CX16** and Apple IIgs versions.

---

## About Time Pilot

Piloting a futuristic fighter across five distinct historical eras, players engage in seamless 360-degree dogfights against era-specific enemy fleets while rescuing marooned parachute pilots drifting across space and time.

* **Fixed Center Screen**: The player plane is locked at the playfield center `(104, 112)`. The sky, clouds, and asteroids scroll smoothly with 3-tier parallax based on the fighter's flight heading.
* **Boss Battles**: Down enough enemy fighters to summon the era's flagship Boss. Destroy the boss to trigger massive multi-stage explosions and a hyperspace **Time Warp** to the next era!

---

## ⚡ Architectural Breakthrough: 100% Zero-Disk Runtime Execution

Traditional Apple II games attempting to play digitized sound effects or stream multi-stage artwork must continuously invoke ProDOS MLI disk routines during gameplay, incurring tens of milliseconds of drive seek latency that causes severe frame stutter, missed keyboard strobes, and audio dropouts.

**TimePilot-IIvera** achieves an uncompromising **100% Zero-Disk Runtime Engine**:
1. **One-Time Boot Streaming (VERA 128KB VRAM as High-Speed SSD)**:
   * During boot, ProDOS MLI reads the `PCM` and `ART` files and streams **53,560 bytes of 15 authentic arcade PCM samples** (game start theme, heavy explosions, parachute rescue, time warp whoosh, bombs, sirens, weapon explosions, gunfire, and missiles) and **56,000 bytes of all-era sprite artwork** directly into VERA's 128 KB dual-bank VRAM (Bank 0 and Bank 1). The 140 KB floppy images retain their dual-drive block-streaming path.
2. **Disk Drive Completely Silent During Entire Play Session**:
   * Once the title screen appears and throughout all active gameplay, **the disk drive goes completely silent and the activity LED remains off**.
   * Dogfights, heavy explosions, multi-squad formation attacks, guided missile tracking, and even inter-era stage transitions (Boss Explosion ➔ Time Warp hyperspace beam) execute with **zero disk reads**.
3. **60 Hz vsync lock**:
   * One-shot PCM is copied from VRAM into VERA's FIFO during blanking. Looping PCM (boss engine drones) is expensive on a 1.02 MHz 6502 and can hitch the frame rate.

---

## Platform Comparison (CX16 vs. Apple IIgs vs. TimePilot-IIvera)

### 1. Hardware Specifications

| Specification | Commander X16 (CX16) | Apple IIgs (Native GS/OS) | Apple IIe (Enhanced) / IIgs + VERA (TimePilot-IIvera) |
| :--- | :--- | :--- | :--- |
| **Host System** | Commander X16 Retro PC | Apple IIgs (16-bit, 1986) | **Enhanced Apple IIe / IIgs / Laser 128**<br>(Requires a 65C02 and 64KB RAM. Apple II+ and non-enhanced IIe are 6502 machines and are **not** supported; the Apple IIc has a 65C02 but no expansion slot for the VERA card.) |
| **CPU** | WDC 65C02S (8-bit) | WDC 65C816 (16-bit) | **WDC 65C02 required (Pure 8-bit challenge)** |
| **Clock Speed** | **8.0 MHz** (High computational budget) | **2.8 MHz** (16-bit instruction set) | **1.02 MHz** (1/8th of CX16 clock speed) |
| **Host RAM** | 512 KB ~ 2 MB Banked RAM | 1.25 MB ~ 8 MB Fast RAM | **64 KB ~ 128 KB Host RAM**<br>(Game image loads at `$0800`, ceiling `$B800` / 45 KB; current build ~33 KB) |
| **Video Chip** | VERA FPGA (Onboard) | Apple IIgs VGC (Video Graphics Controller) | **VERA FPGA Interface Card (Slot 2 or Slot 4)** |
| **Video Memory** | 128 KB VRAM | 32 KB Video RAM (Mirrored) | **128 KB Dual-Bank VRAM** (Card dedicated, 0 host RAM overhead) |
| **Resolution** | 320 × 240 @ 60Hz | 320 × 200 @ 60Hz (Super Hi-Res) | **320 × 240 @ 60Hz** (Full 1:1 arcade aspect ratio) |
| **Hardware Sprites** | 128 hardware sprites | **None** (Software CPU blitting) | **128 hardware sprites** (Zero-flicker FPGA compositing) |
| **Color Palette** | 256 colors (12-bit RGB) | 16 palettes per line (256 colors total) | **256 colors** (12-bit RGB, dynamic stage swap & propeller cycling) |
| **Audio Hardware** | VERA PCM FIFO + YM2151 FM | Ensoniq 5503 DOC (32-oscillator wavetable) | **VERA 16-Channel Stereo PSG (+6dB unison) + 15 Resident PCM Samples** |
| **Storage & Boot** | SD Card (FAT32, PRG) | 3.5" 800KB Disk / 2MG Image | **Bootable ProDOS 800KB HDV** (`TimePilot-IIvera.hdv`) & **Dual 140KB 5.25" Floppies** (`TimePilot-IIvera-D1.po` + `TimePilot-IIvera-D2.po`) |

---

### 2. Game Presentation & Engine Features

| Feature | Commander X16 (CX16) | Apple IIgs (Native GS/OS) | Apple IIe (Enhanced) / IIgs + VERA (TimePilot-IIvera) |
| :--- | :--- | :--- | :--- |
| **Aspect Ratio** | 320 × 240 full field + right status bar | 320 × 200 compressed field | **320 × 240 Arcade Perfect**: Left 28 cols playfield + Right 12 cols pure black status bar |
| **Sprite Engine** | Hardware FPGA sprites | Software blitting (Racing the Beam) | **Hardware FPGA sprites**: 128 zero-flicker sprites, solid 60 FPS at 1.02 MHz |
| **Pre-Game Announce** | Static announce screen | Static announce with Ensoniq music | **Dynamic Flight Announce**: Theme starts with the Stage 1 banner; plane and clouds cruise during intro. First shot can preempt the theme. |
| **Sound System** | Single PCM queue | Ensoniq DOC wavetable | **Dual Hybrid Sound Engine**: 16-channel PSG (+6dB laser, explosion rumble) + 15 PCM samples |
| **Boss Destruction** | Short noise burst | Ensoniq synth explosion | **1.38s Authentic Arcade Heavy PCM Explosion** with 32×16 multi-stage billowing firestorm |
| **Time Warp Effect** | 22-step beam animation | Custom scene transition | **100% CX16 22-Step Hyperspace Beam Animation** + 1.20s PCM warp whoosh + 360° radar sweep |
| **Stage 5 UFO Colors** | Dynamic Cyan & Magenta | Software-rendered sprites | **Arcade-Exact Electric Cyan (`0x00CF`)** with dynamic Magenta (`0x0C0C`) damage alarm flashing |
| **Controls** | Keyboard / CX16 Gamepad | Keyboard / Joystick | **Seamless Dual Input**: Keyboard (WASD/Arrows/Numpad) + Apple II Analog Joystick (PDL0/1) |

---

## Controls

Supports Apple II keyboard and native analog joystick input:

| Input / Key | Action |
| :--- | :--- |
| `W` or `↑` (Up Arrow) | Steer Up (`0`): Single tap sets target; fighter smoothly turns through 32 directions along shortest arc |
| `S` or `X` or `↓` (Down Arrow) | Steer Down (`16`): Both `S` and `X` steer downward |
| `A` or `←` (Left Arrow) | Steer Left (`24`) |
| `D` or `→` (Right Arrow) | Steer Right (`8`) |
| `Q` | Toggle continuous counter-clockwise spin at half the WASD/joystick turn rate. Press `Q` again to stop; `E` reverses. WASD / arrows / joystick cancel the spin. |
| `E` | Toggle continuous clockwise spin. Press `E` again to stop; `Q` reverses. |
| `Space` or `1` | Fire laser cannons / Start 1-Player game (`1-UP`) |
| `2` | Start 2-Player alternating game (`2-UP`) |
| `P` | **Pause Game**: Toggles pause mode (displays red `PAUSED` banner, resumes on `P`/`Space`/fire) |
| `K` | **Toggle Keyboard Mode**: Activates keyboard controls (`[K]EYBOARD` highlighted in green; avoids paddle lag/drift) |
| `J` | **Toggle Joystick Mode**: Activates Apple II analog joystick (`[J]OYSTICK` highlighted in green, **Default**) |
| `I` | **Infinite Lives Cheat Toggle**: Toggles infinite lives practice mode (displays green `INFINITE` on status bar) |
| **Apple II Analog Joystick** | Smooth proportional steering toward stick angle, Button 0/1 (Open/Solid Apple) fires cannons |

---

## Gameplay & Rules

### 1. 360-Degree Parallax Skies
* The player plane remains centered at `(104, 112)`, while the sky and 8 multi-scale background clouds/asteroids drift smoothly with 3-tier parallax scrolling according to flight direction.

### 2. The 5 Historical Eras & Unique Weapons
* **Stage 1: A.D. 1910 (Biplane Era)**
  * **Enemies**: Classic World War I biplanes (16×16, 8-way rotation). Guns plus arcing bombs near the screen edge.
  * **Sky**: Deep Blue (`0x0006`).
  * **Boss**: **Zeppelin / Blimp** (32×16, dual animated propellers, 5 HP).
* **Stage 2: A.D. 1940 (WWII Propeller Era)**
  * **Enemies**: Monoplane WWII fighters (16×16, 8-way rotation).
  * **Sky**: Military Sea-Green (`0x0052`, also used in the 1,472-frame Attract Demo).
  * **Threat**: **Heavy Bomber** flying horizontally across the sky, dropping vertical bombs (`bomb`). Destroying it awards **1,500 bonus points**!
  * **Boss**: **4-Engine Heavy Bomber Flagship** (32×16, 6 HP).
* **Stage 3: A.D. 1970 (Helicopter Era)**
  * **Enemies**: Combat helicopters (16×16, animated rotor, landing skids). Guns plus heat-seeking rockets (`rocket`).
  * **Sky**: Dark Forest Green (`0x0063`).
  * **Boss**: **CH-47 Chinook Twin-Rotor Helicopter** (32×16, dual spinning rotors, 6 HP).
* **Stage 4: A.D. 1982 (Supersonic Jet Era)**
  * **Enemies**: Delta-wing supersonic jet fighters (16×16, 8-way rotation).
  * **Sky**: Dark Dusk Magenta (`0x0505`).
  * **Threat**: Heat-seeking homing tracking rockets (`rocket`) that steer toward the player plane!
  * **Boss**: **B-52 / Supersonic Stealth Bomber** (32×16, 7 HP).
* **Stage 5: A.D. 2001 (Future Space Era)**
  * **Enemies**: Agile flying saucers (16×16 UFO, pulsating energy glow). Space bullets (`sbullet`) plus spinning boomerangs (`boomerang`).
  * **Sky**: Deep Black Space (`0x0000`), filled with floating space asteroids (`astro0/1/2`).
  * **Boss**: **Alien Command Mothership** (32×16, 8 HP). Domes and core render in authentic arcade Cyan (`0x00CF`), pulsating rapidly to Magenta (`0x0C0C`) when damaged below 66% health!

### 3. Dogfight AI & 4-Plane Wave Bonus
* **Lead-Angle Interception**: Enemy squadrons calculate 32-way headings to intercept the player head-on.
* **4-Plane Formation Bonus**: Air raid sirens sound every ~10 seconds as a 4-plane attack wing dives into the arena (`spawn_wave`). Destroy all 4 planes before they break formation to trigger a floating `2000` score popup and earn **2,000 bonus points**!

### 4. Parachute Pilot Rescue
* A drifting parachute pilot sways into the combat zone approximately every 9 seconds in eras 1910–1982.
* Fly into the pilot to rescue him and claim escalating bonus points:
  * 1st Rescue: **1,000 pts** | 2nd Rescue: **2,000 pts** | 3rd Rescue: **3,000 pts** | 4th Rescue: **4,000 pts** | 5th+ Rescue: **5,000 pts**!

### 5. Status Bar & 48-Kill Fleet Progress Bar
* Located in the right 12 columns (`x = 224..320`):
  * **Score Bar**: `HIGH SCORE`, `1-UP`, `2-UP` right-aligned.
  * **Era Marker**: Mini 8×8 era craft icons indicate current stage (1 to 5).
  * **Reserve Fleet**: Player fighter icons represent remaining lives.
  * **Kill Progress Bar**: 6 biplane icons smoothly decrement toward the **48-kill quota**. When depleted, sirens wail and the stage Boss descends!

### 6. Hyperspace Time Warp & Radar Transition
* Defeating the Boss holds the playfield for 3 seconds with explosions still live (no `STAGE CLEAR` banner). Clouds stay. Then a 22-step hyperspace beam uses the current heading, with the 1.20s PCM warp whoosh during the beam. A 360-degree counter-clockwise radar sweep reveals the new era; `AUDIO_NEXT_LEVEL` plays at that sky change (not when wrapping to 1910).

### 7. High Score Ranking Table
* Features a full **7-digit high score display** with the units digit strictly aligned under the `'G'` of `SCORE RANKING TABLE` at **Column 16**, verbatim matching the original Commander X16 (`cx16-1.jpg`) and arcade cabinet layout.

---

## Dual-Engine Sound Architecture

1. **16-Channel Stereo PSG Synthesizer**:
   * **Player Laser (`AUDIO_PLAYER_SHOOT`)**: Channels 0 and 4 in tight unison double acoustic output (+6 dB) with instant 4-frame attack.
   * **Explosion Rumble (`AUDIO_ENEMY_EXPLODE`)**: White noise combined with low-frequency sawtooth shockwave punch.
   * **Game Start Theme (`AUDIO_GAME_START`)**: 4-voice PSG chiptune replaying the full arcade opening theme at 60Hz (435 frames), triggered when Stage 1 banner appears.
   * **High Score BGM (`AUDIO_HIGHSCORE`)**: 4-voice VRAM-resident PSG loop extracted from arcade `name_entry.vgm` (593 events, ~7.72s), streamed at 60Hz directly from VRAM Bank 0 (`$D7F0`) with zero host RAM use; `SPEEDUP=1.06` matches CX16 PCM tempo.
   * **Fanfares & Chords**: Hardware-synthesized extra life fanfares and stage victory chords.
2. **Dual-Bank VRAM Resident 15 Arcade PCM Samples**:
   * **Bank 0 (`$1000..$FBE2`, 60.4 KB)**: `AUDIO_GAME_START` (6.80s opening theme), `AUDIO_BOMB` (0.60s whistle), `AUDIO_PICKUP` (0.72s full rescue melody), and `AUDIO_BIG_EXPLOSION` (1.20s arcade blast). 1,054 bytes safe headroom below `$FFFF`.
   * **Bank 1 (`$1200..$7D3B`, 27.5 KB)**: `AUDIO_COINDROP`, `AUDIO_ROCKET_LAUNCH` (launch only; the fly loop is not started), `AUDIO_WAVE_START`, `AUDIO_BOSSL0..3`, `AUDIO_WAPON_EXPLODE`, `AUDIO_ENEMY_SHOOT`, and `AUDIO_TIMEWARP` (1.20s whoosh). 709 bytes safe headroom before sprite RAM (`$8000`).

---

## Build & Run

Builds on **macOS, Linux and Windows**. A fresh clone builds working disk images with nothing but
the three prerequisites below — the build never reads a file outside `TimePilot-IIvera/`.

### Prerequisites
* **CMake** 3.20 or newer
* **Python** 3.8 or newer
* **llvm-mos SDK** with the `mos-apple2e` platform — [llvm-mos-sdk releases](https://github.com/llvm-mos/llvm-mos-sdk/releases)

### Point the build at the SDK
The only external tool the build needs is the 6502 cross-compiler, located through the
`LLVM_MOS_SDK` environment variable. Set it to the SDK root — the directory containing `bin/`:

```sh
export LLVM_MOS_SDK=/path/to/llvm-mos          # macOS / Linux
```
```bat
set LLVM_MOS_SDK=C:\dev\llvm-mos               :: Windows (cmd)
```
```powershell
$env:LLVM_MOS_SDK = "C:\dev\llvm-mos"          # Windows (PowerShell)
```

Or pass it at configure time instead: `cmake -B build -DLLVM_MOS_SDK=/path/to/llvm-mos`

### Build
From the `TimePilot-IIvera/` directory, identically on all three platforms:
```sh
cmake -B build
cmake --build build
```

Build pipeline:
1. `tools/mkart.py`: packs the sprite art in `src/art.h` into `art.blob` and regenerates `src/art_table.h`.
2. `mos-apple2e-clang`: compiles `MAIN.BIN` (Slot 2, `VERA_BASE=0xC200`), `MAIN4.BIN` (Slot 4, `VERA_BASE=0xC400`), and `TPILOT.SYSTEM` (ProDOS SYS loader) with `-Oz`.
3. `tools/check_size.py`: verifies the game image stays below `$B800`.
4. `tools/build_hdv.py`: packages the 800 KB ProDOS bootable image `disks/TimePilot-IIvera.hdv` (using authentic 4-voice PSG hardware synthesis for the opening theme, saving 45KB of VRAM and 89 disk blocks).
5. `tools/build_disk.py`: packages the dual 140 KB 5.25" floppies `disks/TimePilot-IIvera-D1.po` (Boot + Slot 2 Binary + Art) and `disks/TimePilot-IIvera-D2.po` (PCM Audio + Slot 4 Binary).

Disk images land in `disks/` and are not committed — rebuild them from a clean clone at any time.

### Memory ceiling check
`TPILOT.SYSTEM` (not BASIC.SYSTEM / BRUN) loads the game at `$0800`. BASIC.SYSTEM is not
resident, so the old `$9600` HIMEM ceiling is gone. The load image must stay below `$B800`:

| region | use |
| --- | --- |
| `$0800–$B7FF` | game load image (45,056 bytes max) |
| `$B800–$B9FF` | 512-byte MLI disk window (`diskBuf`) |
| `$BA00–$BDFF` | C stack, growing down from `$BE00` |
| `$BF00–$BFFF` | ProDOS global page |

Every build runs `tools/check_size.py` and reports the range:

```
main.bin      33066 bytes  $0800..$892A  ceiling $B800  headroom 11990  [OK]
```

**Generated code size depends on the llvm-mos version.** A newer SDK can grow the binary with no
source change. If you see `[OVER]`, the images will build but are not safe to run — the payload
would collide with the MLI window. Configure with `-DTPV_STRICT_SIZE=ON` to make an overflow a
hard build failure.

### Editor support
Configuring writes `compile_flags.txt` with the include paths resolved for *your* machine, so
clangd works without hand-editing. It is git-ignored precisely because it holds absolute local paths.

### Project layout
| Path | Contents |
| --- | --- |
| `src/` | C and 6502 sources, headers, `TPILOT.SYSTEM` loader (`loader.c` / `loader.s`) |
| `assets/` | ProDOS templates (`800kb.hdv`, `140kb.po`) and the converted `pcm.blob` |
| `tools/` | Build-time tools, driven by CMake |
| `tools/offline/` | One-time asset conversions, run by hand — never during a build |
| `disks/` | Built disk images (git-ignored) |

### Offline conversion tools
`tools/offline/` holds the one-time conversions that produced the committed assets. They are **not**
part of the build; a normal build never runs them. Some reach outside this folder or need inputs
that are not in this repository, which is exactly why their outputs are committed instead.

| Tool | Produces | Status |
| --- | --- | --- |
| `mkpcm_blob.mjs` | `assets/pcm.blob`, `src/audio_table.h` | Needs Node.js, the CX16 `.pcm` sources and `name_entry.vgm` |
| `gen_psg_highscore.mjs` | high-score PSG table (folded into `pcm.blob`) | Needs `name_entry.vgm`, which is not in this repository |
| `gen_psg_theme.mjs` | `src/theme_psg.h` | Source URL now returns HTTP 410; the generated header is committed |
| `extract_cx16_sprites.py` | `src/art.h` | Needs the CX16 sprite PNGs and palette |
| `make_font.py` | `src/font8x8.h` | Needs the CX16 font PNG |

### Running in Emulator or Real Hardware
Boot chain: ProDOS → (HDV: `CLOCK.SYSTEM`) → `TPILOT.SYSTEM` (VERA slot detect + splash on text page 1) → `MAIN.BIN` / `MAIN4.BIN` at `$0800`.
* **800KB Hard Disk Mode**: Load `TimePilot-IIvera.hdv` into **Apple2TS** or any Apple II emulator/storage controller (CFFA3000, FujiNet, wDrive).
* **Dual 140KB 5.25" Floppy Mode (floppy hardware only)**: Mount `TimePilot-IIvera-D1.po` (`TIME.PILOT`) into Drive 1 and `TimePilot-IIvera-D2.po` (`TIME.PILOT.2`) into Drive 2; boot Drive 1. The game auto-detects floppy mode, streams art from Drive 1 and audio from Drive 2 seamlessly. Newly generated file entries on both disks receive local build timestamps. **For hard-disk installation, use the HDV version below; the two floppy images are not a hard-disk install.**

### File-level installation
The HDV is built with the ProDOS volume name `TIME.PILOT`. Newly generated game file entries receive the local build date and time; the volume header retains its ProDOS metadata. For a file-level hard-disk install, use this HDV version: copy all files from `disks/TimePilot-IIvera.hdv` into your target ProDOS volume or directory, except `PRODOS`. Keep the `TIME.PILOT` marker file in the game directory; the loader checks it before reading game files. Set the ProDOS prefix to that location and launch `TPILOT.SYSTEM`. The loader and game read `MAIN.BIN`/`MAIN4.BIN`, `ART`, and `PCM` by filename, so their disk block allocation can differ from the HDV image. The dual-floppy images use fixed-block loading and are only for dual-floppy environments.

雙軟碟版只適用於雙軟碟機環境：D1 volume name 為 `TIME.PILOT`，D2 為 `TIME.PILOT.2`，新產生的檔案項目會寫入本機建置時間。要安裝到硬碟，請使用 HDV 版本，不要把兩張軟碟分別複製成兩個硬碟目錄。HDV 製作時會將 ProDOS volume name 設為 `TIME.PILOT`，並為新產生的遊戲檔案項目寫入本機建置日期與時間；volume header 的 ProDOS 中繼資料會保留原樣。檔案式安裝時，將 `disks/TimePilot-IIvera.hdv` 內所有檔案複製到同一個目標 ProDOS volume 或目錄，唯獨 `PRODOS` 不需複製。請保留遊戲目錄中的 `TIME.PILOT` 標記檔；啟動器會先確認此檔，再讀取遊戲檔案。將 ProDOS prefix 設為該位置，再執行 `TPILOT.SYSTEM`。啟動器與遊戲會依檔名讀取 `MAIN.BIN`／`MAIN4.BIN`、`ART` 和 `PCM`，不依賴它們在 HDV 中的磁區配置。

---

<a name="繁體中文"></a>
# 繁體中文

1982 Konami 街機經典《Time Pilot》（時空領航員）65C02 架構 Apple II 系列 + VERA 擴充卡 100% 原版規格高傳真移植版。  
本專案直接繼承與改編自 Stefan Wessels 於 2024 年發布之 **TimePilot-CX16** 與 Apple IIgs 版本。

**軟體版本：v1.91**

---

## 遊戲簡介 (About Time Pilot)

玩家駕駛一架超越時代的未來戰鬥機，穿梭於五個不同的歷史時空，在 360 度全向無邊界的天空中與各時代的敵機展開空中纏鬥，同時救援漂流在各個時空的受困跳傘飛行員。

* 戰機始終位於螢幕正中央 `(104, 112)`，背景天空與大小雲層／太空隕石隨戰機航向產生流暢的 3 階視差捲動。
* 擊墜足夠數量的敵機後，該時代的巨型母艦（Boss）將會登場。擊毀母艦後引發巨型連環爆炸，並以超空間 **Time Warp** 躍遷至下一個時空！

---

## ⚡ 核心技術突破：運行中 100% 零磁碟 I/O (100% Zero-Disk Runtime Engine)

傳統 Apple II 遊戲若要在遊玩時播放豐富的語音或長取樣音效，CPU 必須頻繁調用 ProDOS MLI 讀取軟碟或硬碟，磁區尋道與傳輸動輒耗費數十毫秒，往往導致嚴重的畫面卡頓、按鍵漏判定或音效斷音。

本移植版在架構上實現了突破性的創新設計：
1. **開機一次載入，VRAM 充當超高速板載 SSD**：
   * 開機引導階段透過 ProDOS MLI 直讀，一口氣將 **87,837 位元組（172 個磁區）的 15 首街機 PCM 取樣**（包含開場音樂、重低音大爆炸、跳傘員救援、時空躍遷 Time Warp 穿梭音、機槍掃射、攔截爆破等）與 **56,640 位元組（111 個磁區）的全時代精靈圖庫**，直接寫入 VERA 擴充卡的 128 KB 獨立雙 Bank 記憶體（Bank 0 與 Bank 1）。
2. **戰鬥與換關全程零讀碟（Disk Drive Completely Silent）**：
   * 進入標題畫面與遊戲戰鬥後，**磁碟機完全靜音、讀取指示燈全程熄滅**！
   * 無論是激烈的空戰纏鬥、重低音大爆炸、飛彈發射、甚至是擊敗 Boss 後的「大爆炸 ➔ Time Warp 躍遷光束」與跨時代換關，**中途 100% 不讀取任何一個磁區**！
3. **鎖定 60Hz vsync**：
   * 一次性 PCM 在消隱期間由 VRAM 送入 VERA FIFO。循環 PCM（Boss 引擎聲）在 1.02 MHz 6502 上很重，可能拖慢幀率。

---

## 三大平台版本差異對照表 (Platform Comparison: CX16 vs. IIgs vs. IIvera)

### 1. 硬體規格與系統架構對照 (Hardware Specifications)

| 規格維度 | Commander X16 (CX16) | Apple IIgs (GS/OS 原生) | Apple IIe (增強型) / IIgs + VERA (TimePilot-IIvera) |
| :--- | :--- | :--- | :--- |
| **主機平台** | Commander X16 現代復古電腦 | Apple IIgs (1986) 16 位元個人電腦 | **增強型 Apple IIe / IIgs / Laser 128**<br>(需 65C02 處理器與 64KB RAM。Apple II+ 與非增強型 IIe 為 6502 機種，**不支援**；Apple IIc 雖為 65C02，但無擴充槽可安裝 VERA 卡。) |
| **CPU 處理器** | WDC 65C02S (8-bit) | WDC 65C816 (16-bit) | **需 WDC 65C02 (純 8-bit 極限挑戰)** |
| **運作時脈** | **8.0 MHz** (算力極度充裕) | **2.8 MHz** (16 位元指令集) | **1.02 MHz** (算力僅 CX16 的 1/8) |
| **主機 RAM 記憶體** | 512 KB ~ 2 MB (Banked RAM) | 1.25 MB ~ 8 MB Fast RAM | **主機僅 64 KB ~ 128 KB**<br>遊戲映像載入於 `$0800`，上限 `$B800`（45 KB）；目前約 33 KB |
| **圖形顯示晶片** | VERA FPGA (主機板內建) | Apple IIgs VGC (Video Graphics Controller) | **VERA FPGA 介面卡 (外接於 Slot 2 或 Slot 4)** |
| **獨立視訊記憶體** | 128 KB VRAM | 32 KB Video RAM (映照於 Fast RAM) | **128 KB VRAM** (擴充卡專屬，不耗主機 RAM) |
| **原生解析度** | 320 × 240 @ 60Hz | 320 × 200 @ 60Hz (Super Hi-Res) | **320 × 240 @ 60Hz** (全畫面 1:1 滿版輸出) |
| **精靈硬體支援** | 128 個硬體精靈 (FPGA 自動合成) | **無硬體精靈**<br>(需由 65816 CPU 軟體即時擦除與繪製) | **128 個硬體精靈** (FPGA 零撕裂硬體合成) |
| **色盤能力 (Palette)** | 256 色 (12-bit RGB，4096 色選 256) | 16 個調色盤 (每掃描線 16 色，共 256 色) | **256 色** (12-bit RGB，支援動態換關、螺旋槳輪色與母艦青藍/洋紅警報) |
| **音效硬體架構** | VERA PCM FIFO (單聲道) + YM2151 FM | Ensoniq 5503 DOC (32 振盪器波表晶片) | **VERA 16 通道立體聲 PSG (雙聲道齊奏 +6dB) + 雙 Bank VRAM 常駐 15 首 PCM 音效** |
| **儲存媒介與格式** | SD 卡 (FAT32 檔案系統，PRG 載入) | 3.5 吋 800KB 磁碟 / 2MG 映像檔 | **標準 ProDOS 800KB HDV** (`TimePilot-IIvera.hdv`) 與 **雙 140KB 5.25" 軟碟** (`TimePilot-IIvera-D1.po` + `TimePilot-IIvera-D2.po`) |

---

### 2. 遊戲呈現狀態與核心機制差異 (Game Presentation & Engine Features)

| 遊戲呈現維度 | Commander X16 (CX16) | Apple IIgs (GS/OS 原生) | Apple IIe (增強型) / IIgs + VERA (TimePilot-IIvera) |
| :--- | :--- | :--- | :--- |
| **垂直視野與版面** | 320 × 240 完整視野 (40×30 比例)<br>右側黑底狀態列 | 320 × 200 壓縮視野 (垂直少 40 像素)<br>右側黑底狀態列 | **320 × 240 完美街機比例**<br>左側 28 欄戰場 + 右側 12 欄純黑狀態列 (T256C=0) |
| **精靈繪製技術** | FPGA 硬體精靈合成，無畫面閃爍 | 純 CPU 軟體貼圖 (Mr Sprite 產生之 65816 碼)<br>需靠 **Racing the Beam** 追光束防撕裂 | **FPGA 硬體精靈合成**，128 個精靈無閃爍撕裂，1.02MHz 即可滿幀 60 FPS 運行 |
| **開局宣告體驗** | 靜態宣告畫面，開場曲 7.13 秒 | 靜態宣告畫面，播放 Ensoniq 波表合成音樂 | **動態巡航宣告畫面**：開場曲於 Stage 1 宣告時開始，宣告期間戰機與雲朵即時巡航；開火可打斷主題曲 |
| **開場主題曲規格** | 7.13 秒 (CX16 原裝取樣，旋律自然淡出收尾) | Ensoniq DOC 晶片重製版 | 4 聲道 PSG 開場曲，於 Stage 1 宣告時開始；不強制播完 |
| **多音軌音效架構** | 單軌 PCM 優先權互斥佇列 | Ensoniq DOC 專屬多聲道波表合成 | **極限複合雙音效引擎**：<br>1. **PSG 雙聲道疊加齊奏 (+6dB)**：雷射、爆破、敵彈、凱旋和弦多聲道並行！<br>2. **雙 Bank 常駐 15 首 PCM**：開場曲、大爆炸、跳傘員救援、投幣、炸彈、飛彈、敵機機槍、攔截爆破、時空躍遷與四大 Boss 警報無縫串流！ |
| **玩家爆炸震撼度** | 單軌 PCM 短雜音爆破 | Ensoniq 爆炸波表合成音效 | **真·1.38 秒正宗大型電玩重低音 PCM 爆炸**<br>伴隨 32×16 烈焰連環爆破與破片黑煙，PSG 背景音效依然並行不悖！ |
| **過關躍遷特效** | 22 步白光曲速光束 (Time Warp)<br>戰機置中閃爍跳躍後縮為單點 | 專屬過關過場動畫 | **100% 完整還原 CX16 22 步曲速光束字型動畫**<br>白光聚能膨脹 + 戰機高頻閃爍 + 1.20s PCM 穿梭音 + 360° 雷達掃描換關 |
| **關卡過渡音樂** | 換關重複觸發開場 PCM 主題曲 | 原生過關轉場音效 | **`AUDIO_NEXT_LEVEL` 在天空切換時播放**（不在橫幅上；繞回 1910 時不播）。開場曲僅在首局宣告觸發 |
| **巨大 Boss 呈現** | 32 × 16 巨大首領機陣容<br>(Blimp/Bomber/Chinook/B-52/Mothership) | 32 × 16 巨大首領機 (65816 軟體繪製) | **正版 32 × 16 巨大首領機**，具備左右航向、4 階漸進中彈受創冒煙、第五關外星母艦正宗電光青藍 (Cyan) 原色與受創洋紅警報閃爍！ |
| **操作輸入支援** | 鍵盤 / CX16 遊戲手把 (數位 D-Pad) | 鍵盤 (Option/Apple) / 類比搖桿 | **雙模式無縫切換**：<br>1. 鍵盤（WASD / 方向鍵 / 數字鍵盤）<br>2. **Apple II 原生硬體放電類比搖桿 (PDL0/1)** 平滑 32 方位導向 |

---

## 操作說明 (Controls)

本遊戲支援 Apple II 鍵盤與原生類比搖桿即時輸入：

| 按鍵 / 控制器 | 功能說明 |
| :--- | :--- |
| `W` 或 `↑` (Up Arrow) | **朝上轉向 (`0`)**：單按一次設定目標，戰機沿最短路徑平滑經歷 32 向旋轉到位 |
| `S` 或 `X` 或 `↓` (Down Arrow) | **朝下轉向 (`16`)**：`S` 與 `X` 皆為朝下方向 |
| `A` 或 `←` (Left Arrow) | **朝左轉向 (`24`)** |
| `D` 或 `→` (Right Arrow) | **朝右轉向 (`8`)** |
| `Q` | **切換逆時針持續旋轉**（速率為 WASD／搖桿的一半）。再按 `Q` 停止；按 `E` 反向。WASD／方向鍵／搖桿會取消旋轉。 |
| `E` | **切換順時針持續旋轉**。再按 `E` 停止；按 `Q` 反向。 |
| `Space` (空白鍵) 或 `1` | 雷射機砲發射 / 標題畫面啟動單人遊戲 (1-UP) |
| `2` | 標題畫面啟動雙人輪流遊戲 (2-UP) |
| `P` | **暫停遊戲 (Pause)**：即時凍結戰局（畫面中央紅字 `PAUSED`，按 `P`/`Space`/搖桿開火鍵解除） |
| `K` | **切換鍵盤控制**：啟用純鍵盤模式（標題畫面 `[K]EYBOARD` 綠色高亮，完全避免未接搖桿浮動飄移與 CPU 延遲） |
| `J` | **切換搖桿控制**：啟用 Apple II 類比搖桿模式（**預設啟用**，標題畫面 `[J]OYSTICK` 綠色高亮，鍵盤仍可隨時操作） |
| `I` | **密技開關**：切換無限生命練習模式（狀態列顯示綠色 `INFINITE`） |
| **Apple II 類比搖桿** | 8 向推桿即時向目標角度平滑旋轉，Button 0/1（Open/Solid Apple）發射機砲與開始遊戲 |

---

## 核心玩法與遊戲規則 (Gameplay & Rules)

### 1. 360 度視差飛行世界 (Parallax Skies)
* 玩家戰機固定於螢幕中央 `(104, 112)`，世界背景與 8 朵大小雲層（小雲 16×16、中雲 32×16、大雲 64×16）依照戰機航向產生 3 階視差滑動。
* 戰機轉向時，世界與雲層平滑改變飄移方向，帶來無邊界全方位翱翔的真實沉浸感。

### 2. 五大歷史時代與時代專屬武器 (The 5 Eras & Era Weapons)
* **第一關：A.D. 1910（雙翼機時代）**
  * **敵機**：一戰經典雙翼教練機（16×16，雙層機翼與尾翼，8 向旋轉），機槍加上近螢幕邊緣的拋物線炸彈。
  * **天空**：蔚藍深空（Deep Blue，`0x0006`）。
  * **Boss**：**齊柏林巨型飛艇（Zeppelin / Blimp）**（長度達 32 像素，前後動態螺旋槳旋轉，HP 5）。
* **第二關：A.D. 1940（二戰螺旋槳時代）**
  * **敵機**：二戰單翼戰鬥機（16×16，8 向旋轉）。
  * **天空**：軍武深綠（Dark Green，`0x0052`，**Attract Demo 示範模式亦為此關**）。
  * **專屬威脅**：**四引擎重型轟炸機（Heavy Bomber）** 橫穿空域，沿途垂直空投毀滅炸彈（`bomb`）！擊落轟炸機可獲得 1,500 分獎勵！
  * **Boss**：**二戰四發重型轟炸機首領**（32×16，HP 6）。
* **第三關：A.D. 1970（直升機時代）**
  * **敵機**：武裝直升機（16×16，正宗 9 向旋轉機身、動態主旋翼與著陸滑橇）。機槍加上熱追蹤飛彈（`rocket`）。
  * **天空**：翡翠深綠（Forest Green，`0x0063`）。
  * **Boss**：**CH-47 雙旋翼巨型直升機（Chinook Helicopter）**（32×16，前後雙旋翼高速旋轉，HP 6）。
* **第四關：A.D. 1982（超音速噴射機時代）**
  * **敵機**：三角翼超音速噴射戰機（16×16，8 向旋轉）。
  * **天空**：暗紅暮色（Dark Red / Magenta，`0x0505`）。
  * **專屬威脅**：敵機發射**紅外線熱追蹤導向飛彈（`rocket`）**，飛彈會在飛行中依玩家航道自動修正追蹤軌跡！
  * **Boss**：**超音速隱形戰略轟炸機（B-52 / Supersonic Bomber）**（32×16，HP 7）。
* **第五關：A.D. 2001（未來太空時代）**
  * **背景**：漆黑深邃太空（Deep Black Space，`0x0000`，漂浮著大小不一的太空隕石取代雲層）。
  * **敵機**：敏捷的外星飛碟（16×16 UFO，4 影格能量光環持續頻閃）。能量彈（`sbullet`）加上旋轉迴力鏢（`boomerang`）。
  * **Boss**：**外星指揮太空母艦（Alien Command Mothership）**（32×16，HP 8）。座艙罩與燈條還原 1982 街機電光青藍色（Cyan，`0x00CF`）；受創低於 66% 時在青藍與洋紅（Magenta，`0x0C0C`）之間高速閃爍警報！

### 3. 空戰纏鬥獵殺 AI 與 4 機編隊突襲 (Dogfight AI & Wave Bonus)
* **航向預判迎頭攔截**：敵機依照 32 向周界演算法，永遠生成於玩家戰機正前方航道，迎頭包抄壓迫。
* **動態迴旋咬尾**：敵機具備主動發動機推力，並依據夾角以最短弧度（順/逆時針）動態壓機側轉咬住玩家機尾。
* **編隊突襲與 2,000 分波次獎勵**：每約 10 秒防空警報響起，前方大軍壓境發動 4 機俯衝突襲編隊（`spawn_wave`）。若玩家在編隊散開前**全數將 4 架敵機擊落**，在最後一架爆炸處立即觸發浮動 `2000` 獎勵特效並獲得 **2,000 分**！

### 4. 跳傘飛行員救援系統 (Parachute Rescue)
* 在 1910～1982 關卡中，每約 9 秒會有一名跳傘飛行員（4 影格搖曳動畫）由上方隨風飄落。
* 駕駛戰機碰觸飛行員即可成功救援，獲得階梯遞增獎勵：
  * **第 1 次救援**：1,000 分 | **第 2 次救援**：2,000 分 | **第 3 次救援**：3,000 分 | **第 4 次救援**：4,000 分 | **第 5 次及以上**：**5,000 分**！

### 5. 右側狀態欄與 48 架擊墜進度隊列 (Status Bar & Stage Fleet Progress)
狀態欄設於畫面右側 12 欄（`x = 224..320`，純黑邊欄）：
* **頂部計分欄**：`HIGH SCORE`、`1-UP`、`2-UP` 分數均向右靠齊。
* **時代關卡圖標**：右側邊緣以 8×8 微型戰機精靈即時標示當前關卡數（1 到 5 架小飛機由右至左整齊排列）。
* **備用戰機**：右下方整齊排列白色噴射戰機精靈，即時反映剩餘備用命數。
* **擊墜進度敵機隊列**：底部排列 6 架扁平雙翼機圖標。關卡總擊墜門檻為 **48 架敵機**，每擊落 1 架敵機即平滑切削消減；當 6 架進度機全數消失時，空襲警報響起，巨型母艦 Boss 進場決戰！

### 6. 時空躍遷超空間光束 (Time Warp) 與 360 度雷達轉場
* **擊落母艦後停留 3 秒**：爆炸仍在進行，沒有 `STAGE CLEAR` 橫幅；雲層留在場上。
* **22 步動態超空間曲速光束與 1.2 秒正宗街機 PCM**：光束使用當前航向；Time Warp PCM 在光束期間播放。戰機在光柱核心高速頻閃後，光束凝聚塌縮。
* **360 度逆時針雷達轉場**：以戰機為軸心掃描切換至新時代天空；`AUDIO_NEXT_LEVEL` 在天空切換時播放（繞回 1910 時不播）。

### 7. 雙人輪流遊玩模式與 7 位數高分榜簽名 (2-Player & 7-Digit High Scores)
* **2-Player 模式**：標題按 `2` 啟動，獨立記錄雙方分數、命數、時代、擊墜數，陣亡時自動換人接續戰鬥。
* **獨立高分簽名佇列**：若 1P 與 2P 雙雙名列前五名，兩人將依序獲得 30 秒專屬簽名資格，支援鍵盤與搖桿選字填入。
* **7 位數高分榜與精準對齊**：排行榜支援高達 7 位數分數顯示，個位數精準向右對齊於 `SCORE RANKING TABLE` 標題之 `'G'`（Column 16），絕不截斷十萬位數以上高分，100% 忠實呈現 1982 大型電玩與 CX16 原版視覺排版。

---

## 複合式雙音效引擎 (Dual-Engine Audio)

* **VERA 16 通道立體聲 PSG 晶片合成（雙聲道齊奏 +6dB 爆發力）**：
  * **玩家雷射機砲 (`AUDIO_PLAYER_SHOOT`)**：結合 Channel 0（50% 方波）與 Channel 4（25% 方波微調）雙聲道同度齊奏，輸出聲能直接翻倍（+6 dB），槍聲乾脆紮實！
  * **小兵爆炸破片 (`AUDIO_ENEMY_EXPLODE`)**：結合 Channel 2（白噪音急速降頻）與 Channel 5（鋸齒波低頻重低音震波），打擊感拳拳到肉！
  * **遊戲開場主題曲 (`AUDIO_GAME_START`)**：4 聲道 PSG 即時演奏，於 Stage 1 宣告畫面出現時觸發，以 60Hz 流暢重現完整 435 幀街機開場曲。
  * **高分榜簽名 BGM (`AUDIO_HIGHSCORE`)**：自街機 `name_entry.vgm` 提取 593 個 AY-3-8910 事件（~7.72 秒），以 `SPEEDUP=1.06` 校準至 CX16 速度，直接從 VRAM Bank 0 `$D7F0` 以 60Hz 串流播放，完全不佔主機 RAM；輸入完成後立即靜音。
  * **敵彈啾啾聲、獎勵加命三連音、關卡凱旋和弦**：多聲道硬體獨立合成，毫無延遲，擊落再多敵機也絕不卡音！
* **雙 Bank VRAM 常駐 15 首街機 PCM 音訊（100% 零磁碟運行串流）**：
  * **Bank 0 (`$1000..$FBE2`, 60.4 KB)**：開場主題曲 (`AUDIO_GAME_START`, 6.80 秒完整尾韻無死音)、二戰轟炸機空投航彈呼嘯 (`AUDIO_BOMB`, 0.60 秒)、跳傘飛行員救援音效 (`AUDIO_PICKUP`, 0.72 秒完整 9 段多音調旋律) 與重低音大爆炸 (`AUDIO_BIG_EXPLOSION`, 1.20 秒正宗震撼爆炸)，保有 1,054 位元組安全緩衝防禦暫存器邊界。
  * **Bank 1 (`$1200..$7D3B`, 27.5 KB)**：投幣音效 (`AUDIO_COINDROP`)、飛彈點火 (`AUDIO_ROCKET_LAUNCH`，不播放巡航循環)、四機突襲警報 (`AUDIO_WAVE_START`)、四大關卡 Boss 巨型母艦專屬警報 (`AUDIO_BOSSL0 ~ 3`)、攔截爆炸 (`AUDIO_WAPON_EXPLODE`)、敵機機槍 (`AUDIO_ENEMY_SHOOT`)、以及**時空躍遷穿梭 PCM (`AUDIO_TIMEWARP`, 1.20 秒正宗原音)**，保有 709 位元組安全緩衝防禦精靈 RAM。

---

## 編譯與執行 (Build & Run)

支援 **macOS、Linux 與 Windows** 三大平台。全新 clone 後，只需下列三項工具即可建置出可用的磁碟映像檔；
建置過程不會讀取 `TimePilot-IIvera/` 以外的任何檔案。

### 開發環境需求
* **CMake** 3.20 以上
* **Python** 3.8 以上
* **llvm-mos SDK**（目標架構 `mos-apple2e`）— [llvm-mos-sdk 下載頁](https://github.com/llvm-mos/llvm-mos-sdk/releases)

### 指定 SDK 路徑
建置過程唯一需要的外部工具是 6502 交叉編譯器，透過 `LLVM_MOS_SDK` 環境變數尋找。
請將其設為 SDK 根目錄（即包含 `bin/` 的那層目錄）：

```sh
export LLVM_MOS_SDK=/path/to/llvm-mos          # macOS / Linux
```
```bat
set LLVM_MOS_SDK=C:\dev\llvm-mos               :: Windows (cmd)
```
```powershell
$env:LLVM_MOS_SDK = "C:\dev\llvm-mos"          # Windows (PowerShell)
```

亦可於設定階段直接指定：`cmake -B build -DLLVM_MOS_SDK=/path/to/llvm-mos`

### 建置
在 `TimePilot-IIvera/` 目錄下執行，三大平台指令完全相同：
```sh
cmake -B build
cmake --build build
```

建置流程：
1. `tools/mkart.py`：將 `src/art.h` 的精靈圖檔打包為 `art.blob`，並重新產生 `src/art_table.h`。
2. `mos-apple2e-clang`：以 `-Oz` 極限優化編譯 `MAIN.BIN`（Slot 2，`VERA_BASE=0xC200`）、`MAIN4.BIN`（Slot 4，`VERA_BASE=0xC400`）與 `TPILOT.SYSTEM`（ProDOS SYS 載入程式）。
3. `tools/check_size.py`：確認遊戲映像未超過 `$B800`。
4. `tools/build_hdv.py`：生成 800 KB ProDOS 開機硬碟映像檔 `disks/TimePilot-IIvera.hdv`（採用 4 聲道硬體 PSG 即時演奏遊戲開頭音樂，節省 45KB VRAM 與 89 個磁區空間）。
5. `tools/build_disk.py`：生成兩張 140 KB 5.25" 軟碟 `disks/TimePilot-IIvera-D1.po`（開機引導 + Slot 2 主程式 + 圖形）與 `disks/TimePilot-IIvera-D2.po`（PCM 音效庫 + Slot 4 主程式）。

磁碟映像檔輸出至 `disks/`，不納入版本控制；隨時皆可從乾淨的 clone 重新建置。

### 記憶體上限檢查
由 `TPILOT.SYSTEM`（而非 BASIC.SYSTEM / BRUN）將遊戲載入至 `$0800`。BASIC.SYSTEM 不再常駐，
舊的 `$9600` HIMEM 上限已取消。載入映像必須停在 `$B800` 以下：

| 區段 | 用途 |
| --- | --- |
| `$0800–$B7FF` | 遊戲載入映像（最大 45,056 位元組） |
| `$B800–$B9FF` | 512 位元組 MLI 磁碟視窗（`diskBuf`） |
| `$BA00–$BDFF` | C 堆疊，由 `$BE00` 向下成長 |
| `$BF00–$BFFF` | ProDOS global page |

每次建置皆執行 `tools/check_size.py` 並回報位址範圍：

```
main.bin      33066 bytes  $0800..$892A  ceiling $B800  headroom 11990  [OK]
```

**產生的程式碼大小會隨 llvm-mos 版本而異。** 即使原始碼完全未修改，較新的 SDK 仍可能使執行檔變大。
若看到 `[OVER]`，映像檔雖可建置但無法安全執行——會與 MLI 視窗碰撞。
設定時加上 `-DTPV_STRICT_SIZE=ON` 可讓溢位直接中斷建置。

### 編輯器支援
設定階段會產生 `compile_flags.txt`，其中的 include 路徑已針對**你的**機器解析完成，
clangd 無需手動修改即可運作。該檔案含有絕對路徑，因此已列入 `.gitignore`。

### 專案目錄結構
| 路徑 | 內容 |
| --- | --- |
| `src/` | C 與 6502 原始碼、標頭檔、`TPILOT.SYSTEM` 載入程式（`loader.c` / `loader.s`） |
| `assets/` | ProDOS 範本映像（`800kb.hdv`、`140kb.po`）與轉換完成的 `pcm.blob` |
| `tools/` | 建置時工具，由 CMake 呼叫 |
| `tools/offline/` | 一次性資產轉換工具，手動執行，建置時絕不會被呼叫 |
| `disks/` | 建置產出的磁碟映像檔（已列入 `.gitignore`） |

### 離線轉換工具
`tools/offline/` 收錄產生上述已提交資產的一次性轉換工具。這些工具**不屬於**建置流程，
正常建置絕不會執行它們。其中部分會存取本資料夾以外的檔案，或需要本倉庫未包含的輸入檔——
這正是將其產出結果直接提交進版本控制的原因。

| 工具 | 產出 | 狀態 |
| --- | --- | --- |
| `mkpcm_blob.mjs` | `assets/pcm.blob`、`src/audio_table.h` | 需要 Node.js、CX16 的 `.pcm` 原始檔與 `name_entry.vgm` |
| `gen_psg_highscore.mjs` | 高分榜 PSG 音樂表（併入 `pcm.blob`） | 需要 `name_entry.vgm`，本倉庫未包含 |
| `gen_psg_theme.mjs` | `src/theme_psg.h` | 原始下載網址已回傳 HTTP 410；產出的標頭檔已提交 |
| `extract_cx16_sprites.py` | `src/art.h` | 需要 CX16 的精靈 PNG 與調色盤 |
| `make_font.py` | `src/font8x8.h` | 需要 CX16 的字型 PNG |

### 模擬器或實機載入執行
開機鏈：ProDOS →（HDV：`CLOCK.SYSTEM`）→ `TPILOT.SYSTEM`（偵測 VERA 槽位並在 text page 1 顯示啟動畫面）→ 於 `$0800` 載入 `MAIN.BIN` / `MAIN4.BIN`。
* **800KB 硬碟模式**：支援 **Apple2TS** 網頁模擬器或任何支援 VERA 擴充卡之 Apple II 模擬器／實機儲存卡（CFFA3000、FujiNet、wDrive），將 `TimePilot-IIvera.hdv` 掛載至硬碟槽即可自動引導開機啟動！
* **雙 140KB 5.25" 軟碟模式（僅限雙軟碟環境）**：將 `TimePilot-IIvera-D1.po` 掛載至 Drive 1，`TimePilot-IIvera-D2.po` 掛載至 Drive 2，自 Drive 1 開機。程式自動識別軟碟容量，圖形自 D1 讀取、音效自 D2 載入。要安裝到硬碟，請使用 HDV 版本，不要將雙碟映像分別複製到兩個硬碟目錄。
