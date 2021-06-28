//
//  UIColor+Palette.swift
//  kDesignKit
//
//  Created by Jake Lin on 20/10/20.
//
// The colors are picked up from https://backpack.github.io/guidelines/colors

import UIKit
//使用 label.textColor = UIColor.designKit.primaryText
public extension UIColor {
    //调用时具有命名空间
    static let designKit = kUIColor.self
    enum kUIColor {
        //主题颜色
        public static let primary: UIColor = dynamicColor(light: UIColor(hex: 0x0770e3), dark: UIColor(hex: 0x6d9feb))
        //主题背景颜色
        public static let background: UIColor = dynamicColor(light: .white, dark: .black)
        //副主题文本颜色
        public static let secondaryBackground: UIColor = dynamicColor(light: UIColor(hex: 0xf1f2f8), dark: UIColor(hex: 0x1D1B20))
        //三级背景颜色
        public static let tertiaryBackground: UIColor = dynamicColor(light: .white, dark: UIColor(hex: 0x2C2C2E))
        //分割线颜色
        public static let line: UIColor = dynamicColor(light: UIColor(hex: 0xcdcdd7), dark: UIColor(hex: 0x48484A))
        //主文本色
        public static let primaryText: UIColor = dynamicColor(light: UIColor(hex: 0x111236), dark: .white)
        //副文本颜色
        public static let secondaryText: UIColor = dynamicColor(light: UIColor(hex: 0x68697f), dark: UIColor(hex: 0x8E8E93))
        //三级文本颜色
        public static let tertiaryText: UIColor = dynamicColor(light: UIColor(hex: 0x8f90a0), dark: UIColor(hex: 0x8E8E93))
        //四级文本颜色
        public static let quaternaryText: UIColor = dynamicColor(light: UIColor(hex: 0xb2b2bf), dark: UIColor(hex: 0x8E8E93))
/**动态设置颜色*/
        public static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
            if #available(iOS 13.0, *) {
                return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
            } else {
                return light
            }
        }
    }
}

public extension UIColor {
    convenience init(hex: Int) {
        let components = (
                R: CGFloat((hex >> 16) & 0xff) / 255,
                G: CGFloat((hex >> 08) & 0xff) / 255,
                B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}
