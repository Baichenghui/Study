//
//  AbstructCommand.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bubecurer.h"

NS_ASSUME_NONNULL_BEGIN

@interface AbstructCommand : NSObject
@property (nonatomic , strong) Bubecurer *bubecurer;
- (instancetype)initWithBubeacur:(Bubecurer *)cur;
- (void)excuteCmd;
@end

NS_ASSUME_NONNULL_END
