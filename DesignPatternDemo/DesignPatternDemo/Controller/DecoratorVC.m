//
//  DecoratorVC.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/3/31.
//  Copyright © 2020 hh. All rights reserved.
//

#import "DecoratorVC.h"
#import "SimpleHouse.h"
#import "RoughHouse.h"

@interface DecoratorVC ()

@end

@implementation DecoratorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    RoughHouse *rHouse = [RoughHouse new];
    SimpleHouse *sHouse = [SimpleHouse new];
    //shouse 装饰了 rhouse,动态的给rhouse增加了功能。
    //原本rhouse只能用来交易，包装成sHouse之后可以用来居住了
    [sHouse decorator:rHouse];
    [sHouse showFuntion];
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
