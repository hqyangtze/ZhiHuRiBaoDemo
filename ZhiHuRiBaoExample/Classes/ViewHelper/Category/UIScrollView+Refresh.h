//
//  UIScrollView+Refresh.h
//  AppFrame
//
//  Created by HQ on 2016/12/29.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefreshAutoNormalFooter.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshBackNormalFooter.h"

@interface UIScrollView (Refresh)

/// 获取下拉控件
@property (weak, nonatomic, readonly) MJRefreshNormalHeader* af_loadHeader;

/// 添加下拉刷新控件，call 回调Block
- (void)addRefreshHeaderWithCall:(void(^)(void)) call;
/// 下拉结束后回调 endCall 回调 Block
- (void)setHeaderRefreshedCall:(void(^)(void)) endCall;
/// 移除下拉控件 loadHeader = nil
- (void)removeRefreshHeader;



/// 获取上拉控件
@property (weak, nonatomic, readonly) MJRefreshAutoNormalFooter* af_loadFooter;
/// 添加上拉刷新控件，call 回调Block
- (void)addRefreshFooterWithCall:(void(^)(void)) call;

///  不是自动刷新的控件
@property (weak, nonatomic, readonly) MJRefreshBackNormalFooter* af_loadBackFooter;
/// 添加上拉刷新控件，call 回调Block
- (void)addRefreshBackFooterWithCall:(void(^)(void)) call;

/// 上拉结束后回调 endCall 回调 Block
- (void)setFooterRefreshedCall:(void(^)(void)) endCall;
/// 移除上拉控件 loadFooter = nil
- (void)removeRefreshFooter;


/// 下拉控件自动刷新
- (void)beginRefresh;

/// 结束刷新
- (void)endRefresh;

/// 没有更多数据
-(void)showNoMoreData;
@end
