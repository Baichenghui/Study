//
//  HHDaysMatterResult.swift
//  HHTime
//
//  Created by tianxi on 2019/12/4.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation

///// 倒数日表
////id
//let id_daysMatter = rowid
////事件名称
//let name_daysMatter = Expression<String>("nameDaysMatter")
////目标日期
//let targetDate_daysMatter = Expression<String>("targetDateDaysMatter")
////结束 日期
//let endDate_daysMatter = Expression<String>("endDateDaysMatter")
////分类 id
//let categoryId_daysMatter = Expression<Int>("categoryIdDaysMatter")
////是否置顶
//let isTop_daysMatter = Expression<Int>("isTopDaysMatter")
////是否是农历
//let isLunar_daysMatter = Expression<Int>("isLunarDaysMatter")
////重复类型（0、不重复；1、周重复；2、月重复；3、年重复；4、天重复）
//let repeatType_daysMatter = Expression<Int>("repeatTypeDaysMatter")

class HHDaysMatterResult {
    var id: Int?
    var name: String?
    var targetDate: Int?
    var endDate: Int?
    var categoryId: Int?
    var isTop: Int?
    var isLunar: Int?
    var repeatType: Int?
    
    init(){ }
    
    init(_ id:Int,_ name:String,_ targetDate:Int,_ endDate: Int,_ categoryId: Int,_ isTop: Int,_ isLunar: Int,_ repeatType: Int) {
        self.id = id
        self.name = name
        self.targetDate = targetDate
        self.endDate = endDate
        self.categoryId = categoryId
        self.isTop = isTop
        self.isLunar = isLunar
        self.repeatType = repeatType
    }
}
