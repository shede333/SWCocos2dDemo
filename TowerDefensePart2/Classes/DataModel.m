//
//  DataModel.m
//  Cocos2D Build a Tower Defense Game
//
//  Created by iPhoneGameTutorials on 4/4/11.
//  Copyright 2011 iPhoneGameTutorial.com All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

@synthesize _gameLayer;
@synthesize _gameHUDLayer;

@synthesize _towers;
@synthesize _gestureRecognizer;

static DataModel *_sharedContext = nil;

+(DataModel*)getModel 
{
	if (!_sharedContext) {
		_sharedContext = [[self alloc] init];
	}
	
	return _sharedContext;
}

-(void)encodeWithCoder:(NSCoder *)coder {

}

-(id)initWithCoder:(NSCoder *)coder {

	return self;
}

- (id) init
{
	if ((self = [super init])) {
		_towers = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)dealloc {	
	self._gameLayer = nil;
	self._gameHUDLayer = nil;
	self._gestureRecognizer = nil;
	
	[_towers release];
	_towers = nil;
	
	[super dealloc];
}

@end
