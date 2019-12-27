//
//  GCDDispatchBarrierController.m
//  threadDemo
//
//  Created by tianxi on 2019/12/18.
//  Copyright © 2019 hh. All rights reserved.
//

#import "GCDDispatchBarrierController.h"

@interface GCDDispatchBarrierController ()

@end

@implementation GCDDispatchBarrierController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
     
//    [self test2];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self test1];
    
//    [self test2];
}

#pragma mark - 应用

/**
    AFNetworking库中
        
    高效实现读写安全功能。
 
    同一时间，只能有1个线程进行写的操作
    同一时间，允许有多个线程进行读的操作
    同一时间，不允许既有写的操作，又有读的操作
 
    这里在读的时候使用的是同步，目的也是为了线程安全。原因是因为 mutableHTTPRequestHeaders 本身（NSMutableDictionary） 是线程不安全的。
*/
//- (void)setValue:(NSString *)value
//forHTTPHeaderField:(NSString *)field
//{
//    dispatch_barrier_async(self.requestHeaderModificationQueue, ^{
//        [self.mutableHTTPRequestHeaders setValue:value forKey:field];
//    });
//}
//
//- (NSString *)valueForHTTPHeaderField:(NSString *)field {
//    NSString __block *value;
//    dispatch_sync(self.requestHeaderModificationQueue, ^{
//        value = [self.mutableHTTPRequestHeaders valueForKey:field];
//    });
//    return value;
//}


#pragma mark - test

/**
 
 dispatch_barrier_async 中的任务异步执行，不会阻塞当前线程
 
 */
- (void)test2 {
    dispatch_queue_t queue = dispatch_queue_create("asyncConcurrent", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i < 10; i++) {
        if (i % 2 == 0) {
            dispatch_async(queue, ^{
                sleep(1);
                NSLog(@"dispatch_barrier_sync 之前的任务:%d",i);
            });
        }
        else {
            dispatch_async(queue, ^{
                NSLog(@"dispatch_barrier_sync 之前的任务:%d",i);
            });
        }
    }
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"dispatch_barrier_sync 任务执行 %@", [NSThread currentThread]);
    });
    
    NSLog(@"dispatch_barrier_async 所在线程 %@", [NSThread currentThread]);
    
    for (int i = 0; i < 10; i++) {
        if (i % 2 == 0) {
            dispatch_async(queue, ^{
                sleep(1);
                NSLog(@"dispatch_barrier_sync 之后的任务:%d",i);
            });
        }
        else {
            dispatch_async(queue, ^{
                NSLog(@"dispatch_barrier_sync 之后的任务:%d",i);
            });
        }
    }
    
    /**
     2019-12-19 13:40:48.135837+0800 threadDemo[8655:6043503] dispatch_barrier_async 所在线程 <NSThread: 0x6000014820c0>{number = 1, name = main}
     2019-12-19 13:40:48.137458+0800 threadDemo[8655:6043615] dispatch_barrier_sync 之前的任务:1
     2019-12-19 13:40:48.152424+0800 threadDemo[8655:6043615] dispatch_barrier_sync 之前的任务:3
     2019-12-19 13:40:48.152613+0800 threadDemo[8655:6043615] dispatch_barrier_sync 之前的任务:5
     2019-12-19 13:40:48.152732+0800 threadDemo[8655:6043711] dispatch_barrier_sync 之前的任务:7
     2019-12-19 13:40:48.152829+0800 threadDemo[8655:6043615] dispatch_barrier_sync 之前的任务:9
     2019-12-19 13:40:49.140811+0800 threadDemo[8655:6043611] dispatch_barrier_sync 之前的任务:0
     2019-12-19 13:40:49.153305+0800 threadDemo[8655:6043710] dispatch_barrier_sync 之前的任务:6
     2019-12-19 13:40:49.153305+0800 threadDemo[8655:6043609] dispatch_barrier_sync 之前的任务:2
     2019-12-19 13:40:49.153305+0800 threadDemo[8655:6043709] dispatch_barrier_sync 之前的任务:4
     2019-12-19 13:40:49.153359+0800 threadDemo[8655:6043712] dispatch_barrier_sync 之前的任务:8
     2019-12-19 13:40:49.153667+0800 threadDemo[8655:6043712] dispatch_barrier_sync 任务执行 <NSThread: 0x60000140dd00>{number = 7, name = (null)}
     2019-12-19 13:40:49.153994+0800 threadDemo[8655:6043712] dispatch_barrier_sync 之后的任务:1
     2019-12-19 13:40:49.154061+0800 threadDemo[8655:6043710] dispatch_barrier_sync 之后的任务:3
     2019-12-19 13:40:49.154194+0800 threadDemo[8655:6043710] dispatch_barrier_sync 之后的任务:5
     2019-12-19 13:40:49.154419+0800 threadDemo[8655:6043714] dispatch_barrier_sync 之后的任务:7
     2019-12-19 13:40:49.154460+0800 threadDemo[8655:6043713] dispatch_barrier_sync 之后的任务:9
     2019-12-19 13:40:50.154831+0800 threadDemo[8655:6043709] dispatch_barrier_sync 之后的任务:0
     2019-12-19 13:40:50.154831+0800 threadDemo[8655:6043611] dispatch_barrier_sync 之后的任务:4
     2019-12-19 13:40:50.154869+0800 threadDemo[8655:6043712] dispatch_barrier_sync 之后的任务:6
     2019-12-19 13:40:50.154869+0800 threadDemo[8655:6043615] dispatch_barrier_sync 之后的任务:8
     2019-12-19 13:40:50.154867+0800 threadDemo[8655:6043609] dispatch_barrier_sync 之后的任务:2
     
     */
}

/**
 
 dispatch_barrier_sync 中的任务同步执行，会阻塞当前线程
 
 */
- (void)test1 {
    dispatch_queue_t queue = dispatch_queue_create("asyncConcurrent", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i < 10; i++) {
        if (i % 2 == 0) {
            dispatch_async(queue, ^{
                sleep(1);
                NSLog(@"dispatch_barrier_sync 之前的任务:%d",i);
            });
        }
        else {
            dispatch_async(queue, ^{
                NSLog(@"dispatch_barrier_sync 之前的任务:%d",i);
            });
        }
    }
    
    dispatch_barrier_sync(queue, ^{
        NSLog(@"dispatch_barrier_sync 任务执行 %@", [NSThread currentThread]);
    });
    
    NSLog(@"dispatch_barrier_sync 所在线程 %@", [NSThread currentThread]);
    
    for (int i = 0; i < 10; i++) {
        if (i % 2 == 0) {
            dispatch_async(queue, ^{
                sleep(1);
                NSLog(@"dispatch_barrier_sync 之后的任务:%d",i);
            });
        }
        else {
            dispatch_async(queue, ^{
                NSLog(@"dispatch_barrier_sync 之后的任务:%d",i);
            });
        }
    }
    
    /**
     2019-12-19 13:41:20.335598+0800 threadDemo[8655:6043711] dispatch_barrier_sync 之前的任务:1
     2019-12-19 13:41:20.335702+0800 threadDemo[8655:6044001] dispatch_barrier_sync 之前的任务:3
     2019-12-19 13:41:20.336030+0800 threadDemo[8655:6044003] dispatch_barrier_sync 之前的任务:5
     2019-12-19 13:41:20.336205+0800 threadDemo[8655:6044004] dispatch_barrier_sync 之前的任务:7
     2019-12-19 13:41:20.336373+0800 threadDemo[8655:6044005] dispatch_barrier_sync 之前的任务:9
     2019-12-19 13:41:21.340593+0800 threadDemo[8655:6043711] dispatch_barrier_sync 之前的任务:6
     2019-12-19 13:41:21.340593+0800 threadDemo[8655:6043998] dispatch_barrier_sync 之前的任务:0
     2019-12-19 13:41:21.340593+0800 threadDemo[8655:6044001] dispatch_barrier_sync 之前的任务:8
     2019-12-19 13:41:21.340593+0800 threadDemo[8655:6044002] dispatch_barrier_sync 之前的任务:4
     2019-12-19 13:41:21.340636+0800 threadDemo[8655:6044000] dispatch_barrier_sync 之前的任务:2
     2019-12-19 13:41:21.340931+0800 threadDemo[8655:6043503] dispatch_barrier_sync 任务执行 <NSThread: 0x6000014820c0>{number = 1, name = main}
     2019-12-19 13:41:21.341159+0800 threadDemo[8655:6043503] dispatch_barrier_sync 所在线程 <NSThread: 0x6000014820c0>{number = 1, name = main}
     2019-12-19 13:41:21.341339+0800 threadDemo[8655:6044002] dispatch_barrier_sync 之后的任务:1
     2019-12-19 13:41:21.341552+0800 threadDemo[8655:6043998] dispatch_barrier_sync 之后的任务:3
     2019-12-19 13:41:21.342288+0800 threadDemo[8655:6044002] dispatch_barrier_sync 之后的任务:5
     2019-12-19 13:41:21.342807+0800 threadDemo[8655:6044004] dispatch_barrier_sync 之后的任务:7
     2019-12-19 13:41:21.342890+0800 threadDemo[8655:6043711] dispatch_barrier_sync 之后的任务:9
     2019-12-19 13:41:22.345189+0800 threadDemo[8655:6044001] dispatch_barrier_sync 之后的任务:2
     2019-12-19 13:41:22.345189+0800 threadDemo[8655:6044005] dispatch_barrier_sync 之后的任务:4
     2019-12-19 13:41:22.345227+0800 threadDemo[8655:6044003] dispatch_barrier_sync 之后的任务:6
     2019-12-19 13:41:22.345227+0800 threadDemo[8655:6044000] dispatch_barrier_sync 之后的任务:0
     2019-12-19 13:41:22.345237+0800 threadDemo[8655:6043998] dispatch_barrier_sync 之后的任务:8
     */
}

@end
