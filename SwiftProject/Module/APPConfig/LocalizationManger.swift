//
//  LocalizationManger.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/11/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

/**
 字符串本地化管理类
 */
import UIKit

/**
 使用：label.text = kYMString("点一下")
 */
func kYMString(_ key:String) -> String {
    
    return LocalizationManger.shareManger.localizedString(key)
}

class LocalizationManger: NSObject {
    
    var bundle:Bundle?
    
    static let shareManger:LocalizationManger = {
        let instance = LocalizationManger()
        return instance
    }()
    
    override init() {
        super.init()
        initLangage()
    }
    

    
    fileprivate func localizedString(_ key: String) -> String {
        return NSLocalizedString(key, tableName: "", bundle: bundle!, value: "", comment: "")
    }
    
   fileprivate  func initLangage() {
        if let userLanguage = UserDefaults.standard.value(forKey: kUserLanguage) as? String   {
            var languageStr: String  = "en"
            if userLanguage.hasPrefix("en") {
                languageStr = "en"
            }else if userLanguage.hasPrefix("ar") {
                languageStr = "ar"
            }else if userLanguage.hasPrefix("id") {
                languageStr = "id"
            }else if userLanguage.hasPrefix("tr") {
                languageStr = "tr"
            }else if userLanguage.hasPrefix("hi") {
                languageStr = "hi"
            }else if userLanguage.hasPrefix("zh") {
                languageStr = "zh-Hans"
            }
            
            let bundlePath = Bundle.main.path(forResource: languageStr, ofType: "lproj")
            
            bundle = Bundle.init(path: bundlePath!)
            
        }else {
            //默认手机系统语言
            var language = NSLocale.preferredLanguages.first
            UserDefaults.standard.setValue(language, forKey: kUserLanguage)
            if language!.hasPrefix("en") {
                language = "en"
            }else if language!.hasPrefix("ar") {
                language = "ar"
            }else if language!.hasPrefix("id") {
                language = "id"
            }else if language!.hasPrefix("tr") {
                language = "tr"
            }else if language!.hasPrefix("hi") {
                language = "hi"
            }else if language!.hasPrefix("zh") {
                language = "zh-Hans"
            }
            
            UserDefaults.standard.setValue(language, forKey: kUserLanguage)
            UserDefaults.standard.synchronize()
            
            let bundlePath = Bundle.main.path(forResource: language, ofType: "lproj")
            bundle = Bundle.init(path: bundlePath!)
        }
        
    }
}


extension LocalizationManger {
    
    //MARK:-- 设置语言
   public func setUserLanguage(language:String) {
        UserDefaults.standard.setValue(language, forKey: kUserLanguage)
        UserDefaults.standard.synchronize()
        let bundlePath = Bundle.main.path(forResource: language, ofType: "lproj")
        bundle = Bundle.init(path: bundlePath!)
    }
    //MARK:-- APP内切换语言 要刷新项目的RootViewController（修改成你的RootViewController）
    public func reloadRootViewControlle() {
        let delegate = UIApplication.shared.delegate!
        let tabbarVc = UITabBarController()
        delegate.window??.rootViewController = tabbarVc
    }
}


extension String {
    // MARK:-- 本地化字符串
    func localiz(comment: String = "") -> String {
        guard let bundlePath = Bundle.main.path(forResource: APPConfig.getUserLanguage(), ofType: "lproj"),
            let langBundle = Bundle(path: bundlePath)  else {
            return NSLocalizedString(self, comment: comment)
        }
        //返回对应语言国际化的字符串
        return NSLocalizedString(self, tableName: nil, bundle: langBundle, comment: comment)
    }
    
    /// Returns the NSLocalizedString version of self from the Info.plist table
    var infoPlistLocalized: String {
        NSLocalizedString(self, tableName: "InfoPlist", bundle: .main, value: "", comment: "")
    }
}
