//
//  AppDelegate.h
//  Cocos2dDrapDrop
//
//  Created by ZhiHuiGuan001 舍得 on 12-7-23.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
