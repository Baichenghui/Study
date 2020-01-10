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

@interface HHStockView_Kline : UIView

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
- (void)reDrawWithLineModels:(NSArray <id<HHDataModelProtocol>>*) lineModels;

@end

NS_ASSUME_NONNULL_END
