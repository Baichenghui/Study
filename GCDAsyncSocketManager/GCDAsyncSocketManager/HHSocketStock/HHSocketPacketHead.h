//
//  HHSocketPacketHead.h
//  GCDAsyncSocketManager
//
//  Created by tianxi on 2019/12/24.
//  Copyright © 2019 hh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN 

/// socket 包头，可以是请求头，也可以是响应头
@interface HHSocketPacketHead : NSObject

/// 协议包起始标志 0xFF
@property (nonatomic, assign) UInt8   startFlag;

/// 版本号
@property (nonatomic, assign) UInt8   version;

/// 加密标志(0-代表不加密，6-代表加密)
@property (nonatomic, assign) UInt8   encryptFlag;

/// 分包标志(1-分包，0-不分包)
@property (nonatomic, assign) UInt8   multipacketFlag;

/// 总包长，包头 + 包体 的总长
@property (nonatomic, assign) UInt16  packetLength;

/// 命令号
@property (nonatomic, assign) UInt16  command;

/// 请求的客户端ID
@property (nonatomic, assign) UInt16  clientID;

/// Crc16校验码
@property (nonatomic, assign) UInt16  crc;

/// 会话ID
@property (nonatomic, assign) UInt32  sessionID;

/// 分包时，包的总数
@property (nonatomic, assign) UInt16  packetCount;

/// 分包时，包的序号
@property (nonatomic, assign) UInt16  packetSequence;

/// 包头编码
- (NSMutableData *)encodedData;

/// 包头解码
- (instancetype)initWithData:(NSData *)data;

/// 包序判断
- (BOOL)isNextOneForPreviousHead:(HHSocketPacketHead *)previousHead;

/// 计算CRC（服务端指定算法）
+ (UInt16)NtPkgHead2Crc16:(const UInt32 *)pdwBuf;


@end

NS_ASSUME_NONNULL_END
