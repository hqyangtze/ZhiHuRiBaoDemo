//
//  AFNewsDetailView.h
//  AppFrame
//
//  Created by HQ on 2017/1/12.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^loadDataCall) (void);

@interface AFNewsDetailView : UIView

+ (instancetype)getViewWithSize:(CGSize )size newsID:(NSString* )newsID needLoadInfo:(BOOL)need updateStatusStyle:(void(^)(BOOL isLight)) updateStatusCall;

/// 点击图片回调
- (void)didClickImageCall:(void(^)(NSString* URLString)) clickImage;

/// 加载新的数据，不会显示提示信息
- (void)resetNewsID:(NSString* )newsID;

/// 下拉控件回调
- (void)loadNewDataFromNetwork:(loadDataCall) newdataCall;

/// 上拉控件回调
- (void)loadMoreDataFromNetwork:(loadDataCall )moredataCall;

/// 设置加载控件显示的文字(这里的代码写的不好啊）
- (void)setLoadComponentInfoHeader:(NSString* )header footer:(NSString* )footer;


@end
