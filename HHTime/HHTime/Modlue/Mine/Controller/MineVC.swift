//
//  MineVC.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/2.
//  Copyright © 2019 hh. All rights reserved.
//

import UIKit

class MineVC: HHBaseViewController {
    
    lazy var calendarView:HHCalendarScrollView = {
        let cal = HHCalendarScrollView.init(frame: CGRect.init(x: 10, y: 100, width: self.view.bounds.size.width - 20, height: 400))
        
        return cal
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(calendarView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
