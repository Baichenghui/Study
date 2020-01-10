//
//  UIColor+HHStock.h
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//
 
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HHStock)

/************************************K线颜色配置***************************************/

/**
*  整体背景颜色
*/
+(UIColor *)HHStock_bgColor;

/**
 *  K线图背景辅助线颜色
 */
+(UIColor *)HHStock_bgLineColor;

/**
 *  主文字颜色
 */
+(UIColor *)HHStock_textColor;


/**
 *  MA5线颜色
 */
+(UIColor *)HHStock_MA5LineColor;

/**
 *  MA10线颜色
 */
+(UIColor *)HHStock_MA10LineColor;

/**
 *  MA20线颜色
 */
+(UIColor *)HHStock_MA20LineColor;

/**
 *  长按线颜色
 */
+(UIColor *)HHStock_selectedLineColor;

/**
 *  长按出现的圆点的颜色
 */
+(UIColor *)HHStock_selectedPointColor;

/**
 *  长按出现的方块背景颜色
 */
+(UIColor *)HHStock_selectedRectBgColor;

/**
 *  长按出现的方块文字颜色
 */
+(UIColor *)HHStock_selectedRectTextColor;


/**
 *  分时线颜色
 */
+(UIColor *)HHStock_TimeLineColor;

/**
 *  分时均线颜色
 */
+(UIColor *)HHStock_averageTimeLineColor;

/**
 *  分时线下方背景色
 */
+(UIColor *)HHStock_timeLineBgColor;




/**
 *  涨的颜色
 */
+(UIColor *)HHStock_increaseColor;

/**
 *  跌的颜色
 */
+(UIColor *)HHStock_decreaseColor;


/************************************TopBar颜色配置***************************************/

/**
 *  顶部TopBar文字默认颜色
 */
+(UIColor *)HHStock_topBarNormalTextColor;

/**
 *  顶部TopBar文字选中颜色
 */
+(UIColor *)HHStock_topBarSelectedTextColor;

/**
 *  顶部TopBar选中块辅助线颜色
 */
+(UIColor *)HHStock_topBarSelectedLineColor;

@end

NS_ASSUME_NONNULL_END
