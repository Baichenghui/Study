//
//  SqlserverFactory.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "SqlserverFactory.h"
#import "SqlserverDepartment.h"
#import "SqlserverUser.h"

@implementation SqlserverFactory

- (id<IDepartmentProtocol>)createDpt { 
    return [SqlserverDepartment new];
}

- (id<IUserProtocol>)createUser { 
    return [SqlserverUser new];
}

@end
