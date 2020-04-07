//
//  StateVC.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/3/31.
//  Copyright © 2020 hh. All rights reserved.
//

#import "StateVC.h"
#import "StateA.h"
#import "StateB.h"
#import "StateC.h"
#import "Work.h"

@interface StateVC ()

@end

@implementation StateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Work *w = [[Work alloc] init];
    w.hours = 10;
    [w doWork];
    w.hours = 13;
    [w doWork];
    w.hours = 18;
    [w doWork];
    w.hours = 20;
    [w doWork];
    w.hours = 22;
    w.isCompeleted = YES;
    [w doWork];

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
