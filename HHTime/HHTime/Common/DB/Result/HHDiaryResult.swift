//
//  HHDiaryResult.swift
//  HHTime
//
//  Created by tianxi on 2019/12/4.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation

class HHDiaryResult {
    var id: Int?
    var title: String?
    var content: String?
    var date: String?
    var color: String?
  
    init(){ }
    
    init(_ id:Int,_ title:String,_ content:String,_ date:String,_ color: String) {
        self.id = id
        self.title = title
        self.content = content
        self.date = date
        self.color = color
    }
}
