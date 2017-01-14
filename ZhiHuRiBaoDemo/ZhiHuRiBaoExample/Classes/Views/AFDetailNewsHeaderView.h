//
//  AFDetailNewsHeaderView.h
//  AppFrame
//
//  Created by HQ on 2017/1/12.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFResponseModel.h"

@interface AFDetailNewsHeaderViewModel : AFResponseModel
@property(copy, nonatomic) NSString* imgURLString;
@property(copy, nonatomic) NSString* title;
@property(copy, nonatomic) NSString* imageSource;
@end

@interface AFDetailNewsHeaderView : UIView

+ (instancetype)getViewWithSize:(CGSize )size;

- (void)updateViewWithModel:(AFDetailNewsHeaderViewModel* )model;

- (void)layoutBGViewWithOffsetY:(CGFloat )y;

@end
