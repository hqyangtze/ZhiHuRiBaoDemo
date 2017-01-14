//
//  WebViewController.h
//  AppFrame
//
//  Created by HQ on 2016/11/28.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController

@property (nonatomic, copy) NSString* URLString;
@property (nonatomic, copy) NSString* localWebString;

/// 分享链接
@property (nonatomic, copy) NSString* shareString;

@end
