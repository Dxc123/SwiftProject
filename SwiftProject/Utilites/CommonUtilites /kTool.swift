//
//  CJKTTool.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/9/17.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import Foundation
class kTool {
   
    
    /**
     动态颜色设置(适配黑暗模式)
     */
    class func setColor(normalColor: UIColor, darkColor: UIColor)  -> UIColor{
        if #available(iOS 13, *) {
                let dyColor = UIColor.init { (traitCollection) -> UIColor in
                    if traitCollection.userInterfaceStyle == .dark {
                        return darkColor;
                    }else{
                        return normalColor;
                    }
                };
            return dyColor;
        
           } else {
               return normalColor;
           }
    }
//MARK:-- 时间戳—->字符串
    func getDateBytimeStamp(_ timeStamp: Int) -> String {
        //转换为时间
        let timeInterval:TimeInterval = TimeInterval(timeStamp)
        let date = NSDate(timeIntervalSince1970: timeInterval)
         
        //格式化输出
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd"
        let dateStr = dformatter.string(from: date as Date)
        return dateStr
    }
// MARK:--时间戳—->字符串(需传入格式化样样式)
    func getDateBytimeStamp(_ timeStamp: Int,formatStr: String) -> String {
        //转换为时间
        let timeInterval:TimeInterval = TimeInterval(timeStamp)
        let date = NSDate(timeIntervalSince1970: timeInterval)
         
        //格式化输出
        let dformatter = DateFormatter()
        dformatter.dateFormat = formatStr
        let dateStr = dformatter.string(from: date as Date)
        return dateStr
    }
    
    
     ///appName
       class func getAPPName() -> String{
        //    let infoDictionary = Bundle.main.infoDictionary
        //    kLog("infoDictionary = \(infoDictionary)")
             let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
            return appName!
        }
        ///appVersion
       class func getAPPVersion() -> String{
             let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
            return appVersion!
        }
        ///appBulidVersion
       class func  getAppBulidVersion() -> String{
               let appBulidVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
            return appBulidVersion!
        }
        
        
        //ios 版本
    //    static let iOSVersion: String = UIDevice.current.systemVersion
       class func  getiOSVersion() -> String{
               let appiOSVersion = UIDevice.current.systemVersion
               return appiOSVersion
        }
        
        //设备 udid
    //    static let identifierNumber = UIDevice.current.identifierForVendor!.uuidString
       class func  getUdid() -> String{
               let appUdid = UIDevice.current.identifierForVendor!.uuidString
               return appUdid
        }
        
        
        //设备名称
    //    static let systemName = UIDevice.current.systemName
       class func  getsystemName() -> String{
               let systemName = UIDevice.current.identifierForVendor!.uuidString
               return systemName
        }
        
        
        // 设备型号
    //    static let model = UIDevice.current.model
       class func  getSystemModel() -> String{
               let systemModel = UIDevice.current.model
               return systemModel
        }
        
        //设备区域化型号
    //    static let localizedModel = UIDevice.current.localizedModel
       class func  getLocalizedModel() -> String{
               let localizedModel = UIDevice.current.localizedModel
               return localizedModel
        }
}
