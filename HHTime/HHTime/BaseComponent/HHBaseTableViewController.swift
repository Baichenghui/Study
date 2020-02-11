//
//  BaseTableViewController.swift
//  HHTime
//
//  Created by tianxi on 2019/11/5.
//  Copyright © 2019 hh. All rights reserved.
//

import UIKit

class HHBaseTableViewController: HHBaseViewController {
    
    lazy var tableView: HHTableView = {
        let tableView = HHTableView.init(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    var style:UITableView.Style?
    var hasHideTableHeaderViewInitial = false
    
    // MARK: - init
    
    init(style: UITableView.Style) {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init() {
        self.init(style:.plain)
    }
    
    override convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.didInitialize(.plain)
    }
    
    func didInitialize(_ style: UITableView.Style) {
        self.style = style
        self.hasHideTableHeaderViewInitial = false
    }
    
    // MARK: - Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var backgroundColor:UIColor?
        if self.style == .plain {
            backgroundColor = HHTableViewConfigurations.TableViewBackgroundColor
        }
        else {
            backgroundColor = HHTableViewConfigurations.TableViewGroupedBackgroundColor
        }
        if backgroundColor != nil {
            self.view.backgroundColor = backgroundColor
        }
    }
    
    override func initSubViews() {
        super.initSubViews()
        
        initTableView()
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if tableView.allowsMultipleSelection {
            tableView.hh_clearsSelection()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layoutTableView()
        
        hideTableHeaderViewInitialIfCan(animated: false, force: false)
    }
     
    deinit {
        tableView.delegate = nil
        tableView.dataSource = nil
        
        if #available(iOS 11, *) {
            //高于 iOS11
        } else {
            //低于 iOS 11
            tableView.removeObserver(self, forKeyPath: "contentInset")
        }
    }
    
    // MARK: - observe
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentInset" {
            //TODO
        }
    }
    
    // MARK: - 工具方法
    
    func hideTableHeaderViewInitialIfCan(animated: Bool, force: Bool) {
        if shouldHideTableHeaderViewInitial() && (force || !hasHideTableHeaderViewInitial) {
            tableView.setContentOffset(CGPoint.init(x: tableView.contentOffset.x, y: -tableView.hh_contentInsert().top + (tableView.tableHeaderView?.frame.height ?? 0)), animated: animated)
            hasHideTableHeaderViewInitial = true
        }
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

// MARK: - 工具方法

extension HHBaseTableViewController {
    
    /// 初始化tableView，在initSubViews的时候被自动调用。
    /// 一般情况下，有关tableView的设置属性的代码都应该写在这里。
    func initTableView() {
        if #available(iOS 11, *) {
            //高于 iOS11
        } else {
            //低于 iOS 11
            /**
            *  监听 contentInset 的变化以及时更新 emptyView 的布局，详见 layoutEmptyView 方法的注释
            *  iOS 11 及之后使用 UIScrollViewDelegate 的 scrollViewDidChangeAdjustedContentInset: 来监听
            */
            tableView.addObserver(self, forKeyPath: "contentInset", options: .old, context: nil)
        }
    }
    
    /// 布局 tableView 的方法独立抽取出来，方便子类在需要自定义 tableView.frame 时能重写并且屏蔽掉 super 的代码。如果不独立一个方法而是放在 viewDidLayoutSubviews 里，子类就很难屏蔽 super 里对 tableView.frame 的修改。
    /// 默认的实现是撑满 self.view，如果要自定义，可以写在这里而不调用 super，或者干脆重写这个方法但留空
    func layoutTableView() {
        let shouldChangeTableViewFrame = !self.view.bounds.equalTo(tableView.frame)
        if shouldChangeTableViewFrame {
            
        }
    }
    
    /// 是否需要在第一次进入界面时将tableHeaderView隐藏（通过调整self.tableView.contentOffset实现）
    /// 默认为NO
    func shouldHideTableHeaderViewInitial() -> Bool {
        return false
    }
}

// MARK: - UITableViewDelegate,UITableViewDataSource

extension HHBaseTableViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
}
