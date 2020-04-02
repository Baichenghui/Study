//
//  MulFactory.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "MulFactory.h"
#import "OperationMul.h"

@implementation MulFactory

- (id<IOperationProtocol>)createOperation {
    return [OperationMul new];
}

@end
