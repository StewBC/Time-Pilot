# Time Pilot  
Remake of the Time Pilot arcade game, released in 1982 by Konami.  

Video of Windows/Linux/macOS and Commander X16 versions on YouTube: https://youtu.be/EGAHTqTvGlY  

## Play in a browser

The repository now builds a static GitHub Pages site that runs four of the ports
directly in the browser, with links to the emulated Apple II versions:

**https://stewbc.github.io/Time-Pilot/**

| Version | Link | What runs |
| --- | --- | --- |
| Native WebAssembly (`TimePilot-16bit-C`) | [Play](https://stewbc.github.io/Time-Pilot/wasm/) | The 16-bit C port compiled with Emscripten, custom `tigr` canvas backend, WebAudio, keyboard/touch controls, gamepad support |
| Commander X16 (`TimePilot-CX16`) | [Play](https://stewbc.github.io/Time-Pilot/x16/) | The real llvm-mos PRG loaded into the official X16Community WebAssembly emulator r49 |
| Apple II + VERA (`TimePilot-IIvera`) | [a2vera](https://apple2ts.com/?theme=dark&slot2=vera&tab=vera#https://github.com/anomixer/Time-Pilot/releases/latest/download/TimePilot-IIvera.hdv) | External emulator, loads the latest `TimePilot-IIvera.hdv` release asset |
| Apple IIgs (`TimePilot-IIgs`) | [a2gsemu](https://a2gsemu-ia.pages.dev/?lang=en&core=gs2&game=https%3A%2F%2Fgithub.com%2FStewBC%2FTime-Pilot) | External emulator with the supplied TimePilot IIgs game URL |
| Macintosh 68k (`TimePilot-Mac68k`) | [Play](https://stewbc.github.io/Time-Pilot/mac/) | Infinite Mac boots System 7.5 at 640×480 with 8 MB RAM and mounts the hosted `Time.Pilot-m68k.dsk` as a second disk |
| Acorn Archimedes (`TimePilot-Archie`) | [Play](https://stewbc.github.io/Time-Pilot/archie/) | Archimedes Live boots an A3020 (ARM250 @ 12 MHz, 4 MB RAM) with RISC OS 3.11, unpacks the hosted `TimePilot-RISCOS-HostFS.zip` onto HostFS, and autoboots `!TimePilot` |

The a2vera link intentionally uses the `TimePilot-IIvera.hdv` release asset from
the `anomixer/Time-Pilot` releases; that asset is not part of the upstream
release set.

The Mac player is a small `web/mac/` page around Infinite Mac. Its
`Time.Pilot-m68k.dsk` comes from the TimePilot-Mac68k V1.9 release and is tracked
in the repository. Infinite Mac needs a HEAD with `Content-Length` plus
byte-range GETs, which cross-origin GitHub Pages responses do not expose, so the
player reads the disk from `raw.githubusercontent.com` for the repository that
builds the site. `GITHUB_REPOSITORY` and `GITHUB_REF_NAME` are stamped into the
deployed page, so a fork fetches its own copy. Keep the file byte-for-byte intact
when updating it.

The Archimedes player is a small `web/archie/` page around Archimedes Live. Its
`TimePilot-RISCOS-HostFS.zip` is the emulator-friendly release archive (the plain
`TimePilot-RISCOS.zip` lacks the comma file-type metadata HostFS needs). The page
passes the zip through the `disc` hash parameter and an `autoboot` command for
`HostFS:$.!TimePilot`; Archimedes Live fetches the zip over CORS, unpacks it, and
starts the app. Keep the archive byte-for-byte intact when updating it.

The Commander X16 player uses the official X16Community wasm build; that build
does not currently enable VERA PCM audio, so it is silent. The native
WebAssembly port has audio.

### Building the browser versions

Both browser ports self-fetch their toolchains and are independent of any
toolchain installed in this repository. A fresh clone needs only `git`,
Python 3, Node.js, `curl` and `tar`; the Emscripten, llvm-mos and X16 emulator
downloads go into caches outside the repository. All source art and the shared
favicon are tracked, so no generated `dist/` or `_site/` directory is required:

```sh
# Native WebAssembly port -> TimePilot-web/dist
bash TimePilot-web/build.sh

# Commander X16 PRG -> TimePilot-CX16/web/dist/time_pilot.prg
bash TimePilot-CX16/web/build.sh

# Assemble the static site -> web/_site
node web/build-site.mjs
```

To preview the result locally, serve the assembled directory over HTTP (the
WebAssembly and emulator players need HTTP, not `file://`):

```sh
python -m http.server 8000 --directory web/_site
```

Then open `http://localhost:8000/`.

On Windows use `TimePilot-web/build.ps1` and
`TimePilot-CX16/web/build.ps1`. Set `TIMEPILOT_EMSDK` / `LLVM_MOS_SDK` to use an
existing SDK, or `TIMEPILOT_TOOLS` to choose the cache directory. The x16
emulator archive is pinned and SHA-256 checked by
`TimePilot-CX16/web/assemble.mjs`.

GitHub Actions rebuilds all of the above on every push to `master` and deploys
`web/_site` to Pages using `.github/workflows/deploy-web.yml`. In the repository
settings, set **Pages → Build and deployment → Source** to **GitHub Actions**
once; the workflow does the rest.

## Versions  
[Acorn Archimedes Readme](TimePilot-Archie/README.md)  
[Apple //e & IIgs Vera Readme - port by anomixer](TimePilot-IIvera/README.md)  
[Apple IIgs Readme](TimePilot-IIgs/README.md)  
[Commander X16 Readme](TimePilot-CX16/README.md)  
[Mac 68K Readme](TimePilot-Mac68k/README.md)  
[Windows/Linux/macOS Readme](TimePilot-16bit-C/README.md)  
  
## About Time Pilot from Wikipedia:  
Time Pilot is a multidirectional shooter arcade video game designed by Yoshiki Okamoto and released by Konami in 1982. While engaging in aerial combat, the player-controlled jet flies across open airspace that scrolls indefinitely in all directions.  
  
Players assume the role of a pilot of a futuristic fighter jet trying to rescue fellow pilots trapped in different time eras. In each level, players battle enemy aircraft and then a stronger aircraft. Players' fighter jet is in the center of the screen at all times. Players eventually battle a mothership of the time period they are in; once the mothership is defeated, they move onto the next time period. Parachuting pilots will occasionally appear, and award players points if collected.  
  
There are five levels: 1910, 1940, 1970, 1982 and 2001. After the fifth level is finished, the game repeats thereafter.  
  
## History of this implementation  
This repo contains versions and ports of Time Pilot that I made for modern and vintage computers.  In 2021 I started making a version for the Apple IIgs in 65816 assembly language.  I had the ui, high scores, game flow, shooting, parachute, bosses and core rendering all done.  It was at the point where I needed to make the enemy AI that I stopped.  At the end of 2023 I decided I wanted to get back to it.  I thought going through the 65816 code and writing it in C might be a good exercise to help me remember what I had done.  
  
After I finished that task, I wrote the AI all in C as well.  The C code is a little odd, since it is in many ways a direct translation of the 65816 to C so lots of global variables - everything I had in zero page, for example.  Also, the Apple IIgs has only one frame buffer, so the only way to make this game is to "race the beam" (erase and redraw the screen right after the vertical CRT beam has drawn that part of the screen, and before that beam comes round to update that part of the screen) and some remnants of this is left in the C code, either directly as something called scanLine but also through an erase and draw array system.  It doesn't hurt anything; it will just seem weird and out of place to anyone looking at the code.  Lastly, the game is 16-bit (almost exclusively uses int16_t or uint16_t).  
  
After making the Windows/Linux/macOS version, I decided to see if I could compile the code using llvm-mos.  I removed rendering, audio and input and saw that the game ticks over quite a bit faster than 60 FPS.  I then stripped a lot of it down to 8-Bit (everything that doesn't have to be in int 16 is now an int 8).  I added the VERA rendering and sprites.  This game is awesome on the Commander X16.  The CX16 audio is currently done as PCM audio (more or less the same audio as the Windows/Linux version).  This isn't a great solution as only 1 stream can play at a time, but is better than nothing.  

I then went back to the Apple IIgs version and finished it.  I really started over and brought in only the code I knew I wouldn't really change, but a fair bit was rewritten.  In the process I also improved the game a little, so the IIgs version is now actually the best version.  At some point I'll migrate the updates back if I can remember them all.  The audio implementation for Time Pilot was provided by Antoine Vignaue from Brutal Deluxe Software (as was Mr Sprite and Cadius, both of which I also use in the making of this game).  A very big thank you to Brutal Deluxe Software for their support and awesome tools to this community.  
  
## Differences between my version and the 1982 arcade version  
This game was designed for the Apple IIgs whereas the Arcade version runs on a rotated screen.  The arcade version has a resolution of 224H x 256V whereas the Apple IIgs has 320H x 200V.  For this reason, I moved all of the stats such as score, extra lives, etc. over to the right hand side.  The Windows/Linux/macOS version also uses a horizontal resolution of 200.  The Commander X16 version uses a horizontal resolution of 240 - that matches its 40x30 mode.  
  
Another significant difference is stage length.  The original shows 7 stage progress planes.  Each represents killing 8 enemies, so to complete a stage requires killing 56 enemies.  My version has room for only 6, so you have to kill only 48 enemies to advance to the next stage.  That will obviously have an effect on overall scores, but it will be exaggerated since you will encounter less parachutes, for example, which if you pick them all up, means 5,000 points per parachute.  Also less enemy waves which, when wiped out, is 2,000 points per wave.  

The other differences between the original and my version are more subtle, for example the original has an indicator that shows the player has cleared all the stages, and I think perhaps how many times, but I just use the simple plane icon to indicate the stage number.
  
Thank you  
Stefan Wessels  
24 February 2024 - Initial Revision  
