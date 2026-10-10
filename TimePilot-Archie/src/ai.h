//-----------------------------------------------------------------------------
// ai.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.
#pragma once

void aiAddVelocity(int32_t X, int32_t Y);
void aiBomber(int32_t X);
void aiChkWrap(int32_t X);
void aiClouds0(int32_t X);
void aiClouds1(int32_t X);
void aiClouds2(int32_t X);
void aiEndFrame();
void aiEnemy(int32_t X);
void aiEnemyBombs(int32_t X);
void aiEnemyBoomerang(int32_t X);
void aiEnemyBullets(int32_t X);
void aiEnemyRockets(int32_t X);
void aiEnemySpaceBullets(int32_t X);
void aiExplodeThing(int32_t X);
void aiHorizontalFlyer(int32_t X);
void aiLevelBoss(int32_t X);
void aiNonWrapping(int32_t X);
void aiParachute(int32_t X);
void aiPlayer(int32_t X);
void aiPlayerBullets(int32_t X);
int32_t aiRandom();
void aiRecallEnemies();
void aiRts(int32_t X);
void aiScores(int32_t X);
void aiSpawnEnemy();
void aiSpawnWave();
void aiThing(int32_t X);
uint32_t aiTurnOnRay(uint32_t X);
