//
//  ConcreteSubject.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/3.
//  Copyright © 2020 hh. All rights reserved.
//

//具体的被观察者

#import "AbstructSubject.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConcreteSubject : AbstructSubject
- (void)doSomething;
@end

NS_ASSUME_NONNULL_END
