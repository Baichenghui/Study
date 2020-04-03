//
//  MementoVC.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/3/31.
//  Copyright © 2020 hh. All rights reserved.
//

#import "MementoVC.h"
#import "GameCaretaker.h"
#import "GameRole.h"

@interface MementoVC ()

@end

@implementation MementoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    GameRole *role = [GameRole new];
    role.value = @"100";
    
    //保存开打之前的状态 
    GameCaretaker *caretaker = [GameCaretaker new];
    caretaker.memeno = [role saveState];
    NSLog(@"value1: %@",role.value);
    
    //继续打，掉血20，变成80
    role.value = @"80";
    NSLog(@"value2: %@",role.value);
    
    //感觉掉血太多，想恢复到d开打之前的状态
    [role recovery:caretaker.memeno];
    NSLog(@"value3: %@",role.value);
    
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
