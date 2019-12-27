//
//  GCDDispatchGroupController.m
//  threadDemo
//
//  Created by tianxi on 2019/12/18.
//  Copyright © 2019 hh. All rights reserved.
//

#import "GCDDispatchGroupController.h"

/*
 参考：https://xiaozhuanlan.com/topic/0863519247
 
 dispatch_group本质是个初始值为LONG_MAX的信号量，等待group中的任务完成其实是等待value恢复初始值。
 dispatch_group_enter和dispatch_group_leave必须成对出现。

 如果dispatch_group_enter比dispatch_group_leave多一次，则wait函数等待的
 线程不会被唤醒和注册notify的回调block不会执行；

 如果dispatch_group_leave比dispatch_group_enter多一次，则会引起崩溃。
 */

@interface GCDDispatchGroupController ()

@end

@implementation GCDDispatchGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
//    [self test1];
    
//    [self test2];
    
    [self test3];
}

- (void)test3 {
    dispatch_queue_t aDQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    // Add a task to the group
    dispatch_group_async(group, aDQueue, ^{
        sleep(2);
        printf("task 1 \n");
    });
    dispatch_group_async(group, aDQueue, ^{
        printf("task 2 \n");
    });
    
    printf("wait 1 2 \n");
    //同步等待，直到group里面的block全部执行完毕，才会继续往后执行。
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    printf("task 1 2 finished \n");
  
    /**
        wait 1 2
        task 2
        task 1
        task 1 2 finished
    */
}


- (void)test2 {
    NSLog(@"1:%@",[NSThread currentThread]);
    // 创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    // 创建队列组
    dispatch_group_t group = dispatch_group_create();
   
    /*
    // 不要写在这，没意义，我们都知道他在组内所有的任务执行完毕会调用 dispatch_group_notify 中的回调块。
    // 但是后面还有一句，当组内没有任务时，dispatch_group_notify 中的回调块也会立即执行。
    // 队列组拦截通知模块(内部本身是异步执行的,不会阻塞线程)
    dispatch_group_notify(group, queue, ^{
        NSLog(@"4:%@",[NSThread currentThread]);
    });
     
    2019-12-18 16:07:54.677923+0800 threadDemo[5581:5613688] 1:<NSThread: 0x6000035c57c0>{number = 1, name = main}
    2019-12-18 16:07:54.678160+0800 threadDemo[5581:5613816] 4:<NSThread: 0x600003595cc0>{number = 6, name = (null)}
    2019-12-18 16:07:55.678663+0800 threadDemo[5581:5613688] 5:<NSThread: 0x6000035c57c0>{number = 1, name = main}
    2019-12-18 16:07:56.681079+0800 threadDemo[5581:5613812] 2:<NSThread: 0x6000035995c0>{number = 5, name = (null)}
    2019-12-18 16:07:57.680645+0800 threadDemo[5581:5613815] 3:<NSThread: 0x60000359f300>{number = 3, name = (null)}
    */
    
    //队列组异步执行任务
    dispatch_group_async(group, queue, ^{
        sleep(2);
        NSLog(@"2:%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        sleep(3);
        NSLog(@"3:%@",[NSThread currentThread]);
    });
    // 队列组拦截通知模块(内部本身是异步执行的,不会阻塞线程)
    dispatch_group_notify(group, queue, ^{
        NSLog(@"4:%@",[NSThread currentThread]);
    });
    
    sleep(1);
    NSLog(@"5:%@",[NSThread currentThread]);
    
    /*
     2019-12-18 16:06:55.380553+0800 threadDemo[5558:5612492] 1:<NSThread: 0x600003d60800>{number = 1, name = main}
     2019-12-18 16:06:56.381177+0800 threadDemo[5558:5612492] 5:<NSThread: 0x600003d60800>{number = 1, name = main}
     2019-12-18 16:06:57.384415+0800 threadDemo[5558:5612611] 2:<NSThread: 0x600003d30380>{number = 5, name = (null)}
     2019-12-18 16:06:58.385496+0800 threadDemo[5558:5612614] 3:<NSThread: 0x600003d351c0>{number = 3, name = (null)}
     2019-12-18 16:06:58.385737+0800 threadDemo[5558:5612614] 4:<NSThread: 0x600003d351c0>{number = 3, name = (null)}
     */
}
 
- (void)test1 {
    NSLog(@"1:%@",[NSThread currentThread]);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
     
//    //注意不要放在这,而应该放在dispatch_group_enter / leave 最后面。
//    //否则可额能计数不对，导致提前回调
//    dispatch_group_notify(group, queue, ^{
//            NSLog(@"2");
//    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"3:%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        sleep(3);
        NSLog(@"4:%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });
     
    dispatch_group_notify(group, queue, ^{
            NSLog(@"2:%@",[NSThread currentThread]);
    });
    
    NSLog(@"5:%@",[NSThread currentThread]);
    
    /**
    2019-12-18 16:03:42.575564+0800 threadDemo[5518:5610267] 1:<NSThread: 0x600001c085c0>{number = 1, name = main}
    2019-12-18 16:03:42.576226+0800 threadDemo[5518:5610267] 5:<NSThread: 0x600001c085c0>{number = 1, name = main}
    2019-12-18 16:03:43.578856+0800 threadDemo[5518:5610368] 3:<NSThread: 0x600001c4ffc0>{number = 4, name = (null)}
    2019-12-18 16:03:45.579819+0800 threadDemo[5518:5610366] 4:<NSThread: 0x600001c4b580>{number = 6, name = (null)}
    2019-12-18 16:03:45.580037+0800 threadDemo[5518:5610366] 2:<NSThread: 0x600001c4b580>{number = 6, name = (null)}
    */
}

@end
