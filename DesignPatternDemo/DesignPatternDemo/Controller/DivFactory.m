//
//  DivFactory.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "DivFactory.h"
#import "OperationDiv.h"

@implementation DivFactory

- (id<IOperationProtocol>)createOperation {
    return [OperationDiv new];
}

@end
