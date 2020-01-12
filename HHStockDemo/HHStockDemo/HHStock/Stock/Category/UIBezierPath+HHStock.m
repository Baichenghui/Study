

//
//  UIBezierPath+HHStock.m
//  HHStockDemo
//
//  Created by 白成慧&瑞瑞 on 2020/1/11.
//  Copyright © 2020 hh. All rights reserved.
//

#import "UIBezierPath+HHStock.h"
 
@implementation UIBezierPath (HHStock)
 
+ (UIBezierPath*)drawLine:(NSMutableArray*)linesArray {
    UIBezierPath *path = [UIBezierPath bezierPath];
//    [linesArray enumerateObjectsUsingBlock:^(ZYWLineModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (idx == 0)
//        {
//            [path moveToPoint:CGPointMake(obj.xPosition,obj.yPosition)];
//        }
//
//        else
//        {
//            [path addLineToPoint:CGPointMake(obj.xPosition,obj.yPosition)];
//        }
//    }];
    return path;
}

+ (NSMutableArray<__kindof UIBezierPath*>*)drawLines:(NSMutableArray<NSMutableArray*>*)linesArray {
     NSAssert(0 != linesArray.count && NULL != linesArray, @"传入的数组为nil ,打印结果---->>%@",linesArray);
    
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSMutableArray *lineArray in linesArray)
    {
        UIBezierPath *path = [UIBezierPath drawLine:lineArray];
        [resultArray addObject:path];
    }
    return resultArray;
}

+ (UIBezierPath*)drawKLine:(CGFloat)open
                     close:(CGFloat)close
                      high:(CGFloat)high
                       low:(CGFloat)low
               candleWidth:(CGFloat)candleWidth
                      rect:(CGRect)rect
                  xPostion:(CGFloat)xPostion
                 lineWidth:(CGFloat)lineWidth {
    UIBezierPath *candlePath = [UIBezierPath bezierPathWithRect:rect];
    candlePath.lineWidth = lineWidth;
    [candlePath moveToPoint:CGPointMake(xPostion+candleWidth/2-lineWidth/2, high)];
    [candlePath addLineToPoint:CGPointMake(xPostion+candleWidth/2-lineWidth/2, low)];
    return candlePath;
}


@end
