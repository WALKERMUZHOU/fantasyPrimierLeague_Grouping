//
//  CGItemView.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/16.
//  Copyright © 2018 zmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculateModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^SaveBlock)(CalculateModel *model);
@interface CGItemView : UIView

@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *scoreTF;
@property (nonatomic, strong) CalculateModel *model;
@property (nonatomic, copy) SaveBlock save;

@end

NS_ASSUME_NONNULL_END
