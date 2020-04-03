//
//  BaseSubject.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/3.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IObserverProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AbstructSubject : NSObject

@property (nonatomic,strong,readonly)NSMutableArray<id<IObserverProtocol>> *observerList;

- (void)addObserver:(id<IObserverProtocol>)obs;
- (void)removeObserver:(id<IObserverProtocol>)obs;
- (void)removeAllObservers; 
- (void)notifyAllObservers;

@end

NS_ASSUME_NONNULL_END
