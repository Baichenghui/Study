//
//  ViewController.m
//  GCDAsyncSocketManager
//
//  Created by tianxi on 2019/12/24.
//  Copyright © 2019 hh. All rights reserved.
//

#import "ViewController.h"
#import "HHSocketManager.h"
#import <AdSupport/AdSupport.h>
#import <CommonCrypto/CommonCrypto.h>

@interface ViewController ()<HHSocketDelegate>
@property (nonatomic,strong) HHSocketManager *socketManager;

@property (nonatomic,assign) CFTimeInterval startTimeInterval;
@property (nonatomic,assign) CFTimeInterval endTimeInterval;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.socketManager = [[HHSocketManager alloc] initWithConfiguration:[HHSocketConfiguration defaultConfiguration]];
    self.socketManager.delegate = self;
  
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.startTimeInterval = CACurrentMediaTime();
    for (int i = 0; i < 1; i++) {
        /*
        info =     (
            "SH.600519",
            "SZ.000001",
            "SH.601318"
        );
        */
        [self.socketManager sendCommand:15016 params:@{@"info":@[@"SH.600519",@"SZ.000001",@"SH.601318"]}];
    }
}

#pragma mark - HHSocketDelegate
 
/// socket 收到了响应，errorCode == resp.code
- (void)socket:(GCDAsyncSocket *)socket didReceiveResponse:(HHSocketResponse *)resp {
//    HHLog(@"socket 收到了响应 resp:%@", resp);
    HHLog(@"socket 收到了响应 resp");
    
    self.endTimeInterval = CACurrentMediaTime();
    NSLog(@"s1 endTimeInterval - startTimeInterval:%f",self.endTimeInterval - self.startTimeInterval);
}

/// 链接
- (void)socket:(GCDAsyncSocket *)socket didConnectToHost:(NSString *)host port:(uint16_t)port {
    HHLog(@"连接成功");
}

/// 断开链接
- (void)socketDidDisconnect:(GCDAsyncSocket *)socket withError:(NSError *)err {
    HHLog(@"断开连接");
}
  
@end
