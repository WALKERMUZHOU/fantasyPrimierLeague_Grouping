//
//  MMBaseCollectionViewController.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/9.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMBaseListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMBaseCollectionViewController : MMBaseListViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
- (void)initCollectionViewWithLayout:(UICollectionViewLayout *)layout;

@end

NS_ASSUME_NONNULL_END
