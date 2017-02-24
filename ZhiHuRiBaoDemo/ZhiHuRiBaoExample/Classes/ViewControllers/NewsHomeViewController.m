//
//  NewsHomeViewController.m
//  AppFrame
//
//  Created by HQ on 2016/11/28.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "NewsHomeViewController.h"
#import "NavigationBarView.h"
#import "AFLastNewsApi.h"
#import "AFLastNewsModel.h"
#import "AFAdPagesView.h"
#import "AFTopNewsModel.h"
#import "AFNewsModel.h"
#import "AFShortNewsTableViewCell.h"
#import "AFBeforeNewsApi.h"
#import "AFBeforeNewsModel.h"
#import "AFNewsDetailViewController.h"

#define CELL_HEIGHT  (100.0)
/**
 .headline .img-place-holder {
 height: 200px;
 } */
#define HEADER_HEIGHT (200.0) /// 数据来源于知乎日报的接口
static NSString* const kCellIdentifier = @"kAFShortNewsTableViewCell";

@interface NewsHomeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NavigationBarView*  _naviBarView;
    AFAdPagesView*      _adPagesView;
    AFWebImageView*     _snapView;
    UITableView*        _tableView;

    AFLastNewsModel*    _dataModel;
    NSArray*            _topModels;
    NSArray*            _newsModels;
    BOOL                _didChangHeaderView;
    NSString*           _dataString;
}

@end

@implementation NewsHomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNavigationBar];
    [self setupViews];
    _dataString = [self getYestodayDateString];
}

- (void)setUpNavigationBar{
    _naviBarView = [NavigationBarView getView];
    _naviBarView.hq_height = 54.0f;
    _naviBarView.backgroundColor = [UIColor clearColor];
    //_naviBarView.alpha = 0.0f;
    [_naviBarView setCenterTitle:@"今日热闻"];
}

- (void)setupViews{
    [self.view addSubview:[UIView new]];
    WEAK(self)
    _adPagesView = [AFAdPagesView adPagesViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADER_HEIGHT) needPageControl:YES didTapPicBlock:^(NSInteger index) {
        STRONG(weak_self)
        AFTopNewsModel* topModel = [strong_weak_self->_topModels objectAtIndex:index];
        [strong_weak_self gotoNewsDetailViewWithNewsID:topModel.newsID];
    }];
    _adPagesView.currentPageColor = [UIColor whiteColor];
    _adPagesView.pagePosition = ePositionCenter;
    [_adPagesView startAutoWithDuration:5.0];

    _snapView = [AFWebImageView hq_frameWithX:0 Y:0 width:SCREEN_WIDTH height:HEADER_HEIGHT];
    _snapView.contentMode = UIViewContentModeScaleAspectFill;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [_tableView registerNib:[UINib nibWithNibName:@"AFShortNewsTableViewCell" bundle:nil] forCellReuseIdentifier:kCellIdentifier];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = COMMON_BG_COLOR;
    [_tableView addRefreshHeaderWithCall:^{
        STRONG(weak_self)
        [strong_weak_self loadDataFromNewtworking];
    }];
    [_tableView addRefreshFooterWithCall:^{
        STRONG(weak_self)
        [strong_weak_self loadMoreDataFromNewtworking];
    }];
    [_tableView beginRefresh];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }

    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = _adPagesView;

    UIView* bgView = [UIView new];
    [bgView addSubview:_snapView];
    _tableView.backgroundView = bgView;
    /// 添加模拟导航栏
    [self.view addSubview:_naviBarView];
}

- (void)updateViews{
    NSMutableArray* adModels = [NSMutableArray array];
    _topModels = _dataModel.top_stories;
    for (AFTopNewsModel* topModel in _dataModel.top_stories) {
        AFAdPageModel* model = [AFAdPageModel new];
        model.imgURLString = topModel.image;
        model.text = topModel.title;
        [adModels addObject:model];
    }
    _adPagesView.modelArray = adModels;
    _newsModels = _dataModel.stories;
    [_tableView reloadData];
}

#pragma mark - 请求数据 - begin
- (void)loadDataFromNewtworking{
    [_adPagesView stopAutoScrollAnimation];
    AFLastNewsApi *lastNewsApi = [[AFLastNewsApi alloc] init];
    [lastNewsApi startSuccessCall:^(id responseJOSN, id responseModel) {
        _dataModel = responseModel;
        dispatch_main_async_safe(^{
            [self updateViews];
        })
        LOG(@"-- model - %@",_dataModel);
        [_tableView endRefresh];
        [_adPagesView startAutoWithDuration:5.0];
    } failureCall:^(NSError *error, NSDictionary *userInfo) {
        [self showError:error];
        [_tableView endRefresh];
    }];
}

- (void)loadMoreDataFromNewtworking{
    AFBeforeNewsApi* beforeNewsApi = [AFBeforeNewsApi getModelWithDate:_dataString];
    [beforeNewsApi startSuccessCall:^(id  _Nonnull responseJOSN, id  _Nonnull responseModel) {
        [_tableView endRefresh];
        AFBeforeNewsModel* beforeNewsModel = responseModel;
        _dataString = beforeNewsModel.date;
        _newsModels = [_newsModels arrayByAddingObjectsFromArray:beforeNewsModel.stories];
        LOG(@"-- date - %@ \n before_model - %@",_dataString,beforeNewsModel);
        dispatch_main_async_safe(^{
            [_tableView reloadData];
        })
    } failureCall:^(NSError * _Nonnull error, NSDictionary * _Nonnull userInfo) {
        [self showError:error];
        [_tableView endRefresh];
    }];
}
#pragma mark 请求数据 - end
#pragma mark -

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AFNewsModel* model = [_newsModels objectAtIndex:indexPath.row];
    [self gotoNewsDetailViewWithNewsID:model.newsID];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _newsModels.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AFShortNewsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(AFShortNewsTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

    [cell updateCellWithModel:[_newsModels objectAtIndex:indexPath.row]];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_adPagesView stopAutoScrollAnimation];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offSet = _tableView.contentOffset;
    if (offSet.y < 0.0f) {
        if (_didChangHeaderView == NO) {
            [self updateSnapViewWithIndex:_adPagesView.currentIndex];
            [_adPagesView hidenDisplayImage:YES];
            _didChangHeaderView = YES;
        }

        [_snapView setHq_height:_adPagesView.hq_height + ABS(offSet.y)];

    }else{
        [self setStatusBarColorWithOffsetY:offSet.y];
        if (_didChangHeaderView) {
            [self updateSnapViewWithIndex:_adPagesView.currentIndex];
            [_adPagesView hidenDisplayImage:YES];
            _didChangHeaderView = NO;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger alpha = (NSInteger)(scrollView.contentOffset.y / HEADER_HEIGHT);
    _naviBarView.backgroundColor = RGBA(63, 150, 240, alpha);
    [UIView animateWithDuration:0.1 animations:^{
        _snapView.hq_height = HEADER_HEIGHT;
    }];
    [_adPagesView startAutoWithDuration:5.0];
    _didChangHeaderView = NO;
}

#pragma mark - Helper
- (void)updateSnapViewWithIndex:(NSInteger) index{
    UIImage* image = _adPagesView.currentDisplayImg;
    [_snapView setImage:image];
}

- (NSString*)getYestodayDateString{
    NSDate* today = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    return [dateFormatter stringFromDate:[today dateByAddingTimeInterval:-24*60*60]];
}

- (void)setStatusBarColorWithOffsetY:(CGFloat)y{
    _naviBarView.backgroundColor = RGBA(63, 150, 240, y / HEADER_HEIGHT);
}

- (void)gotoNewsDetailViewWithNewsID:(NSString* )newsID{
    
    NSMutableArray* newsIDS = @[].mutableCopy;
    for (NSInteger i = 0; i < _newsModels.count; i++) {
        AFNewsModel* model = _newsModels[i];
        [newsIDS addObject:model.newsID];
    }

    NSInteger currentIndex = 0;
    for (NSString* ID in newsIDS) {
        if ([ID isEqualToString:newsID]) {
            currentIndex = [newsIDS indexOfObject:ID];
        }
    }

    AFNewsDetailViewController* detailVC = [AFNewsDetailViewController getController];
    detailVC.newsID = newsID;
    [detailVC setDataArray:_newsModels currentIndex:currentIndex];
    [self enterViewController:detailVC animated:YES];
}

- (void)enterViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == nil) {
        return;
    }
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromTop;
    [self.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:viewController animated:NO];
}

@end
