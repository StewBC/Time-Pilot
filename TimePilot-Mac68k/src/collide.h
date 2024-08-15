//-----------------------------------------------------------------------------
// collide.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

void collideBomber(uint16_t colID0, uint16_t colID1);
void collideEnemy(uint16_t colID0, uint16_t colID1);
void collideEnemyBoomerang(uint16_t colID0, uint16_t colID1);
void collideEnemyRockets(uint16_t colID0, uint16_t colID1);
void collideEnemySpaceBullets(uint16_t colID0, uint16_t colID1);
void collideLevelBoss(uint16_t colID0, uint16_t colID1);
void collideParachute(uint16_t colID0, uint16_t colID1);
void collidePlayer(uint16_t colID0, uint16_t colID1);
void collideRemove(uint16_t colID0, uint16_t colID1);
void collideRts(uint16_t colID0, uint16_t colID1);
void collideThingExplode(uint16_t colID0);
void collideThings(uint16_t colID0, uint16_t colID1);
