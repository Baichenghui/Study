//
//  HHCalendarHeadView.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/30.
//  Copyright © 2019 hh. All rights reserved.
//

import UIKit

class HHCalendarHeadView: UIView {
    
    var names:[String]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ frame: CGRect,_ names:[String]) {
        self.names = names
        super.init(frame: frame)
         
        initSubViews()
    }
    
    func initSubViews() {
        self.backgroundColor = UIColor.orange
      
        let width = self.frame.size.width
        let height = self.frame.size.height
        
        
        for i in 0..<names.count {
            let name = names[i]
            
            let lable = UILabel.init(frame: CGRect.init(x: CGFloat(i) * width, y: 0, width: width, height: height))
            lable.textAlignment = .center
            lable.textColor = UIColor.init(colorString: "0x424242")
            lable.font = UIFont.init(name: "PingFangSC-Regular", size: 11)
            lable.text = name
            self.addSubview(lable)
        }
    }
}
