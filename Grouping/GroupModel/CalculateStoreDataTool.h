//
//  CalculateStoreDataTool.h
//  Grouping
//
//  Created by 朱成龙 on 2018/9/28.
//  Copyright © 2018 zmm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMGroupingDateModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CalculateStoreDataTool : NSObject

//存储当前排序结果
+ (void)storeCalculateData:(NSArray *)calculateData;

//重新存储某一条数据
+ (void)reStoreOneDateDate:(MMGroupingDateModel *)model;

+ (NSArray *)getStoredArray;

//重新存储全部结果
+ (void)reStoreAllData:(NSArray *)allData;



@end

NS_ASSUME_NONNULL_END
