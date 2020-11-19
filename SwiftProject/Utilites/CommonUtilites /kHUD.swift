//
//  kHUD.swift
//  YseMe
//
//  Created by daixingchuang on 2020/11/12.
//  Copyright © 2020 DiscoverJoy. All rights reserved.
//

import UIKit
import MBProgressHUD
import Toast_Swift
import PKHUD


struct kScreenInfo {
    static let Height = UIScreen.main.bounds.height
    static let Width = UIScreen.main.bounds.width
    static let navigationHeight: CGFloat = navBarHeight()
    static private func  kSafeAreaBottomHeight() -> CGFloat { //底部的安全距离
        if #available(iOS 11.0, *){
            return (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)!
        } else{
            return 0
        }
    }
    static private func kSafeAreaTopHeight() -> CGFloat {//顶部的安全距离
        if #available(iOS 11.0, *){
            return (UIApplication.shared.keyWindow?.safeAreaInsets.top)!
        } else{
            return 0
        }
    }
    static private func navBarHeight() -> CGFloat {
        return kSafeAreaBottomHeight() == 0 ? 88 : 64
    }
    
}
//向后兼容的keyWindow
extension UIWindow {
    static var kkkeyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
//推荐使用这个keyWindow
let hudKeyWindow = UIWindow.kkkeyWindow
/// 默认hub显示时间
private let hudShowTime = 1.5

// +----------------------------------------------------------------------
// 封装:MBProgressHUD
// +----------------------------------------------------------------------
class kHUD: NSObject {
    
    static var hud : MBProgressHUD?
    /// 创建Hud
    private class func createHud(view: UIView? = hudKeyWindow, isMask: Bool = true) -> MBProgressHUD? {
        guard let supview = view ?? hudKeyWindow else {return nil}
        let HUD = MBProgressHUD.showAdded(to: supview
            , animated: true)
        HUD.frame = CGRect(x: 0, y: 0, width: kScreenInfo.Width, height: kScreenInfo.Height)
        HUD.animationType = .zoom
        
        if isMask {
            /// 蒙层type,背景半透明.
            HUD.backgroundView.color = UIColor(white: 0.0, alpha: 0.4)
        } else {
            /// 非蒙层type,没有背景.
            HUD.backgroundView.color = UIColor.clear
            HUD.bezelView.backgroundColor = UIColor(white: 0.0, alpha: 0.9)
            HUD.contentColor = UIColor.white
        }
        HUD.removeFromSuperViewOnHide = true
        HUD.show(animated: true)
        return HUD
    }
    
    private class func showHudTips (message: String?, icon: String?, view: UIView?, completeBlock : (() -> Void)?) {
        var HUD: MBProgressHUD?
        
        HUD = self.createHud(view: view, isMask: false)
        HUD?.label.text = message
        HUD?.label.numberOfLines = 0
        /// 如果有Icon展示.
        if let icon = icon {
            HUD?.customView = UIImageView.init(image: UIImage.init(named: "\(icon)"))
        }
        HUD?.mode = .customView
        /// 在hud消失时调用completeBlock.
        DispatchQueue.main.asyncAfter(deadline: .now() + hudShowTime) {
            HUD?.hide(animated: true)
            guard let completeBlock = completeBlock else {
                return
            }
            completeBlock()
        }
    }
    
}


//MARK:--使用的类方法
extension kHUD {
    //MARK:--显示loadingHUD
    class func showLoadingHud(view: UIView? = hudKeyWindow ,message: String?, isMask: Bool = false,isTranslucent: Bool = false) {
       let HUD = self.createHud(view: view,isMask: isMask)
       HUD?.mode = .indeterminate
       HUD?.label.text = message
       hud = HUD
    }


    //MARK:-- 显示ToastHUD
    class func showToastHud(message: String?, view: UIView? = hudKeyWindow , isMask: Bool = true,afterDelay: Double = hudShowTime) {
    let HUD = self.createHud(view: view, isMask: isMask)
    HUD?.mode = .text
    HUD?.detailsLabel.font = UIFont.systemFont(ofSize: 16.0)
    HUD?.detailsLabel.text = message
    HUD?.hide(animated: true, afterDelay: afterDelay)
    }
    //MARK:-- 显示成功HUD（icon图片64X64）添加图片到项目里
    class func showSuccesshTips (message: String?, view: UIView? = hudKeyWindow , completeBlock : (() -> Void)?) {
       self.showHudTips(message: message, icon: "success.png", view: view, completeBlock: completeBlock)
    }
    //MARK:-- 显示成功HUD（icon图片64X64）添加图片到项目里
    class func showErrorMessage(message: String?, view: UIView? = hudKeyWindow ,completeBlock : (() -> Void)?) {
       self.showHudTips(message: message, icon: "error.png", view: view, completeBlock: completeBlock)
    }


    //MARK:-- 隐藏HUD
    class func hideHud () {
       guard let HUD = hud else {
           return
       }
       HUD.hide(animated: true)
       hud = nil
    }
    
}




// +----------------------------------------------------------------------
// 封装2：MBProgressHUD
// +----------------------------------------------------------------------
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




/////////////////////////////////

//Toast_Swift

/////////////////////////////
extension kHUD {

    class func showToast(title: String?){
        kkeyWindow?.makeToast(title, duration: 1.25, position: .center)
    }
    class func showToastActivity(){
        kkeyWindow?.makeToastActivity(.center)
    }
    
    class func hideToastActivity(){
        kkeyWindow?.hideToastActivity()
    }
    
}



















/**
 PKHUD
 */
//        HUD.flash(.success)
//        HUD.flash(.success, delay: 1)
//        HUD.flash(.error, delay: 1)
//        HUD.flash(.success, onView: kkeyWindow, delay: 1) { (finished) in
//            print("finished")
//        }
//        HUD.flash(.progress)
//        HUD.flash(.labeledSuccess(title: "Title", subtitle: "Subtitle"),delay: 2.0)

//        HUD.flash(.labeledError(title: "Title", subtitle: "Subtitle"),delay: 2.0)
//        HUD.flash(.labeledProgress(title: "Title", subtitle: ""),delay: 2.0)
//        HUD.flash(.labeledImage(image: kIMAGE("login_pic01"), title: "Title", subtitle: "Subtitle"),delay: 2.0)
//        HUD.flash(.rotatingImage(UIImage(named: "progress")), delay: 2.0)
//        HUD.flash(.labeledProgress(title: "Title", subtitle: "Subtitle"), delay: 2.0)
//        HUD.flash(.label("Title"),delay: 2.0)
//        HUD.flash(.systemActivity,delay: 2.0)

//        HUD.hide()
//        HUD.hide(afterDelay: 2)



//ProgressHUD
//        ProgressHUD.showSucceed()
//        ProgressHUD.showFailed()
//        ProgressHUD.showProgress(0.42)
//        ProgressHUD.show(icon: .rotate)
//        ProgressHUD.dismiss()
     
