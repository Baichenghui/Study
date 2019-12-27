//
//  TDManager.m
//  threadDemo
//
//  Created by tianxi on 2019/12/20.
//  Copyright © 2019 hh. All rights reserved.
//

#import "TDManager.h"

/*
  alloc 和 allocWithZone 有啥区别呢？
 
    初始化一个对象的时候， [[Class alloc] init]，其实是做了两件事。
    alloc 给对象分配内存空间，init是对对象的初始化，包括设置成员变量初值这些工作。
 
    给对象分配空间，除了alloc方法之外，还有另一个方法： allocWithZone.
    在NSObject 这个类的官方文档(https://developer.apple.com/documentation/objectivec/nsobject)里面，
    allocWithZone方法介绍说，该方法的参数是被忽略的，正确的做法是传nil或者NULL参数给它。而这个方法之所以存在，是历史遗留原因。
 
    实践证明，使用alloc方法初始化一个类的实例的时候，默认是调用了 allocWithZone 的方法。
    于是覆盖allocWithZone方法的原因已经很明显了：为了保持单例类实例的唯一性，需要覆盖所有会生成新的实例的方法
 
 为了避免copy和mutbleCopy 创建新对象，必须实现协议 <NSCopying,NSMutableCopying>，重写 copyWithZone 和 mutableCopyWithZone 方法。
 */

@interface TDManager()<NSCopying,NSMutableCopying>

@end

static id manager = nil;

@implementation TDManager
 
+ (instancetype)shareManager {
    return [[self alloc] init];
}

- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super init];
    });
    return manager;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
    });
    return manager;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return manager;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return manager;
}

@end
