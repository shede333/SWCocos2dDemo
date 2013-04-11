//
//  EnemyEntity.h
//  cocos2dSWBullet
//
//  Created by shaowei on 12-6-10.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Entity.h"

typedef enum
{
    EnemyTypeOfMan = 0,
    EnemyTypeOfSnake,
    EnemyTypeOfBoss,
    EnemyType_MAX,
}EnemyType;

@interface EnemyEntity : Entity {
    EnemyType type;
    int fullBlood;
    int hitNum;
}

@property (nonatomic,assign) int fullBlood;
@property (nonatomic,assign) int hitNum;


+(id)enemyWithType:(EnemyType)enemyType;
+(int)getSpawnFrequencyForEnimyType:(EnemyType)enemyType;
-(void)spawn;
- (void)goHit;

@end
