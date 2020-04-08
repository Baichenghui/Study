//
//  USA.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/8.
//  Copyright © 2020 hh. All rights reserved.
//

#import "USA.h"

@implementation USA

- (void)declare:(NSString *)msg {
    [self.meditor declare:msg country:self];
}
- (void)getMsg:(NSString *)msg {
    NSLog(@"美国获得消息：%@",msg);
}
 
@end
