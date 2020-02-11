//
//  LCMemoryCache.m
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/26.
//  Copyright © 2019 hh. All rights reserved.
//

#import "LCMemoryCache.h"

@implementation LCMemoryCache

- (instancetype)init {
    if (self = [super init]) {
        _cache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id _Nullable)get:(id)key {
    return self.cache[key];
}

- (void)setKey:(id)key value:(id)value {
    self.cache[key] = value;
}

- (void)clear {
    [self.cache removeAllObjects];
}

- (void)setCurrent:(int)current {
    if (_current != current) {
        _current = current;
        [self clear];
    }
}

@end
