//
//  AFNetworkConfigObject.m
//  AppFrame
//
//  Created by HQ on 2016/12/20.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFNetworkConfigObject.h"
#import "AFNetworkApiName.h"
#import "YTKNetworkConfig.h"

@interface AFNetworkConfigObject()
@property(nonatomic, strong) YTKNetworkConfig* config;
@property(nonatomic, copy) NSDictionary* apiDict;
@end

@implementation AFNetworkConfigObject{
}

static AFNetworkConfigObject* __instance;

+ (instancetype)shareConfig{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[self alloc] init];
    });
    return __instance;
}

- (instancetype)init{
    if (self = [super init]) {
        YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
        config.baseUrl = kNetworkScheme;
        self.config = config;
    }
    return self;
}

- (NSString* )apiForClass:(Class)className{
    return self.apiDict[NSStringFromClass(className)];
}

- (NSDictionary *)apiDict{
    if (_apiDict == nil) {
        _apiDict = @{
                     kAFLastNewsApi: @"/api/4/news/latest",
                     kAFBeforeNewsApi: @"/api/4/news/before",
                     kAFNewsDetailApi:  @"/api/4/news",
                     kAFStartImageApi: @"api/4/start-image",
                     };

    }
    return _apiDict;
}

@end

