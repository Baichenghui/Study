//
//  ConcreteSubject.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/3.
//  Copyright © 2020 hh. All rights reserved.
//

#import "ConcreteSubject.h"

@implementation ConcreteSubject

//做具体业务
- (void)doSomething {
    //
    [self notifyAllObservers];
}

@end
