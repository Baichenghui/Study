//
//  BCHProxy.m
//  TestTimer
//
//  Created by 白成慧&瑞瑞 on 2019/3/15.
//  Copyright © 2019 白成慧. All rights reserved.
//

#import "BCHProxy.h"

@implementation BCHProxy

+(instancetype)proxyWithTarget:(id)target {
    BCHProxy *proxy = [[BCHProxy alloc] init];
    proxy.target = target;
    return proxy;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.target;
}

@end
