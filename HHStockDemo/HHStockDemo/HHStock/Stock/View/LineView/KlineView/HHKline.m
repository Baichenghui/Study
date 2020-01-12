//
//  HHKline.m
//  HHStockDemo
//
//  Created by 白成慧&瑞瑞 on 2020/1/11.
//  Copyright © 2020 hh. All rights reserved.
//

#import "HHKline.h"
#import "UIColor+HHStock.h"
#import "HHLinePositionModel.h"
#import "HHStockVariable.h"
#import "HHStockConstant.h"
#import "HHDataModelProtocol.h"

@interface HHKline()

@property (nonatomic, assign) CGContextRef context;
/**
 *  K线的位置model
 */
@property (nonatomic, strong) NSArray <HHLinePositionModel *>*linePositionModels;

/**
 *  K线的位置model
 */
@property (nonatomic, strong) NSArray <id<HHDataModelProtocol>> *drawLineModels;

@end

@implementation HHKline


- (instancetype)initWithContext:(CGContextRef)context drawModels:(NSArray <id<HHDataModelProtocol>>*)drawLineModels linePositionModels:(NSArray <HHLinePositionModel *>*)linePositionModels {
    self = [super init];
    if (self) {
        _context = context;
        _drawLineModels = drawLineModels;
        _linePositionModels = linePositionModels;
    }
    return self;
}

- (void)draw {
    if (!self.linePositionModels || !self.context) return;
    
    CGContextRef ctx = self.context;
    
    [self.linePositionModels enumerateObjectsUsingBlock:^(HHLinePositionModel * _Nonnull linePositionModel, NSUInteger idx, BOOL * _Nonnull stop) {
        UIColor *strokeColor;
        if ([[self.drawLineModels[idx] Open] floatValue] < [[self.drawLineModels[idx] Close] floatValue]) {
            strokeColor = [UIColor HHStock_increaseColor];
        } else if ([[self.drawLineModels[idx] Open] floatValue] > [[self.drawLineModels[idx] Close] floatValue]) {
            strokeColor = [UIColor HHStock_decreaseColor];
        } else {
            if ([[self.drawLineModels[idx] Open] floatValue] >= [[[self.drawLineModels[idx] preDataModel] Close] floatValue]) {
                strokeColor = [UIColor HHStock_increaseColor];
            } else {
                strokeColor = [UIColor HHStock_decreaseColor];
            }
        }
        
//        UIColor *strokeColor = [[self.drawLineModels[idx] Open] floatValue] <= [[self.drawLineModels[idx] Close] floatValue]? [UIColor HHStock_increaseColor] : [UIColor HHStock_decreaseColor];
        
        
        
        CGContextSetStrokeColorWithColor(ctx, strokeColor.CGColor);
        
        CGContextSetLineWidth(ctx, [HHStockVariable lineWidth]);
        const CGPoint solidPoints[] = {linePositionModel.OpenPoint, linePositionModel.ClosePoint};
        CGContextStrokeLineSegments(ctx, solidPoints, 2);
        
        CGContextSetLineWidth(ctx, HHStockShadowLineWidth);
        const CGPoint shadowPoints[] = {linePositionModel.HighPoint, linePositionModel.LowPoint};
        CGContextStrokeLineSegments(ctx, shadowPoints, 2);
        
        //绘制红色空心线
        CGFloat gap = 2.f;
        if ([[self.drawLineModels[idx] Open] floatValue] <= [[self.drawLineModels[idx] Close] floatValue] && ABS(linePositionModel.OpenPoint.y - linePositionModel.ClosePoint.y) > gap) {
            CGContextSetStrokeColorWithColor(ctx, [UIColor HHStock_bgColor].CGColor);
            CGContextSetLineWidth(ctx, [HHStockVariable lineWidth] - gap);
            const CGPoint solidPoints[] = {CGPointMake(linePositionModel.OpenPoint.x, linePositionModel.OpenPoint.y - gap/2.f),CGPointMake(linePositionModel.ClosePoint.x, linePositionModel.ClosePoint.y + gap/2.f)};
            CGContextStrokeLineSegments(ctx, solidPoints, 2);
        }
    }];

}


@end
