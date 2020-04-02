//
//  PrototypeVC.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/3/31.
//  Copyright © 2020 hh. All rights reserved.
//

//原型模式



#import "PrototypeVC.h"
#import "PrototypeModel.h"

@interface PrototypeVC ()

@end

@implementation PrototypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PrototypeModel *model1 = [PrototypeModel new];
    model1.age = 10;
    model1.name = @"jack";
    model1.hobby = @"basketball";
     
    NSLog(@"model1:%@---name:%@---hobby:%@---age:%d",model1,model1.name,model1.hobby,model1.age);
    
    PrototypeModel *model2 = [model1 clone];
    model2.name = @"rose";
    NSLog(@"model2:%@---name:%@---hobby:%@---age:%d",model2,model2.name,model2.hobby,model2.age);
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
