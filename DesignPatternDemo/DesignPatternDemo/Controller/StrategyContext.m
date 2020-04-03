//
//  StrategyContext.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/3.
//  Copyright © 2020 hh. All rights reserved.
//

#import "StrategyContext.h"
#import "RandomStrategy.h"
#import "NoramlStrategy.h"
#import "SingleStrategy.h"

@interface StrategyContext()
@property (nonatomic,copy) NSString *strategyType;
@property (nonatomic,strong) id<IStrategyProtocol> strategy;
@end

@implementation StrategyContext
 
- (instancetype)initWithType:(NSString *)strategyType {
    if (self = [super init]) {
        _strategyType = strategyType;
        if ([strategyType isEqualToString:@"Random"]) {
            //Random
            _strategy = [RandomStrategy new];
        }
        else if ([strategyType isEqualToString:@"Single"]) {
            //Single
            _strategy = [SingleStrategy new];
        }
        else {
            //Normal
            _strategy = [NoramlStrategy new];
        }
    }
    return self;
}

- (id<IStrategyProtocol>)getStrategy {
    return _strategy;
}

@end
