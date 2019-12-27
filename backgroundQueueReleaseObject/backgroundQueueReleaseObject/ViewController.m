//
//  ViewController.m
//  backgroundQueueReleaseObject
//
//  Created by tianxi on 2019/12/16.
//  Copyright © 2019 hh. All rights reserved.
//

#import "ViewController.h"
#import "HHArray.h"
#import "Person.h"

/// 对象的销毁虽然消耗资源不多，但累积起来也是不容忽视的。通常当容器类持有大量对象时，其销毁时的资源消耗就非常明显。
/// 同样的，如果对象可以放到后台线程去释放，那就挪到后台线程去。
/// 这里有个小 Tip：把对象捕获到 block 中，然后扔到后台队列去随便发送个消息以避免编译器警告，就可以让对象在后台线程销毁了。
 
@interface ViewController ()

@property (nonatomic, weak)HHArray *weakArray;
@property (nonatomic, copy)HHArray *array;
@property (nonatomic, strong)Person *person;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self test1];
//    [self test2];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"viewDidAppear array %@",self.array);
    NSLog(@"viewDidAppear weakArray %@",self.weakArray);
    
    // 2019-12-16 15:38:38.818771+0800 backgroundQueueReleaseObject[2074:1362733] viewDidAppear array (null)
    // 2019-12-16 15:38:38.818771+0800 backgroundQueueReleaseObject[2074:1362733] viewDidAppear weakArray (null)
}

/// 在后台线程释放对象   person只被array所引用，如果还有其他地方强引用这样无法释放，可参考test2。
- (void)test1 {
    Person *person = [Person person];
    self.array = [@[person] copy];

    HHArray *tmp = self.array;
    self.weakArray = tmp;
    self.array = nil;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSLog(@"dispatch_async1 %@",[NSThread currentThread]);
        [tmp class];
        NSLog(@"dispatch_async2 %@",[NSThread currentThread]);
        
        NSLog(@"dispatch_async3 array %@",tmp);
    });
    
    /*
     根据下面的打印，很明显 Person 对象释放了
     
     这里并没有 array 的 dealloc 打印。 不太明白为什么 array 没有调用 dealloc方法。
     但是其实array释放了，因为在 viewDidAppear 中打印weakArray为 null
     
     不太明白为什么 HHArray 没有调用 dealloc方法。
     
     2019-12-16 15:12:27.193780+0800 YYAsyncLayerDemo[2042:1354179] dispatch_async1 <NSThread: 0x283056740>{number = 4, name = (null)}
     2019-12-16 15:12:27.194402+0800 YYAsyncLayerDemo[2042:1354179] dispatch_async2 <NSThread: 0x283056740>{number = 4, name = (null)}
     2019-12-16 15:12:27.194779+0800 YYAsyncLayerDemo[2042:1354179] Person <NSThread: 0x283056740>{number = 4, name = (null)}
     */
}

/// 在后台线程释放对象
- (void)test2 {
    self.person = [[Person alloc] init];
 
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSLog(@"dispatch_async1 %@",[NSThread currentThread]);
        self.person = nil;
        NSLog(@"dispatch_async2 %@",[NSThread currentThread]);
    });
    /*
     2019-12-16 15:29:22.412131+0800 YYAsyncLayerDemo[2061:1359318] dispatch_async1 <NSThread: 0x282f88340>{number = 4, name = (null)}
     2019-12-16 15:29:22.412694+0800 YYAsyncLayerDemo[2061:1359318] Person <NSThread: 0x282f88340>{number = 4, name = (null)}
     2019-12-16 15:29:22.413114+0800 YYAsyncLayerDemo[2061:1359318] dispatch_async2 <NSThread: 0x282f88340>{number = 4, name = (null)}

     */
}

@end
