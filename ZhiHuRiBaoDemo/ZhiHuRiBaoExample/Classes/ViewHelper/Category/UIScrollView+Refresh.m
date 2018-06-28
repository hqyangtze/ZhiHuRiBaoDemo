//
//  UIScrollView+Refresh.m
//  AppFrame
//
//  Created by HQ on 2016/12/29.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "UIScrollView+Refresh.h"

@implementation UIScrollView (Refresh)

/* header*/
- (MJRefreshNormalHeader *)af_loadHeader{
    return (MJRefreshNormalHeader*)self.mj_header;
}

- (void)addRefreshHeaderWithCall:(void (^)(void))call{
    self.mj_header = nil;
    MJRefreshNormalHeader* header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        call== nil ? : call();
    }];
    /// 设置
    header.layer.zPosition = 10000;
    header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    header.ignoredScrollViewContentInsetTop = 30.0;
    [header setBackgroundColor:RGBA(100, 100, 100, 0.0)];
    header.labelLeftInset = BASE_375(30);
    [header.stateLabel setHidden:YES];
    [header.lastUpdatedTimeLabel setHidden:YES];
    header.stateLabel.textColor = RGB(255, 255, 255);
    self.mj_header = header;
    [self addHeraderGradientLayer];
}
- (void)setHeaderRefreshedCall:(void (^)(void))endCall{
    [self.mj_header setEndRefreshingCompletionBlock:endCall];
}
- (void)removeRefreshHeader{
    self.mj_header = nil;
}

/* footer*/
- (MJRefreshAutoNormalFooter *)af_loadFooter{
    return (MJRefreshAutoNormalFooter*)self.mj_footer;
}

- (MJRefreshBackNormalFooter *)af_loadBackFooter{
    return (MJRefreshBackNormalFooter*)self.mj_footer;
}

- (void)addRefreshFooterWithCall:(void (^)(void))call{
    self.mj_footer = nil;
    MJRefreshAutoNormalFooter* footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        call== nil ? : call();
    }];
    /// 设置
    footer.layer.zPosition = 10000;
    footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    footer.triggerAutomaticallyRefreshPercent = 0.0;
    [footer setBackgroundColor:RGBA(200, 200, 200, 0.0)];
    footer.labelLeftInset = BASE_375(30);
    footer.automaticallyHidden = YES;
    [footer.stateLabel setTextColor:RGB(255, 255, 255)];
    self.mj_footer = footer;
    [self addFooterGradientLayer];
}

- (void)addRefreshBackFooterWithCall:(void(^)(void)) call{
    self.mj_footer = nil;
    MJRefreshBackNormalFooter* footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        call== nil ? : call();
    }];
    /// 设置
    footer.layer.zPosition = 10000;
    footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    footer.ignoredScrollViewContentInsetBottom = 20.0;
    [footer setBackgroundColor:RGBA(200, 200, 200, 0.0)];
    footer.labelLeftInset = BASE_375(30);
    footer.automaticallyHidden = YES;
    [footer.stateLabel setTextColor:RGB(255, 255, 255)];
    self.mj_footer = footer;
    [self addFooterGradientLayer];
}

- (void)setFooterRefreshedCall:(void (^)(void))endCall{
    [self.mj_footer setEndRefreshingCompletionBlock:endCall];
}
- (void)removeRefreshFooter{
    self.mj_footer = nil;
}

/// 自动刷新
- (void)beginRefresh{
    [self.mj_header beginRefreshing];
}
/// 结束刷新
- (void)endRefresh{
    if (self.mj_header) {
        [self.mj_header endRefreshing];
    }

    if (self.mj_footer) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.mj_footer.state == MJRefreshStateNoMoreData) {
                [self.mj_footer endRefreshingWithNoMoreData];
            } else {
                [self.mj_footer endRefreshing];
            }
        });
    }
}

/// 没有更多数据
-(void)showNoMoreData{
    if (self.mj_header) {
        [self.mj_header endRefreshing];
    }

    if (self.mj_footer) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mj_footer endRefreshingWithNoMoreData];
        });
    }
}


/// helper
- (void)addHeraderGradientLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.mj_header.bounds;
    CGRect frame = gradientLayer.frame;
    frame.origin.y = -800;
    frame.size.height = self.mj_header.hq_height + 800;
    gradientLayer.frame = frame;

    gradientLayer.colors = @[
                             (id)RGBA(240, 240, 240, 0.1).CGColor,
                             (id)RGBA(240, 240, 240, 0.1).CGColor,
                             (id)RGBA(200, 200, 200, 0.3).CGColor,
                             (id)RGBA(240, 240, 240, 0.1).CGColor,
                             ];
    gradientLayer.locations = @[@(0.90),@(0.95),@(0.97)];

    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);

    [self.mj_header.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)addFooterGradientLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.mj_footer.bounds;
    CGRect frame = gradientLayer.frame;
    frame.size.height = self.mj_footer.hq_height + 800;
    gradientLayer.frame = frame;

    gradientLayer.colors = @[
                             (id)RGBA(240, 240, 240, 0.3).CGColor,
                             (id)RGBA(200, 200, 200, 0.3).CGColor,
                             (id)RGBA(230, 230, 230, 0.1).CGColor,
                             (id)RGBA(255, 255, 255, 0.0).CGColor,
                             ];
    gradientLayer.locations = @[@(0.01),@(0.023),@(0.08)];

    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);

    [self.mj_footer.layer insertSublayer:gradientLayer atIndex:0];
}

@end
