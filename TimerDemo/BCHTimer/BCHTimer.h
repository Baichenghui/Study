//
//  BCHTimer.h
//  BCHTimer
//
//  Created by 白成慧&瑞瑞 on 2019/3/16.
//  Copyright © 2019 白成慧. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BCHTimer : NSObject

+(NSString *)executeTask:(void(^)(void))task
             start:(NSTimeInterval)start
          interval:(NSTimeInterval)interval
           repeats:(BOOL)repeats
             async:(BOOL)async;

+(NSString *)executeTask:(id)target
                selector:(SEL)selector
                   start:(NSTimeInterval)start
                interval:(NSTimeInterval)interval
                 repeats:(BOOL)repeats
                   async:(BOOL)async;

+(void)cancleTask:(NSString *)taskId;

@end

NS_ASSUME_NONNULL_END
