//
//  AFNewsDetailViewController.h
//  AppFrame
//
//  Created by HQ on 2017/1/12.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import "BaseViewController.h"

@interface AFNewsDetailViewController : BaseViewController

@property (nonatomic, copy) NSString* newsID;

- (void)setDataArray:(NSArray* )newsModels currentIndex:(NSInteger )index;

@end
