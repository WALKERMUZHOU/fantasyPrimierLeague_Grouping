//
//  MMBaseListViewController.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/9.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMBaseListViewController : MMBaseViewController

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic) NSUInteger currentPage;
@property (assign, nonatomic) NSUInteger totalPage;
@property (assign, nonatomic) BOOL refreshHeaderAndFooterNeeded;// default is No
@property (assign, nonatomic) BOOL refreshHeaderNeeded;// default is No
@property (assign, nonatomic) BOOL refreshFooterNeeded;// default is No

#pragma mark - refresh
- (void)loadDataWithPage:(NSUInteger)currentPage;
- (void)stopRefresh;
- (void)noMoreData;
#pragma mark - setListView
- (UIScrollView *)getListView;

@end

NS_ASSUME_NONNULL_END
