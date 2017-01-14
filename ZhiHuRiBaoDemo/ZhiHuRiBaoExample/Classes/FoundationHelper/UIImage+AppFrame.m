//
//  UIImage+AppFrame.m
//  AppFrame
//
//  Created by HQ on 2016/11/30.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "UIImage+AppFrame.h"

@implementation UIImage (AppFrame)

- (UIImage *)af_scaleToSize:(CGSize)size {

    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    if (self.size.width * size.height == size.width * self.size.height) {
        [self drawInRect:CGRectMake(0,0,size.width,size.height)];
    } else if (self.size.width * size.height > size.width * self.size.height) { // width is large
        float height = size.width * self.size.height / self.size.width;
        [self drawInRect:CGRectMake(0, (size.height - height) / 2, size.width, height)];
    } else { // height is large
        float width = size.height * self.size.width / self.size.height;
        [self drawInRect:CGRectMake((size.width - width) / 2, 0, width, size.height)];
    }
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)af_circleImage{
    CGFloat scale = [UIScreen mainScreen].scale;

    CGSize size = [self size];

    CGFloat width = size.width * scale;
    CGFloat height = size.height * scale;

    CGFloat radius = width <= height ? width/2:height/2;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(nil, radius*2, radius*2, 8, 0, colorSpace, kCGImageAlphaPremultipliedFirst);

    CGContextBeginPath(context);
    CGContextAddArc(context,radius,radius,radius,0,2*M_PI,1);
    CGContextClip(context);

    CGContextDrawImage(context, CGRectMake(0, 0, radius*2, radius*2), self.CGImage);

    CGImageRef cgimg = CGBitmapContextCreateImage(context);
    UIImage *img = [UIImage imageWithCGImage:cgimg];

    if(cgimg) CGImageRelease(cgimg);
    if(context) CGContextRelease (context);
    if(colorSpace) CGColorSpaceRelease(colorSpace);
    
    return img;
}

- (UIImage *)af_fixImageOrientation{
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp)
        return self;

    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;

    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }

    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }

    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;

        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }

    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (UIImage *)af_imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, .0);
    CGContextRef context = UIGraphicsGetCurrentContext();

    [color set];
    CGContextFillRect(context, CGRectMake(.0, .0, size.width, size.height));

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)af_imageWithColor:(UIColor *)color{
    return [self af_imageWithColor:color size:CGSizeMake(1, 1)];
}

- (UIImage *)af_imageApplyingAlpha:(CGFloat)alpha{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);

    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);

    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);

    CGContextSetAlpha(ctx, alpha);

    CGContextDrawImage(ctx, area, self.CGImage);

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return newImage;
}

+ (UIImage *)af_placeholderImage{
    return [UIImage af_imageWithColor:RGB(200, 200, 200)];
}

@end
