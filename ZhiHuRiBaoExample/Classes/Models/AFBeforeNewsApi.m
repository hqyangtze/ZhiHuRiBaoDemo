//
//  AFBeforeNewsApi.m
//  AppFrame
//
//  Created by HQ on 2016/12/26.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFBeforeNewsApi.h"
#import "AFBeforeNewsModel.h"
#import "AFNetworkConfigObject.h"

@interface AFBeforeNewsApi()
@property (nonatomic, copy) NSString* date;
@end

@implementation AFBeforeNewsApi

+ (instancetype)getModelWithDate:(NSString *)date{
    AFBeforeNewsApi* model = [AFBeforeNewsApi new];
    model.date = date;
    return model;
}

- (Class)responseModelClass{
    return [AFBeforeNewsModel class];
}

- (NSString *)requestUrl{
    NSString* base = [[AFNetworkConfigObject shareConfig] apiForClass:[self class]];;
    return [NSString stringWithFormat:@"%@/%@",base,self.date];
}

@end
