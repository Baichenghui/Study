//
//  HHSocketResponse.h
//  GCDAsyncSocketManager
//
//  Created by tianxi on 2019/12/24.
//  Copyright © 2019 hh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
 
@class HHSocketPacketHead;

/// HHSocket 的业务请求的响应描述
@interface HHSocketResponse : NSObject

/// 包头
@property (nonatomic, strong) HHSocketPacketHead *head;

/// 返回的错误码
@property (nonatomic, assign) NSInteger code;

/// 返回的错误信息
@property (nonatomic, copy) NSString *message;

/// 业务错误时的跳转 url
@property (nonatomic, copy) NSString *url;

/// 返回的主体信息，可能值：数组、字典、nil
@property (nonatomic, strong) id info;

//!
@property (nonatomic, strong) id originData;

/// 初始化方法. Designed.
- (instancetype)initWithHead:(HHSocketPacketHead *)head code:(NSInteger)code message:(NSString *)message;

/// 包解码
+ (instancetype)responseFromData:(NSData *)respData;

@end

NS_ASSUME_NONNULL_END
