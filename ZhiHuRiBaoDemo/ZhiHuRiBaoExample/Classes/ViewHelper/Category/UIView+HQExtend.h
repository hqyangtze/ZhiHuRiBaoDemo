//
//  UIView+HQExtend.h
//  HQBaseLayout
//
//  Created by HQ on 2016/11/24.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HQExtend)

@property (nonatomic , assign) CGFloat hq_x;

@property (nonatomic , assign) CGFloat hq_y;

@property (nonatomic , assign) CGFloat hq_height;

@property (nonatomic , assign) CGFloat hq_width;

@property (nonatomic , assign) CGSize  hq_size;

@property (nonatomic , assign) CGPoint hq_origin;

@property (nonatomic , assign) CGPoint hq_center;

+(instancetype)hq_frameWithX:(CGFloat) x Y:(CGFloat) y width:(CGFloat) width height:(CGFloat) height;

@end
