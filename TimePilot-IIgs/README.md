# Time Pilot for Apple IIgs  
These instructions are for playing the game, but mostly for converting the art and building the code.  
  
## Controls  
The game uses the keyboard or Joystick to control the player plane.  To use the Joystick, simply press `J` on the title screen.  If the J does not turn green (selected) then the game is not detecting the Joystick.  Controls on the Joystick (in game) are Up, Down, Left, Right and fire, while the second button is Pause.  In the UI, the fire button starts a 1 Player game, and the "Pause" button starts a 2 Player game.  
  
The keyboard controls are (and these also work when playing with the Joystick) `1` - 1 Player, `2` - 2 Player, `ESC` - back up (and quit) and `P` - Pause.  The in-game keys are (and these rotate keys *do not* work in joystick mode) `Option` to rotate left, `Open Apple` to rotate right, `Space` to fire (just hold, don't have to tap - I felt too sorry for the poor spacebar).  
  
## Getting started  
The Apple IIgs version is written in 65816 assembly language, targeting the Orca/M assembler and the build process is done using `make`.  Several pieces of software were used to structure the build process, listed below.  Not all are free.  See below.  
  
Running `make` takes these options:  
make option | effect
--- | ---
art | run misc/mkspr.py to build the files in src/sprites
hardware | use misc/hardware_prep.py to make a ShrinkIt archive for use on a real IIgs
dsk | use cadius to make a GS/OS image that auto-runs TIME PILOT as timepilot.2mg
floppy | use cadius to make an 800K floppy image that just contains TIMEPILOT.S16
test | use the emulator to run the game
macros | use Orca/M's macgen to build the needed macro files
indent | put all the source through cadius, sed and awk to format the source
clean | clean up built versions of files
zap | clean and remove intermediate and built files and folders  

### On macOS
There is a different Makefile for macOS, you need cadius (which you can put with the Makefile.macos).  On the mac version, I have tested:  
```
make zap -f Makefile.macos  
make indent -f Makefile.macos  
make macros -f Makefile.macos  
make -j -f Makefile.macos  
make dsk -f Makefile.macos  
```  
  
You probably just want to copy Makefile.macos over Makefile so you can give the commands without the trailing `-f Makefile.macos`.  
  
### Note about png/tpsmall.png  
Mr Sprite will, at the time of writing, generate code to draw tpsmall that is not correct.  Under "; Line 8" it at some point generates:  
```
    LDA    $CF,S
    AND    #$F00F
    ORA    #$0220
    STA    $CF,S
    SHORT  M
```
The manual fix I apply is to make the line `ORA    #$0220` read:  
```
    LDA    $CF,S
    AND    #$F00F
    ORA    #$0F20
    STA    $CF,S
    SHORT  M
```
Without this fix, a pixel is drawn in the play area on the left, that does not belong.  It is harmless, but not nice.  With the fix the pixel is drawn in the sky color so it doesn't show up.  
  
## Note about history/ReadMeFirst  
I found the easiest way to edit this document is in a IIgs Emulator.  Save it, and re-export it back from the emulator to the native filesystem making sure to grab the resource fork as well.  
  
## Note about TimePilot.icon  
The AUX of the executable (which must be named TIME.PILOT) must be DB03 or the icon will not show up.  
  
## Software I use and is needed to rebuild the code and art  
Orca/M is an assembler that runs natively on the Apple IIgs.  It is not freeware but can be bought from [juiced.gs](https://juiced.gs/).  It is called the Opus ][ collection, in the store.  At the time of writing this is $25 for a download version.  
  
To cross-compile (I used Windows to develop this) you will also need Golden Gate.  Golden Gate is also available from [juiced.gs](https://juiced.gs/).  At the time of writing this is $10 for a download version.  
  
[make for Windows](https://gnuwin32.sourceforge.net/packages/make.htm) - This is GNU make.  
  
[Cadius](https://www.brutaldeluxe.fr/products/crossdevtools/cadius/) for making disks and source indent (pretty).  
  
[Crossrunner](https://www.crossrunner.gs/) is my preferred Apple IIgs emulator.  It is cycle accurate and has source level debugging amongst its many virtues.  The Makefile is set up to also use MAME, GSPORT, GSPLUS & KEGS by just setting which one to use on the line `EMULATOR := <NAME>`.  Note however that the paths to the emulators will need to be set in the Makefile.  A search for `swessels` should fine most places where a path needs to be changed.  
  
[Mr Sprite](https://www.brutaldeluxe.fr/products/crossdevtools/mrsprite/) is used to turn the PNG versions of the sprites into executable code.  See the website and misc/mkspr.py for more details.  
  
Python is used to control the building of the art, and prepping an shk archive so I can easily move this to my actual IIgs.  See misc/mkspr.py and misc/hardware_prep.py.  
  
SED and AWK which were installed for me when I installed [GIT](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).  
  
Note that the paths for the tools are in the Makefile, and also in the python files, if the tools are not in the path.  Again, a search for `swessels` should fine most places where a path needs to be changed, but some tools may just be in my path and therefor not referenced through a fully qualified path name.  
  
Once everything is set up, the macros need to be built at least once (`make macros`).  After that, something like `make test -j` should build and run the game just fine.  
  
### Using VS Code  
Put these two files in the `.vscode` folder inside the `TimePilot-IIgs` folder to make the experience using code to develop this game a lot nicer.  
  
This is my launch.json.
```
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Launch",
      "type": "cppvsdbg",
      "request": "launch",
      "cwd": "${workspaceFolder}",
      "program": "make.exe",
      "args": [
        "test",
        "-j"
      ],
      "console": "integratedTerminal"
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
            "command": "make -j dsk test",
            "args": [],
            "group": {
                "kind": "build",
            },
            "presentation": {
                "clear": true
            },
            "problemMatcher": [
                {
                    "owner": "asm",
                    "fileLocation": ["relative", "${workspaceFolder}/src/"],
                    "pattern": {
                        "regexp": "^Error .*?c\\\\(\\S+)\\s+(\\d+)\\s+(.*)$",
                        "file": 1,
                        "line": 2,
                        "message": 3
                    }
                },
                {
                    "owner": "linker",
                    "fileLocation": ["relative", "${workspaceFolder}/src/"],
                    "pattern": {
                        "regexp": "^Error at ([0-9A-F]+) past (.*?) PC.*: (.*)$",
                        "file": 2,
                        "line": 1,
                        "message": 3
                    }
                }            
            ]
        },
        {
            "label": "Clean",
            "type": "shell",
            "command": "make clean",
            "args": [],
            "group": {
                "kind": "build"
            },
            "presentation": {
                "clear": true
            }
        },
        {
            "label": "Build",
            "type": "shell",
            "command": "make -j",
            "group": {
                "kind": "build"
            },
            "presentation": {
                "clear": true
            },
            "problemMatcher": [
                {
                    "owner": "asm",
                    "fileLocation": ["relative", "${workspaceFolder}/src/"],
                    "pattern": {
                        "regexp": "^Error .*?c\\\\(\\S+)\\s+(\\d+)\\s+(.*)$",
                        "file": 1,
                        "line": 2,
                        "message": 3
                    }
                },
                {
                    "owner": "linker",
                    "fileLocation": ["relative", "${workspaceFolder}/src/"],
                    "pattern": {
                        "regexp": "^Error at ([0-9A-F]+) past (.*?) PC.*: (.*)$",
                        "file": 2,
                        "line": 1,
                        "message": 3
                    }
                }            
            ]
        },
        {
            "label": "Build art",
            "type": "shell",
            "command": "make art",
            "args": [],
            "group": {
                "kind": "build"
            },
            "presentation": {
                "clear": true
            }
        },
        {
            "label": "Build macros",
            "type": "shell",
            "command": "make -j macros",
            "args": [],
            "group": {
                "kind": "build"
            },
            "presentation": {
                "clear": true
            },
            "problemMatcher": []
        },
        {
            "label": "Build indent",
            "type": "shell",
            "command": "make indent",
            "args": [],
            "group": {
                "kind": "build"
            },
            "presentation": {
                "clear": true
            }
        }
    ]
}
```
  
With those in place, pressing F5 will build the game and launch it in the emulator.  Pressing CTRL-B will bring up a menu (only the second time you press it if newly launched...) that will contain the options to Build, Build & Run, etc.  
  
# Special Thanks  
I have to give special thanks to a few people.  
**Ian Brumby** - Ian wrote Crossrunner and helped me get started with GS/OS development. Also introduced me to Orca/M and Golden Gate.  
**Brutal Deluxe** - Mr. Sprite and Cadius are indispensable, and the audio code Antoine Vignau gave me made the game awesome!  
**Kelvin Sherlock** - Golden Gate, which is also indispensable in this process.  
**Andy McFadden** - CiderPress 2 that makes moving code to the actual Apple IIgs a breeze.  
**Jeremy Rand** - Made BuGS which made me want to make an arcade game for the IIgs.  
**Mike Westerfield** - Created Orca/M which is a very sophisticated assembler that has been a joy to use.  
**Brian A. Troha** - Provided the splash screen graphic.  
**Emmanuel Marty et al.** - LZSA2 used in the loader - https://github.com/emmanuel-marty/lzsa.git  
  
Thank you all - you have made my life better! :)  
  
swessels@email.com  
Stefan Wessels  
June 19, 2024  
