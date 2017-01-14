//
//  UIFont+Extend.m
//  AppFrame
//
//  Created by HQ on 2016/11/29.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "UIFont+Extend.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>

@implementation UIFont (Extend)

static char* sizeWidthKey = "sizeWidth";
static char* sizeHeightKey = "sizeHeightKey";

-(void)setFontSize:(CGSize)fontSize{
    objc_setAssociatedObject(self, sizeWidthKey, [NSNumber numberWithDouble:fontSize.width], OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, sizeHeightKey, [NSNumber numberWithDouble:fontSize.height], OBJC_ASSOCIATION_RETAIN);
}

-(CGSize)fontSize{
    NSNumber* sizeWidth = objc_getAssociatedObject(self, sizeWidthKey);
    NSNumber* sizeHeight = objc_getAssociatedObject(self, sizeHeightKey);

    CGSize tempSize;
    tempSize.width = [sizeWidth doubleValue];
    tempSize.height = [sizeHeight doubleValue];
    return tempSize;
}

+(UIFont*)getFontWithFontName:(NSString*)fontName displayStr:(NSString*)string fontSize:(CGFloat)size{
    UIFont * titleFont = nil;
    NSString* _tempName = nil;
    if (fontName == nil) {
        _tempName = @"Helvetica";
    }else{
        _tempName = fontName;
    }

    if (size < 0.001) {
        size = 17.0f;
    }
    titleFont = [UIFont fontWithName:_tempName size:size];
    CGSize titleSize;
    if (string == nil) {
        titleSize.height = 0;
        titleSize.width = 0;
    }else{
        titleSize = [string sizeWithAttributes: @{NSFontAttributeName: titleFont}];
    }
    titleFont.fontSize = titleSize;
    return titleFont;
}

@end
