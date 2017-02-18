//
//  AFRequestApi.m
//  AppFrame
//
//  Created by HQ on 2016/12/20.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFRequestApi.h"
#import "AFNetworkConfigObject.h"

@implementation AFRequestApi

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (void)startSuccessCall:(AFRequestObjectSuccessBlock)success failureCall:(AFRequestObjectErrorBlock)failure{
    [super startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        id JSON = request.responseJSONObject;
        id model = [[self responseModelClass] yy_modelWithJSON:JSON];
        success(JSON,model);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        failure(request.error,request.error.userInfo);
        LOG(@"接口 - %@,  ❌  userInfo -- %@",self,request.error.userInfo);
    }];
}

- (Class )responseModelClass{
    return [NSNull class];
}


- (NSString *)requestUrl{
    return [[AFNetworkConfigObject shareConfig] apiForClass:[self class]];
}

- (NSString *)cdnUrl{
    return @"";
}

- (NSTimeInterval)requestTimeoutInterval{
    return 10;
}


- (nullable id)requestArgument{
    return nil;
}

- (BOOL)useCDN{
    return NO;
}

@end
