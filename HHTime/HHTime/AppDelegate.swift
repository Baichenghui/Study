//
//  AppDelegate.swift
//  HHTime
//
//  Created by tianxi on 2019/11/1.
//  Copyright © 2019 hh. All rights reserved.
//

/*
 即要用iOS13中新的SceneDelegate，又可以在iOS13一下的设备中完美运行。
 那就添加版本判断，利用@available
 
 SceneDelegate中添加@available(iOS 13, *)
 
 AppDelegate中同样声明window属性
 
 AppDelegate中两个关于Scene的类也添加版本控制，Swift中可以用扩展单独拎出来
 
切记：这种方式，AppDelegate中的有关程序的一下状态的方法，iOS 13设备是不会走的，iOS13一下的是会收到事件回调的。13以上的设备会走SceneDelegate对应的方法
 */

import UIKit 

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        HHNotificationManager.shared.registerAPN()
        
        if #available(iOS 13, *) {
            
        }else {
            window = UIWindow.init()
            window?.frame = UIScreen.main.bounds
            window?.rootViewController = MineVC.init()
            window?.makeKeyAndVisible()
        }
        return true
    }
} 

@available(iOS 13.0, *)
extension AppDelegate {
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
