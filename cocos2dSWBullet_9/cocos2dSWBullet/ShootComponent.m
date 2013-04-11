//
//  ShootComponent.m
//  cocos2dSWBullet
//
//  Created by shaowei on 12-6-11.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import "ShootComponent.h"
#import "GameScene.h"


@implementation ShootComponent
@synthesize shootFrequency;
@synthesize bulletName;

- (id)init {
    self = [super init];
    if (self) {
        [self scheduleUpdate];
    }
    return self;
}

- (void)update:(ccTime)delta{
    if (self.parent.visible) {
        updateCount ++;
        
        if (updateCount > shootFrequency) {
            updateCount = 0;
            GameScene *game = [GameScene shareGameScene];
            CGPoint point = ccpSub(self.parent.position, 
                                   CGPointMake(self.parent.contentSize.width * 0.5f, 0));
            [[game getBatchCache] shootBulletAt:point
                                       velocity:CGPointMake(-2.0f, 0.0f)
                                      frameName:bulletName 
                                    andIsPlayer:NO];
        }
    }
    
}





- (void)dealloc {
    [bulletName release];
    [super dealloc];
}

@end
