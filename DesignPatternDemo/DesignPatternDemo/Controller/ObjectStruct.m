//
//  ObjectStruct.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/8.
//  Copyright © 2020 hh. All rights reserved.
//

#import "ObjectStruct.h"

@implementation ObjectStruct

- (void)accept:(id<IVisitorProtocol>)visitor {
    for (id<IElementProtocol> cmd in self.list) {
        [cmd accept:visitor];
    }
}

- (NSMutableArray<id<IElementProtocol>> *)list {
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}

@end
