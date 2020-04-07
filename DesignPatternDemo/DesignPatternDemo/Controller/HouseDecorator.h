//
//  HouseDecorator.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IHouseProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HouseDecorator : NSObject<IHouseProtocol>

- (void)decorator:(id<IHouseProtocol>) house;

@end

NS_ASSUME_NONNULL_END
