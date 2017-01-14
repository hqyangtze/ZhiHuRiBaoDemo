//
//  AFBeforeNewsApi.h
//  AppFrame
//
//  Created by HQ on 2016/12/26.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFRequestApi.h"

@interface AFBeforeNewsApi : AFRequestApi

+ (instancetype)getModelWithDate:(NSString* )date;

@end
