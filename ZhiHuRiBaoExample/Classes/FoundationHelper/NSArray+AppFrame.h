//
//  NSArray+AppFrame.h
//  AppFrame
//
//  Created by HQ on 2017/1/13.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (AppFrame)

/// 传入索引，获取对象，index错误返回nil
- (id)af_safeObject:(NSInteger )index;

@end
