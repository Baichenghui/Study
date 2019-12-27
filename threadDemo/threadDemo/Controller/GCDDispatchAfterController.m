//
//  GCDDispatchAfterController.m
//  threadDemo
//
//  Created by tianxi on 2019/12/18.
//  Copyright © 2019 hh. All rights reserved.
//

#import "GCDDispatchAfterController.h"

@interface GCDDispatchAfterController ()

@end

@implementation GCDDispatchAfterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
//    [self test1];
//    [self test2];
    [self test3];
}

/// 延时函数，不会卡住所在线程
/// 任务执行所在队列为主队列，任务在主线程中执行的
- (void)test1 {
    NSLog(@"1 %@",[NSThread currentThread]);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"2 %@",[NSThread currentThread]);
    });
    NSLog(@"3 %@",[NSThread currentThread]);
    
    /*
     2019-12-19 14:58:46.529442+0800 threadDemo[8900:6083577] 1 <NSThread: 0x6000036b8b80>{number = 1, name = main}
     2019-12-19 14:58:46.529659+0800 threadDemo[8900:6083577] 3 <NSThread: 0x6000036b8b80>{number = 1, name = main}
     2019-12-19 14:58:48.529967+0800 threadDemo[8900:6083577] 2 <NSThread: 0x6000036b8b80>{number = 1, name = main}

     */
}

/// 延时函数，不会卡住所在线程
/// 修改任务执行所在队列为并发队列. 任务是在子线程中执行的.
- (void)test2 {
    NSLog(@"1 %@",[NSThread currentThread]);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2 %@",[NSThread currentThread]);
    });
    NSLog(@"3 %@",[NSThread currentThread]);
    
    /*
     2019-12-19 15:00:48.693679+0800 threadDemo[8943:6085531] 1 <NSThread: 0x600000d72ac0>{number = 1, name = main}
     2019-12-19 15:00:48.694252+0800 threadDemo[8943:6085531] 3 <NSThread: 0x600000d72ac0>{number = 1, name = main}
     2019-12-19 15:00:50.855673+0800 threadDemo[8943:6085641] 2 <NSThread: 0x600000d21080>{number = 3, name = (null)}

     */
}


/// 延时函数，不会卡住所在线程
/// 修改任务执行所在队列为自定义的串行队列. 任务是在子线程中执行的.
/// 通过查看打印结果，很明显延时函数底层肯定是异步执行任务。只有在主队列时任务才在主线程执行
- (void)test3 {
    NSLog(@"1 %@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("syncConcrrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), queue, ^{
        NSLog(@"2 %@",[NSThread currentThread]);
    });
    NSLog(@"3 %@",[NSThread currentThread]);
    
    /*
     2019-12-19 15:09:06.207532+0800 threadDemo[9037:6090879] 1 <NSThread: 0x600001960f40>{number = 1, name = main}
     2019-12-19 15:09:06.207745+0800 threadDemo[9037:6090879] 3 <NSThread: 0x600001960f40>{number = 1, name = main}
     2019-12-19 15:09:08.207879+0800 threadDemo[9037:6090962] 2 <NSThread: 0x6000019ee4c0>{number = 8, name = (null)}
     */
}


@end
