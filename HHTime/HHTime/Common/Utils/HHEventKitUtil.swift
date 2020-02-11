//
//  HHEventCalendarUtil.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/10.
//  Copyright © 2019 hh. All rights reserved.
//

import UIKit
import EventKit

internal struct HHEventKitUtil {
    private static let store = EKEventStore.init()
    
    // MARK: - save
    
    static func saveReminderCalendar(title:String?,
                             identifier:String?,
                             color:UIColor?,
                             completion:(@escaping(Bool,Error?,Bool)->())){
        DispatchQueue.global().async {
            self.store.requestAccess(to: EKEntityType.reminder) { (granted, error) in
                DispatchQueue.main.async {
                    if error != nil {
                        print("添加日历失败，，错误了。。。")
                        completion(false, error, false)
                    }
                    else if(!granted) {
                        print("不允许使用日历，没有权限")
                        completion(false, nil, false)
                    }
                    else {
                        var cal: EKCalendar?
                        for calendar in self.store.calendars(for: .reminder) {
                            if calendar.title == title {
                                cal = calendar
                                break
                            }
                        }
                        
                        if let identifier = identifier {
                            //已存在，修改
                            cal = self.store.calendar(withIdentifier: identifier)
                            if let title = title {
                                cal?.title = title
                            }
                            if let color = color {
                                cal?.cgColor = color.cgColor
                            }
                        }
                        else {
                            if cal != nil {
                                if let title = title {
                                    cal?.title = title
                                }
                                if let color = color {
                                    cal?.cgColor = color.cgColor
                                }
                            } else {
                                //不存在，添加
                                guard let title = title else { return  }
                                
                                cal = EKCalendar.init(for: .reminder, eventStore: self.store)
                                cal?.title = title
                                
                                var toSource:EKSource?
                                for source in self.store.sources {
                                    if source.sourceType == EKSourceType.calDAV
                                        && source.title == "iCloud" {
                                        toSource = source
                                        break
                                    }

                                    if source.sourceType == EKSourceType.local {
                                        toSource = source
                                        break
                                    }
                                }
                                cal?.source = toSource
                                if let color = color {
                                    cal?.cgColor = color.cgColor
                                }
                            }
                        }
                        
                        guard let calendar = cal else { return  }
                        do {
                            try self.store.saveCalendar(calendar, commit: true)
                            completion(false, nil, true)
                            print("HHEventKitUtil:添加日历成功")
                        } catch {
                            // error异常的对象
                            print(error)
                            completion(false, error, false)
                        }
                    }
                }
            }
        }
    }
    
    static func saveEventCalendar(title:String?,
                             identifier:String?,
                             color:UIColor?,
                             completion:(@escaping(Bool,Error?,Bool)->())){
        DispatchQueue.global().async {
        
            self.store.requestAccess(to: EKEntityType.event) { (granted, error) in
                if error != nil {
                    print("添加日历失败，，错误了。。。")
                    DispatchQueue.main.async {
                        completion(false, error, false)
                    }
                }
                else if(!granted) {
                    print("不允许使用日历，没有权限")
                    DispatchQueue.main.async {
                        completion(false, nil, false)
                    }
                }
                else {
                    var cal: EKCalendar?
                    for calendar in self.store.calendars(for: .event) {
                        if calendar.title == title {
                            cal = calendar
                            break
                        }
                    }
                    
                    if let identifier = identifier {
                        //已存在，修改
                        cal = self.store.calendar(withIdentifier: identifier)
                        if let title = title {
                            cal?.title = title
                        }
                        if let color = color {
                            cal?.cgColor = color.cgColor
                        }
                    }
                    else {
                        if cal != nil {
                            if let title = title {
                                cal?.title = title
                            }
                            if let color = color {
                                cal?.cgColor = color.cgColor
                            }
                        } else {
                            //不存在，添加
                            guard let title = title else { return  }
                            
                            cal = EKCalendar.init(for: .event, eventStore: self.store)
                            cal?.title = title
                            
                            var toSource:EKSource?
                            for source in self.store.sources {
                                if source.sourceType == EKSourceType.calDAV
                                    && source.title == "iCloud" {
                                    toSource = source
                                    break
                                }
                                
                                if source.sourceType == EKSourceType.local {
                                    toSource = source
                                    break
                                }
                            }
                            cal?.source = toSource
                            if let color = color {
                                cal?.cgColor = color.cgColor
                            }
                        }
                    }
                    
                    guard let calendar = cal else { return  }
                    do {
                        try self.store.saveCalendar(calendar, commit: true)
                        DispatchQueue.main.async {
                            completion(false, nil, true)
                        }
                        print("HHEventKitUtil:添加日历成功")
                    } catch {
                        // error异常的对象
                        print(error)
                        DispatchQueue.main.async {
                            completion(false, error, false)
                        }
                    }
                }
            }
        }
    }
    
    static func saveReminder(title: String,
                            location: String?,
                            notes: String?,
                            date: Date = Date(),
                            priority:Int,
                            recurrenceRule:EKRecurrenceRule?,
                            alarmOffsets: [Int]?,
                            calendar: EKCalendar?,
                            completion:(@escaping(Bool,Error?,Bool)->())){
        DispatchQueue.global().async {
        
            self.store.requestAccess(to: EKEntityType.reminder) { (granted, error) in
                if error != nil {
                    print("HHEventKitUtil:添加失败，，错误了。。。")
                    DispatchQueue.main.async {
                        completion(false,error,false)
                    }
                }
                else if(!granted) {
                    print("HHEventKitUtil:不允许使用事项提醒，没有权限")
                    DispatchQueue.main.async {
                        completion(false,nil,false)
                    }
                }
                else {
                    let reminder = EKReminder.init(eventStore: self.store)
                    reminder.title = title
                    reminder.location = location
                    reminder.notes = notes
                    reminder.priority = priority
                    
                    //重复
                    if let recurrenceRule = recurrenceRule {
                        /**
                         - (instancetype)initRecurrenceWithFrequency:(EKRecurrenceFrequency)type
                                interval:(NSInteger)interval
                           daysOfTheWeek:(nullable NSArray<EKRecurrenceDayOfWeek *> *)days
                          daysOfTheMonth:(nullable NSArray<NSNumber *> *)monthDays
                         monthsOfTheYear:(nullable NSArray<NSNumber *> *)months
                          weeksOfTheYear:(nullable NSArray<NSNumber *> *)weeksOfTheYear
                           daysOfTheYear:(nullable NSArray<NSNumber *> *)daysOfTheYear
                            setPositions:(nullable NSArray<NSNumber *> *)setPositions
                                     end:(nullable EKRecurrenceEnd *)end;
                         
                         https://www.jianshu.com/p/4a903233c022
                         */
                        reminder.addRecurrenceRule(recurrenceRule)
                    }
                    
                    //添加日历
                    if let calendar = calendar {
                        reminder.calendar = calendar
                    } else {
                        reminder.calendar = self.store.defaultCalendarForNewReminders()
                    }
                    
                    var currentCalendar = NSCalendar.current
                    currentCalendar.timeZone = NSTimeZone.system
                    let flags:Set<Calendar.Component> = [.year,.month,.day,.hour,.minute,.second]
                    var dateComponents = currentCalendar.dateComponents(flags, from: date)
                    //判断 这个时间是周几 和 每周第一个提醒时间对比
                    dateComponents.timeZone = NSTimeZone.system
                    //开始时间
                    reminder.startDateComponents = dateComponents
                    //到期时间
                    reminder.dueDateComponents = dateComponents
                     
                    if let alarmOffsets = alarmOffsets {
                        for offset in alarmOffsets {
                            // 添加闹钟结合（开始前多少秒为负，若为正则是开始后多少秒。）
                            let elarm = EKAlarm.init(relativeOffset:TimeInterval(offset))
                            reminder.addAlarm(elarm)
                        }
                    }
                    
                    do {
                        try self.store.save(reminder, commit: true)
                        DispatchQueue.main.async {
                            completion(true,nil,true)
                        }
                        print("HHEventKitUtil:添加提醒成功")
                    } catch {
                        // error异常的对象
                        print(error)
                        DispatchQueue.main.async {
                            completion(true,error,false)
                        }
                    }
                }
            }
        }
    }
    
    static func saveEvent(title: String,
                         location: String?,
                         notes: String?,
                         sinceDate: Date = Date(),
                         startTimeInterval: TimeInterval!,
                         endTimeInterval: TimeInterval!,
                         isAllDay: Bool = false,
                         alarmOffsets: [Int]?,
                         calendar: EKCalendar?,
                         completion:(@escaping(Bool,Error?,Bool)->())){
        DispatchQueue.global().async {
        
            self.store.requestAccess(to: EKEntityType.event) { (granted, error) in
                if error != nil {
                    print("HHEventKitUtil:添加失败，，错误了。。。")
                    DispatchQueue.main.async {
                        completion(false,error,false)
                    }
                }
                else if(!granted) {
                    print("HHEventKitUtil:不允许使用日历，没有权限")
                    DispatchQueue.main.async {
                        completion(false,nil,false)
                    }
                }
                else {
                    let event = EKEvent.init(eventStore: self.store)
                    event.title = title
                    event.location = location

                    // 开始时间(必须传):（startTimeInterval为负）提前一个小时开始
                    let startDate = Date.init(timeInterval: startTimeInterval, since: sinceDate)
                    // 结束时间(必须传):（endTimeInterval为正）提前一分钟结束
                    let endDate = Date.init(timeInterval: endTimeInterval, since: sinceDate)
                    
                    event.startDate = startDate;
                    event.endDate = endDate;
                    event.isAllDay = isAllDay;
                    event.notes = notes
                    
                    if let calendar = calendar {
                        event.calendar = calendar
                    } else {
                        event.calendar = self.store.defaultCalendarForNewEvents
                    }
                    
                    if let alarmOffsets = alarmOffsets {
                        for offset in alarmOffsets {
                            // 添加闹钟结合（开始前多少秒为负，若为正则是开始后多少秒。）
                            let elarm = EKAlarm.init(relativeOffset:TimeInterval(offset))
                            event.addAlarm(elarm)
                        }
                    }
                    
                    do {
                        try self.store.save(event, span: EKSpan.thisEvent)
                        DispatchQueue.main.async {
                            completion(true,nil,true)
                        }
                        print("HHEventKitUtil:添加时间成功")
//                        // 添加成功后需要保存日历关键字
//                        // 保存在沙盒，避免重复添加等其他判断
//                        HHUserDefaultUtil.set(key: HHUserDefaultUtil.kEventIdentifierKey, value: event.eventIdentifier)
                    } catch {
                        // error异常的对象
                        print(error)
                        DispatchQueue.main.async {
                            completion(true,error,false)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - delete
    
    static func deleteReminder(reminder: EKReminder,
                               completion:(@escaping(Bool,Error?,Bool)->())){
        DispatchQueue.global().async {
            self.store.requestAccess(to: EKEntityType.reminder) { (granted, error) in
                if error != nil {
                    print("HHEventKitUtil:删除提醒，，错误了。。。")
                    DispatchQueue.main.async {
                        completion(false,error,false)
                    }
                }
                else if(!granted) {
                    print("HHEventKitUtil:不允许使用事项提醒，没有权限")
                    DispatchQueue.main.async {
                        completion(false,nil,false)
                    }
                }
                else {
                    do {
                        try self.store.remove(reminder, commit: true)
                        DispatchQueue.main.async {
                            completion(true,nil,true)
                        }
                        print("HHEventKitUtil:删除提醒成功")
                    } catch {
                        // error异常的对象
                        print(error)
                        DispatchQueue.main.async {
                            completion(true,error,false)
                        }
                    }
                    
                }
            }
        }
    }
    
    static func deleteEvent(event: EKEvent,
                            completion:(@escaping(Bool,Error?,Bool)->())){
        DispatchQueue.global().async {
        
            self.store.requestAccess(to: EKEntityType.event) { (granted, error) in
                if error != nil {
                    print("HHEventKitUtil:删除 Event 失败，，错误了。。。")
                    DispatchQueue.main.async {
                        completion(false,error,false)
                    }
                }
                else if(!granted) {
                    print("HHEventKitUtil:不允许使用事项提醒，没有权限")
                    DispatchQueue.main.async {
                        completion(false,nil,false)
                    }
                }
                else {
                    do {
                        try self.store.remove(event, span: EKSpan.thisEvent, commit: true)
                        DispatchQueue.main.async {
                            completion(true,nil,true)
                        }
                        print("HHEventKitUtil:删除Event成功")
                    } catch {
                        // error异常的对象
                        print(error)
                        DispatchQueue.main.async {
                            completion(true,error,false)
                        }
                    }
                }
            }
        }
    }
     
    // MARK: - get
    
    static func getEventList(withStart startDate: Date, end endDate: Date,completion:(@escaping(Bool,Error?,[EKEvent]?)->())) {
        
        DispatchQueue.global().async {
            self.store.requestAccess(to: EKEntityType.event) { (granted, error) in
                if error != nil {
                    print("获取 Event 失败，，错误了。。。")
                    DispatchQueue.main.async {
                        completion(false, error, nil)
                    }
                }
                else if(!granted) {
                    print("不允许使用日历，没有权限")
                    DispatchQueue.main.async {
                        completion(false, nil, nil)
                    }
                }
                else {
                        
                    let fetchCalendarEvents = self.store.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
                    let eventList = self.store.events(matching: fetchCalendarEvents)
                    DispatchQueue.main.async {
                        completion(true, nil, eventList)
                    }
                }
            }
        }
    }
    
    static func getEvent(withIdentifier identifier: String,
                         completion:(@escaping(Bool,Error?,EKEvent?)->())) {
        DispatchQueue.global().async {
         
            self.store.requestAccess(to: EKEntityType.event) { (granted, error) in
                if error != nil {
                    print("获取 Event 失败，，错误了。。。")
                    DispatchQueue.main.async {
                        completion(false, error, nil)
                    }
                }
                else if(!granted) {
                    print("不允许使用日历，没有权限")
                    DispatchQueue.main.async {
                        completion(false, nil, nil)
                    }
                }
                else {
                    let event = self.store.event(withIdentifier: identifier)
                    DispatchQueue.main.async {
                        completion(true, nil, event)
                    }
                }
            }
        
        }
    }
    
    static func getReminder(withIdentifier identifier: String,
                            completion:(@escaping(Bool,Error?,EKReminder?)->())) {
        DispatchQueue.global().async {
            let reminderPredicate = self.store.predicateForReminders(in: nil)
            self.store.fetchReminders(matching: reminderPredicate) { (reminders) in
                DispatchQueue.main.async {
                    guard let reminders = reminders else { return  }
                    for reminder in reminders {
                        if reminder.calendarItemIdentifier == identifier {
                            completion(true,nil,reminder)
                            return
                        }
                    }
                }
            }
        }
        
//        DispatchQueue.main.async {
//            self.store.requestAccess(to: EKEntityType.reminder) { (granted, error) in
//                if error != nil {
//                    print("获取失败，，错误了。。。")
//                   completion(false, error, nil)
//                }
//                else if(!granted) {
//                    print("不允许使用事项提醒，没有权限")
//                   completion(false, nil, nil)
//                }
//                else {
//                   let remind:EKReminder = self.store.calendarItem(withIdentifier: identifier) as! EKReminder
//                   completion(true, nil, remind)
//                }
//            }
//        }
    }
     
    // MARK: - Event和提醒事项类型、item 获取
    
    /// 获取日历类型
    /// - Parameter completion: completion
    static func getEventCalendars(completion:(@escaping(Bool,Error?,[EKCalendar]?)->())) {
        DispatchQueue.global().async {
        
             self.store.requestAccess(to: EKEntityType.event) { (granted, error) in
                 if error != nil {
                    print("添加失败，，错误了。。。")
                    DispatchQueue.main.async {
                        completion(false,error,nil)
                    }
                 }
                 else if(!granted) {
                    print("不允许使用事项提醒，没有权限")
                    DispatchQueue.main.async {
                        completion(false,nil,nil)
                    }
                 }
                 else {
                    let eventCalendars = self.store.calendars(for: .event)
                    DispatchQueue.main.async {
                        completion(true,nil,eventCalendars)
                    }
                 }
             }
         }
     
    }
    
    /// 获取提醒事项类型
    /// - Parameter completion: completion
    static func getReminderCalendars(completion:(@escaping(Bool,Error?,[EKCalendar]?)->())) {
        DispatchQueue.global().async { 
            self.store.requestAccess(to: EKEntityType.reminder) { (granted, error) in
                if error != nil {
                    print("添加失败，，错误了。。。")
                    DispatchQueue.main.async {
                        completion(false,error,nil)
                    }
                }
                else if(!granted) {
                    print("不允许使用日历，没有权限")
                    DispatchQueue.main.async {
                        completion(false,nil,nil)
                    }
                }
                else {
                    let reminderCalendars = self.store.calendars(for: .reminder)
                    DispatchQueue.main.async {
                        completion(true,nil,reminderCalendars)
                    }
                }
            }
        
        }
    }
    
    /// 获取所有提醒事项
    /// - Parameter completion: completion
    static func getReminders(completion:(@escaping(Bool,Error?,[EKReminder]?)->())) {
        getReminders(nil, completion: completion)
    }
    
    static func getReminders(_ calendars: [EKCalendar]?,
                             completion:(@escaping(Bool,Error?,[EKReminder]?)->())) {
        DispatchQueue.global().async {
            self.store.requestAccess(to: EKEntityType.reminder) { (granted, error) in
                if error != nil {
                    print("添加失败，，错误了。。。")
                    DispatchQueue.main.async {
                        completion(false,error,nil)
                    }
                }
                else if(!granted) {
                    print("不允许使用日历，没有权限")
                    DispatchQueue.main.async {
                        completion(false,nil,nil)
                    }
                }
                else {
                     let reminderPredicate = self.store.predicateForReminders(in: calendars)
                     self.store.fetchReminders(matching: reminderPredicate) { (reminds) in
                         DispatchQueue.main.async {
                             completion(true,nil,reminds)
                         }
                     }
                }
            }
        }
    }
    
    /// 获取所有 source
    /// - Parameter completion: completion
    static func getAllSources(completion:(@escaping([EKSource])->())){
        DispatchQueue.global().async {
            let sources = self.store.sources;
            DispatchQueue.main.async {
                completion(sources)
            }
        }
    }
    
    /// 根据 source，type 获取日历
    /// - Parameters:
    ///   - source: source
    ///   - entityType: entityType 默认是 .event
    ///   - completion: completion
    static func getCalendars(source:EKSource, entityType: EKEntityType = .event,
                             completion:(@escaping(Bool,Error?,Set<EKCalendar>?)->())) {
        DispatchQueue.global().async {
            self.store.requestAccess(to: entityType) { (granted, error) in
                if error != nil {
                    print("添加失败，，错误了。。。")
                    DispatchQueue.main.async {
                        completion(false,error,nil)
                    }
                }
                else if(!granted) {
                    print("不允许使用日历，没有权限")
                    DispatchQueue.main.async {
                        completion(false,nil,nil)
                    }
                }
                else {
                     let calendars = source.calendars(for: entityType)
                     DispatchQueue.main.async {
                         completion(true,nil,calendars)
                     }
                }
            }
        }
    }

    // MARK: - Tool
    
    static func eventsForDate(events:[EKEvent]?,for date: Date) -> [EKEvent]? {
        return events?.filter { (event) -> Bool in
            return HHDateUtil.isEqualIgnoringTime(date: event.occurrenceDate, otherDate: date)
        }
    }
    
    static func remindersForDate(reminders:[EKReminder]?,for date: Date) -> [EKReminder]? {
        return reminders?.filter { (reminder) -> Bool in
             
            return HHDateUtil.isEqualIgnoringTime(dateComponents: reminder.dueDateComponents,otherDate: date)
        }
    }
    
    
//    {
//        NSArray<EKEvent *> *events = [self.cache objectForKey:date];
//        if ([events isKindOfClass:[NSNull class]]) {
//            return nil;
//        }
//        NSArray<EKEvent *> *filteredEvents = [self.events filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
//            return [evaluatedObject.occurrenceDate isEqualToDate:date];
//        }]];
//        if (filteredEvents.count) {
//            [self.cache setObject:filteredEvents forKey:date];
//        } else {
//            [self.cache setObject:[NSNull null] forKey:date];
//        }
//        return filteredEvents;
//    }

    
}
