//
//  MMUserModel.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/11.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMUserModel : MMBaseModel
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *name;
@end

NS_ASSUME_NONNULL_END
