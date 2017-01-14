//
//  AFNewsModel.m
//  AppFrame
//
//  Created by HQ on 2016/12/20.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFNewsModel.h"
@implementation AFNewsModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"newsID":@[@"id",@"ID"]};
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"images":[NSString class]};
}

@end
