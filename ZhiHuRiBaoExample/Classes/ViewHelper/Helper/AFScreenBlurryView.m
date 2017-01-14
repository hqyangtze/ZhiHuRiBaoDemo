//
//  AFBlurryView.m
//  AppFrame
//
//  Created by HQ on 2016/11/29.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFScreenBlurryView.h"
#import "UIImage+Extend.h"

@interface AFScreenBlurryView(){
     UIImageView* _imageView;
}

@end

@implementation AFScreenBlurryView

-(instancetype)init{
    self = [super init];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _imageView.image = [AFScreenBlurryView blurImage];
        self.frame = [UIScreen mainScreen].bounds;
        [self addSubview:_imageView];
    }
    return self;
}


-(void)updateImage{
    _imageView.image = [AFScreenBlurryView blurImage];
}

/// 毛玻璃效果
+(UIImage *)blurImage{
    UIImage *image = [[self screenShot] imgWithBlur];
    return image;
}

/// 屏幕截屏
+(UIImage *)screenShot{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(SCREEN_WIDTH*[UIScreen mainScreen].scale, SCREEN_HEIGHT*[UIScreen mainScreen].scale), YES, 0);
    //设置截屏大小
    [[[[UIApplication sharedApplication] keyWindow] layer] renderInContext:UIGraphicsGetCurrentContext()];

    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH*[UIScreen mainScreen].scale,SCREEN_HEIGHT*[UIScreen mainScreen].scale);

    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    CGImageRelease(imageRefRect);
    return sendImage;
}

@end
