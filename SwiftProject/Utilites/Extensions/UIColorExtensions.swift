//
//  UIColorExtensions.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import Foundation

extension UIColor {
    public convenience init(r:UInt32 ,g:UInt32 , b:UInt32 , a:CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0,
                  green: CGFloat(g) / 255.0,
                  blue: CGFloat(b) / 255.0,
                  alpha: a)
    }
    
    /**随机色*/
    class var random: UIColor {
        return UIColor(r: arc4random_uniform(256),
                       g: arc4random_uniform(256),
                       b: arc4random_uniform(256))
    }
    
   public func image() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    /**16 进制颜色*/
   public class func  hexString(hexString: String) -> UIColor {
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        if cString.count < 6 { return UIColor.black }
        
        let index = cString.index(cString.endIndex, offsetBy: -6)
        let subString = cString[index...]
        if cString.hasPrefix("0X") { cString = String(subString) }
        if cString.hasPrefix("#") { cString = String(subString) }
        
        if cString.count != 6 { return UIColor.black }
        
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        
//        Scanner(string: rString).scanHexInt32(&r)
//        Scanner(string: gString).scanHexInt32(&g)
//        Scanner(string: bString).scanHexInt32(&b)
        Scanner.init(string: rString).scanHexInt32(&r)
        Scanner.init(string: gString).scanHexInt32(&g)
        Scanner.init(string: bString).scanHexInt32(&b)
        
        return UIColor(r: r, g: g, b: b)
    }
}



extension UIColor{
    /**动态设置暗黑色*/
    /// 动态设置暗黑色
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
        } else {
            return light
        }
    }
}
