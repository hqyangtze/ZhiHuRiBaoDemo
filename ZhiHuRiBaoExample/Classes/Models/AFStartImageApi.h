//
//  AFStartImageApi.h
//  ZhiHuRiBaoExample
//
//  Created by HQ on 2017/1/14.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import "AFRequestApi.h"

@interface AFStartImageApi : AFRequestApi

+ (instancetype)getModelWithImgScale:(NSString* )scale;

@end
