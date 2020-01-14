//
//  TestObject.m
//  weak-strong解决循环引用
//
//  Created by 白成慧&瑞瑞 on 2019/3/9.
//  Copyright © 2019 白成慧. All rights reserved.
//

#import "TestObject.h"

@implementation TestObject

- (void)dealloc {
    NSLog(@"TestObject dealloc");
}

@end
