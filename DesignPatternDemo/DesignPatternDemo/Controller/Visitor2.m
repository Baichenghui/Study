//
//  VisitorB.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/8.
//  Copyright © 2020 hh. All rights reserved.
//

#import "Visitor2.h"

@implementation Visitor2

- (void)visitorElementA:(ElementA *)elementA {
    NSLog(@"elementA 被 Visitor2 访问了");
}

- (void)visitorElementB:(ElementB *)elementB {
    NSLog(@"elementB 被 Visitor2 访问了");
}

@end
