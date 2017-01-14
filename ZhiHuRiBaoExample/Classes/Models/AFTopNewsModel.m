//
//  AFTopNewsModel.m
//  AppFrame
//
//  Created by HQ on 2016/12/20.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFTopNewsModel.h"

@implementation AFTopNewsModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"newsID":@[@"id",@"ID"]};
}

@end
