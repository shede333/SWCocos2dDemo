//
//  EnemyCache.m
//  cocos2dSWBullet
//
//  Created by shaowei on 12-6-10.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import "EnemyCache.h"
#import "EnemyEntity.h"
#import "GameScene.h"

@interface EnemyCache ()

-(void) initEnemies;
- (void)checkForBulletCollisions;
@end


@implementation EnemyCache

- (id)init {
    self = [super init];
    if (self) {
        CCSpriteFrame *spriteFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"monster-a.png"];
        batch = [CCSpriteBatchNode batchNodeWithTexture:spriteFrame.texture];
        [self addChild:batch];
        
        [self initEnemies];
        [self scheduleUpdate];
    }
    return self;
}

-(void) initEnemies{
    enemies = [[CCArray alloc] initWithCapacity:EnemyType_MAX];
    for (int i = 0; i < EnemyType_MAX; i++) {
        int capacity;
        switch (i) {
            case EnemyTypeOfMan:
                capacity = 6;
                break;
            case EnemyTypeOfSnake:
                capacity = 3;
                break;
            case EnemyTypeOfBoss:
                capacity = 1;
                break;
                
            default:
                [NSException exceptionWithName:@"EnemyCache" reason:@"EnemyCache empty type" userInfo:nil];
                break;
        }
        
        
        CCArray *enemyType = [[CCArray alloc] initWithCapacity:capacity];
        [enemies addObject:enemyType];
        [enemyType release];
    }
    
    for (int i = 0; i < EnemyType_MAX; i ++) {
        CCArray *enemyArr = [enemies objectAtIndex:i];
        int num = [enemyArr capacity];
        CCLOG(@"capacity-num: %d:%d",num,i);
        for (int j = 0; j < num; j++) {
            EnemyEntity *enemy = [EnemyEntity enemyWithType:i];
            [enemyArr addObject:enemy ];
            [batch addChild:enemy z:0 tag:i];
        }
    }
    
    
    
}

- (void)spawnEnemyType:(EnemyType)enemyType{
    CCArray *arrOfEnemy = [enemies objectAtIndex:enemyType];
    
    EnemyEntity *enemy;
    CCARRAY_FOREACH(arrOfEnemy, enemy)
    {
        if (enemy.visible == NO) {
            [enemy spawn];
            break;
        }
    }
}

- (void)update:(ccTime)delta{
    updateCount ++;
    for (int i = EnemyType_MAX - 1; i >= 0; i--) {
        int spawnFrequence = [EnemyEntity getSpawnFrequencyForEnimyType:i];
        if (updateCount % spawnFrequence == 0) {
            [self spawnEnemyType:i];
            break;
        }
    }
    
    [self checkForBulletCollisions];
}

- (void)checkForBulletCollisions{
    EnemyEntity *enemy;
    CCARRAY_FOREACH([batch children], enemy)
    {
        if (enemy.visible) {
            BulletCache *bullet = [[GameScene shareGameScene] getBatchCache];
            CGRect rect = enemy.boundingBox;
            if ([bullet playerAndBulletCheckWithRect:rect]) {
                [enemy goHit];
            }
        }
    }
}





- (void)dealloc {
    [enemies release];
    [super dealloc];
}

@end
