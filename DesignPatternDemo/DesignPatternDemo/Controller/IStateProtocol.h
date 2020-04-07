//
//  IStateProtocol.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

@class Work;

@protocol IStateProtocol <NSObject>

- (void)handle:(Work *)work;

@end
