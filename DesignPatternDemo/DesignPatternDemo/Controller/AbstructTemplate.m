//
//  AbstructTemplate.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import "AbstructTemplate.h"

@implementation AbstructTemplate

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)temp {
    [self initView];
    [self initData];
    [self loadData];
}

- (void)initView {
    NSLog(@"AbstructTemplate initView");
}

- (void)initData {
    NSLog(@"AbstructTemplate initData");
}

- (void)loadData {
    NSLog(@"AbstructTemplate loadData");
}

@end
