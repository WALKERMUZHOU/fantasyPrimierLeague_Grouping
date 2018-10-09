//
//  MMBaseCollectionView.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/9.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMBaseCollectionView.h"

@implementation MMBaseCollectionView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initCollectionViewWithLayout:nil];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [self initCollectionViewWithLayout:layout];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:( UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame];
    if (self) {
        [self initCollectionViewWithLayout:layout];
    }
    return self;
}

- (void)initCollectionViewWithLayout:(UICollectionViewLayout *)layout{
    if (layout) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    }else{
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds];
    }
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.scrollsToTop = NO;
    [_collectionView setIndicatorStyle:UIScrollViewIndicatorStyleDefault];
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_collectionView];
    [self addBackIcon];
}

- (void)addBackIcon{
//    CGFloat kScreenWidth = [UIScreen mainScreen].bounds.size.width;
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-23, -46-32, 46, 46)];
//    [imageView setImage:[UIImage imageNamed:@"public_icon_background"]];
//    [_collectionView addSubview:imageView];
}
#pragma mark - coordinatorDelegate

//- (void)coordinator:(CQMBaseCoordinator *)coordinator data:(id)data {
//    [super coordinator:coordinator data:data];
//    [self.collectionView reloadData];
//}

#pragma mark - UICollectionViewDelegate and UICollectionDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [[UICollectionViewCell alloc]init];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - setListView
- (UIScrollView *)getListView {
    return self.collectionView;
}

@end
