//
//  HHKline.h
//  HHStockDemo
//
//  Created by 白成慧&瑞瑞 on 2020/1/11.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "HHDataModelProtocol.h"

@class HHLinePositionModel;

NS_ASSUME_NONNULL_BEGIN

@interface HHKline : NSObject

- (instancetype)initWithContext:(CGContextRef)context
                     drawModels:(NSArray <id<HHDataModelProtocol>>*)drawLineModels
             linePositionModels:(NSArray <HHLinePositionModel *>*)linePositionModels;

- (void)draw;

@end

NS_ASSUME_NONNULL_END
