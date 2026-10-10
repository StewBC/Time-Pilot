//-----------------------------------------------------------------------------
// draw.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "archie.h"
#include "globals.h"

#include "data.h"
#include "draw.h"
#include "print.h"
#include "screen.h"
#include "resids.h"
#include "sprite.h"
#include "update.h"

static tSpriteInfo *drawPropAnimatedSprite(int32_t sid) {
    if(!(frameCounter & 4)) {
        return spritePtrs[sid];
    }

    if(sid >= SID_L0ENEMY0 && sid <= SID_L0ENEMY15) {
        return spritePtrs[SID_L0ENEMY0_PROP + sid - SID_L0ENEMY0];
    }
    if(sid >= SID_L1ENEMY0 && sid <= SID_L1ENEMY15) {
        return spritePtrs[SID_L1ENEMY0_PROP + sid - SID_L1ENEMY0];
    }
    if(sid >= SID_L2ENEMY0 && sid <= SID_L2ENEMY8) {
        return spritePtrs[SID_L2ENEMY0_PROP + sid - SID_L2ENEMY0];
    }
    if(sid >= SID_L1BOSS0 && sid <= SID_L1BOSS7) {
        return spritePtrs[SID_L1BOSS0_PROP + sid - SID_L1BOSS0];
    }
    if(sid >= SID_L2BOSS0 && sid <= SID_L2BOSS7) {
        return spritePtrs[SID_L2BOSS0_PROP + sid - SID_L2BOSS0];
    }
    if(sid >= SID_L1BOMBER0 && sid <= SID_L1BOMBER7) {
        return spritePtrs[SID_L1BOMBER0_PROP + sid - SID_L1BOMBER0];
    }

    return spritePtrs[sid];
}

//-----------------------------------------------------------------------------
void draw11x11Expl_boom(int32_t X) {
    spriteDraw(spritePtrs[SID_EXPL_BMRNG0 + activeFrame[X]], spritePos);
}

//-----------------------------------------------------------------------------
void draw13x13Expl_sblt(int32_t X) {
    spriteDraw(spritePtrs[SID_EXPL_SBLT0 + activeFrame[X]], spritePos);
}

//-----------------------------------------------------------------------------
void draw16x16Expl_wep(int32_t X) {
    spriteDraw(spritePtrs[SID_EXPL_WEPNS0 + activeFrame[X]], spritePos);
}

//-----------------------------------------------------------------------------
void draw16x16Explosion(int32_t X) {
    spriteDraw(spritePtrs[SID_EXPL_SMALL0 + activeFrame[X]], spritePos);
}

//-----------------------------------------------------------------------------
void draw32x16Explosion(int32_t X) {
    spriteDraw(spritePtrs[SID_EXPL_LARGE0 + activeFrame[X]], spritePos);
}

//-----------------------------------------------------------------------------
void drawAstros0(int32_t X) {
    UNUSED(X);
    spriteDraw(spritePtrs[SID_ASTRO0], spritePos);
}

//-----------------------------------------------------------------------------
void drawAstros1(int32_t X) {
    UNUSED(X);
    spriteDraw(spritePtrs[SID_ASTRO1], spritePos);
}

//-----------------------------------------------------------------------------
void drawAstros2(int32_t X) {
    UNUSED(X);
    spriteDraw(spritePtrs[SID_ASTRO2], spritePos);
}

//-----------------------------------------------------------------------------
void drawBomber(int32_t X) {
    int32_t bomber = SID_L1BOMBER0 + ((activeFlags[X] & ACTIVEFLAGS_DIR_RIGHT) ? 0 : 4) + activeFrame[X];
    spriteDraw(drawPropAnimatedSprite(bomber), spritePos);
}

//-----------------------------------------------------------------------------
void drawClouds0(int32_t X) {
    UNUSED(X);
    spriteDraw(spritePtrs[SID_CLOUD0], spritePos);
}

//-----------------------------------------------------------------------------
void drawClouds1(int32_t X) {
    UNUSED(X);
    spriteDraw(spritePtrs[SID_CLOUD1], spritePos);
}

//-----------------------------------------------------------------------------
void drawClouds2(int32_t X) {
    UNUSED(X);
    spriteDraw(spritePtrs[SID_CLOUD2], spritePos);
}

//-----------------------------------------------------------------------------
void drawEnemyBombs(int32_t X) {
    spriteDraw(spritePtrs[SID_BOMB0 + (activeFlags[X] & ACTIVEFLAGS_DIR_RIGHT ? 0 : 1)], spritePos);
}

//-----------------------------------------------------------------------------
void drawEnemyBoomerang(int32_t X) {
    spriteDraw(spritePtrs[SID_BOOMERANG0 + (activeFrame[X] >> 1)], spritePos);
}

//-----------------------------------------------------------------------------
void drawEnemyBullets(int32_t X) {
    if(activeFlags[X] & ACTIVEFLAGS_CLIPMASK) {
        return;
    }
    archieFill(activeMinX[X], activeMinY[X], 2, 2, TP_COLOR_YELLOW);
}

//-----------------------------------------------------------------------------
void drawEnemy(int32_t X) {
    int32_t enemy = enemyStageStart[activeStage];
    if(activeStage == TIME_PERIOD2_1970) {
        enemy += heliFrameMap[activeFrame[X]];
    } else if(activeStage == TIME_PERIOD4_2001) {
        enemy += (frameCounter & 7) >> 1;
    } else {
        enemy += activeFrame[X] >> 1;
    }
    spriteDraw(drawPropAnimatedSprite(enemy), spritePos);
}

//-----------------------------------------------------------------------------
void drawEnemyRockets(int32_t X) {
    spriteDraw(spritePtrs[SID_ROCKET0 + activeFrame[X]], spritePos);
}

//-----------------------------------------------------------------------------
void drawEnemySpaceBullets(int32_t X) {
    spriteDraw(spritePtrs[SID_SBULLET0 + activeFrame[X]], spritePos);
}

//-----------------------------------------------------------------------------
void drawLevelBoss(int32_t X) {
    int32_t boss = SID_L0BOSS0 + (8 * activeStage) + activeFrame[X];
    if(activeStage != TIME_PERIOD4_2001) {
        boss += ((activeFlags[X] & ACTIVEFLAGS_DIR_RIGHT) ? 0 : 4);
    }
    spriteDraw(drawPropAnimatedSprite(boss), spritePos);
}

//-----------------------------------------------------------------------------
void drawParachute(int32_t X) {
    spriteDraw(spritePtrs[SID_PARACHUTE0 + activeFrame[X]], spritePos);
}

//-----------------------------------------------------------------------------
void drawPlayer(int32_t X) {
    UNUSED(X);
    spriteDraw(spritePtrs[SID_PLAYER0 + playerAngle], spritePos);
}

//-----------------------------------------------------------------------------
void drawPlayerBullets(int32_t X) {
    if(activeFlags[X] & ACTIVEFLAGS_CLIPMASK) {
        return;
    }
    archieFill(activeMinX[X], activeMinY[X], 2, 2, TP_COLOR_WHITE);
}

//-----------------------------------------------------------------------------
void drawRts(int32_t X) {
    UNUSED(X);
}

//-----------------------------------------------------------------------------
void drawScores(int32_t X) {
    spriteDraw(spritePtrs[SID_NUMBER0 + activeFrame[X]], spritePos);
}

//-----------------------------------------------------------------------------
void drawThing(int32_t X) {
    int32_t A;
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
