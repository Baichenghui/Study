//
//  HouseDecorator.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import "HouseDecorator.h"

@interface HouseDecorator()

@property (nonatomic,strong) id<IHouseProtocol> decorator;

@end

@implementation HouseDecorator

- (void)decorator:(id<IHouseProtocol>) house {
    self.decorator = house;
}

- (void)showFuntion {
    if (self.decorator != nil) {
        [self.decorator showFuntion];
    }
}

@end
