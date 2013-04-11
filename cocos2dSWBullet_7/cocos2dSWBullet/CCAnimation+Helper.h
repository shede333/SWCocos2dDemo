//
//  CCAnimation+Helper.h
//  cocos2dSWBullet
//
//  Created by shaowei on 12-5-28.
//  Copyright (c) 2012年 SWCaptain. All rights reserved.
//

#import "CCAnimation.h"
#import "cocos2d.h"

@interface CCAnimation (Helper)

+(CCAnimation*) animationWithFile:(NSString*)name frameCount:(int)frameCount delay:(float)delay;
+(CCAnimation*) animationWithFrame:(NSString*)frame frameCount:(int)frameCount delay:(float)delay;

@end
