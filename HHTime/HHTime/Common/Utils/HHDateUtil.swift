//
//  DateUtil.swift
//  HHTime
//
//  Created by tianxi on 2019/11/1.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation

/*
 1、根据日期计算星期几 ✔️
 2、计算2个日期间隔天数 ✔️
 3、周年纪念日 ✔️
 4、每月纪念日 ✔️
 5、每周纪念日 ✔️
 6、当日进度 ✔️
 7、当周进度 ✔️
 8、当月进度 ✔️
 9、当年进度 ✔️
 。。。
 */

internal struct HHDateUtil {
    private static let gregorianCalendar = Calendar.init(identifier: .gregorian)
    private static let lunarCalendar = Calendar.init(identifier: .chinese)
    
    private static let components:Set<Calendar.Component> = [.year,.month,.day,.hour,.minute,.second,.weekday,.weekdayOrdinal,.weekOfMonth,.weekOfYear]
    private static let kOneDayTotalSeconds = 86400
    private static let kOneHourTotalSeconds = 3600
    private static let kOneMinuteTotalSeconds = 60
    
    private static let zodiacs: [String] = ["鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪"]
    
    private static let HeavenlyStems: [String] = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
    
    private static let EarthlyBranches: [String] = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]
    
    // MARK: Comparing dates

    static func isToday(date: Date) -> Bool {
        return isEqualIgnoringTime(date: date,otherDate: Date());
    }

    static func isInFuture(date: Date) -> Bool {
        return isLater(date: date,thanDate: Date())
    }

    static func isInPast(date: Date) -> Bool {
        return isEarlier(date: date,thanDate: Date())
    }
    
    static func isEqualIgnoringTime(date: Date, otherDate:Date) -> Bool {
        let components = gregorianCalendar.dateComponents([.year,.month,.day,.hour,.minute,.second,.weekday,.weekdayOrdinal], from: date)
        let otherComponents = gregorianCalendar.dateComponents([.year,.month,.day,.hour,.minute,.second,.weekday,.weekdayOrdinal], from: otherDate)

        return ((components.year == otherComponents.year) &&
            (components.month == otherComponents.month) &&
            (components.day == otherComponents.day))
    }
    
    static func isEqualIgnoringTime(dateComponents: DateComponents?, otherDate:Date) -> Bool { 
        guard let components = dateComponents else { return false }
        let otherComponents = gregorianCalendar.dateComponents([.year,.month,.day,.hour,.minute,.second,.weekday,.weekdayOrdinal], from: otherDate)

        return ((components.year == otherComponents.year) &&
            (components.month == otherComponents.month) &&
            (components.day == otherComponents.day))
    }
    
    static func isEqualIgnoringTime(year: Int?,month: Int?, day:Int?, otherDate:Date) -> Bool {
        let otherComponents = gregorianCalendar.dateComponents([.year,.month,.day,.hour,.minute,.second,.weekday,.weekdayOrdinal], from: otherDate)

        return ((year == otherComponents.year) &&
            (month == otherComponents.month) &&
            (day == otherComponents.day))
    }
    
    static func isEqualIgnoringTime(year: Int?,month: Int?, day:Int?, otherDateComponents: DateComponents) -> Bool { 
        return ((year == otherDateComponents.year) &&
            (month == otherDateComponents.month) &&
            (day == otherDateComponents.day))
    }
     
    // MARK: Retrieving intervals
    
    static func minuteAfterDate(date: Date,thanDate: Date) -> Int {
        let ti:TimeInterval = date.timeIntervalSince(thanDate)
        return Int(Int(ti) / kOneMinuteTotalSeconds)
    }
    
    static func minuteBeforeDate(date: Date,thanDate: Date) -> Int {
        let ti:TimeInterval = thanDate.timeIntervalSince(date)
        return Int(Int(ti) / kOneMinuteTotalSeconds)
    }
    
    static func hourAfterDate(date: Date,thanDate: Date) -> Int {
        let ti:TimeInterval = date.timeIntervalSince(thanDate)
        return Int(Int(ti) / kOneHourTotalSeconds)
    }
    
    static func hourBeforeDate(date: Date,thanDate: Date) -> Int {
        let ti:TimeInterval = thanDate.timeIntervalSince(date)
        return Int(Int(ti) / kOneHourTotalSeconds)
    }
        
    static func daysAfterDate(date: Date,thanDate: Date) -> Int {
        let ti:TimeInterval = date.timeIntervalSince(thanDate)
        return Int(Int(ti) / kOneDayTotalSeconds)
    }
    
    static func daysBeforeDate(date: Date,thanDate: Date) -> Int {
        let ti:TimeInterval = thanDate.timeIntervalSince(date)
        return Int(Int(ti) / kOneDayTotalSeconds)
    }
    
    static func distanceInDays(fromDate: Date,toDate: Date) -> Int {
        let components = gregorianCalendar.dateComponents([Calendar.Component.day], from: fromDate, to: toDate)
        return components.day!
    }
    
    static func distanceInSeconds(fromDate: Date,toDate: Date) -> Int {
        let components = gregorianCalendar.dateComponents([.second], from: fromDate, to: toDate)
        return components.second!
    }
    
    // MARK: Adjusting dates
    
    static func nextMonthDate(_ date: Date)-> Date? {
        var components = gregorianCalendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        // 定位到当月中间日子
        components.day = 15
        
        if (components.month == 12) {
            components.month = 1;
            components.year = components.year! + 1;
        } else {
            components.month = components.month! + 1;
        }
        let nextDate = gregorianCalendar.date(from: components)
        
        return nextDate
    }
    
    static func previousMonthDate(_ date: Date)-> Date? {
        var components = gregorianCalendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        // 定位到当月中间日子
        components.day = 15
        
        if (components.month == 1) {
            components.month = 12
            components.year = components.year! - 1
        } else {
            components.month = components.month! - 1
        }
        let previousDate = gregorianCalendar.date(from: components)
        
        return previousDate
    }
    
    /// 在日期上加天数，得到新的日期
    /// - Parameter date: date
    /// - Parameter days: days
    static func dateByAddingDays(date: Date,days: Int) -> Date {
        let aTimeInterval = date.timeIntervalSinceReferenceDate + TimeInterval(kOneDayTotalSeconds * days)
        let newDate = Date.init(timeIntervalSinceReferenceDate: aTimeInterval)
        
        return newDate
    }
    
    /// 在日期上减天数，得到新的日期
    /// - Parameter date: date
    /// - Parameter days: days
    static func dateBySubtractingDays(date: Date,days: Int) -> Date {
        
        return dateByAddingDays(date: date, days: days * -1)
    }
    
    // MARK: Decomposing dates
    
    static func year(date: Date) -> Int {
        let components = gregorianCalendar.dateComponents([.year], from: date)
        return components.year!
    }
    
    static func month(date: Date) -> Int {
        let components = gregorianCalendar.dateComponents([.month], from: date)
        return components.month!
    }
    
    static func day(date: Date) -> Int {
        let components = gregorianCalendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    static func hour(date: Date) -> Int {
        let components = gregorianCalendar.dateComponents([.hour], from: date)
        return components.hour!
    }
    
    static func minute(date: Date) -> Int {
        let components = gregorianCalendar.dateComponents([.minute], from: date)
        return components.minute!
    }
    
    static func seconds(date: Date) -> Int {
        let components = gregorianCalendar.dateComponents([.second], from: date)
        return components.second!
    }
     
    /// 返回日期的星期索引（1 =星期日，2 =星期一，…，7 =星期六）
    /// - Parameter date: date
    static func weekday(date: Date) -> Int {
        let components = gregorianCalendar.dateComponents([.weekday], from: date)
        return components.weekday!
    }
    
    /// 一个月中的第几周
    /// - Parameter date: date
    static func weekOfMonth(date: Date) -> Int {
        let components = gregorianCalendar.dateComponents([.weekOfMonth], from: date)
        return components.weekOfMonth!
    }
    
    /// 一年中的第几周
    /// - Parameter date: date
    static func weekOfYear(date: Date) -> Int {
        let components = gregorianCalendar.dateComponents([.weekOfYear], from: date)
        return components.weekOfYear!
    }

    /// 判断公历年是否是闰年
    ///
    /// - Parameter year: 公历年
    /// - Returns: 是否是闰年
    static func isLeapYear(year:Int)-> Bool{
        return ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0));
    }
    
    /// GMT 0 的时区
    ///
    /// - Returns: 时区
    static func timeZone()-> TimeZone {
        let _timeZone : TimeZone = NSTimeZone.system
    //    let _timeZone : TimeZone = TimeZone(secondsFromGMT: 0)!
        
        return _timeZone
    }
    
    /// 获取公历月份的天数
    ///
    /// - Parameters:
    ///   - year: 公历年
    ///   - month: 公历月 （0 - 11）
    /// - Returns: 该月天数
    static func getSolarMonthDays(year:Int, month:Int)-> Int{
        if month == 1 {
            return isLeapYear(year: year) ? 29 : 28;
        } else {
            return solarDaysOfMonth(index: month)
        }
    }
    
    // MARK: time schedule
    
    /// 当日时间度过百分比
    /// - Parameter date: date
    static func scheduleOfDay(_ date: Date) -> Float {
        return Float(hour(date: date) * kOneHourTotalSeconds
        + minute(date: date) * kOneMinuteTotalSeconds
        + seconds(date: date))
            / Float(kOneDayTotalSeconds)
    }
    
    /// 当周度过百分比
    /// - Parameter date: date
    static func scheduleOfWeek(_ date: Date) -> Float {
        return Float(weekday(date: date) - 1)
            / Float(7)
    }
    
    /// 当月度过百分比
    /// - Parameter date: date
    static func scheduleOfMonth(_ date: Date) -> Float {
        return Float(day(date: date))
            / Float(getSolarMonthDays(year: year(date: date),month: month(date: date) - 1))
    }
    
    /// 当年度过百分比
    /// - Parameter date: date
    static func scheduleOfYear(_ date: Date) -> Float {
        let inYear = year(date: date)
            
        return Float(distanceInDays(fromDate: getDateFromYMD(time: String(inYear)+"-01"+"-01"), toDate: Date())) / Float(isLeapYear(year: inYear) ? 366 : 365)
    }
    
    // MARK: anniversary
    
    /// 距离新年多少天
    static func daysBeforeNewYear() -> Int {
        let currentDate = Date()
        
        let inYear = year(date: currentDate)
        let inMonth = month(date: currentDate)
        let inDay = day(date: currentDate)
        //重组当前日期，比较时间时，格式要一样（YYYY-MM-DD）
        let fromDate = getDateFromYMD(time: String(inYear)+"-"+String(inMonth)+"-"+String(inDay))
         
        //周年倒数日，用当前年份算
        let toYear = inYear + 1
        let toMonth = 01
        let toDay = 01
        
        //纪念日
        var toDate = getDateFromYMD(time: String(toYear)+"-"+String(toMonth)+"-"+String(toDay))
        if(isToday(date: toDate)){
            //今天就是纪念日
            return 0
        }
        else if(isInPast(date: toDate)){
            //如果不是未来的日期，说明今年纪念日已经过完，需要计算当前日期到下一年纪念日时间间隔
            toDate = getDateFromYMD(time: String(toYear+1)+"-"+String(toMonth)+"-"+String(toDay))
        }
        //如果是未来的日期，说明今年周年日还没到,不需要修改年份
        
        return distanceInDays(fromDate: fromDate, toDate: toDate)
    }
    
    /// 计算下个周年纪念日（如每年的生日）还剩几天
    /// - Parameter date: 纪念初始日（如出生日：1992-09-13）
    static func daysOfAnniversaryAnnual(date: Date) -> Int {
        let currentDate = Date()
        
        let inYear = year(date: currentDate)
        let inMonth = month(date: currentDate)
        let inDay = day(date: currentDate)
        //重组当前日期，比较时间时，格式要一样（YYYY-MM-DD）
        let fromDate = getDateFromYMD(time: String(inYear)+"-"+String(inMonth)+"-"+String(inDay))
         
        //周年倒数日，用当前年份算
        let toYear = inYear
        let toMonth = month(date: date)
        let toDay = day(date: date)
        
        //纪念日
        var toDate = getDateFromYMD(time: String(toYear)+"-"+String(toMonth)+"-"+String(toDay))
        if(isToday(date: toDate)){
            //今天就是纪念日
            return 0
        }
        else if(isInPast(date: toDate)){
            //如果不是未来的日期，说明今年纪念日已经过完，需要计算当前日期到下一年纪念日时间间隔
            toDate = getDateFromYMD(time: String(toYear+1)+"-"+String(toMonth)+"-"+String(toDay))
        }
        //如果是未来的日期，说明今年周年日还没到,不需要修改年份
        
        return distanceInDays(fromDate: fromDate, toDate: toDate)
    }
    
    /// 计算下个月纪念日（如每月15号发工资）还剩几天
    /// - Parameter day: 每月的几号
    static func daysOfAnniversaryMonthly(dateOfDay: Int) -> Int {
        let currentDate = Date()
        
        let inYear = year(date: currentDate)
        let inMonth = month(date: currentDate)
        let inDay = day(date: currentDate)
        //重组当前日期，比较时间时，格式要一样（YYYY-MM-DD）
        let fromDate = getDateFromYMD(time: String(inYear)+"-"+String(inMonth)+"-"+String(inDay))
        
        //纪念日(默认：本月纪念日还没到)
        var toYear = inYear
        var toMonth = inMonth
        let toDay = dateOfDay
    
        if(dateOfDay == inDay){
            //今天就是本月纪念日
            return 0
        }
        else if(dateOfDay < inDay){
            //本月纪念日已过，计算到下一个月的纪念日时间间隔
            if(inMonth == 12){
                //今年纪念日已经过完，下一个纪念日是下一年第一个月的纪念日
                toYear += 1
                toMonth = 1
            }
            else {
                //今年的当前月的下一个月
                toMonth += 1
            }
        }
        //本月纪念日还没到
        
        let toDate = getDateFromYMD(time: String(toYear)+"-"+String(toMonth)+"-"+String(toDay))
        
        return distanceInDays(fromDate: fromDate, toDate: toDate)
    }
    
    /// TODO : 待测试
    /// 计算下个周纪念日还剩几天
    /// - Parameter weekDay: 星期几（1 =星期日，2 =星期一，…，7 =星期六）
    static func daysOfAnniversaryWeekly(weekDay: Int) -> Int {
        let currentDate = Date()
         
        let toWeekDay = weekDay
        let inCurrentWeekDay = weekday(date: currentDate)
        //间隔天数
        var distanceDays = 0
         
        if(toWeekDay == inCurrentWeekDay){
             //今天就是本周纪念日
             return distanceDays
        }
        
        if(toWeekDay < inCurrentWeekDay){
             //本周纪念日已过，计算到下一个周的纪念日时间间隔
             distanceDays = 7 - inCurrentWeekDay + toWeekDay
             if (distanceDays == 7) {
                return 0
             }
        }
        else {
             //本周纪念日还没到
             distanceDays = toWeekDay - inCurrentWeekDay
        }
         
        return distanceDays
    }
    
    // MARK: Format
     
    static func convertWeekDayToString(_ weekday: Int,_ dayType: Int = 0) -> String {
        var weekDayString = ""
        switch weekday {
            case 1:
                weekDayString = dayType == 1 ?  "7" : "日";
                break;
            case 2:
                weekDayString = dayType == 1 ?  "1" : "一";
                break;
            case 3:
                weekDayString = dayType == 1 ?  "2" : "二";
                break;
            case 4:
                weekDayString = dayType == 1 ?  "3" : "三";
                break;
            case 5:
                weekDayString = dayType == 1 ?  "4" : "四";
                break;
            case 6:
                weekDayString = dayType == 1 ?  "5" : "五";
                break;
            case 7:
                weekDayString = dayType == 1 ?  "6" : "六";
                break;
            default:
                weekDayString = ""
            }
        return weekDayString
    }
     
    static func convertDateComponents(_ date: Date) -> DateComponents {
        let components = gregorianCalendar.dateComponents([.year,.month,.weekday,.day,.hour,.minute,.second], from: date)
        
        return components
    }
    
    /// 每分x秒
    /// - Parameter date: date description
    static func convertMinuteComponents(_ date: Date) -> DateComponents {
        let components = gregorianCalendar.dateComponents([.second], from: date)
        
        return components
    }
    
    /// 每时x分
    /// - Parameter date: date description
    static func convertHourComponents(_ date: Date) -> DateComponents {
        let components = gregorianCalendar.dateComponents([.minute,.second], from: date)
        
        return components
    }
    
    /// 每天x点
    /// - Parameter date: date description
    static func convertDayComponents(_ date: Date) -> DateComponents {
        let components = gregorianCalendar.dateComponents([.hour,.minute,.second], from: date)
        
        return components
    }
    
    /// 每周x   x点
    /// - Parameter date: date description
    static func convertWeekDayComponents(_ date: Date) -> DateComponents {
        let components = gregorianCalendar.dateComponents([.weekday,.hour,.minute,.second], from: date)
        
        return components
    }
    
    /// 每月x号x点
    /// - Parameter date: date description
    static func convertMonthComponents(_ date: Date) -> DateComponents {
        let components = gregorianCalendar.dateComponents([.day,.hour,.minute,.second], from: date)
        
        return components
    }
    
    /// 每年x月x号x点
    /// - Parameter date: date description
    static func convertYearComponents(_ date: Date) -> DateComponents {
        let components = gregorianCalendar.dateComponents([.month,.day,.hour,.minute,.second,.weekday], from: date)
        
        return components
    }

    static func convertToYMD(date: Date) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat="yyyy-MM-dd"
        
        return dateformatter.string(from: date)
    }
    
    static func convertToYMD_HMS(date: Date) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        
        return dateformatter.string(from: date)
    }
    
    static func getDateFromYMD(time:String) -> Date {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat="yyyy-MM-dd"
           
        return dateformatter.date(from: time)!
    }
       
    static func getDateFromYMD_HMS(time:String) -> Date {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat="yyyy-MM-dd HH:mm:ss"
           
        return dateformatter.date(from: time)!
    }
     
    static func getTimeInterval(time: String) -> Int {
        let interval = (getDateFromYMD(time: time).timeIntervalSince1970) * 1000
        return Int(interval)
    }
    
    static func getTimeInterval(time: Date) -> Int {
        let interval = (time.timeIntervalSince1970) * 1000
        return Int(interval)
    }
    
    // MARK: 生肖
    
    /// 生肖
    /// - Parameter year: 农历年份
    static func zodiac(withYear year: Int) -> String {
        let zodiacIndex: Int = (year - 1) % zodiacs.count
        return zodiacs[zodiacIndex]
    }
    /// 生肖
    /// - Parameter date: 阳历日期
    static func zodiac(withDate date: Date) -> String {
        return zodiac(withYear: lunarCalendar.component(.year, from: date))
    }

    // MARK: 计算日期年份的天干地支
     
    /// 天干地支
    /// - Parameter year: 农历年
    static func era(withYear year: Int) -> String {
        let heavenlyStemIndex: Int = (year - 1) % HeavenlyStems.count
        let heavenlyStem: String = HeavenlyStems[heavenlyStemIndex]
        let earthlyBrancheIndex: Int = (year - 1) % EarthlyBranches.count
        let earthlyBranche: String = EarthlyBranches[earthlyBrancheIndex]
        return heavenlyStem + earthlyBranche
    }
    
    /// 天干地支
    /// - Parameter date: 阳历日期
    static func era(withDate date: Date) -> String {
        return era(withYear: lunarCalendar.component(.year, from: date))
    }
    
    // MARK: Tools
    
    /// 阳历每月天数
    /// - Parameter index: 月份index
    public static func solarDaysOfMonth(index: Int) -> Int {
        let solarDaysOfMonth = [31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        
        return solarDaysOfMonth[index]
    }

    private static func isLater(date:Date, thanDate:Date) -> Bool {
        return date.compare(thanDate) == .orderedDescending
    }

    private static func isEarlier(date:Date, thanDate:Date) -> Bool {
        return date.compare(thanDate) == .orderedAscending
    }
}
