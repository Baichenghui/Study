//
//  CalculateFactory.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "CalculateFactory.h"
#import "OperationAdd.h"
#import "OperationSub.h"
#import "OperationMul.h"
#import "OperationDiv.h"


@implementation CalculateFactory

+ (id<IOperationProtocol>)createOperationWithType:(NSString *)type {
    if ([type isEqualToString:@"+"]) {
        return [OperationAdd new];
    }
    else if ([type isEqualToString:@"-"]) {
         return [OperationSub new];
    }
    else if ([type isEqualToString:@"*"]) {
         return [OperationMul new];
    }
    else if ([type isEqualToString:@"/"]) {
         return [OperationDiv new];
    }
    
    return nil;
}

@end
