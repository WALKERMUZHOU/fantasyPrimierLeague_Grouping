//
//  CalculateStoreDataTool.h
//  Grouping
//
//  Created by 朱成龙 on 2018/9/28.
//  Copyright © 2018 zmm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalculateStoreDataTool : NSObject


+ (void)storeCalculateData:(NSArray *)calculateData;
+ (NSArray *)getStoredArray;

+ (void)reStoreAllData:(NSArray *)allData;

@end

NS_ASSUME_NONNULL_END
