//
//  StateB.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import "StateB.h"
#import "StateC.h"
#import "Work.h"


@implementation StateB

- (void)handle:(Work *)work {
    if (work.hours <= 18) {
        NSLog(@"下午工作  效率一般");
    }
    else {
        work.currentState = [StateC new];
        [work doWork];
    }
}

@end
