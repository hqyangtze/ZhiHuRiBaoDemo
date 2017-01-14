//
//  MBProgressHUD+HQExtend.m
//  CocoapodsTest
//
//  Created by HQ on 2016/11/24.
//  Copyright © 2016年 IFA. All rights reserved.
//

#import "MBProgressHUD+HQExtend.h"

@implementation MBProgressHUD (HQExtend)

+ (instancetype)creatHUD{
    UIView* baseView = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView: baseView];
    [baseView addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    return HUD;
}

+ (void)hq_showWithMessage:(NSString *)message{
    [self hq_showWithMessage:message animation:YES];
}

+(void)hq_showWithMessage:(NSString *)message animation:(BOOL)animation{
    [self hq_showWithMessage:message animation:YES completeBlock:nil];
}

+(void)hq_showWithMessage:(NSString *)message animation:(BOOL)animation completeBlock:(MBProgressHUDCompletionBlock)complete{
    if (message == nil || message.length == 0) {
        return;
    }
    MBProgressHUD* HUD = [self creatHUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.label.text = message;
    [HUD showAnimated:animation];
    if (complete) {
        HUD.completionBlock = complete;
    }
    [HUD hideAnimated:animation afterDelay:message.length * 0.2 + 0.5];
}

/// Toast
+ (void)hq_toastWithText:(NSString *)text{
    [self hq_toastWithText:text completeBlock:nil];
}

+ (void)hq_toastWithText:(NSString *)text completeBlock:(MBProgressHUDCompletionBlock)complete{
    MBProgressHUD* HUD = [self creatHUD];
    HUD.animationType = MBProgressHUDAnimationZoom;
    HUD.margin = 4.0f;
    HUD.mode = MBProgressHUDModeText;
    HUD.label.text = text;
    HUD.label.textColor = [UIColor whiteColor];
    HUD.offset = CGPointMake(0.0, MBProgressMaxOffset);
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.bezelView.color = [UIColor colorWithWhite:0.0 alpha:0.8];
    HUD.square = YES;
    [HUD showAnimated:YES];
    if (complete) {
        HUD.completionBlock = complete;
    }
    [HUD hideAnimated:YES afterDelay:text.length * 0.2 + 0.5];
}


/// progress
+ (void)hq_showProgressWithMessage:(NSString *)message{
    [self hq_showProgressWithMessage:message animation:YES];
}

+ (void)hq_showProgressWithMessage:(NSString *)message animation:(BOOL)animation{
    [self hq_showProgressWithMessage:message animation:animation completeBlock:nil];
}

+ (void)hq_showProgressWithMessage:(NSString *)message animation:(BOOL)animation completeBlock:(MBProgressHUDCompletionBlock)complete
{
    [self hq_showProgressWithMessage:message custom:nil animation:animation completeBlock:complete];
}

+ (void)hq_showProgressWithMessage:(NSString *)message custom:(UIView* )customView animation:(BOOL)animation completeBlock:(MBProgressHUDCompletionBlock)complete{
    MBProgressHUD* HUD = [self creatHUD];
    HUD.customView = customView;
    HUD.animationType = MBProgressHUDAnimationZoomOut;
    if (customView) {
        HUD.mode = MBProgressHUDModeCustomView;
    }else{
        HUD.mode = MBProgressHUDModeIndeterminate;
    }
    HUD.label.text = message;
    [HUD showAnimated:animation];
    if (complete) {
        HUD.completionBlock = complete;
    }
}

+ (void)hq_showSuccessWithMessage:(NSString *)message{
    [self hq_showSuccessWithMessage:message completeBlock:nil];
}

+ (void)hq_showSuccessWithMessage:(NSString *)message completeBlock:(MBProgressHUDCompletionBlock)complete{
    UIImageView* customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/success"]]];
    [self hq_showProgressWithMessage:message custom:customView animation:YES completeBlock:complete];
    [self hq_dismissWithDelayTimeInterval:message.length * 0.1 + 1.0];
}

+ (void)hq_showErrorWithMessage:(NSString *)message{
    [self hq_showErrorWithMessage:message completeBlock:nil];
}

+ (void)hq_showErrorWithMessage:(NSString *)message completeBlock:(MBProgressHUDCompletionBlock)complete{
    UIImageView* customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/error"]]];
    [self hq_showProgressWithMessage:message custom:customView animation:YES completeBlock:complete];
    [self hq_dismissWithDelayTimeInterval:message.length * 0.1 + 1.0];
}


+ (void)hq_dismiss{
    [self hq_dismissWithDelayTimeInterval:0.1];
}

+ (void)hq_dismissWithDelayTimeInterval:(NSTimeInterval)interval{
    MBProgressHUD* HUD = [MBProgressHUD HUDForView:[[UIApplication sharedApplication].windows lastObject]];
    if (HUD) {
        HUD.removeFromSuperViewOnHide = YES;
        [HUD hideAnimated:YES afterDelay:interval];
    }
}

@end
