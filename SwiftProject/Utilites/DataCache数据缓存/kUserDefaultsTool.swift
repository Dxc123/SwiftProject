//
//  kUserDefaults.swift
//  AUNewProject
//
//  Created by daixingchuang on 2020/9/24.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//
//https://github.com/bianzhifeng/CZBDataStorge
//UserDefaults封装
import UIKit
import Foundation

/// kUserDefaultsProtocol 协议
public protocol kUserDefaultsProtocol  {
    var uniqueKey: String { get }
}
///限定 为String类型 赋值uniqueKey为命名空间 + value 防止key值重复
public extension kUserDefaultsProtocol where Self: RawRepresentable, Self.RawValue == String {
    var uniqueKey: String {
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        return namespace + "." + "\(rawValue)"
    }
}

/// 重写subscript方法 为kUserDefaults添加下标赋值法
 class kUserDefaultsTool {
    
    private let defaultStand = UserDefaults.standard
    
    public static let standard = kUserDefaultsTool()
    private init() { }
    
    public subscript(key: kUserDefaultsProtocol) -> Any? {
        set {
            defaultStand.set(newValue, forKey: key.uniqueKey)
        }
        get {
            return defaultStand.value(forKey: key.uniqueKey)
        }
    }
}


/**
 使用
  1.首先需要创建一个遵守kUserDefaultsProtocol协议的枚举, 在枚举中定义要存储的值得key. 示例如下所示:

 enum UserDefaultKeys: String, kUserDefaultsProtocol {
   case month
   case day
 }
2. 存值:

 kUserDefaults.standard[UserDefaultKeys.month] = "11月"
 取值: 这里接口返回的是Any类型, 开发者自己转成确定的类型.

 let month = kUserDefaults.standard[UserDefaultKeys.month]
 
 */

