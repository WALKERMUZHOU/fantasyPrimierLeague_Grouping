//
//  MMGroupingDataModel.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/8.
//  Copyright © 2018 zmm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMGroupingDateModel : MMBaseModel


/**
 当前数据的标题,以当前时间为准hh-mm-ss
 */
@property (nonatomic, strong) NSString *currentTitle;

/**
当前分组下所有数据
 */
@property (nonatomic, strong) NSArray *currentDateArray;
@end

NS_ASSUME_NONNULL_END
