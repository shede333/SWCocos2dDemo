//
//  BulletCache.m
//  cocos2dSWBullet
//
//  Created by shaowei on 12-6-7.
//  Copyright 2012年 SWCaptain. All rights reserved.
//

#import "BulletCache.h"
#import "Bullet.h"

@interface BulletCache()

- (BOOL)isCollisionWithRect:(CGRect)rect andIsPlayer:(BOOL)isPlayer;

@end


@implementation BulletCache

- (id)init {
    self = [super init];
    if (self) {
        CCSpriteFrame *spriteFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bullet.png"];
        batch = [CCSpriteBatchNode batchNodeWithTexture:spriteFrame.texture];
        
        [self addChild:batch];
        
        for (int i = 0; i < 200; i ++) {
            Bullet *bullet = [Bullet bullet];
            bullet.visible = NO;
            [batch addChild:bullet];
        }
    }
    return self;
}

- (void)dealloc {
    [batch release];
    [super dealloc];
}

-(void) shootBulletAt:(CGPoint)startPosition 
             velocity:(CGPoint)velocity 
            frameName:(NSString*)frameName
          andIsPlayer:(BOOL)isPlayer{
    
    CCNode *sub = [[batch children] objectAtIndex:nextBullet];
    NSAssert([sub isKindOfClass:[Bullet class]],@"bullet no");
    Bullet *bullet = (Bullet *)sub;
    bullet.isPlsyer = isPlayer;
    [bullet shootBulletAt:startPosition
                 velocity:velocity
                frameName:frameName];
    nextBullet ++;
    if (nextBullet > [[batch children]count]) {
        nextBullet = 0;
    }
}

- (BOOL)playerAndBulletCheckWithRect:(CGRect)rect{
    return [self isCollisionWithRect:rect andIsPlayer:YES];
}

- (BOOL)enemyAndBulletCheckWithRect:(CGRect)rect{
    return [self isCollisionWithRect:rect andIsPlayer:NO];
}

- (BOOL)isCollisionWithRect:(CGRect)rect andIsPlayer:(BOOL)isPlayer{
    BOOL isCollision = NO;
    Bullet *bullet;
    CCARRAY_FOREACH([batch children], bullet)
    {
        if (bullet.visible) {
            if (isPlayer && CGRectIntersectsRect(rect, [bullet boundingBox])) {
                isCollision = YES;
                bullet.visible = NO;
            }else{
                //怪物的子弹
            }
        }
    }
    
    return isCollision;
}


@end
