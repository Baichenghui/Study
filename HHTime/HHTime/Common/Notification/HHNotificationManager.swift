//
//  HHNotificationManager.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/2.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation
import UserNotifications
import UserNotificationsUI

/// 默认本地通知 id
let HHDefaultNotificationIdentifier = "hh.timer.default.notificationIdentifier"

class HHNotificationManager: NSObject {
    /// 单例
    internal static let shared = HHNotificationManager.init()

    /// 阻止其他对象使用这个类的默认的'()'初始化方法
    private override init() {
        super.init()
        
    }
 
    func registerAPN() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options:
            (UNAuthorizationOptions(rawValue:
                UNAuthorizationOptions.RawValue(
                    UInt8(UNAuthorizationOptions.badge.rawValue)
                        | UInt8(UNAuthorizationOptions.alert.rawValue)
                        | UInt8(UNAuthorizationOptions.sound.rawValue)))),
                                    completionHandler: { (granted, error) in
                                        print("通知权限获取:" + "\(granted ? "成功" : "失败")")
        })
    }
     
    /// 添加本地通知
    /// - Parameters:
    ///   - title: title description
    ///   - subtitle: subtitle description
    ///   - body: body description
    ///   - summaryArgument: summaryArgument description
    ///   - identifier: identifier description
    ///   - trigger: 设置提醒时间，有三种方式可以进行设置
    ///         UNTimeIntervalNotificationTrigger多长时间之后发送推送
    ///         UNCalendarNotificationTrigger根据日历推送
    ///         UNLocationNotificationTrigger根据位置推送
    
    func addLocalNotification(title:String,
                                  subtitle:String,
                                  body:String,
                                  summaryArgument:String,
                                  _ identifier:String,
                                  _ trigger: @escaping(()->(UNNotificationTrigger))) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            let content = UNMutableNotificationContent.init()
             
            content.title = title
            content.subtitle = subtitle
            content.body = body
            
     
            if #available(iOS 12.0, *) {
                content.summaryArgument = summaryArgument
                
//                content.sound = UNNotificationSound.criticalSoundNamed(UNNotificationSoundName.init("chirp.mp3"), withAudioVolume: 1)
                
//                content.sound = UNNotificationSound.criticalSoundNamed(UNNotificationSoundName.init("weakup.caf"), withAudioVolume: 1)
                
//                content.sound = UNNotificationSound.criticalSoundNamed(UNNotificationSoundName.init("weakup.mp3"), withAudioVolume: 1)
                
                content.sound = UNNotificationSound.default
            } else {
                
//                content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "chirp.mp3"))
                
                content.sound = UNNotificationSound.default
            }
            
            content.badge = 1
            
            // 添加通知的标识符，可以用于移除，更新等操作
            let identifier = identifier
            let request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: trigger.self())
            
            center.add(request) { (error) in
                if(error == nil){
                    print("成功添加推送")
                }
            }
        }
    
    func removeLocalNotification(notificationId:String) {
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests { (requests) in
            for request in requests {
                print("存在的ID:\(request.identifier)")
            }
        }
        center.removePendingNotificationRequests(withIdentifiers: [notificationId])
    }
    
    func removeAllLocalNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
    }
    
    func checkUserNotificationEnable() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            if settings.notificationCenterSetting == .enabled {
                print("打开了通知")
            }
            else {
                print("关闭了通知")
            }
        }
        /*
         __block BOOL isOn = NO;
                UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    if (settings.notificationCenterSetting == UNNotificationSettingEnabled) {
                        isOn = YES;
                        NSLog(@"打开了通知");
                    }else {
                        isOn = NO;
                        NSLog(@"关闭了通知");
                       [self showAlertView];
                    }
                }];
         */
    }
    
    /*

     - (void)showAlertView {
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"通知" message:@"未获得通知权限，请前去设置" preferredStyle:UIAlertControllerStyleAlert];
         [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
         [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
              [self goToAppSystemSetting];
         }]];
         [self presentViewController:alert animated:YES completion:nil];
     }

     // 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改
     - (void)goToAppSystemSetting {
         dispatch_async(dispatch_get_main_queue(), ^{
             UIApplication *application = [UIApplication sharedApplication];
             NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
             if ([application canOpenURL:url]) {
                 if (@available(iOS 10.0, *)) {
                     if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                         [application openURL:url options:@{} completionHandler:nil];
                     }
                 }else {
                     [application openURL:url];
                 }
             }
         });
     }
     */
    
}
 
// MARK: UNUserNotificationCenterDelegate

extension HHNotificationManager: UNUserNotificationCenterDelegate {
     
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        
        completionHandler(UNNotificationPresentationOptions(rawValue: UNNotificationPresentationOptions.RawValue(UInt8(UNNotificationPresentationOptions.badge.rawValue) | UInt8(UNNotificationPresentationOptions.alert.rawValue) | UInt8(UNNotificationPresentationOptions.sound.rawValue))))
    }
     
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
