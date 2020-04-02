//
//  PrototypeModel.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "PrototypeModel.h"

@implementation PrototypeModel

- (id)clone {
    PrototypeModel *model = [PrototypeModel new];
    model.age = self.age;
    model.name = self.name;
    model.hobby = self.hobby;
    return model;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return [[self class] allocWithZone:zone];
}

@end
