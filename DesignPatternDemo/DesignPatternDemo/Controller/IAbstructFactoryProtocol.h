//
//  IAbstructFactoryProtocol.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "IUserProtocol.h"
#import "IDepartmentProtocol.h"

@protocol IAbstructFactoryProtocol <NSObject>

- (id<IUserProtocol>)createUser;
- (id<IDepartmentProtocol>)createDpt;

@end
