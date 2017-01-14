//
//  AFNewsDetailModel.h
//  AppFrame
//
//  Created by HQ on 2016/12/31.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFResponseModel.h"

@interface AFNewsDetailSectionModel : AFResponseModel
@property NSString* thumbnail;
@property NSString* sectionID;
@property NSString* name;
@end


@interface AFNewsDetailModel : AFResponseModel
@property NSString* body;
@property NSString* image_source;
@property NSString* title;
@property NSString* image;
@property NSString* share_url;
@property NSArray*  js;
@property NSString* recommenders;
@property NSString* ga_prefix;
@property AFNewsDetailSectionModel* section;
@property NSString* type;
@property NSString* newsID;
@property NSArray*  css;
@end
