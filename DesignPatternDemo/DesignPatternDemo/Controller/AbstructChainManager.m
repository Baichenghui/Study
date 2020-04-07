//
//  CORManager.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import "AbstructChainManager.h"

@interface AbstructChainManager()
@property (nonatomic,weak) AbstructChainManager *chain;
@end

@implementation AbstructChainManager

- (void)configChain:(AbstructChainManager *)chain {
    self.chain = chain;
}

- (void)request:(NSInteger)num {
    //子类实现
}

@end
