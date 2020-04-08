//
//  VisitorVC.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/3/31.
//  Copyright © 2020 hh. All rights reserved.
//

#import "VisitorVC.h"
#import "ObjectStruct.h"
#import "ElementA.h"
#import "ElementB.h"
#import "Visitor1.h"
#import "Visitor2.h"

@interface VisitorVC ()

@end

@implementation VisitorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ObjectStruct *os = [ObjectStruct new];
    [os.list addObject:[ElementA new]];
    [os.list addObject:[ElementB new]];
    
    Visitor1 *v1 = [Visitor1 new];
    Visitor2 *v2 = [Visitor2 new];
    
    [os accept:v1];
    [os accept:v2];
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
