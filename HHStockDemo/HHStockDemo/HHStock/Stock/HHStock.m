//
//  HHStock.m
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

#import "HHStock.h"
#import "HHStockConstant.h"
#import "HHStockView_Kline.h"
#import "UIColor+HHStock.h"
#import "HHStockViewMaskView.h"
#import "HHStockVariable.h"
#import <Masonry/Masonry.h>

@interface HHStock()<HHStockViewKlineProtocol>
/**
 *  数据源
 */
@property (nonatomic, weak) id<HHStockDataSource> dataSource;
/**
 *  代理
 */
@property (nonatomic, weak) id<HHStockDelegate> delegate;
 
/**
 长按时出现的遮罩View
 */
//@property (nonatomic, strong) HHStockViewMaskView *maskView;

@property (nonatomic, strong) NSMutableArray <__kindof UIView *> *stockViewArray;
 
@end

@implementation HHStock
 
- (instancetype)initWithFrame:(CGRect)frame dataSource:(id)dataSource delegate:(id)delegate {
    self = [super init];
    if (self) {
        self.dataSource = dataSource;
        self.delegate = delegate;
        self.mainView = [[UIView alloc] initWithFrame:frame];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self initUI_StockContainerView];
}

- (void)initUI_StockContainerView {
    self.stockViewArray = [NSMutableArray array];
    self.containerView = ({
        UIView *view = [UIView new];
        [self.mainView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self.mainView);
        }];
        view;
    });
    
    HHStockView_Kline *stockView = [[HHStockView_Kline alloc]initWithLineModels:[self.dataSource stock:self stockDatasOfIndex:0]];
    stockView.delegate = self;
    stockView.backgroundColor = [UIColor HHStock_bgColor];
    [self.containerView addSubview:stockView];
    [stockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
    [self.stockViewArray addObject:stockView];
}

/**
 绘制
 */
- (void)draw:(BOOL)isRefresh {
    //更新数据
    NSInteger index = self.currentIndex;
    if ([self.stockViewArray[index] isKindOfClass:[HHStockView_Kline class]]) {
        HHStockView_Kline *stockView = (HHStockView_Kline *)(self.stockViewArray[index]);
        [stockView reDrawWithLineModels:[self.dataSource stock:self stockDatasOfIndex:index] isRefresh:isRefresh];
    }
}
 
#pragma mark - HHStockViewKlineProtocol

/**
 StockView_Kline代理
 此处Kline和TimeLine都走这一个代理
 @param stockView HHStockView_Kline
 @param model     选中的数据源 若为nil表示取消绘制
 */
- (void)stockView:(HHStockView_Kline *)stockView selectedModel:(id<HHDataModelProtocol>)model {
    if (model == nil) {
//        self.maskView.hidden = YES;
    } else {
//        if (!self.maskView) {
//            _maskView = [HHStockViewMaskView new];
//            _maskView.backgroundColor = [UIColor clearColor];
//            [self.mainView addSubview:_maskView];
//            [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.edges.equalTo(self.topBarView);
//            }];
//        } else {
//            self.maskView.hidden = NO;
//        }
//        if ([stockView isKindOfClass:[HHStockView_Kline class]]) {
//            self.maskView.stockType = HHStockTypeLine;
//        } else {
//            self.maskView.stockType = HHStockTypeTimeLine;
//        }
//        self.maskView.selectedModel = model;
//        [self.maskView setNeedsDisplay];
    }
}

- (void)stockView:(HHStockView_Kline *)stockView didScrollView:(UIScrollView *)scrollView {
    if ([self.dataSource isLoadingDataForStock:self]) {
        return;
    }

    if (scrollView.contentOffset.x < scrollView.frame.size.width
        && [self.dataSource hasMoreDataForStock:self]) {
        // 查询更多K线数据
        if ([self.delegate respondsToSelector:@selector(stock:didScrollViewToLoadData:)]) {
            [self.delegate stock:self didScrollViewToLoadData:scrollView];
        }
    }
}
 
@end
