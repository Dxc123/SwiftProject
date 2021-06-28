//
//  UITextFieldExtensions.swift
//  SwiftExtenions
//
//  Created by daixingchuang on 2021/6/25.
//(Swift版本扩展)前缀 sf

import Foundation
import UIKit

public extension UITextField{
    
    /**设置文本框的左边间隔*/
    func sf_setPaddingLeft(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
    //**设置文本框的左边间隔的图片*/
    func sf_setPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        leftView = imageView
        leftView?.frame.size = CGSize(width: image.size.width + padding, height: image.size.height)
        leftViewMode = .always
    }
    /**设置文本框的右边间隔*/
    func sf_setPaddingRight(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        rightView = paddingView
        rightViewMode = .always
    }
    //**设置文本框的左边间隔的图片*/
    func sf_setPaddingRightIcon(_ image: UIImage, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        rightView = imageView
        rightView?.frame.size = CGSize(width: image.size.width + padding, height: image.size.height)
        rightViewMode = .always
    }
}
