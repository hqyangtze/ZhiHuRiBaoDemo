//
//  AFNewsDetailModel.m
//  AppFrame
//
//  Created by HQ on 2016/12/31.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFNewsDetailModel.h"

@implementation AFNewsDetailSectionModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"sectionID":@[@"id",@"ID"]};
}

@end

@implementation AFNewsDetailModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"recommenders":[NSDictionary class]
             };
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"newsID":@[@"id",@"ID"]};
}

@end
