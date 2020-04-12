//
//  UIViewControllerExtensions.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    //MARK: -显示 （信息）  确定
    func showAlert(_ title: String = "", msg: String?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
 //MARK: -显示（ 错误信息）  确定
    func showAlert(_ title: String = "", error: Error?) {
        if let error = error, view.window != nil {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler: { (_) -> Void in
                
            }))
            present(alert, animated: true, completion: nil)
        }
    }
//MARK: -显示 确定 和取消
    func showAlert(title: String?,
                   msg: String?,
                   cancel: String?, cancelBlock: (() -> Void)? = nil,
                   ok: String = "确定", okBlock: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        if let cancel = cancel {
            alert.addAction(UIAlertAction(title: cancel, style: UIAlertAction.Style.cancel, handler: { (_) in
                cancelBlock?()
            }))
        }
        alert.addAction(UIAlertAction(title: ok, style: UIAlertAction.Style.destructive, handler: { (_) in
            okBlock()
        }))
        present(alert, animated: true, completion: nil)
    }
}
