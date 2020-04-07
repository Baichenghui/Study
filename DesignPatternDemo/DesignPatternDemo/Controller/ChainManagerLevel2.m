//
//  ChainManagerLevel2.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import "ChainManagerLevel2.h"

@implementation ChainManagerLevel2

- (void)request:(NSInteger)num {
    if (num <= 2) {
        NSLog(@"ChainManagerLevel2 审批通过");
    }
    else {
        [self.chain request:num];
    }
}

@end
