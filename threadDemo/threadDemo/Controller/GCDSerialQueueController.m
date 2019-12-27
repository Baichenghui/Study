//
//  GCDSerialQueueController.m
//  threadDemo
//
//  Created by tianxi on 2019/12/18.
//  Copyright © 2019 hh. All rights reserved.
//

#import "GCDSerialQueueController.h"

@interface GCDSerialQueueController ()

@end

@implementation GCDSerialQueueController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
//    [self test1];
    [self test2];
//    [self test3];
}
  
#pragma mark - test

/**
 自定义串行队列
 
 异步执行，开启新线程
 */
- (void)test3 {
    dispatch_queue_t queue = dispatch_queue_create("asyncSerial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"test3 %@", [NSThread currentThread]);
    });
    /*
     2019-12-20 09:30:49.599224+0800 threadDemo[11311:6395891] test3 <NSThread: 0x60000342e600>{number = 6, name = (null)}
     */
}

/**
 自定义串行队列

 同步执行，不会开启新线程
 
 注意：当前队列与同步函数中任务的队列不是一个队列，否则会死锁
 */
- (void)test2 {
    dispatch_queue_t queue = dispatch_queue_create("syncSerial", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"test2 %@", [NSThread currentThread]);
    });
    
    /*
     2019-12-20 09:30:49.598920+0800 threadDemo[11311:6395735] test2 <NSThread: 0x600003452140>{number = 1, name = main}
     */
}

/**
 如果使用 dispatch_sync 函数在当前串行队列中添加任务，会卡住当前串行队列
 */
- (void)test1 {
    // dispatch_async 开启的新线程，在队列 queue 中 ，往queue队列添加同步任务执行，线程卡死
    dispatch_queue_t queue = dispatch_queue_create("asyncSerial", DISPATCH_QUEUE_SERIAL);
    
    
    dispatch_async(queue, ^{ 
        NSLog(@"test1 start%@", [NSThread currentThread]);
        //Thread 3: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)
        dispatch_sync(queue, ^{
            NSLog(@"test1 %@", [NSThread currentThread]);
        });
        
        NSLog(@"test1 end%@", [NSThread currentThread]);
    });
    
    /*
     2019-12-20 09:56:54.932893+0800 threadDemo[11409:6405262] test1 start<NSThread: 0x600002235e40>{number = 5, name = (null)}
     
     只打印了第一条。后面出现线程死锁了。
     
     卡住原因：
        1、串行队列，任务需要一个任务执行完毕接着下一个才执行
        2、现在队列queue要执行 dispatch_sync 函数添加一个同步任务block
        3、dispatch_sync 是同步的，需要将添加的任务block立即执行
        4、此时调用 dispatch_sync 函数所在线程处于等待状态，需要block任务执行才继续往后执行，而执行 dispatch_sync 函数的线程与block执行所在线程是同一个线程，所以这个线程一直处于等待状态。不会往后执行，也不会执行block。
     */
}

@end
