//
//  SingletonManager.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/2.
//  Copyright © 2020 hh. All rights reserved.
//

#import "SingletonManager.h"

@interface SingletonManager()

@end

@implementation SingletonManager

static SingletonManager *instance;

// 线程不安全
//+ (instancetype)shareManager {
//    if (instance == nil) {
//        instance = [SingletonManager new];
//    }
//    return instance;
//}

////双重判空
//+ (instancetype)shareManager {
//
//    //第一层判空，原因是同步锁消耗性能，没必要每次都去加锁，只有需要创建对象的时候去加锁
//    if (instance == nil) {
//        @synchronized (self) {
//            //第二层判空，原因是多线程情况下，可能多个线程进入第一层判空的if语句，这时同步块内部代码可能执行多次造成实例多次创建。
//            if (instance == nil) {
//                instance = [SingletonManager new];
//            }
//        }
//    }
//    return instance;
//}

//OC中一般使用gcd一次性函数配合实现单例，高性能
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [SingletonManager new];
    });
     
    return instance;
}

//allocWithZone:这个方法是对象创建,比如使用alloc ]init];会走的方法
//alloc 方法 只是去调用allocWithZone:方法，进行内存分配
//+ (id)allocWithZone:(struct _NSZone *)zone {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        //确保使用同一块内存地址
//        instance = [super allocWithZone:zone];
//    });
//    return instance;
//}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [SingletonManager shareManager];
}

  
//+ (id)copyWithZone:(struct _NSZone *)zone {
//    return instance;
//}

+ (id)copyWithZone:(struct _NSZone *)zone {
    return [SingletonManager shareManager];
}

@end
