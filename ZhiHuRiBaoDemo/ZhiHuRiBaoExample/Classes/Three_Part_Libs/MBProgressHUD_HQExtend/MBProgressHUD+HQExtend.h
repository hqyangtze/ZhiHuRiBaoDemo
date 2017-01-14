//
//  MBProgressHUD+HQExtend.h
//  CocoapodsTest
//
//  Created by HQ on 2016/11/24.
//  Copyright © 2016年 IFA. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>
#import <MBProgressHUD.h>

@interface MBProgressHUD (HQExtend)

/// message
+(void)hq_showWithMessage:(NSString* )message;
+(void)hq_showWithMessage:(NSString* )message animation:(BOOL)animation;
+(void)hq_showWithMessage:(NSString* )message animation:(BOOL)animation completeBlock:(MBProgressHUDCompletionBlock) complete;

/// toast
+(void)hq_toastWithText:(NSString* )text;
+(void)hq_toastWithText:(NSString* )text completeBlock:(MBProgressHUDCompletionBlock) complete;

/// progress 加载...   需要手动调用 hq_dismiss 方法
+(void)hq_showProgressWithMessage:(NSString* )message;
+(void)hq_showProgressWithMessage:(NSString* )message animation:(BOOL)animation;
+(void)hq_showProgressWithMessage:(NSString* )message animation:(BOOL)animation completeBlock:(MBProgressHUDCompletionBlock) complete;

/// dismiss HUD
+ (void)hq_dismiss;

/// success
+ (void)hq_showSuccessWithMessage:(NSString* )message;
+ (void)hq_showSuccessWithMessage:(NSString* )message completeBlock:(MBProgressHUDCompletionBlock) complete;

/// error
+ (void)hq_showErrorWithMessage:(NSString* )message;
+ (void)hq_showErrorWithMessage:(NSString* )message completeBlock:(MBProgressHUDCompletionBlock) complete;

@end
