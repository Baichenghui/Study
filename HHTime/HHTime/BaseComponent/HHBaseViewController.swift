//
//  BaseViewController.swift
//  KeepDiary
//
//  Created by hh on 2018/3/29.
//  Copyright © 2018年 hh. All rights reserved.
//

import UIKit

class HHBaseViewController: UIViewController {
  
    // MARK: - Life Cycle and Initialized
    
    var supportedOrientationMask:UIInterfaceOrientationMask = UIInterfaceOrientationMask.portrait
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        didInitialized()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didInitialized()
    }
    
    private func didInitialized(){
        hidesBottomBarWhenPushed = true
        extendedLayoutIncludesOpaqueBars = true
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge.all//UIRectEdge.init(rawValue: 0)
        if #available(iOS 11, *) {
            //高于 iOS11
        } else {
            //低于 iOS 11
            automaticallyAdjustsScrollViewInsets = false;
        }
        if view.backgroundColor == nil {
            view.backgroundColor = HHTheme.current.mainColor
        } 
        
        initSubViews() 
        bindViewModel()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationItems()
        setToolBarItems()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 屏幕旋转
    
    public override var shouldAutorotate: Bool {
        return false
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return supportedOrientationMask
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    

    // MARK: - SubclassingHooks
    
    ///  添加View到ViewController
    func initSubViews() {
        //sub class orverride
    }
    
    ///  用来绑定V(VC)与VM
    func bindViewModel() {
        //sub class orverride
    }
    
    /// 设置导航栏、分栏
    func setNavigationItems() {
        //sub class orverride
    }
    
    func setToolBarItems() {
        //sub class orverride
    }
}


