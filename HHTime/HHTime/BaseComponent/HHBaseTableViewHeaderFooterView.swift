//
//  HHTableViewHeaderFooterView.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/5.
//  Copyright © 2019 hh. All rights reserved.
//

import UIKit

class HHBaseTableViewHeaderFooterView: UITableViewHeaderFooterView {
 
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        didInitialized()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        didInitialized()
    }
    
    private func didInitialized() {
        initSubViews()
        bindViewModel()
    }
    
    ///  用来绑定V与VM
    func bindViewModel() {
        //sub class orverride
    }
    
    ///  添加View到ViewController
    func initSubViews() {
        //sub class orverride
    }
}
