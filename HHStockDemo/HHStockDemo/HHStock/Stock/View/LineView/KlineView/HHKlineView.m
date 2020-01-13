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
#import "HHLinePositionModel.h" 
 
#import "UIColor+HHStock.h"
#import "UIBezierPath+HHStock.h"
 
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

@property (nonatomic,strong) CAShapeLayer *ma5LineLayer;
@property (nonatomic,strong) CAShapeLayer *ma10LineLayer;
@property (nonatomic,strong) CAShapeLayer *ma20LineLayer;

@end

@implementation HHKlineView

#pragma mark - Initialize

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize {
    [self initLayer];
}
 
- (void)initLayer {
    //redLayer
    if (!self.redLayer) {
        self.redLayer = [CAShapeLayer layer];
    }
    self.redLayer.lineWidth = HHStockShadowLineWidth;
    self.redLayer.fillColor = [UIColor HHStock_increaseColor].CGColor;
    self.redLayer.strokeColor = [UIColor HHStock_increaseColor].CGColor;
    [self.layer addSublayer:self.redLayer];
      
    //greenLayer
    if (!self.greenLayer) {
        self.greenLayer = [CAShapeLayer layer];
    }
    self.greenLayer.lineWidth = HHStockShadowLineWidth;
    self.greenLayer.fillColor = [UIColor HHStock_decreaseColor].CGColor;
    self.greenLayer.strokeColor = [UIColor HHStock_decreaseColor].CGColor;
    [self.layer addSublayer:self.greenLayer];
    
    //ma5LineLayer
    if (!self.ma5LineLayer) {
        self.ma5LineLayer = [CAShapeLayer layer];
    }
    self.ma5LineLayer.lineWidth = HHStockMALineLineWidth;
    self.ma5LineLayer.lineCap = kCALineCapRound;
    self.ma5LineLayer.lineJoin = kCALineJoinRound;
    self.ma5LineLayer.contentsScale = [UIScreen mainScreen].scale;
    self.ma5LineLayer.strokeColor = [UIColor HHStock_MA5LineColor].CGColor;
    self.ma5LineLayer.fillColor = [[UIColor clearColor] CGColor];
    [self.layer addSublayer:self.ma5LineLayer];
    
    //ma10LineLayer
    if (!self.ma10LineLayer) {
        self.ma10LineLayer = [CAShapeLayer layer];
    }
    self.ma10LineLayer.lineWidth = HHStockMALineLineWidth;
    self.ma10LineLayer.lineCap = kCALineCapRound;
    self.ma10LineLayer.lineJoin = kCALineJoinRound;
    self.ma10LineLayer.contentsScale = [UIScreen mainScreen].scale;
    self.ma10LineLayer.strokeColor = [UIColor HHStock_MA10LineColor].CGColor;
    self.ma10LineLayer.fillColor = [[UIColor clearColor] CGColor];
    [self.layer addSublayer:self.ma10LineLayer];
    
    //ma20LineLayer
    if (!self.ma20LineLayer) {
        self.ma20LineLayer = [CAShapeLayer layer];
    }
    self.ma20LineLayer.lineWidth = HHStockMALineLineWidth;
    self.ma20LineLayer.lineCap = kCALineCapRound;
    self.ma20LineLayer.lineJoin = kCALineJoinRound;
    self.ma20LineLayer.contentsScale = [UIScreen mainScreen].scale;
    self.ma20LineLayer.strokeColor = [UIColor HHStock_MA20LineColor].CGColor;
    self.ma20LineLayer.fillColor = [[UIColor clearColor] CGColor];
    [self.layer addSublayer:self.ma20LineLayer];
}

#pragma mark - Public

- (NSArray *)drawViewWithXPosition:(CGFloat)xPosition drawModels:(NSMutableArray <id<HHDataModelProtocol>>*)drawLineModels  maxValue:(CGFloat)maxValue minValue:(CGFloat)minValue {
    NSAssert(drawLineModels, @"数据源不能为空");
    //转换为实际坐标
    [self _convertToPositionModelsWithXPosition:xPosition drawLineModels:drawLineModels maxValue:maxValue minValue:minValue];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _draw];
    });
    return [self.drawPositionModels copy];
}

#pragma mark - Private

- (NSArray *)_convertToPositionModelsWithXPosition:(CGFloat)startX drawLineModels:(NSArray <id<HHDataModelProtocol>>*)drawLineModels  maxValue:(CGFloat)maxValue minValue:(CGFloat)minValue {
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
    
    __weak typeof(self) weakSelf = self;
    [drawLineModels enumerateObjectsUsingBlock:^(id<HHDataModelProtocol>  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        CGFloat xPosition = startX + idx * ([HHStockVariable lineWidth] + [HHStockVariable lineGap]);
        CGPoint highPoint = CGPointMake(xPosition, ABS(maxY - (model.High.floatValue - minValue)/unitValue));
        CGPoint lowPoint = CGPointMake(xPosition, ABS(maxY - (model.Low.floatValue - minValue)/unitValue));
        CGPoint openPoint = CGPointMake(xPosition, ABS(maxY - (model.Open.floatValue - minValue)/unitValue));
        CGFloat closePointY = ABS(maxY - (model.Close.floatValue - minValue)/unitValue);
        
        //格式化openPoint和closePointY
        if(ABS(closePointY - openPoint.y) < HHStockLineMinThick) { 
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
        [strongSelf.drawPositionModels addObject:positionModel];
        
        if (model.MA5.floatValue > 0.f) {
            [strongSelf.MA5Positions addObject: [NSValue valueWithCGPoint:CGPointMake(xPosition, ABS(maxY - (model.MA5.floatValue - minValue)/unitValue))]];
        }
        if (model.MA10.floatValue > 0.f) {
            [strongSelf.MA10Positions addObject: [NSValue valueWithCGPoint:CGPointMake(xPosition, ABS(maxY - (model.MA10.floatValue - minValue)/unitValue))]];
        }
        if (model.MA20.floatValue > 0.f) {
            [strongSelf.MA20Positions addObject: [NSValue valueWithCGPoint:CGPointMake(xPosition, ABS(maxY - (model.MA20.floatValue - minValue)/unitValue))]];
        }
    }];
    
    return self.drawPositionModels ;
}
 
- (void)_draw {
    if (!self.drawPositionModels) {
        return;
    }
    
    if (self.drawPositionModels.count > 0) {
         [self _drawCandleSublayers];
    }
    
    if(self.MA5Positions.count > 0) {
        UIBezierPath *ma5Path = [UIBezierPath drawLine:self.MA5Positions];
        self.ma5LineLayer.path = ma5Path.CGPath;
    }
    
    if(self.MA10Positions.count > 0) {
        UIBezierPath *ma10Path = [UIBezierPath drawLine:self.MA10Positions];
        self.ma10LineLayer.path = ma10Path.CGPath;
    }
    
    if(self.MA20Positions.count > 0) {
        UIBezierPath *ma20Path = [UIBezierPath drawLine:self.MA20Positions];
        self.ma20LineLayer.path = ma20Path.CGPath;
    }
}
 
/// k线绘制
- (void)_drawCandleSublayers {
    CGMutablePathRef redRef = CGPathCreateMutable();
    CGMutablePathRef greenRef = CGPathCreateMutable();

    __weak typeof(self) weakSelf = self;
    [self.drawPositionModels enumerateObjectsUsingBlock:^(HHLinePositionModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if ([[strongSelf.drawLineModels[idx] Open] floatValue] < [[strongSelf.drawLineModels[idx] Close] floatValue]) {
            [strongSelf _addCandleRef:redRef postion:model];
        } else if ([[strongSelf.drawLineModels[idx] Open] floatValue] > [[strongSelf.drawLineModels[idx] Close] floatValue]) {
            [strongSelf _addCandleRef:greenRef postion:model];
        } else {
            if ([[strongSelf.drawLineModels[idx] Open] floatValue] >= [[[strongSelf.drawLineModels[idx] preDataModel] Close] floatValue]) {
                [strongSelf _addCandleRef:redRef postion:model];
            } else {
                [strongSelf _addCandleRef:greenRef postion:model];
            }
        } 
    }];

    self.redLayer.path = redRef;
    self.greenLayer.path = greenRef;
     
    //释放，避免内存泄漏
    CGPathRelease(redRef);
    CGPathRelease(greenRef);
}

- (void)_addCandleRef:(CGMutablePathRef)ref postion:(HHLinePositionModel*)postion {
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

#pragma mark - Getter

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
