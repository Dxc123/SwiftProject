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
let kBottomSafeAreaHeight =  UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
//顶部的安全距离
let ktopSafeAreaHeight = (kBottomSafeAreaHeight == 0 ? 0 : 24)
//状态栏高度
let kStatusBarHeight = (kBottomSafeAreaHeight == 0 ? 20 : 44)
//导航栏高度
let kNavBarHeight = (kBottomSafeAreaHeight == 0 ? 64 : 88)
//tabbar高度
let kTabBarHeight = (kBottomSafeAreaHeight + 49)


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
let IMAGE: (String) -> UIImage? = {imageName in
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
func printLog<T>(message: T)
{
    #if DEBUG
        print(" \(message)");
    #endif
}


//封装的日志输出功能（T表示不指定日志信息参数类型） （文件名、函数名、行号）
func CJKTLog<T>(_ message:T, file:String = #file, function:String = #function,
           line:Int = #line) {
    #if DEBUG
        //获取文件名
        let fileName = (file as NSString).lastPathComponent
        //打印日志内容
        print("\(fileName):\(line) \(function) | \(message)")
    #endif
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


extension UIButton {

    //MARK: -定义button 内Image相对label的位置
    enum ButtonImagePosition {
            case top          //图片在上，文字在下，垂直居中对齐
            case bottom       //图片在下，文字在上，垂直居中对齐
            case left         //图片在左，文字在右，水平居中对齐
            case right        //图片在右，文字在左，水平居中对齐
    }
    /// - Description 设置Button图片的位置
    /// - Parameters:
    ///   - style: 图片位置
    ///   - spacing: 按钮图片与文字之间的间隔
    func imagePosition(style: ButtonImagePosition, spacing: CGFloat) {
        //得到imageView和titleLabel的宽高
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        
        var labelWidth: CGFloat! = 0.0
        var labelHeight: CGFloat! = 0.0
        
        labelWidth = self.titleLabel?.intrinsicContentSize.width
        labelHeight = self.titleLabel?.intrinsicContentSize.height
        
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .top:
            //上 左 下 右
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-spacing/2, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-spacing/2, right: 0)
            break;
            
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
            break;
            
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-spacing/2, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-spacing/2, left: -imageWidth!, bottom: 0, right: 0)
            break;
            
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+spacing/2, bottom: 0, right: -labelWidth-spacing/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-spacing/2, bottom: 0, right: imageWidth!+spacing/2)
            break;
            
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        
    }
}


typealias CCornersRadius = (topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat)

extension UIView {
    // 自定义圆角

    //创建Path
    func createPath(bounds:CGRect, cornersRadius:CCornersRadius) -> CGPath {
            let minX = bounds.minX
            let minY = bounds.minY
            let maxX = bounds.maxX
            let maxY = bounds.maxY

            let topLeftCenterX = minX + cornersRadius.topLeft
            let topLeftCenterY = minY + cornersRadius.topLeft
            let topRightCenterX = maxX - cornersRadius.topRight
            let topRightCenterY = minY + cornersRadius.topRight
            let bottomLeftCenterX = minX + cornersRadius.bottomLeft
            let bottomLeftCenterY = maxY - cornersRadius.bottomLeft
            let bottomRightCenterX = maxX - cornersRadius.bottomRight
            let bottomRightCenterY = maxY - cornersRadius.bottomRight
            
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: topLeftCenterX, y: topLeftCenterY), radius: cornersRadius.topLeft, startAngle: CGFloat(Double.pi), endAngle: CGFloat(3 * Double.pi / 2.0), clockwise: false)
            path.addArc(center: CGPoint(x: topRightCenterX, y: topRightCenterY), radius: cornersRadius.topRight, startAngle: CGFloat(3 * Double.pi / 2.0), endAngle: 0, clockwise: false)
            path.addArc(center: CGPoint(x: bottomRightCenterX, y: bottomRightCenterY), radius: cornersRadius.bottomRight, startAngle: 0, endAngle: CGFloat(Double.pi / 2.0), clockwise: false)
            path.addArc(center: CGPoint(x: bottomLeftCenterX, y: bottomLeftCenterY), radius: cornersRadius.bottomLeft, startAngle: CGFloat(Double.pi / 2.0), endAngle: CGFloat(Double.pi), clockwise: false)
            path.closeSubpath()
            
            return path
    }
}

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


//MARK: Kingfisher
//setImage(with: URL(string: urlString ?? ""),
//placeholder: placeholder,
//options:[.transition(.fade(0.5))])


     
      
///appName
func getAPPName() -> String{
//    let infoDictionary = Bundle.main.infoDictionary
//    CJKTLog("infoDictionary = \(infoDictionary)")
     let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
    return appName!
}
///appVersion
func getAPPVersion() -> String{
     let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    return appVersion!
}
///appBulidVersion
func  getAppBulidVersion() -> String{
       let appBulidVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    return appBulidVersion!
}
