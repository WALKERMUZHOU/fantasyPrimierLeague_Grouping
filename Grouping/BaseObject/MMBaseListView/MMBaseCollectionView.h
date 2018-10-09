//
//  MMBaseCollectionView.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/9.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMBaseCollectionView : MMBaseView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:( UICollectionViewLayout *)layout;

@end

NS_ASSUME_NONNULL_END
