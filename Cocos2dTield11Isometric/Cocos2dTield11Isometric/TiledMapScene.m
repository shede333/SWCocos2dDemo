//
//  TiledMapScene.m
//  Cocos2dTield11Isometric
//
//  Created by ZhiHuiGuan001 舍得 on 12-7-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "TiledMapScene.h"

@interface TiledMapScene()

- (void)directionOfInit;

@end


@implementation TiledMapScene

+ (id)scene{
    CCScene *scene = [CCScene node];
    TiledMapScene *layer = [TiledMapScene node];
    [scene addChild:layer];
    return scene; 
}

- (id)init
{
    self = [super init]; 
    if (self) {
        CCTMXTiledMap *map = [CCTMXTiledMap tiledMapWithTMXFile:@"isometric-with-border.tmx"];
        [self addChild:map z:-1 tag:eChildOfTiledMap];
        
        CCTMXLayer *layerOfTemp = [map layerNamed:@"Collisions"];
//        layerOfTemp.visible = NO;
        
        CCLOG(@"anchorPoint:%@",NSStringFromCGPoint(map.anchorPoint));
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CGPoint centerOfScreen = CGPointMake(screenSize.width * 0.5f, screenSize.height * 0.5f);
        map.position = CGPointMake(- (map.contentSize.width * 0.5f - screenSize.width * 0.5f) + 100, 
                                   - (map.contentSize.height * 0.5f - screenSize.height * 0.5f));
        CCLOG(@"map.position:%@,contentSize:%@",NSStringFromCGPoint(map.position),
              NSStringFromCGSize(map.contentSize));
        
        
        CCLOG(@"%@",NSStringFromCGRect(map.boundingBox));
        CCLOG(@"%@",NSStringFromCGSize(map.contentSize));
        CCLOG(@"anchorPoint:%@",NSStringFromCGPoint(map.anchorPoint));
        
        player = [Player player];
        player.position = CGPointMake(centerOfScreen.x, centerOfScreen.y);
        
        player.anchorPoint = CGPointMake(0.3f, 0.1f);
        [self addChild:player z:0 tag:eChildOfPlayer];
        
        const int borderSize = 10;
        playableAreaMin = CGPointMake(borderSize, borderSize);
        playableAreaMax = CGPointMake(map.mapSize.width - borderSize - 1,
                                      map.mapSize.height - borderSize - 1);
        
        
        self.isTouchEnabled = YES;
        
        [self directionOfInit];
        
        [self scheduleUpdate];
        
    }
    return self;
}

#pragma mark - Function

- (void)directionOfInit{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    screenCenter = CGPointMake(screenSize.width/2, screenSize.height/2);
    
    upLeft = CGRectMake(0, screenCenter.y, screenCenter.x, screenCenter.y);
    upRight = CGRectMake(screenCenter.x, screenCenter.y,screenCenter.x, screenCenter.y);
    downLeft = CGRectMake(0, 0, screenCenter.x, screenCenter.y);
    downRight = CGRectMake(screenCenter.x, 0,screenCenter.x, screenCenter.y);
    
    moveOffset[eDirectionOfNone] = CGPointMake(0, 0);
     moveOffset[eDirectionOfUpLeft] = CGPointMake(-1, 0);
     moveOffset[eDirectionOfUpRight] = CGPointMake(0, -1);
     moveOffset[eDirectionOfDownLeft] = CGPointMake(0, 1);
     moveOffset[eDirectionOfDownRight] = CGPointMake(1, 0);
    
    currentDirection = eDirectionOfNone;
    
}

-(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

-(CGPoint) locationFromTouches:(NSSet*)touches
{
	return [self locationFromTouch:[touches anyObject]];
}

-(CGPoint) tilePosFromLocation:(CGPoint)location tileMap:(CCTMXTiledMap*)tileMap
{
	// Tilemap position must be subtracted, in case the tilemap position is not at 0,0 due to scrolling
	CGPoint pos = ccpSub(location, tileMap.position);
	
	float halfMapWidth = tileMap.mapSize.width * 0.5f;
	float mapHeight = tileMap.mapSize.height;
	float tileWidth = tileMap.tileSize.width;
	float tileHeight = tileMap.tileSize.height;
	
	CGPoint tilePosDiv = CGPointMake(pos.x / tileWidth, pos.y / tileHeight);
	float inverseTileY = mapHeight - tilePosDiv.y;
    
	// Cast to int makes sure that result is in whole numbers, tile coordinates will be used as array indices
	float posX = (int)(inverseTileY + tilePosDiv.x - halfMapWidth);
	float posY = (int)(inverseTileY - tilePosDiv.x + halfMapWidth);
    
//	// make sure coordinates are within isomap bounds
//	posX = MAX(playableAreaMin.x, posX);
//	posX = MIN(playableAreaMax.x, posX);
//	posY = MAX(playableAreaMin.y, posY);
//	posY = MIN(playableAreaMax.y, posY);
	
	pos = CGPointMake(posX, posY);
    
//	CCLOG(@"touch at (%.0f, %.0f) is at tileCoord (%i, %i)", location.x, location.y, (int)pos.x, (int)pos.y);
	//CCLOG(@"\tinverseY: %.2f -- tilePosDiv: (%.2f, %.2f) -- halfMapWidth: %.0f\n", inverseTileY, tilePosDiv.x, tilePosDiv.y, halfMapWidth);
	
	return pos;
}

- (CGPoint)checkBound:(CGPoint)tilePos{
    float posX = tilePos.x;
    float posY = tilePos.y;
    posX = MAX(playableAreaMin.x, posX);
	posX = MIN(playableAreaMax.x, posX);
	posY = MAX(playableAreaMin.y, posY);
	posY = MIN(playableAreaMax.y, posY);
    
    return CGPointMake(posX, posY);
}

-(CGPoint) checkTilePosFromLocation:(CGPoint)location tileMap:(CCTMXTiledMap*)tileMap{
    CGPoint tilePos = [self tilePosFromLocation:location tileMap:tileMap];
    tilePos = [self checkBound:tilePos];
    
    return tilePos;
}



-(void) centerTileMapOnTileCoord:(CGPoint)tilePos tileMap:(CCTMXTiledMap*)tileMap
{
	// center tilemap on the given tile pos
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	CGPoint screenCenter = CGPointMake(screenSize.width * 0.5f, screenSize.height * 0.5f);
	
	// get the ground layer
	CCTMXLayer* layer = [tileMap layerNamed:@"Ground"];
	NSAssert(layer != nil, @"Ground layer not found!");
	
	// internally tile Y coordinates are off by 1, this fixes the returned pixel coordinates
	tilePos.y -= 1;
	
	// get the pixel coordinates for a tile at these coordinates
	CGPoint scrollPosition = [layer positionAt:tilePos];
	// negate the position for scrolling
	scrollPosition = ccpMult(scrollPosition, -1);
	// add offset to screen center
	scrollPosition = ccpAdd(scrollPosition, screenCenter);
	
//	CCLOG(@"tilePos: (%i, %i) moveTo: (%.0f, %.0f)\n\n", (int)tilePos.x, (int)tilePos.y, scrollPosition.x, scrollPosition.y);
	
	CCAction* move = [CCMoveTo actionWithDuration:0.2f position:scrollPosition];
	[tileMap stopAllActions];
	[tileMap runAction:move];
}

- (BOOL)isCollisions:(CGPoint)tilePos andTileMap:(CCTMXTiledMap*)tileMap{
    CCTMXLayer *layer = [tileMap layerNamed:@"Collisions"];
    
    unsigned int gid = [layer tileGIDAt:tilePos];
    
    BOOL isCollisions = NO;
    if (gid > 0) {
        
        NSDictionary *dic = [tileMap propertiesForGID:gid];
        
        id object = [dic objectForKey:@"blocks_movement"];
        isCollisions = (object != nil);
        CCLOG(@"isCollisions,%d",isCollisions);
        
    }
    
    return isCollisions;
}


#pragma mark - Touch - delegate

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//	CCNode* node = [self getChildByTag:eChildOfTiledMap];
//	NSAssert([node isKindOfClass:[CCTMXTiledMap class]], @"not a CCTMXTiledMap");
//	CCTMXTiledMap* tileMap = (CCTMXTiledMap*)node; 
//    
//	// get the position in tile coordinates from the touch location
//	CGPoint touchLocation = [self locationFromTouches:touches];
//	CGPoint tilePos = [self tilePosFromLocation:touchLocation tileMap:tileMap];
//    
//	// move tilemap so that touched tiles is at center of screen
//	[self centerTileMapOnTileCoord:tilePos tileMap:tileMap];
//    
//    [player updateVertexZ:tilePos tileMap:tileMap];
    
    
    CGPoint touchLocal = [self locationFromTouches:touches];
    
    if (CGRectContainsPoint(upLeft, touchLocal)) {
        currentDirection = eDirectionOfUpLeft;
    }else if (CGRectContainsPoint(upRight, touchLocal)) {
        currentDirection = eDirectionOfUpRight;
    }else if (CGRectContainsPoint(downLeft, touchLocal)) {
        currentDirection = eDirectionOfDownLeft;
    }else if (CGRectContainsPoint(downRight, touchLocal)) {
        currentDirection = eDirectionOfDownRight;
    }
    
    CCLOG(@"currentDirection:%d",currentDirection);
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	currentDirection = eDirectionOfNone;
}



#pragma mark - System

- (void)update:(ccTime)delta{
    CCNode* node = [self getChildByTag:eChildOfTiledMap];
	NSAssert([node isKindOfClass:[CCTMXTiledMap class]], @"not a CCTMXTiledMap");
	CCTMXTiledMap* tileMap = (CCTMXTiledMap*)node; 
    
    if ([tileMap numberOfRunningActions] == 0) {
        if (currentDirection != eDirectionOfNone) {
            CGPoint tilePos = [self checkTilePosFromLocation:screenCenter tileMap:tileMap];
            CGPoint offSet = moveOffset[currentDirection];
            tilePos = ccpAdd(tilePos, offSet);
            tilePos = [self checkBound:tilePos];
            
            if (![self isCollisions:tilePos andTileMap:tileMap]) {
                [self centerTileMapOnTileCoord:tilePos tileMap:tileMap];
            }
            
        }
    }
    
    CGPoint tilePos = [self tilePosFromLocation:screenCenter tileMap:tileMap];
    [player updateVertexZ:tilePos tileMap:tileMap];
}

- (void)draw{
    return;
    glLineWidth(3.0f);
    glColor4f(1, 1, 1, 1);
    
    // show center screen position
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	CGPoint center = CGPointMake(screenSize.width * 0.5f, screenSize.height * 0.5f);
	ccDrawCircle(center, 10, 0, 8, NO);
    
    glLineWidth(1.0f);
    glColor4f(1, 1, 1, 1);
}

@end
