//
//  BCHProxy1.m
//  TestTimer
//
//  Created by 白成慧&瑞瑞 on 2019/3/15.
//  Copyright © 2019 白成慧. All rights reserved.
//

#import "BCHProxy1.h"

@implementation BCHProxy1

+(instancetype)proxyWithTarget:(id)target {
    BCHProxy1 *proxy = [BCHProxy1 alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
