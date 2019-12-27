//
//  GCDDispatchApplyController.m
//  threadDemo
//
//  Created by tianxi on 2019/12/18.
//  Copyright © 2019 hh. All rights reserved.
//

#import "GCDDispatchApplyController.h"

/*
    dispatch_apply类似一个for循环，会在指定的dispatch queue中运行block任务n次.
    如果队列是并发队列，则会并发执行block任务;
    如果队列是串行队列，则会串行在当前队列执行block任务;
    dispatch_apply是一个同步调用，block任务执行n次后才返回。
 
 */

@interface GCDDispatchApplyController ()

@end

@implementation GCDDispatchApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self test1];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self test2];
    [self test0];
}

- (void)test0 {
    NSLog(@"start");
        
    CFTimeInterval startTimeInterval = CACurrentMediaTime();
    for (int i = 0; i < 10000; i++) {
        NSLog(@"%d %@",i,[NSThread currentThread]);
    }
    CFTimeInterval endTimeInterval = CACurrentMediaTime();
    NSLog(@"end");
    
    NSLog(@"endTimeInterval - startTimeInterval:%f",endTimeInterval - startTimeInterval);
    
    /*
     2019-12-19 16:26:30.629584+0800 threadDemo[9736:6143494] 0 <NSThread: 0x600000d62100>{number = 1, name = main}
     2019-12-19 16:26:30.629696+0800 threadDemo[9736:6143494] 1 <NSThread: 0x600000d62100>{number = 1, name = main}
     2019-12-19 16:26:30.629864+0800 threadDemo[9736:6143494] 2 <NSThread: 0x600000d62100>{number = 1, name = main}
     ...
     2019-12-19 16:26:34.692254+0800 threadDemo[9736:6143494] 9997 <NSThread: 0x600000d62100>{number = 1, name = main}
     2019-12-19 16:26:34.692512+0800 threadDemo[9736:6143494] 9998 <NSThread: 0x600000d62100>{number = 1, name = main}
     2019-12-19 16:26:34.692852+0800 threadDemo[9736:6143494] 9999 <NSThread: 0x600000d62100>{number = 1, name = main}
     2019-12-19 16:26:34.693201+0800 threadDemo[9736:6143494] end
     2019-12-19 16:26:34.693523+0800 threadDemo[9736:6143494] endTimeInterval - startTimeInterval:4.063527
     */
}

/// 串行队列中执行,效率还是略高于普通的 for 循环
- (void)test1 {
    NSLog(@"start");
      
    dispatch_queue_t queue= dispatch_queue_create("asyncSerial", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t queue = dispatch_queue_create("asyncConcurrent", DISPATCH_QUEUE_CONCURRENT);
    
    CFTimeInterval startTimeInterval = CACurrentMediaTime();
    //dispatch_apply是一个同步调用，block任务执行都执行完才返回，会卡住当前线程（无论串行还是并发队列）
    dispatch_apply(10000, queue, ^(size_t i) {
        
//        [NSThread sleepForTimeInterval:arc4random()%1];
        
        NSLog(@"%zu %@",i,[NSThread currentThread]);
    });
    CFTimeInterval endTimeInterval = CACurrentMediaTime();
    NSLog(@"end");
    
    NSLog(@"endTimeInterval - startTimeInterval:%f",endTimeInterval - startTimeInterval);
    
    /*
     2019-12-19 15:46:19.281002+0800 threadDemo[9336:6115616] 0 <NSThread: 0x6000008aa0c0>{number = 1, name = main}
     2019-12-19 15:46:19.281440+0800 threadDemo[9336:6115616] 1 <NSThread: 0x6000008aa0c0>{number = 1, name = main}
     2019-12-19 15:46:19.281440+0800 threadDemo[9336:6115616] 2 <NSThread: 0x6000008aa0c0>{number = 1, name = main}
     2019-12-19 15:46:19.281440+0800 threadDemo[9336:6115616] 3 <NSThread: 0x6000008aa0c0>{number = 1, name = main}
     ....
     2019-12-19 15:46:19.281002+0800 threadDemo[9336:6115616] 9997 <NSThread: 0x6000008aa0c0>{number = 1, name = main}
     2019-12-19 15:46:19.281440+0800 threadDemo[9336:6115616] 9998 <NSThread: 0x6000008aa0c0>{number = 1, name = main}
     2019-12-19 15:46:19.282302+0800 threadDemo[9336:6115616] 9999 <NSThread: 0x6000008aa0c0>{number = 1, name = main}
     2019-12-19 15:46:19.282819+0800 threadDemo[9336:6115616] end
     2019-12-19 15:46:19.283203+0800 threadDemo[9336:6115616] endTimeInterval - startTimeInterval:4.206515
     
     */
}
 
/// 并发队列中执行，比串行队列效率高
- (void)test2 {
    NSLog(@"start");
    
    dispatch_queue_t queue = dispatch_queue_create("asyncConcurrent", DISPATCH_QUEUE_CONCURRENT);
    
    CFTimeInterval startTimeInterval = CACurrentMediaTime();
    //dispatch_apply是一个同步调用，block任务执行都执行完才返回，会卡住当前线程（无论串行还是并发队列）
    dispatch_apply(10000, queue, ^(size_t i) {
        
//        [NSThread sleepForTimeInterval:arc4random()%1];
        
        NSLog(@"%zu %@",i,[NSThread currentThread]);
    });
    CFTimeInterval endTimeInterval = CACurrentMediaTime();
    NSLog(@"end");
    
    NSLog(@"endTimeInterval - startTimeInterval:%f",endTimeInterval - startTimeInterval);
    
    /*

     2019-12-19 16:23:13.700098+0800 threadDemo[9717:6141471] 0 <NSThread: 0x600002f5a140>{number = 1, name = main}
     2019-12-19 16:23:13.700240+0800 threadDemo[9717:6141471] 1 <NSThread: 0x600002f5a140>{number = 1, name = main}
     2019-12-19 16:23:13.700767+0800 threadDemo[9717:6141471] 2 <NSThread: 0x600002f5a140>{number = 1, name = main}
     ...
     2019-12-19 16:23:17.318679+0800 threadDemo[9717:6141471] 9995 <NSThread: 0x600002f5a140>{number = 1, name = main}
     2019-12-19 16:23:17.318908+0800 threadDemo[9717:6141715] 9996 <NSThread: 0x600002fd6900>{number = 8, name = (null)}
     2019-12-19 16:23:17.319090+0800 threadDemo[9717:6141471] 9997 <NSThread: 0x600002f5a140>{number = 1, name = main}
     2019-12-19 16:23:17.319294+0800 threadDemo[9717:6141714] 9998 <NSThread: 0x600002fd6780>{number = 7, name = (null)}
     2019-12-19 16:23:17.319498+0800 threadDemo[9717:6141662] 9999 <NSThread: 0x600002fd6740>{number = 6, name = (null)}
     2019-12-19 16:23:17.321036+0800 threadDemo[9717:6141471] end
     2019-12-19 16:23:17.321507+0800 threadDemo[9717:6141471] endTimeInterval - startTimeInterval:3.620898
     */
}


/// 验证：如果队列是串行队列，则会串行在当前队列执行block任务; 是对的
- (void)test4 {
    dispatch_queue_t queue1 = dispatch_queue_create("asyncConcurrent", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue1, ^{
        dispatch_queue_t queue= dispatch_queue_create("asyncSerial", DISPATCH_QUEUE_SERIAL);
        //    dispatch_queue_t queue = dispatch_queue_create("asyncConcurrent", DISPATCH_QUEUE_CONCURRENT);
            
            CFTimeInterval startTimeInterval = CACurrentMediaTime();
            //dispatch_apply是一个同步调用，block任务执行都执行完才返回，会卡住当前线程（无论串行还是并发队列）
            dispatch_apply(10000, queue, ^(size_t i) {
                
        //        [NSThread sleepForTimeInterval:arc4random()%1];
                
                NSLog(@"%zu %@",i,[NSThread currentThread]);
            });
            CFTimeInterval endTimeInterval = CACurrentMediaTime();
            NSLog(@"end");
            
            NSLog(@"endTimeInterval - startTimeInterval:%f",endTimeInterval - startTimeInterval);
    });
    
    /*
     打印都是在同一个子线程，顺序打印。说明队列是串行队列，则会串行在当前队列执行block任务;
     */
}

@end
