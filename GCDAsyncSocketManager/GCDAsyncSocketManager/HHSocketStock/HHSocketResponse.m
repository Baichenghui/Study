//
//  HHSocketResponse.m
//  GCDAsyncSocketManager
//
//  Created by tianxi on 2019/12/24.
//  Copyright © 2019 hh. All rights reserved.
//

#import "HHSocketResponse.h"
#import "HHSocketDefine.h"
#import "NSData+HHSocket.h"

#import "HHSocketPacketHead.h"

@implementation HHSocketResponse

/// 初始化方法. Designed.
- (instancetype)initWithHead:(HHSocketPacketHead *)head code:(NSInteger)code message:(NSString *)message {
    self = [super init];
    if (self) {
        self.head = head;
        self.code = code;
        self.message = message;
    }
    return self;
}

+ (instancetype)responseFromData:(NSData *)respData {
    // decode head data
    HHSocketPacketHead *currentHead = [[HHSocketPacketHead alloc] initWithData:respData];
    
    // 取出服务端给的 crc 值
    UInt16 crcReceived = currentHead.crc;
    
    // 重设 crc 值后计算包头的 crc 值
    NSMutableData *mHeadDataBig = [[respData subdataWithRange:RANGE_HEAD] mutableCopy];
    [mHeadDataBig resetBytesInRange:RANGE_CRC_8];
    UInt16 crcCalculated = [HHSocketPacketHead NtPkgHead2Crc16:(UInt32 *)mHeadDataBig.bytes];
    
    // 两个 crc 值比较
    if (crcReceived != crcCalculated) {
        HHLog(@"Socket 响应的 CRC 校验失败");
        return nil;
    }
    
    NSData *bodyData = [respData subdataWithRange:NSMakeRange(LENGTH_HEAD, respData.length - LENGTH_HEAD)];
    NSData *finalBodyData = [self finalBodyDataWithHead:currentHead bodyData:bodyData];
    HHSocketResponse *resp = [self finalResponseWithHead:currentHead finalBodyData:finalBodyData];
    return resp;
    
}

+ (HHSocketResponse *)finalResponseWithHead:(HHSocketPacketHead *)currentHead finalBodyData:(NSData *)bodyData {
    if (bodyData == nil) {
        return nil;
    }
    
    HHSocketResponse *resp = [HHSocketResponse new];
    resp.head = currentHead;
    resp.head.multipacketFlag = 0;
    resp.head.crc = 0;
    resp.head.packetCount = 0;
    resp.head.packetSequence = 0;

    [self decodeBody:bodyData toResponse:resp];
    
    return resp;
}

+ (void)decodeBody:(NSData *)bodyData toResponse:(HHSocketResponse *)resp {
    if (bodyData == nil) {
        return;
    }
    
    NSData* data = bodyData;
    switch (resp.head.encryptFlag){
        case HHSocketZipTypeGZip:
            data = [bodyData gzipInflate];
            break;
        case HHSocketZipTypeZLib:
            data = [bodyData zlibInflate];
            break;
    }
    NSError *error = nil;
    id JSONObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) { 
        return;
    }
    if ([JSONObject isKindOfClass:[NSDictionary class]] == NO) {
        HHLog(@"Socket 返回的不是字典");
        return;
    }
    NSDictionary *dict = (NSDictionary *)JSONObject;

    resp.code = [dict[@"ret"] integerValue] | [dict[@"code"] integerValue];
    resp.message = [NSString stringWithFormat:@"%@", dict[@"msg"]];
    resp.url = [NSString stringWithFormat:@"%@", dict[@"url"]];
    resp.info = dict[@"info"];
    
    resp.originData = [JSONObject copy];
}

 /// 半包返回 nil
+ (NSData *)finalBodyDataWithHead:(HHSocketPacketHead *)currentHead bodyData:(NSData *)currentBodyData {
    // 合包
    static HHSocketPacketHead *lastHead = nil;
    static NSMutableData *mBodyData = nil;
     
    if (currentHead.multipacketFlag == 1) { // 分包
        
        if (currentHead.packetSequence == 0) { // 分包的首包，初始化 static 对象
            lastHead = currentHead;
            mBodyData = [[NSMutableData alloc] initWithData:currentBodyData];
            return nil;
        }
        else {
            // 非分包的首包
            if ([currentHead isNextOneForPreviousHead:lastHead]) {
                // 顺序包合并
                [mBodyData appendData:currentBodyData];
                if (currentHead.packetSequence == currentHead.packetCount - 1) {
                    // 分包的末包
                    NSData *retData = [mBodyData copy];
                    lastHead = nil;
                    mBodyData = nil;
                    
                    return retData;
                }
                else {
                    // 分包的中间包
                    lastHead.packetSequence = currentHead.packetSequence;
                    return nil;
                }
            }
            else {
                // 乱序包直接丢弃；服务端不乱序，客户端接收到的就不会乱序
                lastHead = nil;
                mBodyData = nil;
                return nil;
            }
        }
        
    }
    else {
        // 不分包
        lastHead = nil;
        mBodyData = nil;
        
        return currentBodyData;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"head:%@ \n code:%ld \n message:%@ \n url:%@ \n info:%@ \n originData:%@ \n",_head,(long)_code,_message,_url,_info,_originData];
}

@end
