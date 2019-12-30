//
//  CGDQuartzView.m
//  CoreGraphicsDemo
//
//  Created by tianxi on 2019/12/27.
//  Copyright © 2019 hh. All rights reserved.
//

#import "CGDQuartzView.h"

/*
    自定义视图
    drawRect: 中的步骤：
        1、取得当前上下文
        2、绘制相应的图形内容，绘制时产生的线条成为路径，路径由一个或多个组成
        3、利用图形上下文将绘制的内容渲染显示到view上
 
    之所以在drawRect:中绘制，是因为只有在该方法中才能获取 CGContextRef
 
    Quartz2D的API来自Core Graphics
 
 
    ////////////////////////////////////////////////////////////////
    图形上下文生成图片
    
    CGRect rect = CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
    //开启图形上下文
    UIGraphicsBeginImageContext(rect.size);
    //开启绘制上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置路径
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //绘制
    CGContextFillRect(context, rect);
    //图形上下文中取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
 
 
    ////////////////////////////////////////////////////////////////
    截图
    1.开启一个图片上下文
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    获取当前的上下文.
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    2.把控制器View的内容绘制上下文当中.
    [self.view.layer renderInContext:ctx];
    3.从上下文当中取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    4.关闭上下文.
    UIGraphicsEndImageContext();

    
    
 */

@implementation CGDQuartzView

- (void)drawRect:(CGRect)rect {
    
    ////////////////////////////////////////////////////////////////
//    CGContextRef myContext = UIGraphicsGetCurrentContext();
//
////   // ********** Your drawing code here ********** // 2
////    CGContextSetRGBFillColor (myContext, 1, 0, 0, 1);// 3
////    CGContextFillRect (myContext, CGRectMake (0, 0, 200, 100 ));// 4
////    CGContextSetRGBFillColor (myContext, 0, 0, 1, .5);// 5
////    CGContextFillRect (myContext, CGRectMake (0, 0, 100, 200));// 6
//
//    CGContextMoveToPoint(myContext, 10, 10);
//    CGContextAddLineToPoint(myContext, 100, 100);
//    //绘制路径
//    CGContextStrokePath(myContext);
    
    
    ////////////////////////////////////////////////////////////////
    // 设置红色---》copy一份当前绘制状态保存到上下文
    // ---》设置黄色---》画一个圈（黄色）
    // ---》恢复到上一次保存上下文的状态（变为红色）---》画一个圈（红色）
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    [[UIColor redColor] setStroke];                                 //红色
    
    CGContextSaveGState(UIGraphicsGetCurrentContext());//此前的上下文状态入栈保存
    
    CGContextAddEllipseInRect(ctx, CGRectMake(100, 100, 50, 50));
    CGContextSetLineWidth(ctx, 10);
//    [[UIColor yellowColor] setStroke];                               //黄色
    CGContextStrokePath(ctx);
    
    CGContextRestoreGState(UIGraphicsGetCurrentContext());//pop上一次保存的上下文状态作为最新上下文状态
    
    CGContextAddEllipseInRect(ctx, CGRectMake(200, 100, 50, 50));    //红色
    CGContextStrokePath(ctx);
}

@end
