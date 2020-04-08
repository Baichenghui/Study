//
//  ElementB.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/8.
//  Copyright © 2020 hh. All rights reserved.
//

#import "ElementB.h"

@implementation ElementB

- (void)accept:(id<IVisitorProtocol>) visitor {
    [visitor visitorElementB:self];
}

@end
