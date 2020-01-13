//
//  HHStockView_Kline.m
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

#import "HHStockView_Kline.h"
#import "HHKlineView.h"
#import "HHKlineVolumeView.h"
#import <Masonry/Masonry.h>
#import "HHStockConstant.h"
#import "HHStockVariable.h"
#import "UIColor+HHStock.h"
#import "HHStockScrollView.h"
#import "HHKlineMaskView.h"
#import "HHLinePositionModel.h"

@interface HHStockView_Kline() <UIScrollViewDelegate>

@property (nonatomic, strong) HHStockScrollView *stockScrollView;

/**
 数据源
 */
@property (nonatomic, strong) NSArray <id<HHDataModelProtocol>>*lineModels;

/**
 K线部分
 */
@property (nonatomic, copy) HHKlineView *kLineView;

/**
 成交量部分
 */
@property (nonatomic, copy) HHKlineVolumeView *volumeView;

/**
 当前绘制在屏幕上的数据源数组
 */
@property (nonatomic, strong) NSMutableArray <id<HHDataModelProtocol>>*drawLineModels;

/**
 当前绘制在屏幕上的数据源位置数组
 */
@property (nonatomic, copy) NSArray <HHLinePositionModel *>*drawLinePositionModels;

/**
 长按时出现的遮罩View
 */
@property (nonatomic, strong) HHKlineMaskView *maskView;

@end

@implementation HHStockView_Kline {

#pragma mark - 页面上显示的数据
    //图表最大的价格
    CGFloat maxValue;
    //图表最小的价格
    CGFloat minValue;
    //图表最大的成交量
    NSInteger volumeValue;
    //当前长按选中的model
    id<HHDataModelProtocol> selectedModel;
}


/**
 重绘视图
 
 @param lineModels  K线数据源
 */
- (void)reDrawWithLineModels:(NSArray <id<HHDataModelProtocol>>*) lineModels {
    _lineModels = lineModels;
     
    [self updateScrollViewContentWidth];
    [self draw];
    if (self.lineModels.count > 0) {
        self.stockScrollView.contentOffset = CGPointMake(self.stockScrollView.contentSize.width - self.stockScrollView.bounds.size.width, self.stockScrollView.contentOffset.y);
    }
}

- (void)draw {
    if (self.lineModels.count > 0) {
        if (!self.maskView || self.maskView.isHidden) {
            //更新绘制的数据源
            [self updateDrawModels];
            //更新背景线
            self.stockScrollView.isShowBgLine = YES;
            [self.stockScrollView draw];
            //绘制K线上部分
            self.drawLinePositionModels = [self.kLineView drawViewWithXPosition:[self xPosition] drawModels:self.drawLineModels maxValue:maxValue minValue:minValue];
            //绘制成交量
            [self.volumeView drawViewWithXPosition:[self xPosition] drawModels:self.drawLineModels linePositionModels:self.drawLinePositionModels];
        } else {
            [self.maskView draw];
        }
//        //绘制左侧文字部分
//        [self drawLeftDesc];
//        //绘制顶部的MA数据
//        [self drawTopDesc];
    }
}
 

/**
 构造器
 
 @param lineModels 数据源
 
 @return HHStockView_Kline对象
 */
- (instancetype)initWithLineModels:(NSArray<id<HHDataModelProtocol>> *)lineModels {
    self = [super init];
    if (self) {
        _lineModels = lineModels;
        [self initUI];
    }
    return self;
}

/**
 初始化子View
 */
- (void)initUI {  
    //加载StockScrollView
    [self initUI_stockScrollView];
    
    //加载LineView
    _kLineView = [HHKlineView new];
    _kLineView.backgroundColor = [UIColor clearColor];
    [_stockScrollView.contentView addSubview:_kLineView];
    [_kLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_stockScrollView.contentView);
        make.height.equalTo(_stockScrollView.contentView).multipliedBy([HHStockVariable lineMainViewRadio]);
    }];
    
    //加载VolumeView
    _volumeView = [HHKlineVolumeView new];
    _volumeView.backgroundColor = [UIColor clearColor];
    _volumeView.parentScrollView = _stockScrollView;
    [_stockScrollView.contentView addSubview:_volumeView];
    [_volumeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_stockScrollView.contentView);
        make.height.equalTo(_stockScrollView.contentView).multipliedBy([HHStockVariable volumeViewRadio]);
    }];

    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf draw];
    });
}

- (void)initUI_stockScrollView {
    _stockScrollView = [HHStockScrollView new];
    _stockScrollView.stockType = HHStockTypeLine;
    _stockScrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    _stockScrollView.showsHorizontalScrollIndicator = NO;
    _stockScrollView.delegate = self;
    _stockScrollView.bounces = NO;
//    _stockScrollView.contentView.backgroundColor = [UIColor grayColor];

    [self addSubview:_stockScrollView];
    [_stockScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(HHStockScrollViewLeftGap);
        make.top.equalTo(self).offset(HHStockScrollViewTopGap);
        make.right.equalTo(self).offset(-12);
    }];
    
//    //缩放
//    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(event_pinchAction:)];
//    [_stockScrollView addGestureRecognizer:pinch];
//    //长按手势
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressAction:)];
//    [_stockScrollView addGestureRecognizer:longPress];
}

/**
 scrollView滑动重绘页面
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView { 
    [self draw];
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    [self draw];
//}

#pragma mark - private

- (CGFloat)updateScrollViewContentWidth {
    //根据stockModels的个数和间隔和K线的宽度计算出self的宽度，并设置contentsize
    CGFloat kLineViewWidth = self.lineModels.count * [HHStockVariable lineWidth] + (self.lineModels.count + 1) * [HHStockVariable lineGap];
    
    if(kLineViewWidth < self.stockScrollView.bounds.size.width) {
        kLineViewWidth = self.stockScrollView.bounds.size.width;
    }
    
    //更新scrollview的contentsize
    self.stockScrollView.contentSize = CGSizeMake(kLineViewWidth, self.stockScrollView.contentSize.height);
    return kLineViewWidth;
}

/**
 更新需要绘制的数据源
 */
- (void)updateDrawModels {

    NSInteger startIndex = [self startIndex];
    NSInteger drawLineCount = (self.stockScrollView.frame.size.width) / ([HHStockVariable lineGap] +  [HHStockVariable lineWidth]);
//    NSInteger drawLineCount = (self.stockScrollView.frame.size.width - [HHStockVariable lineGap]) / ([HHStockVariable lineGap] +  [HHStockVariable lineWidth]);

    
    [self.drawLineModels removeAllObjects];
    NSInteger length = startIndex+drawLineCount < self.lineModels.count ? drawLineCount+1 : self.lineModels.count - startIndex;
    [self.drawLineModels addObjectsFromArray:[self.lineModels subarrayWithRange:NSMakeRange(startIndex, length)]];
    
    //更新顶部ma数据
    selectedModel = self.drawLineModels.lastObject;
    
    //更新最大值最小值-价格
    CGFloat max =  [[[self.drawLineModels valueForKeyPath:@"High"] valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat ma5max = [[[self.drawLineModels valueForKeyPath:@"MA5"] valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat ma10max = [[[self.drawLineModels valueForKeyPath:@"MA10"] valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat ma20max = [[[self.drawLineModels valueForKeyPath:@"MA20"] valueForKeyPath:@"@max.floatValue"] floatValue];
    
    __block CGFloat min =  [[[self.drawLineModels valueForKeyPath:@"Low"] valueForKeyPath:@"@min.floatValue"] floatValue];
    [self.drawLineModels enumerateObjectsUsingBlock:^(id<HHDataModelProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat ma5value = [[obj MA5] floatValue];
        CGFloat ma10value = [[obj MA10] floatValue];
        CGFloat ma20value = [[obj MA20] floatValue];
        if ( ma5value > 0 && ma5value < min ) min = ma5value;
        if ( ma10value > 0 && ma10value < min ) min = ma10value;
        if ( ma20value > 0 && ma20value < min ) min = ma20value;
    }];

    max = MAX(MAX(MAX(ma5max, ma10max), ma20max), max);

    CGFloat average = (min+max) / 2;
    maxValue = max;
    minValue = average * 2 - maxValue;
}


- (CGRect)rectOfNSString:(NSString *)string attribute:(NSDictionary *)attribute {
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                     options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                  attributes:attribute
                                     context:nil];
    return rect;
}

#pragma mark - setter,getter方法
- (NSInteger)xPosition {
    NSInteger leftArrCount = [self startIndex];
    CGFloat startXPosition = (leftArrCount + 1) * [HHStockVariable lineGap] + leftArrCount * [HHStockVariable lineWidth] + [HHStockVariable lineWidth]/2;
    return startXPosition;
}

- (NSMutableArray *)drawLineModels {
    if (!_drawLineModels) {
        _drawLineModels = [NSMutableArray array];
    }
    return _drawLineModels;
}

- (NSInteger)startIndex {
    CGFloat offsetX = self.stockScrollView.contentOffset.x < 0 ? 0 : self.stockScrollView.contentOffset.x;
    
    NSUInteger leftCount = ABS(offsetX) / ([HHStockVariable lineGap] + [HHStockVariable lineWidth]);

    if (leftCount > self.lineModels.count) {
        leftCount = self.lineModels.count - 1;
    }
    return leftCount;
}

@end
