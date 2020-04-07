//
//  Waiter.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import "Waiter.h"

@implementation Waiter
 
- (NSMutableArray<AbstructCommand *> *)list {
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}


- (void)notify {
    for (AbstructCommand *cmd in self.list) {
        [cmd excuteCmd];
    }
}

@end
