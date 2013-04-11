//
//  GameScene.m
//  cocos2dSWBullet
//
//  Created by shaowei on 12-5-24.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import "GameScene.h"
#import "ParallaxBackground.h"
#import "InputLayer.h"
#import "ShipEntity.h"
#import "EnemyCache.h"


@implementation GameScene

+(id)scene{
    CCScene *scene = [CCScene node];
    GameScene *layer = [GameScene node];
    [scene addChild:layer];
    
    InputLayer* inputLayer = [InputLayer node];
	[scene addChild:inputLayer z:1 tag:22];
    
    return scene;
}

static GameScene* instanceOfGameScene;
+ (GameScene *)shareGameScene{
    return instanceOfGameScene;
}

- (id)init {
    self = [super init];
    if (self) {
        instanceOfGameScene = self;
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        CCSpriteFrameCache *cache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [cache addSpriteFramesWithFile:@"game-art.plist"];
        
//        CCSprite *backGround = [CCSprite spriteWithFile:@"background.png"];
//        backGround.anchorPoint = CGPointMake(0, 0);
//        [self addChild:backGround];
        
        ParallaxBackground *bgd = [ParallaxBackground node];
        [self addChild:bgd z:-1];
        
        CGRect reRect = CGRectMake(0, 0, 240, 160);
        CCSprite *mybgd = [CCSprite spriteWithFile:@"mySquare.png" rect:reRect];
        mybgd.anchorPoint = CGPointMake(0, 0);
        ccTexParams params = 
        {
            GL_LINEAR,
            GL_LINEAR,
            GL_REPEAT,
            GL_REPEAT
        };
        
        [mybgd.texture setTexParameters:&params];
        [self addChild:mybgd];
        
        
        ShipEntity *myShip = [ShipEntity ship];
        myShip.position = CGPointMake(myShip.contentSize.width/2 + 80, screenSize.height/2);
//        myShip.position = CGPointMake(myShip.contentSize.width/2, screenSize.height/2);
        [self addChild:myShip z:0 tag:eMyChildShip];
        
        EnemyCache *enemy = [EnemyCache node];
        [self addChild:enemy z:0 tag:eMyChildEnemyCache];
        
        BulletCache *batch = [BulletCache node];
        [self addChild:batch z:0 tag:eMyChildBatchCache];
        
    }
    return self;
}

- (BulletCache *)getBatchCache{
    return (BulletCache *)[self getChildByTag:eMyChildBatchCache];
}

//-(void) shootBulletFromShip:(Ship*)ship{
//    
//    Bullet *bullet = [[[self getBatch] children] objectAtIndex:numOfBullet];
//    [bullet shootBulletFromShip:ship];
//    
//    numOfBullet ++;
//    if (numOfBullet >= [[self getBatch] children].count) {
//        numOfBullet = 0;
//    }
//}

-(Ship*) defaultShip
{
	CCNode* node = [self getChildByTag:eMyChildShip];
	NSAssert([node isKindOfClass:[ShipEntity class]], @"node is not a Ship!");
	return (Ship*)node;
}





@end
