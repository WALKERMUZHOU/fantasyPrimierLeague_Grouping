//
//  MMGroupingModel.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/8.
//  Copyright © 2018 zmm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MMGroupingModel : MMBaseModel

/**
 当前日期yy-mm-dd
 */
@property (nonatomic, strong) NSString *dateString;

/**
 按照日期分类Array
 */
@property (nonatomic, strong) NSArray   *dateGroupArray;

@end

NS_ASSUME_NONNULL_END
