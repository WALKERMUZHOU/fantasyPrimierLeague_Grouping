//
//  MMUser.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/11.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMUser.h"

static NSString * const kUserInfo_key = @"kUserInfo_key";
static NSString * const kUserInfo_File_Name = @"kUserInfo.data";

@interface MMUser () <NSCoding>

@property (nonatomic, strong) MMUserModel *model;

@end

@implementation MMUser

static MMUser *instance = nil;
+ (MMUser *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MMUser alloc]init];
    });
    return instance;
}

/**
 code
 @param model userModel
 */
- (void)userInfoArchieve:(MMUserModel *)model{
    [self clearUser];
    self.model = model;
    NSMutableData *deviceData = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:deviceData];
    [archiver encodeObject:self.model forKey:kUserInfo_key];
    [archiver finishEncoding];
    [deviceData writeToFile:[[self class] obtainDeviceDataPath] atomically:YES];
}

/**
 decode

 @return MMUserModel
 */
- (MMUserModel *)userInfoUnArchieve{
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[[self class] obtainDeviceDataPath]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    MMUserModel *model = [unarchiver decodeObjectForKey:kUserInfo_key];
    [unarchiver finishDecoding];
    return model;
}

/**
 path
 @return data path
 */
+ (NSString *)obtainDeviceDataPath {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *deviceDataPath = [path stringByAppendingPathComponent:kUserInfo_File_Name];
    return deviceDataPath;
}

+ (BOOL)isLogin{
    MMUserModel *model = [[MMUser shareInstance] userInfoUnArchieve];
    if (model && model.userId && ![model.userId isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

- (void)setUser:(MMUserModel *)model{
    [self userInfoArchieve:model];
}

- (void)clearUser{
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath:[[self class] obtainDeviceDataPath]]) {
        [defaultManager removeItemAtPath:[[self class] obtainDeviceDataPath] error:nil];
    }
}

#pragma mark - getMethod
- (NSString *)getUserId{
    MMUserModel *model = [self userInfoUnArchieve];
    if (!model.userId) {
        return @"";
    }
    return model.userId;
}

- (NSString *)getUserName{
    MMUserModel *model = [self userInfoUnArchieve];
    if (!model.name) {
        return @"";
    }
    return model.name;
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.model forKey:kUserInfo_key];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        self.model = [aDecoder decodeObjectForKey:kUserInfo_key];
    }
    return self;
}

@end
