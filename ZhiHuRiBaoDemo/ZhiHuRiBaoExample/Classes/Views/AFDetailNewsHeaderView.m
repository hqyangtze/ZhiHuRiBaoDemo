//
//  AFDetailNewsHeaderView.m
//  AppFrame
//
//  Created by HQ on 2017/1/12.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import "AFDetailNewsHeaderView.h"

@implementation AFDetailNewsHeaderViewModel
@end

@interface AFDetailNewsHeaderView(){
    CAGradientLayer* _bgCoverLayer;
}
@property (weak, nonatomic) IBOutlet AFWebImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *imgCopyLab;

@property (assign, nonatomic) CGSize viewSize;
@end

@implementation AFDetailNewsHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];

    self.titleLab.font = UIFontBoldMake(18);
    self.titleLab.textColor = WHITE_COLOR;
    [self addCAGradientLayer];
}

+ (instancetype)getViewWithSize:(CGSize)size{
    AFDetailNewsHeaderView* view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    view.hq_size = size;
    view.viewSize = size;
    [view setNeedsLayout];

    return view;
}

- (void)updateViewWithModel:(AFDetailNewsHeaderViewModel *)model{
    [self.bgImgView setImageWithURLString:model.imgURLString.af_string  placeholderImage:[UIImage af_placeholderImage]];
    self.titleLab.text = model.title.af_string;
    self.imgCopyLab.text = model.imageSource.af_string;

    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _bgCoverLayer.frame = self.bgImgView.bounds;
    [self.bgImgView.layer setNeedsLayout];
    [CATransaction commit];
}

- (void)addCAGradientLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bgImgView.bounds;

    gradientLayer.colors = @[(id)RGBA(255, 255, 255, 0.25).CGColor,
                             (id)RGBA(50, 50, 50, 0.25).CGColor,
                             ];
    gradientLayer.locations = @[@(0.2f)];

    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);

    [self.bgImgView.layer insertSublayer:gradientLayer atIndex:0];
    _bgCoverLayer = gradientLayer;
}

- (void)layoutBGViewWithOffsetY:(CGFloat)y{
    [self.bgImgView setHq_y:y];
    [self.bgImgView setHq_height:self.viewSize.height + ABS(y)];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _bgCoverLayer.frame = self.bgImgView.bounds;
    [self.bgImgView.layer setNeedsLayout];
    [CATransaction commit];
}

@end
