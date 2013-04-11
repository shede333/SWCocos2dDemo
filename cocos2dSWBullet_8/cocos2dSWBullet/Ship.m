//
//  ship.m
//  cocos2dSWBullet
//
//  Created by shaowei on 12-5-24.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import "ship.h"
#import "GameScene.h"
#import "CCAnimation+Helper.h"

@interface Ship()

- (id)initWithImage;

@end


@implementation Ship

+ (id)ship{
    return [[[self alloc] initWithImage] autorelease];
}

- (id)initWithImage{
//    if (self = [super initWithFile:@"ship.png"]) {
//        [self scheduleUpdate];
//    }
//    
//    return self;
    
    
    
    if (self = [super initWithFile:@"ship1.png"]) {
        
        CCAnimation *animation = [CCAnimation animationWithFrame:@"ship-anim" frameCount:5 delay:0.08];
        CCAnimate *animate = [CCAnimate actionWithAnimation:animation];
        CCRepeatForever *fo = [CCRepeatForever actionWithAction:animate];
        [self runAction:fo];
        
        
//        [self scheduleUpdate];
    }
    return self;
}

//-(void) update:(ccTime)delta{
//    [[GameScene shareGameScene] shootBulletFromShip:self];
//}


-(void) setPosition:(CGPoint)pos{
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
	float halfWidth = self.contentSize.width * 0.5f;
	float halfHeight = contentSize_.height * 0.5f;
    
	// Cap the position so the Ship's sprite stays on the screen
	if (pos.x < halfWidth)
	{
		pos.x = halfWidth;
	}
	else if (pos.x > (screenSize.width - halfWidth))
	{
		pos.x = screenSize.width - halfWidth;
	}
	
	if (pos.y < halfHeight)
	{
		pos.y = halfHeight;
	}
	else if (pos.y > (screenSize.height - halfHeight))
	{
		pos.y = screenSize.height - halfHeight;
	}
    
    
    [super setPosition:pos];
}







@end
