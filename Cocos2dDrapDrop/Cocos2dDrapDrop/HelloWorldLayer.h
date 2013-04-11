//
//  HelloWorldLayer.h
//  Cocos2dDrapDrop
//
//  Created by ZhiHuiGuan001 舍得 on 12-7-23.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"


typedef enum{
    eChildOfBackground = 0,
}eChild;

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer<CCTargetedTouchDelegate>
{
    
    CCSprite * background;
    CCSprite * selSprite;
    NSMutableArray * movableSprites;

}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
