//
//  NSDictionary+AppFrame.m
//  AppFrame
//
//  Created by HQ on 2017/1/12.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import "NSDictionary+AppFrame.h"

@implementation NSDictionary (AppFrame)

/**
 *  @brief  将url参数转换成NSDictionary
 *
 *  @param query url参数
 *
 *  @return NSDictionary
 */
+ (NSDictionary *)dictionaryWithURLQuery:(NSString *)query
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *parameters = [query componentsSeparatedByString:@"&"];
    for(NSString *parameter in parameters){
        NSArray *contents = [parameter componentsSeparatedByString:@"="];
        if([contents count] == 2){
            NSString *key = [contents objectAtIndex:0];
            NSString *value = [contents objectAtIndex:1];

            value = [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            if (key && value){
                [dict setObject:value forKey:key];
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}
/**
 *  @brief  将NSDictionary转换成url 参数字符串
 *
 *  @return url 参数字符串
 */
- (NSString *)URLQueryString
{
    NSMutableString *string = [NSMutableString string];
    for (NSString *key in [self allKeys]){
        if ([string length])
        {
            [string appendString:@"&"];
        }

        NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
        NSCharacterSet * queryKVSet = [NSCharacterSet
                                       characterSetWithCharactersInString:charactersToEscape].invertedSet;
        NSString * escaped = [[self objectForKey:key] stringByAddingPercentEncodingWithAllowedCharacters:queryKVSet];

        [string appendFormat:@"%@=%@", key, escaped];

    }
    return string;
}


@end
