//
//  Adapter.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "Target.h"
#import "Adaptee.h"

NS_ASSUME_NONNULL_BEGIN

@interface Adapter : Target
@property (nonatomic,strong) Adaptee *adaptee;
@end

NS_ASSUME_NONNULL_END
