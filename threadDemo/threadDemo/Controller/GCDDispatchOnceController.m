//
//  GCDDispatchOnceController.m
//  threadDemo
//
//  Created by tianxi on 2019/12/18.
//  Copyright © 2019 hh. All rights reserved.
//

#import "GCDDispatchOnceController.h"
#import "TDManager.h"

@interface GCDDispatchOnceController ()

@end

/*
 简介：
    dispatch_once能保证任务只会被执行一次，同时多线程调用也是线程安全的。
 
 底层实现：
    dispatch_once用原子性操作block执行完成标记位，同时用信号量确保只有一个线程执行block，等block执行完再唤醒所有等待中的线程。

 应用：
    dispatch_once 常被用于创建单例；另外在第三方库AFNetworking中用来创建一些队列等操作。
 */

@implementation GCDDispatchOnceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self test1];
}

#pragma mark - 应用

/*
 AFNetworking 库中
 
 创建队列
 1、用到时才创建
 2、确保只要创建一次
 3、需要线程安全
 综上原因，使用 dispatch_once 是最优选择
 
 */
//static dispatch_queue_t url_session_manager_processing_queue() {
//    static dispatch_queue_t af_url_session_manager_processing_queue;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        af_url_session_manager_processing_queue = dispatch_queue_create("com.alamofire.networking.session.manager.processing", DISPATCH_QUEUE_CONCURRENT);
//    });
//
//    return af_url_session_manager_processing_queue;
//}

/**
 单利
 */
- (void)test1 {
    TDManager *manager1 = [TDManager shareManager];
    TDManager *manager2 = [TDManager new];
    TDManager *manager3 = [[TDManager alloc] init];
    TDManager *manager4 = [manager1 copy];
    TDManager *manager5 = [manager1 mutableCopy];
    
    NSLog(@"manager1:%p",manager1);
    NSLog(@"manager2:%p",manager2);
    NSLog(@"manager3:%p",manager3);
    NSLog(@"manager4:%p",manager4);
    NSLog(@"manager5:%p",manager5);
    
    /*
     打印内存地址都一致，起到了单利效果
     
     2019-12-20 17:00:15.974273+0800 threadDemo[30701:6628246] manager1:0x6000021d68b0
     2019-12-20 17:00:15.974428+0800 threadDemo[30701:6628246] manager2:0x6000021d68b0
     2019-12-20 17:00:15.974544+0800 threadDemo[30701:6628246] manager3:0x6000021d68b0
     2019-12-20 17:00:15.974634+0800 threadDemo[30701:6628246] manager4:0x6000021d68b0
     2019-12-20 17:00:15.974714+0800 threadDemo[30701:6628246] manager5:0x6000021d68b0
     */
}

@end
