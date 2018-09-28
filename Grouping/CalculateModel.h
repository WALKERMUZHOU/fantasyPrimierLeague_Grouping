//
//  CalclateModel.h
//  Grouping
//
//  Created by 朱成龙 on 2018/9/26.
//  Copyright © 2018 zmm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalculateModel : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger groupId;
@property (nonatomic, strong) NSString   *name;
@property (nonatomic, strong) NSString  *grade;
@end

NS_ASSUME_NONNULL_END
