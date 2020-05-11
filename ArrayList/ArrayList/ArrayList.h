//
//  ArrayList.h
//  ArrayList
//
//  Created by tianxi on 2020/5/11.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
 
@interface ArrayList<E> : NSObject
 
- (instancetype)initWithCapacity:(NSUInteger)capacity;

/// 元素的数量
- (NSUInteger)size;

/// 是否为空
- (BOOL)isEmpty;

/// 是否包含某个元素
- (BOOL)contains:(E)element;

/// 添加元素到最后面
- (void)add:(E)element;

/// 返回index位置对应的元素
- (E)get:(NSUInteger)index;

/// 设置index位置的元素
- (void)set:(NSUInteger)index element:(E)element;

/// 往index位置添加元素
- (void)add:(E)element atIndex:(NSUInteger)index;

/// 删除index位置对应的元素
- (E)remove:(NSUInteger)index;

/// 查看元素的位置
- (NSUInteger)indexOf:(E)element;

/// 清除所有元素
- (void)clear;

@end

NS_ASSUME_NONNULL_END
