//
//  UIImageEXtensions.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
// MARK: -图片处理操作
   
   /// 裁切圆角图片
   ///
   /// - Parameter radius: 裁切半径
   /// - Returns: 裁切后的图片
   func clicpCircle() -> UIImage? {
       guard self.size.width == self.size.height else {
           return nil
       }
       // 准备图片上下文操作
       UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
       // 获取上下文
       let context = UIGraphicsGetCurrentContext()
       // 内切圆矩形尺寸
       let circleRect = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
       // 裁切圆
       context?.addEllipse(in: circleRect)
       context?.clip()
       self.draw(in: circleRect)
       // 获取裁切后的图片
       let newImage = UIGraphicsGetImageFromCurrentImageContext();
       // 关闭上下文
       UIGraphicsEndImageContext();
       return newImage
   }
   
   
}
