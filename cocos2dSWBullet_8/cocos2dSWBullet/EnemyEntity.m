//
//  EnemyEntity.m
//  cocos2dSWBullet
//
//  Created by shaowei on 12-6-10.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import "EnemyEntity.h"
#import "MoveComponent.h"
#import "ShootComponent.h"
#import "HealthBarComponent.h"

@interface EnemyEntity()

- (void)initspawnFrequency;
//- (id)initWithType:(EnemyType)enemyType;

@end


@implementation EnemyEntity
@synthesize fullBlood;
@synthesize hitNum;

- (id)initWithType:(EnemyType)enemyType{
    type = enemyType;
    NSString *frameName;
    NSString *bulletName;
    int shootFrequence = 300;
    int subFullBlood;
    
    CCLOG(@"type :%d",type);
    switch (type) {
        case EnemyTypeOfMan:
            frameName = @"monster-a.png";
            bulletName = @"candystick.png";
            subFullBlood = 2;
            
            break;
        case EnemyTypeOfSnake:
            frameName = @"monster-b.png";
            bulletName = @"redcross.png";
            shootFrequence = 200;
            subFullBlood = 4;
            break;
        case EnemyTypeOfBoss:
            frameName = @"monster-c.png";
            bulletName = @"blackhole.png";
            shootFrequence = 100;
            subFullBlood = 8;
            break;
            
        default:
            [NSException exceptionWithName:@"EnemyEntity Exception"
                                    reason:@"default nil"
                                  userInfo:nil];
            break;
    }
    CCLOG(@"frameName :%@",frameName);
    
    if ([super initWithSpriteFrameName:frameName]) {
        
        self.hitNum = subFullBlood;
        self.fullBlood = subFullBlood;
        [self addChild:[MoveComponent node]];
        
        ShootComponent *shoot = [ShootComponent node];
        shoot.shootFrequency = shootFrequence;
        shoot.bulletName = bulletName;
        [self addChild:shoot];
        
        HealthBarComponent *healthBar = [HealthBarComponent spriteWithSpriteFrameName:@"healthbar.png"];
        [healthBar reset];
        
        [self addChild:healthBar];
        
        self.visible = NO;
        [self initspawnFrequency];
    }
    return self;
    
}


+(id)enemyWithType:(EnemyType)enemyType{
    return [[[self alloc] initWithType:enemyType] autorelease];
}



static CCArray *spawnFrequency;
- (void)initspawnFrequency{
    if (spawnFrequency == nil) {
        spawnFrequency = [[CCArray alloc] initWithCapacity:EnemyType_MAX];
        [spawnFrequency insertObject:[NSNumber numberWithInt:80] atIndex:EnemyTypeOfMan];
        [spawnFrequency insertObject:[NSNumber numberWithInt:260] atIndex:EnemyTypeOfSnake];
        [spawnFrequency insertObject:[NSNumber numberWithInt:1500] atIndex:EnemyTypeOfBoss];
        [self spawn];
    }
}

+(int)getSpawnFrequencyForEnimyType:(EnemyType)enemyType{
    NSAssert(enemyType < EnemyType_MAX,@"invalid EnemyType");
    return [[spawnFrequency objectAtIndex:enemyType] intValue];
}


- (void)spawn{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CGSize spriteSize = [self contentSize];
    
    float xPoi = screenSize.width + spriteSize.width * 0.5f;
    float yPoi = CCRANDOM_0_1()*(screenSize.height - spriteSize.height) + spriteSize.height * 0.5f;
    self.position = CGPointMake(xPoi, yPoi);
    
    hitNum = fullBlood;
    self.visible = YES;
    
    CCNode *node;
    CCARRAY_FOREACH([self children], node)
    {
        if ([node isKindOfClass:[HealthBarComponent class]]) {
            HealthBarComponent *healthBar = (HealthBarComponent *)node;
            [healthBar reset];
        }
    }
}

- (void)dealloc {
    [spawnFrequency release];
    spawnFrequency = nil;
    [super dealloc];
}

- (void)goHit{
    hitNum--;
    CCNode *node;
    CCARRAY_FOREACH([self children], node)
    {
        if ([node isKindOfClass:[HealthBarComponent class]]) {
            HealthBarComponent *health = (HealthBarComponent *)node;
            health.scaleX = hitNum/(float)fullBlood;
        }
    }
    
    if (hitNum <= 0) {
        self.visible = NO;
    };
}



@end
