//
//  AFLastNewsModel.m
//  AppFrame
//
//  Created by HQ on 2016/12/20.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFLastNewsModel.h"
#import "AFNewsModel.h"
#import "AFTopNewsModel.h"

@implementation AFLastNewsModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"stories":[AFNewsModel class],
             @"top_stories":[AFTopNewsModel class]};
}

@end
