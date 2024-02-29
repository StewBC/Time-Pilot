# Time Pilot for Commander X16  
These instructions are for Converting the art and audio, building the code, and playing the game.  
  
## About the Audio
The CX16 version now supports sound by using almost the same sounds as the PC version.  These are PCM files.  Since I can only play 1 PCM file at a time, I have arranged the audio files in a priority order.  Higher priority sounds will interrupt lower priority sounds and lower priority sounds will simply not play while a higher priority sound is playing.  
  
This sound system is not satisfactory.  I shortened the samples so that a higher priority sample doesn't tie up the whole sound system for too long.  It doesn't sound awesome but it's better than nothing.  
  
Quite frankly, I am stunned that this works half as well as it does.  I did not expect to be able to play the game and feed the audio all from C code.  If I ever learn how to do SFX on this system, or if someone else does it for me, I will gladly replace this with a proper SFX system.
  
## Getting started  
This workspace uses cmake and Ninja, so that does have to be installed.  

Getting started with llvm-mos - follow these instructions:  
https://github.com/llvm-mos/llvm-mos-sdk#getting-started  
  
After installing llvm-mos, making the build folder under TimePilot-CX16 and doing a cd into the build folder, this is what you need to do:  
```cmake -G "Ninja" -DCMAKE_INSTALL_PREFIX="C:/Users/swessels/Apps/llvm-mos/bin" ..```  
Notice the local path to where I have llvm-mos installed.  Subsequent builds can be made simply running ninja in the build folder.  
  
## VS Code  
If you use VS Code with the cmake extension, it is best to disable that extension for this workspace.  
  
This is my launch.json, below.  Notice the local path to the emulator, x16emu.exe.  
```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Launch",
            "type": "cppvsdbg",
            "request": "launch",
            "cwd": "${workspaceFolder}",
            "program": "C:/Users/swessels/Games/CX16/x16emu.exe",
            "args": ["-joy1", "-prg", "./build/time_pilot"],
            "preLaunchTask": "${defaultBuildTask}"
        }
    ]
}
```
  
This is my tasks.json.  
```
{
    // See https://go.microsoft.com/fwlink/?LinkId=733558
    // for the documentation about the tasks.json format
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Build and Run",
            "type": "shell",
            "command": "cd build;ninja",
            "args": [],
            "group": {
                "kind": "build",
                "isDefault": true
            },
            "presentation": {
                "clear": true
            },
            "problemMatcher": ["$gcc"]
        }
    ]
}

```
  
With those in place, pressing F5 will build the game and launch it in the emulator.  
  
## Switches  
There is a define to enable replay recording (see RECORD_REPLAY in globals.h).  When defined, the game starts at Stage 2 and the playing is recorded to a buffer.  When you die or kill the boss, the replay is saved (replayXXX.bin) and played back and the next play will record again.  This is useful for capturing the demo attract sequence.  The saved files are numbered so the highest numbered save is the last one played.  Remember to strip the first 2 bytes from the recording before adding the data to demoAttractBuffer, and set the DEMO_ATTRACT_LENGTH define to the length of the recording.  
  
## Additional files  
Apart from all of the C source code, in the src/ folder, there are some additional files in this repo, described below.  
  
### X16 launcher  
The misc/TIME_PILOT.INF file can go into LAUNCHER.DATA/.META and misc/TIME-PILOT.ABM can go into LAUNCHER.DATA/.THUMB.  This will show the info and thumbnail when using //launch on the cx16.  
  
### Sprites  
The sprites folder contains all of the images that get converted into the game-ready vram binaries.  See tools for how these conversions work.  
  
### Tools  
The python file, misc/mkvram.py is the image conversion tool.  I used that to convert the sprites, font and X16 launch image to VRAM ready images (tpfont.vrm and tpspr.vrm for the game).  mkvram.py has built-in help, but also look at the text files convert.txt, font.txt and thumb.txt to see how to use mkvram.py to do the conversions.  The two palette*.txt files contain the mappings for image colors to pallet indices.  
  
The python file misc/mkaudio.py is used to pack the PCM audio into the BANKxxx.au files that are found in the assets folder. Look at misc/auto.txt for an explanation of how the audio/*.pcm files were generated from the audio/*.wav files.  
  
### Helpers  
I added two excel documents that helped me calculate the appropriate coordinates to "launch" things around the screen (launch_point_calcs_cx16.xlsx), and the "rays" that the enemies use to steer towards the center of the screen (rays_table_calcs.xlsx).  
  
## Playing the game  
The game is played using a Joystick.  Either the "keyboard" joystick, or an actual joystick (gamepad).  Scan for the next usable Joystick by pressing the J key.  High Score initials can be done via the joystick or entered directly from the keyboard.  
  
Otherwise, these keys have actions:  
```
P pauses
1 or Space starts a 1P game
2 starts a 2P game
ESC quits the game or app if in the ui  
```  
  
The joystick maps to some actions when in the ui:  
```
A or B to start a 1P game, also FIRE
A or Y to start a 2P game
START to start a 1P game
SELECT to quit (ESC equivalent)
```  
  
Thank you  
Stefan Wessels  
24 February 2024  
