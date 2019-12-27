//
//  HHSocketManager.m
//  GCDAsyncSocketManager
//
//  Created by tianxi on 2019/12/24.
//  Copyright © 2019 hh. All rights reserved.
//

#import "HHSocketManager.h"
#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>
#import <CommonCrypto/CommonDigest.h>

#import "ZFReachabilityManager.h"

#import "HHTimer.h"
  
const char *kSocketReceiveQueueKey = "com.stock.manager.receive";
const char *kSocketRequestQueueKey = "com.stock.manager.request";
const char *kSocketTasksQueueKey = "com.stock.manager.tasks";

//! 发数据的串行队列
static dispatch_queue_t stock_manager_request_queue() {
    static dispatch_queue_t stock_manager_request_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stock_manager_request_queue = dispatch_queue_create(kSocketRequestQueueKey, DISPATCH_QUEUE_SERIAL);
        dispatch_queue_set_specific(stock_manager_request_queue, kSocketRequestQueueKey, &kSocketRequestQueueKey, NULL);
    });

    return stock_manager_request_queue;
}

//! 接收数据的串行队列
static dispatch_queue_t stock_manager_receive_queue() {
    static dispatch_queue_t stock_manager_receive_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stock_manager_receive_queue = dispatch_queue_create(kSocketReceiveQueueKey, DISPATCH_QUEUE_SERIAL);
        dispatch_queue_set_specific(stock_manager_receive_queue, kSocketReceiveQueueKey, &kSocketReceiveQueueKey, NULL);
    });

    return stock_manager_receive_queue;
}
 
//! 操作任务数组的串行队列
static dispatch_queue_t stock_manager_tasks_queue() {
    static dispatch_queue_t stock_manager_tasks_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stock_manager_tasks_queue = dispatch_queue_create(kSocketTasksQueueKey, DISPATCH_QUEUE_SERIAL);
        dispatch_queue_set_specific(stock_manager_tasks_queue, kSocketTasksQueueKey, &kSocketTasksQueueKey, NULL);
    });

    return stock_manager_tasks_queue;
}
  

@interface HHSocketManager()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) HHSocketConfiguration *configuration;
 
@property (nonatomic, strong) GCDAsyncSocket *socket;

@property (nonatomic, assign) HHSocketStatus socketStatus;

//
@property (nonatomic, strong) NSMutableArray<HHSocketRequest *> *requestTasks;
  
// 心跳计时器
@property (nonatomic, strong) HHTimer *heartBeatTimer;
// 重连定时器
@property (nonatomic, strong) HHTimer* reconnectTimer;
// 重连次数
@property (nonatomic, assign) NSUInteger reConnectCount;

@end
  
@implementation HHSocketManager
 
#pragma mark - Initialize
  
- (instancetype)initWithConfiguration:(nonnull HHSocketConfiguration *)configuration {
    if (self = [super init]) {
        self.configuration = configuration;
        [self didInitialize];
    }
    return self;
}

- (instancetype)init {
    return [self initWithConfiguration:[HHSocketConfiguration defaultConfiguration]];
}

- (void)didInitialize {
    [self initSocket];
    [self initHeartBeatTimer];
    [self initReconnectTimer];
    [self initNetWorkObserver];
}

- (void)initSocket{
    [self _clearupSocket];
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:stock_manager_receive_queue()];
}

- (void)initHeartBeatTimer{
    NSTimeInterval heartBerterInterval = kcHHSocket_HeartBeatInterval;
    if (self.configuration.heartBeatInterval > 0) {
        heartBerterInterval = self.configuration.heartBeatInterval;
    }
    __weak __typeof(self) weakSelf = self;
    _heartBeatTimer = [HHTimer timerWithInterval:heartBerterInterval handler:^{
        __typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _sendHeartBeat];
    }];
}

- (void)initReconnectTimer{
    CGFloat reconnectInterval = kcHHSocket_ReconnectInterval;
    if (self.configuration.reConnectInterval > 0) {
        reconnectInterval = self.configuration.reConnectInterval;
    }
    __weak __typeof(self) weakSelf = self;
    _reconnectTimer = [HHTimer timerWithInterval:reconnectInterval handler:^{
        __typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.configuration.autoReconnect){
            [strongSelf _connect];
        }
    }];
}

- (void)initNetWorkObserver{ 
    [[ZFReachabilityManager sharedManager] startMonitoring];
    __weak __typeof(self) weakSelf = self;
    [[ZFReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(ZFReachabilityStatus status) {
         __typeof(weakSelf) strongSelf = weakSelf;

        HHLog(@"ZFReachabilityManager");
        if (status == ZFReachabilityStatusUnknown || status == ZFReachabilityStatusNotReachable) {
            [strongSelf disconnect];
            return ;
        }

        strongSelf.reConnectCount = 0;
        [strongSelf _reConnect];
    }];
}

#pragma mark - Public

//! 断开 socket 连接
- (void)disconnect {
    self.socketStatus = HHSocketStatusClosed;
    
    [_heartBeatTimer stop];
    [_reconnectTimer stop];
    [_socket disconnect];
}

//! 开始连接
- (void)connect {
    // 外部主动调用连接，重连清零
    self.reConnectCount = 0;
    
    [self _connect];
}

//! 发送业务请求
- (HHSocketRequest *)sendCommand:(UInt16)command params:(nullable NSDictionary *)params {
    HHLog(@"来个命令:%d",command);
    
    // 无网络，直接返回
    if (![self _avaliableNetwork]) {
        HHLog(@"没有网络，命令:%d处理不了",command);
        return nil;
    }
    
    // 不是登录命令，不是心跳, 且未登录
    // 先登录，登录失败返回错误
    if (command != self.configuration.handLoginCommand
        && command != self.configuration.heartBeatCommand
        && self.socketStatus < HHSocketStatusLoggedIn) {
        HHLog(@"没有登录，先登录");
        [self sendCommand:self.configuration.handLoginCommand params:self.configuration.handLoginParams];
        return nil;
    }
    
    // 生成task
    NSDictionary* newParams = [self appendDeviceInfoToParams:params];
    HHSocketRequest* request = [[HHSocketRequest alloc] initWithCmd:command params:newParams];
    request.block = [self _taskBlockForRequest:request];
    [self _addRequestTask:request];

    // 执行task
    if (dispatch_get_specific(&kSocketRequestQueueKey)) {
        request.block();
    } else {
        dispatch_async(stock_manager_request_queue(), request.block);
    }
    
    return request;
}

- (void)sendRequest:(HHSocketRequest*)request {
    HHLog(@"来个请求:%d",request.head.command);
    
    // 无网络，直接返回
    if (![self _avaliableNetwork]) {
        HHLog(@"没有网络，命令:%d处理不了",request.head.command);
        return;
    }
    
    // 不是登录命令，不是心跳, 且未登录
    // 先登录，登录失败返回错误
    if (request.head.command != self.configuration.handLoginCommand
        && request.head.command != self.configuration.heartBeatCommand
        && self.socketStatus < HHSocketStatusLoggedIn) {
        HHLog(@"没有登录，先登录");
        [self sendCommand:self.configuration.handLoginCommand params:self.configuration.handLoginParams];
        return;
    }
     
    NSDictionary* newParams = [self appendDeviceInfoToParams:request.params];
    request.params = newParams;
    request.block = [self _taskBlockForRequest:request];
    [self _addRequestTask:request];
    
    if (dispatch_get_specific(&kSocketRequestQueueKey)) {
        request.block();
    } else {
        dispatch_async(stock_manager_request_queue(), request.block);
    }
}

//! 取消请求，已发生的将无法取消
- (void)cancelRequest:(HHSocketRequest *)request {
    __weak __typeof(self) weakSelf = self;
    dispatch_block_t block = dispatch_block_create(DISPATCH_BLOCK_BARRIER, ^{
        __typeof(weakSelf) strongSelf = weakSelf;
        dispatch_block_cancel(request.block);
        [strongSelf _removeRequestTask:request];
    });
    if (dispatch_get_specific(&kSocketRequestQueueKey)) {
        block();
    } else {
        dispatch_async(stock_manager_request_queue(), block);
    }
}

//! 是否可以收发数据
- (BOOL)avaliable {
    // 网络不可用
    if (![self _avaliableNetwork]) {
        return false;
    }
    
    // 还没登录
    if (self.socketStatus < HHSocketStatusLoggedIn) {
        return false;
    }
    
    return true;
}


#pragma mark - GCDAsyncSocketDelegate

//! socket连接成功
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    HHLog(@"socket连接成功[%@]",host);
    self.socketStatus = HHSocketStatusConnected;

    //连接成功次数清零
    self.reConnectCount = 0;
    //重连定时器关闭
    [self.reconnectTimer stop];
    //发起登录
    [self _sendLoginCommand];
    //设置读取相关
    [self.socket readDataToLength:LENGTH_HEAD withTimeout:-1 tag:TAG_READ_HEAD];
    
    if ([self.delegate respondsToSelector:@selector(socket:didConnectToHost:port:)]) {
        [self.delegate socket:sock didConnectToHost:host port:port];
    }
}

//! socket断开连接
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    [self disconnect];
    if ([self.delegate respondsToSelector:@selector(socketDidDisconnect:withError:)]) {
        [self.delegate socketDidDisconnect:sock withError:err];
    }
    
    [self _reConnect];
    HHLog(@"socket连接断开[%@]",err);
}

//! socket发送成功
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    HHLog(@"发送成功:%ld", tag);
}
 
//! socket读取成功
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    static NSData *dataHead = nil;
    if (tag == TAG_READ_HEAD) {
        dataHead = data;
        UInt16 lengthTotal;
        [data getBytes:&lengthTotal range:RANGE_PACKET_LENGTH_5];
        lengthTotal = CFSwapInt16BigToHost(lengthTotal);
        UInt16 lengthBody = lengthTotal - LENGTH_HEAD;

        [sock readDataToLength:lengthBody withTimeout:-1 tag:TAG_READ_BODY];
    }
    else if (tag == TAG_READ_BODY) {
        NSMutableData *mPacketData = [NSMutableData dataWithData:dataHead];
        [mPacketData appendData:data];
        dataHead = nil;
        [self _processResponse:[HHSocketResponse responseFromData:[mPacketData copy]]];

        [sock readDataToLength:LENGTH_HEAD withTimeout:-1 tag:TAG_READ_HEAD];
    }
    else {
        HHLog(@"Socket: DidReadData: withTag: 没有相应的 TAG");
    }
}

////    //看能不能读到这条消息发送成功的回调消息，如果2秒内没收到，则断开连接
////    [gcdSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:2 maxLength:50000 tag:110];
//
////! 貌似触发点
//- (void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag {
//    NSLog(@"读的回调,length:%ld,tag:%ld",partialLength,tag);
//}

//Unix domain socket
//- (void)socket:(GCDAsyncSocket *)sock didConnectToUrl:(NSURL *)url
//{
//    NSLog(@"connect:%@",[url absoluteString]);
//}

// //为上一次设置的读取数据代理续时 (如果设置超时为-1，则永远不会调用到)
//-(NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutReadWithTag:(long)tag elapsed:(NSTimeInterval)elapsed bytesDone:(NSUInteger)length
//{
//    HHLog(@"来延时，tag:%ld,elapsed:%f,length:%ld",tag,elapsed,length);
//    return 10;
//}

#pragma mark - Private

//! 网络是否可用
- (BOOL)_avaliableNetwork {
    ZFReachabilityStatus status = [[ZFReachabilityManager sharedManager] networkReachabilityStatus];
    if (status == ZFReachabilityStatusUnknown || status == ZFReachabilityStatusNotReachable) {
        return false;
    }
    return true;
}
 
//! 重连机制
- (void)_reConnect {
    if (self.reConnectCount > self.configuration.maxReConnectCount || !self.configuration.autoReconnect) {
        return;
    }
    
    self.reConnectCount += 1;
    
    if (!self.reconnectTimer.started) {
        [self.reconnectTimer startImediately];
    }
}

//!  连接
- (void)_connect {
    [self disconnect];
    __weak __typeof(self) weakSelf = self;
    
    dispatch_sync_on_main_queue(^{
        __typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf.configuration.host) {
            strongSelf.configuration.host = kcDXDefaultSocketHost;
        }
        if (strongSelf.configuration.port == 0) {
            strongSelf.configuration.port = kcDXDefaultSocketPort;
        }
        self.socketStatus = HHSocketStatusConnecting;
        [strongSelf.socket connectToHost:strongSelf.configuration.host onPort:strongSelf.configuration.port error:nil];
    });
}

//! 任务数组添加
- (void)_addRequestTask:(HHSocketRequest *)request{
    __weak __typeof(self) weakSelf = self;
    dispatch_block_t block = dispatch_block_create(DISPATCH_BLOCK_BARRIER, ^{
        __typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.requestTasks addObject:request];
    });
    if (dispatch_get_specific(&kSocketTasksQueueKey)) {
        block();
    } else {
        dispatch_async(stock_manager_tasks_queue(), block);
    }
}

//! 任务数组移除
- (void)_removeRequestTask:(HHSocketRequest*)request{
    __weak __typeof(self) weakSelf = self;
    dispatch_block_t block = dispatch_block_create(DISPATCH_BLOCK_BARRIER, ^{
        __typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.requestTasks removeObject:request];
    });
    if (dispatch_get_specific(&kSocketTasksQueueKey)) {
        block();
    } else {
        dispatch_async(stock_manager_tasks_queue(), block);
    }
}

//! 任务包装
- (dispatch_block_t)_taskBlockForRequest:(HHSocketRequest*)request{
    __weak __typeof(self) weakSelf = self;
   return dispatch_block_create(DISPATCH_BLOCK_BARRIER, ^{
        __typeof(weakSelf) strongSelf = weakSelf;
        __block HHSocketStatus currentStatus = HHSocketStatusClosed;
        dispatch_sync_on_main_queue(^{
            currentStatus = strongSelf.socketStatus;
        });
       
        UInt16 command = strongSelf.configuration.handLoginCommand;
        if (currentStatus < HHSocketStatusConnected){
            return;
        } else if (currentStatus == HHSocketStatusConnected){
            if (request.head.command != command) {
                return;
            }
        }
        
        if (request){
            if (strongSelf.configuration.supportedZipType){
                request.head.encryptFlag = strongSelf.configuration.supportedZipType;
            }
            NSData *requestData = [request encodedData];
            [strongSelf.socket writeData:requestData withTimeout:TIMEOUT_WRITE tag:request.head.command * 100000 + request.head.clientID];
        }
    });
}

//! 登录命令发送
- (void)_sendLoginCommand{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSDictionary *handLoginParams = self.configuration.handLoginParams;
    [params addEntriesFromDictionary:handLoginParams];

    if (!self.configuration.handLoginCommand) {
        HHLog(@"没有提供登录命令号!!!");
        [self disconnect];
    } else {
        UInt16 command = self.configuration.handLoginCommand;
        [self sendCommand:command params:[params copy]];
        self.socketStatus = HHSocketStatusLoggingIn;
    }
}

//! 心跳命令发送
- (void)_sendHeartBeat{
    UInt16 command = self.configuration.heartBeatCommand;
    [self sendCommand:command params:nil];
}
 
- (void)_clearupSocket {
    [_heartBeatTimer stop];
    [_socket disconnect];
    _socket = nil;
}

//! 查找request
- (HHSocketRequest *)_findRequestForClientID:(long)clientID{
    __block HHSocketRequest* request;
    __weak __typeof(self) weakSelf = self;
    dispatch_block_t block = dispatch_block_create(DISPATCH_BLOCK_BARRIER, ^{
        __typeof(weakSelf) strongSelf = weakSelf;
        NSInteger index = [strongSelf.requestTasks indexOfObjectPassingTest:^BOOL(HHSocketRequest* obj, NSUInteger idx, BOOL* stop) {
            return (obj.head.clientID == clientID);
        }];
        if (index != NSNotFound) {
            request = self.requestTasks[index];
        }
    });
    if (dispatch_get_specific(&kSocketTasksQueueKey)) {
        block();
    } else {
        dispatch_sync(stock_manager_tasks_queue(), block);
    }
    return request;
}

- (void)_processResponse:(HHSocketResponse*)resp{
    if (resp == nil) {
        return;
    }
     
    HHSocketRequest* request = [self _findRequestForClientID:resp.head.clientID];
    [self _removeRequestTask:request]; 
    UInt16 cmdHeartBeat = [self.configuration heartBeatCommand];
    UInt16 cmdhandLogin = [self.configuration handLoginCommand];
    if (resp.head.command == cmdhandLogin) {
        if (resp.code == 0) {       // 登录成功
            [_heartBeatTimer start];
            self.socketStatus = HHSocketStatusLoggedIn;
        } else {
            self.socketStatus = HHSocketStatusConnected;
        }
    }
    NSArray* ignoreNotificationCMD = @[@(cmdHeartBeat)];
    if (self.configuration.ignoreNotificationCommands != nil
        && self.configuration.ignoreNotificationCommands.count > 0) {
        ignoreNotificationCMD = self.configuration.ignoreNotificationCommands;
    }
    
    if ([ignoreNotificationCMD containsObject:@(resp.head.command)]) {
        return;
    }
    
    // 数据抛给上层处理
    dispatch_sync_on_main_queue(^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(socket:didReceiveResponse:)]) {
            [self.delegate socket:self.socket didReceiveResponse:resp];
        }
    });
}
 
#pragma mark - getter
 
- (NSString *)deviceID {
    return [ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString;
}

- (NSString *)systemInfo {
    UIDevice *device = [UIDevice currentDevice];
    return [NSString stringWithFormat:@"%@ %@", device.systemName, device.systemVersion];
}

- (NSMutableDictionary *)appendDeviceInfoToParams:(NSDictionary *)params {
    NSMutableDictionary *mParams = [[NSMutableDictionary alloc] initWithDictionary:params];
    NSDictionary *commonParams = self.configuration.commonParams;
    if (commonParams){
        [mParams addEntriesFromDictionary:commonParams];
    }
    return mParams;
}

- (NSMutableArray<HHSocketRequest *> *)requestTasks {
    if (!_requestTasks) {
        _requestTasks = [NSMutableArray array];
    }
    return _requestTasks;
}

@end
