//
//  RootNavigationController.m
//  AppFrame
//
//  Created by HQ on 2016/11/28.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "RootNavigationController.h"
#import "AFScreenBlurryView.h"

@interface RootNavigationController(){
    AFScreenBlurryView* _blurView;
    UIViewController* _topVc;
}

@property(nonatomic, strong) UINavigationController* sharedNavigationController;

@end

@implementation RootNavigationController

+(UINavigationController*)getRootNavigationController{
    return  [[RootNavigationController defaultManager] sharedNavigationController];
}

+(void)setRootNavigationController:(UINavigationController*)navigationController{
    [[RootNavigationController defaultManager] setSharedNavigationController:navigationController];
}

+(instancetype)defaultManager{
    static RootNavigationController * _RootNavigationController_sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _RootNavigationController_sharedInstance = [[RootNavigationController alloc] init];
    });
    return _RootNavigationController_sharedInstance;
}

-(instancetype)init{
    self = [super init];

    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignActive) name:UIApplicationDidEnterBackgroundNotification object:nil];
#ifdef DEBUG
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(copyAction) name:UIPasteboardChangedNotification object:nil];
#endif
    }
    return self;
}

-(void)becomeActive{
    if (_blurView) {
        [UIView animateWithDuration:0.4 animations:^{
            _blurView.alpha = 0.0f;
            _blurView.transform = CGAffineTransformMakeScale(1.05, 1.05);

        } completion:^(BOOL finished) {
            [_blurView removeFromSuperview];
            _blurView.alpha = 1.0f;
            _blurView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }
}

-(void)resignActive{
    if (_sharedNavigationController) {
        if (_blurView == nil) {
            _blurView= [[AFScreenBlurryView alloc]init];
        }else{
            [_blurView updateImage];
        }

        [[UIApplication sharedApplication].keyWindow addSubview:_blurView];
    }
}

#ifdef DEBUG
-(void)copyAction{
    NSString* copyString = [UIPasteboard generalPasteboard].string;
    NSLog(@"\n\n copy action(拷贝数据）\n\n %@ \n\n", copyString);
}
#endif

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
