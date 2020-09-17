//
//  CJKTAlertController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/5/13.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import Foundation
import  UIKit

extension UIAlertController {

  ///Set background color of UIAlertController
  public func setBackgroudColor(color: UIColor) {
    if let bgView = self.view.subviews.first,
      let groupView = bgView.subviews.first,
      let contentView = groupView.subviews.first {
      contentView.backgroundColor = color
    }
  }

  ///Set title font and title color
  public func setTitle(font: UIFont?, color: UIColor?) {
    guard let title = self.title else { return }
    let attributeString = NSMutableAttributedString(string: title)//1
    if let titleFont = font {
      attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
        range: NSMakeRange(0, title.utf8.count))
    }
    if let titleColor = color {
      attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
        range: NSMakeRange(0, title.utf8.count))
    }
    self.setValue(attributeString, forKey: "attributedTitle")//4
  }

  ///Set message font and message color
  public func setMessage(font: UIFont?, color: UIColor?) {
    guard let title = self.message else {
      return
    }
    let attributedString = NSMutableAttributedString(string: title)
    if let titleFont = font {
      attributedString.addAttributes([NSAttributedString.Key.font : titleFont], range: NSMakeRange(0, title.utf8.count))
    }
    if let titleColor = color {
      attributedString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor], range: NSMakeRange(0, title.utf8.count))
    }
    self.setValue(attributedString, forKey: "attributedMessage")//4
  }

  ///Set tint color of UIAlertController(除了标题)
  public func setTint(color: UIColor) {
    self.view.tintColor = color
  }
    
    
/*
     
     let alertController = UIAlertController(title: "Alert!!", message: "This is custom alert message", preferredStyle: .alert)
               alertController.setTitle(font: UIFont.boldSystemFont(ofSize: 18), color: UIColor.gray)
               alertController.setMessage(font: UIFont(name: "AvenirNextCondensed-HeavyItalic", size: 18), color: UIColor.red)
               alertController.setBackgroudColor(color: UIColor.white)
               let actnOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
               let actnCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
               alertController.addAction(actnOk)
               alertController.addAction(actnCancel)
               self.present(alertController, animated: true, completion: nil)
     
 **/
    
    

}

///封装系统UIAlertController
/**
 //使用
 //        UIAlertController.showAlertOneButton(title: "Ok", message: "Ok", buttonTitle: "Ok") { (action) in
 //        }
         
 //        UIAlertController.showAlertTwoButton(title: "Ok", message: "Ok", cancelButtonTitle: "cancel", cancelhandler: { (action) in
 //        }, otherButtonTitle: "other") { (action) in
 //        }
 */
extension UIAlertController {
    
    static func showAlertTitle(title: String?) {
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            kkeyWindow?.rootViewController!.present(alert, animated: true)
            
     }
    static func showAlertMessage(message: String?) {
               let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
               kkeyWindow?.rootViewController!.present(alert, animated: true)
               
      }
    
    static func showAlertTitleMessage(title: String?, message: String?) {
               let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
               kkeyWindow?.rootViewController!.present(alert, animated: true)
               
      }
    
     
    static func showAlertOneButton(title: String?, message: String?, buttonTitle: String?, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actnOk = UIAlertAction(title: buttonTitle, style: .default, handler: handler)
        alert.addAction(actnOk)
        kkeyWindow?.rootViewController!.present(alert, animated: true)
       
    }
    
     static func showAlertTwoButton(title: String?,
                                    message: String?,
                                    cancelButtonTitle: String?,
                                    cancelHandler: ((UIAlertAction) -> Void)?,
                                    otherButtonTitle: String?,
                                    otherHandler: ((UIAlertAction) -> Void)?) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let actnOk = UIAlertAction(title: otherButtonTitle, style: .default, handler: cancelHandler)
            let actnCancel = UIAlertAction(title: cancelButtonTitle, style: .default, handler: otherHandler)
            
            alert.addAction(actnCancel)
            alert.addAction(actnOk)
            kkeyWindow?.rootViewController!.present(alert, animated: true)
            
        }
    
    
    static func showAlertTextField(title: String?,
                                message: String?,
                                cancelButtonTitle: String?,
                                cancelHandler: ((UIAlertAction) -> Void)?,
                                otherButtonTitle: String?,
                                otherHandler: ((UIAlertAction) -> Void)?,
                                addTextFieldHandler: ((UITextField) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actnOk = UIAlertAction(title: otherButtonTitle, style: .default, handler: cancelHandler)
        let actnCancel = UIAlertAction(title: cancelButtonTitle, style: .default, handler: otherHandler)
        alert.addTextField(configurationHandler: addTextFieldHandler)
        alert.addAction(actnCancel)
        alert.addAction(actnOk)
        kkeyWindow?.rootViewController!.present(alert, animated: true)
        
    }
    
    

    
}
