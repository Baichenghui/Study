//
//  HHSocketRequest.m
//  GCDAsyncSocketManager
//
//  Created by tianxi on 2019/12/24.
//  Copyright © 2019 hh. All rights reserved.
//

#import "HHSocketRequest.h"
#import "HHSocketPacketHead.h"
#import "HHSocketDefine.h"

@implementation HHSocketRequest

/// 初始化方法. Designed.
- (instancetype)initWithCmd:(UInt16)command params:(NSDictionary *)params {
    self = [super init];
    if (self) {
        HHSocketPacketHead *head = [HHSocketPacketHead new];
        head.startFlag = 0xFF;
        head.command = command;
        head.clientID = [self.class nextClientID];

        self.head = head;
        self.params = params;
    }
    return self;
}

/// 请求的数据编码
- (NSData *)encodedData {

    
    NSData *bodyData = nil;
    if (self.params != nil) {
        NSError *error = nil;
        bodyData = [NSJSONSerialization dataWithJSONObject:self.params options:NSJSONWritingPrettyPrinted error:&error];
        if (error) {
//            dxsc_outputLog(@"Socket Message Serialization error: %@", error.localizedDescription);
            return nil;
        }
    }
    self.head.packetLength = (UInt16)(LENGTH_HEAD + bodyData.length);
    
    // 包头编码
    NSMutableData *mData = [self.head encodedData];
    // 添加包体
    [mData appendData:bodyData];
    
//    dxsc_outputLog(@"发送 --> 命令号:%d, 压缩类型:%d", self.head.command, self.head.encryptFlag);
    return [mData copy];
}

// MARK: - Private Methods

+ (UInt16)nextClientID {
    static dispatch_semaphore_t lock;
    static UInt16 clientID = 0;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lock = dispatch_semaphore_create(1);
    });
    
    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
    clientID += 1;
    dispatch_semaphore_signal(lock);
    
    return clientID;
}

@end
