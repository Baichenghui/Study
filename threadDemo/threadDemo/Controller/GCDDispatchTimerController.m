//
//  GCDDispatchTimerController.m
//  threadDemo
//
//  Created by tianxi on 2019/12/18.
//  Copyright © 2019 hh. All rights reserved.
//

#import "GCDDispatchTimerController.h"

/*
 Dispatch Source是BSD系统内核惯有功能kqueue的包装，kqueue是在XNU内核中发生各种事件时，在应用程序编程方执行处理的技术。
 它的CPU负荷非常小，尽量不占用资源。当事件发生时，Dispatch Source会在指定的Dispatch Queue中执行事件的处理。
 
 
 dispatch_source_t
 一共有一下几种类型（dispatch_source_type_t):

 监控进程：DISPATCH_SOURCE_TYPE_PROC,
 定时器：DISPATCH_SOURCE_TYPE_TIMER,
 从描述符中读取数据：DISPATCH_SOURCE_TYPE_READ,
 向描述符中写入字符：DISPATCH_SOURCE_TYPE_WRITE,
 监控文件系统对象:DISPATCH_SOURCE_TYPE_VNODE,.....

 demo演示定时器使用
    
 
 Dispatch Source使用最多的就是用来实现定时器，source创建后默认是暂停状态，需要手动调用dispatch_resume启动定时器。dispatch_after只是封装调用了dispatch source定时器，然后在回调函数中执行定义的block。

 Dispatch Source定时器使用时也有一些需要注意的地方，不然很可能会引起crash：

 1、循环引用：因为dispatch_source_set_event_handler回调是个block，在添加到source的链表上时会执行copy并被source强引用，如果block里持有了self，self又持有了source的话，就会引起循环引用。正确的方法是使用weak+strong或者提前调用dispatch_source_cancel取消timer。

 2、dispatch_resume和dispatch_suspend调用次数需要平衡，如果重复调用dispatch_resume则会崩溃,因为重复调用会让dispatch_resume代码里if分支不成立，从而执行了DISPATCH_CLIENT_CRASH("Over-resume of an object")导致崩溃。

 3、source在suspend状态下，如果直接设置source = nil或者重新创建source都会造成crash。正确的方式是在resume状态下调用dispatch_source_cancel(source)后再重新创建。

 */
@interface GCDDispatchTimerController ()

@end

@implementation GCDDispatchTimerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self test1];
}

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

- (void)test1 {
    __block int timeout=30; //倒计时时间
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, 0), 1 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"time 倒计时结束");
            });
        }else{
            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d分%.2d秒后重新获取验证码",minutes, seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"strTime %@",strTime);
            });
            timeout--;
        }
    });
    //启动timer
    dispatch_resume(_timer);
}

@end
