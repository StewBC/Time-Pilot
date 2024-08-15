//-----------------------------------------------------------------------------
// draw.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "mac.h"
#include "globals.h"

#include "data.h"
#include "draw.h"
#include "print.h"
#include "screen.h"
#include "resids.h"
#include "sprite.h"
#include "update.h"

//-----------------------------------------------------------------------------
void draw11x11Expl_boom(int16_t X) {
    spriteDraw(spritePtrs[SID_EXPL_BMRNG0 + activeFrame[X]], spritePos);
}

//-----------------------------------------------------------------------------
void draw13x13Expl_sblt(int16_t X) {
    spriteDraw(spritePtrs[SID_EXPL_SBLT0 + activeFrame[X]], spritePos);
}

//-----------------------------------------------------------------------------
void draw16x16Expl_wep(int16_t X) {
    spriteDraw(spritePtrs[SID_EXPL_WEPNS0 + activeFrame[X]], spritePos);
}

//-----------------------------------------------------------------------------
void draw16x16Explosion(int16_t X) {
    spriteDraw(spritePtrs[SID_EXPL_SMALL0 + activeFrame[X]], spritePos);
}

//-----------------------------------------------------------------------------
void draw32x16Explosion(int16_t X) {
    spriteDraw(spritePtrs[SID_EXPL_LARGE0 + activeFrame[X]], spritePos);
}

//-----------------------------------------------------------------------------
void drawAstros0(int16_t X) {
    spriteDraw(spritePtrs[SID_ASTRO0], spritePos);
}

//-----------------------------------------------------------------------------
void drawAstros1(int16_t X) {
    spriteDraw(spritePtrs[SID_ASTRO1], spritePos);
}

//-----------------------------------------------------------------------------
void drawAstros2(int16_t X) {
    spriteDraw(spritePtrs[SID_ASTRO2], spritePos);
}

//-----------------------------------------------------------------------------
void drawBomber(int16_t X) {
    int16_t bomber = SID_L1BOMBER0 + ((activeFlags[X] & ACTIVEFLAGS_DIR_RIGHT) ? 0 : 4) + activeFrame[X];
    spriteDraw(spritePtrs[bomber], spritePos);
}

//-----------------------------------------------------------------------------
void drawClouds0(int16_t X) {
    spriteDraw(spritePtrs[SID_CLOUD0], spritePos);
}

//-----------------------------------------------------------------------------
void drawClouds1(int16_t X) {
    spriteDraw(spritePtrs[SID_CLOUD1], spritePos);
}

//-----------------------------------------------------------------------------
void drawClouds2(int16_t X) {
    spriteDraw(spritePtrs[SID_CLOUD2], spritePos);
}

//-----------------------------------------------------------------------------
void drawEnemyBombs(int16_t X) {
    spriteDraw(spritePtrs[SID_BOMB0 + (activeFlags[X] & ACTIVEFLAGS_DIR_RIGHT ? 0 : 1)], spritePos);
}

//-----------------------------------------------------------------------------
void drawEnemyBoomerang(int16_t X) {
    spriteDraw(spritePtrs[SID_BOOMERANG0 + (activeFrame[X] >> 1)], spritePos);
}

//-----------------------------------------------------------------------------
void drawEnemyBullets(int16_t X) {
    if(activeFlags[X] & ACTIVEFLAGS_CLIPMASK) {
        return;
    }
    Rect bulletRect = { activeMinY[X], activeMinX[X], activeMinY[X] + 2, activeMinX[X] + 2 };
    RGBForeColor(&colors[TP_COLOR_YELLOW]);
    PaintRect(&bulletRect);
    addRectToUpdate(&bulletRect);
}

//-----------------------------------------------------------------------------
void drawEnemy(int16_t X) {
    int16_t enemy = enemyStageStart[activeStage];
    if(activeStage == TIME_PERIOD2_1970) {
        enemy += heliFrameMap[activeFrame[X]];
    } else if(activeStage == TIME_PERIOD4_2001) {
        enemy += (frameCounter & 7) >> 1;
    } else {
        enemy += activeFrame[X] >> 1;
    }
    spriteDraw(spritePtrs[enemy], spritePos);
}

//-----------------------------------------------------------------------------
void drawEnemyRockets(int16_t X) {
    spriteDraw(spritePtrs[SID_ROCKET0 + activeFrame[X]], spritePos);
}

//-----------------------------------------------------------------------------
void drawEnemySpaceBullets(int16_t X) {
    spriteDraw(spritePtrs[SID_SBULLET0 + activeFrame[X]], spritePos);
}

//-----------------------------------------------------------------------------
void drawLevelBoss(int16_t X) {
    int16_t boss = SID_L0BOSS0 + (8 * activeStage) + activeFrame[X];
    if(activeStage != TIME_PERIOD4_2001) {
        boss += ((activeFlags[X] & ACTIVEFLAGS_DIR_RIGHT) ? 0 : 4);
    }
    spriteDraw(spritePtrs[boss], spritePos);
}

//-----------------------------------------------------------------------------
void drawParachute(int16_t X) {
    spriteDraw(spritePtrs[SID_PARACHUTE0 + activeFrame[X]], spritePos);
}

//-----------------------------------------------------------------------------
void drawPlayer(int16_t X) {
    spriteDraw(spritePtrs[SID_PLAYER0 + playerAngle], spritePos);
}

//-----------------------------------------------------------------------------
void drawPlayerBullets(int16_t X) {
    if(activeFlags[X] & ACTIVEFLAGS_CLIPMASK) {
        return;
    }
    Rect bulletRect = { activeMinY[X], activeMinX[X], activeMinY[X] + 2, activeMinX[X] + 2 };
    RGBForeColor(&colors[TP_COLOR_WHITE]);
    PaintRect(&bulletRect);
    addRectToUpdate(&bulletRect);
}

//-----------------------------------------------------------------------------
void drawRts(int16_t X) {
}

//-----------------------------------------------------------------------------
void drawScores(int16_t X) {
    spriteDraw(spritePtrs[SID_NUMBER0 + activeFrame[X]], spritePos);
}

//-----------------------------------------------------------------------------
void drawThing(int16_t X) {
    int16_t A;
    activeFlags[X] &= ~ACTIVEFLAGS_CLIPMASK;
    activeFlags[X] |= screenClips(X);
    A = activeFlags[X] & ACTIVEFLAGS_CLIPMASK;
    // If the sprite is not completely clipped, draw it
    if(A != ACTIVEFLAGS_CLIPMASK) {
        spritePos.h = activeMinX[X];
        spritePos.v = activeMinY[X];
        if(activeFlags[X] & ACTIVEFLAGS_ISDEAD) {
            sprite_draw_dead[activeLayer[X]] (X);
        } else {
            sprite_draw[activeLayer[X]] (X);
        }
    }
}
