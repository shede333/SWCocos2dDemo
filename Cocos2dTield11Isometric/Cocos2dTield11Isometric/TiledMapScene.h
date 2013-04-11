//
//  TiledMapScene.h
//  Cocos2dTield11Isometric
//
//  Created by ZhiHuiGuan001 舍得 on 12-7-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Player.h"

typedef enum
{
    eChildOfMin,
    eChildOfTiledMap = 1,
    eChildOfPlayer = 2,
}eChild;

typedef enum
{
    eDirectionOfNone,
    eDirectionOfUpLeft,
    eDirectionOfUpRight,
    eDirectionOfDownLeft,
    eDirectionOfDownRight,
    eDirectionOfMax,
    
}eDirection;

@interface TiledMapScene : CCLayer {
    Player* player;
    CGPoint playableAreaMin, playableAreaMax;
    
    CGPoint screenCenter;
    CGRect upLeft,upRight,downLeft,downRight;
    CGPoint moveOffset[eDirectionOfMax];
    eDirection currentDirection;
}

+ (id)scene;

@end
