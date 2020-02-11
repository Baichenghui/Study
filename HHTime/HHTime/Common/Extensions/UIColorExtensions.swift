
//
//  UIColorExtensions.swift
//  TCCommon_Example
//
//  Created by hh on 2018/6/16.
//  Copyright © 2018年 hh. All rights reserved.
//

import UIKit

private struct Color {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
}

public extension UIColor {
    /**
     * Initializes and returns a color object for the given RGB hex integer.
     */
    convenience init(rgb: Int) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8)  / 255.0,
            blue: CGFloat((rgb & 0x0000FF) >> 0)  / 255.0,
            alpha: 1)
    }
    
    convenience init(colorString: String) {
        var colorInt: UInt64 = 0
        Scanner(string: colorString).scanHexInt64(&colorInt)
        self.init(rgb: (Int) (colorInt))
    }
}
