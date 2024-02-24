//-----------------------------------------------------------------------------
// draw.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

void draw11x11Expl_boom(int8_t X);
void draw13x13Expl_sblt(int8_t X);
void draw16x16Expl_wep(int8_t X);
void draw16x16Explosion(int8_t X);
void draw32x16Explosion(int8_t X);
void drawEnemyBomber(int8_t X);
void drawEnemyBombs(int8_t X);
void drawEnemyBoomerang(int8_t X);
void drawEnemyBullets(int8_t X);
void drawEnemyP0P1P3(int8_t X);
void drawEnemyP2(int8_t X);
void drawEnemyP4(int8_t X);
void drawEnemyRockets(int8_t X);
void drawEnemySpaceBullets(int8_t X);
void drawLevelBossP0P1P2P3(int8_t X);
void drawLevelBossP4(int8_t X);
void drawParachute(int8_t X);
void drawPlayer(int8_t X);
void drawPlayerBullets(int8_t X);
void drawRts(int8_t X);
void drawScores(int8_t X);
void drawSetOtherSprite(int8_t X, uint8_t layer, uint16_t posX, uint16_t posY, uint8_t frameOffset);
void drawSetSpriteFrame(int8_t X, uint8_t frameOffset);
void drawSetSpritePosition(int8_t X);
void drawSetSpritePositionAndFrame(int8_t X, uint8_t frameOffset);
void drawSetSpritePositionAndFrameForBosses(int8_t X, uint8_t frameOffset);
void drawSetSpritePositionAndFrameForEnemies(int8_t X, uint8_t frameOffset);
void drawSetSpritePositionAndFrameForExplosions(int8_t X, uint8_t type, uint8_t frameOffset);
void drawSetSpriteSize(int8_t X, uint8_t size);
void drawShowSprite(int8_t X, uint8_t zMask);
void drawThing(int8_t X);
