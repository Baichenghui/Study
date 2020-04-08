//
//  ElementA.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/8.
//  Copyright © 2020 hh. All rights reserved.
//

#import "ElementA.h"

@implementation ElementA

- (void)accept:(id<IVisitorProtocol>) visitor {
    [visitor visitorElementA:self];
}

@end
