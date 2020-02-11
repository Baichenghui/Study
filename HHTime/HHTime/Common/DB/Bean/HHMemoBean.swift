//
//  HHMemoBean.swift
//  HHTime
//
//  Created by tianxi on 2019/11/4.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation

class HHMemoBean {
    var id: Int?
    var type: Int
    var identifier: String
      
    init(_ id:Int,_ identifier:String,_ type:Int) {
        self.id = id
        self.identifier = identifier
        self.type = type
    }
}
