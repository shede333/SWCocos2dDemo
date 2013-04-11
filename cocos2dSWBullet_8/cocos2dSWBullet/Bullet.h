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
    CGPoint myVelocity;
    float outScreen;
}

@property (nonatomic,assign) BOOL isPlsyer;

+ (id)bullet;

-(void) shootBulletAt:(CGPoint)startPosition 
             velocity:(CGPoint)velocity 
            frameName:(NSString*)frameName;

@end
