//
//  HelloWorldLayer.m
//  Cocos2dDrapDrop
//
//  Created by ZhiHuiGuan001 舍得 on 12-7-23.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background = [CCSprite spriteWithFile:@"blue-shooting-stars.png"];
        background.anchorPoint = ccp(0, 0);
        [self addChild:background z:0 tag:eChildOfBackground];
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
        
        movableSprites = [[NSMutableArray alloc] init];
        NSArray *images = [NSArray arrayWithObjects:@"bird.png", @"cat.png", @"dog.png", @"turtle.png", nil]; 
        
        int i = 0;
        for (NSString *imageName in images) {
            CCSprite *sprite = [CCSprite spriteWithFile:imageName];
            float offSet = (float)(1 + i)/(images.count + 1);
            sprite.position = CGPointMake(winSize.width * offSet, winSize.height * 0.5f);
            [self addChild:sprite];
            [movableSprites addObject:sprite];

            i++;
        }
        
//    self.isTouchEnabled = YES;
		
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    [movableSprites release];
    movableSprites = nil;
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark - Function

- (void)registerWithTouchDispatcher{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES]; 
}

- (void)selectSpriteForTouch:(CGPoint)touchLocation{
    
    CCSprite *mySprite = nil;
    for (CCSprite *sprite in movableSprites) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {
            mySprite = sprite;
            break;
        }
    }
    
    if (mySprite != selSprite) {
        [selSprite stopAllActions];
        [selSprite runAction:[CCRotateTo actionWithDuration:0.1f angle:0]];
        
        CCRotateTo * rotLeft = [CCRotateBy actionWithDuration:0.1 angle:-14.0];
        CCRotateTo * rotCenter = [CCRotateBy actionWithDuration:0.1 angle:0.0];
        CCRotateTo * rotRight = [CCRotateBy actionWithDuration:0.1 angle:14.0];
        
        CCSequence *sequence = [CCSequence actions:rotLeft,rotCenter,rotRight,rotCenter, nil];
        selSprite = mySprite;
        if (selSprite != nil) {
            [selSprite runAction:[CCRepeatForever actionWithAction:sequence]];
        }
        
        
    }
}

#pragma mark - Touch

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint point = [self convertTouchToNodeSpace:touch];
    
    [self selectSpriteForTouch:point];
    
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint currentPoint = [self convertTouchToNodeSpace:touch];
    
    CGPoint point = [touch previousLocationInView:touch.view];
    point = [[CCDirector sharedDirector] convertToGL:point];
    point = [self convertToNodeSpace:point];
    
    CGPoint translation = ccpSub(currentPoint, point);
    [self panForTranslation:translation];
}


- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGPoint point = newPos;
    point.x = MIN(point.x, 0);
    point.x = MAX(point.x, -background.contentSize.width+winSize.width);
    point.y = self.position.y;
    return point;
}

- (void)panForTranslation:(CGPoint)translation{
    if (selSprite != nil) {
        selSprite.position = ccpAdd(selSprite.position, translation);
    }else {
        CGPoint newPos = ccpAdd(self.position, translation);
        self.position = [self boundLayerPos:newPos];
    }
}

#pragma mark - Gesture

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [recognizer locationInView:recognizer.view];
        point = [[CCDirector sharedDirector] convertToGL:point];
        
        point = [self convertToNodeSpace:point];
        [self selectSpriteForTouch:point];
    }else if(recognizer.state == UIGestureRecognizerStateChanged){
        CGPoint point = [recognizer translationInView:recognizer.view];
        CGPoint tt = CGPointMake(point.x, -point.y);
        [self panForTranslation:tt];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
    }else if(recognizer.state == UIGestureRecognizerStateEnded){
//        if (selSprite != nil) {
//            int duration = 0.2f;
//            CGPoint space = [recognizer velocityInView:recognizer.view];
//            CGPoint point = ccpAdd(selSprite.position, ccpMult(space, duration));
////            point = [self boundLayerPos:point];
//            
//            [selSprite stopAllActions];
//            CCMoveTo *move = [CCMoveTo actionWithDuration:duration position:point];
//            CCEaseOut *ee = [CCEaseOut actionWithAction:move];
//            [selSprite runAction:ee];
//        }
        
        if (!selSprite) {
            float scrollDuration =0.2;
            CGPoint velocity = [recognizer velocityInView:recognizer.view];
            CGPoint newPos = ccpAdd(self.position, ccpMult(velocity, scrollDuration));
            newPos = [self boundLayerPos:newPos];
            
            [self stopAllActions];
            CCMoveTo *moveTo = [CCMoveTo actionWithDuration:scrollDuration position:newPos];
            [self runAction:[CCEaseOut actionWithAction:moveTo rate:1]];
        } 
        
        
    }
}




@end
