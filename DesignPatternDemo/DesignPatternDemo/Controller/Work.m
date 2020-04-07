//
//  Work.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import "Work.h"
#import "StateA.h"

@interface Work()
@end

@implementation Work

- (instancetype)init {
    if (self = [super init]) {
        self.currentState = [StateA new];
    }
    return self;
}

- (void)doWork {
    if (self.currentState != nil) {
        [self.currentState handle:self];
    }
}

@end
