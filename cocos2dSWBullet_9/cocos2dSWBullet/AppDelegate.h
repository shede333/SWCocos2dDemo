//
//  AppDelegate.h
//  cocos2dSWBullet
//
//  Created by shaowei on 12-5-24.
//  Copyright SWCaptain 2012年. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
