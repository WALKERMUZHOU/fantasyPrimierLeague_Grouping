//
//  MMBaseListViewController.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/9.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMBaseListViewController.h"
#import "MMFreshHeader.h"
#import "MMRefreshFooter.h"

@interface MMBaseListViewController ()

@property (weak, nonatomic) UIScrollView *listView;

@end

@implementation MMBaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currentPage = 1;
    self.dataSource = [[NSMutableArray alloc]init];
}

#pragma mark - Refresh and LoadMore

- (void)setRefreshHeaderAndFooterNeeded:(BOOL)refeshHeaderAndFooterNeeded {
    _refreshHeaderAndFooterNeeded = refeshHeaderAndFooterNeeded;
    if (!self.listView) {
        self.listView = [self getListView];
    }
    if (refeshHeaderAndFooterNeeded) {
        self.listView.mj_header.hidden = NO;
        self.listView.mj_header = [MMFreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        self.listView.mj_footer.hidden = NO;
        self.listView.mj_footer = [MMRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    }else{
        self.listView.mj_header.hidden = YES;
        self.listView.mj_footer.hidden = YES;
    }
}

- (void)setRefreshFooterNeeded:(BOOL)refreshFooterNeeded{
    _refreshFooterNeeded = refreshFooterNeeded;
    if (!self.listView) {
        self.listView = [self getListView];
    }
    if (refreshFooterNeeded) {
        self.listView.mj_header.hidden = YES;
        self.listView.mj_footer.hidden = NO;
        self.listView.mj_footer = [MMRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    }else{
        self.listView.mj_footer.hidden = YES;
    }
}

- (void)setRefreshHeaderNeeded:(BOOL)refreshHeaderNeeded{
    _refreshHeaderNeeded = refreshHeaderNeeded;
    
    if (!self.listView) {
        self.listView = [self getListView];
    }
    if (refreshHeaderNeeded) {
        self.listView.mj_header.hidden = NO;
        self.listView.mj_header = [MMFreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        self.listView.mj_footer.hidden = YES;
    }else{
        self.listView.mj_header.hidden = YES;
    }
}

- (void)refresh {
    self.currentPage = 1;
    [self.listView.mj_footer resetNoMoreData];
    [self loadDataWithPage:self.currentPage];
}

- (void)loadMore {
    self.currentPage ++ ;
    [self loadDataWithPage:self.currentPage];
}

- (void)loadDataWithPage:(NSUInteger)currentPage {
    
}

- (void)stopRefresh {
    [self.listView.mj_header endRefreshing];
    [self.listView.mj_footer endRefreshing];
}

- (void)noMoreData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.listView.mj_footer endRefreshingWithNoMoreData];
    });
}

#pragma mark - coordinatorDelegate

//- (void)coordinatorBegainRequest {
//
//}
//
//- (void)coordinatorEndRequest {
//    [self stopRefresh];
//}
//
//- (void)coordinator:(CQMBaseCoordinator *)coordinator data:(id)data {
//    if ([data isKindOfClass:[NSArray class]]) {
//        if (self.currentPage == 1) {
//            [self.dataSource removeAllObjects];
//        }
//        [self.dataSource addObjectsFromArray:(NSArray *)data
//         ];
//    }
//}

#pragma mark - Others
- (UIScrollView *)getListView {
    return nil;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
