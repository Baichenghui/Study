//
//  HHTableView.swift
//  HHTime
//
//  Created by tianxi on 2019/11/5.
//  Copyright © 2019 hh. All rights reserved.
//

import UIKit
  
class HHTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        didInitialized()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didInitialized()
    }
    
    deinit {
        self.delegate = nil
        self.dataSource = nil
    }
    
    private func didInitialized(){
        styledAsTableView()
    }
     
    /// 保证一直存在tableFooterView，以去掉列表内容不满一屏时尾部的空白分割线
    override var tableFooterView: UIView? {
        get {
            return super.tableFooterView
        }
        
        set {
            if newValue == nil {
                super.tableFooterView = UIView.init()
            }
            else {
                super.tableFooterView = newValue
            }
        }
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        // 子类可根据需要重写
        if self.touchesShouldCancel(in: view, tableView: self) {
             return true
        }
        
        // 默认情况下只有当view是非UIControl的时候才会返回yes，这里统一对UIButton也返回yes
        // 原因是UITableView上面把事件延迟去掉了，但是这样如果拖动的时候手指是在UIControl上面的话，就拖动不了了
        if view.isKind(of: UIControl.self) {
            if view.isKind(of: UIButton.self) {
                return true
            }
            else {
                return false
            }
        }
        return true
    }
}

extension HHTableView {
    
    /// 样式
    func styledAsTableView() -> Void {
        self.rowHeight = HHTableViewConfigurations.TableViewCellNormalHeight
        var backgroundColor:UIColor?
        if self.style == .plain {
            backgroundColor = HHTableViewConfigurations.TableViewBackgroundColor
             // 去掉空白的cell
            self.tableFooterView = UIView.init()
        }
        else {
            backgroundColor = HHTableViewConfigurations.TableViewGroupedBackgroundColor
        }
        if backgroundColor != nil {
            self.backgroundColor = backgroundColor
        }
        self.separatorColor = HHTableViewConfigurations.TableViewSeparatorColor
        // 设置一个空的 backgroundView，去掉系统自带的，以使 backgroundColor 生效
        self.backgroundView = UIView.init()
        
        self.sectionIndexColor = HHTableViewConfigurations.TableSectionIndexColor;
        self.sectionIndexTrackingBackgroundColor = HHTableViewConfigurations.TableSectionIndexTrackingBackgroundColor;
        self.sectionIndexBackgroundColor = HHTableViewConfigurations.TableSectionIndexBackgroundColor;
    }
    
    /// 自定义要在<i>func touchesShouldCancel(in view: UIView) -> Bool</i>内的逻辑<br/>
    /// 若delegate不实现这个方法，则默认对所有UIControl返回NO（UIButton除外，它会返回YES），非UIControl返回YES。
    /// - Parameter in: view
    /// - Parameter tableView: tableView
    func touchesShouldCancel(in: UIView, tableView: HHTableView) -> Bool {
        
        return false
    }
}
