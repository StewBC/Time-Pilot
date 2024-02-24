//-----------------------------------------------------------------------------
// draw.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "tigr.h"
#include "globals.h"

#include "data.h"
#include "draw.h"
#include "screen.h"

//-----------------------------------------------------------------------------
void draw11x11Expl_boom(int16_t X) {
    tigrBlitAlpha(screen, boomerangExplodeSprites,
        activeMinX[X], activeMinY[X],
        activeFrame[X]*activeWidth[X], 0,
        activeWidth[X], activeHeight[X], 1.0f);
}

//-----------------------------------------------------------------------------
void draw13x13Expl_sblt(int16_t X) {
    tigrBlitAlpha(screen, spaceBulletExplodeSprites,
        activeMinX[X], activeMinY[X],
        activeFrame[X]*activeWidth[X], 0,
        activeWidth[X], activeHeight[X], 1.0f);
}

//-----------------------------------------------------------------------------
void draw16x16Expl_wep(int16_t X) {
    tigrBlitAlpha(screen, explWepSprites,
        activeMinX[X], activeMinY[X],
        activeFrame[X]*activeWidth[X], 0,
        activeWidth[X], activeHeight[X], 1.0f);
}

//-----------------------------------------------------------------------------
void draw16x16Explosion(int16_t X) {
    tigrBlitAlpha(screen, explSmallSprites,
        activeMinX[X], activeMinY[X],
        activeFrame[X]*activeWidth[X], 0,
        activeWidth[X], activeHeight[X], 1.0f);
}

//-----------------------------------------------------------------------------
void draw16x16TimeWarpAtX(int16_t F, int16_t x) {
    tigrBlitAlpha(screen, timeWarpSprites, x, PLAYER_Y, F << 4, 0, 16, 16, 1.0f);
}

//-----------------------------------------------------------------------------
void draw32x16Explosion(int16_t X) {
    tigrBlitAlpha(screen, explosionSprites,
        activeMinX[X], activeMinY[X],
        activeFrame[X]*activeWidth[X], 0,
        activeWidth[X], activeHeight[X], 1.0f);
}

//-----------------------------------------------------------------------------
void drawAstros0(int16_t X) {
    drawBMPFully(X);
}

//-----------------------------------------------------------------------------
void drawAstros0Part(int16_t X) {
    drawBMPPartly(X);
}

//-----------------------------------------------------------------------------
void drawAstros1(int16_t X) {
    drawBMPFully(X);
}

//-----------------------------------------------------------------------------
void drawAstros1Part(int16_t X) {
    drawBMPPartly(X);
}

//-----------------------------------------------------------------------------
void drawAstros2(int16_t X) {
    drawBMPFully(X);
}

//-----------------------------------------------------------------------------
void drawAstros2Part(int16_t X) {
    drawBMPPartly(X);
}

//-----------------------------------------------------------------------------
void drawBMPFully(int16_t X) {
    tigrBlitAlpha(screen, *spritePtrs[activeBMPIdx[X]],
        activeMinX[X], activeMinY[X],
        activeFrame[X]*activeWidth[X], 0,
        activeWidth[X], activeHeight[X], 1.0f);
}

//-----------------------------------------------------------------------------
void drawBMPFullyWithFrame(int16_t X, int16_t F) {
    tigrBlitAlpha(screen, *spritePtrs[activeBMPIdx[X]],
        activeMinX[X], activeMinY[X],
        F*activeWidth[X], 0,
        activeWidth[X], activeHeight[X], 1.0f);
}

//-----------------------------------------------------------------------------
void drawBMPFullyWithFrameAndAlternate(int16_t X, int16_t F, int16_t alt) {
    tigrBlitAlpha(screen, *spritePtrs[activeBMPIdx[X]],
        activeMinX[X], activeMinY[X],
        F*activeWidth[X], alt ? activeHeight[X] : 0,
        activeWidth[X], activeHeight[X], 1.0f);
}

//-----------------------------------------------------------------------------
void drawBMPPartly(int16_t X) {
    int16_t T, B, L, R, DrX, DrY;

    if(activeMinY[X] < 0) {
        DrY = 0;
        T = -activeMinY[X];
    } else {
        DrY = activeMinY[X];
        T = 0;
    }

    if(activeMinX[X] < 0) {
        DrX = 0;
        L = -activeMinX[X];
    } else {
        DrX = activeMinX[X];
        L = 0;
    }

    B = activeMaxY[X] > SCREEN_PLAYAREA_BOTTOM ? activeMaxY[X] - SCREEN_PLAYAREA_BOTTOM : 0;
    R = activeMaxX[X] > SCREEN_PLAYAREA_RIGHT ? activeMaxX[X] - SCREEN_PLAYAREA_RIGHT : 0;

    if(!(activeFlags[X] & ACTIVEFLAGS_ISDEAD)) {
        tigrBlitAlpha(screen, *spritePtrs[activeBMPIdx[X]],
            DrX                              , DrY                    ,
            activeFrame[X]*activeWidth[X] + L, T                      ,
            activeWidth[X] - L - R           , activeHeight[X] - T - B,
            1.0f);
    }
}

//-----------------------------------------------------------------------------
void drawBMPPartlyWithFrame(int16_t X, int16_t F) {
    int16_t T, B, L, R, DrX, DrY;

    if(activeMinY[X] < 0) {
        DrY = 0;
        T = -activeMinY[X];
    } else {
        DrY = activeMinY[X];
        T = 0;
    }

    if(activeMinX[X] < 0) {
        DrX = 0;
        L = -activeMinX[X];
    } else {
        DrX = activeMinX[X];
        L = 0;
    }

    B = activeMaxY[X] > SCREEN_PLAYAREA_BOTTOM ? activeMaxY[X] - SCREEN_PLAYAREA_BOTTOM : 0;
    R = activeMaxX[X] > SCREEN_PLAYAREA_RIGHT ? activeMaxX[X] - SCREEN_PLAYAREA_RIGHT : 0;

    if(!(activeFlags[X] & ACTIVEFLAGS_ISDEAD)) {
        tigrBlitAlpha(screen, *spritePtrs[activeBMPIdx[X]],
            DrX                   , DrY                    ,
            F*activeWidth[X] + L  , T                      ,
            activeWidth[X] - L - R, activeHeight[X] - T - B,
            1.0f);
    }
}

//-----------------------------------------------------------------------------
void drawBMPPartlyWithFrameAndAlternate(int16_t X, int16_t F, int16_t alt) {
    int16_t TO, TC, BC, LC, RC, DrX, DrY;

    TO = alt ? activeHeight[X] : 0;

    if(activeMinY[X] < 0) {
        DrY = 0;
        TC = -activeMinY[X];
    } else {
        DrY = activeMinY[X];
        TC = 0;
    }

    if(activeMinX[X] < 0) {
        DrX = 0;
        LC = -activeMinX[X];
    } else {
        DrX = activeMinX[X];
        LC = 0;
    }

    BC = activeMaxY[X] > SCREEN_PLAYAREA_BOTTOM ? activeMaxY[X] - SCREEN_PLAYAREA_BOTTOM : 0;
    RC = activeMaxX[X] > SCREEN_PLAYAREA_RIGHT ? activeMaxX[X] - SCREEN_PLAYAREA_RIGHT : 0;

    if(!(activeFlags[X] & ACTIVEFLAGS_ISDEAD)) {
        tigrBlitAlpha(screen        , *spritePtrs[activeBMPIdx[X]],
            DrX                     , DrY                         ,
            F*activeWidth[X] + LC   , TO + TC                     ,
            activeWidth[X] - LC - RC, activeHeight[X] - TC - BC   ,
            1.0f);
    }
}

//-----------------------------------------------------------------------------
void drawClouds0(int16_t X) {
    drawBMPFully(X);
}

//-----------------------------------------------------------------------------
void drawClouds0Part(int16_t X) {
    drawBMPPartly(X);
}

//-----------------------------------------------------------------------------
void drawClouds1(int16_t X) {
    drawBMPFully(X);
}

//-----------------------------------------------------------------------------
void drawClouds1Part(int16_t X) {
    drawBMPPartly(X);
}

//-----------------------------------------------------------------------------
void drawClouds2(int16_t X) {
    drawBMPFully(X);
}

//-----------------------------------------------------------------------------
void drawClouds2Part(int16_t X) {
    drawBMPPartly(X);
}

//-----------------------------------------------------------------------------
void drawEnemyBombs(int16_t X) {
    int16_t localActiveFrame = activeFrame[X];
    activeFrame[X] = activeFlags[X] & (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT) ? 0 : 1;
    drawBMPFully(X);
    activeFrame[X] = localActiveFrame;
}

//-----------------------------------------------------------------------------
void drawEnemyBoomerang(int16_t X) {
    drawBMPFullyWithFrame(X, activeFrame[X] >> 1);
}

//-----------------------------------------------------------------------------
void drawEnemyBoomerangPart(int16_t X) {
    drawBMPPartlyWithFrame(X, activeFrame[X] >> 1);
}

//-----------------------------------------------------------------------------
void drawEnemyBullets(int16_t X) {
    tigrBlitTint(screen, *spritePtrs[activeBMPIdx[X]],
        activeMinX[X], activeMinY[X],
        0, 0,
        activeWidth[X], activeHeight[X], colors[TP_COLOR_YELLOW]);
}

//-----------------------------------------------------------------------------
void drawEnemyP0P1(int16_t X) {
    drawBMPFullyWithFrameAndAlternate(X, activeFrame[X] >> 1, frameCounter & 2);
}

//-----------------------------------------------------------------------------
void drawEnemyP0P1Part(int16_t X) {
    drawBMPPartlyWithFrameAndAlternate(X, activeFrame[X] >> 1, frameCounter & 2);
}

//-----------------------------------------------------------------------------
void drawEnemyP2(int16_t X) {
    drawBMPFullyWithFrameAndAlternate(X, heliFrameMap[activeFrame[X]], frameCounter & 2);
}

//-----------------------------------------------------------------------------
void drawEnemyP2Part(int16_t X) {
    drawBMPPartlyWithFrameAndAlternate(X, heliFrameMap[activeFrame[X]], frameCounter & 2);
}

//-----------------------------------------------------------------------------
void drawEnemyP3(int16_t X) {
    drawBMPFullyWithFrame(X, activeFrame[X] >> 1);
}

//-----------------------------------------------------------------------------
void drawEnemyP3Part(int16_t X) {
    drawBMPPartlyWithFrame(X, activeFrame[X] >> 1);
}

//-----------------------------------------------------------------------------
void drawEnemyP4(int16_t X) {
    drawBMPFullyWithFrame(X, (frameCounter & 7) >> 1);
}

//-----------------------------------------------------------------------------
void drawEnemyP4Part(int16_t X) {
    drawBMPPartlyWithFrame(X, (frameCounter & 7) >> 1);
}

//-----------------------------------------------------------------------------
void drawEnemyRockets(int16_t X) {
    drawBMPFully(X);
}

//-----------------------------------------------------------------------------
void drawEnemyRocketsPart(int16_t X) {
    drawBMPPartly(X);
}

//-----------------------------------------------------------------------------
void drawEnemySpaceBullets(int16_t X) {
    drawBMPFully(X);
}

//-----------------------------------------------------------------------------
void drawLevelBossP0P3(int16_t X) {
    int16_t frameOffset = activeFlags[X] & ACTIVEFLAGS_DIR_RIGHT ? 0 : 4;
    drawBMPFullyWithFrame(X, frameOffset + activeFrame[X]);
}

//-----------------------------------------------------------------------------
void drawLevelBossP0P3Part(int16_t X) {
    int16_t frameOffset = activeFlags[X] & ACTIVEFLAGS_DIR_RIGHT ? 0 : 4;
    drawBMPPartlyWithFrame(X, frameOffset + activeFrame[X]);
}

//-----------------------------------------------------------------------------
void drawLevelBossP1P2(int16_t X) {
    int16_t frameOffset = activeFlags[X] & ACTIVEFLAGS_DIR_RIGHT ? 0 : 4;
    drawBMPFullyWithFrameAndAlternate(X, frameOffset + activeFrame[X], frameCounter & 4);
}

//-----------------------------------------------------------------------------
void drawLevelBossP1P2Part(int16_t X) {
    int16_t frameOffset = activeFlags[X] & ACTIVEFLAGS_DIR_RIGHT ? 0 : 4;
    drawBMPPartlyWithFrameAndAlternate(X, frameOffset + activeFrame[X], frameCounter & 4);
}

//-----------------------------------------------------------------------------
void drawLevelBossP4(int16_t X) {
    int16_t frameOffset = (frameCounter & 4) ? 1 : 0;
    int16_t alt = levelBossHealth < 6 ? frameOffset : 0;
    drawBMPFullyWithFrameAndAlternate(X, activeFrame[X], alt);
}

//-----------------------------------------------------------------------------
void drawLevelBossP4Part(int16_t X) {
    int16_t frameOffset = (frameCounter & 4) ? 1 : 0;
    int16_t alt = levelBossHealth < 6 ? frameOffset : 0;
    drawBMPPartlyWithFrameAndAlternate(X, activeFrame[X], alt);
}

//-----------------------------------------------------------------------------
void drawParachute(int16_t X) {
    drawBMPFully(X);
}

//-----------------------------------------------------------------------------
void drawParachutePart(int16_t X) {
    drawBMPPartly(X);
}

//-----------------------------------------------------------------------------
void drawPlayer(int16_t X) {
    activeFrame[X] = playerAngle;
    drawBMPFully(X);
}

//-----------------------------------------------------------------------------
void drawPlayerBullets(int16_t X) {
    drawBMPFully(X);
}

//-----------------------------------------------------------------------------
void drawRts(int16_t X) {
}

//-----------------------------------------------------------------------------
void drawScores(int16_t X) {
    drawBMPFully(X);
}

//-----------------------------------------------------------------------------
void drawThing(int16_t X) {
    int16_t A;
    activeFlags[X] &= ~(ACTIVEFLAGS_ERASED | ACTIVEFLAGS_CLIPMASK);
    activeFlags[X] |= screenClips(X);
    A = activeFlags[X] & ACTIVEFLAGS_CLIPMASK;
    if(!A) {
        drawVisibleFully(X);
    } else if(A != ACTIVEFLAGS_CLIPMASK) {
        drawVisiblePartly(X);
    } // else X is off screen, no drawing
}

//-----------------------------------------------------------------------------
void drawVisibleFully(int16_t X) {
    if(activeFlags[X] & ACTIVEFLAGS_ISDEAD) {
        sprite_draw_dead[activeLayer[X]](X);
    } else {
        sprite_draw[activeLayer[X]](X);
    }
}

//-----------------------------------------------------------------------------
void drawVisiblePartly(int16_t X) {
    if(activeFlags[X] & ACTIVEFLAGS_ISDEAD) {
        // sprite_draw_dead[activeLayer[X]](X);
    } else {
        sprite_partial_draw[activeLayer[X]](X);
    }
}
