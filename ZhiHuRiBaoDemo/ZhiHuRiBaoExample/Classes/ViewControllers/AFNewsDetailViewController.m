//
//  AFNewsDetailViewController.m
//  AppFrame
//
//  Created by HQ on 2017/1/12.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import "AFNewsDetailViewController.h"
#import "AFNewsDetailView.h"
#import "AFNewsModel.h"
#import "AFNewsImageView.h"

@interface AFNewsDetailViewController (){

    AFNewsDetailView*   _currentView;

    AFNewsDetailView*   _nextView;
    AFNewsDetailView*   _beforeView;
    UIStatusBarStyle        _barStyle;
}
@property (nonatomic, strong) NSArray* innerModels;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation AFNewsDetailViewController

- (void)setDataArray:(NSArray *)newsModels currentIndex:(NSInteger)index{
    self.innerModels = newsModels;
    self.currentIndex = index;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _barStyle = UIStatusBarStyleLightContent;
    [self setUpViews];
    [self setupToolBarView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController setToolbarHidden:NO animated:NO];
}

- (void)setUpViews{
    CGSize viewSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - TOOLBAR_HEIGHT);
    WEAK(self)
    _currentView = [AFNewsDetailView getViewWithSize:viewSize newsID:self.newsID needLoadInfo:NO updateStatusStyle:^(BOOL isLight) {
        STRONG(weak_self)
        [strong_weak_self updateStatusViewStytleWithLight:isLight];
    }];

    [_currentView loadNewDataFromNetwork:^{
        STRONG(weak_self)
        [strong_weak_self loadBeforArticle];
    }];
    [_currentView loadMoreDataFromNetwork:^{
        STRONG(weak_self)
        [strong_weak_self loadNextArticle];
    }];
    [_currentView didClickImageCall:^(NSString *URLString) {
        STRONG(weak_self)
        [strong_weak_self showImageWithURLString:[URLString copy]];
    }];
    [self setLoadTipInfo];
    [self.view addSubview:_currentView];

    if (_innerModels) {
        AFNewsModel* beforeModel = [self.innerModels af_safeObject:self.currentIndex - 1];
        if (beforeModel) {
            _beforeView = [AFNewsDetailView getViewWithSize:viewSize newsID:beforeModel.newsID needLoadInfo:NO updateStatusStyle:^(BOOL isLight) {
                STRONG(weak_self)
                [strong_weak_self updateStatusViewStytleWithLight:isLight];
            }];

            [_beforeView loadNewDataFromNetwork:^{
                STRONG(weak_self)
                [strong_weak_self loadBeforArticle];
            }];
            [_beforeView loadMoreDataFromNetwork:^{
                STRONG(weak_self)
                [strong_weak_self loadNextArticle];
            }];
            [_beforeView didClickImageCall:^(NSString *URLString) {
                STRONG(weak_self)
                [strong_weak_self showImageWithURLString:[URLString copy]];
            }];
            [self.view addSubview:_beforeView];
        }

        AFNewsModel* nestModel = [self.innerModels af_safeObject:self.currentIndex + 1];
        if (nestModel) {
            _nextView = [AFNewsDetailView getViewWithSize:viewSize newsID:nestModel.newsID needLoadInfo:NO updateStatusStyle:^(BOOL isLight) {
                STRONG(weak_self)
                [strong_weak_self updateStatusViewStytleWithLight:isLight];
            }];
            [_nextView loadNewDataFromNetwork:^{
                STRONG(weak_self)
                [strong_weak_self loadBeforArticle];
            }];
            [_nextView loadMoreDataFromNetwork:^{
                STRONG(weak_self)
                [strong_weak_self loadNextArticle];
            }];
            [_nextView didClickImageCall:^(NSString *URLString) {
                STRONG(weak_self)
                [strong_weak_self showImageWithURLString:[URLString copy]];
            }];
            [self.view addSubview:_nextView];
        }
    }
    [self.view bringSubviewToFront:_currentView];
    [self setViewUserInterfaceEnable];
}

- (void)setupToolBarView{
    self.navigationController.view.backgroundColor = THEME_COLOR;

     UIBarButtonItem *flexibleitem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];

    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:k_zhifuribao_news_detail_back_image] af_scaleToSize:CGSizeMake(30, 30)] style:UIBarButtonItemStylePlain target:self action:@selector(backBeforeView)];
    UIBarButtonItem* nextItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:k_zhifuribao_news_detail_next_article_image] af_scaleToSize:CGSizeMake(30, 30)] style:UIBarButtonItemStylePlain target:self action:@selector(loadNextArticle)];
    UIBarButtonItem* beforeItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:k_zhifuribao_news_detail_scroll_top_image] af_scaleToSize:CGSizeMake(30, 30)] style:UIBarButtonItemStylePlain target:self action:@selector(loadBeforArticle)];

    [self setToolbarItems:@[backItem,flexibleitem,nextItem,flexibleitem,beforeItem] animated:YES];
}


- (void)updateStatusViewStytleWithLight:(BOOL )isLight{
    _barStyle = isLight ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return  _barStyle;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    return UIStatusBarAnimationFade;
}

- (void)loadBeforArticle{
    if (_currentIndex == 0) { /// 第一个model,没有上一篇
    }else{
        _currentIndex--;
         UIViewAnimationOptions ani = UIViewAnimationOptionCurveEaseInOut |UIViewAnimationOptionTransitionCurlDown;
        [UIView transitionFromView:_currentView toView:_beforeView duration:0.5 options:ani completion:^(BOOL finished) {

            [self.view bringSubviewToFront:_beforeView];

            AFNewsDetailView* temView = _nextView;
            _nextView = _currentView;
            _currentView = _beforeView;
            _beforeView = temView;
            [self setViewUserInterfaceEnable];
            AFNewsModel* beforeModel = [self.innerModels af_safeObject:self.currentIndex - 1];
            if (beforeModel) {
                [_beforeView resetNewsID:beforeModel.newsID];
            }
            AFNewsModel* nextModel = [self.innerModels af_safeObject:self.currentIndex + 1];
            if (nextModel) {
                [_nextView resetNewsID:nextModel.newsID];
            }
            [self setLoadTipInfo];
        }];
    }
}

- (void)loadNextArticle{
    if (_currentIndex == self.innerModels.count - 1) { /// 最后一个model,没有下一篇
    }else{
        _currentIndex++;
        UIViewAnimationOptions ani = UIViewAnimationOptionCurveEaseInOut |UIViewAnimationOptionTransitionCurlUp;
        [UIView transitionFromView:_currentView toView:_nextView duration:0.5 options:ani completion:^(BOOL finished) {

            [self.view bringSubviewToFront:_nextView];

            AFNewsDetailView* temView = _beforeView;
            _beforeView = _currentView;
            _currentView = _nextView;
            _nextView = temView;
            [self setViewUserInterfaceEnable];
            AFNewsModel* beforeModel = [self.innerModels af_safeObject:self.currentIndex - 1];
            if (beforeModel) {
                [_beforeView resetNewsID:beforeModel.newsID];
            }
            AFNewsModel* nextModel = [self.innerModels af_safeObject:self.currentIndex + 1];
            if (nextModel) {
                [_nextView resetNewsID:nextModel.newsID];
            }
            [self setLoadTipInfo];
        }];
    }
}

- (void)setLoadTipInfo{
    NSString* header = @"阅读上一篇文章";
    NSString* footer = @"阅读下一篇文章";
    if (self.currentIndex <= 0) {
        header = @"这是第一篇";
    }
    if (self.currentIndex >= self.innerModels.count - 1) {
        footer = @"这是最后一篇";
    }
    [_currentView setLoadComponentInfoHeader:header footer:footer];
}

- (void)setViewUserInterfaceEnable{
    _currentView.userInteractionEnabled = YES;
    _nextView.userInteractionEnabled = NO;
    _beforeView.userInteractionEnabled = NO;
}

- (void)showImageWithURLString:(NSString* )urlString{
    [AFNewsImageView showWithImageURLString:urlString.af_toSafeString];
}

- (void)backBeforeView{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
