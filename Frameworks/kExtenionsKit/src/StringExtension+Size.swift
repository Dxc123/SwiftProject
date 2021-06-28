//
//  StringExtension+Size.swift
//  SwiftProject
//
//  Created by daixingchuang on 2021/6/23.
//  Copyright © 2021 Dxc_iOS. All rights reserved.
//(Swift版本扩展)前缀 sf

import Foundation
import UIKit
public extension String{
    /// 计算字符串的尺寸
    func sf_getTextSize(rectSize: CGSize, fontSize: CGFloat) -> CGSize {
        let str: NSString = self as NSString
        let rect = str.boundingRect(with: rectSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)], context: nil)
        return CGSize(width: ceil(rect.width), height: ceil(rect.height))
    }
    /// 根据字符串以及字体->返回文本的尺寸
    func sf_getTextSize(string: String, font: UIFont,size: CGSize) -> CGSize {
        return string.boundingRect(with: size, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).size
    }

    
    /// 根据字符串的字体和限制宽度->返回文本的尺寸
    func sf_getTextSize(font:UIFont,width:CGFloat)-> CGSize{

     let size: CGSize  =   self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options:  NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesDeviceMetrics.rawValue |   NSStringDrawingOptions.usesFontLeading.rawValue |    NSStringDrawingOptions.usesLineFragmentOrigin.rawValue |
         NSStringDrawingOptions.truncatesLastVisibleLine.rawValue
       ), attributes: [NSAttributedString.Key.font:font], context: nil).size;
       return size;

    }
    
    
   
    
}
