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
//        [self runAction:repeat];
        
        
        CCParticleSystem *sys = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"myFire.plist"];
        sys.positionType = kCCPositionTypeFree;
        sys.autoRemoveOnFinish = YES;
        sys.position = CGPointMake(0, self.contentSize.height * 0.5f);
//        sys.texture = [[CCTextureCache sharedTextureCache] addImage:@"snow.png"];
        [self addChild:sys];
    }
    return self;
}




+(id)ship{
    return [[[self alloc] initWithImage] autorelease];
}

@end
