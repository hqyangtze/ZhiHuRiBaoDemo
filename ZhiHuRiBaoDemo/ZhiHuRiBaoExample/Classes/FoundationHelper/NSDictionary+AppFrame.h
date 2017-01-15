//
//  NSDictionary+AppFrame.h
//  AppFrame
//
//  Created by HQ on 2017/1/12.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (AppFrame)

/**
 *  @brief  将url参数转换成NSDictionary
 *
 *  @param query url参数
 *
 *  @return NSDictionary
 */
+ (NSDictionary *)af_dictionaryWithURLQuery:(NSString *)query;

/**
 *  @brief  将NSDictionary转换成url 参数字符串
 *
 *  @return url 参数字符串
 */
- (NSString *)af_URLQueryString;

@end
