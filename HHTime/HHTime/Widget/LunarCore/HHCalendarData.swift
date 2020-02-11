//
//  HHCalendarData.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/23.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation

enum HHSourceType {
    case HHSourceTypeCalendar
    case HHSourceTypeEvent
    case HHSourceTypeReminder
    case HHSourceTypeDiary
    case HHSourceTypeAlarm
    case HHSourceTypeDaysMatter
    case HHSourceTypeHabitTraining
}

struct HHCalendarData {
    /// 自定义的日历数据
    /// 来源类型 （）
    var sourceType:HHSourceType
    
    /// 标题
    var title:String?
    
    ///  唯一标识
    var identifier:String?

    /// 对应日期
    var dateComponents:DateComponents?
    
    /// 纯日历数据
    
    /// 阳历
    var solarDay:String?
    
    /// 农历
    var lunarDay:String?
    
    /// 干支
    var ganZhiYear:String?
    
    /// 生肖
    var zodiac:String?
    
    /// 节气
    var term:String?
    
    /// 阳历节日
    var solarFestival:String?
    
    /// 农历节日
    var lunarFestival:String?
    
    /// 周节日
    var weekFestival:String?
    
    /// 中国节日放假安排，外部设置，0无特殊安排，1工作，2放假
    var weektime:Int?
}

/*
 
 "lunarDay": lunarDate[2],
 "lunarMonthName": `$`(lunarMonthName),
 "lunarDayName": `$`(lunarCalendarData["dateCn"]![lunarDate2 - 1]),
 "solarFestival": i18n(`$`(solarFestival[formatDay(month,day)])),
 "lunarFestival": `$`(i18n(lunarFtv ?? "")),
 "weekFestival": `$`(getWeekFestival(year, month + 1, day)),
 "worktime": workTime,
 "GanZhiYear": `$`(getLunarYearName(GanZhiYear, 0)),
 "zodiac": `$`(getYearZodiac(GanZhiYear)),
 "term": `$`(termList[formatDay(month, day)])
 */
