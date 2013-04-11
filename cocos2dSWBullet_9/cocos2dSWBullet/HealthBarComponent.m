//
//  HealthBarComponent.m
//  cocos2dSWBullet
//
//  Created by shaowei on 12-6-11.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import "HealthBarComponent.h"


@implementation HealthBarComponent

- (id)init {
    self = [super init];
    if (self) {
        self.anchorPoint = CGPointMake(0.5f, 1.0f);
    }
    return self;
}

- (void)reset{
    self.position = CGPointMake(self.parent.contentSize.width * 0.5f, 
                                self.parent.contentSize.height);
    self.scaleX = 1.0f;
    self.visible = YES;
}
@end
