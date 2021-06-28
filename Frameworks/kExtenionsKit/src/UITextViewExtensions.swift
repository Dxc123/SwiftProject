//
//  UITextViewExtensions.swift
//  SwiftExtenions
//
//  Created by daixingchuang on 2021/6/25.
//(Swift版本扩展)前缀 sf

import Foundation
import UIKit

public extension UITextView {
    
    /*滚动到顶部**/
    func sf_scrollToTop() {

        let range = NSMakeRange(0, 1)
        scrollRangeToVisible(range)
    }
    /*滚动到底部**/
    func sf_scrollToBottom() {
        let range = NSMakeRange((text as NSString).length - 1, 1)
        scrollRangeToVisible(range)
    }


    
}
