//
//  ShipEntity.m
//  cocos2dSWBullet
//
//  Created by shaowei on 12-6-10.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import "ShipEntity.h"
#import "CCAnimation+Helper.h"

@implementation ShipEntity


- (id)initWithImage{
    if ([super initWithSpriteFrameName:@"ship.png"]) {
        CCAnimation *animation = [CCAnimation animationWithFrame:@"ship-anim"
                                                      frameCount:5
                                                           delay:0.08];
        CCAnimate *animate = [CCAnimate actionWithAnimation:animation];
        CCRepeatForever *repeat = [CCRepeatForever actionWithAction:animate];
        [self runAction:repeat];
    }
    return self;
}




+(id)ship{
    return [[[self alloc] initWithImage] autorelease];
}

@end
