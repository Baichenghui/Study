//
//  HHStockConstant.h
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

/**
 *  K线最小的厚度
 */
#define HHStockLineMinThick 0.5


/**
 *  K线最大的宽度
 */
#define HHStockLineMaxWidth 20

/**
 *  K线图最小的宽度
 */
#define HHStockLineMinWidth 3

/**
 *  时分线的宽度
 */
#define HHStockTimeLineWidth 1

/**
 *  上下影线宽度
 */
#define HHStockShadowLineWidth 1.2

/**
 *  MA线宽度
 */
#define HHStockMALineLineWidth 1.2

/**
 * 圆点的半径
 */
#define HHStockPointRadius 3

/**
 *  K线图上可画区域最小的Y
 */
#define HHStockLineMainViewMinY 2

/**
 *  K线图的成交量上最小的Y
 */
#define HHStockLineVolumeViewMinY 2

/**
 *  K线图的成交量下面日期高度
 */
#define HHStockLineDayHeight 20

/**
 *  TopBar的高度
 */
#define HHStockTopBarViewHeight 40

/**
 *  TopBar的按钮宽度
 */
#define HHStockTopBarViewWidth 94

/**
 *  TopBar和StockView的间距
 */
#define HHStockViewGap 1


/**
 *  K线ScrollView距离顶部的距离
 */
#define HHStockScrollViewTopGap 25

/**
 *  K线ScrollView距离左边的距离
 */
#define HHStockScrollViewLeftGap 45

/**
 *  TimeLineView文字距离左边的距离
 */
#define HHStockTimeLineViewLeftGap 12

/**
 *  分时图成交量线的间距
 */
#define HHStockTimeLineViewVolumeGap 0.1

/**
 *  五档图宽度
 */
#define HHStockFiveRecordViewWidth 95

/**
 *  五档图高度
 */
#define HHStockFiveRecordViewHeight 175


/**
 *  K线图缩放界限
 */
#define HHStockLineScaleBound 0.03

/**
 *  K线的缩放因子
 */
#define HHStockLineScaleFactor 0.06

//Kline种类
typedef NS_ENUM(NSInteger, HHStockType) {
    HHStockTypeLine = 1,    //K线
    HHStockTypeTimeLine,  //分时图
    HHStockTypeOther
};
 
//Accessory指标种类
typedef NS_ENUM(NSInteger, HHStockTargetLineStatus) {
    HHStockTargetLineStatusMACD = 100,    //MACD线
    HHStockTargetLineStatusKDJ,    //KDJ线
    HHStockTargetLineStatusAccessoryClose,    //关闭Accessory线
    HHStockTargetLineStatusMA , //MA线
    HHStockTargetLineStatusEMA,  //EMA线
    HHStockTargetLineStatusCloseMA  //MA关闭线
    
};
