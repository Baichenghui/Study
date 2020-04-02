//
//  Adapter.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "Adapter.h"

@implementation Adapter

- (void)eat {
    [self.adaptee eat];
}

@end
