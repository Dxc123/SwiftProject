//
//  APPConfig.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/11/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class APPConfig: NSObject {
    
    //MARK: APP第一次启动 获取当前系统默认语言 并储存
        class func getSystemLanguage() {
            //    获取当前系统默认语言
           // 方法一，preferredLanguages 可以获取系统首选语言列表数组
            let userLanguage = NSLocale.preferredLanguages.first
            
            // 方法二，从 UserDefaults 获取系统首选语言列表数组
//            let userLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
//            let userLanguage = userLanguages.first
            kLog("当前系统userLanguage = \(String(describing: userLanguage))")
            //储存用户语言
            UserDefaults.standard.set(userLanguage, forKey: kUserLanguage)
            UserDefaults.standard.synchronize()
        }
    
    
    //MARK:-- 获取语言
      class func getUserLanguage() -> String {
         return UserDefaults.standard.value(forKey: kUserLanguage) as! String
        }
       
////////////////////////////////////////////////////////////////////
    
//    适配阿拉伯语等RLT布局
    
////////////////////////////////////////////////////////////////////
    //    MARK: 设置APP布局方向
    class func setAPPDirection() {
        if let lang = UserDefaults.standard.value(forKey: kUserLanguage) as? String   {
            if lang.hasPrefix("ar") {
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
            }else {
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
            }
        }
    }
    //    MARK: --是否是RTL
       class func  IsRightToLeft() -> Bool{
           if let lang = UserDefaults.standard.value(forKey: kUserLanguage) as? String   {
               guard lang.hasPrefix("ar") else { return false }
               return true
              
           }else {
               return false
           }
         
       }
    //    MARK:-- 箭头图片旋转 180（适配阿拉伯语）(左右)
        class func ImgeTransformX(imgeV: UIImageView) {
            if let lang = UserDefaults.standard.value(forKey: kUserLanguage) as? String   {
                if lang.hasPrefix("ar") {
    //  当sx为正值时,会在x轴方向上缩放x倍,反之,则在缩放的基础上沿着竖直线翻转;当sy为正值时,会在y轴方向上缩放y倍,反之,则在缩放的基础上沿着水平线翻转
                    imgeV.transform = CGAffineTransform(scaleX: -1, y: -1)
                }
            }
        }
        //    MARK:-- 箭头图片旋转 180（适配阿拉伯语）(上下)
        class func ImgeTransformY(imgeV: UIImageView) {
            if let lang = UserDefaults.standard.value(forKey: kUserLanguage) as? String   {
                if lang.hasPrefix("ar") {
                    imgeV.transform = CGAffineTransform.init(scaleX: -1, y: 1)
                }
            }
        }
   
    
    //    MARK:-- 显示语言名称
        class  func getLanguageName(str: String) -> String{
            let Str = str as NSString
            var languageName = ""
            if Str.isEqual(to: "ar") {
                languageName = "Arabic"
            }else if Str.isEqual(to: "id") {
                languageName = "Indonesia"
            }
            else if Str.isEqual(to: "en") {
                languageName = "English"
            }
            else if Str.isEqual(to: "tr") {
                languageName = "Turkish"
            }
            else if Str.isEqual(to: "hi") {
                languageName = "Hindi"
            }
            else if Str.hasPrefix("zh") {
                languageName = "中文"
            }
            else{
                languageName = "English"
            }
              kLog("languageName = \(languageName)")
             return languageName
         }
        

}
