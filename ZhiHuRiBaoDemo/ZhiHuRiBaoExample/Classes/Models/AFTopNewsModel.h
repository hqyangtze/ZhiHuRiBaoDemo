//
//  AFTopNewsModel.h
//  AppFrame
//
//  Created by HQ on 2016/12/20.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFResponseModel.h"

@interface AFTopNewsModel : AFResponseModel
@property NSString* ga_prefix;
@property NSString* newsID;
@property NSString* title;
@property NSString* type;
@property NSString* image;
@property NSString* multipic;
@end
