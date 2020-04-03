//
//  StrategyVC.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/3/31.
//  Copyright © 2020 hh. All rights reserved.
//

/**
    为音频播放列表的不同播放模式提供获取上一首、下一首、当前播放的接口
    策略模式封装了不同播放模式下获取音频的算法
 */

#import "StrategyVC.h"
#import "StrategyContext.h"

@interface StrategyVC ()

@end

@implementation StrategyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    StrategyContext *context = [[StrategyContext alloc] initWithType:@"Random"];
    StrategyContext *context = [[StrategyContext alloc] initWithType:@"Normal"];
//    StrategyContext *context = [[StrategyContext alloc] initWithType:@"Single"];
    
    id<IStrategyProtocol> strategy = [context getStrategy];
    [strategy current];
    [strategy previous];
    [strategy next];
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
