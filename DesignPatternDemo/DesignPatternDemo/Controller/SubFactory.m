//
//  SubFactory.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "SubFactory.h"
#import "OperationSub.h"

@implementation SubFactory
 
- (id<IOperationProtocol>)createOperation {
    return [OperationSub new];
}

@end
