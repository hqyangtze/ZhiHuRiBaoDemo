//
//  UIColor+AppFrame.h
//  AppFrame
//
//  Created by HQ on 2016/11/30.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AppFrame)

/**
 根据颜色16进制

 @param hexValue 形如 0xffffff
 @param alphaValue 透明度
 */
+ (UIColor *)af_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

+ (UIColor *)af_colorWithHex:(NSInteger)hexValue;

+ (UIColor *)af_randomColor;

/** 由16进制字符串转换为 UIColor 对象 */
+ (UIColor *)af_hexStringToColor:(NSString *)stringToConvert;

@end
