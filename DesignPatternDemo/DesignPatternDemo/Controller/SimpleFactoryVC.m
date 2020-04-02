//
//  SimpleFactoryVC.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/3/31.
//  Copyright © 2020 hh. All rights reserved.
//

#import "SimpleFactoryVC.h"
#import "CalculateSimpleFactory.h"

@interface SimpleFactoryVC ()

@end

@implementation SimpleFactoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTest];
    [self subTest];
    [self mulTest];
    [self divTest];
}

- (void)addTest {
    id<IOperationProtocol> operation = [CalculateSimpleFactory createOperationWithType:@"+"];
    operation.numA = 10;
    operation.numB = 20;
    CGFloat result = [operation getResult];
    NSLog(@"addTest result:%.f",result);
}

- (void)subTest {
    id<IOperationProtocol> operation = [CalculateSimpleFactory createOperationWithType:@"-"];
    operation.numA = 10;
    operation.numB = 20;
    CGFloat result = [operation getResult];
    NSLog(@"subTest result:%.f",result);
}

- (void)mulTest {
    id<IOperationProtocol> operation = [CalculateSimpleFactory createOperationWithType:@"*"];
    operation.numA = 10;
    operation.numB = 20;
    CGFloat result = [operation getResult];
    NSLog(@"mulTest result:%.f",result);
}

- (void)divTest {
    id<IOperationProtocol> operation = [CalculateSimpleFactory createOperationWithType:@"/"];
    operation.numA = 10;
    operation.numB = 20;
    CGFloat result = [operation getResult];
    NSLog(@"divTest result:%.f",result);
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
