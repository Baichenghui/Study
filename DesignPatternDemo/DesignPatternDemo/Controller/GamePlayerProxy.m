//
//  GamePlayerProxy.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/3.
//  Copyright © 2020 hh. All rights reserved.
//

#import "GamePlayerProxy.h"

@interface GamePlayerProxy()
@end

@implementation GamePlayerProxy
 
- (void)playGame {
    if (self.delegate && [self.delegate respondsToSelector:@selector(playGame)]) {
        //代理玩游戏
        [self.delegate playGame];
    }
}

@end
