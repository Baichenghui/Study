//
//  HabitTrainingVC.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/2.
//  Copyright © 2019 hh. All rights reserved.
//

import UIKit

class HabitTrainingVC: HHBaseViewController {
 
    lazy var style: KDCalendarAppearStyle = {
        var style = KDCalendarAppearStyle.init()
        style.headerViewDateFont = UIFont.init(name: "Courier-BoldOblique", size: 17)
        style.headerViewDateColor = UIColor(colorString: "0xFF99CC")
        style.headerViewWeekFont = UIFont.init(name: "Courier-BoldOblique", size: 12)
        style.headerViewWeekColor = UIColor(colorString: "0x9933FF")
        style.dateDescUnselectColor = UIColor(colorString: "0x9933FF")
        return style
    }()
    
    lazy var calendarView: KDCalendar = {
        let calendar = KDCalendar(style: self.style, frame: CGRect.zero)
        calendar.delegate = self
        calendar.layer.cornerRadius = 20.0;
        calendar.layer.masksToBounds = true;
        return calendar
    }()
     
    lazy var calendarDateArray: Array<Dictionary<String, Any>> = {
        var array = Array<Dictionary<String, Any>>.init()
        for i in 0..<12 {
            let dict = HHLuanarCore.hh_calendar(2019, i + 1)
            array.append(dict!)
             
//            let dict = hh_calendar(2019, Int32(i + 1))
//            array.append(dict as! Dictionary<String, Any>)
            
        }
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        calendarView.setMonthData(monthData: calendarDateArray[10])
        
        self.view.addSubview(calendarView)
    }
    
    override func initSubViews() {
        super.initSubViews()
        
//        self.calendarView.frame = CGRect.init(x: 0, y: 100, width: self.view.bounds.size.width, height: 300)
    }

}
 
extension HabitTrainingVC: KDCalendarDelegate {
    func calendar(_ calendar: KDCalendar, didDate date: Date) {
         
    }
    
    func calendar(_ calendar: KDCalendar, contentHeight height: CGFloat) {
        let sWidth = self.view.bounds.size.width
        let sHeight = self.view.bounds.size.height
        
        calendarView.frame = CGRect(x: 0, y: (sHeight - height) * 0.5, width: sWidth, height: height)
    }
}
