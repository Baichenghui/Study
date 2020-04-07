//
//  StateC.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import "StateC.h"
#import "Work.h"


@implementation StateC

- (void)handle:(Work *)work {
    if (work.hours <= 22) {
        if (work.isCompeleted) {
            NSLog(@"工作完成   下班休息");
        }
        else {
            NSLog(@"工作没完成   努力加班");
        }
    }
    else {
        NSLog(@"太晚了  睡觉");
    }
}

@end
