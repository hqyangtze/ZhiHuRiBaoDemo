//
//  UIView+HQExtend.m
//  HQBaseLayout
//
//  Created by HQ on 2016/11/24.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "UIView+HQExtend.h"

@implementation UIView (HQExtend)

-(CGFloat)hq_x
{
    return self.frame.origin.x;
}
- (void)setHq_x:(CGFloat)hq_x
{
    CGRect frame = self.frame;
    frame.origin.x = hq_x;
    self.frame = frame;
}

-(CGFloat)hq_y
{
    return self.frame.origin.y;
}
- (void)setHq_y:(CGFloat)hq_y
{
    CGRect frame = self.frame;
    frame.origin.y = hq_y;
    self.frame = frame;
}

-(CGFloat)hq_width
{
    return self.frame.size.width;
}
- (void)setHq_width:(CGFloat)hq_width
{
    CGRect frame = self.frame;
    frame.size.width = hq_width;
    self.frame = frame;
}


-(CGFloat)hq_height
{
    return self.frame.size.height;
}
- (void)setHq_height:(CGFloat)hq_height
{
    CGRect frame = self.frame;
    frame.size.height = hq_height;
    self.frame = frame;
}

- (CGSize)hq_size
{
    return self.frame.size;
}
- (void)setHq_size:(CGSize)hq_size
{
    CGRect frame = self.frame;
    frame.size = hq_size;
    self.frame = frame;
}

- (CGPoint)hq_origin
{
    return self.frame.origin;
}
- (void)setHq_origin:(CGPoint)hq_origin
{
    CGRect frame= self.frame;
    frame.origin = hq_origin;
    self.frame = frame;
}

- (CGPoint)hq_center
{
    return self.center;
}

- (void)setHq_center:(CGPoint)hq_center
{
    CGPoint center= self.center;
    center = hq_center;
    self.center = center;
}

+(instancetype)hq_frameWithX:(CGFloat) x Y:(CGFloat) y width:(CGFloat) width height:(CGFloat) height
{
    return [[self alloc] initWithFrame:CGRectMake(x, y, width, height)];
}


@end
