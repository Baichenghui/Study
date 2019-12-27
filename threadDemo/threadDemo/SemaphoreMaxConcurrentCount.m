//
//  SemaphoreMaxConcurrentCount.m
//  threadDemo
//
//  Created by tianxi on 2019/12/19.
//  Copyright © 2019 hh. All rights reserved.
//

#import "SemaphoreMaxConcurrentCount.h"


@implementation SemaphoreMaxConcurrentCount {
    dispatch_semaphore_t _semaphore;
    dispatch_queue_t _queue;
}

- (instancetype)init {
    return [self initWithMaxConcurrentCount:3];;
}
 
- (instancetype)initWithMaxConcurrentCount:(NSInteger)count {
    if (self = [super init]) {
        if (count < 1) {
            count = 3;
        }
        _semaphore = dispatch_semaphore_create(count);
        _queue = dispatch_queue_create("asyncConcurrent", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}


- (void)addTask:(TaskBlock)block {
    dispatch_async(_queue, ^{
        dispatch_semaphore_wait(self->_semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            block();
            dispatch_semaphore_signal(self->_semaphore);
        });
    });
}

@end
