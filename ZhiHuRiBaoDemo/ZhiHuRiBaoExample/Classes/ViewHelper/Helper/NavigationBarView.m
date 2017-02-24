//
//  NavigationBarView.m
//  AppFrame
//
//  Created by HQ on 2016/11/29.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "NavigationBarView.h"
#import "AFWebImageView.h"
#import "UIView+HQExtend.h"

@interface NavigationBarView()
@property (weak, nonatomic) IBOutlet UIButton *leftBtnItem;
@property (weak, nonatomic) IBOutlet UILabel *centerTitleLab;
@property (weak, nonatomic) IBOutlet UIButton *rightBtnItem;
@property (weak, nonatomic) IBOutlet AFWebImageView *centerImgView;

/// action
- (IBAction)af_leftTopClickEvent;
- (IBAction)af_rightTopClickEvent;

@property (copy, nonatomic) AFNaviButtonClickCall leftCall;
@property (copy, nonatomic) AFNaviButtonClickCall rightCall;

@end

@implementation NavigationBarView

- (void)awakeFromNib{
    [super awakeFromNib];

    self.leftBtnItem.hidden = YES;
    self.rightBtnItem.hidden = YES;
    self.centerTitleLab.hidden = YES;
    self.centerImgView.hidden = YES;
    self.backgroundColor = THEME_COLOR;
    self.centerTitleLab.font = UIFontBoldMake(20);
    self.centerTitleLab.textColor = WHITE_COLOR;
}

+ (instancetype)getView{
    NavigationBarView* barView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    barView.hq_width = SCREEN_WIDTH;
    barView.hq_height = 64.0f;
    return barView;
}

- (IBAction)af_leftTopClickEvent {
    !self.leftCall ? : self.leftCall();
}

- (IBAction)af_rightTopClickEvent {
    !self.rightCall ? : self.rightCall();
}

- (void)setLeftItemTitle:(NSString* )leftText call:(AFNaviButtonClickCall) call{
    [self.leftBtnItem setTitle:leftText forState:UIControlStateNormal];
    self.leftCall = call;
    self.leftBtnItem.hidden = !!!leftText;
}
- (void)setLeftItemImg:(UIImage* )leftImg call:(AFNaviButtonClickCall) call{
    [self.leftBtnItem setImage:leftImg forState:UIControlStateNormal];
    self.leftCall = call;
    self.leftBtnItem.hidden = !!!leftImg;
}

- (void)setRightItemTitle:(NSString* )rightText call:(AFNaviButtonClickCall) call{
    [self.rightBtnItem setTitle:rightText forState:UIControlStateNormal];
    self.rightCall = call;
    self.rightBtnItem.hidden = !!!rightText;
}
- (void)setRightItemImg:(UIImage* )rightImg call:(AFNaviButtonClickCall) call{
    [self.rightBtnItem setImage:rightImg forState:UIControlStateNormal];
    self.rightCall = call;
    self.rightBtnItem.hidden = !!!rightImg;
}

- (void)setCenterTitle:(NSString* )title{
    self.centerTitleLab.text = title;
    self.centerTitleLab.hidden = !!!title;
}
- (void)setCenterImgae:(UIImage* )centerImg{
    self.centerImgView.image = centerImg;
    self.centerImgView.hidden = !!!centerImg;
}
- (void)setCenterImgURLString:(NSString* )imgURLString{
    [self.centerImgView setImageWithURL:[NSURL URLWithString:imgURLString] placeholderImage:nil];
    self.centerImgView.hidden = !!!imgURLString;
}

@end
