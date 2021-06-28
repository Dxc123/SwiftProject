//
//  UISearchBarExtension.swift
//  AUNewProject
//
//  Created by daixingchuang on 2020/9/29.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import Foundation

extension UISearchBar {
//    MARK:--  修改SearchBar系统自带的TextField
        public var textField: UITextField {
            
            if #available(iOS 13.0, *) {//iOS 13可以直接访问文本字段：
                return searchTextField
            }

            guard let firstSubview = subviews.first else {
                fatalError("Could not find text field")
            }

            for view in firstSubview.subviews {
                if let textView = view as? UITextField {
                    return textView
                }
            }

           fatalError("Could not find text field")
        }
 
}

