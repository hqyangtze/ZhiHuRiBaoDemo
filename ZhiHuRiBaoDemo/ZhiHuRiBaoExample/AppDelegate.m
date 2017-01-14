//
//  AppDelegate.m
//  ZhiHuRiBaoExample
//
//  Created by HQ on 2017/1/14.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import "AppDelegate.h"
#import "RootNavigationController.h"
#import "NewsHomeViewController.h"
#import "CoreNavigationController.h"
#import "APPFrameMacro.h"
#import "AFNetworkConfigObject.h"
#import "AFStartImageView.h"

@interface AppDelegate ()
@property (nonatomic, strong) NewsHomeViewController* homeVC;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //self.tabBarVC = [[MainTabBarViewController alloc]init];
    self.homeVC = [NewsHomeViewController getController];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CoreNavigationController * menuNav = [[CoreNavigationController alloc] initWithRootViewController:self.homeVC];

    [RootNavigationController setRootNavigationController:menuNav];

    [self.window setRootViewController:menuNav];
    [self.window makeKeyAndVisible];
    // networking
    [AFNetworkConfigObject shareConfig];
    [AFStartImageView showStartImage];
    return YES;
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
