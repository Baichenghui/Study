//
//  ViewController.m
//  weak-strong解决循环引用
//
//  Created by 白成慧&瑞瑞 on 2019/3/9.
//  Copyright © 2019 白成慧. All rights reserved.
//

#import "ViewController.h"

#import "TestObject.h"

@interface ViewController ()

@end

@implementation ViewController

void(^block)(void);

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    TestObject *obj = [[TestObject alloc] init];
    __weak TestObject *weakObj = obj;
    NSLog(@"before block");
    
    block = ^(){
        NSLog(@"TestObj对象地址:%@",weakObj);
        
        __strong TestObject *strongObj = weakObj;
        dispatch_async(dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, NULL), ^{
            
            for (int i = 0; i < 1000000; i++) {
                // 模拟一个耗时的任务
            }
            
            NSLog(@"耗时的任务 结束 TestObj对象地址:%@",strongObj);
        });
    };
    NSLog(@"after block");
    block();
}


@end
