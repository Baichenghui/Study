//
//  AbstructCommand.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import "AbstructCommand.h"

@interface AbstructCommand()
@end

@implementation AbstructCommand
 
- (instancetype)initWithBubeacur:(Bubecurer *)cur {
    if (self = [super init]) {
        self.bubecurer = cur;
    }
    return self;
}

- (void)excuteCmd {
    //子类执行
}

@end
