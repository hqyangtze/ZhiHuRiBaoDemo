//
//  NSTimer+HQExtend.m
//  AppFrame
//
//  Created by HQ on 2016/12/21.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "NSTimer+HQExtend.h"

@implementation NSTimer (HQExtend)

+ (void)_af_ExecBlock:(NSTimer *)timer {
    if ([timer userInfo]) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *timer))[timer userInfo];
        block(timer);
    }
}

+ (NSTimer *)af_scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats {
    return [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(_af_ExecBlock:) userInfo:[block copy] repeats:repeats];
}

+ (NSTimer *)af_timerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats {
    return [NSTimer timerWithTimeInterval:seconds target:self selector:@selector(_af_ExecBlock:) userInfo:[block copy] repeats:repeats];
}

@end
