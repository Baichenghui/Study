//
//  Waiter.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstructCommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface Waiter : NSObject
@property (nonatomic,strong)NSMutableArray <AbstructCommand *> *list;

- (void)notify;
@end

NS_ASSUME_NONNULL_END
