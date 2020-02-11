//
//  KDCalendarDateCell.swift
//  KeepDiary
//
//  Created by 白成慧&瑞瑞 on 2018/5/5.
//  Copyright © 2018年 白成慧. All rights reserved.
//

import UIKit

class KDCalendarDateCell: UICollectionViewCell {
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel.init()
//        dateLabel.layer.cornerRadius = 17
//        dateLabel.layer.masksToBounds = true
        dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor(colorString: "0x333333")
        dateLabel.font = UIFont.init(name: "Courier-BoldOblique", size: 15)
        dateLabel.backgroundColor = UIColor.white
        return dateLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(dateLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = bounds.size.width
        let height = bounds.size.height
        
//        dateLabel.layer.cornerRadius = width * 0.5
        dateLabel.center = CGPoint.init(x: width * 0.5, y: height * 0.5)
        dateLabel.bounds = CGRect.init(x: 0, y: 0, width: width, height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setter And Getter
    
    public func setDateDictionary(dictionary: Dictionary<String, Any>, isCurrentMonth: Bool = true) -> Void {
        if let day = dictionary["day"],
            let month = dictionary["month"],
            let year = dictionary["year"]{
            if isCurrentMonth {
                dateLabel.text = "\(day)"
                
                //今日
                let currentDate = Date.init()
                let today: String = dateConvertString(date: currentDate)
                let dateString: String = String(format: "%d-", (year as! Int)) + String(format: "%.2d-", (month as! Int)) + String(format: "%.2d", (day as! Int))
                let date = stringConvertDate(string: dateString, dateFormat: "yyyy-MM-dd")
                
                //星期几
                let weekDay = getDay(date: date)
                
                //设置日期颜色
                if weekDay == 6 {
                    dateLabel.textColor = UIColor(colorString: "0x3399FF")
                } else if weekDay == 0 {
                    dateLabel.textColor = UIColor(colorString: "0xFF99CC")
                } else {
                    dateLabel.textColor = UIColor(colorString: "0x333333")
                }
                
                //今日背景色
                if today.elementsEqual(dateString) {//今日
                    dateLabel.backgroundColor = UIColor(colorString: "0x9933FF")
                } else {
                    dateLabel.backgroundColor = UIColor.white
                } 
            } else {
                dateLabel.text = ""
                dateLabel.textColor = UIColor(colorString: "0x333333")
                dateLabel.backgroundColor = UIColor.white
            }
        }
    }
}
