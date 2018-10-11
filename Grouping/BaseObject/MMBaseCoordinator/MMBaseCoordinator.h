//
//  MMBaseCoordinator.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/11.
//  Copyright © 2018 zmm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,RequestMethod) {
    RequestMethodGet = 0,
    RequestMethodPost = 1,
};

typedef NS_ENUM(NSInteger,RequestErrorType) {
    RequestErrorTypeNoNetWork = 0,
    RequestErrorTypeNoData = 1,
    RequestErrorTypeServeBad = 2,
};

typedef NS_ENUM(NSInteger,RequestSerializerType){
    RequestSerializerTypeHttp = 1,
    RequestSerializerTypeJson = 2,
};

@interface  MMBaseCoordinatorRequestItem: NSObject

@property (weak, nonatomic) NSURLSessionDataTask *task;
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger totalPage;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSDictionary  *paramers;
@property (strong, nonatomic) NSMutableDictionary  *requestDic;
@property (assign, nonatomic) RequestMethod requestMethod;//"post","get"
@property (assign, nonatomic) BOOL requesting;
@property (assign, nonatomic) BOOL loadedAllData;
@property (assign, nonatomic) BOOL showErrorMessage;//default is YES;

@end

@class MMBaseCoordinator;
@protocol MMCoordinatorDelegate <NSObject>
@optional

- (void)coordinatorBegainRequest;
- (void)coordinatorRepeatRequestFail;
- (void)coordinatorRequestError:(NSError *)error;
- (void)coordinator:(MMBaseCoordinator *)coordinator data:(id)data;
- (void)coordinatorLoadedAllData;
- (void)coordinator:(MMBaseCoordinator *)coordinator requestEndAllCompleted:(BOOL)completed;//if completed is YES,load All data

- (void)coordinator:(MMBaseCoordinator *)coordinator resultCode:(NSInteger)resultCode resultMessage:(NSString *)resultMessage;
- (void)coordinator:(MMBaseCoordinator *)coordinator resultCode:(NSInteger)resultCode data:(id)data resultMessage:(NSString *)resultMessage;

@end
@interface MMBaseCoordinator : NSObject

@property (assign, nonatomic) NSInteger tag;
@property (weak, nonatomic) id<MMCoordinatorDelegate> delegate;
@property (strong, nonatomic) NSDictionary *extraInfomation;
@property (assign, nonatomic) BOOL showErrorMessage;//default is YES;
@property (weak, nonatomic) MMBaseCoordinatorRequestItem *currentRequestItem;
@property (strong, nonatomic) NSMutableArray *requestItemArray;

+ (void)logoutAction;

- (void)setLoadedAllData:(BOOL)loadedAllData;
- (instancetype)initWithDelegate:(id <MMCoordinatorDelegate>)delegate;
- (void)loadDataWithPath:(NSString *)path;
- (void)loadDataWithPath:(NSString *)path type:(NSInteger)type;
- (void)loadDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters;
- (void)loadDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters requestSerializer:(RequestSerializerType )serializerType;
- (void)loadDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters type:(NSInteger)type;
- (void)loadDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(BOOL success))block;
- (void)loadDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters requestSerializer:(RequestSerializerType )serializerType type:(NSInteger)type success:(void (^)(BOOL success))block;
/**
 需要根据具体情况让子类重写
 */
- (void)precessResult:(NSDictionary *)result error:(NSError *)error complete:(void (^)(BOOL))success;

- (void)getCurrentRequestItem:(NSString *)path;


/**
 重置初始状态(loadAllData = NO)
 */
- (void)resetBeginningState:(NSDictionary *)parameters;
/**
 *  处理网络返回的数据,需要子类来重写
 *  @param data 源数据
 */
- (void)processOriginalData:(id)data;

+ (void)loadDataDirectWithPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id data))block;

#pragma mark - getMethod
- (void)getDataWithPath:(NSString *)path;
- (void)getDataWithPath:(NSString *)path type:(NSInteger)type;
- (void)getDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters;
- (void)getDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters requestSerializer:(RequestSerializerType )serializerType;
- (void)getDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters type:(NSInteger)type;
- (void)getDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(BOOL success))block;
- (void)getDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters requestSerializer:(RequestSerializerType )serializerType type:(NSInteger)type success:(void (^)(BOOL success))block;


@end

NS_ASSUME_NONNULL_END
