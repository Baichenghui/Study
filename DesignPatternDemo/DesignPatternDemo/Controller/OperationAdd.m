//
//  OperationAdd.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "OperationAdd.h"

@implementation OperationAdd  
@synthesize numA = _numA;
@synthesize numB = _numB;

- (CGFloat)getResult {
    return _numA + _numB;
}

@end
