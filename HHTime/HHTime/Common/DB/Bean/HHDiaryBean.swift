//
//  HHDiaryBean.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/12.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation

class HHDiaryBean {
    var id: Int?
    var title: String
    var content: String
    var date: String
    var color: String 
    
    init(_ id:Int,_ title:String,_ content:String,_ date:String,_ color: String) {
        self.id = id
        self.title = title
        self.content = content
        self.date = date
        self.color = color
    }
}
