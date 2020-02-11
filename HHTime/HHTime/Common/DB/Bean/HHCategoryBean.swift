//
//  CategoryBean.swift
//  HHTime
//
//  Created by tianxi on 2019/11/4.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation

class HHCategoryBean {
    var id: Int?
    var name: String?
    var type: Int?
    var isDefault: Int?
     
    init(){ }
    
    init(_ id:Int,_ name:String,_ type:Int, _ isDefault: Int = 0) {
        self.id = id
        self.name = name
        self.type = type
        self.isDefault = isDefault
    }
}
