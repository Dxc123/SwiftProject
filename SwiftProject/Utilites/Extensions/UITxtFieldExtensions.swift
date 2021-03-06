//
//  UITxtFieldExtensions.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/27.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import Foundation
import UIKit

//MARK: ----------创建方法-----------
extension UITextField {
    /// 输入框
    ///
    /// - Parameters:
    ///   - holdStr: 替代文字
    ///   - holdColor: 替代文字颜色
    ///   - textFont: 字号
    ///   - textColor: 字体颜色
    ///   - isSecure: 密文显示
    ///   - keyBorderType: 键盘样式
    /// - Returns: 输入框
    public class func creatTextField(holdStr: String, holdColor: UIColor = .lightGray, textFont: UIFont, textColor: UIColor = .black, isSecure: Bool = false, keyBorderType: UIKeyboardType = .default) -> UITextField {
        let field = UITextField()
        field.keyboardType = keyBorderType
        field.borderStyle = UITextField.BorderStyle.none
        field.clearButtonMode = UITextField.ViewMode.whileEditing
        
        field.textColor = textColor
        field.tintColor = textColor
        field.placeholder = holdStr
        field.font = textFont
        field.isSecureTextEntry = isSecure
        field.setValue(holdColor, forKeyPath: "_placeholderLabel.textColor")
        return field
    }
}

