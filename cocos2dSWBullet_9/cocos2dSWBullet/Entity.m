//
//  Entity.m
//  cocos2dSWBullet
//
//  Created by shaowei on 12-6-10.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import "Entity.h"



@implementation Entity

- (void)setPosition:(CGPoint)position{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    float halfWidth = self.contentSize.width * 0.5f;
    float halfHeight = self.contentSize.width * 0.5f;
    
    if (position.x < halfWidth) {
        position.x = halfWidth;
    }else if(position.x > (screenSize.width - halfWidth)){
        position.x = screenSize.width - halfWidth;
    }
    
    if (position.y < halfHeight) {
        position.y = halfHeight;
    }else if(position.y > (screenSize.height - halfHeight)){
        position.y = screenSize.height - halfHeight;
    }
    
    [super setPosition:position];
}

@end
