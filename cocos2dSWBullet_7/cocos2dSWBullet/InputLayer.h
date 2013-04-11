//
//  InputLayer.h
//  cocos2dSWBullet
//
//  Created by shaowei on 12-6-4.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ColoredCircleSprite.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"

#import "SneakyExtension.h"

@interface InputLayer : CCLayer {
    SneakyButton *fireButton ;
    SneakyJoystick *joystick;
    
    ccTime totalTime;
    ccTime nextTime;
}

@end
