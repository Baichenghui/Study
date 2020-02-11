//
//  Theme.swift
//  KeepDiary
//
//  Created by 白成慧&瑞瑞 on 2018/3/29.
//  Copyright © 2018年 白成慧. All rights reserved.
//
import UIKit

enum HHTheme: Int {
    case `default`, dark, graphical

    private enum Keys {
        static let selectedTheme = "SelectedTheme"
    }

    static var current: HHTheme {
        let storedTheme = UserDefaults.standard.integer(forKey: Keys.selectedTheme)
        return HHTheme(rawValue: storedTheme) ?? .default
    }
  
    var mainColor: UIColor {
        switch self {
        case .default:
          return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        case .dark:
          return UIColor(red: 255.0/255.0, green: 115.0/255.0, blue: 50.0/255.0, alpha: 1.0)
        case .graphical:
          return UIColor(red: 10.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 1.0)
        }
    }
  
    var barStyle: UIBarStyle {
        switch self {
        case .default, .graphical:
          return .default
        case .dark:
          return .black
        }
    }

    var navigationBackgroundImage: UIImage? {
        return self == .graphical ? UIImage(named: "navBackground") : nil
    }
  
//  var tabBarBackgroundImage: UIImage? {
//    return self == .graphical ? UIImage(named: "tabBarBackground") : nil
//  }
  
    var backgroundColor: UIColor {
        switch self {
        case .default, .graphical:
            return mainColor
        case .dark:
            return UIColor.black
        }
    }

    var tintColor: UIColor {
        switch self {
        case .default, .graphical:
            return UIColor.white
        case .dark:
            return UIColor.black
        }
    }

    var barTintColor: UIColor {
        switch self {
        case .default, .graphical:
            return mainColor
        case .dark:
            return UIColor.black
        }
    }
    
    var statusBarStyle: UIStatusBarStyle {
        switch self {
        case .default, .graphical:
            return UIStatusBarStyle.default
        case .dark:
            return UIStatusBarStyle.lightContent
        }
    }
    
    var textFieldBackGroundColor: UIColor {
        switch self {
        case .default, .graphical:
            return UIColor.black
        case .dark:
            return UIColor.white
        }
    }
    
    var textFieldPlaceholderColor: UIColor {
        switch self {
        case .default, .graphical:
            return UIColor.white
        case .dark:
            return UIColor(colorString: "0x999999")
        }
    }

    var textFieldTextColor: UIColor {
        switch self {
        case .default, .graphical:
            return UIColor.white
        case .dark:
            return UIColor.black
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .default, .graphical:
          return UIColor.white
        case .dark:
          return UIColor.black
        }
    }

    func apply() {
        UserDefaults.standard.set(rawValue, forKey: Keys.selectedTheme)
        UserDefaults.standard.synchronize()

        UIApplication.shared.delegate?.window??.tintColor = mainColor
        
        UITextField.appearance().tintColor = textFieldTextColor
        
        //系统默认状态栏的字体颜色为黑色，即UIStatusBarStyle=UIStatusBarStyleDefault，
        //同时背景颜色和self.view.backgroundColor颜色一致
        UINavigationBar.appearance().barStyle = barStyle
        UINavigationBar.appearance().setBackgroundImage(navigationBackgroundImage, for: .default)

        let backArrow = UIImage(named: "publish_home_revoke")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)//backArrow
        let backArrowMaskFixed = UIImage(named: "publish_home_revoke")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)//publish_home_revoke//backArrowMaskFixed

        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backArrowMaskFixed
        UINavigationBar.appearance().backIndicatorImage = backArrow

        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().subviews.first?.alpha = 1.0
        UINavigationBar.appearance().tintColor = tintColor
        UINavigationBar.appearance().barTintColor = barTintColor
        UINavigationBar.appearance().clipsToBounds = true;
        UINavigationBar.appearance().shadowImage = UIImage.init()
        UINavigationBar.appearance().setBackgroundImage(UIImage.init(), for: UIBarMetrics.default)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:textColor];
         
        UISwitch.appearance().onTintColor = mainColor.withAlphaComponent(0.3)
        UISwitch.appearance().thumbTintColor = mainColor

        UITableViewCell.appearance().backgroundColor = backgroundColor
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).textColor = textColor
    }
}
