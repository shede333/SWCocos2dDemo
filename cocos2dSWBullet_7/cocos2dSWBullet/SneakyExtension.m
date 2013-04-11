//
//  SneakyExtension.m
//  cocos2dSWBullet
//
//  Created by shaowei on 12-6-4.
//  Copyright (c) 2012年 SWCaptain. All rights reserved.
//

#import "SneakyExtension.h"

@implementation SneakyButton(Extension)

+ (id)button{
    return [[[SneakyButton alloc] initWithRect:CGRectZero] autorelease];
}
+ (id)buttonWithRect:(CGRect)rect{
    return [[[SneakyButton alloc] initWithRect:rect] autorelease];
}

@end

/*******************************************/

@implementation SneakyButtonSkinnedBase(Extension)

+ (id)buttonSkinned{
    return [[[SneakyButtonSkinnedBase alloc] init] autorelease];
}

@end

/*******************************************/

@implementation SneakyJoystick(Extension)

+ (id)joystick:(CGRect)rect{
    return [[[SneakyJoystick alloc] initWithRect:rect] autorelease];
}

@end

/*******************************************/

@implementation SneakyJoystickSkinnedBase(Extension)

+ (id)joystickSkinned{
    return [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
}

@end
