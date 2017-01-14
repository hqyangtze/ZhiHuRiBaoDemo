//
//  CoreNavigationController.h
//  Core
//
//  Created by ZhouHui on 14-5-7.
//  Copyright (c) 2014年 ifa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreNavigationController : UINavigationController

@property (nonatomic) BOOL inAnimating;

@property (nonatomic) BOOL supportPortraitOnly;

@property(nonatomic,weak) UIViewController* currentShowVC;

-(id)initWithRootViewController:(UIViewController *)rootViewController;

@end
