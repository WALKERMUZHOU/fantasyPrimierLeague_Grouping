//
//  MMNetworkSessionManager.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/11.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "AFNetworking/AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMNetworkSessionManager : AFHTTPSessionManager

+ (MMNetworkSessionManager *)shareInstance;

/**
 *  get请求
 *
 *  @param path       url路径
 *  @param parameters 参数
 *  @param block      block
 */
- (NSURLSessionDataTask *)getPath:(NSString *)path parameters:(NSDictionary *)parameters withBlock:(void (^)(NSDictionary *result, NSError *error))block;


/**
 *  post请求
 *
 *  @param path       url路径
 *  @param parameters 参数
 *  @param block      block
 */
- (NSURLSessionDataTask *)postPath:(NSString *)path parameters:(NSDictionary *)parameters withBlock:(void (^)(NSDictionary *result, NSError *error))block;

#pragma mark - NetworkReachability
// 开始检测网络状态
- (void)startMonitoring;
// 停止检测网络状态
- (void)stopMonitoring;
// 是否可以连接网络
@property (nonatomic, assign, readonly) BOOL netWorkAbility;

#pragma mark - 设置超时
@property (nonatomic, assign) NSTimeInterval timeoutInterval;   // 默认30秒

@end

NS_ASSUME_NONNULL_END
