//
//  Bullet.h
//  cocos2dSWBullet
//
//  Created by shaowei on 12-5-24.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Ship.h";

@interface Bullet : CCSprite {
    BOOL isExit;
    CGPoint velocity;
    float outScreen;
}

+ (id)bullet;

-(void) shootBulletFromShip:(Ship*)ship;
-(void) shootBulletAt:(CGPoint)startPosition 
             velocity:(CGPoint)velocity 
            frameName:(NSString*)frameName;

@end
