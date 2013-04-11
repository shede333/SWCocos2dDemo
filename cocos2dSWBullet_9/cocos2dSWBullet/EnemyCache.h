//
//  EnemyCache.h
//  cocos2dSWBullet
//
//  Created by shaowei on 12-6-10.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface EnemyCache : CCNode {
    CCSpriteBatchNode *batch;
    CCArray *enemies;
    int updateCount;
}

@end
