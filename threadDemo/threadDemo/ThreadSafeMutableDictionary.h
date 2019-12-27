//
//  ThreadSafeMutableDictionary.h
//  threadDemo
//
//  Created by tianxi on 2019/12/20.
//  Copyright © 2019 hh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ThreadSafeMutableDictionary;

typedef void (^ThreadSafeBlock)(ThreadSafeMutableDictionary * _Nullable dict, NSString *key, id _Nullable object);

@interface ThreadSafeMutableDictionary : NSMutableDictionary

- (void)objectForKey:(NSString *)key block:(ThreadSafeBlock)block;

- (void)setObject:(id)object forKey:(NSString *)key block:(ThreadSafeBlock)block;

@end

NS_ASSUME_NONNULL_END
