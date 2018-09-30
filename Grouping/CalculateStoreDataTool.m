//
//  CalculateStoreDataTool.m
//  Grouping
//
//  Created by 朱成龙 on 2018/9/28.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "CalculateStoreDataTool.h"
static NSString *const kUserInfo_File_Name = @"kCalculate_File_Name.data";
static NSString *const kCalculateInfo_key = @"kCalculateInfo_key";



@implementation CalculateStoreDataTool

+ (void)storeCalculateData:(NSArray *)calculateData{

    
    NSMutableData *deviceData = [[NSMutableData alloc] init];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:deviceData];
    [archiver encodeObject:[CalculateStoreDataTool getDeviceDataPath] forKey:kCalculateInfo_key];
    [archiver finishEncoding];
    [deviceData writeToFile:[CalculateStoreDataTool getDeviceDataPath] atomically:YES];
}

+ (NSArray *)getStoredArray{
    
    NSMutableData *data = [[NSMutableData alloc]initWithContentsOfFile:[CalculateStoreDataTool getDeviceDataPath]];
    NSKeyedUnarchiver *archieve = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    NSArray *array = [archieve decodeObjectForKey:kCalculateInfo_key];
    [archieve finishDecoding];
    return array;
    
}

+ (NSString *)getDeviceDataPath{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *deviceDataPath = [path stringByAppendingPathComponent:kUserInfo_File_Name];
    return deviceDataPath;
}

- (void)getTimeStamp{
    NSTimeInterval timeIn = [[NSDate alloc] timeIntervalSince1970];
    
    NSDateFormatter *dateformate = [[NSDateFormatter alloc]init];
    dateformate.dateFormat = @"yy-mm-dd";
    NSString *currentTime = [dateformate stringFromDate:[NSDate date]];
    
}

@end
