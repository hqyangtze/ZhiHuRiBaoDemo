//
//  AFNewsDetailApi.m
//  AppFrame
//
//  Created by HQ on 2016/12/31.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFNewsDetailApi.h"
#import "AFNetworkConfigObject.h"
#import "AFNewsDetailModel.h"
@interface AFNewsDetailApi()
@property (nonatomic, copy) NSString* newsID;
@end

@implementation AFNewsDetailApi

+(instancetype)getModelWithNewsID:(NSString *)ID{
    AFNewsDetailApi* api = [AFNewsDetailApi new];
    api.newsID = ID;
    return api;
}

- (Class)responseModelClass{
    return [AFNewsDetailModel class];
}

- (NSString *)requestUrl{
    NSString* base = [[AFNetworkConfigObject shareConfig] apiForClass:[self class]];;
    return [NSString stringWithFormat:@"%@/%@",base,self.newsID];
}

@end
