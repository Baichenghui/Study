//
//  IUserProtocol.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

//Dao层

#import "User.h"

@protocol IUserProtocol <NSObject>

- (void)insert:(User *)obj;
- (User *)getObj;

@end
