//
//  HHBaseTableViewCell.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/5.
//  Copyright © 2019 hh. All rights reserved.
//

import UIKit

class HHBaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        didInitialized()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        didInitialized()
    }
    
    private func didInitialized() {
        self.selectionStyle = .none
        
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
