//
//  GameScene.h
//  cocos2dSWBullet
//
//  Created by shaowei on 12-5-24.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Ship.h"
#import "Bullet.h"


typedef enum{
    eBatchBullet=1,
}flagChild;

typedef enum
{
    eMyChildShip = 4,
}eMyChild;

@interface GameScene : CCLayer {
    int numOfBullet;
}

+(id)scene;

+ (GameScene *)shareGameScene;

-(void) shootBulletFromShip:(Ship*)ship;

-(Ship*) defaultShip;

@end
