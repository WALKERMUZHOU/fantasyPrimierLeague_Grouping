//
//  MMJsonUtil.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/12.
//  Copyright © 2018 zmm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMJsonUtil : NSObject

//jsonString 与字典互转
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;
+ (NSString *)objectToJson:(id)object;

@end

NS_ASSUME_NONNULL_END
