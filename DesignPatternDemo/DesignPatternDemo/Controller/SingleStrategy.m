//
//  SingleStrategy.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/3.
//  Copyright © 2020 hh. All rights reserved.
//

#import "SingleStrategy.h"

@implementation SingleStrategy
  
- (id<IMediaProtocol>)current {
    NSLog(@"single 获取current item");
    return nil;
}

- (id<IMediaProtocol>)next {
    NSLog(@"single 获取next item");
    return nil;
}

- (id<IMediaProtocol>)previous {
    NSLog(@"single 获取previous item");
    return nil;
}

@end
