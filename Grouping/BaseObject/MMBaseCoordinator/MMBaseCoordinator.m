//
//  MMBaseCoordinator.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/11.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMBaseCoordinator.h"
#import "MMNetworkSessionManager.h"
#import "NSDictionary+SafeAccess.h"

@implementation MMBaseCoordinatorRequestItem

@end


@interface MMBaseCoordinator()

@property (nonatomic, assign) NSInteger  index;

@end

@implementation MMBaseCoordinator

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        self.showErrorMessage = YES;
        self.requestItemArray = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithDelegate:(id<MMCoordinatorDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.requestItemArray = [NSMutableArray array];
        self.showErrorMessage = YES;
    }
    return self;
}

#pragma mark - Methods

- (void)getCurrentRequestItem:(NSString *)path andParamers:(NSDictionary *)paramers{
    if (!path) {
        return;
    }
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]initWithDictionary:paramers];
    [dataDic setObject:path forKey:@"path"];
    //    NSString *jsonString = [JsonUtil dictionaryToJson:dataDic];
    
}

- (void)getCurrentRequestItem:(NSString *)path {
    if (!path) {
        return;
    }
    MMBaseCoordinatorRequestItem *currentRequestItem;
    for (MMBaseCoordinatorRequestItem *requestItem in self.requestItemArray) {
        if ([requestItem.path isEqualToString:path]) {
            currentRequestItem = requestItem;
            break;
        }
    }
    if (!currentRequestItem) {
        currentRequestItem = [[MMBaseCoordinatorRequestItem alloc] init];
        currentRequestItem.path = path;
        [self.requestItemArray addObject:currentRequestItem];
    }
    self.currentRequestItem = currentRequestItem;
}

- (void)loadDataWithPath:(NSString *)path {
    [self loadDataWithPath:path parameters:nil requestSerializer:RequestSerializerTypeJson type:NSNotFound success:nil];
}

- (void)loadDataWithPath:(NSString *)path type:(NSInteger)type {
    [self loadDataWithPath:path parameters:nil requestSerializer:RequestSerializerTypeJson type:type success:nil];
}

- (void)loadDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters {
    [self loadDataWithPath:path parameters:parameters requestSerializer:RequestSerializerTypeJson type:NSNotFound success:nil];
}

- (void)loadDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters requestSerializer:(RequestSerializerType)serializerType{
    [self loadDataWithPath:path parameters:parameters requestSerializer:serializerType type:NSNotFound success:nil];
}

- (void)loadDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters type:(NSInteger)type {
    [self loadDataWithPath:path parameters:parameters requestSerializer:RequestSerializerTypeJson type:type success:nil];
}

- (void)loadDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(BOOL success))block  {
    [self loadDataWithPath:path parameters:parameters requestSerializer:RequestSerializerTypeJson type:NSNotFound success:block];
}

- (void)loadDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters requestSerializer:(RequestSerializerType )serializerType type:(NSInteger)type success:(void (^)(BOOL success))block {
    
    [self getCurrentRequestItem:path];
    self.currentRequestItem.type = type;
    if ([path isEqualToString:self.currentRequestItem.path] && self.currentRequestItem.requesting) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(coordinatorRepeatRequestFail)]) {
            [self.delegate coordinatorRepeatRequestFail];
        }
        return;
    }
    if ([self.delegate respondsToSelector:@selector(coordinatorBegainRequest)]) {
        self.currentRequestItem.requesting = YES;
        [self.delegate coordinatorBegainRequest];
    }
    [self resetBeginningState:parameters];

    self.currentRequestItem.task = [[MMNetworkSessionManager shareInstance]postPath:path parameters:parameters withBlock:^(NSDictionary *result, NSError *error) {
        [self getCurrentRequestItem:path];
        [self precessResult:result error:error success:block];
        [self requestEnd];
        self.currentRequestItem.requesting = NO;
    }];
}

- (void)resetBeginningState:(NSDictionary *)parameters {}

- (void)precessResult:(NSDictionary *)result error:(NSError *)error success:(void (^)(BOOL success))block{
    //此类由子类重写,主要是公共信息的处理(包括异常和正常数据)
    if (error) {
        NSLog(@"error:%@",error);
        if (self.showErrorMessage) {
            NSString *LocalizedDescription = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            if (LocalizedDescription && LocalizedDescription.length) {
                NSLog(@"NSLocalizedDescription:%@",LocalizedDescription);
            }else {
                NSString *DebugDescription = [error.userInfo objectForKey:@"NSDebugDescription"];
                if (DebugDescription && DebugDescription.length) {
                    NSLog(@"NSDebugDescription:%@",DebugDescription);
                }else {
                    NSLog(@"无网络连接");
                }
            }
        }
        //判断,无网络,访问超时等
        if([self.delegate respondsToSelector:@selector(coordinatorRequestError:)]){
            [self.delegate coordinatorRequestError:error];
        } else if (NSURLErrorTimedOut == error.code) {
            [self alterShowWithMessage:@"网络超时"];
        }
        
        if (block) {
            block(NO);
        }
    }else{
        NSString *code = [result ds_stringForKey:@"resultCode"];
        NSLog(@"%@",code);
        if ([code.lowercaseString isEqualToString:@"200"]) {
            id data = [result objectForKey:@"resultModel"];
            [self processOriginalData:data];
            if (block) {
                block(YES);
            }
        }else{
            if([self.delegate respondsToSelector:@selector(coordinatorRequestError:)]){
                [self.delegate coordinatorRequestError:error];
            }
            NSString *message = [result ds_stringForKey:@"resultMessage"];
            if (self.showErrorMessage) {
                if (message && message.length) {
                    NSLog(@"message-------->:%@",message);
                    //#ifdef DEBUG
//                    [SystemUtil showAlterViewWithMessage:message];
                    //#endif
                }else{
                    NSString *code = [result ds_stringForKey:@"resultCode"];
                    if (code && code.length) {
                        NSString *uppercaseCode = [code uppercaseString];
                        if ([uppercaseCode isEqualToString:@"1026"]) {
                            
                        }else if ([uppercaseCode isEqualToString:@"ERR_SYS"]){
                            NSLog(@"系统异常");
                        }else if ([uppercaseCode isEqualToString:@"ERR_TOKEN_EXPIRED"]){
                            NSLog(@"未知错误!");
                        }
                    }else{
                        NSLog(@"未知错误!");
                    }
                }
            }
            if(self.delegate && [self.delegate respondsToSelector:@selector(coordinatorRequestError:)]){
                NSError *myError = [[NSError alloc] initWithDomain:@"kBaseAddress" code:RequestErrorTypeServeBad userInfo:@{NSLocalizedDescriptionKey:message}];
                [self.delegate coordinatorRequestError:myError];
            }
            
            NSString *code = [result ds_stringForKey:@"resultCode"];
            if (self.delegate && [self.delegate respondsToSelector:@selector(coordinator:resultCode:resultMessage:)]) {
                [self.delegate coordinator:self resultCode:[code integerValue] resultMessage:message];
            }
            
            if (block) {
                block(NO);
            }
        }
    }
}

- (void)requestEnd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(coordinator:requestEndAllCompleted:)]) {
        [self.delegate coordinator:self requestEndAllCompleted:self.currentRequestItem.loadedAllData];
        self.currentRequestItem.requesting = NO;
    }
}

- (void)precessResult:(NSDictionary *)result error:(NSError *)error complete:(void (^)(BOOL))success {
    
}

- (void)processOriginalData:(id)data {
    if ([self.delegate respondsToSelector:@selector(coordinator:data:)]) {
        [self.delegate coordinator:self data:data];
    }
    if (!self.currentRequestItem.loadedAllData && [data isKindOfClass:[NSArray class]]) {
        if (!data || [(NSArray *)data count] == 0) {
            [self setLoadedAllData:YES];
        }else {
            [self setLoadedAllData:NO];
        }
    }
}

+ (void)loadDataDirectWithPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id))block {
    [[MMNetworkSessionManager shareInstance] postPath:path parameters:parameters withBlock:^(NSDictionary *result, NSError *error) {
        if (error) {
            
        }else{
            NSString *code = [result ds_stringForKey:@"resultCode"];
            NSLog(@"%@",code);
            if ([code.lowercaseString isEqualToString:@"200"]) {
                if (block) {
                    block(result[@"result"]);
                }
            }else{
                
            }
        }
        
    }];
}

#pragma mark - getMethod
- (void)getDataWithPath:(NSString *)path {
    [self getDataWithPath:path parameters:nil requestSerializer:RequestSerializerTypeJson type:NSNotFound success:nil];
}

- (void)getDataWithPath:(NSString *)path type:(NSInteger)type {
    [self getDataWithPath:path parameters:nil requestSerializer:RequestSerializerTypeJson type:type success:nil];
}

- (void)getDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters {
    [self getDataWithPath:path parameters:parameters requestSerializer:RequestSerializerTypeJson type:NSNotFound success:nil];
}


- (void)getDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters requestSerializer:(RequestSerializerType)serializerType{
    [self getDataWithPath:path parameters:parameters requestSerializer:serializerType type:NSNotFound success:nil];
}

- (void)getDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters type:(NSInteger)type {
    [self getDataWithPath:path parameters:parameters requestSerializer:RequestSerializerTypeJson type:type success:nil];
}

- (void)getDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(BOOL success))block  {
    [self getDataWithPath:path parameters:parameters requestSerializer:RequestSerializerTypeJson type:NSNotFound success:block];
}

- (void)getDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters requestSerializer:(RequestSerializerType )serializerType type:(NSInteger)type success:(void (^)(BOOL success))block {

    [self getCurrentRequestItem:path];
    self.currentRequestItem.type = type;
    if ([path isEqualToString:self.currentRequestItem.path] && self.currentRequestItem.requesting) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(coordinatorRepeatRequestFail)]) {
            [self.delegate coordinatorRepeatRequestFail];
        }
        return;
    }
    if ([self.delegate respondsToSelector:@selector(coordinatorBegainRequest)]) {
        self.currentRequestItem.requesting = YES;
        [self.delegate coordinatorBegainRequest];
    }
    [self resetBeginningState:parameters];

    self.currentRequestItem.task = [[MMNetworkSessionManager shareInstance] getPath:path parameters:parameters withBlock:^(NSDictionary *result, NSError *error) {
        [self getCurrentRequestItem:path];
        [self precessResult:result error:error success:block];
        [self requestEnd];
        self.currentRequestItem.requesting = NO;
    }];
    
}

- (void)alterShowWithMessage:(NSString *)message{

    UIAlertController *alertControl = [UIAlertController  alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertControl addAction:okAction];
//    [LogicHandle presentViewController:alertControl animate:YES];
}

- (void)setSmsToken:(NSString *)smsToken{
    if (smsToken && ![smsToken isEqualToString:@""]) {
        [[MMNetworkSessionManager shareInstance].requestSerializer setValue:smsToken forHTTPHeaderField:@"smsToken"];
    }else{
        [[MMNetworkSessionManager shareInstance].requestSerializer setValue:@"" forHTTPHeaderField:@"smsToken"];
    }
}
@end
