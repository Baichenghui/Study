//
//  KDCalendarHeaderView.swift
//  KeepDiary
//
//  Created by 白成慧&瑞瑞 on 2018/5/5.
//  Copyright © 2018年 白成慧. All rights reserved.
//

import UIKit

class KDCalendarHeaderView: UIView {

    // MARK : - lazy
    
    private var style: KDCalendarAppearStyle
    
    lazy var topView: UIView = {
        let topView = UIView.init()
        topView.backgroundColor = UIColor(colorString: "0xffffff")
        return topView
    }()
    lazy var dateLable: UILabel = {
        let dateLabel = UILabel.init()
        dateLabel.numberOfLines = 2
        dateLabel.textAlignment = .center
        return dateLabel
    }()
    lazy var bottomView: UIView = {
        let bottomView = UIView.init()
        bottomView.backgroundColor = UIColor.white
        return bottomView
    }()
    lazy var weekdayLabels: [UILabel] = [UILabel]()
    
    // MARK: - Life Cycle and Initialized
    
    init(style: KDCalendarAppearStyle, frame: CGRect) {
        self.style = style
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI() {
        addSubview(topView)
        addSubview(bottomView)
        
        topView.addSubview(dateLable)
        
        let weekDateDays: [String] = self.style.weekDateDays
        for _ in weekDateDays {
            let label = UILabel.init(frame: CGRect.zero)
            label.textAlignment = .center
            bottomView.addSubview(label)
            weekdayLabels.append(label)
        }
        
        setupValidSettingData()
    }
    
    func setupValidSettingData(){
        dateLable.font = style.headerViewDateFont;
        dateLable.textColor = style.headerViewDateColor;
        
        for item: UILabel in weekdayLabels {
            item.font = style.headerViewWeekFont
            item.textColor = style.headerViewWeekColor
        }
        
        for (index, value) in weekdayLabels.enumerated() {
            if index < style.weekDateDays.count {
                value.text = style.weekDateDays[index];
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let selfWidth: CGFloat = self.bounds.size.width
        
        if self.style.isNeedCustomHeihgt! {
            self.topView.frame = CGRect.init(x: 0, y:0, width: selfWidth, height: self.style.headerViewDateHeight!)
            self.bottomView.frame = CGRect.init(x: 0, y: self.topView.frame.maxY, width: selfWidth, height: self.style.headerViewWeekHeight!)
             
            self.dateLable.frame = CGRect.init(x: selfWidth * 0.5 - 32, y: 0, width: 64, height: self.topView.frame.size.height);
            
            let weekdayWidth = self.bottomView.bounds.size.width / CGFloat(self.style.weekDateDays.count)
            let weekdayHeight = self.bottomView.bounds.size.height;
            
            
            for (index, value) in self.weekdayLabels.enumerated() { 
                value.frame = CGRect.init(x: CGFloat(index) * weekdayWidth, y: 0, width: weekdayWidth, height: weekdayHeight)
            }
        } else {
            //计算高度
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Events
    
    //MARK: - Delegate
    
    //MARK: - Public
    
    //MARK: - Private
 
    //MARK: - Setter And Getter
    
    func setDate(date: String) -> Void {
        dateLable.text = date
    }
}
