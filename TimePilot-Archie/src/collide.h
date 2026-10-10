//-----------------------------------------------------------------------------
// collide.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

void collideBomber(uint32_t colID0, uint32_t colID1);
void collideEnemy(uint32_t colID0, uint32_t colID1);
void collideEnemyBoomerang(uint32_t colID0, uint32_t colID1);
void collideEnemyRockets(uint32_t colID0, uint32_t colID1);
void collideEnemySpaceBullets(uint32_t colID0, uint32_t colID1);
void collideLevelBoss(uint32_t colID0, uint32_t colID1);
void collideParachute(uint32_t colID0, uint32_t colID1);
void collidePlayer(uint32_t colID0, uint32_t colID1);
void collideRemove(uint32_t colID0, uint32_t colID1);
void collideRts(uint32_t colID0, uint32_t colID1);
void collideThingExplode(uint32_t colID0);
void collideThings(uint32_t colID0, uint32_t colID1);
