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

    PrototypeModel *model3 = [model1 copy];
    model3.name = @"Tim";
    NSLog(@"model3:%@---name:%@---hobby:%@---age:%d",model3,model3.name,model3.hobby,model3.age);

    NSMutableArray<PrototypeModel *> *array1 = [NSMutableArray arrayWithObject:model1];
    NSMutableArray<PrototypeModel *> *array2 = [array1 copy];
    NSLog(@"array1:%p model:%@",array1,array1[0]);
    NSLog(@"array2:%p model:%@",array2,array2[0]);
    
    NSArray *array3 = @[model1];
    NSArray *array4 = [array3 copy];
    NSLog(@"array3:%p model:%@",array3,array3[0]);
    NSLog(@"array4:%p model:%@",array4,array4[0]);
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
