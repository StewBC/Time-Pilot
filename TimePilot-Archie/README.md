# Time Pilot for the Archimedes

A native Acorn Archimedes port of the Time Pilot remake, targeting the **A3010 with 2 MB RAM and RISC OS 3.11**. Gameplay uses fullscreen Mode 13 at a 50 Hz.

I have played the game on an actual A3010 with that RAM/OS configuration and performance and behaviour matches Arculator. Development testing used Arculator v2.2 configured as an A3010 with 4 MB RAM and RISC OS 3.11. 

## Build the game

Requirements: ArchieSDK (tested with its GCC 8.5.0 toolchain), CMake and Ninja. Set `ARCHIESDK` to your SDK installation. For example, on my current development machine:

```sh
export ARCHIESDK=/Users/swessels/Develop/gitlab/archiesdk
cmake --preset archie
cmake --build --preset archie
```

Run these commands from this project directory. The preset creates `build/`; the executable is `build/tpilot,ff8`. This SDK targets ARMv2/ARM2 with software floating point; the game is compiled with `-O2`. If `ARCHIECOPYPATH` is set, the build also copies the executable there.

Generated graphics and audio C files are already in `src/`. CMake compiles them; it does **not** rerun the asset converters automatically. The standalone test programs and profiling hooks have been removed.

## Convert graphics and audio

Requirements: Python 3, Pillow and ffmpeg. The active converter is **`misc/resman.py`**. It generates the 32-bit token sprite data consumed by the renderer, signed 8-bit mono PCM audio, and resource IDs:

```sh
python3 misc/resman.py -f -r 160 -i misc/convert.txt -p misc/palette.txt -o src/tpr.c -a misc/audio.txt -s src/audio_data.c -c src/resids.h
cmake --build --preset archie
```

`misc/convert.txt` lists the PNG inputs and sprite parameters; `misc/palette.txt` defines source colours and their mapping. Propeller animation variants are generated after the base sprite IDs. `misc/audio.txt` lists the WAV inputs and conversion parameters. Regeneration includes timestamps.

Graphics and sound are embedded in the executable; the PNG/WAV sources do not need deployment.

## Package for emulator or hardware

Build the game first, then run:

```sh
python3 misc/package.py
```

This generates the HostFS application directory `build/release/!TimePilot` and **two standard ZIP archives**:

| Archive | Use |
| --- | --- |
| `build/release/TimePilot-HostFS.zip` | Emulator HostFS; files retain comma file-type suffixes, such as `!Run,feb`. |
| `build/release/TimePilot-RISCOS.zip` | Real RISC OS hardware or native emulator extraction; filenames have no comma suffixes, and Acorn ZIP metadata stores file types, timestamps and attributes. |

Both are generated automatically by `package.py`; ZIP integrity and file-type metadata have been checked. The native archive opened in SparkPlug under Arculator.

For hardware, transfer `TimePilot-RISCOS.zip` intact and extract it **on RISC OS** using SparkPlug or another ZIP tool that preserves Acorn metadata. If the transferred archive has lost its file type, set it to Archive (&DDC). Double-click the extracted `!TimePilot` application. Its launcher allocates a 640 KB Wimp slot and loads the bundled sound module. Shift-double-click the application and run `Silent` for explicit silent play.

The package includes Tony Houghton's unchanged THSound module, GPL licence, documentation and attribution from `third_party/THSound/`. The original source/build archive remains in `third_party/THSound/THS221.zip` and is not copied into the application. No installation in system Modules is needed. The launcher uses:

```text
RMEnsure THSound 2.20 RMLoad <Obey$Dir>.THSound
```

The supplied distribution is labelled 2.21, but its module header reports 2.20 (04 Jul 2003). This mismatch can cause the launcher to reload it on subsequent launches. The game's audio initialization permits silent operation when THSound is unavailable; the normal packaged launcher still attempts to load its bundled module. Use `Silent` to bypass that load.

## Change the application icon

Edit `misc/app-icon.png`. `misc/app_icon.py` writes a native RISC OS sprite directly, preserving the input dimensions, quantizing to 16 colours, and generating an old-format transparency mask. The sprite is named `!timepilot`, uses Mode 12, and is saved as `!Sprites,ff9`. Packaging runs this conversion automatically.

Mode 12 pixels display twice as tall as wide: an image of W × H pixels occupies 2W × 4H OS units. Wide logos can clip in the Filer. Icon dimensions are not fixed; the source can be replaced repeatedly while experimenting.

## Controls and presentation

- Space or 1 starts one-player play; 2 starts alternating two-player play.
- Cursor keys or WASD steer; square brackets rotate; Space fires.
- P pauses/resumes. Escape returns from gameplay to the menu, then exits from the menu.
- Type letters or a period for initials, or use direction/rotation and fire to select them.
- J scans for a joystick in the menu. Keyboard play works without a joystick.

Sky colours approximate the requested arcade colours using Mode 13's palette.

Sound uses four native channels: music/boss/rocket cues, two effect channels, and player fire. Boss and rocket loops use direct THSound restarts every 0.2 seconds; the boss phase reserves the loop channel. A new explosion can interrupt the preceding explosion of the same type. The player gun plays one cue on the middle bullet of each three-shot burst as this sounded better to me overall - playing a sound on each bullet worked but it sounded as though some sounds were clipped. The game restores its saved sound configuration and master volume on exit.

## Project layout

- `audio/`, `png/`: source game assets.
- `src/`: game/platform code and generated asset data.
- `misc/`: conversion manifests, palette, icon source, converters and packaging script.
- `third_party/`: bundled THSound distribution and licence.
- `build/`: generated executables, CMake files and release packages; recreated by the build and packaging commands.

