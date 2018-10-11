//
//  MMUser.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/11.
//  Copyright © 2018 zmm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMUser : NSObject

+ (MMUser *)shareInstance;
+ (BOOL)isLogin;

- (void)setUser:(MMUserModel *)model;
- (void)clearUser;

#pragma mark - get
- (NSString *)getUserName;
- (NSString *)getUserId;

@end

NS_ASSUME_NONNULL_END
