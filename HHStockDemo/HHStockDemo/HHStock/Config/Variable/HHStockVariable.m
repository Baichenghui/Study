//
//  HHStockVariable.m
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

#import "HHStockVariable.h"
#import "HHStockConstant.h"

/**
 K线图中蜡烛的宽度
 */
static CGFloat HHStockLineWidth = 6;

/**
 分时图成交量线宽度
 */
static CGFloat HHStockTimeLineVolumeWidth = 6;

/**
 K线图的间隔，初始值为1
 */
static CGFloat HHStockLineGap = 2;

/**
 KLineView的高度占比
 */
static CGFloat HHStockLineViewRadio = 0.6;

/**
 成交量图的高度占比
 */
static CGFloat HHStockVolumeViewRadio = 0.3;

/**
 设置K线宽度数组
 */
static NSMutableArray *HHStockLineWidthArray;

/**
 设置当前从哪个K线宽度数组进行存取
 */
static NSInteger HHStockLineWidthIndex;

@implementation HHStockVariable

/**
 K线图中蜡烛的宽度
 */
+(CGFloat)lineWidth
{
    if (HHStockLineWidthIndex >= 0 && HHStockLineWidthArray && [HHStockLineWidthArray count] > HHStockLineWidthIndex) {
        return [HHStockLineWidthArray[HHStockLineWidthIndex] floatValue];
    } else {
        return HHStockLineWidth;
    }
}

/**
 设置K线图中蜡烛的宽度
 
 @param lineWidth 宽度
 */
+(void)setLineWith:(CGFloat)lineWidth
{
    if (lineWidth > HHStockLineMaxWidth) {
        lineWidth = HHStockLineMaxWidth;
    }else if (lineWidth < HHStockLineMinWidth){
        lineWidth = HHStockLineMinWidth;
    }
    if (HHStockLineWidthIndex >= 0 && HHStockLineWidthArray && [HHStockLineWidthArray count] > HHStockLineWidthIndex) {
        HHStockLineWidthArray[HHStockLineWidthIndex] = [NSNumber numberWithFloat:lineWidth];
    } else {
        HHStockLineWidth = lineWidth;
    }
}

/**
 分时线的成交量线的宽度
 */
+(CGFloat)timeLineVolumeWidth {
    return HHStockTimeLineVolumeWidth;
}

/**
 设置分时线的成交量线的宽度
 
 @param timeLineVolumeWidth 宽度
 */
+(void)setTimeLineVolumeWidth:(CGFloat)timeLineVolumeWidth {
    HHStockTimeLineVolumeWidth = timeLineVolumeWidth;
}

/**
 K线图的间隔，初始值为1
 */
+(CGFloat)lineGap
{
    return HHStockLineGap;
}

/**
 设置K线图中蜡烛的间距
 
 @param lineGap 间距
 */
+(void)setLineGap:(CGFloat)lineGap
{
    HHStockLineGap = lineGap;
}

/**
 LineView的高度占比,初始值为0.6，剩下的为成交量图的高度占比
 */
+ (CGFloat)lineMainViewRadio
{
    return HHStockLineViewRadio;
}

/**
 设置LineView的高度占比
 
 @param radio 占比
 */
+ (void)setLineMainViewRadio:(CGFloat)radio
{
    HHStockLineViewRadio = radio;
}

/**
 成交量图的高度占比
 */
+ (CGFloat)volumeViewRadio {
    return HHStockVolumeViewRadio;
}

/**
 设置成交量图的高度占比
 
 @param radio 占比
 */
+ (void)setVolumeViewRadio:(CGFloat)radio {
    HHStockVolumeViewRadio = radio;
}


+ (void)setStockLineWidthArray:(NSArray <NSNumber *>*)lineWidthArray {
    HHStockLineWidthArray = lineWidthArray.mutableCopy;
}

+ (void)setStockLineWidthIndex:(NSInteger)lineWidthindex {
    HHStockLineWidthIndex = lineWidthindex;
}

@end
