//
//  AccessUser.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "AccessUser.h"

@implementation AccessUser

- (User *)getObj {
    NSLog(@"Access 获取 User");
    return nil;
}

- (void)insert:(User *)obj {
    NSLog(@"Access insert User");
}

@end
