//
//  AFBeforeNewsModel.m
//  AppFrame
//
//  Created by HQ on 2016/12/26.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFBeforeNewsModel.h"
#import "AFNewsModel.h"

@implementation AFBeforeNewsModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"stories":[AFNewsModel class],
            };
}


@end
