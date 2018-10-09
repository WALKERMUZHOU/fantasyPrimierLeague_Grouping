//
//  MMBaseCollectionViewController.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/9.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMBaseCollectionViewController.h"
#import "ConstantFile.h"
#import "ColorFile.h"

@interface MMBaseCollectionViewController ()

@end

@implementation MMBaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initCollectionViewWithLayout:(UICollectionViewLayout *)layout{
    if (layout) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, KScreenHeightBar)collectionViewLayout:layout];
    }else{
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, KScreenHeightBar) collectionViewLayout:layout];
    }
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.scrollsToTop = NO;
    [_collectionView setIndicatorStyle:UIScrollViewIndicatorStyleDefault];
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_collectionView];
    [self addBackIcon];
}

- (void)addBackIcon{
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
{   UICollectionViewCell *cell = [[UICollectionViewCell alloc]init];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - Others

- (UIScrollView *)getListView {
    return self.collectionView;
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
