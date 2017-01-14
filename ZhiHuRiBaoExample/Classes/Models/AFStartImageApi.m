//
//  AFStartImageApi.m
//  ZhiHuRiBaoExample
//
//  Created by HQ on 2017/1/14.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import "AFStartImageApi.h"
#import "AFStartImageModel.h"
#import "AFNetworkConfigObject.h"

@interface AFStartImageApi()
@property (copy, nonatomic) NSString* scale;
@end

@implementation AFStartImageApi

+ (instancetype)getModelWithImgScale:(NSString *)scale{
    AFStartImageApi* api = [AFStartImageApi new];
    api.scale = scale;
    return api;
}

- (Class)responseModelClass{
    return [AFStartImageModel class];
}

- (NSString *)requestUrl{
    NSString* base = [[AFNetworkConfigObject shareConfig] apiForClass:[self class]];;
    return [NSString stringWithFormat:@"%@/%@",base,self.scale];
}


@end
