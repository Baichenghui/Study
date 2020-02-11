//
//  HHCalendarCell.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/21.
//  Copyright © 2019 hh. All rights reserved.
//

import UIKit

class HHCalendarCell: UICollectionViewCell {

    static let HHCalendarCellID = "HHCalendarCell"
    
    fileprivate var calendarData:HHCalendarData?
    
    /** 阳历日期label（eg：1、2、3日） */
    fileprivate lazy var solarDateLabel:UILabel = {
        let dateLabel = UILabel.init()
        dateLabel.textAlignment = .left
        dateLabel.textColor = UIColor(colorString: "0x333333")
        dateLabel.font = UIFont.init(name: "PingFangSC-Regular", size: 10)
        dateLabel.backgroundColor = UIColor.white
        return dateLabel
    }()

    /** 农历日期label（eg：初一、初二、初三） */
    fileprivate lazy var lunarDateLabel:UILabel = {
        let dateLabel = UILabel.init()
        dateLabel.textAlignment = .left
        dateLabel.textColor = UIColor(colorString: "0x333333")
        dateLabel.font = UIFont.init(name: "PingFangSC-Regular", size: 8)
        dateLabel.backgroundColor = UIColor.white
        return dateLabel
    }()
    
    /** event  */
    fileprivate lazy var eventLabel:UILabel = {
        let dateLabel = UILabel.init()
        dateLabel.textAlignment = .left
        dateLabel.textColor = UIColor(colorString: "0x333333")
        dateLabel.font = UIFont.init(name: "PingFangSC-Regular", size: 8)
        dateLabel.backgroundColor = UIColor.white
        return dateLabel
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubViews()
        initLayoutSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubViews() {
        self.contentView.addSubview(solarDateLabel)
        self.contentView.addSubview(lunarDateLabel)
        self.contentView.addSubview(eventLabel)
    }
    
    func initLayoutSubViews() {
        let width = bounds.size.width
        let height = bounds.size.height
                 
        solarDateLabel.frame = CGRect.init(x: 0, y: 0, width: width * 0.5, height: height * 0.25)
        eventLabel.frame = CGRect.init(x: width * 0.5, y: 0, width: width * 0.5, height: height * 0.25)
        lunarDateLabel.frame = CGRect.init(x: 0, y: height * 0.25, width: width, height: height * 0.25)
    }
     
    override func layoutSubviews() {
        super.layoutSubviews() 
    }
    
    //MARK: - public
     
    func configDictionary(_ dict:Dictionary<String,Any>) {
        if let day = dict["day"] {
            self.solarDateLabel.text = "\(day)"
        }
        if let lunarDayName = dict["lunarDayName"] {
            self.lunarDateLabel.text = (lunarDayName as! String)
        }
        //customEvent
        if let customEvents = dict["customEvents"] {
            let list = (customEvents as! [HHCalendarData])
            if list.count > 0 {
                self.eventLabel.text = list[0].title
            }
            else {
                self.eventLabel.text = ""
            }
        }
        else {
            self.eventLabel.text = ""
        }
    }
}
