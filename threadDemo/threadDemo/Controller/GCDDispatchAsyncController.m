//
//  GCDDispatchAsyncController.m
//  threadDemo
//
//  Created by tianxi on 2019/12/18.
//  Copyright © 2019 hh. All rights reserved.
//

#import "GCDDispatchAsyncController.h"

@interface GCDDispatchAsyncController ()

@end

@implementation GCDDispatchAsyncController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
     
     [self test1];
     [self test2]; 
}
 
 
/*
 除主队列外，异步执行任务，都会开启新线程
 */
- (void)test2 {
    dispatch_queue_t queue1= dispatch_queue_create("asyncSerial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue1, ^{ NSLog(@"1-1 %@", [NSThread currentThread]); });
    dispatch_async(queue1, ^{ NSLog(@"1-2 %@", [NSThread currentThread]); });
    dispatch_async(queue1, ^{ NSLog(@"1-3 %@", [NSThread currentThread]); });
    
    /**
        2019-12-18 11:53:59.972777+0800 threadDemo[4656:5507191] 1 <NSThread: 0x6000012fd380>{number = 3, name = (null)}
        2019-12-18 11:53:59.973284+0800 threadDemo[4656:5507191] 2 <NSThread: 0x6000012fd380>{number = 3, name = (null)}
        2019-12-18 11:53:59.973437+0800 threadDemo[4656:5507191] 3 <NSThread: 0x6000012fd380>{number = 3, name = (null)}
     */
     
//    dispatch_queue_t queue2 = dispatch_queue_create("asyncConcurrent", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue2, ^{ NSLog(@"2-1 %@", [NSThread currentThread]); });
//    dispatch_async(queue2, ^{ NSLog(@"2-2 %@", [NSThread currentThread]); });
//    dispatch_async(queue2, ^{ NSLog(@"2-3 %@", [NSThread currentThread]); });
    
    /**
     2019-12-18 11:57:09.136050+0800 threadDemo[4686:5509014] 2-2 <NSThread: 0x600002350000>{number = 6, name = (null)}
     2019-12-18 11:57:09.136154+0800 threadDemo[4686:5509013] 2-1 <NSThread: 0x60000237bd00>{number = 5, name = (null)}
     2019-12-18 11:57:09.136174+0800 threadDemo[4686:5509015] 2-3 <NSThread: 0x60000237b480>{number = 4, name = (null)}
     */
}
 
/*
 在主队列，异步执行任务，不会开启新线程
 */
- (void)test1 {
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{ NSLog(@"1 %@", [NSThread currentThread]); });
    dispatch_async(queue, ^{ NSLog(@"2 %@", [NSThread currentThread]); });
    dispatch_async(queue, ^{ NSLog(@"3 %@", [NSThread currentThread]); });
    
    /**
        2019-12-18 11:50:33.358149+0800 threadDemo[4613:5504490] 1 <NSThread: 0x600001cde1c0>{number = 1, name = main}
        2019-12-18 11:50:33.358549+0800 threadDemo[4613:5504490] 2 <NSThread: 0x600001cde1c0>{number = 1, name = main}
        2019-12-18 11:50:33.358696+0800 threadDemo[4613:5504490] 3 <NSThread: 0x600001cde1c0>{number = 1, name = main}
     */
}

@end
