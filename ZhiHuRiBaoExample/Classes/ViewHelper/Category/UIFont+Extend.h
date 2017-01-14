//
//  UIFont+Extend.h
//  AppFrame
//
//  Created by HQ on 2016/11/29.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Extend)

@property(nonatomic, assign) CGSize fontSize;

+(UIFont*)getFontWithFontName:(NSString*)fontName displayStr:(NSString*)string fontSize:(CGFloat)size;

@end
