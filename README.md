# Time Pilot  
Remake of the Time Pilot arcade game, released in 1982 by Konami.  
  
## About Time Pilot from Wikipedia:  
Time Pilot is a multidirectional shooter arcade video game designed by Yoshiki Okamoto and released by Konami in 1982. While engaging in aerial combat, the player-controlled jet flies across open airspace that scrolls indefinitely in all directions.  
  
Players assume the role of a pilot of a futuristic fighter jet trying to rescue fellow pilots trapped in different time eras. In each level, players battle enemy aircraft and then a stronger aircraft. Players' fighter jet is in the center of the screen at all times. Players eventually battle a mothership of the time period they are in; once the mothership is defeated, they move onto the next time period. Parachuting pilots will occasionally appear, and award players points if collected.  
  
There are five levels: 1910, 1940, 1970, 1982 and 2001. After the fifth level is finished, the game repeats thereafter.  
  
## History of this implementation  
This repo contains versions and ports of Time Pilot that I made for modern and vintage computers.  In 2021 I started making a version for the Apple IIgs in 65816 assembly language.  I had the ui, high scores, game flow, shooting, parachute, bosses and core rendering all done.  It was at the point where I needed to make the enemy AI that I stopped.  At the end of 2023 I decided I wanted to get back to it.  I thought going through the 65816 code and writing it in C might be a good exercise to help me remember what I had done.  
  
After I finished that task, I wrote the AI all in C as well.  The C code is a little odd, since it is in many ways a direct translation of the 65816 to C so lots of global variables - everything I had in zero page, for example.  Also, the Apple IIgs has only one frame buffer, so the only way to make this game is to "chase the beam" and some remnants of this is left in the C code, either directly as something called scanLine but also through an erase and draw array system.  It doesn't hurt anything; it will just seem weird and out of place to anyone looking at the code.  Lastly, the game is 16-bit (almost exclusively uses int16_t or uint16_t).  
  
I used a source and header file called tigr (see Windows README) to do the rendering for the C version I made.  I probably should have used SDL but this is so easy and lightweight, and I really like it.  This works on Windows, macOS and Linux.  I also added audio using OpenAL and joystick support on Windows using XInput.  The Linux version is playable using the keyboard.  The windows version is complete and uses the keyboard, but the Joystick (tested with an XBox gamepad) can also be used.  On macOS tigr is not frame locked so game runs much faster than 60 FPS on my Mac Mini.  I didn't make sure that audio worked on the mini - I had trouble with freealut and since the framerate wasn't right I didn't try hard to solve my macOS freealut cmake issues.  
  
After making the Windows/Linux/macOS version, I decided to see if I could compile the code using llvm-mos.  I removed rendering, audio and input and saw that the game ticks over quite a bit faster than 60 FPS.  I then stripped a lot of it down to 8-Bit (everything that doesn't have to be in int 16 is now an int 8).  I added the VERA rendering and sprites.  This game is awesome on the Commander X16.  I have not yet added the audio, but otherwise the game is also complete.  
  
## Differences between my version and the 1982 arcade version  
This game was designed for the Apple IIgs which has a much lower vertical resolution (maybe 192 but I think 200 lines, I can't remember for sure now) than the Arcade version.  For this reason, I moved all of the stats such as score, extra lives, etc. over to the right hand side.  The Windows/Linux/macOS version uses a horizontal resolution of 200.  The Commander X16 version uses a horizontal resolution of 240 - that matches its 40x30 mode.  
  
I tried to copy the patterns and timings as much as I could, but the game won't quite feel the same.  My game is different in some subtle, and some not-so-subtle ways.  For example, my bosses will almost always shoot but in the Arcade version, the bosses don't always shoot.  Another important difference is that I think you need to kill 56 enemies in the Arcade to advance to the boss.  In my game that's only 48 enemies.  That is because the Arcade version has a stage indicator that is 7 "aircraft" wide, and I only had room to draw 6 "aircraft" side-by-side.  I had plenty of room for a stacked indicator but I didn't think a 3x4 stack, or any other configuration, would look good (I just realized maybe a fully vertical stack could have worked?).  Each strip on a 8-pixels wide plane is 1 enemy kill and so I live with the difference.  
  
More differences:  I think the time I allow for letting you score 2000 points for destroying a "flight wing" is longer than the original.  The arcade properly keeps track of the stages.  If you get to the space stage the 1st time, where normally you see little planes that count out the stages, or time periods, the game shows a little rocket with a 5 on it.  The second time to space, it shows a helicopter. My game will always just show planes.  I don't know if anyone will play my game past or through the space stage, so I just didn't bother ;)  
  
## Versions  
[Windows/Linux/macOS](TimePilot-16bit-C/README.md)  
[Commander X16 Readme](TimePilot-CX16/README.md)  
  
Thank you  
Stefan Wessels  
24 February 2024 - Initial Revision  
