//
//  AFLastNewsModel.h
//  AppFrame
//
//  Created by HQ on 2016/12/20.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFResponseModel.h"

@interface AFLastNewsModel : AFResponseModel
@property NSString* date;
@property NSArray* stories;
@property NSArray* top_stories;
@end
