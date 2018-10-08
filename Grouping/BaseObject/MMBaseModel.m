//
//  MMBaseModel.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/8.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMBaseModel.h"

@implementation MMBaseModel

#pragma Coding/Copying/hash/equal/description

- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
- (NSString *)description { return [self yy_modelDescription]; }

+ (NSDictionary*)modelCustomPropertyMapper {
    return [NSDictionary dictionary];
}

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary*)modelContainerPropertyGenericClass {
    return [NSDictionary dictionary];
}

// 如果实现了该方法，则处理过程中不会处理该列表外的属性。
//+ (NSArray*)modelPropertyWhitelist
//{
//    return [NSArray array];
//}

// 如果实现了该方法，则处理过程中会忽略该列表内的所有属性
+ (NSArray*)modelPropertyBlacklist {
    return [NSArray array];
}

// 当 JSON 转为 Model 完成后，该方法会被调用。
// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
// 你也可以在这里做一些自动转换不能完成的工作。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    return YES;
}

@end
