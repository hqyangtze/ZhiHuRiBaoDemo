//
//  AFAdPagesView.m
//  AppFrame
//
//  Created by HQ on 2016/12 * 0.51.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFAdPagesView.h"
#import "AFWebImageView.h"
#import "NSTimer+HQExtend.h"
#define SELF_VIEW_WIDTH  (self.hq_width)
#define SELF_VIEW_HEIGHT (self.hq_height)

////
@interface AFAdPageView : UIView{
  @public
    AFWebImageView*     _imgView;
    UILabel*            _textLab;
}

+ (instancetype) getViewWithSize:(CGSize)size;
- (void)updateView:(AFAdPageModel* )model;

@end

@implementation AFAdPageView

- (instancetype)init{
    if (self = [super init]) {
        _imgView = [[AFWebImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.backgroundColor = [UIColor colorWithWhite:.94 alpha:1];
        [self addSubview:_imgView];

        _textLab = [UILabel new];
        _textLab.numberOfLines = 3;
        [_textLab setTextColor:WHITE_COLOR];
        _textLab.font = UIFontBoldMake(18);
        [self addSubview:_textLab];
    }
    return self;
}

+ (instancetype)getViewWithSize:(CGSize)size{
    AFAdPageView*view = [[AFAdPageView alloc] init];
    view.hq_size = size;
    return view;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self);
        make.top.equalTo(0.0);
        make.left.equalTo(0.0);
    }];
    [_textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-22.0);
    }];
}

- (void)updateView:(AFAdPageModel *)model{
    [_imgView setImageWithURLString:model.imgURLString placeholderImage:[UIImage af_placeholderImage]];
    _textLab.text = model.text;
    [_textLab sizeToFit];
}

@end

////
@interface AFAdPagesView()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView* scrollView;
@property(nonatomic,assign,readwrite)NSInteger currentIndex;
@property (nonatomic,strong,readwrite) UIImage* currentDisplayImg;
@property(nonatomic,strong)UIView* currentView;
@property(nonatomic,strong)UIView* nextView;
@property(nonatomic,strong)UIView* awardView;

@property(nonatomic,strong)AFAdPageView* currentIV;
@property(nonatomic,strong)AFAdPageView* nextIV;
@property(nonatomic,strong)AFAdPageView* awardIV;

@property(nonatomic,strong)UITapGestureRecognizer* tapGR;

@property(nonatomic,strong)UIPageControl* pageControl;

@property(nonatomic,strong)NSTimer* scrollTimer;

@property(nonatomic,assign)NSTimeInterval eachTime;

@property(nonatomic,copy)void(^didTapPicBlock)(NSInteger index);    //点击图片后的回调block,返回下标
@end

@implementation AFAdPagesView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)initialize{
    [self initScrollView];
    [self initTapGR];
    [self initPageControlCenter];
}

+(instancetype)adPagesViewWithFrame:(CGRect)frame needPageControl:(BOOL)need didTapPicBlock:(void (^)(NSInteger index))didTapPicBlock;{
    AFAdPagesView* scrollPicView = [[AFAdPagesView alloc]initWithFrame:frame];
    if (didTapPicBlock) {
        scrollPicView.didTapPicBlock = didTapPicBlock;
    }

    if (need) {
        scrollPicView.currentPageColor = [UIColor whiteColor];
    }

    return scrollPicView;
}

-(void)setModelArray:(NSArray *)modelArray{
    _modelArray = modelArray;

    self.currentIndex = 0;
    [self.currentIV updateView:modelArray[0]];

    if (modelArray.count <= 1) {
        [self.nextIV updateView:modelArray[0]];
    }else{
        [self.nextIV updateView:modelArray[1]];
    }
    [self.awardIV updateView:[modelArray lastObject]];

    if (self.pageControl) {
        self.pageControl.numberOfPages = modelArray.count;
    }
    [self startAutoWithDuration:self.eachTime];
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    self.pageControl.currentPage = currentIndex;
}

-(void)initScrollView{
    if (self.scrollView) {
        [self.scrollView removeFromSuperview];
    }

    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SELF_VIEW_WIDTH, SELF_VIEW_HEIGHT)];
    self.scrollView.contentSize = CGSizeMake(SELF_VIEW_WIDTH*3, 0);

    [self addSubview:self.scrollView];
    self.scrollView.delegate = self;

    self.currentView = [[UIView alloc]initWithFrame:CGRectMake(SELF_VIEW_WIDTH, 0, SELF_VIEW_WIDTH, SELF_VIEW_HEIGHT)];
    self.currentView.clipsToBounds = YES;
    CGSize itemSize = CGSizeMake(SELF_VIEW_WIDTH, SELF_VIEW_HEIGHT);
    self.currentIV = [AFAdPageView getViewWithSize:itemSize];
    [self.currentView addSubview:self.currentIV];
    [self.scrollView addSubview:self.currentView];

    self.nextView = [[UIView alloc]initWithFrame:CGRectMake(SELF_VIEW_WIDTH*2, 0, SELF_VIEW_WIDTH, SELF_VIEW_HEIGHT)];
    self.nextView.clipsToBounds = YES;

    self.nextIV = [AFAdPageView getViewWithSize:itemSize];
    self.nextIV.center = CGPointMake(self.nextView.hq_width * 0.5, self.nextView.hq_height * 0.5);
    [self.nextView addSubview:self.nextIV];
    [self.scrollView addSubview:self.nextView];

    self.awardView = [[UIView alloc]initWithFrame:CGRectMake(SELF_VIEW_WIDTH, 0, 0, SELF_VIEW_HEIGHT)];
    self.awardView.clipsToBounds = YES;

    self.awardIV = [AFAdPageView getViewWithSize:itemSize];
    self.awardIV.center = CGPointMake(self.awardView.hq_width * 0.5, self.awardView.hq_height * 0.5);

    [self.awardView addSubview:self.awardIV];
    [self.scrollView addSubview:self.awardView];

    self.scrollView.contentOffset = CGPointMake(SELF_VIEW_WIDTH, 0);
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
}


-(void)addNewAward{
    [self.currentIV removeFromSuperview];
    [self.nextIV removeFromSuperview];
    [self.awardIV removeFromSuperview];


    AFAdPageView* temView = self.nextIV;
    self.nextIV = self.currentIV;
    self.nextIV.center = CGPointMake(self.nextView.hq_width * 0.5, self.nextView.hq_height * 0.5);
    [self.nextView addSubview:self.nextIV];

    self.currentIV = self.awardIV;
    self.currentIV.center = CGPointMake(self.currentView.hq_width * 0.5, self.currentView.hq_height * 0.5);
    [self.currentView addSubview:self.currentIV];

    self.awardIV = temView;
    if (self.modelArray) {
        if (self.currentIndex == 0) {
            [self.awardIV updateView:[self.modelArray lastObject]];
        }else{
            [self.awardIV updateView:self.modelArray[self.currentIndex-1]];
        }
    }

    self.awardIV.center = CGPointMake(self.awardView.hq_width * 0.5, self.awardView.hq_height * 0.5);

    [self.awardView addSubview:self.awardIV];
    self.scrollView.contentOffset = CGPointMake(SELF_VIEW_WIDTH, 0);
}

-(void)addNewNext{
    [self.currentIV removeFromSuperview];
    [self.nextIV removeFromSuperview];
    [self.awardIV removeFromSuperview];

    AFAdPageView* temView = self.awardIV;
    self.awardIV = self.currentIV;
    self.awardIV.center = CGPointMake(self.awardView.hq_width * 0.5, self.awardView.hq_height * 0.5);
    [self.awardView addSubview:self.awardIV];

    self.currentIV = self.nextIV;
    self.currentIV.center = CGPointMake(self.currentView.hq_width * 0.5, self.currentView.hq_height * 0.5);
    [self.currentView addSubview:self.currentIV];
    self.nextIV = temView;
    if (self.modelArray) {
        if (self.currentIndex == self.modelArray.count-1) {
            [self.nextIV updateView:self.modelArray.firstObject];
        }else{
            [self.nextIV updateView:self.modelArray[self.currentIndex+1]];
        }
    }

    self.nextIV.center = CGPointMake(self.nextView.hq_width * 0.5, self.nextView.hq_height * 0.5);
    [self.nextView addSubview:self.nextIV];

    self.scrollView.contentOffset = CGPointMake(SELF_VIEW_WIDTH, 0);
}

#pragma mark  ---scrollViewDelegate------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.scrollView) {
        CGFloat offSetX = scrollView.contentOffset.x - SELF_VIEW_WIDTH;
        //向前滑动
        if (offSetX<0) {
            offSetX = ABS(offSetX);
            CGRect frame = self.awardView.frame;
            frame.size.width = offSetX;
            frame.origin.x = SELF_VIEW_WIDTH - offSetX;
            self.awardView.frame = frame;
            self.awardIV.center = CGPointMake(self.awardView.hq_width * 0.5, self.awardView.hq_height * 0.5);

            frame = self.currentView.frame;
            frame.size.width =  SELF_VIEW_WIDTH - offSetX;
            self.currentView.frame = frame;
            self.currentIV.center = CGPointMake(self.currentView.hq_width * 0.5, self.currentView.hq_height * 0.5);

        }else{
            //向后滑动
            CGRect frame = self.nextView.frame;
            frame.size.width = offSetX;
            self.nextView.frame = frame;
            self.nextIV.center = CGPointMake(self.nextView.hq_width * 0.5, self.nextView.hq_height * 0.5);

            frame = self.currentView.frame;
            frame.size.width =  SELF_VIEW_WIDTH - offSetX;
            frame.origin.x = SELF_VIEW_WIDTH+ offSetX;
            self.currentView.frame = frame;
            self.currentIV.center = CGPointMake(self.currentView.hq_width * 0.5, self.currentView.hq_height * 0.5);
        }
    }
}

-(void)scrollViewWillBeginDecelerating: (UIScrollView *)scrollView{
    [scrollView setContentOffset:scrollView.contentOffset animated:NO];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (scrollView.contentOffset.x < SELF_VIEW_WIDTH && targetContentOffset->x <= SELF_VIEW_WIDTH * 0.5) {
        [self scrollViewMoveToAward];
    }else if (scrollView.contentOffset.x > SELF_VIEW_WIDTH && targetContentOffset->x >= SELF_VIEW_WIDTH*3 * 0.5){
        [self scrollViewMoveToNext];
    }else{
        [self scrollViewMoveToMiddle];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopAutoScrollAnimation];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startAutoWithDuration:self.eachTime];
}


-(void)scrollViewMoveToAward{
    [self hidenDisplayImage:NO];
    self.currentIndex --;
    if (self.currentIndex < 0) {
        if (self.modelArray) {
            self.currentIndex = self.modelArray.count-1;
        }
    }

    self.pageControl.currentPage = self.currentIndex;
    [UIView animateWithDuration:.2 animations:^{
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }completion:^(BOOL finished) {
        [self addNewAward];
    } ];
}

-(void)scrollViewMoveToNext{
    [self hidenDisplayImage:NO];
    self.currentIndex ++;
    if (self.currentIndex >= self.modelArray.count) {
        if (self.modelArray) {
            self.currentIndex = 0;
        }
    }
    self.pageControl.currentPage = self.currentIndex;
    [UIView animateWithDuration:.2 animations:^{
        self.scrollView.contentOffset = CGPointMake(SELF_VIEW_WIDTH*2, 0);
    }completion:^(BOOL finished) {
        [self addNewNext];
    }];
}

-(void)scrollViewMoveToMiddle{
    [self hidenDisplayImage:NO];
    [UIView animateWithDuration:.2 animations:^{
        self.scrollView.contentOffset = CGPointMake(SELF_VIEW_WIDTH, 0);
    }];
}


#pragma mark  -----点击事件--------
-(void)initTapGR{
    self.tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGRDidTap:)];
    self.tapGR.numberOfTapsRequired = 1;
    self.tapGR.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:self.tapGR];
}

-(void)tapGRDidTap:(UITapGestureRecognizer*)tapGR{
    if (self.didTapPicBlock) {
        self.didTapPicBlock(self.currentIndex);
    }
}

#pragma mark  -----pagecontrol------
- (void)initPageControlCenter{
    //设置pageControl
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.hq_height-25, 100, 20)];
    self.pageControl.center = CGPointMake(self.hq_width * 0.5, self.pageControl.center.y);
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.alpha = 0.0;
    [self addSubview:self.pageControl];

}

- (void)setPagePosition:(ePageControlPosition)pagePosition{
     _pageControl.alpha = 1.0;
    CGPoint position;
    switch (pagePosition) {
        case ePositionLeft:
            position = CGPointMake(self.pageControl.hq_width * 0.5 + 5, self.pageControl.center.y);
            break;
        case ePositionCenter:
            position = CGPointMake(SELF_VIEW_WIDTH * 0.5, self.pageControl.center.y);
            break;
        case ePositionRight:
            position = CGPointMake((SELF_VIEW_WIDTH - self.pageControl.hq_width) + self.pageControl.hq_width * 0.5 - 5.0, self.pageControl.center.y);
            break;

    }
    _pageControl.hq_center = position;
}

- (void)setCurrentPageColor:(UIColor *)currentPageColor{
    _currentPageColor = currentPageColor;
    _pageControl.alpha = 1.0;
    _pageControl.currentPageIndicatorTintColor = currentPageColor;
}

-(void)startAutoWithDuration:(NSTimeInterval)eachTime{
    [self stopAutoScrollAnimation];
    self.scrollTimer = [NSTimer af_scheduledTimerWithTimeInterval:eachTime block:^(NSTimer * _Nonnull timer) {
        [self scrollViewMoveToNext];
    } repeats:YES];
    self.eachTime = eachTime;
}

-(void)stopAutoScrollAnimation{
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;
}

- (UIImage *)currentDisplayImg{
    return self.currentIV->_imgView.image;
}

- (void)hidenDisplayImage:(BOOL)hiden{
    [UIView animateWithDuration:.2 animations:^{
        self.currentIV->_imgView.hidden = hiden;
        self.nextIV->_imgView.hidden = hiden;
        self.awardIV->_imgView.hidden = hiden;
    } completion:^(BOOL finished) {
    }];
}

- (void)dealloc{
    [self.tapGR removeTarget:self action:@selector(tapGRDidTap:)];
    [self.scrollView removeGestureRecognizer:self.tapGR];
    [self stopAutoScrollAnimation];
}

@end


@implementation AFAdPageModel

@end
