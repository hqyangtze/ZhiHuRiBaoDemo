//
//  NSArray+AppFrame.m
//  AppFrame
//
//  Created by HQ on 2017/1/13.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import "NSArray+AppFrame.h"

@implementation NSArray (AppFrame)

- (id)af_safeObject:(NSInteger)index{
    if (index < 0 || index >= self.count) {
        return  nil;
    }
    return self[index];
}

@end
