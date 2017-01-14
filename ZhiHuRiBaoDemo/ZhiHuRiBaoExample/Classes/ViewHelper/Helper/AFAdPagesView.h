//
//  AFAdPagesView.h
//  AppFrame
//
//  Created by HQ on 2016/12/21.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ePageControlPosition) {
    ePositionCenter = 0,
    ePositionLeft   = 1,
    ePositionRight  = 2,
};

/// model
@interface AFAdPageModel : NSObject
@property(nonatomic, copy) NSString* imgURLString;
@property(nonatomic, copy) NSString* text;
@end

/// view
@interface AFAdPagesView : UIView

@property (nonatomic, strong) NSArray<AFAdPageModel*>* modelArray;   // models
@property (nonatomic, assign) ePageControlPosition pagePosition;  //center of pageControl
@property (nonatomic, strong) UIColor* currentPageColor;  //current page point color
@property (nonatomic, strong) UIImage* placeHolder;
@property (nonatomic, assign,readonly) NSInteger currentIndex;
/// 当前正在显示的图片 null_able
@property (nonatomic, strong,readonly) UIImage* currentDisplayImg;

- (void)hidenDisplayImage:(BOOL)hiden;

/**
 *  创建一个本地图片类型的轮播画廊
 *
 *  @param frame            Frame
 *  @param need             是否需要页数视图
 *  @param didTapPicBlock   点击图片后的回调,返回下标
 *
 *  @return 轮播画廊
 */
+(instancetype)adPagesViewWithFrame:(CGRect)frame needPageControl:(BOOL)need didTapPicBlock:(void (^)(NSInteger index))didTapPicBlock;

/**
 *  开始自动轮播
 *  一般在viewWillApper中调用
 *
 *  @param eachTime 每次切换的时间(秒)
 */
-(void)startAutoWithDuration:(NSTimeInterval)eachTime;

/**
 *  停止自动轮播
 *  对应在viewWillDisAppear中停止
 */
-(void)stopAutoScrollAnimation;

@end




