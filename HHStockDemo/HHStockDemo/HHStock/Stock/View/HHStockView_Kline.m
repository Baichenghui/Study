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
    
//    [HHStockVariable setLineWith:(self.stockScrollView.bounds.size.width / lineModels.count) - [HHStockVariable lineGap]];
    [self layoutIfNeeded];
    [self updateScrollViewContentWidth];
    [self setNeedsDisplay];
    if (self.lineModels.count > 0) {
        self.stockScrollView.contentOffset = CGPointMake(self.stockScrollView.contentSize.width - self.stockScrollView.bounds.size.width, self.stockScrollView.contentOffset.y);
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

}

- (void)initUI_stockScrollView {
    _stockScrollView = [HHStockScrollView new];
    _stockScrollView.stockType = HHStockTypeLine;
    _stockScrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    _stockScrollView.showsHorizontalScrollIndicator = NO;
    _stockScrollView.delegate = self;

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
//    [self setNeedsDisplay];
}

#pragma mark - private


- (CGFloat)updateScrollViewContentWidth {
    //根据stockModels的个数和间隔和K线的宽度计算出self的宽度，并设置contentsize
    CGFloat kLineViewWidth = self.lineModels.count * [YYStockVariable lineWidth] + (self.lineModels.count + 1) * [YYStockVariable lineGap];
    
    if(kLineViewWidth < self.stockScrollView.bounds.size.width) {
        kLineViewWidth = self.stockScrollView.bounds.size.width;
    }
    
    //更新scrollview的contentsize
    self.stockScrollView.contentSize = CGSizeMake(kLineViewWidth, self.stockScrollView.contentSize.height);
    return kLineViewWidth;
}

@end
