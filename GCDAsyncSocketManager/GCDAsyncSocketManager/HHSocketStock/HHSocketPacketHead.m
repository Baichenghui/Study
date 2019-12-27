//
//  HHSocketPacketHead.m
//  GCDAsyncSocketManager
//
//  Created by tianxi on 2019/12/24.
//  Copyright © 2019 hh. All rights reserved.
//

#import "HHSocketPacketHead.h"
#import "HHSocketDefine.h"

@implementation HHSocketPacketHead

/// 计算CRC（服务端指定算法）
+ (UInt16)NtPkgHead2Crc16:(const UInt32 *)pdwBuf
{
    UInt32 dwCrc = 0;
    dwCrc ^= *pdwBuf++;
    dwCrc ^= *pdwBuf++;
    dwCrc ^= *pdwBuf++;
    dwCrc ^= *pdwBuf++;
    dwCrc ^= *pdwBuf++;
    return (UInt16)((dwCrc & 0xffff) ^ (dwCrc >> 16));
}

- (NSMutableData *)encodedData {
    self.crc = 0; // 初始 CRC 为 0
    
    NSMutableData *mData = [[NSMutableData alloc] initWithLength:LENGTH_HEAD];
    
    [self data:mData replaceInt8:self.startFlag inRange:RANGE_START_FLAG_1];
    [self data:mData replaceInt8:self.version inRange:RANGE_VERSION_2];
    [self data:mData replaceInt8:self.encryptFlag inRange:RANGE_ENCRYPT_FLAG_3];
    [self data:mData replaceInt8:self.multipacketFlag inRange:RANGE_MULTIPACKET_FLAG_4];
    [self data:mData replaceInt16:self.packetLength inRange:RANGE_PACKET_LENGTH_5];
    [self data:mData replaceInt16:self.command inRange:RANGE_COMMAND_6];
    [self data:mData replaceInt16:self.clientID inRange:RANGE_CLIENT_ID_7];
    [self data:mData replaceInt16:self.crc inRange:RANGE_CRC_8];
    [self data:mData replaceInt32:self.sessionID inRange:RANGE_SESSION_ID_9];
    [self data:mData replaceInt16:self.packetCount inRange:RANGE_PACKET_COUNT_10];
    [self data:mData replaceInt16:self.packetSequence inRange:RANGE_PACKET_SEQUENCE_11];
    
    // 重新生成包头的 CRC16 校验值（CRC 初始为 0）
    UInt16 crcCalculated = [self.class NtPkgHead2Crc16:(UInt32*)mData.bytes];
    [self data:mData replaceInt16:crcCalculated inRange:RANGE_CRC_8];
    
    return mData;
}

- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        self.startFlag = [self Int8InData:data range:RANGE_START_FLAG_1];
        self.version = [self Int8InData:data range:RANGE_VERSION_2];
        self.encryptFlag = [self Int8InData:data range:RANGE_ENCRYPT_FLAG_3];
        self.multipacketFlag = [self Int8InData:data range:RANGE_MULTIPACKET_FLAG_4];
        self.packetLength = [self Int16InData:data range:RANGE_PACKET_LENGTH_5];
        self.command = [self Int16InData:data range:RANGE_COMMAND_6];
        self.clientID = [self Int16InData:data range:RANGE_CLIENT_ID_7];
        self.crc = [self Int16InData:data range:RANGE_CRC_8];
        self.sessionID = [self Int32InData:data range:RANGE_SESSION_ID_9];
        self.packetCount = [self Int16InData:data range:RANGE_PACKET_COUNT_10];
        self.packetSequence = [self Int16InData:data range:RANGE_PACKET_SEQUENCE_11];
    }
    return self;
}

-(BOOL)isNextOneForPreviousHead:(HHSocketPacketHead *)pHead {
    if (self.clientID == pHead.clientID && self.packetSequence == pHead.packetSequence + 1) {
        return YES;
    }
    return NO;
}

// MARK: - Private Methods - head encode

- (void)data:(NSMutableData *)mData replaceInt8:(UInt8)value inRange:(NSRange)range {
    [mData replaceBytesInRange:range withBytes:&value];
}

- (void)data:(NSMutableData *)mData replaceInt16:(UInt16)value inRange:(NSRange)range {
    UInt16 bigValue = CFSwapInt16HostToBig(value);
    [mData replaceBytesInRange:range withBytes:&bigValue];
}

- (void)data:(NSMutableData *)mData replaceInt32:(UInt32)value inRange:(NSRange)range {
    UInt32 bigValue = CFSwapInt32HostToBig(value);
    [mData replaceBytesInRange:range withBytes:&bigValue];
}

// MARK: - Private Methods - head decode

- (UInt8)Int8InData:(NSData *)data range:(NSRange)range {
    UInt8 value;
    [data getBytes:&value range:range];
    return value;
}

- (UInt16)Int16InData:(NSData *)data range:(NSRange)range {
    UInt16 value;
    [data getBytes:&value range:range];
    value = CFSwapInt16BigToHost(value);
    return value;
}

- (UInt32)Int32InData:(NSData *)data range:(NSRange)range {
    UInt32 value;
    [data getBytes:&value range:range];
    value = CFSwapInt32BigToHost(value);
    return value;
}

@end
