//
//  ConcreteUnitedNations.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/8.
//  Copyright © 2020 hh. All rights reserved.
//

#import "ConcreteUnitedNations.h"


@implementation ConcreteUnitedNations

- (void)declare:(NSString *)msg country:(AbstructCountry *)country {
    if ([country isMemberOfClass:[USA class]]) {
        [self.c2 getMsg:msg];
    }
    else {
        [self.c1 getMsg:msg];
    }
}

@end
