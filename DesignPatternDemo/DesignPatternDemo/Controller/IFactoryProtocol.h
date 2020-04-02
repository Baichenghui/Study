//
//  IFactoryProtocol.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "IOperationProtocol.h"

@protocol IFactoryProtocol <NSObject>

- (id<IOperationProtocol>)createOperation;
//+ (id<IOperationProtocol>)createOperation;

@end
