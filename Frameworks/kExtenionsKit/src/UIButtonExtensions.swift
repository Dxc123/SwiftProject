//
//  UIButtonExtensions.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//(Swift版本扩展)前缀 sf

import Foundation
import UIKit
public extension UIButton {
    /**
     Set UIButton's backgroundColor with a UIImage
     */
    func sf_setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(theImage, for: forState)
    }
}
public extension UIButton {
   
    ///MARK:--调整按钮中的图标和文字位置(适配 RTL布局)
    func sf_setTitlePosition(image: UIImage?,
                                 title: String,
                   titlePosition: UIView.ContentMode,
                   contentSpacing: CGFloat,
                   state: UIControl.State,isRTL: Bool){
        self.imageView?.contentMode = .center
        self.setImage(image, for: state)
        
        sf_setPosition(title: title,
                    position: titlePosition,
                    spacing: contentSpacing,
                    isRTL: isRTL)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
    
    private func sf_setPosition(title: String,
                             position: UIView.ContentMode,
                             spacing: CGFloat,
                             isRTL: Bool) {
        //计算文本尺寸
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
//        默认：左imge 右title
        if isRTL {
            switch (position){
                   case .top:
                       titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                                  left: 0, bottom: 0, right: -(imageSize.width))
                       imageInsets = UIEdgeInsets(top: 0, left: -titleSize.width, bottom: 0, right: 0)
                   case .bottom:
                       titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                                                  left: 0, bottom: 0, right: -(imageSize.width))
                       imageInsets = UIEdgeInsets(top: 0, left: -titleSize.width, bottom: 0, right: 0)
                   case .left:
                       titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -(imageSize.width * 2))
                       imageInsets = UIEdgeInsets(top: 0, left: -(titleSize.width * 2 + spacing), bottom: 0,
                                                  right: 0)
                   case .right:
                       titleInsets = UIEdgeInsets(top: 0, left: -spacing, bottom: 0, right: 0)
                       imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                   default:
                       titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                       imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                   }
            
        }else{
            switch (position){
                   case .top:
                       titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                                  left: -(imageSize.width), bottom: 0, right: 0)
                       imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
                   case .bottom:
                       titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                                                  left: -(imageSize.width), bottom: 0, right: 0)
                       imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
                   case .left:
                       titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
                       imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                                  right: -(titleSize.width * 2 + spacing))
                   case .right:
                       titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
                       imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                   default:
                       titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                       imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                   }
        }
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}
public extension UIButton {

    //MARK: -定义button 内Image相对label的位置
    enum ButtonImagePosition {
            case top          //图片在上，文字在下，垂直居中对齐
            case bottom       //图片在下，文字在上，垂直居中对齐
            case left         //图片在左，文字在右，水平居中对齐
            case right        //图片在右，文字在左，水平居中对齐
    }
    /// - Description 设置Button图片的位置
    /// - Parameters:
    ///   - style: 图片位置
    ///   - spacing: 按钮图片与文字之间的间隔
    func sf_setImagePosition(style: ButtonImagePosition, spacing: CGFloat) {
        //得到imageView和titleLabel的宽高
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        
        var labelWidth: CGFloat! = 0.0
        var labelHeight: CGFloat! = 0.0
        
        labelWidth = self.titleLabel?.intrinsicContentSize.width
        labelHeight = self.titleLabel?.intrinsicContentSize.height
        
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .top:
            //上 左 下 右
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-spacing/2, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-spacing/2, right: 0)
            break;
            
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
            break;
            
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-spacing/2, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-spacing/2, left: -imageWidth!, bottom: 0, right: 0)
            break;
            
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+spacing/2, bottom: 0, right: -labelWidth-spacing/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-spacing/2, bottom: 0, right: imageWidth!+spacing/2)
            break;
            
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        
    }
}



public extension UIButton {
   
    /// 文字的按钮
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - titleFont: 标题文本尺寸
    ///   - titleColor: 标题颜色
    ///   - bgColor: 背景色
    ///   - obj: 按钮响应对象
    ///   - methord: 按钮事件
    /// - Returns: 按钮
    class func sf_creatBtn(title: String, titleFont: UIFont, titleColor: UIColor = .black, bgColor: UIColor = .clear, obj: AnyObject?, methord: Selector?) -> UIButton {
        let btn = UIButton.init(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.titleLabel?.font = titleFont
        btn.backgroundColor = bgColor
        if methord != nil && obj != nil {
            btn.addTarget(obj, action: methord!, for: .touchUpInside)
        }
        return btn
    }
    
    /// 图片按钮
    ///
    /// - Parameters:
    ///   - img: 背景图片
    ///   - selectImg: 选中背景图片
    ///   - obj: 按钮响应对象
    ///   - methord: 按钮事件
    /// - Returns: 按钮
    class func sf_creatBtn(img: String, selectImg: String?, obj: AnyObject?, methord: Selector?) -> UIButton {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: img), for: .normal)
        if selectImg != nil {
            btn.setImage(UIImage.init(named: selectImg!), for: .selected)
        }
        if methord != nil && obj != nil {
            btn.addTarget(obj, action: methord!, for: .touchUpInside)
        }
        return btn
    }
    
    /// 背景图片按钮
    ///
    /// - Parameters:
    ///   - bgImg: 背景图片
    ///   - selectBgImg: 选中背景图片
    ///   - obj: 按钮响应对象
    ///   - methord: 按钮事件
    /// - Returns: 按钮
    class func sf_creatBtn(bgImg: String, selectBgImg: String?, obj: AnyObject?, methord: Selector?) -> UIButton {
        let btn = UIButton.init(type: .custom)
        btn.setBackgroundImage(UIImage.init(named: bgImg), for: .normal)
        if selectBgImg != nil {
            btn.setBackgroundImage(UIImage.init(named: selectBgImg!), for: .selected)
        }
        if methord != nil && obj != nil {
            btn.addTarget(obj, action: methord!, for: .touchUpInside)
        }
        return btn
    }
    
    /// 倒计时按钮
    ///
    /// - Parameters:
    ///   - title: 重置标题
    ///   - timeOut: 倒计时
    ///   - waitTime: 等待时间
   func sf_creatBtn(title: String, timeOut: NSInteger, waitTitle: String) {
        let timer = DispatchSource.makeTimerSource()
        timer.setEventHandler {
            if timeOut <= 0 {
                timer.cancel()
                self.setTitle(title, for: .normal)
                self.isUserInteractionEnabled = true
            } else {
                let seconds = timeOut % 60
                self.setTitle("\(seconds)\(waitTitle)", for: .normal)
                self.isUserInteractionEnabled = false
            }
        }
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        timer.resume()
    }
}
