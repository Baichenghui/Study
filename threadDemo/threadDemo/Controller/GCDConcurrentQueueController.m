//
//  GCDConcurrentQueueController.m
//  threadDemo
//
//  Created by tianxi on 2019/12/18.
//  Copyright © 2019 hh. All rights reserved.
//

#import "GCDConcurrentQueueController.h"

@interface GCDConcurrentQueueController ()

@end

@implementation GCDConcurrentQueueController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self test1];
    
    [self test2];
}

#pragma mark - test

/**
 自定义并发队列,  可以多个任务并发执行
 
 异步执行，开启新线程
 */
- (void)test2 {
    dispatch_queue_t queue = dispatch_queue_create("asyncConcurrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"test2 %@", [NSThread currentThread]);
    });
    /*
      2019-12-20 10:18:37.836157+0800 threadDemo[11552:6414791] test2 <NSThread: 0x600001108300>{number = 6, name = (null)}
     */
}

/**
 自定义并发队列,  可以多个任务并发执行

 同步执行，不会开启新线程
 
 注意：当前队列与同步函数中任务的队列不是一个队列，否则会死锁
 */
- (void)test1 {
    dispatch_queue_t queue = dispatch_queue_create("syncConcurrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        NSLog(@"test1 %@", [NSThread currentThread]);
    });
    
    /*
      2019-12-20 10:18:37.835964+0800 threadDemo[11552:6414692] test1 <NSThread: 0x60000117cbc0>{number = 1, name = main}
     */
}
 
@end
