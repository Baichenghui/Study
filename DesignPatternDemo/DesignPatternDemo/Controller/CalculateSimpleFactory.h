//
//  CalculateFactory.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IOperationProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface CalculateSimpleFactory : NSObject

+ (id<IOperationProtocol>)createOperationWithType:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
