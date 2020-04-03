//
//  NoramlStrategy.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/3.
//  Copyright © 2020 hh. All rights reserved.
//

#import "NoramlStrategy.h"

@implementation NoramlStrategy
  
- (id<IMediaProtocol>)current {
    NSLog(@"normal 获取current item");
    return nil;
}

- (id<IMediaProtocol>)next {
    NSLog(@"normal 获取next item");
    return nil;
}

- (id<IMediaProtocol>)previous {
    NSLog(@"normal 获取previous item");
    return nil;
}

@end
