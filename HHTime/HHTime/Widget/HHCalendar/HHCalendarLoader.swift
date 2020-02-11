//
//  HHCalendarLoader.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/12/1.
//  Copyright © 2019 hh. All rights reserved.
//

import UIKit

internal struct HHCalendarLoader {
    
    private static let gregorianCalendar = Calendar.init(identifier: .gregorian)

    static func loadAdjacentMonthCalendar(_ currentDate: Date,
                                          _ completion:(@escaping(Bool,[Dictionary<String, Any>])->())) {
        var previousComponents = gregorianCalendar.dateComponents([.year,.month,.day], from: currentDate)
        let components = gregorianCalendar.dateComponents([.year,.month,.day], from: currentDate)
        var nextComponents = gregorianCalendar.dateComponents([.year,.month,.day], from: currentDate)
        if (previousComponents.month == 1) {
            previousComponents.month = 12
            previousComponents.year = previousComponents.year! - 1
        } else {
            previousComponents.month = previousComponents.month! - 1
        }
        if (nextComponents.month == 12) {
            nextComponents.month = 1;
            nextComponents.year = nextComponents.year! + 1;
        } else {
            nextComponents.month = nextComponents.month! + 1;
        }
        
        print("c显示日期:currentDate:",HHDateUtil.convertToYMD_HMS(date: currentDate))
        
        //group中控制依赖管理，1，2，3三个异步操作需要完成之后才能刷新UI，enter 和 leave控制group中所有操作是否完成。
        let queue = DispatchQueue(label: "com.hh.time.HHCalendarLoader", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)//并行队列
        let group = DispatchGroup.init()
        
        let semaphore = DispatchSemaphore(value: 1)
        queue.async(group: group, execute: DispatchWorkItem.init(block: {
            var monthList:[Dictionary<String, Any>] = [Dictionary<String, Any>]()
            
            // previous
            group.enter()
            //异步调用返回前，就会一直阻塞在这
            semaphore.wait()
            HHLuanarCore.hh_asyncCalendar(previousComponents.year!, previousComponents.month!) { (success, data) in
                guard let data = data else {
                    return
                }
                monthList.append(data)
                print("previous 1")
                group.leave()
                semaphore.signal()
            }
        
            // current
            group.enter()
            //异步调用返回前，就会一直阻塞在这
            semaphore.wait()
            HHLuanarCore.hh_asyncCalendar(components.year!, components.month!) { (success, data) in
                guard let data = data else {
                    return
                }
                monthList.append(data)
                print("current 2")
                group.leave()
                semaphore.signal()
            }
            
            // next
            group.enter()
            //异步调用返回前，就会一直阻塞在这
            semaphore.wait()
            HHLuanarCore.hh_asyncCalendar(nextComponents.year!, nextComponents.month!) { (success, data) in
                guard let data = data else {
                    return
                }
                monthList.append(data)
                print("next 3")
                group.leave()
                semaphore.signal()
            } 
            
            group.notify(queue: queue, execute: {
                DispatchQueue.main.async {
                    completion(true,monthList)
                }
            })
        }))
    } 
}
