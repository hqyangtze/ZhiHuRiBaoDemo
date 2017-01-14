//
//  AFWebImageView.m
//  AppFrame
//
//  Created by HQ on 2016/11/29.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFWebImageView.h"
#import "SDWebImageOperation.h"
#import "SDWebImageCompat.h"

#define kCTImageViewAnimateTime  (0.5)

@interface AFWebImageView(){
    id<SDWebImageOperation> _operation;
}

@property(nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end
@implementation AFWebImageView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.needShowActivityIndicatorView = YES;
        [self initLoadingView];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];

    self.needShowActivityIndicatorView = YES;
    [self initLoadingView];
}

- (void)setNeedShowActivityIndicatorView:(BOOL)needShowActivityIndicatorView{
    _needShowActivityIndicatorView = needShowActivityIndicatorView;
    _indicatorView.hidden = !needShowActivityIndicatorView;
}

- (void)initLoadingView{
    if (self.indicatorView) return;
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.indicatorView.hidesWhenStopped = YES;
    CGRect rec = self.indicatorView.frame;
    rec.origin.x = (self.frame.size.width-rec.size.width)/2;
    rec.origin.y = (self.frame.size.height-rec.size.height)/2;
    self.indicatorView.frame = rec;
    [self addSubview:self.indicatorView];
}

- (void)setImageWithURL:(NSURL *)url {
    [self setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil];
}

- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock {
    [self setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:completedBlock];
}
- (void)setImageWithURL:(NSURL *)url progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock{
    [self setImageWithURL:url placeholderImage:nil options:0 progress:progressBlock completed:completedBlock];
}

- (void)setImageWithURLString:(NSString *)urlStr placeholderImage:(UIImage *)placeholder;{
    [self setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeholder];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self setImageWithURL:url placeholderImage:placeholder options:SDWebImageDelayPlaceholder progress:nil completed:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock {
    if(self.needShowActivityIndicatorView){
        [_indicatorView startAnimating];
    }
    [self cancelImageLoad];
    if (!(options & SDWebImageDelayPlaceholder)) {
        dispatch_main_async_safe(^{
            self.image = placeholder;
        });
    }
    __weak AFWebImageView *wself = self;
    if (url) {
        _operation = [SDWebImageManager.sharedManager downloadImageWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe(^{
                if (!wself) return;
                if (wself.needShowActivityIndicatorView) {
                    [wself.indicatorView stopAnimating];
                }
                wself.image = image?image:placeholder;
                [wself setNeedsLayout];
                if (wself.hasAnimation) {
                    [self showloadImageAnimation];
                }
                if (completedBlock && finished) {
                    completedBlock(image, error, cacheType, url);
                }
            });
        }];
    } else {
        dispatch_main_async_safe(^{
            if (!wself) return;
            wself.image = placeholder;
            if (wself.needShowActivityIndicatorView) {
                [wself.indicatorView stopAnimating];
            }
            NSError *error = [NSError errorWithDomain:@"CTWebImageErrorDomain" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
            if (completedBlock) {
                completedBlock(nil, error, SDImageCacheTypeNone, url);
            }
        });
    }
}

- (void)showloadImageAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animation setFromValue:[NSNumber numberWithFloat:0.0]];
    [animation setToValue:[NSNumber numberWithFloat:1.0]];
    [animation setDuration:kCTImageViewAnimateTime];
    [self.layer addAnimation:animation forKey:@"fade_in"];
}

- (void)cancelImageLoad {
    if (_operation) {
        [_operation cancel];
    }
}

@end
