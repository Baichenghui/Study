//
//  AbstructFactoryVC.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/3/31.
//  Copyright © 2020 hh. All rights reserved.
//

#import "AbstructFactoryVC.h"
#import "SqlserverFactory.h"
#import "AccessFactory.h"
#import "User.h"
#import "Department.h"

@interface AbstructFactoryVC ()

@end

@implementation AbstructFactoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self test];
}

- (void)test {
    //替换成Sqlserver
//    id<IAbstructFactoryProtocol> factory = [SqlserverFactory new];
    //替换成Access
    id<IAbstructFactoryProtocol> factory = [AccessFactory new];
    
    id<IDepartmentProtocol> dpt = [factory createDpt];
    [dpt getObj];
    [dpt insert:[Department new]];
    
    id<IUserProtocol> user = [factory createUser];
    [user getObj];
    [user insert:[User new]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
