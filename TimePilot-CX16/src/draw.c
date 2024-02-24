//-----------------------------------------------------------------------------
// draw.c
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include <stdint.h>
#include "globals.h"

#include "data.h"
#include "draw.h"
#include "screen.h"

#include <cx16.h>

//-----------------------------------------------------------------------------
void draw11x11Expl_boom(int8_t X) {
    drawSetSpritePositionAndFrameForExplosions(X, EXPLOSION_TYPE_BOOM11X11, FRAME_OFFSET(16,16) * activeFrame[X]);
}

//-----------------------------------------------------------------------------
void draw13x13Expl_sblt(int8_t X) {
    drawSetSpritePositionAndFrameForExplosions(X, EXPLOSION_TYPE_SBLT13X13, FRAME_OFFSET(16,16) * activeFrame[X]);
}

//-----------------------------------------------------------------------------
void draw16x16Expl_wep(int8_t X) {
    drawSetSpritePositionAndFrameForExplosions(X, EXPLOSION_TYPE_WEP16X16, FRAME_OFFSET(16,16) * activeFrame[X]);
}

//-----------------------------------------------------------------------------
void draw16x16Explosion(int8_t X) {
    drawSetSpritePositionAndFrameForExplosions(X, EXPLOSION_TYPE_16X16, FRAME_OFFSET(16,16) * activeFrame[X]);
}

//-----------------------------------------------------------------------------
void draw32x16Explosion(int8_t X) {
    drawSetSpritePositionAndFrameForExplosions(X, EXPLOSION_TYPE_32X16, FRAME_OFFSET(32,16) * activeFrame[X]);
}

//-----------------------------------------------------------------------------
void drawEnemyBomber(int8_t X) {
    int8_t frameOffset = activeFlags[X] & (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT) ? 0 : 4;
    drawSetSpritePositionAndFrame(X, FRAME_OFFSET(32,16) * (frameOffset + activeFrame[X]));
}

//-----------------------------------------------------------------------------
void drawEnemyBombs(int8_t X) {
    uint8_t frame = activeFlags[X] & (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT) ? 0 : 1;
    drawSetSpritePositionAndFrame(X, FRAME_OFFSET(8,8) * frame);
}

//-----------------------------------------------------------------------------
void drawEnemyBoomerang(int8_t X) {
    drawSetSpritePositionAndFrame(X, FRAME_OFFSET(8,8) * activeFrame[X]);
}

//-----------------------------------------------------------------------------
void drawEnemyBullets(int8_t X) {
    drawSetSpritePosition(X);
}

//-----------------------------------------------------------------------------
void drawEnemyP0P1P3(int8_t X) {
    drawSetSpritePositionAndFrameForEnemies(X, FRAME_OFFSET(16,16) * (activeFrame[X] >> 1));
}

//-----------------------------------------------------------------------------
void drawEnemyP2(int8_t X) {
    drawSetSpritePositionAndFrameForEnemies(X, FRAME_OFFSET(16,16)*heliFrameMap[activeFrame[X]]);
}

//-----------------------------------------------------------------------------
void drawEnemyP4(int8_t X) {
    drawSetSpritePositionAndFrameForEnemies(X, FRAME_OFFSET(16,8)*((frameCounter & 7) >> 1));
}

//-----------------------------------------------------------------------------
void drawEnemyRockets(int8_t X) {
    drawSetSpritePositionAndFrame(X, FRAME_OFFSET(16,16) * activeFrame[X]);
}

//-----------------------------------------------------------------------------
void drawEnemySpaceBullets(int8_t X) {
    drawSetSpritePositionAndFrame(X, FRAME_OFFSET(16,16) * (activeFrame[X] >> 1));
}

//-----------------------------------------------------------------------------
void drawLevelBossP0P1P2P3(int8_t X) {
    int8_t frameOffset = activeFlags[X] & (ACTIVEFLAGS_MULTIPURPOSE | ACTIVEFLAGS_DIR_RIGHT) ? 0 : 4;
    drawSetSpritePositionAndFrameForBosses(X, FRAME_OFFSET(32,16) * (frameOffset + activeFrame[X]));
}

//-----------------------------------------------------------------------------
void drawLevelBossP4(int8_t X) {
    int8_t frameOffset = (frameCounter & 4) ? 1 : 0;
    drawSetSpritePositionAndFrameForBosses(X, FRAME_OFFSET(32,16) * frameOffset);
    // Animate the colors if the boss has been hit (< 66%)
    if(!(frameCounter & 7) && ((LEVELBOSS_HEALTH * 2) / 3) >= levelBossHealth) {
        VERA.address_hi = VERA_INC_1 | 1;
        VERA.address = (VERA_COLOR_PALETTE+32)+(2*TP_COLOR_SKY);
        propState ^= 1;
        if(propState) {
            VERA.data0 = colorPalette[TP_COLOR_CYAN] & 0xff; 
            VERA.data0 = colorPalette[TP_COLOR_CYAN] >> 8;
        } else {
            VERA.data0 = colorPalette[TP_COLOR_MAGENTA] & 0xff; 
            VERA.data0 = colorPalette[TP_COLOR_MAGENTA] >> 8;
        }
    }
}

//-----------------------------------------------------------------------------
void drawParachute(int8_t X) {
    drawSetSpritePositionAndFrame(X, FRAME_OFFSET(16,16) * activeFrame[X]);
}

//-----------------------------------------------------------------------------
void drawPlayer(int8_t X) {
    drawSetSpriteFrame(X, FRAME_OFFSET(16, 16) * playerAngle);
}

//-----------------------------------------------------------------------------
void drawPlayerBullets(int8_t X) {
    drawSetSpritePosition(X);
}

//-----------------------------------------------------------------------------
void drawRts(int8_t X) {
}

//-----------------------------------------------------------------------------
void drawScores(int8_t X) {
    drawSetSpritePositionAndFrame(X, FRAME_OFFSET(16,8) * activeFrame[X]);
}

//-----------------------------------------------------------------------------
void drawSetOtherSprite(int8_t X, uint8_t layer, uint16_t posX, uint16_t posY, uint8_t frameOffset) {
    uint16_t frameAddress;
    uint8_t spriteSize;
    VERA.address_hi = VERA_INC_1 | 1;
    VERA.address = VERA_SPRITES_BASE + (X * 8);
    
    if(layer > LAYER_NUM_LAYERS) {
        layer -= LAYER_NUM_LAYERS;
        frameAddress = spriteVRAMMisc_lo[layer] + frameOffset;
        VERA.data0 = frameAddress & 0xFF;
        VERA.data0 = spriteVRAMMisc_hi[layer] + (frameAddress >> 8);
        spriteSize = spriteSizeByMisc[layer];
    } else {
        frameAddress = spriteVRAMAddress_lo[layer] + frameOffset;
        VERA.data0 = frameAddress & 0xFF;
        VERA.data0 = spriteVRAMAddress_hi[layer] + (frameAddress >> 8);
        spriteSize = spriteSizeByLayer[layer];
    }

    VERA.data0 = posX & 0xFF;
    VERA.data0 = posX >> 8;
    VERA.data0 = posY & 0xFF;
    VERA.data0 = posY >> 8;
    VERA.data0 = 0; // Z
    VERA.data0 = spriteSize;
}

//-----------------------------------------------------------------------------
void drawSetSpriteFrame(int8_t X, uint8_t frameOffset) {
    uint16_t frameAddress = spriteVRAMAddress_lo[activeLayer[X]];
    frameAddress += frameOffset;
    VERA.address_hi = VERA_INC_1 | 1;
    VERA.address = VERA_SPRITES_BASE + (X * 8);
    VERA.data0 = frameAddress & 0xFF;
    VERA.data0 = spriteVRAMAddress_hi[activeLayer[X]] + (frameAddress >> 8);
}

//-----------------------------------------------------------------------------
void drawSetSpritePosition(int8_t X) {
    VERA.address_hi = VERA_INC_1 | 1;
    VERA.address = VERA_SPRITES_BASE + (X * 8) + 2;
    VERA.data0 = activeMinX[X] & 0xff;
    VERA.data0 = (activeMinX[X] >> 8) & 3;
    VERA.data0 = activeMinY[X] & 0xff;
    VERA.data0 = (activeMinY[X] >> 8) & 3;
}

//-----------------------------------------------------------------------------
void drawSetSpritePositionAndFrame(int8_t X, uint8_t frameOffset) {
    uint16_t frameAddress = (uint8_t)spriteVRAMAddress_lo[activeLayer[X]] + frameOffset;
    VERA.address_hi = VERA_INC_1 | 1;
    VERA.address = VERA_SPRITES_BASE + (X * 8);
    VERA.data0 = frameAddress & 0xFF;
    VERA.data0 = spriteVRAMAddress_hi[activeLayer[X]] + (uint8_t)(frameAddress >> 8);
    VERA.data0 = activeMinX[X] & 0xff;
    VERA.data0 = (activeMinX[X] >> 8) & 3;
    VERA.data0 = activeMinY[X] & 0xff;
    VERA.data0 = (activeMinY[X] >> 8) & 3;
}

//-----------------------------------------------------------------------------
void drawSetSpritePositionAndFrameForBosses(int8_t X, uint8_t frameOffset) {
    uint16_t frameAddress = (uint8_t)spriteVRAMBosses_lo[activeStage] + frameOffset;
    VERA.address_hi = VERA_INC_1 | 1;
    VERA.address = VERA_SPRITES_BASE + (X * 8);
    VERA.data0 = frameAddress & 0xFF;
    VERA.data0 = spriteVRAMBosses_hi[activeStage] + (uint8_t)(frameAddress >> 8);
    VERA.data0 = activeMinX[X] & 0xff;
    VERA.data0 = (activeMinX[X] >> 8) & 3;
    VERA.data0 = activeMinY[X] & 0xff;
    VERA.data0 = (activeMinY[X] >> 8) & 3;
}

//-----------------------------------------------------------------------------
void drawSetSpritePositionAndFrameForEnemies(int8_t X, uint8_t frameOffset) {
    uint16_t frameAddress = (uint8_t)spriteVRAMEnemies_lo[activeStage] + frameOffset;
    VERA.address_hi = VERA_INC_1 | 1;
    VERA.address = VERA_SPRITES_BASE + (X * 8);
    VERA.data0 = frameAddress & 0xFF;
    VERA.data0 = spriteVRAMEnemies_hi[activeStage] + (uint8_t)(frameAddress >> 8);
    VERA.data0 = activeMinX[X] & 0xff;
    VERA.data0 = (activeMinX[X] >> 8) & 3;
    VERA.data0 = activeMinY[X] & 0xff;
    VERA.data0 = (activeMinY[X] >> 8) & 3;
}

//-----------------------------------------------------------------------------
void drawSetSpritePositionAndFrameForExplosions(int8_t X, uint8_t type, uint8_t frameOffset) {
    uint8_t hi;
    uint16_t frameAddress = (uint8_t)spriteVRAMExplosions_lo[type] + frameOffset;
    VERA.address_hi = VERA_INC_1 | 1;
    VERA.address = VERA_SPRITES_BASE + (X * 8);
    VERA.data0 = frameAddress & 0xFF;
    hi = spriteVRAMExplosions_hi[type] + (uint8_t)(frameAddress >> 8);
    VERA.data0 = hi;
    VERA.data0 = activeMinX[X] & 0xff;
    VERA.data0 = (activeMinX[X] >> 8) & 3;
    VERA.data0 = activeMinY[X] & 0xff;
    VERA.data0 = (activeMinY[X] >> 8) & 3;
}

//-----------------------------------------------------------------------------
void drawSetSpriteSize(int8_t X, uint8_t size) {
    VERA.address_hi = VERA_INC_0 | 1;
    VERA.address = VERA_SPRITES_BASE + (X * 8) + 7;
    VERA.data0 = (VERA.data0 & 0b00001111) | size;
}

//-----------------------------------------------------------------------------
void drawShowSprite(int8_t X, uint8_t zMask) {
    VERA.address_hi = VERA_INC_0 | 1;
    VERA.address = VERA_SPRITES_BASE + (X * 8) + 6;
    VERA.data0 |= zMask;
}

//-----------------------------------------------------------------------------
void drawThing(int8_t X) {
    activeFlags[X] &= ~(ACTIVEFLAGS_CLIPMASK);
    activeFlags[X] |= screenClips(X);

    if(activeFlags[X] & ACTIVEFLAGS_ISDEAD) {
        sprite_draw_dead[activeLayer[X]](X);
    } else {
        sprite_draw[activeLayer[X]](X);
    }
}
