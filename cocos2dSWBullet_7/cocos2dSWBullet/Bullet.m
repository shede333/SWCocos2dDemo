//
//  Bullet.m
//  cocos2dSWBullet
//
//  Created by shaowei on 12-5-24.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import "Bullet.h"
#import "GameScene.h"

@interface Bullet()

- (id)initwithImage;

@end

@implementation Bullet

+ (id)bullet{
    return [[[self alloc] initwithImage] autorelease];
}

- (id)initwithImage{
//    if (self = [super initWithFile:@"bullet.png"]) {
    if (self = [super initWithSpriteFrameName:@"bullet.png"]) {
        isExit = YES;
   
        self.visible = NO;
        
    }
    return self;
}

-(void) shootBulletFromShip:(Ship*)ship{
    
    float spread = (CCRANDOM_0_1() - 0.5f) * 0.5f;
    velocity = CGPointMake(1, spread);
    outScreen = [[CCDirector sharedDirector] winSize].width;
    
    self.position = CGPointMake(ship.position.x + ship.contentSize.width * 0.5f, ship.position.y);
    self.visible = YES;
    
    if (isExit) {
        isExit = NO;
        [self scheduleUpdate];
    }
}


- (void)update:(ccTime)delta{
    self.position = ccpAdd(self.position, velocity);
    if (self.position.x > outScreen) {
        self.visible = NO;
        isExit = YES;
        [self unscheduleUpdate];
    }
    
}

-(void) shootBulletAt:(CGPoint)startPosition 
             velocity:(CGPoint)velocity 
            frameName:(NSString*)frameName{
    
}

@end
