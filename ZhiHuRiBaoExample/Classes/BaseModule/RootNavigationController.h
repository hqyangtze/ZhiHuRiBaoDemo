//
//  RootNavigationController.h
//  AppFrame
//
//  Created by HQ on 2016/11/28.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ROOT_NAVIGATION_CONTROLLER    [RootNavigationController getRootNavigationController]

@interface RootNavigationController : NSObject

/// 全局就一个 NavigationController
+(instancetype)defaultManager;

+(UINavigationController*)getRootNavigationController;

+(void)setRootNavigationController:(UINavigationController*)navigationController;

@end
