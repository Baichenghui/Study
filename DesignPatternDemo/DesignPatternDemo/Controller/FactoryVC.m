//
//  FactoryVC.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/3/31.
//  Copyright © 2020 hh. All rights reserved.
//

#import "FactoryVC.h"

#import "IFactoryProtocol.h"
#import "AddFactory.h"
#import "SubFactory.h"
#import "MulFactory.h"
#import "DivFactory.h"

@interface FactoryVC ()

@end

@implementation FactoryVC
  
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTest];
    [self subTest];
    [self mulTest];
    [self divTest];
}

- (void)addTest {
    id<IFactoryProtocol> factory = [AddFactory new];
    id<IOperationProtocol> operation = [factory createOperation];
    operation.numA = 10;
    operation.numB = 20;
    CGFloat result = [operation getResult];
    NSLog(@"addTest result:%.f",result);
}

- (void)subTest {
    id<IFactoryProtocol> factory = [SubFactory new];
    id<IOperationProtocol> operation = [factory createOperation];
    operation.numA = 10;
    operation.numB = 20;
    CGFloat result = [operation getResult];
    NSLog(@"subTest result:%.f",result);
}

- (void)mulTest {
    id<IFactoryProtocol> factory = [MulFactory new];
    id<IOperationProtocol> operation = [factory createOperation];
    operation.numA = 10;
    operation.numB = 20;
    CGFloat result = [operation getResult];
    NSLog(@"mulTest result:%.f",result);
}

- (void)divTest {
    id<IFactoryProtocol> factory = [DivFactory new];
    id<IOperationProtocol> operation = [factory createOperation];
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
