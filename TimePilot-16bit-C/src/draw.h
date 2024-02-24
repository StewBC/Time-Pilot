//-----------------------------------------------------------------------------
// draw.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

void draw11x11Expl_boom(int16_t X);
void draw13x13Expl_sblt(int16_t X);
void draw16x16Expl_wep(int16_t X);
void draw16x16Explosion(int16_t X);
void draw16x16TimeWarpAtX(int16_t X, int16_t x);
void draw32x16Explosion(int16_t X);
void drawAstros0(int16_t X);
void drawAstros0Part(int16_t X);
void drawAstros1(int16_t X);
void drawAstros1Part(int16_t X);
void drawAstros2(int16_t X);
void drawAstros2Part(int16_t X);
void drawBMPFully(int16_t X);
void drawBMPFullyWithFrame(int16_t X, int16_t F);
void drawBMPFullyWithFrameAndAlternate(int16_t X, int16_t F, int16_t alt);
void drawBMPPartly(int16_t X);
void drawBMPPartlyWithFrame(int16_t X, int16_t F);
void drawBMPPartlyWithFrameAndAlternate(int16_t X, int16_t F, int16_t alt);
void drawClouds0(int16_t X);
void drawClouds0Part(int16_t X);
void drawClouds1(int16_t X);
void drawClouds1Part(int16_t X);
void drawClouds2(int16_t X);
void drawClouds2Part(int16_t X);
void drawEnemyBombs(int16_t X);
void drawEnemyBoomerang(int16_t X);
void drawEnemyBoomerangPart(int16_t X);
void drawEnemyBullets(int16_t X);
void drawEnemyP0P1(int16_t X);
void drawEnemyP0P1Part(int16_t X);
void drawEnemyP2(int16_t X);
void drawEnemyP2Part(int16_t X);
void drawEnemyP3(int16_t X);
void drawEnemyP3Part(int16_t X);
void drawEnemyP4(int16_t X);
void drawEnemyP4Part(int16_t X);
void drawEnemyRockets(int16_t X);
void drawEnemyRocketsPart(int16_t X);
void drawEnemySpaceBullets(int16_t X);
void drawLevelBossP0P3(int16_t X);
void drawLevelBossP0P3Part(int16_t X);
void drawLevelBossP1P2(int16_t X);
void drawLevelBossP1P2Part(int16_t X);
void drawLevelBossP4(int16_t X);
void drawLevelBossP4Part(int16_t X);
void drawParachute(int16_t X);
void drawParachutePart(int16_t X);
void drawPlayer(int16_t X);
void drawPlayerBullets(int16_t X);
void drawRts(int16_t X);
void drawScores(int16_t X);
void drawThing(int16_t X);
void drawVisibleFully(int16_t X);
void drawVisiblePartly(int16_t X);
