//
//  HHSocketManager.h
//  GCDAsyncSocketManager
//
//  Created by tianxi on 2019/12/24.
//  Copyright © 2019 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaAsyncSocket/GCDAsyncSocket.h>
#import "HHSocketConfiguration.h"
#import "HHSocketResponse.h"
#import "HHSocketRequest.h"
#import "HHSocketPacketHead.h"

NS_ASSUME_NONNULL_BEGIN
 
@class HHSocketManager;
@protocol HHSocketDelegate <NSObject>
 
/// socket 收到了响应，errorCode == resp.code
- (void)socket:(GCDAsyncSocket *)socket didReceiveResponse:(HHSocketResponse *)resp;
/// 链接
- (void)socket:(GCDAsyncSocket *)socket didConnectToHost:(NSString *)host port:(uint16_t)port;
/// 断开链接
- (void)socketDidDisconnect:(GCDAsyncSocket *)socket withError:(NSError *)err;

@end
 
@interface HHSocketManager : NSObject

@property (nonatomic, weak) id <HHSocketDelegate> delegate;

@property (nonatomic, strong, readonly) HHSocketConfiguration *configuration;

@property (nonatomic, assign, readonly) HHSocketStatus socketStatus; 

- (instancetype)initWithConfiguration:(nonnull HHSocketConfiguration *) configuration;

//! 是否可以收发数据
- (BOOL)avaliable;
 
//! 断开 socket 连接
- (void)disconnect;
//! 开始连接
- (void)connect;

//! 发送业务请求
- (HHSocketRequest *)sendCommand:(UInt16)command params:(nullable NSDictionary *)params;

- (void)sendRequest:(HHSocketRequest*)request;

//! 取消所有请求，已发生的将无法取消
- (void)cancelRequest:(HHSocketRequest*)request;


@end

NS_ASSUME_NONNULL_END
