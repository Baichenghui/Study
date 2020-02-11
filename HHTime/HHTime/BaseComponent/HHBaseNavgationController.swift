//
//  BaseNavigationController.swift
//  KeepDiary
//
//  Created by hh on 2018/3/27.
//  Copyright © 2018年 hh. All rights reserved.
//

import UIKit

///// 外观样式
//protocol HHNavigationControllerAppearanceDelegate: NSObjectProtocol {
//    func titleViewTintColor() -> UIColor?
//    func navigationBarBackgroundImage() -> UIImage?
//    func navigationBarShadowImage() -> UIImage?
//    func navigationBarBarTintColor() -> UIColor?
//    func navigationBarStyle() -> UIBarStyle
//    func navigationBarTintColor() -> UIColor?
//    func backBarButtonItemTitleWithPreviousViewController(controller: UIViewController) -> NSString?
//}
//
///// navigationBar 显隐/动画相关的方法
//protocol HHCustomNavigationBarTransitionDelegate: NSObjectProtocol {
//    func preferredNavigationBarHidden() -> Bool
//    func shouldCustomizeNavigationBarTransitionIfHideable() -> Bool
//    func customNavigationBarTransitionKey() -> NSString?
//    func containerViewBackgroundColorWhenTransitioning() -> UIColor?
//}
//
///// push/pop 相关的一些方法
//protocol HHNavigationControllerTransitionDelegate: NSObjectProtocol {
//    func navigationController(_ navigationController: HHBaseNavgationController,
//                              _ gestureRecognizer: UIScreenEdgePanGestureRecognizer?,
//                              _ viewControllerWillDisappear: UIViewController?,
//                              _ viewControllerWillAppear: UIViewController?) -> Void
//    func willPopInNavigationControllerWithAnimated(_ animated: Bool) -> Void
//    func didPopInNavigationControllerWithAnimated(_ animated: Bool) -> Void
//    func viewControllerKeepingAppearWhenSetViewControllersWithAnimated(_ animated: Bool) -> Void
//}
//
//protocol HHNavigationControllerDelegate:UINavigationControllerDelegate,
//                                        HHNavigationControllerAppearanceDelegate,
//                                        HHCustomNavigationBarTransitionDelegate,
//                                        HHNavigationControllerTransitionDelegate {
//
//}

class HHBaseNavgationController: UINavigationController {
    
    // MARK: - LifeCycle
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        if #available(iOS 13, *) {
            didInitialized()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        didInitialized()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didInitialized()
    }
    
    private func didInitialized(){
//        self.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /**  //系统默认状态栏的字体颜色为黑色，即UIStatusBarStyle=UIStatusBarStyleDefault，
         //同时背景颜色和self.view.backgroundColor颜色一致
         */
        self.view.backgroundColor = HHTheme.current.backgroundColor
    }
    
    deinit {
        self.delegate = nil
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if (topViewController != nil) {
            //目的是去掉系统自带返回按钮的文字
        topViewController?.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .done, target: nil, action: nil)
        }

        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return (topViewController?.preferredStatusBarStyle)!
    }
    
    // MARK: - popActopn
    @objc func popAction(sender:UIButton) -> Void {
        self.popViewController(animated: true)
    }
    
}

