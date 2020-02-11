//
//  DictionaryExtensions.swift
//  HHTime
//
//  Created by tianxi on 2019/11/28.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
