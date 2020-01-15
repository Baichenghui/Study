//
//  BCHTimer.m
//  BCHTimer
//
//  Created by 白成慧&瑞瑞 on 2019/3/16.
//  Copyright © 2019 白成慧. All rights reserved.
//

#import "BCHTimer.h"

@implementation BCHTimer

static NSMutableDictionary *timers_;
dispatch_semaphore_t semaphore_;
+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers_ = [NSMutableDictionary dictionary];
        semaphore_ = dispatch_semaphore_create(1);
    });
}

+(NSString *)executeTask:(void(^)(void))task
             start:(NSTimeInterval)start
          interval:(NSTimeInterval)interval
           repeats:(BOOL)repeats
             async:(BOOL)async {
    
    if (!task || start < 0 || (interval <= 0 && repeats)) {
        return nil;
    }
    
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, start * NSEC_PER_SEC, interval * NSEC_PER_SEC);
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    NSString *taskId = [NSString stringWithFormat:@"%zd",timers_.count];
    timers_[taskId] = timer;
    dispatch_semaphore_signal(semaphore_);
    
    dispatch_source_set_event_handler(timer, ^{
        task();
        if (!repeats) {
            [self cancleTask:taskId];
        }
    });
    dispatch_resume(timer);
    
    
    return taskId;
}

+(NSString *)executeTask:(id)target
                selector:(SEL)selector
                   start:(NSTimeInterval)start
                interval:(NSTimeInterval)interval
                 repeats:(BOOL)repeats
                   async:(BOOL)async {
    if (!target || !selector) {
        return nil;
    }
    
    return [self executeTask:^{
        if ([target respondsToSelector:selector ]) {
            #pragma clang diagnostic push
            //"-Wunused-variable"这里就是警告的类型
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            
            [target performSelector:selector];
            
            #pragma clang diagnostic pop
        }
        
    } start:start interval:interval repeats:repeats async:async];
}

+ (void)cancleTask:(NSString *)taskId {
    if (!taskId || taskId.length <= 0) {
        return ;
    }
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    dispatch_source_t timer = timers_[taskId];
    if (timer) {
        dispatch_source_cancel(timer);
        [timers_ removeObjectForKey:taskId];
    }
    dispatch_semaphore_signal(semaphore_);
}

@end
