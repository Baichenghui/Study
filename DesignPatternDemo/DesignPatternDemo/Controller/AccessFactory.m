//
//  AccessFactory.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "AccessFactory.h"
#import "AccessDepartment.h"
#import "AccessUser.h"

@implementation AccessFactory

- (id<IDepartmentProtocol>)createDpt {
    return [AccessDepartment new];
}

- (id<IUserProtocol>)createUser {
    return [AccessUser new];
}

@end
