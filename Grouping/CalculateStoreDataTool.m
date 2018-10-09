//
//  CalculateStoreDataTool.m
//  Grouping
//
//  Created by 朱成龙 on 2018/9/28.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "CalculateStoreDataTool.h"
#import "CalculateModel.h"
#import "MMGroupingModel.h"
#import "MMGroupingDateModel.h"

static NSString *const kUserInfo_File_Name = @"kCalculate_File_Name.data";
static NSString *const kCalculateInfo_key = @"kCalculateInfo_key";



@implementation CalculateStoreDataTool

+ (void)storeCalculateData:(NSArray *)calculateData{

    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[CalculateStoreDataTool getStoredArray]];
    if (array && array.count>0) {
        for (NSInteger i = 0; i<array.count; i++) {
            
            MMGroupingModel *groupingModel = [array objectAtIndex:i];

            NSString *storeTime = groupingModel.dateString;
            
            if ([storeTime isEqualToString:[CalculateStoreDataTool getCurretTime]]) {
                NSMutableArray *currentDataArray = [groupingModel.dateGroupArray mutableCopy];
                
                MMGroupingDateModel *model = [[MMGroupingDateModel alloc]init];
                model.currentDateArray = calculateData;
                model.currentTitle = [CalculateStoreDataTool getCurrentDetailTime];
                
                [currentDataArray insertObject:model atIndex:0];
                groupingModel.dateGroupArray = currentDataArray;
                break;
            }
            
        }
    }else{
        MMGroupingModel *groupingModel = [[MMGroupingModel alloc] init];
        groupingModel.dateString = [CalculateStoreDataTool getCurretTime];
        
        NSMutableArray *mutableArray = [NSMutableArray array];
        MMGroupingDateModel *model = [[MMGroupingDateModel alloc]init];
        model.currentDateArray = calculateData;
        model.currentTitle = [CalculateStoreDataTool getCurrentDetailTime];
        [mutableArray addObject:model];
        
        groupingModel.dateGroupArray = mutableArray;
        
        [array addObject:groupingModel];
    }
    
    NSMutableData *deviceData = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:deviceData];
    [archiver encodeObject:array forKey:kCalculateInfo_key];
    [archiver finishEncoding];
    [deviceData writeToFile:[CalculateStoreDataTool getDeviceDataPath] atomically:YES];
}

+ (void)reStoreAllData:(NSArray *)allData{
    NSMutableData *deviceData = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:deviceData];
    [archiver encodeObject:allData forKey:kCalculateInfo_key];
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

+ (NSString *)getCurretTime{
    
    NSDateFormatter *dateformate = [[NSDateFormatter alloc]init];
    dateformate.dateStyle = NSDateFormatterMediumStyle;
    dateformate.timeStyle = NSDateFormatterShortStyle;
    dateformate.dateFormat = @"yyyy-MM-dd";
    NSString *currentTime = [dateformate stringFromDate:[NSDate date]];
    return currentTime;
}

+ (NSString *)getCurrentDetailTime{
    NSDateFormatter *dateformate = [[NSDateFormatter alloc]init];
    dateformate.dateStyle = NSDateFormatterMediumStyle;
    dateformate.timeStyle = NSDateFormatterShortStyle;
    dateformate.dateFormat = @"HH:MM:ss";
    NSString *currentTime = [dateformate stringFromDate:[NSDate date]];
    return currentTime;
}

@end
