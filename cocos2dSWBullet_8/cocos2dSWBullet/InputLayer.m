//
//  InputLayer.m
//  cocos2dSWBullet
//
//  Created by shaowei on 12-6-4.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import "InputLayer.h"
#import "GameScene.h"

@interface InputLayer()

- (void)addFirebutton;
- (void)addJoystick;

@end



@implementation InputLayer

- (id)init {
    self = [super init];
    if (self) {
        [self addFirebutton];
        [self addJoystick];
        
        [self scheduleUpdate];
    }
    return self;
}


- (void)addFirebutton{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    float btnRadius = 50.0f;
    
    fireButton = [SneakyButton button];
    fireButton.isHoldable = YES;
    
    SneakyButtonSkinnedBase *skinBtn = [SneakyButtonSkinnedBase buttonSkinned];
    
    skinBtn.position = CGPointMake(screenSize.width - btnRadius * 1.5f, btnRadius * 1.5f);
    skinBtn.button = fireButton;
    skinBtn.defaultSprite = [CCSprite spriteWithSpriteFrameName:@"button-default.png"];
    skinBtn.pressSprite = [CCSprite spriteWithSpriteFrameName:@"button-pressed.png"];
    
    [self addChild:skinBtn];
}

- (void)addJoystick{
    float stickRadius = 50;
    joystick = [SneakyJoystick joystick:CGRectMake(0, 0, stickRadius, stickRadius)];
    joystick.autoCenter = YES;
    
//    joystick.isDPad = YES;
//    joystick.numberOfDirections = 8;
    
    SneakyJoystickSkinnedBase *skin = [SneakyJoystickSkinnedBase joystickSkinned];
    skin.position =  CGPointMake(stickRadius * 1.5f, stickRadius * 1.5f);
    skin.joystick = joystick;
    skin.backgroundSprite = [CCSprite spriteWithSpriteFrameName:@"button-disabled.png"];
    skin.backgroundSprite.color = ccMAGENTA;
    skin.thumbSprite = [CCSprite spriteWithSpriteFrameName:@"button-disabled.png"];
    skin.thumbSprite.scale = 0.5f;
    
    [self addChild:skin];
}

- (void)update:(ccTime)delta{
    
    totalTime = totalTime + delta;
    
   
    
    if (fireButton.active && (totalTime > nextTime)) {
        nextTime = totalTime + 0.5f;
        GameScene *scene = [GameScene shareGameScene];
        BulletCache *batch = [scene getBatchCache];
        Ship *ship = [scene defaultShip];
        CGPoint startPoint = CGPointMake(ship.position.x + ship.contentSize.width * 0.5f, ship.position.y);
        float spread = (CCRANDOM_0_1() - 0.5f) * 0.5f;
        CGPoint velocity = CGPointMake(4, spread);
        [batch shootBulletAt:startPoint
                    velocity:velocity
                   frameName:@"bullet.png" 
                 andIsPlayer:YES];
    }
    
    if (fireButton.active == NO) {
        nextTime = 0;
    }
    
    
    
    CGPoint speed = ccpMult(joystick.velocity, 200);
    if (!CGPointEqualToPoint(speed, CGPointZero)) {
        GameScene* game = [GameScene shareGameScene];
        Ship* ship = [game defaultShip];
        ship.position = CGPointMake(ship.position.x + speed.x*delta,
                                    ship.position.y + speed.y*delta);
    }
    
    
    
}

@end
