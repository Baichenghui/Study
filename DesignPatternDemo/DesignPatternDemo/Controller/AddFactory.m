//
//  CalculateFactory.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "AddFactory.h"
#import "OperationAdd.h"

@implementation AddFactory

- (id<IOperationProtocol>)createOperation {
    return [OperationAdd new];
}

@end
