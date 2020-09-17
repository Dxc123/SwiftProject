//
//  CJKTHUD.swift
//  Happy100
//
//  Created by 李鹏 on 2017/4/4.
//  Copyright © 2017年 Hangzhou DangQiang network Technology Co., Ltd. All rights reserved.
//

import Foundation
class CJKTHUD {
    static var lastHUD: MBProgressHUD? = nil
    ///显示文字
    class func showText(at view: UIView?, text: String) {
        if let lastHUD = lastHUD {
            lastHUD.hide(animated: false)
        }
        
        let inView = view ?? topView()
        let HUD = MBProgressHUD(view: inView)
        HUD.mode = MBProgressHUDMode.text
        HUD.detailsLabel.text = text
        HUD.margin = 10.0
        //HUD.yOffset = inView.frame.size.height / 2.0 - 80.0
        HUD.removeFromSuperViewOnHide = true
        inView.addSubview(HUD)
        HUD.show(animated: true)
        
        HUD.hide(animated: true, afterDelay: 1)
    }
///   错误
    class func showError(at view: UIView?, text: String?) {
        let errorView = UIImageView(image: UIImage(named: "hud_error"))
        let HUD = show(at: view, text: text, customView: errorView, global: true)
        HUD.hide(animated: true, afterDelay: 1)
    }
///    成功
    class func showSuccess(at view: UIView?, text: String?) {
        let successView = UIImageView(image: UIImage(named: "hud_success"))
        let HUD = show(at: view, text: text, customView: successView, global: true)
        HUD.hide(animated: true, afterDelay: 1)
    }
    
    @discardableResult class func showHUD(at view: UIView?, text: String?, global: Bool = true) -> MBProgressHUD {
        return show(at: view, text: text, customView: nil, global: global)
    }
}

extension CJKTHUD {
///    隐藏
    class func hide(_ animated: Bool) {
        if let hud = lastHUD {
            hud.hide(animated: animated)
            lastHUD = nil
        }
    }
}

extension CJKTHUD {
///    自定义HUD
    fileprivate class func show(at view: UIView?, text: String?, customView: UIView?, global: Bool) -> MBProgressHUD {
        CJKTHUD.hide(false)
        
        let inView = view ?? topView()
        let HUD = MBProgressHUD(view: inView)
        if let _ = customView {
            HUD.mode = MBProgressHUDMode.customView
        } else {
            HUD.mode = MBProgressHUDMode.indeterminate
        }
        
        HUD.customView = customView
        HUD.detailsLabel.text = text
        HUD.removeFromSuperViewOnHide = true
        inView.addSubview(HUD)
        HUD.show(animated: true)
        
        if global {
            lastHUD = HUD
        }
        return HUD
    }
    
    fileprivate class func topView() -> UIView {
//        return UIApplication.shared.keyWindow ?? UIView()
        if #available(iOS 13, *) {
                   return UIApplication.shared.windows.first {$0.isKeyWindow } ?? UIView()
               } else {
                   return UIApplication.shared.keyWindow ?? UIView()
               }
    }
}
