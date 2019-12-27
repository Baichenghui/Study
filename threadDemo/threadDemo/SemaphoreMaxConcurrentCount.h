//
//  SemaphoreMaxConcurrentCount.h
//  threadDemo
//
//  Created by tianxi on 2019/12/19.
//  Copyright © 2019 hh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^TaskBlock)(void);

@interface SemaphoreMaxConcurrentCount : NSObject
- (instancetype)initWithMaxConcurrentCount:(NSInteger)count;
- (void)addTask:(TaskBlock)block;
@end

NS_ASSUME_NONNULL_END
