//
//      File: sprite.h
//
//      This file is the header for sprite.c.
//
//      2/18/95 -- Created by Mick
//      8/11/24 -- Marginally changed for TimePilot by Stefan Wessels
//

#pragma once

extern void spriteDispose(tSpriteInfo * spriteInfo);
extern void spriteDraw(tSpriteInfo * spriteInfo, Point location);
extern void spriteDrawClipped(tSpriteInfo * spriteInfo, Rect * inDestRect);
extern void spriteDrawUnclipped(tSpriteInfo * spriteInfo, Rect * inDestRect);
extern tSpriteInfo *spriteLoad(signed short resID);
extern void spriteSetClipRect(Rect * drawRect);
extern void spriteShowTextUnclipped(tSpriteInfo * spriteInfo, Rect * inDestRect, uint32_t color);
extern void spriteStartDraw(PixMapHandle destPixMap);
