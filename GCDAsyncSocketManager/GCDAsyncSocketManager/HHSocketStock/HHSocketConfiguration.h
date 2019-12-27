//
//  HHSocketConfiguration.h
//  GCDAsyncSocketManager
//
//  Created by tianxi on 2019/12/25.
//  Copyright © 2019 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHSocketDefine.h"

NS_ASSUME_NONNULL_BEGIN

/**
  socke manager 配置文件
 
 由于这些设置，初始设置好之后不会再器变化，所以使用时作为属性即可。
 若经常动态变化，考虑将该类作为数据源返回。
 */
@interface HHSocketConfiguration : NSObject

+ (instancetype)defaultConfiguration;

// 登录参数
+ (nonnull NSDictionary*)loginParams;

// 域名
@property (nonatomic, copy, nonnull) NSString *host;
// 端口号
@property (nonatomic, assign) UInt16 port;
// 心跳命令
@property (nonatomic, assign) UInt16 heartBeatCommand;
// 登录命令 
@property (nonatomic, assign) UInt16 handLoginCommand;
// 登录参数
@property (nonatomic, strong, nonnull) NSDictionary *handLoginParams;
// 超时时间, 超时会关闭 socket（-1 一直不超时）
@property (nonatomic, assign) NSTimeInterval timeOut;
// iOS
@property (nonatomic, copy, nonnull) NSString *channel;
// 自动重连次数（默认3次）
@property (nonatomic, assign) NSUInteger maxReConnectCount;

// 下面的参数非必须配置

// 通用参数配置
@property (nonatomic, strong, nullable) NSDictionary *commonParams;
// 不需要广播出来的命令 默认心跳&登录
@property (nonatomic, strong, nullable) NSArray<NSNumber*> *ignoreNotificationCommands;
// 心跳时间间隔
@property (nonatomic, assign) NSTimeInterval heartBeatInterval;
// 重连时间间隔
@property (nonatomic, assign) NSTimeInterval reConnectInterval;
// 压缩方式
@property (nonatomic, assign) HHSocketZipType supportedZipType;
// 是否自动重连
@property (nonatomic, assign) BOOL autoReconnect;

// log 打印开关(暂不起作用)
@property (nonatomic, assign, getter=isEnableLog) BOOL enableLog;

@end

NS_ASSUME_NONNULL_END
