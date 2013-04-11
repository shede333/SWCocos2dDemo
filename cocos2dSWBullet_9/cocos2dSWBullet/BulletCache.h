//
//  BulletCache.h
//  cocos2dSWBullet
//
//  Created by shaowei on 12-6-7.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BulletCache : CCNode {
    CCSpriteBatchNode *batch;
    int nextBullet;
}

-(void) shootBulletAt:(CGPoint)startPosition velocity:(CGPoint)velocity frameName:(NSString*)frameName andIsPlayer:(BOOL)isPlayer;
- (BOOL)playerAndBulletCheckWithRect:(CGRect)rect;

- (BOOL)enemyAndBulletCheckWithRect:(CGRect)rect;

@end
