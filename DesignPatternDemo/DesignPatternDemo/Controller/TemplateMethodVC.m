//
//  TemplateMethodVC.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/3/31.
//  Copyright © 2020 hh. All rights reserved.
//

#import "TemplateMethodVC.h"
#import "ConcreteTemplate.h"

@interface TemplateMethodVC ()

@end

@implementation TemplateMethodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ConcreteTemplate *ct = [ConcreteTemplate new];
    [ct temp];
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
