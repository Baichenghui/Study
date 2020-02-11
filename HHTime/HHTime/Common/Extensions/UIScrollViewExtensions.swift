//
//  UIScrollViewExtensions.swift
//  HHTime
//
//  Created by tianxi on 2019/11/5.
//  Copyright © 2019 hh. All rights reserved.
//

import UIKit

public extension UIScrollView {
    
    func hh_contentInsert() -> UIEdgeInsets {
        if #available(iOS 11, *) {
            return self.adjustedContentInset;
        } else {
            return self.contentInset;
        }
    }
}

