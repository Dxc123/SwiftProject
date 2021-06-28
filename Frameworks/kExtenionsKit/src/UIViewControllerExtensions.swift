//
//  UIViewControllerExtensions.swift
//  SwiftExtenions
//
//  Created by daixingchuang on 2021/6/25.
//

import Foundation
import UIKit

///封装系统UIAlertController
public extension UIViewController {
//   func sf_showAlert(title: String?){
//            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
//        present(alert, animated: true, completion: nil)
//     }
//   func sf_showAlertMessage(message: String?) {
//          let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//          present(alert, animated: true, completion: nil)
//
//      }
//
//  func sf_showAlertTitleMessage(title: String?, message: String?) {
//           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//           present(alert, animated: true, completion: nil)
//
//      }
    
     
  func sf_showAlertOneButton(title: String?, message: String?, buttonTitle: String?, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actnOk = UIAlertAction(title: buttonTitle, style: .default, handler: handler)
        alert.addAction(actnOk)
        present(alert, animated: true, completion: nil)
       
    }
    
    func sf_showAlertTwoButton(title: String?,
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
            present(alert, animated: true)
            
        }
    
    
    func showAlertTextField(title: String?,
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
        present(alert, animated: true)
        
    }

    
}
