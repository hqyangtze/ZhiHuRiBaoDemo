//
//  AFWebImageView.h
//  AppFrame
//
//  Created by HQ on 2016/11/29.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageManager.h"

@interface AFWebImageView : UIImageView

/// 是否含有加载完成动画默认是 NO
@property (nonatomic, assign) BOOL hasAnimation;
/// 是否需要显示ActivityIndicatorView 默认是 YES
@property (nonatomic, assign) BOOL needShowActivityIndicatorView;

/**
	下载函数,使用默认的placeholder和选项，不支持进度回调，支持完成的回调
 @param url  下载地址
 @param completedBlock 下载完成回调
 */
- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock;

/**
	下载函数,使用默认的placeholder和选项，支持进度和完成的回调
 @param url  下载地址
 @param progressBlock 下载进度回调
 @param completedBlock 下载完成回调
 */
- (void)setImageWithURL:(NSURL *)url progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock ;

/**
	下载函数
 @param url  下载地址
 @param placeholder 指定的占位图片
 */
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;


- (void)setImageWithURLString:(NSString *)urlStr placeholderImage:(UIImage *)placeholder;

/* 下载取消 */
- (void)cancelImageLoad;

@end
