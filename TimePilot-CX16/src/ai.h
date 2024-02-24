//-----------------------------------------------------------------------------
// ai.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

void aiAddVelocity(int8_t X, uint8_t Y);
void aiBomber(int8_t X);
void aiChkWrap(int8_t X);
void aiClouds0(int8_t X);
void aiClouds1(int8_t X);
void aiClouds2(int8_t X);
void aiEndFrame();
void aiEnemy(int8_t X);
void aiEnemyBombs(int8_t X);
void aiEnemyBoomerang(int8_t X);
void aiEnemyBullets(int8_t X);
void aiEnemyRockets(int8_t X);
void aiEnemySpaceBullets(int8_t X);
void aiExplodeThing(int8_t X);
void aiHorizontalFlyer(int8_t X);
void aiLevelBoss(int8_t X);
void aiNonWrapping(int8_t X);
void aiParachute(int8_t X);
void aiPlayer(int8_t X);
void aiPlayerBullets(int8_t X);
int8_t aiRandom();
void aiRecallEnemies();
void aiRts(int8_t X);
void aiScores(int8_t X);
void aiSpawnEnemy();
void aiSpawnWave();
void aiThing(int8_t X);
uint8_t aiTurnOnRay(uint8_t X);
