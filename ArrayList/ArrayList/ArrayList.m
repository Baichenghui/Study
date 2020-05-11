//
//  ArrayList.m
//  ArrayList
//
//  Created by tianxi on 2020/5/11.
//  Copyright © 2020 hh. All rights reserved.
//

#import "ArrayList.h"

static const NSUInteger DEFAULT_CAPACITY = 10;
static const NSUInteger ELEMENT_NOT_FOUND = -1;

@interface ArrayList<E>()

@property (nonatomic,assign) NSUInteger pSize;
@property (nonatomic,assign) NSUInteger pCapacity;

@end


@implementation ArrayList
  
- (instancetype)initWithCapacity:(NSUInteger)capacity {
    if (self = [self init]) {
        if (capacity < DEFAULT_CAPACITY) {
            capacity = DEFAULT_CAPACITY;
        }
        self.pCapacity = capacity;
    }
    return self;
}

- (instancetype)init {
    return [self initWithCapacity:DEFAULT_CAPACITY];
}

/// 元素的数量
- (NSUInteger)size {
    return self.pSize;
}

/// 是否为空
- (BOOL)isEmpty {
    return self.pSize == 0;
}

/// 是否包含某个元素
- (BOOL)contains:(id)element {
    return NO;
}

/// 添加元素到最后面
- (void)add:(id)element {
    
}

/// 返回index位置对应的元素
- (id)get:(NSUInteger)index {
    return nil;
}

/// 设置index位置的元素
- (void)set:(NSUInteger)index element:(id)element {
    
}

/// 往index位置添加元素
- (void)add:(id)element atIndex:(NSUInteger)index {
    
}

/// 删除index位置对应的元素
- (id)remove:(NSUInteger)index {
    return nil;
}

/// 查看元素的位置
- (NSUInteger)indexOf:(id)element {
    return ELEMENT_NOT_FOUND;
}

/// 清除所有元素
- (void)clear {
    
}

@end
