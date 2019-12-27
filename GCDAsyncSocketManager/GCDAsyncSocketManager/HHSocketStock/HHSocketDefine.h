//
//  HHSocketDefine.h
//  GCDAsyncSocketManager
//
//  Created by tianxi on 2019/12/24.
//  Copyright © 2019 hh. All rights reserved.
//

#ifndef HHSocketDefine_h
#define HHSocketDefine_h

#import <pthread.h>

typedef NS_ENUM(NSUInteger, HHSocketZipType) {
    HHSocketZipTypeNone = 48,       // 字符0
    HHSocketZipTypeGZip = 49,       // 字符1
    HHSocketZipTypeZLib = 50,       // 字符2
};

typedef NS_ENUM(NSUInteger, HHSocketStatus) {
    HHSocketStatusClosed = 0,   // 已关闭
    HHSocketStatusConnecting,   // 正在连接
    HHSocketStatusConnected,    // 已连接但未登录
    HHSocketStatusLoggingIn,    // 正在登录
    HHSocketStatusLoggedIn,     // 已登录
};
    
#define TAG_READ_HEAD    -601
#define TAG_READ_BODY    -602
#define TAG_WRITE_DATA   -603

#define RANGE_HEAD                NSMakeRange(0, 20)
#define RANGE_START_FLAG_1        NSMakeRange(0, 1)
#define RANGE_VERSION_2           NSMakeRange(1, 1)
#define RANGE_ENCRYPT_FLAG_3      NSMakeRange(2, 1)
#define RANGE_MULTIPACKET_FLAG_4  NSMakeRange(3, 1)
#define RANGE_PACKET_LENGTH_5     NSMakeRange(4, 2)
#define RANGE_COMMAND_6           NSMakeRange(6, 2)
#define RANGE_CLIENT_ID_7         NSMakeRange(8, 2)
#define RANGE_CRC_8               NSMakeRange(10, 2)
#define RANGE_SESSION_ID_9        NSMakeRange(12, 4)
#define RANGE_PACKET_COUNT_10     NSMakeRange(16, 2)
#define RANGE_PACKET_SEQUENCE_11  NSMakeRange(18, 2)
 
#ifdef DEBUG
#define HHLog(format, ...) NSLog((@"com.stock.socket" format), ## __VA_ARGS__)
#else
#define HHLog(...)
#endif

static NSUInteger const kMaxReConnectCount = 3;//重连次数
static NSUInteger const DXCommandPing = 3101; // 心跳包
static NSUInteger const DXCommandLogin = 8888; // 登录请求

static NSUInteger const TIMEOUT_WRITE  = 7;// 写超时时间
static NSUInteger const LENGTH_HEAD = 20;

static NSString * const kcSocketConnectKey = @"xxxx";//登录时带的参数
static NSString * const kcDXDefaultSocketHost = @"xxxx";//填写正确的host
static UInt16 const     kcDXDefaultSocketPort = 0000;//填写正确的端口号
static NSString * const kcHHSocket_DefaultChannel = @"iOS";

// 心跳间隔时间
static NSTimeInterval const kcHHSocket_HeartBeatInterval = 20;
// 重连间隔时间
static NSTimeInterval const kcHHSocket_ReconnectInterval = 60;
 
/**
 YYKit库中，在SDWebImage中也有类似的应用
  
 用于确保任务在主线程下执行
 */
static inline void dispatch_sync_on_main_queue(void (^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
} 

#endif /* HHSocketDefine_h */
