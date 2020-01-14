//
//  Person.m
//  CopyTest
//
//  Created by 白成慧&瑞瑞 on 2019/3/16.
//  Copyright © 2019 白成慧. All rights reserved.
//

#import "Person.h"

@interface Person()<NSCopying>

@end

@implementation Person

-(id)copyWithZone:(NSZone *)zone {
    Person *p = [[self class] allocWithZone:zone];
//    p.name = _name ;
//    p.age = _age;
    
    p.name = [_name copy];
//    p.age = [_age copy];
    return p;
}

@end
