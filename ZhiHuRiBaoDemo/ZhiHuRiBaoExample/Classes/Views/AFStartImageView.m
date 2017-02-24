//
//  AFStartImageView.m
//  ZhiHuRiBaoExample
//
//  Created by HQ on 2017/1/14.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import "AFStartImageView.h"
#import "AFStartImageModel.h"
#import "AFStartImageApi.h"

@interface AFStartImageView()
@property (weak, nonatomic) IBOutlet AFWebImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *textLab;
@end

@implementation AFStartImageView

+ (void)showStartImage{
    AFStartImageView* view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    view.frame = [UIScreen mainScreen].bounds;
    [[[UIApplication sharedApplication].windows lastObject] addSubview:view];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUI];
}

- (void)setUI{
    NSInteger rand = arc4random_uniform(11) % 11;
    UIImage* placeHolderImage = [UIImage imageNamed:[NSString stringWithFormat:@"Launch_image_%zd",rand]];
    [self.bgImageView setImage:placeHolderImage];
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString* imageScale = [NSString stringWithFormat:@"%zd*%zd",(NSUInteger)viewSize.width,(NSUInteger)viewSize.height];
    AFStartImageApi* startImageApi = [AFStartImageApi getModelWithImgScale:imageScale];
    [startImageApi startSuccessCall:^(id  _Nonnull responseJOSN, id  _Nonnull responseModel) {
        AFStartImageModel* model = responseModel;
        [self.bgImageView setImageWithURLString:model.img.af_string placeholderImage:placeHolderImage];
        [self.textLab setText:model.text];
        [self amimationAndDisappear];
    } failureCall:^(NSError * _Nonnull error, NSDictionary * _Nonnull userInfo) {
        [self removeFromSuperview];
    }];
}

- (void)amimationAndDisappear{
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:20.0 options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionAutoreverse animations:^{
        self.bgImageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.bgImageView.alpha = 0.8;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
