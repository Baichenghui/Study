//
//  HHKlineView.m
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

#import "HHKlineView.h"

#import "HHKlineView.h"
#import "HHStockVariable.h"
#import "HHStockConstant.h"
#import "UIColor+HHStock.h"
#import "HHLinePositionModel.h" 

//#import "HHKline.h"


static inline bool isEqualZero(float value)
{
    return fabsf(value) <= 0.00001f;
}

@interface HHKlineView()

@property (nonatomic, strong) NSMutableArray *drawPositionModels;

@property (nonatomic, strong) NSArray <id<HHDataModelProtocol>>*drawLineModels;

@property (nonatomic, strong) NSMutableArray *MA5Positions;
@property (nonatomic, strong) NSMutableArray *MA10Positions;
@property (nonatomic, strong) NSMutableArray *MA20Positions;

@property (nonatomic,strong) CAShapeLayer *redLayer;
@property (nonatomic,strong) CAShapeLayer *greenLayer;

@end

@implementation HHKlineView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize {
    [self initLayer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (void)drawRect:(CGRect)rect {
//    [super drawRect:rect];
//
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    if (!self.drawPositionModels) {
//        return;
//    }
//
//    if (self.drawPositionModels.count > 0) {
//        HHKline *line = [[HHKline alloc] initWithContext:ctx drawModels:self.drawLineModels linePositionModels:self.drawPositionModels];
//        [line draw];
//    }
//}

- (void)initLayer {
    if (!self.redLayer) {
        self.redLayer = [CAShapeLayer layer];
        self.redLayer.lineWidth = HHStockShadowLineWidth;
        self.redLayer.fillColor = [UIColor HHStock_increaseColor].CGColor;
        self.redLayer.strokeColor = [UIColor HHStock_increaseColor].CGColor;
        [self.layer addSublayer:self.redLayer];
    }
      
    if (!self.greenLayer) {
        self.greenLayer = [CAShapeLayer layer];
        self.greenLayer.lineWidth = HHStockShadowLineWidth;
        self.greenLayer.fillColor = [UIColor HHStock_decreaseColor].CGColor;
        self.greenLayer.strokeColor = [UIColor HHStock_decreaseColor].CGColor;
        [self.layer addSublayer:self.greenLayer];
    }
}

- (void)draw {
    if (!self.drawPositionModels) {
        return;
    }
    
    if (self.drawPositionModels.count > 0) {
         [self drawCandleSublayers];
    }
    
    if(self.MA5Positions.count > 0) {
        
    }
    
    if(self.MA10Positions.count > 0) {
        
    }
    
    if(self.MA20Positions.count > 0) {
        
    }
}

- (void)drawCandleSublayers {
    CGMutablePathRef redRef = CGPathCreateMutable();
    CGMutablePathRef greenRef = CGPathCreateMutable();
    [self.drawPositionModels enumerateObjectsUsingBlock:^(HHLinePositionModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.OpenPoint.y < model.ClosePoint.y) {
            [self addCandleRef:redRef postion:model];
        }
        else if (model.OpenPoint.y > model.ClosePoint.y) {
            [self addCandleRef:greenRef postion:model];
        }
        else {
            [self addCandleRef:redRef postion:model];
        }
    }];
     
    self.redLayer.path = redRef;
    self.greenLayer.path = greenRef;
}

- (void)addCandleRef:(CGMutablePathRef)ref postion:(HHLinePositionModel*)postion {
    //k线柱绘制
    CGFloat openPrice = postion.OpenPoint.y;
    CGFloat closePrice = postion.ClosePoint.y;
    CGFloat hightPrice = postion.HighPoint.y;
    CGFloat lowPrice = postion.LowPoint.y;
    CGFloat x = postion.OpenPoint.x;
     
    CGFloat y = openPrice > closePrice ? (closePrice) : (openPrice);
    CGFloat height = MAX(fabs(closePrice-openPrice), HHStockLineMinThick);
    CGRect rect = CGRectMake(x, y, [HHStockVariable lineWidth], height);
    
    if (isEqualZero(fabs(closePrice-openPrice))) {
        rect = CGRectMake(x, closePrice - height, [HHStockVariable lineWidth], height);
    }
    CGPathAddRect(ref, NULL, rect);
    
    //上、下影线绘制
    CGFloat xPostion = x + [HHStockVariable lineWidth] / 2;
    if (closePrice < openPrice) {
        if (!isEqualZero(closePrice - hightPrice)) {
            CGPathMoveToPoint(ref, NULL, xPostion, closePrice);
            CGPathAddLineToPoint(ref, NULL, xPostion, hightPrice);
        }
        
        if (!isEqualZero(lowPrice - openPrice)) {
            CGPathMoveToPoint(ref, NULL, xPostion, lowPrice);
            CGPathAddLineToPoint(ref, NULL, xPostion, openPrice + HHStockShadowLineWidth / 2.f);
        }
    }
    else {
        if (!isEqualZero(openPrice - hightPrice)) {
            CGPathMoveToPoint(ref, NULL, xPostion, openPrice);
            CGPathAddLineToPoint(ref, NULL, xPostion, hightPrice);
        }
        
        if (!isEqualZero(lowPrice - closePrice)) {
            CGPathMoveToPoint(ref, NULL, xPostion, lowPrice);
            CGPathAddLineToPoint(ref, NULL, xPostion, closePrice - HHStockShadowLineWidth);
        }
    }
}

- (NSArray *)drawViewWithXPosition:(CGFloat)xPosition drawModels:(NSMutableArray <id<HHDataModelProtocol>>*)drawLineModels  maxValue:(CGFloat)maxValue minValue:(CGFloat)minValue {
    NSAssert(drawLineModels, @"数据源不能为空");
    //转换为实际坐标
    [self convertToPositionModelsWithXPosition:xPosition drawLineModels:drawLineModels maxValue:maxValue minValue:minValue];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self draw];
    });
    return [self.drawPositionModels copy];
}

- (NSArray *)convertToPositionModelsWithXPosition:(CGFloat)startX drawLineModels:(NSArray <id<HHDataModelProtocol>>*)drawLineModels  maxValue:(CGFloat)maxValue minValue:(CGFloat)minValue {
    if (!drawLineModels) return nil;

    _drawLineModels = drawLineModels;
    [self.drawPositionModels removeAllObjects];
    [self.MA5Positions removeAllObjects];
    [self.MA10Positions removeAllObjects];
    [self.MA20Positions removeAllObjects];

    CGFloat minY = HHStockLineMainViewMinY;
    CGFloat maxY = self.frame.size.height - HHStockLineMainViewMinY;
    CGFloat unitValue = (maxValue - minValue)/(maxY - minY);
    if (unitValue == 0) unitValue = 0.01f;
    
    [drawLineModels enumerateObjectsUsingBlock:^(id<HHDataModelProtocol>  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat xPosition = startX + idx * ([HHStockVariable lineWidth] + [HHStockVariable lineGap]);
//        NSLog(@"xPosition:%f",xPosition);
        CGPoint highPoint = CGPointMake(xPosition, ABS(maxY - (model.High.floatValue - minValue)/unitValue));
        CGPoint lowPoint = CGPointMake(xPosition, ABS(maxY - (model.Low.floatValue - minValue)/unitValue));
        CGPoint openPoint = CGPointMake(xPosition, ABS(maxY - (model.Open.floatValue - minValue)/unitValue));
        CGFloat closePointY = ABS(maxY - (model.Close.floatValue - minValue)/unitValue);
        
        //格式化openPoint和closePointY
        if(ABS(closePointY - openPoint.y) < HHStockLineMinThick) {
            NSLog(@"closePointY:%f",closePointY);
            NSLog(@"openPointY:%f",openPoint.y);
 
            if(openPoint.y > closePointY) {
                openPoint.y = closePointY + HHStockLineMinThick;
            } else if(openPoint.y < closePointY) {
                closePointY = openPoint.y + HHStockLineMinThick;
            } else {
                if(idx > 0) {
                    id<HHDataModelProtocol> preKLineModel = drawLineModels[idx-1];
                    if(model.Open.floatValue > preKLineModel.Close.floatValue) {
                        openPoint.y = closePointY + HHStockLineMinThick;
                    } else {
                        closePointY = openPoint.y + HHStockLineMinThick;
                    }
                } else if(idx+1 < drawLineModels.count) {
                    //idx==0即第一个时
                    id<HHDataModelProtocol> subKLineModel = drawLineModels[idx+1];
                    if(model.Close.floatValue < subKLineModel.Open.floatValue) {
                        openPoint.y = closePointY + HHStockLineMinThick;
                    } else {
                        closePointY = openPoint.y + HHStockLineMinThick;
                    }
                } else {
                    openPoint.y = closePointY - HHStockLineMinThick;
                }
            }
        }
        CGPoint closePoint = CGPointMake(xPosition, closePointY);
        HHLinePositionModel *positionModel = [HHLinePositionModel modelWithOpen:openPoint close:closePoint high:highPoint low:lowPoint];
        [self.drawPositionModels addObject:positionModel];
        
        if (model.MA5.floatValue > 0.f) {
            [self.MA5Positions addObject: [NSValue valueWithCGPoint:CGPointMake(xPosition, ABS(maxY - (model.MA5.floatValue - minValue)/unitValue))]];
        }
        if (model.MA10.floatValue > 0.f) {
            [self.MA10Positions addObject: [NSValue valueWithCGPoint:CGPointMake(xPosition, ABS(maxY - (model.MA10.floatValue - minValue)/unitValue))]];
        }
        if (model.MA20.floatValue > 0.f) {
            [self.MA20Positions addObject: [NSValue valueWithCGPoint:CGPointMake(xPosition, ABS(maxY - (model.MA20.floatValue - minValue)/unitValue))]];
        }
    }];
    
    return self.drawPositionModels ;
}

- (NSMutableArray *)drawPositionModels {
    if (!_drawPositionModels) {
        _drawPositionModels = [NSMutableArray array];
    }
    return _drawPositionModels;
}

- (NSMutableArray *)MA5Positions {
    if (!_MA5Positions) {
        _MA5Positions = [NSMutableArray array];
    }
    return _MA5Positions;
}

- (NSMutableArray *)MA10Positions {
    if (!_MA10Positions) {
        _MA10Positions = [NSMutableArray array];
    }
    return _MA10Positions;
}

- (NSMutableArray *)MA20Positions {
    if (!_MA20Positions) {
        _MA20Positions = [NSMutableArray array];
    }
    return _MA20Positions;
}

@end
