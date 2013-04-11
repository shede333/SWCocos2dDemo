//
//  DataModel.h
//  Cocos2D Build a Tower Defense Game
//
//  Created by iPhoneGameTutorials on 4/4/11.
//  Copyright 2011 iPhoneGameTutorial.com All rights reserved.
//

#import "cocos2d.h"

@interface DataModel : NSObject <NSCoding> {
	CCLayer *_gameLayer;
	CCLayer *_gameHUDLayer;	

	NSMutableArray *_towers;

	UIPanGestureRecognizer *_gestureRecognizer;
}

@property (nonatomic, retain) CCLayer *_gameLayer;
@property (nonatomic, retain) CCLayer *_gameHUDLayer;

@property (nonatomic, retain) NSMutableArray * _towers;

@property (nonatomic, retain) UIPanGestureRecognizer *_gestureRecognizer;;
+ (DataModel*)getModel;

@end
