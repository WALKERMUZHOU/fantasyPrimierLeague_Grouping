//
//  CalclateModel.h
//  Grouping
//
//  Created by 朱成龙 on 2018/9/26.
//  Copyright © 2018 zmm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CalculateModel : MMBaseModel<NSCoding>

/**
 当前分组id
 */
@property (nonatomic, assign) NSInteger groupId;

/**
 用户名称
 */
@property (nonatomic, strong) NSString   *name;

/**
 成绩
 */
@property (nonatomic, strong) NSString  *grade;

@end

NS_ASSUME_NONNULL_END
