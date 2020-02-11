//
//  ViewController.swift
//  HHTime
//
//  Created by tianxi on 2019/11/1.
//  Copyright © 2019 hh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let day = HHDateUtil.getDay(date: Date());
//        let weekday = HHDateUtil.weekday(date: Date());
//        let weekOfMonth = HHDateUtil.weekOfMonth(date: Date());
//        let weekOfYear = HHDateUtil.weekOfYear(date: Date());
//
//        print("day:",day)
//        print("weekday:",weekday)
//        print("weekOfMonth:",weekOfMonth)
//        print("weekOfYear:",weekOfYear)
        
//        let year = HHDateUtil.year(date: Date());
//        let month = HHDateUtil.month(date: Date());
//        let day = HHDateUtil.day(date: Date());
//
//        let hour = HHDateUtil.hour(date: Date());
//        let minue = HHDateUtil.minute(date: Date());
//        let second = HHDateUtil.seconds(date: Date());
//
//        print("year:",year)
//        print("month:",month)
//        print("day:",day)
//        print("hour:",hour)
//        print("minue:",minue)
//        print("second:",second)
        
        
//        //5分钟前的date
//        let fiveMAgo = Date(timeIntervalSinceNow: -5 * 60)
//        let fiveMLater = Date(timeIntervalSinceNow: 5 * 60)
        
//       let scheduleOfDay = HHDateUtil.scheduleOfDay(Date())
//       let scheduleOfMonth = HHDateUtil.scheduleOfMonth(Date())
//       let scheduleOfYear = HHDateUtil.scheduleOfYear(Date())
//              
//       print("scheduleOfDay:",scheduleOfDay)
//       print("scheduleOfMonth:",scheduleOfMonth)
//       print("scheduleOfYear:",scheduleOfYear)
        
        let days1 = HHDateUtil.daysOfAnniversaryMonthly(dateOfDay: 15)
        let days2 = HHDateUtil.daysOfAnniversaryAnnual(date:HHDateUtil.getDateFromYMD(time: "2019-1-29"))
        let days3 = HHDateUtil.daysOfAnniversaryWeekly(weekDay: 7)
        let days4 = HHDateUtil.daysBeforeNewYear()
        
        
        print("daysOfAnniversaryMonthly:",days1)
        print("daysOfAnniversaryAnnual:",days2)
        print("daysOfAnniversaryWeekly:",days3)
        print("daysBeforeNewYear:",days4)
        
        let _ = HHSQLiteManager.shared.getDaysMatterDao().createTable()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          
    }
     
    @IBAction func add(_ sender: Any) {
//        HHSQLiteManager.shared.getCategoryDao().insert(bean: HHCategoryBean.init(0,"生活", 1)) { (success) in}
//        HHSQLiteManager.shared.getCategoryDao().insert(bean: HHCategoryBean.init(0,"工作", 2)) { (success) in}
//        HHSQLiteManager.shared.getCategoryDao().insert(bean: HHCategoryBean.init(0,"纪念日", 3)) { (success) in}
    }
    
    @IBAction func update(_ sender: Any) {
//        HHSQLiteManager.shared.getCategoryDao().update(bean:HHCategoryBean.init(2,"纪念日", 3)) { (success) in}
    }
    
    @IBAction func del(_ sender: Any) {
        HHSQLiteManager.shared.getCategoryDao().delete(id: 1) { (success) in}
    }
    
    @IBAction func query(_ sender: Any) {
//        HHSQLiteManager.shared.getCategoryDao().query(id: 5) { (bean) in
//            print("bean:"+(bean?.name ?? "nil"))
//        }
        
        HHSQLiteManager.shared.getCategoryDao().queryAll { (list) in
            print("list count:"+String(list?.count ?? 0))
        }
    }
    
}

