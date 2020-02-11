//
//  HHDaysMatterBean.swift
//  HHTime
//
//  Created by tianxi on 2019/11/4.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation
 
class HHDaysMatterBean {
    var id: Int?
    var name: String?
    var targetDate: Int?
    var endDate: Int?
    var isTop: Int?
    var isLunar: Int?
    var repeatType: Int?
     
    var category:HHCategoryBean?
    
    init(){ }
    
    init(_ id:Int,_ name:String,_ targetDate:Int,_ endDate: Int,_ category: HHCategoryBean,_ isTop: Int,_ isLunar: Int,_ repeatType: Int) {
        self.id = id
        self.name = name
        self.targetDate = targetDate
        self.endDate = endDate
        self.category = category
        self.isTop = isTop
        self.isLunar = isLunar
        self.repeatType = repeatType
    }
}
