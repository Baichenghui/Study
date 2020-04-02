//
//  Director.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "BuilderDirector.h"

@interface BuilderDirector()

@end

@implementation BuilderDirector

- (void)builderWithbuilder:(id<IDateBuilderProtocol>)builder {
    NSString *date = [builder dateFormat:@"yyyy-MM-dd"];
    NSLog(@"date:%@",date);
}

@end
