//
//  IStrategyProtocol.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/3.
//  Copyright © 2020 hh. All rights reserved.
//

#import "IMediaProtocol.h"
 
@protocol IStrategyProtocol <NSObject>
 
- (id<IMediaProtocol>)previous;
- (id<IMediaProtocol>)next;
- (id<IMediaProtocol>)current;

@end
