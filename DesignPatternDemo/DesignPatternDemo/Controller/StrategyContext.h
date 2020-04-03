//
//  StrategyContext.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/3.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IStrategyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface StrategyContext : NSObject

- (instancetype)initWithType:(NSString *)strategyType;

- (id<IStrategyProtocol>)getStrategy;

@end

NS_ASSUME_NONNULL_END
