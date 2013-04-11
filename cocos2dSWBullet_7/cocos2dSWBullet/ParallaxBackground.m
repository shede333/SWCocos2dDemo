//
//  ParallaxBackground.m
//  cocos2dSWBullet
//
//  Created by shaowei on 12-5-30.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import "ParallaxBackground.h"


@implementation ParallaxBackground

- (id)init {
    self = [super init];
    if (self) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        CCTextureCache *cache = [CCTextureCache sharedTextureCache];
        CCTexture2D *texture = [cache addImage:@"game-art.png"];
        
        batch = [CCSpriteBatchNode batchNodeWithTexture:texture];
        [self addChild:batch];
        
        numOfSprite = 7;
        
        for (int i = 0; i < numOfSprite; i++) {
            NSString* frameName = [NSString stringWithFormat:@"bg%i.png", i];
            CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:frameName];
            sprite.anchorPoint = CGPointMake(0, 0.5);
            sprite.position = CGPointMake(0, screenSize.height/2);
            [batch addChild:sprite z:i tag:i];
        }
        
        for (int i = 0; i < numOfSprite; i++) {
            NSString* frameName = [NSString stringWithFormat:@"bg%i.png", i];
            CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:frameName];
            sprite.anchorPoint = CGPointMake(0, 0.5);
            sprite.position = CGPointMake(screenSize.width - 1, screenSize.height/2);
            sprite.flipX = YES;
            [batch addChild:sprite z:i tag:i+numOfSprite];
        }
        
        speed = 1.0f;
   
        arrOfspace = [[CCArray alloc] initWithCapacity:numOfSprite];
		[arrOfspace addObject:[NSNumber numberWithFloat:0.3f]];
		[arrOfspace addObject:[NSNumber numberWithFloat:0.5f]];
		[arrOfspace addObject:[NSNumber numberWithFloat:0.5f]];
		[arrOfspace addObject:[NSNumber numberWithFloat:0.8f]];
		[arrOfspace addObject:[NSNumber numberWithFloat:0.8f]];
		[arrOfspace addObject:[NSNumber numberWithFloat:1.2f]];
		[arrOfspace addObject:[NSNumber numberWithFloat:1.2f]];
        
        [self scheduleUpdate];
    }
    return self;
}

- (void)dealloc {
    [arrOfspace release];
    [super dealloc];
}

- (void)update:(ccTime)delta{
//    return;
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCSprite *sprite;
    CCARRAY_FOREACH([batch  children], sprite)
    {
        NSNumber *subSpeed = [arrOfspace objectAtIndex:sprite.zOrder];
        CGPoint point = sprite.position;
        point.x -= (speed * [subSpeed floatValue]);
        
        
        if (point.x < -screenSize.width) {
            point.x += screenSize.width *2 - 2;
        }
        
        sprite.position = point;
    }
    
    
}

















@end
