//
//  UIViewController+Extend.m
//  AppFrame
//
//  Created by HQ on 2016/11/29.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "UIViewController+Extend.h"
#import "UIFont+Extend.h"

@implementation UIViewController (Extend)

-(void)af_setBackWithTitle:(NSString*)backTitle
{
    if (![backTitle isKindOfClass:[NSString class]]) {
        return;
    }

    UIImage* image = [UIImage imageNamed:k_navi_left_back_image];
    UIFont* font = [UIFont getFontWithFontName:nil displayStr:(NSString*)backTitle fontSize:17.0f];

    UIButton* leftTopBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, font.fontSize.width+image.size.width+5, font.fontSize.height)];
    leftTopBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    leftTopBtn.titleLabel.font = font;
    [leftTopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftTopBtn setTitle:(NSString*)backTitle forState:UIControlStateNormal];
    [leftTopBtn setImage:image forState:UIControlStateNormal];

    UIBarButtonItem* leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftTopBtn];
    [leftTopBtn addTarget:self action:@selector(af_leftTopAction) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -5;

    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftBar, nil];
}

-(void)af_setNavigationItemWithLeftObject:(NSObject*)left right:(NSObject*)right title:(NSObject*)title
{
    if (left != nil) {
        if ([left isKindOfClass:[UIImage class]]) {
            UIButton* leftTopBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ((UIImage*)left).size.width, ((UIImage*)left).size.height)];
            [leftTopBtn setImage:(UIImage*)left forState:UIControlStateNormal];
            UIBarButtonItem* leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftTopBtn];
            [leftTopBtn addTarget:self action:@selector(af_leftTopAction) forControlEvents:UIControlEventTouchUpInside];

            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                               target:nil action:nil];
            negativeSpacer.width = -5;

            self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftBar, nil];
        }

        if ([left isKindOfClass:[NSString class]]) {
            UIFont* font = [UIFont getFontWithFontName:nil displayStr:(NSString*)left fontSize:17.0f];

            UIButton* leftTopBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, font.fontSize.width, font.fontSize.height)];
            leftTopBtn.titleLabel.font = font;
            [leftTopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [leftTopBtn setTitle:(NSString*)left forState:UIControlStateNormal];

            UIBarButtonItem* leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftTopBtn];
            [leftTopBtn addTarget:self action:@selector(af_leftTopAction) forControlEvents:UIControlEventTouchUpInside];

            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                               target:nil action:nil];
            negativeSpacer.width = -5;

            self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftBar, nil];
        }

        if ([left isKindOfClass:[UIView class]]) {
            UIBarButtonItem* leftBar = [[UIBarButtonItem alloc]initWithCustomView:(UIView*)left];
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                               target:nil action:nil];
            negativeSpacer.width = -5;

            self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftBar, nil];
        }

        if ([left isKindOfClass:[NSArray class]]) {

            UIBarButtonItem * leftPositiveSpacer = [[UIBarButtonItem alloc]
                                                    initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                    target:nil action:nil];
            leftPositiveSpacer.width = -5;

            NSMutableArray* btns = [NSMutableArray arrayWithArray:(NSArray*)left];
            [btns insertObject:left atIndex:0];

            self.navigationItem.leftBarButtonItems = btns;
        }
    }

    if (right != nil) {
        if ([right isKindOfClass:[UIImage class]]) {
            UIButton* rightTopBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ((UIImage*)right).size.width, ((UIImage*)right).size.height)];
            [rightTopBtn setImage:((UIImage*)right) forState:UIControlStateNormal];
            [rightTopBtn addTarget:self action:@selector(af_rightTopAction) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightTopBtn];

            UIBarButtonItem * RightPositiveSpacer = [[UIBarButtonItem alloc]
                                                     initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                     target:nil action:nil];
            RightPositiveSpacer.width = -5;

            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:RightPositiveSpacer, rightBar, nil];
        }

        if ([right isKindOfClass:[NSString class]]) {
            UIFont* font = [UIFont getFontWithFontName:nil displayStr:(NSString*)right fontSize:17.0f];
            UIButton* rightTopBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, font.fontSize.width, font.fontSize.height)];
            rightTopBtn.titleLabel.font = font;
            [rightTopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [rightTopBtn setTitle:(NSString*)right forState:UIControlStateNormal];

            [rightTopBtn addTarget:self action:@selector(af_rightTopAction) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightTopBtn];

            UIBarButtonItem * RightPositiveSpacer = [[UIBarButtonItem alloc]
                                                     initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                     target:nil action:nil];
            RightPositiveSpacer.width = -5;

            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:RightPositiveSpacer, rightBar, nil];
        }

        if ([right isKindOfClass:[UIView class]]) {
            UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithCustomView:(UIView*)right];

            UIBarButtonItem * RightPositiveSpacer = [[UIBarButtonItem alloc]
                                                     initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                     target:nil action:nil];
            RightPositiveSpacer.width = -5;

            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:RightPositiveSpacer, rightBar, nil];
        }

        if ([right isKindOfClass:[NSArray class]]) {

            UIBarButtonItem * RightPositiveSpacer = [[UIBarButtonItem alloc]
                                                     initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                     target:nil action:nil];
            RightPositiveSpacer.width = -5;

            NSMutableArray* btns = [NSMutableArray arrayWithArray:(NSArray*)right];
            [btns insertObject:RightPositiveSpacer atIndex:0];

            self.navigationItem.rightBarButtonItems = btns;
        }
    }

    if (title != nil) {
        if ([title isKindOfClass:[NSString class]]) {
            UIFont* font = [UIFont getFontWithFontName:nil displayStr:(NSString*)title fontSize:20.0f];
            UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10.5, font.fontSize.width, font.fontSize.height)];
            lab.font = font;
            lab.text = (NSString*)title;
            lab.textColor = [UIColor whiteColor];
            lab.center = CGPointMake(0.5 * (SCREEN_WIDTH - CGRectGetWidth(lab.frame)), lab.center.y);

            self.navigationItem.titleView = lab;
        } else if ([title isKindOfClass:[UIView class]]) {
            self.navigationItem.titleView = (UIView *)title;
        }
    }
}


-(void)af_leftTopAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)af_rightTopAction{

}

- (void)af_popToViewControllers:(NSArray*)aimViewControllerStrings{
    if (!self.navigationController) {
        return;
    }
    UIViewController* popToVC = nil;
    for (UIViewController *obj in self.navigationController.viewControllers) {
        for (NSString * aimvcstr in aimViewControllerStrings) {
            UIViewController *aimvc = [[NSClassFromString(aimvcstr) alloc] init];
            if ([obj isKindOfClass:[aimvc class]]) {
                popToVC = obj;
                break;
            }
        }
    }
    if (popToVC) {
        [self.navigationController popToViewController:popToVC animated:YES];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end


@implementation UIViewController(HUD)

/// message
- (void)showWithMessage:(NSString* )message{
    [MBProgressHUD hq_showWithMessage:message];
}
- (void)showWithMessage:(NSString* )message animation:(BOOL)animation{
    [MBProgressHUD hq_showWithMessage:message animation:YES];
}
- (void)showWithMessage:(NSString* )message animation:(BOOL)animation completeBlock:(MBProgressHUDCompletionBlock) complete{
    [MBProgressHUD hq_showWithMessage:message animation:YES completeBlock:complete];
}

/// toast
- (void)toastWithText:(NSString* )text{
    [MBProgressHUD hq_toastWithText:text];
}
- (void)toastWithText:(NSString* )text completeBlock:(MBProgressHUDCompletionBlock) complete{
    [MBProgressHUD hq_toastWithText:text completeBlock:complete];
}

/// progress 加载...   需要手动调用 dismiss 方法
- (void)showProgressWithMessage:(NSString* )message{
    [MBProgressHUD hq_showProgressWithMessage:message];
}
- (void)showProgressWithMessage:(NSString* )message animation:(BOOL)animation{
    [MBProgressHUD hq_showProgressWithMessage:message animation:YES];
}
- (void)showProgressWithMessage:(NSString* )message animation:(BOOL)animation completeBlock:(MBProgressHUDCompletionBlock) complete{
    [MBProgressHUD hq_showProgressWithMessage:message animation:animation completeBlock:complete];
}

/// dismiss HUD
- (void)dismiss{
    [MBProgressHUD hq_dismiss];
}

/// success
- (void)showSuccessWithMessage:(NSString* )message{
    [MBProgressHUD hq_showSuccessWithMessage:message];
}
- (void)showSuccessWithMessage:(NSString* )message completeBlock:(MBProgressHUDCompletionBlock) complete{
    [MBProgressHUD hq_showSuccessWithMessage:message completeBlock:complete];
}

/// error
- (void)showError:(NSError *)error{
    [MBProgressHUD hq_dismiss];
    NSString* errorString = error.userInfo[@"NSLocalizedDescription"];
    if (errorString) {
        [MBProgressHUD hq_showWithMessage:errorString];
    }
}
- (void)showErrorWithMessage:(NSString* )message{
    [MBProgressHUD hq_showErrorWithMessage:message];
}
- (void)showErrorWithMessage:(NSString* )message completeBlock:(MBProgressHUDCompletionBlock) complete{
    [MBProgressHUD hq_showErrorWithMessage:message completeBlock:complete];
}

@end

