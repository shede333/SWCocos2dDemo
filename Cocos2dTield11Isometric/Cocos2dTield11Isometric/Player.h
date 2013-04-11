//
//  Player.h
//  Cocos2dTield11Isometric
//
//  Created by ZhiHuiGuan001 舍得 on 12-7-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Player : CCSprite {
    
}


+ (id)player;
- (void)updateVertexZ:(CGPoint)tilePos tileMap:(CCTMXTiledMap *)tileMap;

@end
