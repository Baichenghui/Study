//
//  HHSocketRequest.h
//  GCDAsyncSocketManager
//
//  Created by tianxi on 2019/12/24.
//  Copyright © 2019 hh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
 
@class HHSocketPacketHead;

/// HHSocket 的业务请求的描述
@interface HHSocketRequest : NSObject

//! 包头
@property (nonatomic, strong) HHSocketPacketHead *head;
//! 请求参数
@property (nonatomic, copy) NSDictionary *params;
//! 应该的执行时间
@property (nonatomic, copy) NSDate *fireDate;

//! GCD-block
@property (nonatomic, copy) dispatch_block_t block;

//! 初始化方法. Designed. cliendID 在这里生成.
- (instancetype)initWithCmd:(UInt16)command params:(NSDictionary *)params;
//! 请求的数据编码, 取前请先初始化
- (NSData *)encodedData;

@end

NS_ASSUME_NONNULL_END
