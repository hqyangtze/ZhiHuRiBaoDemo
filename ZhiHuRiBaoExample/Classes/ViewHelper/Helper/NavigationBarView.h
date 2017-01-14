//
//  NavigationBarView.h
//  AppFrame
//
//  Created by HQ on 2016/11/29.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^AFNaviButtonClickCall)(void);

@interface NavigationBarView : UIView

+ (instancetype)getView;

- (void)setLeftItemTitle:(NSString* )leftText call:(AFNaviButtonClickCall) call;
- (void)setLeftItemImg:(UIImage* )leftImg call:(AFNaviButtonClickCall) call;

- (void)setRightItemTitle:(NSString* )rightText call:(AFNaviButtonClickCall) call;
- (void)setRightItemImg:(UIImage* )rightImg call:(AFNaviButtonClickCall) call;

- (void)setCenterTitle:(NSString* )title;
- (void)setCenterImgae:(UIImage* )centerImg;
- (void)setCenterImgURLString:(NSString* )imgURLString;

@end
