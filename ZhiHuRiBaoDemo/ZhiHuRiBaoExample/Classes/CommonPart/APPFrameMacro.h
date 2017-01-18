//
//  APPFrameMacro.h
//  AppFrame
//
//  Created by HQ on 2016/11/29.
//  Copyright © 2016年 HQ. All rights reserved.
//

#ifndef APPFrameMacro_h
#define APPFrameMacro_h

#ifdef DEBUG
#define LOG(...) NSLog(__VA_ARGS__)
#else
#define LOG(...)
#endif

#define WEAK(o) __weak typeof (&*o) weak_##o = o;
#define STRONG(o) __strong typeof (&*o) strong_##o = o;

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define STATUSBAR_HEIGHT (20.0)
#define NAVIGATION_HEIGHT (44.0)
#define TABBAR_HEIGHT   (49.0)
#define TOOLBAR_HEIGHT   (44.0)
#define SEPARATOR_LINE_HEIGHT (0.25 * [UIScreen mainScreen].scale)

#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

#define BASE_375(x) ((x) * (SCREEN_WIDTH) / 375)


#pragma mark - COLOR
// rgb颜色转换（16进制->10进制）
#define COLOR_RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

//主题蓝色
#define THEME_COLOR COLOR_RGB(0x3f96f0)  /// 63 150 240
#define COMMON_BG_COLOR COLOR_RGB(0xf5f1f0)
#define SEPARATOR_COLOR COLOR_RGB(0xf0ebea)
#define WHITE_COLOR  RGB(255,255,255)
/// 加上透明度的白色
#define WHITE_COLOR_A(alpha) RGBA(255,255,255,alpha)
#define CLEAR_COLOR  RGBA(255,255,255,0)
/// 较深的背景灰色
#define DARK_COMMON_BG_COLOR  RGB(150,150,150)
#define DARK_TEXT_COLOR [UIColor darkTextColor]
#define LIGHT_TEXT_COLOR [UIColor lightTextColor]


#define UIFontMake(size) [UIFont systemFontOfSize:size]
#define UIFontBoldMake(size) [UIFont boldSystemFontOfSize:size]
#endif /* APPFrameMacro_h */
