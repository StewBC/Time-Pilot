//-----------------------------------------------------------------------------
// ai.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.
#pragma once

void aiAddVelocity(int16_t X, int16_t Y);
void aiBomber(int16_t X);
void aiChkWrap(int16_t X);
void aiClouds0(int16_t X);
void aiClouds1(int16_t X);
void aiClouds2(int16_t X);
void aiEndFrame();
void aiEnemy(int16_t X);
void aiEnemyBombs(int16_t X);
void aiEnemyBoomerang(int16_t X);
void aiEnemyBullets(int16_t X);
void aiEnemyRockets(int16_t X);
void aiEnemySpaceBullets(int16_t X);
void aiExplodeThing(int16_t X);
void aiHorizontalFlyer(int16_t X);
void aiLevelBoss(int16_t X);
void aiNonWrapping(int16_t X);
void aiParachute(int16_t X);
void aiPlayer(int16_t X);
void aiPlayerBullets(int16_t X);
int16_t aiRandom();
void aiRecallEnemies();
void aiRts(int16_t X);
void aiScores(int16_t X);
void aiSpawnEnemy();
void aiSpawnWave();
void aiThing(int16_t X);
uint16_t aiTurnOnRay(uint16_t X);
