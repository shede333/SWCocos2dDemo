//
//  TieldMapLayer.m
//  Cocos2dTield10
//
//  Created by ZhiHuiGuan001 舍得 on 12-6-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "TieldMapLayer.h"
#import "SimpleAudioEngine.h"


@implementation TieldMapLayer

+ (id)scene{
    CCScene *scene = [CCScene node];
    CCLayer *my = [TieldMapLayer node];
    [scene addChild:my];
    return scene;
}

- (id)init{
    if (self = [super init]) {
        CCTMXTiledMap *map = [CCTMXTiledMap tiledMapWithTMXFile:@"First.tmx"];
//        CCTMXTiledMap *map = [CCTMXTiledMap tiledMapWithTMXFile:@"orthogonal.tmx"];
        [self addChild:map z:-1 tag:TileMapNode];
        
        CCTMXLayer *tieldLayer = [map layerNamed:@"GameEventLayer"];
        
        tieldLayer.visible = NO;
        
        self.isTouchEnabled = YES;
        
        CCTMXLayer *winter = [map layerNamed:@"WinterLayer"];
        winter.visible = NO;
        
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"alien-sfx.caf"];
        
    }
    
    return self;
}

- (CGPoint)locationFromTouch:(UITouch *)touch{
    CGPoint pos = [touch locationInView:[touch view]];
    return [[CCDirector sharedDirector] convertToGL:pos];
}

- (CGPoint)locationFromTouchs:(NSSet *)touchs{
    return [self locationFromTouch:[touchs anyObject]];
}

- (CGPoint)tilePosFromLocation:(CGPoint)location tileMap:(CCTMXTiledMap *)tileMap{
    CGPoint pos = ccpSub(location, tileMap.position);
    pos.x = (int)(pos.x / tileMap.tileSize.width);
    pos.y = (int)((tileMap.mapSize.height * tileMap.tileSize.height - pos.y) / tileMap.tileSize.height);
    
    NSAssert3(pos.x >= 0 && pos.y >= 0 && pos.x <= tileMap.mapSize.width && pos.y <= tileMap.mapSize.height, @"%@  %d,%d", NSStringFromSelector(_cmd), pos.x, pos.y);
    return pos;
    
}

- (CGRect)getRectFromObjectGroup:(NSDictionary *)dic withTileMap:(CCTMXTiledMap *)tileMap{
    float x,y,width,height;
    x = [[dic objectForKey:@"x"] floatValue] + tileMap.position.x ;
    y = [[dic objectForKey:@"y"] floatValue] + tileMap.position.y ;
    width = [[dic objectForKey:@"width"] floatValue];
    height = [[dic objectForKey:@"height"] floatValue];
    return CGRectMake(x, y, width, height);
}

- (void)centerTileOnPos:(CGPoint)tilePos andMap:(CCTMXTiledMap *)tileMap{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CGPoint centerOfScreen = CGPointMake(screenSize.width * 0.5f, screenSize.height * 0.5f);
    
    tilePos.y = tileMap.mapSize.height - 1 - tilePos.y;
    
    CGPoint scrollPosition = CGPointMake(- (tilePos.x * tileMap.tileSize.width), -(tilePos.y * tileMap.tileSize.height));
    scrollPosition.x += centerOfScreen.x;
    scrollPosition.y += centerOfScreen.y;
    
    scrollPosition.x = MIN(scrollPosition.x, 0);
    scrollPosition.x = MAX(scrollPosition.x, -(tileMap.mapSize.width * tileMap.tileSize.width - screenSize.width));
    scrollPosition.y = MIN(scrollPosition.y, 0);
    scrollPosition.y = MAX(scrollPosition.y, -(tileMap.mapSize.height * tileMap.tileSize.height - screenSize.height));
    
    CCLOG(@"scroll   %f:%f",scrollPosition.x,scrollPosition.y);
    
    CCAction *action = [CCMoveTo actionWithDuration:0.2f position:scrollPosition];
    [tileMap stopAllActions];
    [tileMap runAction:action];
    
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint location = [self locationFromTouchs:touches];
    
    CCNode *node = [self getChildByTag:TileMapNode];
    NSAssert([node isKindOfClass:[CCTMXTiledMap class]], @"node is not map");
    CCTMXTiledMap *tileMap = (CCTMXTiledMap *)node;
    
    [tileMap propertyNamed:@""];
    [tileMap objectGroups];
    
    CGPoint pos = [self tilePosFromLocation:location tileMap:tileMap];
    
    CCTMXLayer *eventLayer = [tileMap layerNamed:@"GameEventLayer"];
    
    [self centerTileOnPos:pos andMap:tileMap];
    
    BOOL isOnWater = NO;
    
    int gid = [eventLayer tileGIDAt:pos];
    if (gid != 0) {
        NSDictionary *dic = [tileMap propertiesForGID:gid];
        if (dic != nil) {
            NSString * isWaterproperty = [dic objectForKey:@"isWater"];
            isOnWater = [isWaterproperty boolValue];
        }
    }
    
    
    BOOL isTouchObject = NO;
    CCTMXObjectGroup *object = [tileMap objectGroupNamed:@"ObjectLayer"];
    int count = [object.objects count];
    for (int i = 0; i < count; i++) {
        NSDictionary *dic = [object.objects objectAtIndex:i];
        CGRect rect = [self getRectFromObjectGroup:dic withTileMap:tileMap];
        if (CGRectContainsPoint(rect, location)) {
            isTouchObject = YES;
            break;
        }
    }
    
    
    if (isOnWater) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"alien-sfx.caf"];
    }else if(isTouchObject){
        CCParticleSystem *particle = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"fx-explosion.plist"];
        particle.position = location;
        [self addChild:particle z:1];
    }else{
//        CCTMXLayer *winter = [tileMap layerNamed:@"WinterLayer"];
//        winter.visible = !winter.visible;
    }
    
}

- (void)drawRect:(CGRect)rect{
    CGPoint pos1,pos2,pos3,pos4;
    pos1 = CGPointMake(rect.origin.x, rect.origin.y);
    pos2 = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
    pos3 = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    pos4 = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
    
    ccDrawLine(pos1, pos2);
    ccDrawLine(pos2, pos3);
    ccDrawLine(pos3, pos4);
    ccDrawLine(pos4, pos1);
}

- (void)draw{
    
    CCNode *node = [self getChildByTag:TileMapNode];
    NSAssert([node isKindOfClass:[CCTMXTiledMap class]], @"node is not map");
    CCTMXTiledMap *tileMap = (CCTMXTiledMap *)node;
    
    CCTMXObjectGroup *object = [tileMap objectGroupNamed:@"ObjectLayer"];
    
    glLineWidth(3.0f);
    glColor4f(1, 0, 1, 1);
    
    int count = [object.objects count];
    for (int i = 0; i < count; i++) {
        NSDictionary *dic = [object.objects objectAtIndex:i];
        CGRect rect = [self getRectFromObjectGroup:dic withTileMap:tileMap];
        [self drawRect:rect];
    }
    
    // show center screen position
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	CGPoint center = CGPointMake(screenSize.width * 0.5f, screenSize.height * 0.5f);
	ccDrawCircle(center, 10, 0, 8, NO);
    
    glLineWidth(1.0f);
    glColor4f(1, 1, 1, 1);
}








@end
