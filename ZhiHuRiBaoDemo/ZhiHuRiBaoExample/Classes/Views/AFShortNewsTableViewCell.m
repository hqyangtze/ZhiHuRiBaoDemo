//
//  AFShortNewsTableViewCell.m
//  AppFrame
//
//  Created by HQ on 2016/12/23.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFShortNewsTableViewCell.h"
#import "AFNewsModel.h"

@interface AFShortNewsTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLab;
@property (weak, nonatomic) IBOutlet AFWebImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *separatorLineHeight;

@end

@implementation AFShortNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.separatorLineHeight.constant = SEPARATOR_LINE_HEIGHT;
}

- (void)updateCellWithModel:(AFNewsModel*) model{
    self.newsTitleLab.text = model.title;
    if (model.images.count) {
        NSString* imgString = [[model.images firstObject] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        LOG(@"--- image index %@",imgString);
        [self.iconImgView setImageWithURLString:imgString placeholderImage:[UIImage af_placeholderImage]];
    }
}

@end
