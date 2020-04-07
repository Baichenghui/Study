//
//  ChainManagerLevel3.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import "ChainManagerLevel3.h"

@implementation ChainManagerLevel3

- (void)request:(NSInteger)num {
    if (num <= 3) {
        NSLog(@"ChainManagerLevel3 审批通过");
    }
    else {
        NSLog(@"ChainManagerLevel3 不批");
    }
}

@end
