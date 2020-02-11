//
//  KDCalendarCore.swift
//  KeepDiary
//
//  Created by 白成慧&瑞瑞 on 2018/5/5.
//  Copyright © 2018年 白成慧. All rights reserved.
//

import Foundation

let weekStart: Int = 0;        // 周首日（可改成 app 配置）


//MARK:  - Public

/// 获取指定年月日历
///
/// - Parameters:
///   - year: 年
///   - month: 月
/// - Returns: 该月的日历
public func calendar(year:Int, month:Int)-> Dictionary<String, Any> {
    let inputDate = formatDate(year: year, month: month, day: -1)
    
    let _year : Int = inputDate["year"] as! Int
    let _month : Int = inputDate["month"] as! Int
    
    let calendarData = solarCalendar(year: _year, month: _month + 1) 
    
    return calendarData
}

//MARK:  - Private


/// 构造 Date
///
/// - Parameters:
///   - year: 年
///   - month: 月
///   - day: 日
/// - Returns: Date
private func date(year:Int, month:Int, day:Int)-> Date {
    let calendar = Calendar.current
    
    var components = DateComponents()
    components.year = year
    components.month = month + 1
    components.day = day
    
    if let date = calendar.date(from: components) {
        return date
    }
    return Date.init()
}

/// 根据 Date 获得星期几
///
/// - Parameter date: date
/// - Returns: 星期几
func getDay(date : Date)-> Int{
    let gregorian = Calendar.init(identifier: .gregorian)
    let components = gregorian.dateComponents([Calendar.Component.weekday], from: date)
    
    return components.weekday! - 1
}

/// 获取公历月份的天数
///
/// - Parameters:
///   - year: 公历年
///   - month: 公历月
/// - Returns: 该月天数
private func getSolarMonthDays(year:Int, month:Int)-> Int{
    if month == 1 {
        return isLeapYear(year: year) ? 29 : 28;
    } else {
        return solarDaysOfMonth(index: month)
    }
}

private func solarDaysOfMonth(index: Int) -> Int {
    let solarDaysOfMonth = [31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    return solarDaysOfMonth[index]
}

/// 以年月和长度构造一个日历
///
/// - Parameters:
///   - year: 年
///   - month: 月
///   - len: 参数
///   - start: 开始日期
/// - Returns: 整月日历
private func createMonthData(year: Int,month: Int,len: Int,start: Int)->Array<Dictionary<String, Any>> {
    var monthData = Array<Dictionary<String, Any>>()
    
    if len < 1 {
        return monthData
    }
    
    var k = start
    
    for _ in 0..<len {
        let dict = ["year":year,
                    "month":month,
                    "day":k]
        k = k + 1
        monthData.append(dict)
    }
    return monthData
}

/// 判断公历年是否是闰年
///
/// - Parameter year: 公历年
/// - Returns: 是否是闰年
private func isLeapYear(year:Int)-> Bool{
    return ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0));
}

/// 某月公历
///
/// - Parameters:
///   - year: 年
///   - month: 月
/// - Returns: 公历
private func solarCalendar(year:Int, month:Int)-> Dictionary<String, Any> {
    let inputDate = formatDate(year: year, month: month, day: -1)
    
    let _year : Int = inputDate["year"] as! Int
    let _month : Int = inputDate["month"] as! Int
    
    let firstDate = date(year: _year, month: _month, day: 1)
    var res = ["currentMonth":month,
                "firstDay":getDay(date: firstDate),// 该月1号星期几
               "monthDays":getSolarMonthDays(year: _year, month: _month),// 该月天数
               "monthData":[]] as [String : Any]
    res["monthData"] = createMonthData(year: year, month: _month + 1, len: res["monthDays"] as! Int, start: 1);
    
    let firstDay: Int = res["firstDay"] as! Int
    let moveDays: Int = (firstDay >= weekStart) ? firstDay : (firstDay + 7)
    let preFillDays: Int = moveDays - weekStart
    
    //前补齐
    let preYear: Int = (_month - 1 < 0) ? (year - 1) : (year)
    let preMonth: Int = (_month - 1 < 0) ? (11) : (_month - 1)
    let preMonthDays = getSolarMonthDays(year: preYear, month: preMonth)
    let preMonthData: Array = createMonthData(year: preYear, month: preMonth + 1, len: preFillDays, start: preMonthDays - preFillDays + 1)
    res["monthData"] = preMonthData + (res["monthData"] as! Array)
    
    //后补齐
    let length: Int = (res["monthData"] as! NSArray).count
    let fillLen = 7 * 6 - length
    if fillLen != 0 {
        let nextYear: Int = (_month + 1 > 11) ? (year + 1) : (year)
        let nextMonth: Int = (_month + 1 > 11) ? (0) : (_month + 1)
        let nextMonthData: Array = createMonthData(year: nextYear, month: nextMonth + 1, len: fillLen, start: 1)
        res["monthData"] = (res["monthData"] as! Array) + nextMonthData
    }
    return res
}

/// GMT 0 的时区
///
/// - Returns: 时区
private func timeZone()-> TimeZone {
    let _timeZone : TimeZone = NSTimeZone.system
//    let _timeZone : TimeZone = TimeZone(secondsFromGMT: 0)!
    
    return _timeZone
}

/// 统一日期输入参数（输入月份从1开始，内部月份统一从0开始）
///
/// - Parameters:
///   - year: 年
///   - month: 月
///   - day: 日
/// - Returns: 格式化的日期
private func formatDate(year:Int, month:Int, day:Int)-> Dictionary<String, Any> {
    let now = Date()
    
    var gregorian = Calendar.init(identifier: .gregorian)
    gregorian.timeZone = timeZone()
    
    let components = gregorian.dateComponents([Calendar.Component.year , Calendar.Component.month , Calendar.Component.day], from: now)
    let _year = year
    let _month = month - 1
    let _day = day > 0 ? day : components.day
    
    return ["year":_year,"month":_month,"day":_day!]
}

/// Date类型转化为日期字符串
///
/// - Parameters:
///   - date: Date类型
///   - dateFormat: 格式化样式默认“yyyy-MM-dd”
/// - Returns: 日期字符串
func dateConvertString(date:Date, dateFormat:String="yyyy-MM-dd") -> String {
//    let timeZone = TimeZone.init(identifier: "UTC")
    let formatter = DateFormatter()
    formatter.timeZone = timeZone()
    formatter.locale = Locale.current
    formatter.dateFormat = dateFormat
    let date = formatter.string(from: date)
    return date.components(separatedBy: " ").first!
}

/// 日期字符串转化为Date类型
///
/// - Parameters:
///   - string: 日期字符串
///   - dateFormat: 格式化样式，默认为“yyyy-MM-dd HH:mm:ss”
/// - Returns: Date类型
func stringConvertDate(string:String, dateFormat:String="yyyy-MM-dd HH:mm:ss") -> Date { 
//    let timeZone = TimeZone.init(identifier: "UTC")
    let formatter = DateFormatter()
    formatter.timeZone = timeZone()
    formatter.locale = Locale.current
    formatter.dateFormat = dateFormat
    let date = formatter.date(from: string)
    return date!
}

//MARK: - Setter And Getter
