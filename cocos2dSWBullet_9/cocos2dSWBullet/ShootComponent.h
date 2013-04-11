//
//  ShootComponent.h
//  cocos2dSWBullet
//
//  Created by shaowei on 12-6-11.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ShootComponent : CCSprite {
    int updateCount;
    int shootFrequence;
    NSString *bulletName;
    
}

@property (nonatomic,retain) NSString *bulletName;
@property (nonatomic,assign) int shootFrequency;

@end
