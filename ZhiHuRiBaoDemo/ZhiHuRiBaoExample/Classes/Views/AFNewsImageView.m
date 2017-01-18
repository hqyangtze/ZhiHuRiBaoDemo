//
//  AFNewsImageView.m
//  ZhiHuRiBaoExample
//
//  Created by HQ on 2017/1/18.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import "AFNewsImageView.h"

@interface AFNewsImageView()<UIScrollViewDelegate>
@property (weak, nonatomic)  AFWebImageView *imageView;
@property (weak, nonatomic)  UIScrollView *baseScrollView;
@property (weak, nonatomic)  UITapGestureRecognizer *tapGesture;
@property (weak, nonatomic)  UITapGestureRecognizer *tapSingleGesture;
@property(nonatomic, copy) NSString* picturePath;
@end

@implementation AFNewsImageView


+ (void)showWithImageURLString:(NSString *)URLString{
    AFNewsImageView* view = [AFNewsImageView hq_frameWithX:0 Y:0 width:SCREEN_WIDTH height:SCREEN_HEIGHT];
    view.picturePath = URLString;
    [view addSubView];
    [view layoutIfNeed];
    view.alpha = 0.0;
    [[[UIApplication sharedApplication].windows lastObject] addSubview:view];
    [UIView animateWithDuration:0.5 animations:^{
        view.alpha = 1.0;
    }];
}

- (void)addSubView{
    UIScrollView* baseView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    baseView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    baseView.showsVerticalScrollIndicator = NO;
    baseView.showsHorizontalScrollIndicator = NO;
    baseView.bounces = NO;
    baseView.delegate = self;
    baseView.backgroundColor = RGBA(0, 0, 0, 0.8);
    baseView.minimumZoomScale = 1.0;
    baseView.maximumZoomScale = 3.0;
    [self addSubview:baseView];
    self.baseScrollView = baseView;

    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapEvent:)];
    gesture.numberOfTapsRequired = 2;
    [self.baseScrollView addGestureRecognizer:gesture];
    self.tapGesture = gesture;

    UITapGestureRecognizer* singleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    singleGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleGesture];
    self.tapSingleGesture = singleGesture;

    AFWebImageView* imageView = [[AFWebImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [baseView addSubview:imageView];
    self.imageView = imageView;
}

- (void)layoutIfNeed{
    void (^layoutViewByScaleImage)(UIImage* image) = ^(UIImage* image){
        CGSize imgSize = [image size];
        self.imageView.hq_height = SCREEN_WIDTH / imgSize.width * imgSize.height;
        self.baseScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.imageView.hq_height);
        if (self.imageView.hq_height > SCREEN_HEIGHT) {
            self.imageView.hq_y = 0.0f;
        }else{
            self.imageView.hq_y = (SCREEN_HEIGHT - self.imageView.hq_height) * 0.5;
        }
        [self setNeedsDisplay];
    };

    if ([self.picturePath hasPrefix:@"http://"] || [self.picturePath hasPrefix:@"https://"]) {
        [self.imageView setImageWithURL:[NSURL URLWithString:self.picturePath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                layoutViewByScaleImage(image);
            }
        }];
    }else{
        UIImage* image = [UIImage imageWithContentsOfFile:self.picturePath.af_toSafeString];
        [self.imageView setImage:image];
        if (image) {
            layoutViewByScaleImage(image);
        }
    }
}

#pragma mark - doubleTapEvent
- (void)doubleTapEvent:(UITapGestureRecognizer* )gesture{
    if (gesture == self.tapGesture) {
        CGFloat scale = self.baseScrollView.zoomScale > 1.0 ? 1.0 : 2.0;
        [self.baseScrollView setZoomScale:scale animated:YES];
    }
}

- (void)dismiss:(UITapGestureRecognizer* )gesture{
    if (self.tapSingleGesture == gesture) {
        [self removeFromSuperview];
    }
}

#pragma mark - UIScrollViewDelegate
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return  self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    self.imageView.center = [self centerOfScrollViewContent:scrollView];
}

- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}

- (void)dealloc{
    [self.tapGesture removeTarget:self action:@selector(doubleTapEvent:)];
    [self.baseScrollView removeGestureRecognizer:self.tapGesture];
}

@end
