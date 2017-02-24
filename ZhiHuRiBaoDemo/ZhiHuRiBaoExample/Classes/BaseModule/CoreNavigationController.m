//
//  CoreNavigationController.m
//  Core
//
//  Created by ZhouHui on 14-5-7.
//  Copyright (c) 2014年 ifa. All rights reserved.
//

#import "CoreNavigationController.h"
#import "APPFrameMacro.h"

@interface CoreNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation CoreNavigationController

- (void)viewDidLoad{
    [super viewDidLoad];

    [self.navigationBar setTranslucent:NO];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:WHITE_COLOR}];

    [[UINavigationBar appearance] setTintColor:WHITE_COLOR];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName : UIFontMake(20), NSForegroundColorAttributeName : WHITE_COLOR}];

    [[UINavigationBar appearance] setShadowImage:[UIImage af_imageWithColor:THEME_COLOR]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage af_imageWithColor:THEME_COLOR] forBarMetrics:UIBarMetricsDefault];

    self.toolbar.barStyle = UIBarStyleDefault;
    [self.toolbar setBackgroundColor:WHITE_COLOR];
    [[UIToolbar appearance] setTranslucent:NO];
    [[UIToolbar appearance] setBarTintColor:WHITE_COLOR];
    [[UIToolbar appearance] setTintColor:WHITE_COLOR];
    [[UIToolbar appearance] setBackgroundImage:[UIImage af_imageWithColor:THEME_COLOR] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UIToolbar appearance] setShadowImage:[UIImage af_imageWithColor:THEME_COLOR] forToolbarPosition:UIBarPositionAny];
}

-(id)initWithRootViewController:(UIViewController *)rootViewController{
    CoreNavigationController* nvc = [super initWithRootViewController:rootViewController];
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
    nvc.delegate = self;
    return nvc;
}

- (void)pushViewController:(UIViewController *)viewController withAnimation:(BOOL)animated {
    if (!animated) {
        // 无动画
        [super pushViewController:viewController animated:animated];
        _inAnimating = NO;
        return;
    }
    
    [self pushViewController:viewController animated:animated];
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    LOG(@"ges:%@",gestureRecognizer);
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.currentShowVC == self.topViewController);
    }
    return YES;
}

#pragma mark - UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    LOG(@"nvShow:%@", viewController);
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    LOG(@"nvDidShow:%@", viewController);
    if (navigationController.viewControllers.count == 1)
        self.currentShowVC = Nil;
    else
        self.currentShowVC = viewController;
}

#pragma mark -  重写父类方法
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    _inAnimating = animated;
    [super pushViewController:viewController animated:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        _inAnimating = NO;
    });
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if (self.supportPortraitOnly) {
        return UIInterfaceOrientationPortrait == toInterfaceOrientation;
    }else {
        return [self.topViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.supportPortraitOnly) {
        return UIInterfaceOrientationMaskPortrait;
    }else{
        return [self.topViewController supportedInterfaceOrientations];
    }
}

- (BOOL)shouldAutorotate {
    if (self.supportPortraitOnly) {
        return NO;
    }else{
        return [self.topViewController shouldAutorotate];
    }
}

@end
