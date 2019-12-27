//
//  GCDDispatchSemaphoreController.m
//  threadDemo
//
//  Created by tianxi on 2019/12/18.
//  Copyright © 2019 hh. All rights reserved.
//

#import "GCDDispatchSemaphoreController.h"
#import "SemaphoreMaxConcurrentCount.h"

/**
 信号量，有三个方法：
 
 dispatch_semaphore_t dispatch_semaphore_create(long value);
    创建一个信号量，信号量的值为入参 value
 
 long dispatch_semaphore_signal(dispatch_semaphore_t dsema);
    接收一个信号量，发送信号使信号量的值 +1并返回
 
 long dispatch_semaphore_wait(dispatch_semaphore_t dsema, dispatch_time_t timeout);
    接收一个信号和时间值，若信号的信号量为0，则会阻塞当前线程，直到信号量大于0或者经过输入的时间值；
    若信号量大于0，则会使信号量减1并返回，程序继续住下执行

 */

@interface GCDDispatchSemaphoreController ()

@end

@implementation GCDDispatchSemaphoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.

//    [self test1];
   
}

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self test3];
}

#pragma mark - 应用
 
/**
 AFNetworking库中
 
 获取session中完成的tasks。这个 与 `appVersionInAppStore:` 方法中的作用差不多。
 
 都是通过block获取数据，然后将数据直接返回出去，避免了其他地方获取task也要用回调的方式获取数据。
 
 */
//- (NSArray *)tasksForKeyPath:(NSString *)keyPath {
//    __block NSArray *tasks = nil;
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//    [self.session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
//        if ([keyPath isEqualToString:NSStringFromSelector(@selector(dataTasks))]) {
//            tasks = dataTasks;
//        } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(uploadTasks))]) {
//            tasks = uploadTasks;
//        } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(downloadTasks))]) {
//            tasks = downloadTasks;
//        } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(tasks))]) {
//            tasks = [@[dataTasks, uploadTasks, downloadTasks] valueForKeyPath:@"@unionOfArrays.self"];
//        }
//
//        dispatch_semaphore_signal(semaphore);
//    }];
//
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//
//    return tasks;
//}

/**
 并发控制
 实现与NSOperationQueue中max-ConcurrentOperationCount 类似功能。
 */
- (void)test3 {
    SemaphoreMaxConcurrentCount *smcc = [[SemaphoreMaxConcurrentCount alloc] initWithMaxConcurrentCount:2];
    for (int i = 0; i < 10; i++) {
        [smcc addTask:^{
            NSLog(@"task %d %@",i,[NSThread currentThread]);
        }];
    }
}
 
/**
 异步任务，同步返回
 
 同步获取指定APP在AppStore中的当前版本
 */
- (NSString *)appVersionInAppStore:(NSString *)appId {
    __block NSString *appVersion = @"";
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@",appId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *err;
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&err];
        if (!err) {
            NSArray *results = jsonData[@"results"];
            if ([results isKindOfClass:[NSArray class]] && results != nil && results.count > 0) {
                appVersion = results.firstObject[@"version"];
            }
        }
        
        dispatch_semaphore_signal(semaphore);
    }];
    
    [dataTask resume];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return appVersion;
    
//   var appVersion = ""
//
//   let url = "https://itunes.apple.com/lookup?id=\(appId)"
//   let request = NSURLRequest(URL: NSURL(string: url)!)
//
//   let semaphore = dispatch_semaphore_create(0)
//
//   let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request)
//   { (data, response, error) in
//       do {
//           let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
//           if let results = jsonData["results"]! {
//               assert(results.count != 0, "results should not be null")
//
//               appVersion = results.firstObject!?["version"]! as! String
//           }
//
//           dispatch_semaphore_signal(semaphore)
//
//       } catch {
//
//       }
//   }
//   dataTask.resume()
//
//   dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
//
//   return appVersion
}

/**
 充当锁的功能
 
 当线程1执行到dispatch_semaphore_wait这一行时，semaphore的信号量为1，所以使信号量-1变为0，并且线程1继续往下执行；
 当在线程1NSLog这一行代码还没执行完的时候，又有线程2来访问，执行dispatch_semaphore_wait时由于此时信号量为0，且时间为DISPATCH_TIME_FOREVER,所以会一直阻塞线程2（此时线程2处于等待状态），直到线程1执行完NSLog并执行完dispatch_semaphore_signal使信号量为1后，线程2才能解除阻塞继续住下执行。
 这就可以保证同时只有一个线程执行NSLog这一行代码。

 */
- (void)test1 {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    for (int i = 0; i < 100; i++) {
        dispatch_async(queue, ^{
            // 相当于加锁
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"i = %d semaphore = %@", i, semaphore);
            // 相当于解锁
            dispatch_semaphore_signal(semaphore);
        });
    }
}

@end
