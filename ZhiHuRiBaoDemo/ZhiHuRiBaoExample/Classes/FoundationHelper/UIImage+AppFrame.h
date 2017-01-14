//
//  UIImage+AppFrame.h
//  AppFrame
//
//  Created by HQ on 2016/11/30.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AppFrame)

/** 修正UIImage对象的方向 */
- (UIImage *)af_fixImageOrientation;

/** 根据颜色获取图片 */
+ (UIImage *)af_imageWithColor:(UIColor *)color size:(CGSize)size;

/** 根据颜色获取图片 size  = {1,1} */
+ (UIImage *)af_imageWithColor:(UIColor *)color;

/** 改变图片的大小 */
- (UIImage *)af_scaleToSize:(CGSize)size;

/** 生成圆形图片 */
- (UIImage *)af_circleImage;

/** 图片添加透明度效果 */
- (UIImage *)af_imageApplyingAlpha:(CGFloat) alpha;

/** APP 默认显示的图片 */
+ (UIImage* )af_placeholderImage;

@end
