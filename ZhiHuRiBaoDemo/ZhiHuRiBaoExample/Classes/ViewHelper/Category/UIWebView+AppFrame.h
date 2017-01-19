//
//  UIWebView+AppFrame.h
//  ZhiHuRiBaoExample
//
//  Created by HQ on 2017/1/19.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIWebView (AppFrame)

/// 点击图片回调 返回被点击图片的地址字符串
- (void)af_didClickImageCall:(void(^)(NSString* URLString)) clickImage;

@end
