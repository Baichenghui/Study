//
//  ConcreteObserver.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/3.
//  Copyright © 2020 hh. All rights reserved.
//

//具体的观察者

#import <Foundation/Foundation.h>
#import "IObserverProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConcreteObserver : NSObject<IObserverProtocol>

@end

NS_ASSUME_NONNULL_END
