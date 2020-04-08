//
//  MediatorVC.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/3/31.
//  Copyright © 2020 hh. All rights reserved.
//

#import "MediatorVC.h"
#import "ConcreteUnitedNations.h"
#import "USA.h"
#import "Irag.h"

@interface MediatorVC ()

@end

@implementation MediatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ConcreteUnitedNations *cun = [ConcreteUnitedNations new];
    
    USA *usa = [[USA alloc] initWithMeditor:cun];
    Irag *irag = [[Irag alloc] initWithMeditor:cun];
    
    cun.c1 = usa;
    cun.c2 = irag;
    
    [usa declare:@"不准研究k核武器,否则我削你"];
    [irag declare:@"我没有研究，不怕你削我"];
    
    
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
