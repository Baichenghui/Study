//
//  HHStockView_Kline.h
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHDataModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class HHStockView_Kline;

@protocol HHStockViewKlineProtocol <NSObject>

/**
 长按代理

 @param stockView 长按的view
 @param model     长按时选中的数据
 */
- (void)stockView:(HHStockView_Kline *)stockView selectedModel:(id<HHDataModelProtocol>)model;

@optional

/// 滚动加载更多数据
/// @param stockView stockView
/// @param scrollView scrollView
- (void)stockView:(HHStockView_Kline *)stockView didScrollView:(UIScrollView *)scrollView;

@end



@interface HHStockView_Kline : UIView
 
@property (nonatomic, weak) id<HHStockViewKlineProtocol> delegate;
/**
 构造器

 @param lineModels 数据源
 
 @return YYStockView_Kline对象
 */
- (instancetype)initWithLineModels:(NSArray <id<HHDataModelProtocol>>*) lineModels;

/**
 重绘视图
 
 @param lineModels  K线数据源
 */  
- (void)reDrawWithLineModels:(NSArray <id<HHDataModelProtocol>>*) lineModels isRefresh:(BOOL)isRefresh;
  
@end

NS_ASSUME_NONNULL_END
