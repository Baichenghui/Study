//
//  UITableViewExtensions.swift
//  HHTime
//
//  Created by tianxi on 2019/11/5.
//  Copyright © 2019 hh. All rights reserved.
//

import UIKit
 
protocol TableViewCellFromNib {}
extension TableViewCellFromNib {
    static var identifier: String { return "\(self)ID" }
    static var nib: UINib? { return UINib(nibName: "\(self)", bundle: nil) }
    static func hh_getNibPath() -> String? {
        return Bundle.main.path(forResource: "\(self)", ofType: "nib")
    }
}
extension UITableViewCell : TableViewCellFromNib{}

public extension UITableView {
    
    func hh_clearsSelection() {
        guard let selectedIndexPaths = indexPathsForSelectedRows else { return  }
        for indexPath in selectedIndexPaths {
            deselectRow(at: indexPath, animated: true)
        }
    }
    
    /// 注册 cell 的方法 注意:identifier是传入的 T+ID
    func hh_registerCell<T: UITableViewCell>(cell: T.Type) {
        if T.hh_getNibPath() != nil {
            register(T.nib, forCellReuseIdentifier: T.identifier)
        } else {
            register(cell, forCellReuseIdentifier: T.identifier)
        }
    }
    
    /// 从缓存池池出队已经存在的 cell
    func hh_dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        if T.identifier == UITableViewCell.identifier {
            register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
            return dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath) as! T
        }
        let cell = dequeueReusableCell(withIdentifier: T.identifier) as? T
        if cell == nil {
            hh_registerCell(cell: T.self)
        }
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}
