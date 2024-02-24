//-----------------------------------------------------------------------------
// collide.h
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#pragma once

void collideBomber(uint8_t colID0, uint8_t colID1);
void collideEnemy(uint8_t colID0, uint8_t colID1);
void collideEnemyBoomerang(uint8_t colID0, uint8_t colID1);
void collideEnemyRockets(uint8_t colID0, uint8_t colID1);
void collideEnemySpaceBullets(uint8_t colID0, uint8_t colID1);
void collideLevelBoss(uint8_t colID0, uint8_t colID1);
void collideParachute(uint8_t colID0, uint8_t colID1);
void collidePlayer(uint8_t colID0, uint8_t colID1);
void collideRemove(uint8_t colID0, uint8_t colID1);
void collideRts(uint8_t colID0, uint8_t colID1);
void collideThingExplode(uint8_t colID0);
void collideThings(uint8_t colID0, uint8_t colID1);
