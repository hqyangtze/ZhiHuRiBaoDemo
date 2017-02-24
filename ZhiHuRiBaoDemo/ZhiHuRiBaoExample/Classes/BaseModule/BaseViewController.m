//
//  BaseViewController.m
//  AppFrame
//
//  Created by HQ on 2016/11/28.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (instancetype)init{
    if (self = [super init]) {
        self.title = NSStringFromClass([self class]);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:UIFontMake(20), NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    [self af_setBackWithTitle:@" 返回"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController setToolbarHidden:YES animated:NO];
    [self setNeedsStatusBarAppearanceUpdate];
}


+ (instancetype)getController{
    return [[self alloc] init];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
