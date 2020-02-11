//
//  HHCalendarVC.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/19.
//  Copyright © 2019 hh. All rights reserved.
//

import UIKit
import EventKit
import FSCalendar

class HHCalendarVC: HHBaseTableViewController,FSCalendarDataSource, FSCalendarDelegate, UIGestureRecognizerDelegate  {

    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    
    fileprivate lazy var calendar:FSCalendar = {
        let cal = FSCalendar.init(frame: CGRect.init(x: 0, y: 64, width: self.view.bounds.size.width, height: 375))
        cal.delegate = self
        cal.dataSource = self
//        cal.pagingEnabled = false
        cal.register(HHCalendarCell.self, forCellReuseIdentifier: "HHCell")
        return cal
    }()
    
    fileprivate var lunar: Bool = true {
        didSet {
            self.calendar.reloadData()
        }
    }
    
    fileprivate var events:[EKEvent]?
    fileprivate var reminders:[EKReminder]?
    fileprivate var allDatas:[HHCalendarData]?
    
    fileprivate let lunarFormatter = HHLunarFormatter()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        self.calendar.select(Date())
//        
//        self.view.addGestureRecognizer(self.scopeGesture)
//        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
//        self.calendar.scope = .week
//         
//        
////        HHNotificationManager.shared.addLocalNotification(title: "闹钟添加", subtitle: "闹钟测试", body: "闹钟测试", summaryArgument: "测试闹钟") { () -> (UNNotificationTrigger) in
////
////            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)
////            return trigger
////        }
//        
//        let date = HHDateUtil.getDateFromYMD_HMS(time: "2019-11-25 10: 56:10")
//        
////        HHAlarmClockUtil.addWorkDayAlarm(title: "测试工作日闹钟 title", body: "测试工作日闹钟 body", date: date, repeats: true)
//         
////        HHAlarmClockUtil.addTimeIntervalSimpleAlarm(title: "具体时间闹钟 title", body: "具体时间闹钟 body", date: date)
//        
//        HHAlarmClockUtil.addWeekDayAlarm(title: "测试每周几闹钟 title", body: "测试每周几闹钟 body", date: date, repeats: true)//👌
//        HHAlarmClockUtil.addYearAlarm(title: "测试每年闹钟 title", body: "测试每年闹钟 body", date: date, repeats: true)
//        HHAlarmClockUtil.addMonthAlarm(title: "测试每月闹钟 title", body: "测试每月闹钟 body", date: date, repeats: true)//👌
//        HHAlarmClockUtil.addDayAlarm(title: "测试每天闹钟 title", body: "测试每天闹钟 body", date: date, repeats: true)//👌
//        HHAlarmClockUtil.addHourAlarm(title: "测试每小时闹钟 title", body: "测试每小时闹钟 body", date: date, repeats: true)//👌
//        HHAlarmClockUtil.addMinuteAlarm(title: "测试每分钟的闹钟 title", body: "测试每分钟的闹钟 body", date: date, repeats: true)//👌
//        
//        
//        let lunarCalendar = hh_calendar(2019, 11)
//        
////        print("\(String(describing: lunarCalendar))")
//        
//        
//        let calendarData = hh_solarToLunar(2019,11,25);
//        HHCalendarManager.shared.loadCalendarData(startDate: Date.init(), endDate: Date.init()) { (graned, error, datas) in
//             
//            guard let calendarForData = HHCalendarManager.shared.calendarDatasForDate(datas: datas, for: date) else { return }
//            
//            calendarData?["events"] = calendarForData
//
//            print("\(String(describing: calendarData))")
//        }
        
//        hh_solarToLunarWithCalendarData(2019,11,25, HHCalendarDataBlock())
        
        
//        HHAlarmClockUtil.addAlarm()
         
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         let str1 = hh_solarToLunar(2019,11,28);
         let str2 = HHLuanarCore.hh_solarToLunar(2019,11,28);
         print("str")
        
        let month1 = hh_calendar(2019,11)
        let month2 = HHLuanarCore.hh_calendar(2019,11)
        print("month")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        HHEventKitUtil.getEventList(withStart: dateFormatter.date(from: "2018/11/20")!, end: dateFormatter.date(from: "2022/11/22")!) { (granted, error, events) in
//            self.events = events
//            self.calendar.reloadData()
//        }
//
//        HHEventKitUtil.getReminders { (granted, error, reminders) in
//            self.reminders = reminders
//            self.calendar.reloadData()
//        }
        
        HHCalendarManager.shared.loadCalendarData(startDate: Date.init(), endDate: Date.init()) { (graned, error, datas) in
            self.allDatas = datas
            
            self.calendar.reloadData()
        }
        
    }

    override func initSubViews() {
        super.initSubViews()
        
        self.view.addSubview(self.calendar)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    deinit {
        print("\(#function)")
    }
    
    // MARK:- UIGestureRecognizerDelegate
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
                case .month:
                    return velocity.y < 0
                case .week:
                    return velocity.y > 0
                @unknown default: break
            }
        }
        return shouldBegin
    }
    
    // MARK:- FSCalendarDataSource, FSCalendarDelegate
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendar.frame = CGRect.init(x: 0, y: 100, width: self.view.bounds.size.width, height: bounds.height)
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }

//    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
//        print("\(self.dateFormatter.string(from: calendar.currentPage))")
//    }
//
//    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
//        let cell:HHCalendarCell = calendar.dequeueReusableCell(withIdentifier: "HHCell", for: date, at: position) as! HHCalendarCell
//
//        return cell
//    }
//
//    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
//
//    }
//
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return self.gregorian.isDateInToday(date) ? "今天" : nil
//    }
       
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        guard let calendarForData = HHCalendarManager.shared.calendarDatasForDate(datas: self.allDatas, for: date) else {
            return self.lunarFormatter.string(from: date)
        }

        return calendarForData.first?.title
    }
      
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        guard let calendarForData = HHCalendarManager.shared.calendarDatasForDate(datas: self.allDatas, for: date) else {
            return 0
        }

        return calendarForData.count
    }
}
