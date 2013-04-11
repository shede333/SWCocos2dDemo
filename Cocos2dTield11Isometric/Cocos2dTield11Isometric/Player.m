//
//  Player.m
//  Cocos2dTield11Isometric
//
//  Created by ZhiHuiGuan001 舍得 on 12-7-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player

+ (id)player{
    return [[[self alloc] initWithFile:@"ninja.png"] autorelease];
}

- (void)updateVertexZ:(CGPoint)tilePos tileMap:(CCTMXTiledMap *)tileMap{
    float zOfMin = - (tileMap.mapSize.width + tileMap.mapSize.height);
    float zOfCurrent = tilePos.x + tilePos.y;
    self.vertexZ = zOfMin + zOfCurrent - 1;
}


@end
