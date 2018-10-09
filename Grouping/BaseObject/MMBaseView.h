//
//  MMBaseView.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/9.
//  Copyright © 2018 zmm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMBaseView : UIView


@property (strong, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic) NSUInteger currentPage;
@property (assign, nonatomic) NSUInteger totalPage;
@property (assign, nonatomic) BOOL refreshHeaderAndFooterNeeded;
@property (assign, nonatomic) BOOL refreshFooterNeeded;
@property(nonatomic,copy)NSString *scrollReuseIdentifier;

// default is No

- (void)refreshWithHeader;
- (void)loadView;
#pragma mark - refresh
- (void)loadDataWithPage:(NSUInteger)currentPage;
- (void)stopRefresh;
- (void)noMoreData;
#pragma mark - setListView
- (UIScrollView *)getListView;


@end

NS_ASSUME_NONNULL_END
