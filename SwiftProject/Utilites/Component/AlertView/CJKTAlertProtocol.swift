//
//  CJKTAlertProtocol.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/5/13.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

public enum AppearFrom {
    case top, bottom, left, right
}

// Protocol for showing and dissmising alert view
public protocol AlertProtocol {
    func show(animated:Bool) -> Self
    func dismiss(animated:Bool) -> Self
    var backgroundView: UIView {get}
    var dialogView: UIView {get set}
    var appearFrom: AppearFrom {get}
    var clearBackground: Bool {get}
}

extension AlertProtocol {
    @discardableResult
    public func show() -> Self {
        return show(animated: true)
    }
    @discardableResult
    public func dismiss() -> Self {
        return dismiss(animated: true)
    }
}

extension AlertProtocol where Self: UIView{
    
    @discardableResult
    public func show(animated: Bool) -> Self {
        return show(animated: animated, superview: nil)
    }
    
    @discardableResult
    public func show(animated: Bool, superview: UIView?) -> Self {
        
        // Set origin before Animation
        if appearFrom == .top {
            self.dialogView.center = CGPoint(x:self.center.x, y:-self.frame.height+self.dialogView.frame.size.height/2)
        }else if appearFrom == .bottom {
            self.dialogView.center = CGPoint(x:self.center.x, y:self.frame.height+self.dialogView.frame.size.height/2)
        }else if appearFrom == .left {
            self.dialogView.center = CGPoint(x:-self.frame.size.width, y:self.frame.height/2)
        }else {
            self.dialogView.center = CGPoint(x:self.frame.size.width, y:self.frame.height/2)
        }
        
        self.backgroundView.alpha = 0
        self.backgroundView.isHidden = false
        
        if superview != nil {
            superview?.addSubview(self)
        }else {
            let cv = UIViewController.currentViewController()
            if let nav = cv?.navigationController {
                nav.view.addSubview(self)
            }else {
                cv?.view.addSubview(self)
            }
        }
        if animated {
            
            UIView.animate(withDuration: 0.33, animations: {
                if self.clearBackground == true{
                    self.backgroundView.alpha = 0
                }else{
                    self.backgroundView.alpha = 0.6
                }
            })
            // Set origin during Animation
            UIView.animate(withDuration: 0.33, delay:0, usingSpringWithDamping:0.7, initialSpringVelocity:10, options:UIView.AnimationOptions(rawValue:0), animations: {
                self.dialogView.center = self.center
            })
        }else{
            if self.clearBackground == true{
                self.backgroundView.alpha = 0
            }else{
                self.backgroundView.alpha = 0.6
            }
            self.dialogView.center = self.center
        }
        return self
    }
    
    @discardableResult
    public func dismiss() -> Self {
        return dismiss(animated: true)
    }
    
    @discardableResult
    public func dismiss(animated: Bool) -> Self {
        
        self.backgroundView.isHidden = true
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0
            })
            
            UIView.animate(withDuration: 0.33, delay:0, usingSpringWithDamping: 1, initialSpringVelocity:10, options:UIView.AnimationOptions(rawValue:0), animations: {
                
                if self.appearFrom == .top {
                    self.dialogView.center = CGPoint(x:self.center.x, y:-self.frame.height+self.backgroundView.frame.size.height/2)
                }else if self.appearFrom == .bottom {
                    self.dialogView.center = CGPoint(x:self.center.x, y:self.frame.height+self.dialogView.frame.size.height/2)
                }else if self.appearFrom == .left {
                    self.dialogView.center = CGPoint(x:-self.frame.size.width, y:self.frame.height/2)
                }else {
                    self.dialogView.center = CGPoint(x:self.frame.size.width+self.dialogView.frame.size.width, y:self.frame.height/2)
                }
                
                
            }) { (completed) in
                self.removeFromSuperview()
            }
            
        }else{
            self.removeFromSuperview()
        }
        return self
    }
}

extension UIViewController {
    /// 获取当前最顶层的vc
    internal class func currentViewController(base: UIViewController? = kkeyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
    
}
