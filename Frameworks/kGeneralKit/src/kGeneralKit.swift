//
//  kGeneralKit.swift
//  kGeneralKit
//
//  Created by daixingchuang on 2021/6/25.
//

import UIKit
/**全屏高度，不含状态栏高度*/
let kSCREEN_H = UIScreen.main.bounds.height
/**屏幕宽度*/
let kSCREEN_W = UIScreen.main.bounds.size.width;

//更简洁的keyWindow
//fileprivate let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
//UIApplication.shared.windows.first(where: { $0.isKeyWindow })
//UIApplication.shared.windows.first { $0.isKeyWindow }

//向后兼容的keyWindow
public extension UIWindow {
    static var keyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
/**推荐使用这个keyWindow*/
let kkeyWindow = UIWindow.keyWindow

// MARK: - 全面屏iPhone X系列

public func kIsIPhoneX() -> Bool {
    if #available(iOS 11, *) {
       let  bottomSafeInset =  UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
        if (bottomSafeInset == 34.0 || bottomSafeInset == 21.0) {
            return true;
        }
    }
    return false
}

//底部的安全距离
public func kSafeAreaBottomH() -> CGFloat {
    if #available(iOS 11, *) {
        return   UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
    } else {
      return  0
    }
}

//顶部的安全距离
public func kSafeAreaTopH() -> CGFloat {
    if #available(iOS 11, *) {
        return   UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0.0
    } else {
      return  0
    }
}
//状态栏高度
public func kStatusBarH() -> CGFloat {
    if #available(iOS 13, *) {
        return  UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0.0
    } else {
      return  UIApplication.shared.statusBarFrame.size.height
    }
}



//导航栏高度
public let kNavBarH = (kSafeAreaBottomH() == 0 ? 64 : 88)
//tabbar高度
public let kTabBarH = (kSafeAreaBottomH() + 49)


// MARK: - 适配
public let UISCALE =  UIScreen.main.bounds.size.width/375
public let kScaleW =  UIScreen.main.bounds.size.width/375
public let kScaleH =  UIScreen.main.bounds.size.height/667


// MARK: - 颜色
public func kRGB(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}


// MARK: - 随机颜色
public func kRandomColor() -> UIColor {
    let randomRed = CGFloat(arc4random()%255)/255.0
    let randomGreen = CGFloat(arc4random()%255)/255.0
    let randomBlue = CGFloat(arc4random()%255)/255.0
    return UIColor.init(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
}
/**
 动态颜色设置(适配黑暗模式)
 */
public  func kDynamicColor(light: UIColor, dark: UIColor) -> UIColor {
   if #available(iOS 13.0, *) {
       return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
   } else {
       return light
   }
}


/**获取图片*/
public let kIMAGE: (String) -> UIImage? = {imageName in
    return UIImage.init(named: imageName)
}
/**获取原色图片*/
public let kIMG_Original: (String) -> UIImage? = { imageName in
    return UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal)
    
}


/**封装的日志输出功能（T表示不指定日志信息参数类型） （文件名、函数名、行号）*/
public func kLog<T>(_ message:T, file:String = #file, function:String = #function,
           line:Int = #line) {
    #if DEBUG
        //获取文件名
        let fileName = (file as NSString).lastPathComponent
        //打印日志内容
        print("\(fileName):\(line) \(function) | \(message)")
    #endif
}

/** MARK:--打印数组中所有元素*/
public func printArrayElements<T>(a: [T]) {
 for element in a { print(element) }
}


/**MARK:--延时执行*/
public func kDispatchAfter(_ delay: Double, closure:@escaping () -> Void) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
/**主线程*/
public func kDispatch_mainQueue(_ closure:@escaping () -> Void) {
    DispatchQueue.main.async {
        closure()
    }
}
/** 注册通知*/
public func kAddNotiObserver(_ observer: Any,aSelector: Selector,aName: NSNotification.Name?,anObject: Any?){
    NotificationCenter.default.addObserver(observer, selector: aSelector, name: aName, object: anObject)
}

/** 发送通知*/
public func kPostNoti(_ name: NSNotification.Name,_ object: Any?,_ userInfo:[AnyHashable : Any]? = nil){
    NotificationCenter.default.post(name: name, object: object, userInfo: userInfo)
}
/** 移除通知*/
public func kNoti_RemoveObserver(_ observer: Any,_ name: NSNotification.Name,_ object: Any?){
    NotificationCenter.default.removeObserver(observer, name: name, object: object)
    
}

//MARK: -- UserDefaults保存key
public func kUserDefaultsSaveKey(_ value: Any?, key: String){
     UserDefaults.standard.set(value, forKey: key)
     UserDefaults.standard.synchronize()
 }
public func kUserDefaultsSaveBool(_ boolValue: Bool, key: String){
     UserDefaults.standard.set(boolValue, forKey: key)
     UserDefaults.standard.synchronize()
 }

public func kUserDefaultsSaveInteger(_ intValue: Int, key: String){
    UserDefaults.standard.set(intValue, forKey: key)
    UserDefaults.standard.synchronize()
}


//MARK: -- UserDefaults get key
public func kUserDefaultsGetKey(_ key: String) ->Any?{
    return UserDefaults.standard.object(forKey: key)
     
 }
 
public func kUserDefaultsGetBoolKey(_ key: String) ->Bool{
    return UserDefaults.standard.bool(forKey: key)
 }

public func kUserDefaultsGetIntegerKey(_ key: String) ->Int{
   return UserDefaults.standard.integer(forKey: key)
    
}
public func kUserDefaultsGetArray(_ key: String) ->[Any]?{
       return UserDefaults.standard.array(forKey: key)
}

public func kUserDefaultsGetDictionary(_ key: String) ->[String : Any]?{
     return UserDefaults.standard.dictionary(forKey: key)
}
public func kUserDefaultsRemoveAllKey(_ key: String){
     UserDefaults.standard.removeObject(forKey: key)
     UserDefaults.standard.synchronize()
}


//MARK: --  Device设备相关的工具方法
/**生成标识字符串(可作为设备唯一标志，储存钥匙串中)*/
public func kGenerateUUIDStr() -> String {
    let unique = CFUUIDCreate(kCFAllocatorDefault)
    guard let string = CFUUIDCreateString(kCFAllocatorDefault, unique) else { return "iOS-uuid-unknow" }
    return String(string)
}


  /**appName*/
public func kGetAPPName() -> String{
      let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
     return appName!
 }

/**appVersion*/
public func kGetAPPVersion() -> String{
      let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
     return appVersion!
 }

/**appBulidVersion*/
public func kGetAppBulidVersion() -> String{
        let appBulidVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
     return appBulidVersion!
 }
 
     
/**iOS系统版本*/
public func kGetiOSVersion() -> String{
        let appiOSVersion = UIDevice.current.systemVersion
        return appiOSVersion
 }
     
/**设备 udid*/
public func kGetUdid() -> String{
        let appUdid = UIDevice.current.identifierForVendor!.uuidString
        return appUdid
 }
     
     
/**设备名称*/
public func kGetsystemName() -> String{
        let systemName = UIDevice.current.name
        return systemName
 }
     
     
/** 设备型号*/
public func kGetSystemModel() -> String{
        let systemModel = UIDevice.current.model
        return systemModel
 }
     
/**设备区域化型号*/
public func kGetLocalizedModel() -> String{
        let localizedModel = UIDevice.current.localizedModel
        return localizedModel
 }




class kGeneralKit: NSObject {
        /**-- 时间戳—->字符串*/
    public func getDateBytimeStamp(_ timeStamp: Int) -> String {
            //转换为时间
            let timeInterval:TimeInterval = TimeInterval(timeStamp)
            let date = NSDate(timeIntervalSince1970: timeInterval)
             
            //格式化输出
            let dformatter = DateFormatter()
            dformatter.dateFormat = "yyyy-MM-dd"
            let dateStr = dformatter.string(from: date as Date)
            return dateStr
        }
    /**--时间戳—->字符串(需传入格式化样样式如:"yyyy-MM-dd")*/
    public func getDateBytimeStamp(_ timeStamp: Int,formatStr: String) -> String {
            //转换为时间
            let timeInterval:TimeInterval = TimeInterval(timeStamp)
            let date = NSDate(timeIntervalSince1970: timeInterval)
            //格式化输出
            let dformatter = DateFormatter()
            dformatter.dateFormat = formatStr
            let dateStr = dformatter.string(from: date as Date)
            return dateStr
        }
        
 }
