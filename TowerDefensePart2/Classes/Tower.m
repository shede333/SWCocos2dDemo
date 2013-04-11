//
//  Creep.m
//  Cocos2D Build a Tower Defense Game
//
//  Created by iPhoneGameTutorials on 4/4/11.
//  Copyright 2011 iPhoneGameTutorial.com All rights reserved.
//

#import "Tower.h"

@implementation Tower

@synthesize range = _range;

@end

@implementation MachineGunTower

+ (id)tower {
	
    MachineGunTower *tower = nil;
    if ((tower = [[[super alloc] initWithFile:@"MachineGunTurret.png"] autorelease])) {
		tower.range = 200;
		
		[tower schedule:@selector(towerLogic:) interval:0.2];
		
    }
	
    return tower;
    
}

-(id) init
{
	if ((self=[super init]) ) {
		//[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	}
	return self;
}

-(void)towerLogic:(ccTime)dt {
	
} 

@end
