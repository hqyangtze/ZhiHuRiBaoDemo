//
//  AFShortNewsTableViewCell.h
//  AppFrame
//
//  Created by HQ on 2016/12/23.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AFNewsModel;

@interface AFShortNewsTableViewCell : UITableViewCell

- (void)updateCellWithModel:(AFNewsModel*) model;

@end
