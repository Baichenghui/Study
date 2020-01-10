//
//  HHVolumePositionModel.h
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHVolumePositionModel : NSObject

/**
 *  开始点
 */
@property (nonatomic, assign) CGPoint StartPoint;

/**
 *  结束点
 */
@property (nonatomic, assign) CGPoint EndPoint;

/**
 *  日期
 */
@property (nonatomic, copy) NSString *DayDesc;

/**
 *  工厂方法
 */
+ (instancetype) modelWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint dayDesc:(NSString *)dayDesc;

@end

NS_ASSUME_NONNULL_END
