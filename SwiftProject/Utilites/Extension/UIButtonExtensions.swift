//
//  UIButtonExtensions.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
   
    /// 自由调整图标按钮中的图标和文字位置（扩展UIButton）
   
    public func set(image anImage: UIImage?, title: String,
                   titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
    
    private func positionLabelRespectToImage(title: String, position: UIView.ContentMode,
                                             spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
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
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}


extension UIButton {
   
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
    public class func creatBtn(title: String, titleFont: UIFont, titleColor: UIColor = .black, bgColor: UIColor = .clear, obj: AnyObject?, methord: Selector?) -> UIButton {
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
    public class func creatBtn(img: String, selectImg: String?, obj: AnyObject?, methord: Selector?) -> UIButton {
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
    public class func creatBtn(bgImg: String, selectBgImg: String?, obj: AnyObject?, methord: Selector?) -> UIButton {
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
    public func creatBtn(title: String, timeOut: NSInteger, waitTitle: String) {
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
