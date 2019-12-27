//
//  ThreadSafeMutableDictionary.m
//  threadDemo
//
//  Created by tianxi on 2019/12/20.
//  Copyright © 2019 hh. All rights reserved.
//

#import "ThreadSafeMutableDictionary.h"
  
@implementation ThreadSafeMutableDictionary {
    dispatch_queue_t _concurrentQueue;
}

- (instancetype)init {
    if (self = [super init]) {
        _concurrentQueue = dispatch_queue_create("com.thread.ThreadSafeMutableDictionary", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)objectForKey:(NSString *)key block:(ThreadSafeBlock)block {
    id cKey = [key copy];
    __weak __typeof__(self) weakSelf = self;

    dispatch_sync(_concurrentQueue, ^{
        ThreadSafeMutableDictionary *strongSelf = weakSelf;
        if (!strongSelf) {
            block(nil,cKey,nil);
            return ;
        }
        
        id object = [strongSelf objectForKey:cKey];
        block(strongSelf,cKey,object);
    });
}

- (void)setObject:(id)object forKey:(NSString *)key block:(ThreadSafeBlock)block {
    if (!key || !object) {
        return;
    }
    
    NSString *aKey = [key copy];
    __weak __typeof__(self) weakSelf = self;
    dispatch_barrier_async(_concurrentQueue, ^{
        ThreadSafeMutableDictionary *strongSelf = weakSelf;
        if (!strongSelf) {
            block(nil,aKey,nil);
            return ;
        }
        
        [self setObject:object forKey:aKey];
        if (block) {
            block(strongSelf,aKey,object);
        }
    });
}

@end
