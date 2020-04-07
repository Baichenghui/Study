//
//  SimpleHouse.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import "SimpleHouse.h"

@implementation SimpleHouse

- (void)showFuntion {
    [super showFuntion];
    
    [self live];
}

- (void)live {
    NSLog(@"房子可用来居住了");  
}

@end
