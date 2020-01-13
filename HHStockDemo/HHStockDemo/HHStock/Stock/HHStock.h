//
//  HHStock.h
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "HHDataModelProtocol.h" 
#import "HHStockConstant.h"

NS_ASSUME_NONNULL_BEGIN

@class HHStock;
 
@protocol HHStockDelegate <NSObject>
  
/// 滚动加载更多数据
/// @param stock stock
/// @param scrollView scrollView
- (void)stock:(HHStock *)stock didScrollViewToLoadData:(UIScrollView *)scrollView;

@end

@protocol HHStockDataSource <NSObject>
@required 
/**
 K线的数据源
 */
-(NSArray *)stock:(HHStock *)stock stockDatasOfIndex:(NSInteger)index;

/**
 K线的顶部栏文字
 */
//-(NSArray <NSString *> *)titleItemsOfStock:(HHStock *)stock;

/**
 K线的类型
 */
-(HHStockType)stockTypeOfIndex:(NSInteger)index;

/// 是否正在为 stock 加载数据
/// @param stock stock
- (BOOL)isLoadingDataForStock:(HHStock *)stock;

/// 是否还有更多数据
/// @param stock stock
- (BOOL)hasMoreDataForStock:(HHStock *)stock;

@optional

/**
 分时图是否显示五档数据
 */
-(BOOL)isShowfiveRecordModelOfIndex:(NSInteger)index;

/**
 五档图数据源
 */
//-(id<HHStockFiveRecordProtocol>)fiveRecordModelOfIndex:(NSInteger)index;

@end

@interface HHStock : NSObject
 
/**
 HHStock的ContentView
 */
@property (nonatomic, strong) UIView *mainView;

/**
 构造器

 @param frame      frame
 @param dataSource 数据源

 @return HHStock对象
 */
- (instancetype)initWithFrame:(CGRect)frame dataSource:(id<HHStockDataSource>)dataSource delegate:(id)delegate ;

/**
 开始绘制
 */
- (void)draw:(BOOL)isRefresh;

/**
 stockView的容器
 */
@property (nonatomic, strong) UIView *containerView;

/**
 当前选中的ViewIndex
 */
@property (nonatomic, assign) NSInteger currentIndex;

@end

NS_ASSUME_NONNULL_END
