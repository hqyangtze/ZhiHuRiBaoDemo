//
//  AFNewsDetailView.m
//  AppFrame
//
//  Created by HQ on 2017/1/12.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import "AFNewsDetailView.h"
#import "AFNewsDetailApi.h"
#import "AFNewsDetailModel.h"
#import "AFDetailNewsHeaderView.h"
#import "BaseViewController.h"
#import "WebViewController.h"
#import "RootNavigationController.h"
/**
 .headline .img-place-holder {
 height: 200px;
 } */
#define HEADER_HEIGHT (200.0) /// 数据来源于知乎日报的接口
static const CGFloat kFootViewHeight = 44.0f;

@interface AFNewsDetailView ()<UIWebViewDelegate>{
    UIWebView* _webView;
    UIView*    _statusCoverView;
    UIView*    _footView;
    /// 头部native视图
    AFDetailNewsHeaderView*     _headerView;

    /// 新闻model
    AFNewsDetailModel*      _detailModel;
}

@property (nonatomic, copy) NSString* newsID;
@property (nonatomic, copy) void(^updateStatusCall)(BOOL isLight);
@property (nonatomic, strong) BaseViewController* infoNeedVC;
/// 加载数据回调
@property (nonatomic, copy) loadDataCall newdataCall;
@property (nonatomic, copy) loadDataCall moredataCall;

@end
@implementation AFNewsDetailView

+ (instancetype)getViewWithSize:(CGSize )size newsID:(NSString* )newsID needLoadInfo:(BOOL)need updateStatusStyle:(void(^)(BOOL isLight)) updateStatusCall{

    AFNewsDetailView* view = [[AFNewsDetailView alloc] init];
    view.hq_size = size;
    view.newsID = newsID;
    view.infoNeedVC = need ? [BaseViewController new] : nil;
    view.updateStatusCall = updateStatusCall;
    [view setUpViews];
    [view loadNewsDetailData];

    return view;
}

- (void)setUpViews{
    _webView = [[UIWebView alloc] initWithFrame:self.bounds];
    //_webView.hq_height = _webView.hq_height - kFootViewHeight;
    _webView.backgroundColor = COMMON_BG_COLOR;
    _webView.allowsInlineMediaPlayback = YES;
    [self addSubview:_webView];
    _webView.delegate = self;
    WEAK(self)
    [_webView.scrollView addRefreshHeaderWithCall:^{
        STRONG(weak_self)
        [strong_weak_self->_webView.scrollView endRefresh];
        !strong_weak_self.newdataCall ? : strong_weak_self.newdataCall();
    }];
    [_webView.scrollView addRefreshBackFooterWithCall:^{
        STRONG(weak_self)
         [strong_weak_self->_webView.scrollView endRefresh];
        !strong_weak_self.moredataCall ? : strong_weak_self.moredataCall();
    }];
    
    [_webView.scrollView af_addObserverBlockForKeyPath:@"contentOffset" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
        STRONG(weak_self)
        if (obj == strong_weak_self->_webView.scrollView) {
            CGPoint offSet = [newVal CGPointValue];
            if (offSet.y < 0.0f) {
                [strong_weak_self->_headerView layoutBGViewWithOffsetY:offSet.y];
            }else{
                CGFloat temHeight = HEADER_HEIGHT - STATUSBAR_HEIGHT;
                if ((temHeight - 0.1) <= offSet.y || offSet.y <= (temHeight + 0.1)) {
                    CGPoint oldOffset = [oldVal CGPointValue];
                    /// 比较大的值和比较小的值都忽略
                    if (oldOffset.y > HEADER_HEIGHT * 2 || oldOffset.y < 0.0f) {

                    }else{
                        [strong_weak_self updateBarStytleIsLight:!!(oldOffset.y < temHeight)];
                    }
                }
            }
        }
    }];
    _headerView = [AFDetailNewsHeaderView getViewWithSize:CGSizeMake(SCREEN_WIDTH, HEADER_HEIGHT)];
    [_webView.scrollView addSubview:_headerView];

    _statusCoverView = [UIView hq_frameWithX:0 Y:0 width:SCREEN_WIDTH height:STATUSBAR_HEIGHT];
    _statusCoverView.backgroundColor = WHITE_COLOR;
    _statusCoverView.hidden = YES;
    [self addSubview:_statusCoverView];

    _footView = [UIView hq_frameWithX:0 Y:SCREEN_HEIGHT - kFootViewHeight width:SCREEN_WIDTH height:kFootViewHeight];
    _footView.backgroundColor = WHITE_COLOR;
    //[self addSubview:_footView];
}

- (void)loadNewDataFromNetwork:(loadDataCall)newdataCall{
    self.newdataCall = newdataCall;
}

- (void)loadMoreDataFromNetwork:(loadDataCall)moredataCall{
    self.moredataCall = moredataCall;
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSURL* URL = request.URL;
    NSString* URLString = URL.absoluteString;
    LOG(@"正在加载的URLString : %@", URLString);
    /// 内嵌视频
    NSDictionary* paras = [NSDictionary af_dictionaryWithURLQuery:URLString];
    if (paras[@"auto"] || [URL.host isEqualToString:@"video.qq.com"]) {
        return YES;
    }
    if ([URLString hasPrefix:@"http://"] || [URLString hasPrefix:@"https://"]) {
        WebViewController* webVC = [WebViewController getController];
        webVC.URLString = URLString;
        webVC.shareString = _detailModel.share_url;
        [ROOT_NAVIGATION_CONTROLLER pushViewController:webVC animated:YES];
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.infoNeedVC showProgressWithMessage:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.infoNeedVC dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.infoNeedVC dismiss];
}

///  私有方法
- (void)loadNewsDetailData{
    AFNewsDetailApi* api = [AFNewsDetailApi getModelWithNewsID:self.newsID.af_toSafeString];
    [api startSuccessCall:^(id  _Nonnull responseJOSN, id  _Nonnull responseModel) {

        _detailModel = responseModel;
        LOG(@"----responseJSON %@\n, detail_model ---- %@",responseJOSN,_detailModel);

        /// 开始加载数据
        NSString* newsString = [self setUpURLStringWithModel:_detailModel];
        [_webView loadHTMLString:newsString baseURL:nil];

        /// 更新头部视图
        AFDetailNewsHeaderViewModel* headerModel = [AFDetailNewsHeaderViewModel new];
        headerModel.title = _detailModel.title;
        headerModel.imageSource = _detailModel.image_source;
        headerModel.imgURLString = _detailModel.image.af_toSafeString;
        [_headerView updateViewWithModel:headerModel];
    } failureCall:^(NSError * _Nonnull error, NSDictionary * _Nonnull userInfo) {
        [self.infoNeedVC showError:error];
    }];
}

- (NSString*)setUpURLStringWithModel:(AFNewsDetailModel* )model{
    NSString* cssString = nil;
    if (model.css.count) {
        NSString* css = [[model.css firstObject] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        cssString = css;
    }
    NSString* jsString = nil;
    if (model.css.count) {
        NSString* js = [[model.js firstObject] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        jsString = js;
    }
    NSString* temString = [NSString stringWithFormat:@"<!DOCTYPE html>\n<html>\n<head>\n<title>%@</title>\n<link rel=\"stylesheet\" href=\"%@\" type=\"text/css\"/>\n</head>\n<body>\n%@\n<script type = \n\"text/javascript\"src = \"%@\"></script>\n</body>\n</html>",model.title,cssString,model.body,jsString];
    return temString;

}

- (void)updateBarStytleIsLight:(BOOL )isLight{
    _statusCoverView.hidden = isLight;
    !self.updateStatusCall ? : self.updateStatusCall(isLight);
}

- (void)resetNewsID:(NSString *)newsID{
    self.infoNeedVC = nil; /// 在使用的时候，之后默默加载
    self.newsID = newsID;
    [self loadNewsDetailData];
}

- (void)setLoadComponentInfoHeader:(NSString *)header footer:(NSString *)footer{
    [[_webView.scrollView af_loadHeader].stateLabel setTextColor:WHITE_COLOR];
    [[_webView.scrollView af_loadBackFooter].stateLabel setTextColor:WHITE_COLOR];
    [[_webView.scrollView af_loadHeader].stateLabel setHidden:NO];
    [[_webView.scrollView af_loadBackFooter].stateLabel setHidden:NO];
    [[_webView.scrollView af_loadHeader] setTitle:header forState:MJRefreshStateIdle];
    [[_webView.scrollView af_loadHeader] setTitle:header forState:MJRefreshStatePulling];
    [[_webView.scrollView af_loadHeader] setTitle:header forState:MJRefreshStateRefreshing];
    [[_webView.scrollView af_loadHeader] setTitle:header forState:MJRefreshStateWillRefresh];
    [[_webView.scrollView af_loadBackFooter] setTitle:footer forState:MJRefreshStateIdle];
    [[_webView.scrollView af_loadBackFooter] setTitle:footer forState:MJRefreshStatePulling];
    [[_webView.scrollView af_loadBackFooter] setTitle:footer forState:MJRefreshStateRefreshing];
    [[_webView.scrollView af_loadBackFooter] setTitle:footer forState:MJRefreshStateWillRefresh];
}

- (void)dealloc{
    [_webView.scrollView af_removeObserverBlocksForKeyPath:@"contentOffset"];
}

@end
