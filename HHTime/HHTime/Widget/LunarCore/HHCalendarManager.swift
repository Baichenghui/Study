//
//  HHcalendarManager.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/23.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation
import EventKit

class HHCalendarManager: NSObject {
    /// 单例
    internal static let shared = HHCalendarManager.init()

    /// 阻止其他对象使用这个类的默认的'()'初始化方法
    private override init() {
        super.init()
       
    }
    
    func loadCalendarData(startDate:Date,
                          endDate:Date,
                          _ completion:(@escaping(Bool,Error?,[HHCalendarData]?)->())) {
        //group中控制依赖管理，1，2，3三个异步操作需要完成之后才能刷新UI，enter 和 leave控制group中所有操作是否完成。
        let queue = DispatchQueue(label: "com.hh.time.HHCalendarManager", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)//并行队列
        let group = DispatchGroup.init()
        queue.async(group: group, execute: DispatchWorkItem.init(block: {

            var eventList:[EKEvent]?
            var reminderList:[EKReminder]?
            var allGranted:Bool = true
            var allError:Error?
            
            // getEventList
            group.enter()
            queue.async { 
                HHEventKitUtil.getEventList(withStart: startDate, end: endDate) { (granted, error, events) in
                    allGranted = granted
                    if granted {
                        eventList = events
                    }
                    else {
                        allError = error
                    }
                    group.leave()
                }
            }
        
            // getReminders
            group.enter()
            queue.async {
                HHEventKitUtil.getReminders { (granted, error, reminders) in
                    allGranted = granted && allGranted
                    if granted {
                        reminderList = reminders
                    }
                    else {
                        allError = error
                    }
                    group.leave()
                }
            }
         
            group.notify(queue: queue, execute: {
                var eventDataList:[HHCalendarData] = []
                var reminderDataList:[HHCalendarData] = []
                
                if let eventList = eventList {
                    for event in eventList {
                        let eventData = HHCalendarData(sourceType: .HHSourceTypeEvent, title: event.title, identifier: event.eventIdentifier, dateComponents: HHDateUtil.convertDateComponents(event.occurrenceDate))
                        eventDataList.append(eventData)
                    }
                }
                
                if let reminderList = reminderList {
                    for reminder in reminderList {
                        if let dueDateComponents = reminder.dueDateComponents {
                            let reminderData = HHCalendarData(sourceType: .HHSourceTypeReminder, title: reminder.title, identifier: reminder.calendarItemExternalIdentifier, dateComponents: dueDateComponents)
                            reminderDataList.append(reminderData)
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    print("刷新UI")
                    if allGranted {
                        completion(true,nil,eventDataList + reminderDataList)
                    }
                    else {
                        completion(false,allError,nil)
                    }
                }
            })
        }))
    }
    
    func loadCalendarData(_ year:Int,
                          _ month:Int,
                          _ completion:(@escaping(Bool,Error?,[HHCalendarData]?)->())) {
        
        let daysOfMonth = HHDateUtil.getSolarMonthDays(year: year, month: month - 1)
        
            //group中控制依赖管理，1，2，3三个异步操作需要完成之后才能刷新UI，enter 和 leave控制group中所有操作是否完成。
            let queue = DispatchQueue(label: "com.hh.time.HHCalendarManager", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)//并行队列
            let group = DispatchGroup.init()
            queue.async(group: group, execute: DispatchWorkItem.init(block: {

                var eventList:[EKEvent]?
                var reminderList:[EKReminder]?
                var allGranted:Bool = true
                var allError:Error?
                
                // getEventList
                group.enter()
                queue.async {
                    let startDate = HHDateUtil.getDateFromYMD(time: "\(year)-" + String.init(format: "%02d", month) + "-01")
                    let endDate = HHDateUtil.getDateFromYMD(time: "\(year)-" + String.init(format: "%02d", month) + "-" + String.init(format: "%02d", daysOfMonth))
                    HHEventKitUtil.getEventList(withStart: startDate, end: endDate) { (granted, error, events) in
                        allGranted = granted
                        if granted {
                            eventList = events
                        }
                        else {
                            allError = error
                        }
                        group.leave()
                    }
                }
            
                // getReminders
                group.enter()
                queue.async {
                    HHEventKitUtil.getReminders { (granted, error, reminders) in
                        allGranted = granted && allGranted
                        if granted {
                            reminderList = reminders
                        }
                        else {
                            allError = error
                        }
                        group.leave()
                    }
                }
                 
                group.notify(queue: queue, execute: {
                    var eventDataList:[HHCalendarData] = []
                    var reminderDataList:[HHCalendarData] = []
                    
                    if let eventList = eventList {
                        for event in eventList {
                            let eventData = HHCalendarData(sourceType: .HHSourceTypeEvent, title: event.title, identifier: event.eventIdentifier, dateComponents: HHDateUtil.convertDateComponents(event.occurrenceDate))
                            eventDataList.append(eventData)
                        }
                    }
                    
                    if let reminderList = reminderList {
                        for reminder in reminderList {
                            if let dueDateComponents = reminder.dueDateComponents {
                                let reminderData = HHCalendarData(sourceType: .HHSourceTypeReminder, title: reminder.title, identifier: reminder.calendarItemExternalIdentifier, dateComponents: dueDateComponents)
                                reminderDataList.append(reminderData)
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        print("刷新UI")
                        if allGranted {
                            completion(true,nil,eventDataList + reminderDataList)
                        }
                        else {
                            completion(false,allError,nil)
                        }
                    }
                })
            }))
        }
    
    // MARK: - Tool
    
    func calendarDatasForDate(datas:[HHCalendarData]?,for date: Date) -> [HHCalendarData]? {
        return datas?.filter { (data) -> Bool in
             
            return HHDateUtil.isEqualIgnoringTime(dateComponents: data.dateComponents,otherDate: date)
        }
    }
    
    func calendarDatasForDate(datas:[HHCalendarData]?,_ year: Int,_ month: Int,_ day: Int) -> [HHCalendarData]? {
        return datas?.filter { (data) -> Bool in
            return HHDateUtil.isEqualIgnoringTime(year: year, month: month, day: day, otherDateComponents: data.dateComponents!)
        }
    }
}
