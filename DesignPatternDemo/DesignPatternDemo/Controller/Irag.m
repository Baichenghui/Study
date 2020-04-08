//
//  Irag.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/8.
//  Copyright © 2020 hh. All rights reserved.
//

#import "Irag.h"

@implementation Irag

- (void)declare:(NSString *)msg {
    [self.meditor declare:msg country:self];
}

- (void)getMsg:(NSString *)msg {
    NSLog(@"伊拉克获得消息：%@",msg);
}
 
@end
