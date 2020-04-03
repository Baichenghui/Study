//
//  BaseSubject.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/3.
//  Copyright © 2020 hh. All rights reserved.
//

#import "AbstructSubject.h"

@interface AbstructSubject()
//注意线程不安全
@property (nonatomic,strong)NSMutableArray<id<IObserverProtocol>> *observerList;
@end

@implementation AbstructSubject

- (void)addObserver:(id<IObserverProtocol>)obs {
    [self.observerList addObject:obs];
}

- (void)removeObserver:(id<IObserverProtocol>)obs {
    [self.observerList removeObject:obs];
}

- (void)removeAllObservers {
    [self.observerList removeAllObjects];
}

- (void)notifyAllObservers {
    for (id<IObserverProtocol> obs in self.observerList) {
        [obs update];
    }
}

- (NSMutableArray<id<IObserverProtocol>> *)observerList {
    if (!_observerList) {
        _observerList = [NSMutableArray array];
    }
    return _observerList;
}

@end
