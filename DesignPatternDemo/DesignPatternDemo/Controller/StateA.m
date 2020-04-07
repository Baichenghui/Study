//
//  State.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import "StateA.h"
#import "StateB.h"
#import "Work.h"

@implementation StateA
 
- (void)handle:(Work *)work {
    if (work.hours <= 12) {
        NSLog(@"上午工作  精神抖擞");
    }
    else {
        work.currentState = [StateB new];
        [work doWork];
    }
}

@end
