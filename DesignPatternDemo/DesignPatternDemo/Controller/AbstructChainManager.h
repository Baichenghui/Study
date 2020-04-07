//
//  CORManager.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AbstructChainManager : NSObject
@property (nonatomic,weak,readonly) AbstructChainManager *chain;

- (void)configChain:(AbstructChainManager *)chain;
- (void)request:(NSInteger)num;

@end

NS_ASSUME_NONNULL_END
