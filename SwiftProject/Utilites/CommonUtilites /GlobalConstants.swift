//
//  GlobalConstants.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import Foundation
import UIKit


//在swift中的宏定义的意义, 在swift中, 并非是预编译代码替换, 而是设置全局常量, 简单宏, 直接let 加常量名即可, 复杂的宏由于必须保证宏的代码的语句的合法性(C语言就不用担心, 合法不合法都会被替换), 所以使用函数进行实现


// MARK: - 常用宽高

/// 全屏高度，不含状态栏高度
let SCREEN_HEIGHT = UIScreen.main.bounds.height
/// 屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.size.width;



//更简洁的keyWindow
let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
//UIApplication.shared.windows.first(where: { $0.isKeyWindow })
//UIApplication.shared.windows.first { $0.isKeyWindow }

//向后兼容的keyWindow
extension UIWindow {
    static var keyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
//推荐使用这个keyWindow
let kkeyWindow = UIWindow.keyWindow


//适配全面屏iPhone X系列

//底部的安全距离
let kSafeAreaBottomHeight =  UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
//顶部的安全距离
let kSafeAreaTopHeight = (kSafeAreaBottomHeight == 0 ? 0 : 24)
//状态栏高度
let kStatusBarHeight = (kSafeAreaBottomHeight == 0 ? 20 : 44)
//导航栏高度
let kNavBarHeight = (kSafeAreaBottomHeight == 0 ? 64 : 88)
//tabbar高度
let kTabBarHeight = (kSafeAreaBottomHeight + 49)


// MARK: - 适配
let UISCALE =  UIScreen.main.bounds.size.width/375
let kScaleW =  UIScreen.main.bounds.size.width/375
let kScaleH =  UIScreen.main.bounds.size.height/667


// MARK: - 颜色
func RGB(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor
{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}


// MARK: - 随机颜色
func randomColor() -> UIColor {
    let randomRed = CGFloat(arc4random()%255)/255.0
    let randomGreen = CGFloat(arc4random()%255)/255.0
    let randomBlue = CGFloat(arc4random()%255)/255.0
    return UIColor.init(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
}



// MARK: - 根据图片名称获取图片
let kIMAGE: (String) -> UIImage? = {imageName in
    return UIImage(named: imageName);
}

// MARK: - font 字号
func customFont(font :CGFloat) -> UIFont{
//    刘海屏
    guard SCREEN_HEIGHT <= 736 else {
        return UIFont.systemFont(ofSize: font)
    }
    //    5.5
    guard SCREEN_HEIGHT == 736 else {
        return UIFont.systemFont(ofSize: font-2)
    }
    //    4.7
    guard SCREEN_HEIGHT >= 736 else {
        return UIFont.systemFont(ofSize: font-4)
    }
     return UIFont.systemFont(ofSize: font)
}



// MARK: - fram
func x(object : UIView)->CGFloat{
    return object.frame.origin.x
}
func y(object : UIView)->CGFloat{
    return object.frame.origin.y
}
func w(object : UIView)->CGFloat{
    return object.frame.size.width
}
func h(object : UIView)->CGFloat{
    return object.frame.size.height
}


// MARK: - 打印日志
/**
 打印日志
 
 - parameter message: 日志消息内容
 */
func printLog<T>(message: T){
    #if DEBUG
        print(" \(message)");
    #endif
}


//封装的日志输出功能（T表示不指定日志信息参数类型） （文件名、函数名、行号）
func kLog<T>(_ message:T, file:String = #file, function:String = #function,
           line:Int = #line) {
    #if DEBUG
        //获取文件名
        let fileName = (file as NSString).lastPathComponent
        //打印日志内容
        print("\(fileName):\(line) \(function) | \(message)")
    #endif
}

//    MARK:--打印数组中所有元素
func printElementFromArray<T>(a: [T]) {
 for element in a { print(element) }
}


//MARK:--topVC

var topVC: UIViewController? {
    var resultVC: UIViewController?
    
//    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    resultVC = _topVC(kkeyWindow!.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

private  func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}





//MARK:--延时执行
func kDispatchAfter(_ delay: Double, closure:@escaping () -> Void) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

