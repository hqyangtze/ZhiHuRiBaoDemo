//
//  AFNewsImageView.m
//  ZhiHuRiBaoExample
//
//  Created by HQ on 2017/1/18.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import "AFNewsImageView.h"
#import "BaseViewController.h"

static const CGFloat kBGAlpha = 0.9;

@interface AFNewsImageView()<UIScrollViewDelegate>{
    BaseViewController*     _helperVC;
}
@property (weak, nonatomic)  AFWebImageView *imageView;
@property (weak, nonatomic)  UIScrollView *baseScrollView;
@property (weak, nonatomic)  UIButton *downloadBtn;
@property (weak, nonatomic)  UITapGestureRecognizer *tapGesture;
@property (weak, nonatomic)  UITapGestureRecognizer *tapSingleGesture;
@property(nonatomic, copy) NSString* picturePath;
@end

@implementation AFNewsImageView


+ (void)showWithImageURLString:(NSString *)URLString{
    AFNewsImageView* view = [AFNewsImageView hq_frameWithX:0 Y:0 width:SCREEN_WIDTH height:SCREEN_HEIGHT];
    view.picturePath = URLString;
    [view addSubViews];
    [view layoutIfNeed];
    view.alpha = 0.0;
    [[[UIApplication sharedApplication].windows lastObject] addSubview:view];
    [UIView animateWithDuration:0.5 animations:^{
        view.alpha = 1.0;
    }];
}

- (void)addSubViews{
    UIScrollView* baseView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    baseView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    baseView.showsVerticalScrollIndicator = NO;
    baseView.showsHorizontalScrollIndicator = NO;
    baseView.bounces = YES;
    baseView.alwaysBounceVertical = YES;
    baseView.delegate = self;
    baseView.backgroundColor = RGBA(0, 0, 0, kBGAlpha);
    baseView.minimumZoomScale = 1.0;
    baseView.maximumZoomScale = 5.0;
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
    [self.tapSingleGesture requireGestureRecognizerToFail:self.tapGesture];

    AFWebImageView* imageView = [[AFWebImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [baseView addSubview:imageView];
    self.imageView = imageView;

    UIButton* dlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dlBtn setImage:[[UIImage imageNamed:k_zhifuribao_news_image_download_icon_image] af_scaleToSize:CGSizeMake(30, 30)] forState:UIControlStateNormal];
    [dlBtn setHidden:YES];

    [dlBtn addTarget:self action:@selector(saveImageToDisk) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dlBtn];
    self.downloadBtn = dlBtn;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    [self.downloadBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.with.width.equalTo(40.0);
        make.rightMargin.with.bottomMargin.equalTo(- 20.0);
    }];
}

- (void)layoutIfNeed{
    void (^layoutViewByScaleImage)(UIImage* image) = ^(UIImage* image){
        CGSize imgSize = [image size];
        self.imageView.hq_height = SCREEN_WIDTH / imgSize.width * imgSize.height;
        CGFloat contentSizeHeight = SCREEN_HEIGHT > self.imageView.hq_height ? SCREEN_HEIGHT : self.imageView.hq_height;
        self.baseScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, contentSizeHeight);
        if (self.imageView.hq_height > SCREEN_HEIGHT) {
            self.imageView.hq_y = 0.0f;
        }else{
            self.imageView.hq_y = (SCREEN_HEIGHT - self.imageView.hq_height) * 0.5;
        }
        [self.downloadBtn setHidden:NO];
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
        CGFloat scale = self.baseScrollView.zoomScale > 1.0 ? 1.0 : 3.0;
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

/// 实现 仿滑动消失
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = kBGAlpha - (ABS(offsetY) / SCREEN_HEIGHT) * 2.6;

    self.baseScrollView.backgroundColor = RGBA(0, 0, 0, alpha);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{

    if (ABS(velocity.y) > 2.05f) {
        [self removeFromSuperview];
        return;
    }

    if (targetContentOffset->y < 0  || (targetContentOffset->y > self.imageView.hq_height)) {
        [self removeFromSuperview];
    }
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

- (void)saveImageToDisk{
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
     _helperVC = [BaseViewController new];
     if (error) {
         [_helperVC showError:error];
     }else{
         [_helperVC showWithMessage:@"保存成功" animation:YES];
     }
}

- (void)dealloc{
    _helperVC = nil;
    [self.downloadBtn removeTarget:self action:@selector(saveImageToDisk) forControlEvents:UIControlEventTouchUpInside];
    [self.tapGesture removeTarget:self action:@selector(doubleTapEvent:)];
    [self.tapSingleGesture removeTarget:self action:@selector(dismiss:)];
    [self.baseScrollView removeGestureRecognizer:self.tapGesture];
    [self removeGestureRecognizer:self.tapSingleGesture];
}

@end
