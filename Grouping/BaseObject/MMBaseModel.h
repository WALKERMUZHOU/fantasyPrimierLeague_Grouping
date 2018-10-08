//
//  MMBaseModel.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/8.
//  Copyright © 2018 zmm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YYModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MMBaseModel : NSObject
/**
 *  YYModel适配属性键值 key:属性名     value:字典的key
 *
 *  @return 字典
 */

+ (NSDictionary *)modelCustomPropertyMapper;

/**
 * YYModel 适配嵌套模型  key:属性名   value:嵌套模型的class
 *
 *  @return 字典
 */

+ (NSDictionary *)modelContainerPropertyGenericClass;

/**
 *  YYModel黑名单
 *
 *  @return 数组
 */
+ (NSArray *)modelPropertyBlacklist;

/**
 *  YYModel白名单
 *
 *  @return 白名单
 */
//+ (NSArray *)modelPropertyWhitelist;

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic ;

@end

NS_ASSUME_NONNULL_END
