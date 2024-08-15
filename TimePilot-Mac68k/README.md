# Time Pilot in C for the 68K Mac
I have made this need at least System 7.  It was an arbitrary decision, but I did read something somewhere that made me think this will only work on System 7 and above.  You need color - I tested on my SE/30 with System 7 and the game ran, but the display was very wrong.  Probably a way to make it go but I am not investing in that now.  I play on my Centris 650 or in the Basilisk II emulator.  Even though vMac looks like a target, that just crashes.  
  
This version was derived from the Windows code which in turn was derived from my original Apple IIgs 65816 code. I cleaned up the code a little, since I couldn't afford the sloppiness that I was allowed in Windows.  This version sorts the sprites by layer only (vs in Y and then overlapping sprites by layer for the IIgs).  The collision routine thus had to change a little as well.  Otherwise, this is pretty much the Windows version.  
  
## Prerequisites and Dev Environment 
* The code builds using the Retro68 compiler, with the Universal headers.  
* To build the art, ffmpeg needs to be installed, and the pipeline is in Python with its own set of requirements.  The python script (probably the best thing of the whole project) is in misc/resman.py.  See the top of that file for modules needed, also for sample usage.  
  
I developed using WSL (Windows subsystem for Linux) and there are paths checked in, which refer to, for example, Basilisk II, on my Windows side.  So, yes, I developed on Linux and from VS Code launched the emulator on Windows, to mount a disk on Linux.  It all works great!  

## Audio  
The audio works quite well, but there are issues with the code.  I could not get the callback system to see the parameters I am passing so I found a much less efficient way to do what I need to do (still using async play and the callbacks).  I wish I understood what I am not understanding.  
  
## Graphics  
The game uses a clever way to draw sprites that don't require a mask. The sprites are encoded as horizontal lines, with a code for draw, skip, etc.  All sprites are software drawn to a back buffer and the back buffer is sent to the screen at (hopefully) 60 FPS.  At 320x200 this worked but it was agonizingly slow (like 2 FPS) at 640x480.  The game now uses dirty rectangles and runs at 320x200 but will stretch by 2x if 640x480 mode is selected.  It runs slow, but almost passable like this.  Not bad for all "C" code.  The sprites and dirty rect code comes from "Tricks of the Mac Game Programming Gurus".  That was an invaluable resource for getting this done.  
  
I did not get the color cycling to work either.  I must admit that I did not put in a lot of effort, other than trying to swap a couple of colors.  When I looked at the documentation, I could see that there's more to this.  I think it is because applications have to coexist with others, but I try to take over the whole screen, so I don't care so much - but I suppose it's good that the Mac does care.  I'll investigate this down the road somewhere.  
  
## Code Switches  
There's a define to enable replay recording (see RECORD_REPLAY in globals.h).  When defined, the game starts at Stage 2 and the playing is recorded to a buffer.  When you die or kill the boss, the replay is saved (replayXXX.bin) and played back and the next play will record again.  This is useful for capturing the demo attract sequence.  The saved files are numbered so the highest numbered save is the last one played.  There is, however, an issue with this Mac version where it is somehow not repeatable.  I'll have to think how that came about.  Quite possibly the Audio.  
  
## Other issues  
There are quite possibly some other issues.  One is that this code is not up to date with the IIgs version - that's the best version.  I also think there may be other bugs - for example - I think that the parachute, in this version, always scores 1000 points and not 1000, 2000, etc. as it does in the Arcade, and on the IIgs.  Over time, I might address these bugs.  For now I want to move on since I wasn't actually planning to make this now.  
  
## Game Input and Keyboard  
```
Hold space to fire (I didn't like tapping the key)  
Rotate left right with the [ and ] keys (or where they would have been if you have say a French keyboard)  
Steer with cursor keys or WASD in the 4 directions  
P pauses  
1 or Space starts a 1P game  
2 starts a 2P game  
ESC or command-q quits the in-progress game, or the app if in the ui  
- and + (or =) will switch the game display between 320x240 and 640x480.
```  
  
At 640x480 the game is still a bit too slow on my Centris 650.  

Pressing the J key will supposedly scan for the next usable joystick, but I don't know if there were even any Mac joysticks?  If there were, I don't support them.  For now, this is a keyboard only game and pressing J will have no effect.  

## Image and .bin file  
In releases (from V1.7) there are 2 Mac 68K files.  One is Time.Pilot68K.bin and the other is Time.Pilot68K.dsk.  When I FTP Time.Pilot68K.bin (which, in development is just called Time.Pilot.bin) to my Centris, the .bin is dropped and that is the game (app) with resource forks and all.  I did also rawwrite (or dd on Linux) Time.Pilot68K.dsk (again just Time.Pilot.dsk in the build folder) to a USB floppy drive on my Windows machine, and I could load that on my Mac.  
  
## VS Code  
These files are in the .vscode folder, inside the TimePilot-Mac68k folder.
c_cpp_properties.json:  
```
{
    "configurations": [
        {
            "name": "Linux",
            "includePath": [
                "${workspaceFolder}/**",
                "/home/swessels/develop/external/github/Retro68-build/toolchain/universal/CIncludes/**"
            ],
            "defines": [],
            "compilerPath": "/usr/bin/gcc",
            "cStandard": "c11",
            "cppStandard": "c++17",
            "intelliSenseMode": "linux-gcc-x64"
        }
    ],
    "version": 4,
    "enableConfigurationSquiggles": true
}
```  
`/home/swessels/develop/external/github/Retro68-build/toolchain/universal/CIncludes/` is where I have Retro68 installed.  
  
launch.json:  
```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Basilisk II",
            "type": "cppdbg",
            "request": "launch",
            "cwd": "${workspaceFolder}",
            "program": "/mnt/c/Users/swessels/Games/Mac68k/BasiliskII/BasiliskII.exe",
            "args": [],
            "preLaunchTask": "${defaultBuildTask}"
        },
        {
            "name": "Mini vMac",
            "type": "cppdbg",
            "request": "launch",
            "cwd": "${workspaceFolder}",
            "program": "/bin/sh",
            "args": ["vMac.sh"],
            "preLaunchTask": "${defaultBuildTask}"
        }
    ]
}
```  
`/mnt/c/Users/swessels/Games/Mac68k/BasiliskII/BasiliskII.exe` Basilisk II on my Windows machine.  
  
tasks.json:  
```
{
    // See https://go.microsoft.com/fwlink/?LinkId=733558
    // for the documentation about the tasks.json format
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Build and Run",
            "type": "shell",
            "command": "cd build;make -j",
            "args": [],
            "group": {
                "kind": "build",
                "isDefault": true
            },
            "presentation": {
                "clear": true
            },
            "problemMatcher": [
                "$gcc"
            ]
        }
    ]
}
```  
I use Unix Makefiles with cmake.  Pretty standard CMakeLists.txt for Retro68.  
  
## Thank you  
1) [Retro68](https://github.com/autc04/Retro68)  
2) [Tricks of the Mac Game Programming Gurus](https://vintageapple.org/macprogramming/pdf/Tricks_Of_The_Mac_Game_Programming__Gurus_1995.pdf)  
3) https://dev.os9.ca/ - I don't know who owns this site, but it's great!  Inside Macintosh was another indispensable resource, even though it's for Pascal and sometimes a bit confusing (to me).  There's almost no quicker way to find something than a Google search with say `SndPlay site:https://dev.os9.ca/techpubs/mac/`  
  
This was a lot of fun.  I really wanted to make a 68K Mac game - I just wasn't expecting to do it now but once I saw Retro68, I couldn't stop myself!  

Thank you  
Stefan Wessels  
14 August 2024  