//
//  LCMemoryCache.h
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/26.
//  Copyright © 2019 hh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
*  缓存 主要是缓存节气信息
*/
@interface LCMemoryCache : NSObject
@property (nonatomic, assign) int current;
@property (nonatomic, strong) NSMutableDictionary *cache;

- (id _Nullable)get:(id)key;
- (void)setKey:(id)key value:(id)value;
- (void)clear;
@end

NS_ASSUME_NONNULL_END
