//
//  UIImageExtensions.swift
//  KeepDiary
//
//  Created by hh on 2018/6/16.
//  Copyright © 2018年 hh. All rights reserved.
//

import UIKit

public extension UIImage {
    
    func imageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func imageWithColor(_ color: UIColor) -> UIImage { 
        let rect = CGRect(origin: CGPoint.zero, size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context!.translateBy(x: 0, y: self.size.height)
        context!.scaleBy(x:1,y:-1)
        context!.setBlendMode(CGBlendMode.normal);
        context!.clip(to: rect, mask: self.cgImage!) 
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    
//    /**
//     *  重新绘制图片
//     *
//     *  @param color 填充色
//     *
//     *  @return UIImage
//     */
//    - (UIImage *)imageWithColor:(UIColor *)color
//    {
//    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextTranslateCTM(context, 0, self.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    CGContextSetBlendMode(context, kCGBlendModeNormal);
//    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
//    CGContextClipToMask(context, rect, self.CGImage);
//    [color setFill];
//    CGContextFillRect(context, rect);
//    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
//    }
    
}
