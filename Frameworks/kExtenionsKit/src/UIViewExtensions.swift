//
//  UIViewExtensions.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//(Swift版本扩展)前缀 sf

import Foundation
import UIKit

// MARK: - Properties
public extension UIView {

     var sf_borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }

     var sf_borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
     var sf_cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }


    /**布局方向 是否是RTL*/ 
    var sf_isRTL: Bool {
        if #available(tvOS 10.0, *) {
            return effectiveUserInterfaceLayoutDirection == .rightToLeft
        } else {
            return false
        }
    }

    /**截图*/
    var sf_screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    /**阴影色*/
    var sf_shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    /**阴影色偏移量*/
     var sf_shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    /**阴影不透明度*/
    var sf_shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    /**阴影圆角*/
    var sf_shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

  

    /**获取视图的父视图控制器*/
    var sf_parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

   

   
}
public extension UIView{
    /**注册 NIb*/
    class func sf_ViewNib() -> UINib {
        let hasNib: Bool = Bundle.main.path(forResource: self.nib_className, ofType: "nib") != nil
        guard hasNib else {
            assert(!hasNib, "Nib is not exist")
            return UINib()
        }
        return UINib(nibName: self.nib_className, bundle:nil)
    }
     
    /**注册 NIb*/
    class func sf_ViewFromNib<T>(_ aClass: T.Type) -> T {
        let name = String(describing: aClass)
        if Bundle.main.path(forResource: name, ofType: "nib") != nil {
            return UINib(nibName: name, bundle:nil).instantiate(withOwner: nil, options: nil)[0] as! T
        } else {
            fatalError("\(String(describing: aClass)) nib is not exist")
        }
    }
    /**注册nib(class)*/
    class var nib_className: String {
        return String(describing: self.self)
    }
}

 
extension UIView {
    /** 设置圆角*/
    func sf_setCornersRadius(bounds:CGRect, topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
            let minX = bounds.minX
            let minY = bounds.minY
            let maxX = bounds.maxX
            let maxY = bounds.maxY

            let topLeftCenterX = minX + topLeft
            let topLeftCenterY = minY + topLeft
            let topRightCenterX = maxX - topRight
            let topRightCenterY = minY + topRight
            let bottomLeftCenterX = minX + bottomLeft
            let bottomLeftCenterY = maxY - bottomLeft
            let bottomRightCenterX = maxX - bottomRight
            let bottomRightCenterY = maxY - bottomRight
            
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: topLeftCenterX, y: topLeftCenterY), radius:topLeft, startAngle: CGFloat(Double.pi), endAngle: CGFloat(3 * Double.pi / 2.0), clockwise: false)
            path.addArc(center: CGPoint(x: topRightCenterX, y: topRightCenterY), radius: topRight, startAngle: CGFloat(3 * Double.pi / 2.0), endAngle: 0, clockwise: false)
            path.addArc(center: CGPoint(x: bottomRightCenterX, y: bottomRightCenterY), radius: bottomRight, startAngle: 0, endAngle: CGFloat(Double.pi / 2.0), clockwise: false)
            path.addArc(center: CGPoint(x: bottomLeftCenterX, y: bottomLeftCenterY), radius: bottomLeft, startAngle: CGFloat(Double.pi / 2.0), endAngle: CGFloat(Double.pi), clockwise: false)
            path.closeSubpath()
        
           let maskPath = UIBezierPath.init(cgPath: path)
           let maskLayer = CAShapeLayer()
           maskLayer.frame = bounds
           maskLayer.path = maskPath.cgPath
           layer.addSublayer(maskLayer)
           layer.mask = maskLayer
    }
}

extension UIView {
    /// 裁剪 view 的圆角
    public func sf_setRectCorner(direction: UIRectCorner, cornerRadius: CGFloat) {
        let cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
   

}
// MARK: - 扩展UIView,增加抖动方法

public extension UIView{
    
   enum ShakeDirection: Int{
        case horizontal
        case vertical
    }
    ///
    /// - Parameters:
    ///   - direction: 抖动方向（默认是水平方向）
    ///   - times: 抖动次数（默认5次）
    ///   - interval: 每次抖动时间（默认0.1秒）
    ///   - delta: 抖动偏移量（默认2）
    ///   - completion: 抖动动画结束后的回调
    func sf_shake(direction: ShakeDirection = .horizontal, times: Int = 5, interval: TimeInterval = 0.1, delta: CGFloat = 2, completion: (() -> Void)? = nil)
    {
        UIView.animate(withDuration: interval, animations: {
            
            switch direction
            {
            case .horizontal:
                self.layer.setAffineTransform(CGAffineTransform(translationX: delta, y: 0))
            case .vertical:
                self.layer.setAffineTransform(CGAffineTransform(translationX: 0, y: delta))
            }
        }) { (finish) in
            
            if times == 0{
                UIView.animate(withDuration: interval, animations: {
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (finish) in
                    completion?()
                })
            }else{
                self.sf_shake(direction: direction, times: times - 1, interval: interval, delta: -delta, completion: completion)
            }
        }
    }
}



public extension UIView {
    
    enum GradientDirection: Int{
        ///水平
        case horizontal
        ///垂直
        case vertical
    }
    
    /**MARK:-- UIView添加渐变色*/ 
//  使用:   sendGiftBtn.setGradientColor(direction: .horizontal, colors: [.red.cgColor ,.blue.cgColor])
    func sf_setGradientColor(direction: GradientDirection = .horizontal, colors: [Any]) {
       //    //水平方向渐变色  (x: 0, y: 0.5) (x: 1.0, y: 0.5)
       //   //垂直方向渐变色  (x: 0.5, y: 0) (x: 0.5, y: 1)
        var startPoint = CGPoint.init(x: 0, y: 0.5)
        var endPoint   = CGPoint.init(x: 1.0, y: 0.5)
        switch direction {
        case .horizontal:
            startPoint = CGPoint.init(x: 0, y: 0.5)
            endPoint   = CGPoint.init(x: 1.0, y: 0.5)
        case .vertical:
            startPoint = CGPoint.init(x: 0.5, y: 0)
            endPoint   = CGPoint.init(x: 0.5, y: 1)
        }
        
       // 外界如果改变了self的大小，需要先刷新
       layoutIfNeeded()
       var gradientLayer: CAGradientLayer!
       removeGradientLayer()
       gradientLayer = CAGradientLayer()
       gradientLayer.frame = self.layer.bounds
       gradientLayer.startPoint = startPoint
       gradientLayer.endPoint = endPoint
       gradientLayer.colors = colors
       gradientLayer.cornerRadius = self.layer.cornerRadius
       gradientLayer.masksToBounds = true
       // 渐变图层插入到最底层，避免在uibutton上遮盖文字图片
       self.layer.insertSublayer(gradientLayer, at: 0)
       self.backgroundColor = UIColor.clear
       // self如果是UILabel，masksToBounds设为true会导致文字消失
       self.layer.masksToBounds = false
    }
    
        // 移除渐变图层
        // （当希望只使用backgroundColor的颜色时，需要先移除之前加过的渐变图层）
    func removeGradientLayer() {
            if let sl = self.layer.sublayers {
                for layer in sl {
                    if layer.isKind(of: CAGradientLayer.self) {
                        layer.removeFromSuperlayer()
                    }
                }
            }
        }
}

