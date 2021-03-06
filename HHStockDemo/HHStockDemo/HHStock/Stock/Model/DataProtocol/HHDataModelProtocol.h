//
//  HHLineDataModelProtocol.h
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//
 
//提供K线数据源
@protocol HHDataModelProtocol <NSObject>

@required
 
/**
 前一个数据
 */
@property (nonatomic, readonly) id<HHDataModelProtocol> preDataModel;
/**
 *  开盘价
 */
@property (nonatomic, readonly) NSNumber *Open;

/**
 *  收盘价
 */
@property (nonatomic, readonly) NSNumber *Close;

/**
 *  最高价
 */
@property (nonatomic, readonly) NSNumber *High;

/**
 *  最低价
 */
@property (nonatomic, readonly) NSNumber *Low;

/**
 *  成交量
 */
@property (nonatomic, readonly) CGFloat Volume;

/**
 *  日期
 */
@property (nonatomic, readonly) NSString *Day;
/**
 是否绘制在View上
 */
@property (nonatomic, readonly) BOOL isShowDay;

/**
 *  长按时显示的详细日期
 */
@property (nonatomic, readonly) NSString *DayDatail;

@optional

- (instancetype)initWithDict: (NSDictionary *)dict;

/**
 *  MA5
 */
@property (nonatomic, readonly) NSNumber *MA5;

/**
 *  MA10
 */
@property (nonatomic, readonly) NSNumber *MA10;

/**
 *  MA20
 */
@property (nonatomic, readonly) NSNumber *MA20;

@end
