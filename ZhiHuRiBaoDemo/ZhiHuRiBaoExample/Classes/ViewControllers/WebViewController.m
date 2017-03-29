//
//  WebViewController.m
//  AppFrame
//
//  Created by HQ on 2016/11/28.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "WebViewController.h"
#import <Social/Social.h>
#import "AFNewsImageView.h"
@interface WebViewController ()<UIWebViewDelegate>{
    UIWebView* _webView;
}

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"外部网页";
    [self setUpWebView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _webView.hq_height = SCREEN_HEIGHT - NAVIGATION_HEIGHT - STATUSBAR_HEIGHT;

    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setUpWebView{
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_webView];
    if (self.localWebString) {
        [_webView loadHTMLString:self.localWebString baseURL:nil];
    }else{
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString]]];
    }
    _webView.delegate = self;

    [_webView af_didClickImageCall:^(NSString *URLString) {
        [AFNewsImageView showWithImageURLString:URLString];
    }];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSURL* URL = request.URL;
    NSString* URLString = URL.absoluteString;
    LOG(@"正在加载的URLString : %@", URLString);
    [self setNavigationLeftItems];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self showProgressWithMessage:nil];

    /// 如果5秒钟后还没有加载完成，取消加载图示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismiss];
    });
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self dismiss];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)setNavigationLeftItems{
    UIImage* image = [UIImage imageNamed:k_navi_left_back_image];
    UIFont* font = UIFontMake(17);

    UIButton* leftTopBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36+image.size.width+5, 30)];
    leftTopBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    leftTopBtn.titleLabel.font = font;
    [leftTopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftTopBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftTopBtn setImage:image forState:UIControlStateNormal];

    UIBarButtonItem* leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftTopBtn];
    [leftTopBtn addTarget:self action:@selector(af_leftTopAction) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -5;

    UIBarButtonItem * closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeThisView)];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:spaceItem, leftBar, spaceItem, closeItem, spaceItem, nil];

    UIBarButtonItem * shareItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(af_rightTopAction)];
    self.navigationItem.rightBarButtonItems = @[shareItem];
}

- (void)af_leftTopAction{
    if ([_webView canGoBack]) {
        [_webView goBack];
    }else{
        [super af_leftTopAction];
    }
}

- (void)closeThisView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)af_rightTopAction{
    /// 设置分享内容
    NSString *text = @"来自知乎，分享知识";
    UIImage *image = [UIImage imageNamed:k_zhifuribao_share_icon_image];
    NSURL *url = [NSURL URLWithString:self.shareString];
    NSArray *activityItems = @[text, image, url];

    /// 服务类型控制器
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:nil];

    /// 选中分享类型
    [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){

        LOG(@"choose type -- %@",activityType);
        if (completed) {
            LOG(@"分享成功");
        }
    }];
}

@end
