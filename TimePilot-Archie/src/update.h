//
//      File: update.h
//
//      This file is the header for update.c.
//
//      2/18/95 -- Created by Mick
//      8/11/24 -- Marginally changed for TimePilot by Stefan Wessels
//

#pragma once

extern void clearUpdate(void);
extern void addRectToUpdate(Rect * inUpdateRect);
extern uint32_t getUpdateRectCount(void);
extern void getUpdateRect(uint32_t inRectIndex, Rect * outUpdateRect);
extern void increaseUpdateRects(void);
extern void decreaseUpdateRects(void);
extern void adjustRect(Rect * ioRect);
