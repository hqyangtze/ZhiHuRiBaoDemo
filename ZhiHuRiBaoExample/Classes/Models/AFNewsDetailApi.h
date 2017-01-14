//
//  AFNewsDetailApi.h
//  AppFrame
//
//  Created by HQ on 2016/12/31.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFRequestApi.h"

@interface AFNewsDetailApi : AFRequestApi
+ (instancetype)getModelWithNewsID:(NSString* )ID;
@end
