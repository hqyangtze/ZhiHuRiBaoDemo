//
//  AFNetworkConfigObject.h
//  AppFrame
//
//  Created by HQ on 2016/12/20.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNetworkConfigObject : NSObject

+ (instancetype)shareConfig;

- (NSString* )apiForClass:(Class)className;

@end

