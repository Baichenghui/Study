
//
//  IDepartmentProtocol.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "Department.h"

@protocol IDepartmentProtocol <NSObject>

- (void)insert:(Department *)obj;
- (Department *)getObj;

@end
