//
//  Person.m
//  YYAsyncLayerDemo
//
//  Created by tianxi on 2019/12/16.
//  Copyright © 2019 hh. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (instancetype)person {
    return [[self class] new];
}

- (void)dealloc { 
    NSLog(@"Person %@",[NSThread currentThread]);
}

@end
