//
//  RandomStrategy.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/3.
//  Copyright © 2020 hh. All rights reserved.
//

#import "RandomStrategy.h"

@implementation RandomStrategy
 
- (id<IMediaProtocol>)current {
    NSLog(@"random 获取current item");
    return nil;
}

- (id<IMediaProtocol>)next {
    NSLog(@"random 获取next item");
    return nil;
}

- (id<IMediaProtocol>)previous {
    NSLog(@"random 获取previous item");
    return nil;
}

@end
