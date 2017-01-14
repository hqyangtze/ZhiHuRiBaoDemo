//
//  UIViewController+Extend.h
//  AppFrame
//
//  Created by HQ on 2016/11/29.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD+HQExtend.h"
@interface UIViewController(Extend)

/// 设置“返回” 文字
-(void)af_setBackWithTitle:(NSString*)backTitle;

/**
 设置导航栏的信息

 @param left  接受参数类型 NSString,UIImage,UIView NSArray<UIBarButtonItem *>;
 @param right 接受参数类型 NSString,UIImage,UIView,NSArray<UIBarButtonItem *>;
 @param title 接受参数类型 NSString,UIView
 */
-(void)af_setNavigationItemWithLeftObject:(NSObject*)left right:(NSObject*)right title:(NSObject*)title;

/// 当导航栏左边只有一个item时，这个方法才会生效
-(void)af_leftTopAction;

/// 当导航栏右边只有一个item时，这个方法才会生效
-(void)af_rightTopAction;

/**
 扩展pop退出控制器的方法

 @param aimViewControllerStrings 可能返回的控制器类名称数组
 */
- (void)af_popToViewControllers:(NSArray*)aimViewControllerStrings;

@end



/// HUD
@interface UIViewController(HUD)
/// message
- (void)showWithMessage:(NSString* )message;
- (void)showWithMessage:(NSString* )message animation:(BOOL)animation;
- (void)showWithMessage:(NSString* )message animation:(BOOL)animation completeBlock:(MBProgressHUDCompletionBlock) complete;

/// toast
- (void)toastWithText:(NSString* )text;
- (void)toastWithText:(NSString* )text completeBlock:(MBProgressHUDCompletionBlock) complete;

/// progress 加载...   需要手动调用 dismiss 方法
- (void)showProgressWithMessage:(NSString* )message;
- (void)showProgressWithMessage:(NSString* )message animation:(BOOL)animation;
- (void)showProgressWithMessage:(NSString* )message animation:(BOOL)animation completeBlock:(MBProgressHUDCompletionBlock) complete;

/// dismiss HUD
- (void)dismiss;

/// success
- (void)showSuccessWithMessage:(NSString* )message;
- (void)showSuccessWithMessage:(NSString* )message completeBlock:(MBProgressHUDCompletionBlock) complete;

/// error
- (void)showError:(NSError* )error;
- (void)showErrorWithMessage:(NSString* )message;
- (void)showErrorWithMessage:(NSString* )message completeBlock:(MBProgressHUDCompletionBlock) complete;

@end
