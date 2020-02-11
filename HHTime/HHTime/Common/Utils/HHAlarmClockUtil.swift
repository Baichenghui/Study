//
//  HHAlarmClockUtil.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/23.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation

import UserNotifications
import UserNotificationsUI

internal struct HHAlarmClockUtil {

    // MARK: - 添加通知基础
    
    static func addCalendarAlarm(title:String,
                                   subtitle:String,
                                   body:String,
                                   summaryArgument:String,
                                   dateComponents:DateComponents,
                                   repeats:Bool = false,
                                   _ identifier:String = HHDefaultNotificationIdentifier) {
        HHNotificationManager.shared.addLocalNotification(title: title, subtitle: subtitle, body: body, summaryArgument: summaryArgument,identifier) { () -> (UNNotificationTrigger) in
            let trigger = UNCalendarNotificationTrigger.init(dateMatching: dateComponents, repeats: repeats)
            
            /// 闹钟重复时间设置
            /// https://blog.csdn.net/weixin_42857581/article/details/85399721#2_21
            
            return trigger
        }
    }
    
    static func addTimeIntervalAlarm(title:String,
                                   subtitle:String,
                                   body:String,
                                   summaryArgument:String,
                                   timeInterval:TimeInterval,
                                   repeats:Bool = false,
                                   _ identifier:String = HHDefaultNotificationIdentifier) {
        HHNotificationManager.shared.addLocalNotification(title: title, subtitle: subtitle, body: body, summaryArgument: summaryArgument,identifier) { () -> (UNNotificationTrigger) in
            
            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: timeInterval, repeats: repeats)
            return trigger
        }
    }
     
    // MARK: - 便利方法
    
    /// 注意：在测试时 iphone5 失效 ，使用：addTimeIntervalSimpleAlarm 即可
    static func addSimpleAlarm(title:String = "HHTime 闹钟", body:String?,date:Date) {
            let dateComponents = HHDateUtil.convertDateComponents(date)
            let weekDayString = HHDateUtil.convertToYMD_HMS(date: date)
            
            let identifier = buildIdentifier(tag: "addSimpleAlarm", date: date)
        
            addCalendarAlarm(title: title, subtitle: weekDayString, body: body ?? "", summaryArgument: "", dateComponents: dateComponents,identifier)
    }
    
    /// 注意：在测试时 iphone5 有效 ，可用于替代 addSimpleAlarm
    static func addTimeIntervalSimpleAlarm(title:String = "HHTime 闹钟", body:String?,date:Date) {
        let weekDayString = HHDateUtil.convertToYMD_HMS(date: date)
        let timeInterval:TimeInterval = TimeInterval(HHDateUtil.distanceInSeconds(fromDate: Date.init(), toDate: date))
        if (timeInterval <= 0){
            print("不能给过去时间设置闹钟")
            return
        }
        let identifier = buildIdentifier(tag: "addTimeIntervalSimpleAlarm", date: date)
        
        addTimeIntervalAlarm(title: title, subtitle: weekDayString, body: body ?? "", summaryArgument: "", timeInterval: timeInterval,identifier)
    }
    
    /// 重复周期：年
    static func addYearAlarm(title:String = "HHTime 闹钟", body:String?,
                            date:Date,
                         repeats:Bool = false) {
        let dateComponents = HHDateUtil.convertYearComponents(date)
        let weekDayString = HHDateUtil.convertToYMD_HMS(date: date)
        let identifier = buildIdentifier(tag: "addYearAlarm", date: date)
        
        addCalendarAlarm(title: title, subtitle: weekDayString, body: body ?? "", summaryArgument: "", dateComponents: dateComponents,repeats: repeats,identifier)
    }
    
    /// 重复周期：月
    static func addMonthAlarm(title:String = "HHTime 闹钟", body:String?,
                            date:Date,
                         repeats:Bool = false) {
        let dateComponents = HHDateUtil.convertMonthComponents(date)
        let weekDayString = HHDateUtil.convertToYMD_HMS(date: date)
        let identifier = buildIdentifier(tag: "addMonthAlarm", date: date)
         
        addCalendarAlarm(title: title, subtitle: weekDayString, body: body ?? "", summaryArgument: "", dateComponents: dateComponents,repeats: repeats,identifier)
    }
    
    /// 重复周期：周
    static func addWeekDayAlarm(title:String = "HHTime 闹钟", body:String?,
                         date:Date,
                         repeats:Bool = false) {
        let dateComponents = HHDateUtil.convertWeekDayComponents(date)
        let weekDayString = HHDateUtil.convertToYMD(date: date) + "  星期: " + HHDateUtil.convertWeekDayToString(dateComponents.weekday!)
        let identifier = buildIdentifier(tag: "addWeekDayAlarm", date: date)
        
        addCalendarAlarm(title: title, subtitle: weekDayString, body: body ?? "", summaryArgument: "", dateComponents: dateComponents,repeats: repeats,identifier)
    }
    
    /// 重复周期：天
    static func addDayAlarm(title:String = "HHTime 闹钟", body:String?,
                            date:Date,
                         repeats:Bool = false) {
        let dateComponents = HHDateUtil.convertDayComponents(date)
        let weekDayString = HHDateUtil.convertToYMD_HMS(date: date)
        let identifier = buildIdentifier(tag: "addDayAlarm", date: date)
         
        addCalendarAlarm(title: title, subtitle: weekDayString, body: body ?? "", summaryArgument: "", dateComponents: dateComponents,repeats: repeats,identifier)
    }
     
    /// 重复周期：时
    static func addHourAlarm(title:String = "HHTime 闹钟", body:String?,
                            date:Date,
                         repeats:Bool = false) {
        let dateComponents = HHDateUtil.convertHourComponents(date)
        let weekDayString = HHDateUtil.convertToYMD_HMS(date: date)
        let identifier = buildIdentifier(tag: "addHourAlarm", date: date)
         
        addCalendarAlarm(title: title, subtitle: weekDayString, body: body ?? "", summaryArgument: "", dateComponents: dateComponents,repeats: repeats,identifier)
    }
     
    /// 重复周期：分
    static func addMinuteAlarm(title:String = "HHTime 闹钟", body:String?,
                            date:Date,
                         repeats:Bool = false) {
        let dateComponents = HHDateUtil.convertMinuteComponents(date)
        let weekDayString = HHDateUtil.convertToYMD_HMS(date: date)
        let identifier = buildIdentifier(tag: "addMinuteAlarm", date: date)
         
        addCalendarAlarm(title: title, subtitle: weekDayString, body: body ?? "", summaryArgument: "", dateComponents: dateComponents,repeats: repeats,identifier)
    }
     
    /// 周一到周五的每天8点 提醒时，我的做法是用for循环创建5个通知：
    /**
            //因为周日是一星期第一天，1代表周日，所以周一从2开始
            for (NSInteger i = 2; i <= 6; i++) {
            //这里时间容器创建和以上每周提醒的一样，省略。
                    components.weekday = i;
                    
            //然后用这个components去添加通知就可以实现重复通知了
            }
     */
    static func addWorkDayAlarm(title:String = "HHTime 闹钟", body:String?,
                         date:Date,
                         repeats:Bool = false) {
        for i in 2...6 {
            var dateComponents = HHDateUtil.convertWeekDayComponents(date)
            dateComponents.weekday = i 
            let weekDayString = HHDateUtil.convertToYMD(date: date) + "  星期: " + HHDateUtil.convertWeekDayToString(dateComponents.weekday!)
            let identifier = buildIdentifier(tag: "addWorkDayAlarm", date: date)
            
            addCalendarAlarm(title: title, subtitle: weekDayString, body: body ?? "", summaryArgument: "", dateComponents: dateComponents,repeats: repeats,identifier)
        }
    }
     
    // MARK: - build identifier
    
    static func buildIdentifier(tag:String, date:Date) -> String {
        let dateComponents = HHDateUtil.convertDateComponents(date)
        return buildIdentifier(tag:tag, dateComponents: dateComponents)
    }
    
    static func buildIdentifier(tag:String, dateComponents:DateComponents) -> String {
        guard let second = dateComponents.second else {
            return tag + HHDefaultNotificationIdentifier
        }
        guard let minute = dateComponents.minute else {
            return tag + String(second)
        }
        guard let hour = dateComponents.hour else {
            return tag + String(minute) + String(second)
        }
         
        var dayOrWeekDay:Int
        if tag == "addWeekDayAlarm" {
            guard let weekDay = dateComponents.day else {
                return tag + String(hour) + String(minute) + String(second)
            }
            dayOrWeekDay = weekDay
        }
        else {
            guard let day = dateComponents.day else {
                return tag + String(hour) + String(minute) + String(second)
            }
            dayOrWeekDay = day
        }
        guard let month = dateComponents.month else {
            return tag + String(dayOrWeekDay) + String(hour) + String(minute) + String(second)
        }
        guard let year = dateComponents.month else {
            return tag + String(month) + String(dayOrWeekDay) + String(hour) + String(minute) + String(second)
        }
        
        return tag + String(year) + String(month) + String(dayOrWeekDay) + String(hour) + String(minute) + String(second)
    }
    
    // MARK: - test
     
    static func addAlarm(){
        HHEventKitUtil.saveReminder(title: "测试添加提醒", location: "西朱新村", notes: "啊说说大数据", date: HHDateUtil.getDateFromYMD_HMS(time: "2019-11-26 20:57:20"), priority: 1, recurrenceRule: nil, alarmOffsets: nil, calendar: nil) { (granted, error, success) in
                    
            if (success){
              
            }
        }
    }
}
