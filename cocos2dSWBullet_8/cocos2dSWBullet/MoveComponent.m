//
//  MoveComponent.m
//  cocos2dSWBullet
//
//  Created by shaowei on 12-6-11.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import "MoveComponent.h"
#import "Entity.h"


@implementation MoveComponent

- (id)init {
    self = [super init];
    if (self) {
        velocity = CGPointMake(-1.0f, 0);
        [self scheduleUpdate];
    }
    return self;
}

- (void)update:(ccTime)delta{
    if (self.parent.visible) {
        
        NSAssert([self.parent isKindOfClass:[Entity class]],@"Not Entity");
        Entity *entity = (Entity *)self.parent;
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        if (entity.position.x > screenSize.width * 0.5f) {
            entity.position = ccpAdd(entity.position, velocity);
        }
    }
}

@end
