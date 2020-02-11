//
//  MemoVC.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/2.
//  Copyright © 2019 hh. All rights reserved.
//

import UIKit
import EventKit

class MemoVC: HHBaseViewController {

    //iOS 添加日历提醒事件
    //https://www.jianshu.com/p/31e36a95d360
    //https://www.jianshu.com/p/4a903233c022
    //https://blog.csdn.net/lovechris00/article/details/78156186#EKCalendar__137
    //https://www.jianshu.com/p/5f3489d162e6  **
    let store = EKEventStore.init()
    
    //所有日历
    lazy var readEventsBtn:UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom);
        btn.frame = CGRect.init(x: 10, y: 50, width: 100, height: 50)
        btn.backgroundColor = UIColor.orange
        btn.setTitle("日历类型", for: .normal)
        btn.addTarget(self, action: Selector(("readEventsAction")), for: .touchUpInside)
        return btn
    }()
    
    //添加日历事件
    lazy var  addEventsBtn:UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom);
        btn.frame = CGRect.init(x: 120, y: 50, width: 100, height: 50)
        btn.backgroundColor = UIColor.orange
        btn.setTitle("add日历Event", for: .normal)
        btn.addTarget(self, action: Selector(("addEventsAction")), for: .touchUpInside)
        return btn
    }()
    
    //提醒事项：类型
    lazy var readRemindsBtn:UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom);
        btn.frame = CGRect.init(x: 10, y: 120, width: 100, height: 50)
        btn.backgroundColor = UIColor.orange
        btn.setTitle("提醒事项类型", for: .normal)
        btn.addTarget(self, action: Selector(("readRemindsAction")), for: .touchUpInside)
        return btn
    }()
    
    
    //添加提醒事项
    lazy var addRemindsBtn:UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom);
        btn.frame = CGRect.init(x: 120, y: 120, width: 100, height: 50)
        btn.backgroundColor = UIColor.orange
        btn.setTitle("添加提醒事项", for: .normal)
        btn.addTarget(self, action: Selector(("addRemindsAction")), for: .touchUpInside)
        return btn
    }()
    
    //所有提醒事项
    lazy var readAllRemindsBtn:UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom);
        btn.frame = CGRect.init(x: 10, y: 190, width: 100, height: 50)
        btn.backgroundColor = UIColor.orange
        btn.setTitle("所有提醒事项", for: .normal)
        btn.addTarget(self, action: Selector(("readAllRemindsAction")), for: .touchUpInside)
        return btn
    }()
     
    //添加日历
    lazy var addCalendarBtn:UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom);
        btn.frame = CGRect.init(x: 10, y: 330, width: 100, height: 50)
        btn.backgroundColor = UIColor.orange
        btn.setTitle("add 日历", for: .normal)
        btn.addTarget(self, action: Selector(("addCalendarAction")), for: .touchUpInside)
        return btn
    }()
    
    
    //添加本地推送
    lazy var addLocalPushBtn:UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom);
        btn.frame = CGRect.init(x: 10, y: 400, width: 100, height: 50)
        btn.backgroundColor = UIColor.orange
        btn.setTitle("add  推送", for: .normal)
        btn.addTarget(self, action: Selector(("addLocalPushAction")), for: .touchUpInside)
        return btn
    }()
    
    
    //移除本地推送
    lazy var removeLocalPushBtn:UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom);
        btn.frame = CGRect.init(x: 120, y: 400, width: 100, height: 50)
        btn.backgroundColor = UIColor.orange
        btn.setTitle("remove  推送", for: .normal)
        btn.addTarget(self, action: Selector(("removeLocalPushAction")), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var readAllSourcesBtn:UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom);
        btn.frame = CGRect.init(x: 10, y: 260, width: 100, height: 50)
        btn.backgroundColor = UIColor.orange
        btn.setTitle("所有Sources", for: .normal)
        btn.addTarget(self, action: Selector(("readAllSourcesAction")), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var addDiaryBtn:UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom);
        btn.frame = CGRect.init(x: 120, y: 330, width: 100, height: 50)
        btn.backgroundColor = UIColor.orange
        btn.setTitle("添加一条笔记", for: .normal)
        btn.addTarget(self, action: Selector(("addDiaryAction")), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var readDiaryBtn:UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom);
        btn.frame = CGRect.init(x: 120, y: 260, width: 100, height: 50)
        btn.backgroundColor = UIColor.orange
        btn.setTitle("读取一条笔记", for: .normal)
        btn.addTarget(self, action: Selector(("readDiaryAction")), for: .touchUpInside)
        return btn
    }()
    
    lazy var corverView:UIView = {
        let view = UIView.init(frame: CGRect.init(x: 60, y: 300, width: 100, height: 100))
        let v1 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        v1.backgroundColor = UIColor.orange
        view.addSubview(v1)
        
        let btn1 = UIButton.init(type: .contactAdd)
        view.addSubview(btn1)
        
        view.backgroundColor = UIColor.blue
        view.layer.cornerRadius = 50
        
        return view
    }()
    
    
    lazy var corverLable:UILabel = {
        let view = UILabel.init(frame: CGRect.init(x: 200, y: 300, width: 100, height: 100))
//        let v1 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
//        v1.backgroundColor = UIColor.orange
//        view.addSubview(v1)
        
        view.layer.backgroundColor = UIColor.blue.cgColor
        view.layer.cornerRadius = 50
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.addSubview(self.addEventsBtn)
        self.view.addSubview(self.readEventsBtn)
        
        self.view.addSubview(self.readRemindsBtn)
        self.view.addSubview(self.addRemindsBtn)
        
        self.view.addSubview(self.readAllRemindsBtn)
        self.view.addSubview(self.addCalendarBtn)
        self.view.addSubview(self.readAllSourcesBtn)
        self.view.addSubview(self.addDiaryBtn)
        self.view.addSubview(self.readDiaryBtn)
         
         self.view.addSubview(self.addLocalPushBtn)
         self.view.addSubview(self.removeLocalPushBtn)
        
        self.view.addSubview(self.corverView)
        self.view.addSubview(self.corverLable)
    }
    
    override func initSubViews() {
        super.initSubViews()
        
        self.view.backgroundColor = UIColor.white
    }
    
    @objc func addLocalPushAction(){
//        HHNotificationManager.shared.addLocalNotification(title: "测试 title", subtitle: "测试 subTitle", body: "测试 body", summaryArgument:"测试 summaryArgument")
        
        HHNotificationManager.shared.addLocalNotification(title: "闹钟添加", subtitle: "闹钟测试", body: "闹钟测试", summaryArgument: "测试闹钟","...") { () -> (UNNotificationTrigger) in
            
            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)
            return trigger
        }
    }
    
    @objc func removeLocalPushAction(){
//        HHNotificationManager.shared.removeAllLocalNotification()
        HHNotificationManager.shared.removeLocalNotification(notificationId: HHDefaultNotificationIdentifier)
    }
    
    @objc func addDiaryAction(){
//        HHSQLiteManager.shared.getDiaryDao().insert(bean: HHDiaryBean.init(0, "测试日记", "测试日记内容", HHDateUtil.convertToYMD(date: Date()), "ff0000")) { (success) in
//            if success {
//                print("添加成功")
//            }
//        }
    }
    
    @objc func readDiaryAction(){
        HHSQLiteManager.shared.getDiaryDao().queryAll { (list) in
            guard list != nil else {
                return
            }
            
            print("list")
        }
    }
    
    @objc func addCalendarAction(){
//        HHEventKitUtil.saveEventCalendar(title: "测试日历添加XX", identifier: nil,color:UIColor.cyan) { (granted, error, success) in
//
//        }
        
        HHEventKitUtil.saveReminderCalendar(title: "测试提醒日历添加😆", identifier: nil,color:UIColor.orange) { (granted, error, success) in
            
        }
    }
    
    @objc func addEventsAction(){
        HHEventKitUtil.saveEvent(title: "测试addEventsAction", location: "上海宝山", notes: "哈哈哈😆", sinceDate: Date(), startTimeInterval: -60, endTimeInterval: 600, isAllDay: false, alarmOffsets: [60,70,90], calendar: nil){ (granted, error, success) in
            
        }
    }
    
    @objc func readAllSourcesAction(){
        HHEventKitUtil.getAllSources { (sources) in
            for source in sources {
                print("source title:"+source.title + " ")
                
                HHEventKitUtil.getCalendars(source: source, entityType: .event) { (granted, error, calendars) in
                    guard let calendars = calendars else { return  }
                    for calendar in calendars {
                        print("event title:"+calendar.title + " ")
                    }
                }
                
//                HHEventKitUtil.getCalendars(source: source, entityType: .event) { (calendars) in
//                    for calendar in calendars {
//                        print("event title:"+calendar.title + " ")
//                    }
//                }
                
//                HHEventKitUtil.getCalendars(source: source, entityType: .reminder) { (calendars) in
//                    for calendar in calendars {
//                        print("reminder title:"+calendar.title + " ")
//                    }
//                }
            }
        }
    }
    
    @objc func addRemindsAction(){
        
        HHEventKitUtil.saveReminder(title: "测试添加提醒", location: "西朱新村", notes: "啊说说大数据", date: HHDateUtil.getDateFromYMD(time: "2019-12-14"), priority: 1, recurrenceRule: nil, alarmOffsets: [60,600], calendar: nil) { (granted, error, success) in
            
            if (success){
//                HHSQLiteManager.shared.getMemoDao().insert(bean: HHMemoBean.init(0, <#T##identifier: String##String#>, kMemoTypeReminder)) { (y) in
//
//                }
            }
        }
        
        
    }
     
    @objc func readEventsAction() {
        HHEventKitUtil.getEventCalendars { (granted, error, eventResults) in
            guard let eventResults = eventResults else { return  }
            for calendar in eventResults {
                print("event title:"+calendar.title + " ")
                print("event source title:"+calendar.source.title + " ")
                print("event source type:"+String(calendar.source.sourceType.rawValue))
            }
        }
    }
    
    @objc func readRemindsAction() {
        HHEventKitUtil.getReminderCalendars { (granted, error, reminderResults) in
            guard let reminderResults = reminderResults else { return  }
            for calendar in reminderResults {
                print("remind title:"+calendar.title + " ")
                
//                HHEventKitUtil.getCalendars(source: calendar.source, entityType: .reminder) { (calendars) in
//                    for calendar in calendars {
//                        print("reminder sub title:"+calendar.title + " ")
//                    }
//                }
            }
        }
    }
     
    @objc func readAllRemindsAction() {
        HHEventKitUtil.getReminders { (granted, error, reminds) in
            guard let reminds = reminds else { return  }
            
            for remind in reminds {
                print("remind type:"+remind.calendar.title )
                print("remind title:"+remind.title )
                print("notes:"+(remind.notes ?? ""))
                print("completionDate:"+(remind.completionDate?.description ?? ""))
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
