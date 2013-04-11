//
//  CCAnimation+Helper.m
//  cocos2dSWBullet
//
//  Created by shaowei on 12-5-28.
//  Copyright (c) 2012年 SWCaptain. All rights reserved.
//

#import "CCAnimation+Helper.h"

@implementation CCAnimation (Helper)

+(CCAnimation*) animationWithFile:(NSString*)name frameCount:(int)frameCount delay:(float)delay{
    NSMutableArray *arrOfFrame = [[NSMutableArray alloc] initWithCapacity:frameCount];
    for (int i = 0; i < frameCount; i++) {
        NSString *file = [NSString stringWithFormat:@"%@%d.png",name,i];
        CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addImage:file];
        
        CGSize textureSize = texture.contentSize;
        CGRect textureRect = CGRectMake(0, 0, textureSize.width, textureSize.height);
        CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithTexture:texture rect:textureRect];
        [arrOfFrame addObject:spriteFrame];
    }
    
    CCAnimation *animation = [CCAnimation animationWithFrames:arrOfFrame];
    return animation;
}

+(CCAnimation*) animationWithFrame:(NSString*)frame frameCount:(int)frameCount delay:(float)delay{
    NSMutableArray *arrOfFrame = [[NSMutableArray alloc] initWithCapacity:frameCount];
    for (int i = 0; i < frameCount; i++) {
        NSString *file = [NSString stringWithFormat:@"%@%d.png",frame,i];
        CCSpriteFrameCache *cache = [CCSpriteFrameCache sharedSpriteFrameCache];
        CCSpriteFrame *spriteFrame = [cache spriteFrameByName:file];
        [arrOfFrame addObject:spriteFrame];
    }
    CCAnimation *animation = [CCAnimation animationWithFrames:arrOfFrame delay:delay];
    return animation;
}

@end
