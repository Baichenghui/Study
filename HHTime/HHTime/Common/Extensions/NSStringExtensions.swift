//
//  NSStringExtensions.swift
//  KeepDiary
//
//  Created by hh on 2018/6/16.
//  Copyright © 2018年 hh. All rights reserved.
//
 
import UIKit

public extension NSString {
    
    func getSize(constrainedToSize: CGSize, attributes: [NSAttributedString.Key : Any]?) -> CGSize {
        
        var resultSize = CGSize.zero
        
        if self.length <= 0 {
            return resultSize
        }
        
        resultSize = boundingRect(with: constrainedToSize, options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.RawValue(UInt8(NSStringDrawingOptions.usesFontLeading.rawValue) | UInt8(NSStringDrawingOptions.usesLineFragmentOrigin.rawValue))), attributes: attributes, context: nil).size
        
        return resultSize;
    } 
}
