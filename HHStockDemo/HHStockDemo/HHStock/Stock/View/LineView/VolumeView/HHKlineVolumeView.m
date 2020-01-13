//
//  HHKlineVolumeView.m
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

#import "HHKlineVolumeView.h"
#import "HHVolumePositionModel.h"
#import "HHStockVariable.h"
#import "HHStockConstant.h"
#import "UIColor+HHStock.h"

static inline bool isEqualZero(float value)
{
    return fabsf(value) <= 0.00001f;
}

@interface HHKlineVolumeView()
 
@property (nonatomic, strong) NSMutableArray *drawPositionModels;

/**
 上面K线的位置models数组
 */
@property (nonatomic, strong) NSArray *linePositionModels;
 
@property (nonatomic, strong) NSArray <id<HHDataModelProtocol>> *drawLineModels;


@property (nonatomic,strong) CAShapeLayer *redLayer;
@property (nonatomic,strong) CAShapeLayer *greenLayer;

@end

@implementation HHKlineVolumeView

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
}

#pragma mark - Public

- (void)drawViewWithXPosition:(CGFloat)xPosition
                   drawModels:(NSArray <id<HHDataModelProtocol>>*)drawLineModels
           linePositionModels:(NSArray <HHLinePositionModel *>*)linePositionModels {
    
    NSAssert(drawLineModels, @"数据源不能为空");
    _linePositionModels = linePositionModels;
    //转换为实际坐标
    [self _convertToPositionModelsWithXPosition:xPosition drawLineModels:drawLineModels];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _draw];
    });
}

#pragma mark - Private

- (NSArray *)_convertToPositionModelsWithXPosition:(CGFloat)startX drawLineModels:(NSArray <id<HHDataModelProtocol>>*)drawLineModels  {
    if (!drawLineModels) return nil;
    self.drawLineModels = drawLineModels;
    [self.drawPositionModels removeAllObjects];
    
    CGFloat minValue =  0;
    CGFloat maxValue =  [[[drawLineModels valueForKeyPath:@"Volume"] valueForKeyPath:@"@max.floatValue"] floatValue];
    
    CGFloat minY = HHStockLineVolumeViewMinY;
    CGFloat maxY = self.frame.size.height - HHStockLineVolumeViewMinY - HHStockLineDayHeight;
    
    CGFloat unitValue = (maxValue - minValue)/(maxY - minY);
    
    [drawLineModels enumerateObjectsUsingBlock:^(id<HHDataModelProtocol>  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat xPosition = startX + idx * ([HHStockVariable lineWidth] + [HHStockVariable lineGap]);
        CGFloat yPosition = ABS(maxY - (model.Volume - minValue)/unitValue);
        CGPoint startPoint = CGPointMake(xPosition, (ABS(yPosition - maxY) > 0 && ABS(yPosition - maxY) < 0.5) ? maxY - 0.5 : yPosition);
        CGPoint endPoint = CGPointMake(xPosition, maxY);
        
        HHVolumePositionModel *positionModel = [HHVolumePositionModel modelWithStartPoint:startPoint endPoint:endPoint dayDesc:model.Day];
        [self.drawPositionModels addObject:positionModel];
    }];
    
    return self.drawPositionModels ;
}
 
- (void)_draw {
    if (!self.drawPositionModels) {
        return;
    }
    
    NSAssert(self.linePositionModels.count == self.drawPositionModels.count, @"K线图和成交量的个数不相等");

    if (self.drawPositionModels.count > 0) {
        [self _drawCandleSublayers];
    }
}

- (void)_drawCandleSublayers {
    CGMutablePathRef redRef = CGPathCreateMutable();
    CGMutablePathRef greenRef = CGPathCreateMutable();
    
//    __block CGFloat lastRectX = 0;
    __weak typeof(self) weakSelf = self;
    [self.drawPositionModels enumerateObjectsUsingBlock:^(HHVolumePositionModel  *_Nonnull pModel, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
         
        if ([[strongSelf.drawLineModels[idx] Open] floatValue] < [[strongSelf.drawLineModels[idx] Close] floatValue]) {
            [strongSelf _addCandleRef:redRef postion:pModel];
        } else if ([[strongSelf.drawLineModels[idx] Open] floatValue] > [[strongSelf.drawLineModels[idx] Close] floatValue]) {
            [strongSelf _addCandleRef:greenRef postion:pModel];;
        } else {
            if ([[strongSelf.drawLineModels[idx] Open] floatValue] >= [[[strongSelf.drawLineModels[idx] preDataModel] Close] floatValue]) {
                [strongSelf _addCandleRef:redRef postion:pModel];
            } else {
                [strongSelf _addCandleRef:greenRef postion:pModel];
            }
        }
    }];
     
    self.redLayer.path = redRef;
    self.greenLayer.path = greenRef;
     
    //释放，避免内存泄漏
    CGPathRelease(redRef);
    CGPathRelease(greenRef);
}

- (void)_addCandleRef:(CGMutablePathRef)ref postion:(HHVolumePositionModel *)postion {
    CGFloat x = postion.StartPoint.x;
    CGFloat y = postion.StartPoint.y;
    CGFloat height = ABS(postion.StartPoint.y - postion.EndPoint.y);
    CGRect rect = CGRectMake(x, y, [HHStockVariable lineWidth], height);
     
    CGPathAddRect(ref, NULL, rect);
}

#pragma mark - Getter

- (NSMutableArray *)drawPositionModels {
    if (!_drawPositionModels) {
        _drawPositionModels = [NSMutableArray array];
    }
    return _drawPositionModels;
}

@end
