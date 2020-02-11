//
//  HHUserDefaultUtil.swift
//  HHTime
//
//  Created by tianxi on 2019/11/4.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation

internal struct HHUserDefaultUtil {
    
    /// 分类数据库默认数据是否插入数据库 key
    static let kInitCategoryDBKey = "kInitCategoryDBKey"
    
    static let kEventIdentifierKey = "kEventIdentifierKey"
 
    
    static func set(key:String, value: Any?) {
        let defaultStand = UserDefaults.standard
        defaultStand.set(value, forKey: key)
        defaultStand.synchronize()
    }
 
    static func get(key:String) -> Any? {
        let defaultStand = UserDefaults.standard
        return defaultStand.value(forKey: key)
    }
}
