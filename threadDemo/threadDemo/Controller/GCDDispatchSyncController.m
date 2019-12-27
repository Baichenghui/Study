//
//  GCDDispatchSyncController.m
//  threadDemo
//
//  Created by tianxi on 2019/12/18.
//  Copyright © 2019 hh. All rights reserved.
//

#import "GCDDispatchSyncController.h"
#import <pthread.h>

@interface GCDDispatchSyncController ()

@end

@implementation GCDDispatchSyncController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
//    [self test1];
//    [self test2];
    
    [self test3];
}

#pragma mark - 应用
 
/**
 YYKit库中，在SDWebImage中也有类似的应用
  
 用于确保任务在主线程下执行
 */
static inline void _yy_dispatch_sync_on_main_queue(void (^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}


/**
 AFNetworking库中
 
 AFURLSessionManager 中session创建时用到：
    由于session创建在iOS8之前是线程不安全的，所以使用同步+串行队列实现锁的功能
 
 注意：当前队列与同步函数中任务的队列不是一个队列
 */
//    static void url_session_manager_create_task_safely(dispatch_block_t block) {
//        if (NSFoundationVersionNumber < NSFoundationVersionNumber_With_Fixed_5871104061079552_bug) {
//            // Fix of bug
//            // Open Radar:http://openradar.appspot.com/radar?id=5871104061079552 (status: Fixed in iOS8)
//            // Issue about:https://github.com/AFNetworking/AFNetworking/issues/2093
//            dispatch_sync(url_session_manager_creation_queue(), block);
//        } else {
//            block();
//        }
//    }


#pragma mark - test

/*
 同步+并发  不会开启新线程，依旧在当前线程执行任务
 */
- (void)test3 {
    dispatch_queue_t queue = dispatch_queue_create("syncConcrrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        NSLog(@"1 %@", [NSThread currentThread]);
    });
    
    /*
     2019-12-20 16:22:30.890416+0800 threadDemo[30526:6608103] 1 <NSThread: 0x600001b9c680>{number = 1, name = main}
     */
}

/**
 GCDSerialQueueController 串行队列的时候已分析
 
 如果使用 dispatch_sync 函数在当前串行队列中添加任务，会卡住当前串行队列
 */
- (void)test2 {
    // dispatch_async 开启的新线程，在队列 queue 中 ，往queue队列添加同步任务执行，线程卡死
    dispatch_queue_t queue = dispatch_queue_create("asyncSerial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
          
        //Thread 3: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)
        dispatch_sync(queue, ^{
            NSLog(@"1 %@", [NSThread currentThread]);
        });
    });
}


/**
 如果使用 dispatch_sync 函数在当前串行队列中添加任务，会卡住当前串行队列
 */
- (void)test1 {
    //在主线程中，往主队列添加同步任务执行，线程卡死
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    //Thread 1: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)
    dispatch_sync(queue, ^{
        NSLog(@"1 %@", [NSThread currentThread]);
    });
}

@end
