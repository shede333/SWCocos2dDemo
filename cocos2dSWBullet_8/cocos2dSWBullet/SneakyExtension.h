//
//  SneakyExtension.h
//  cocos2dSWBullet
//
//  Created by shaowei on 12-6-4.
//  Copyright (c) 2012年 SWCaptain. All rights reserved.
//

#import "CCLayer.h"

#import "ColoredCircleSprite.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"


@interface SneakyButton(Extension)

+ (id)button;
+ (id)buttonWithRect:(CGRect)rect;

@end

/*******************************************/

@interface SneakyButtonSkinnedBase(Extension)

+ (id)buttonSkinned;

@end

/*******************************************/

@interface SneakyJoystick(Extension)

+ (id)joystick:(CGRect)rect;

@end

/*******************************************/

@interface SneakyJoystickSkinnedBase(Extension)

+ (id)joystickSkinned;

@end


