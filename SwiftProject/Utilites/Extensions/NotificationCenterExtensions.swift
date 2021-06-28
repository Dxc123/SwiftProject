//
//  NotificationCenterExtensions.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/28.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import Foundation
import UserNotifications

extension NotificationCenter{
     /// 扩展类属性
    public static var ys: NotificationCenterTool.Type{
      return NotificationCenterTool.self
    }
    
}
// MARK: - 发送通知
public final class NotificationCenterTool{
    
    /// 发送通知
    public final class func post(notification: Notification){
        NotificationCenter.default.post(notification)
    }
    
    /// 发送通知
    public final class func post(notiName: String, object: Any? = nil){
        NotificationCenter.default.post(name: NSNotification.Name(notiName), object: object)
    }
    
    /// 发送通知
    public final class func post(notiName: String, object: Any?, userInfo: [AnyHashable: Any]?){
        NotificationCenter.default.post(name: NSNotification.Name(notiName), object: object, userInfo: userInfo)
    }
}

// MARK: - 监听自定义通知
extension NotificationCenterTool{
    
    /// 监听自定义通知
    public static func add_custom(_ observer: Any, _ selector: Selector, notiName: String, object: Any? = nil){
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(notiName), object: object)
    }
    
    /// 监听自定义通知
    public static func add_custom(_ observer: Any, _ selector: Selector, notiNames: [String], object: Any? = nil){
        for item in notiNames{
            NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(item), object: object)
        }
    }
}

// MARK: - 监听系统通知
extension NotificationCenterTool{
    
    /// 监听系统通知
    public static func add_system(_ observer: Any, _ selector: Selector, notiName: NSNotification.Name, object: Any? = nil){
        NotificationCenter.default.addObserver(observer, selector: selector, name: notiName, object: object)
    }
    
    /// 监听系统通知
    public static func add_system(_ observer: Any, _ selector: Selector, notiNames: [NSNotification.Name], object: Any? = nil){
        for item in notiNames{
            NotificationCenter.default.addObserver(observer, selector: selector, name: item, object: object)
        }
    }
}
