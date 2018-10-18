//
//  MMTimeUtil.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/12.
//  Copyright © 2018 zmm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMTimeUtil : NSObject


/**
 *  @return 返回当前时间2014-05-01 15:20:13
 */
+(NSString *)getNowTime;

/**
 *  得到时间差
 *  @param time 2014-05-01 15:20:13
 *  @return 返回秒
 */
+(long)getTimeDistance:(NSString *)time;

/**
 *  根据时间戳得到具体时间
 *  @param time 时间戳
 *  @return 时间（2014-05-01 15:20:13）
 */
+(NSString *)getTimeByTimeStamp:(NSString *)time;

//2015/02/13  12:24
+ (NSString *)getTimeStyleTwoByTimeStamp:(NSString *)time;

/**
 *  得到时间戳
 *  @return 返回时间戳
 */
+(NSString *)getTimeStamp;

+(NSArray *)yearArray;

+(NSArray *)monthArray;

+(NSArray *)dayArray;


@end

NS_ASSUME_NONNULL_END
