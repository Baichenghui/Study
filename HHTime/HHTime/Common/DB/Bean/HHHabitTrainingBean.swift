//
//  HHHabitTrainingBean.swift
//  HHTime
//
//  Created by tianxi on 2019/11/4.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation

class HHHabitTrainingBean {
    var id: Int?
    /// 习惯 ，对应HHHabitResult
    var habit: HHHabitBean?
    /// 提醒日的闹钟，每个提醒日有效性一样。（只能设置24小时时间，不能设置日期）
//    var alarms:[String]?
    var alarms:String? /// 用，分开
    ///  1、每月几次
    ///  2、每周几次     周日-周六 提供选择 [0，1，2，3，4，5，6]
    ///  3、每日几次
    var remindFrequencyType:Int?
    /// 一周的哪几天，只有当 remindFrequencyType == 2 时起作用
//    var weekDays:[Int]?
    var weekDays:String? /// 用，分开
    /// 鼓励语
    var encouragingSayings: String?
    /// 创建日期
    var createDate: String = String(Date.init().timeIntervalSinceNow)
    /// 已签到几天
    var signedDays:Int = 0
    
}
