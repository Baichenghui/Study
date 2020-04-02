//
//  AccessDepartment.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "AccessDepartment.h"

@implementation AccessDepartment

- (Department *)getObj {
    NSLog(@"Access 获取 dpt");
    return nil;
}

- (void)insert:(Department *)obj {
    NSLog(@"Access insert dpt");
}

@end
