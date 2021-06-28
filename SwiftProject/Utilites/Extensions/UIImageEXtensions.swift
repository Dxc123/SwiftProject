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


extension UIImage {
    
    ///根据颜色创建图片
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}


extension UIImage{
/**生成渐变色图片*/
//    let imge = UIImage.getGradientImage(colors: [.red,.cyan])
//    let color = UIColor.init(patternImage: imge)
    
//      func getGradientImage(colors: [UIColor], blendMode: CGBlendMode = CGBlendMode.normal) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(size, false, scale)
//        let context = UIGraphicsGetCurrentContext()
//        context?.translateBy(x: 0, y: size.height)
//        context?.scaleBy(x: 1.0, y: -1.0)
//        context?.setBlendMode(blendMode)
//        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//        context?.draw(self.cgImage!, in: rect)
//        // Create gradient
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let colors = colors.map {(color: UIColor) -> AnyObject? in return color.cgColor as AnyObject? } as NSArray
//        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)
//        // Apply gradient
//        context?.clip(to: rect, mask: self.cgImage!)
//        context?.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: size.height), options: CGGradientDrawingOptions(rawValue: 0))
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext();
//        return image!;
//    }
}
