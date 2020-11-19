//
//  CJKTCornerView.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/9/17.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
/**
 view 设置任意圆角
 */
@IBDesignable
class CJKTCornerView: UIView {
        /// 左上角圆角
        @IBInspectable var topLeftCornerRadious: CGFloat = 0 {
            didSet {
                refreshCorner()
            }
        }
        /// 右上角圆角
        @IBInspectable var topRightCornerRadious: CGFloat = 0 {
            didSet {
                refreshCorner()
            }
        }
        /// 左下角圆角
        @IBInspectable var bottomLeftCornerRadious: CGFloat = 0 {
            didSet {
                refreshCorner()
            }
        }
        /// 右下角圆角
        @IBInspectable var bottomRightCornerRadious: CGFloat = 0 {
            didSet {
                refreshCorner()
            }
        }
        
        private func refreshCorner() {
            let maskLayer = CAShapeLayer()
            maskLayer.frame = bounds
            self.layer.mask = maskLayer
            
            let borderPath = UIBezierPath()
            // 起点
            borderPath.move(to: .init(x: 0, y: topLeftCornerRadious))
            // 左上角
            borderPath.addQuadCurve(to: .init(x: topLeftCornerRadious, y: 0), controlPoint: .zero)
            // 直线，到右上角
            borderPath.addLine(to: .init(x: bounds.width-topRightCornerRadious, y: 0))
            // 右上角圆角
            borderPath.addQuadCurve(to: .init(x: bounds.width, y: topRightCornerRadious), controlPoint: .init(x: bounds.width, y: 0))
            // 直线，到右下角
            borderPath.addLine(to: .init(x: bounds.width, y: bounds.height-bottomRightCornerRadious))
            // 右下角圆角
            borderPath.addQuadCurve(to: .init(x: bounds.width-bottomRightCornerRadious, y: bounds.height), controlPoint: .init(x: bounds.width, y: bounds.height))
            // 直线，到左下角
            borderPath.addLine(to: .init(x: bottomLeftCornerRadious, y: bounds.height))
            // 左下角圆角
            borderPath.addQuadCurve(to: .init(x: 0, y: bounds.height-bottomLeftCornerRadious), controlPoint: .init(x: 0, y: bounds.height))
            // 回到起点
            borderPath.addLine(to: .init(x: 0, y: topLeftCornerRadious))
            
            maskLayer.path = borderPath.cgPath
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            refreshCorner()
        }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
