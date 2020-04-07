//
//  CommandVC.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/3/31.
//  Copyright © 2020 hh. All rights reserved.
//

#import "CommandVC.h"
#import "Bubecurer.h"
#import "Waiter.h"
#import "CommandA.h"
#import "CommandB.h"

@interface CommandVC ()

@end

@implementation CommandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Waiter *w = [Waiter new];
    
    Bubecurer *bb = [Bubecurer new];
    CommandA *ca = [[CommandA alloc] initWithBubeacur:bb];
    CommandB *cb = [[CommandB alloc] initWithBubeacur:bb];
    
    [w.list addObject:ca];
    [w.list addObject:cb];
    
    [w.list removeObject:ca];
    
    [w notify];
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
