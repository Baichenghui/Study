//
//  ProxyVC.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/3/31.
//  Copyright © 2020 hh. All rights reserved.
//

#import "ProxyVC.h"
#import "IGamePlayerProtocol.h"
#import "GamePlayerProxy.h"
#import "GamePlayer.h"

@interface ProxyVC ()

@end

@implementation ProxyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //玩家
    id<IGamePlayerProtocol> player = [GamePlayer new];
    
    //代练
    GamePlayerProxy *proxy = [GamePlayerProxy new];
    proxy.delegate = player;
    [proxy playGame];
    
    /**
     2020-04-03 14:52:40.678178+0800 DesignPatternDemo[47337:1495850] 玩游戏
        最终也只是：玩游戏
        但是现在玩游戏已经是通过调用代理的playGame方法完成的
     */
    
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
