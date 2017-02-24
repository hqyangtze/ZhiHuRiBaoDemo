//
//  UIWebView+AppFrame.m
//  ZhiHuRiBaoExample
//
//  Created by HQ on 2017/1/19.
//  Copyright © 2017年 HQ. All rights reserved.
//

typedef void (^AFClickImageBlock)(NSString *URLString);
#import "UIWebView+AppFrame.h"
#import <objc/runtime.h>


@interface UIWebView()<UIGestureRecognizerDelegate>
@property (nonatomic, copy) AFClickImageBlock af_clickImage;
@property (nonatomic, copy) NSString* af_imageString;
@property (nonatomic, strong) NSNumber* af_isClickImage;
@property (nonatomic, strong) UITapGestureRecognizer* af_customTap;
@end

@implementation UIWebView (AppFrame)



- (AFClickImageBlock)af_clickImage{
    return objc_getAssociatedObject(self, @selector(af_clickImage));
}
- (void)setAf_clickImage:(AFClickImageBlock)clickImage{
    objc_setAssociatedObject(self, @selector(af_clickImage), clickImage, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)af_imageString{
    return objc_getAssociatedObject(self, @selector(af_imageString));
}
-(void)setAf_imageString:(NSString *)af_imageString{
    objc_setAssociatedObject(self, @selector(af_imageString), af_imageString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSNumber*)af_isClickImage{
    return objc_getAssociatedObject(self, @selector(af_isClickImage));
}
- (void)setAf_isClickImage:(NSNumber*)af_isClickImage{
    objc_setAssociatedObject(self, @selector(af_isClickImage), af_isClickImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UITapGestureRecognizer *)af_customTap{
    return objc_getAssociatedObject(self, @selector(af_customTap));
}

- (void)setAf_customTap:(UITapGestureRecognizer *)af_customTap{
    objc_setAssociatedObject(self, @selector(af_customTap), af_customTap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)af_didClickImageCall:(void (^)(NSString *imgURLString))clickImage{
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:nil action:nil];
    [self addGestureRecognizer:gesture];

    gesture.delegate = self;
    self.af_customTap = gesture;
    self.af_clickImage = clickImage;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        if (gestureRecognizer == self.af_customTap) {
            CGPoint touchPoint = [touch locationInView:self];
            NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
            NSString *URLString = [self stringByEvaluatingJavaScriptFromString:imgURL];
            self.af_isClickImage = @(NO);
            if (URLString.af_string.length > 0) {
                self.af_isClickImage = @(YES);
                self.af_imageString = URLString;
            }
        }
    }
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == self.af_customTap) {
        if (self.af_imageString && [self.af_isClickImage boolValue]) {
            !self.af_clickImage ? : self.af_clickImage(self.af_imageString);
            self.af_imageString = nil;
        }
        return NO;
    }

    return YES;
}

@end

