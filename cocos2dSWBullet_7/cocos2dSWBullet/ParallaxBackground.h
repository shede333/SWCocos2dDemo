//
//  ParallaxBackground.h
//  cocos2dSWBullet
//
//  Created by shaowei on 12-5-30.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ParallaxBackground : CCNode {
    
    int numOfSprite;
    CCArray *arrOfspace;
    CCSpriteBatchNode *batch;
    float speed;
}

@end
