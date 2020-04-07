//
//  ChainManagerLevel1.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import "ChainManagerLevel1.h"

@implementation ChainManagerLevel1

- (void)request:(NSInteger)num {
    if (num <= 1) {
        NSLog(@"ChainManagerLevel1 审批通过");
    }
    else {
        [self.chain request:num];
    }
}

@end
