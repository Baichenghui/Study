//
//  OperationSub.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "OperationSub.h"

@implementation OperationSub 
@synthesize numA = _numA;
@synthesize numB = _numB;

- (CGFloat)getResult {
    return _numA - _numB;
}

@end
