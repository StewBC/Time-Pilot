# Time Pilot in "C" using (mostly) 16 Bit variables/structures  
This version was derived from the Apple IIgs 65816 code but uses the tigr library for rendering.  
  
These notes are quite honestly for me because in a few days I won't remember what I did.  In fact, I have already forgotten some things.  

## Prerequisites  
1. tigr. ```https://github.com/erkkah/tigr```  
2. OpenAL (OpenAL-soft?)  
3. freealut  
  
## Windows  
I don't think there's anything special to build this for Windows.  I use Visual Studio 2022.  I did have to install openal and freealut but I can't now remember where I got them or how I installed them.  
  
## Linux  
On linux, I installed vcpkg using this guide: https://lindevs.com/install-vcpkg-on-ubuntu/  
I then used vcpkg to install OpenAL-soft and freealut.  I had to export these variables so that cmake could find freealut and openal.  
```
export FreeALUT_DIR=/usr/local/vcpkg/installed/x64-linux/share/freealut/  
export OpenAL_DIR=/usr/local/vcpkg/installed/x64-linux/share/openal-soft/  
```  
  
## macOS  
Since tigr doesn't run at 60 FPS on macOS, I only tested by taking out the Audio (commenting all AL... stuff out, and stubbing all of the functions in audio.c).  The game ran but way too fast and obviously without sound.  I did file a ticket with tigr.  I was able to install OpenAL-soft and freealut using homebrew but I couldn't figure out what to do about FreeALUTConfig.cmake (which is not installed).  Would be nice to get sorted so if you know what to do, please let me know.  
  
Thank you  
Stefan Wessels  
24 February 2024
