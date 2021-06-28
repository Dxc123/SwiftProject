//
//  UIViewExtension+Frame.swift
//  SwiftProject
//
//  Created by daixingchuang on 2021/6/23.
//  Copyright © 2021 Dxc_iOS. All rights reserved.
//(Swift版本扩展)前缀 sf

import Foundation
import UIKit
//扩展UIView便捷修改frame
extension UIView{
    
       /// x
       public var x: CGFloat {
           get {
               return frame.origin.x
           }
           set(newValue) {
               var tempFrame: CGRect = frame
               tempFrame.origin.x    = newValue
               frame                 = tempFrame
           }
       }
       
       /// y
      public var y: CGFloat {
           get {
               return frame.origin.y
           }
           set(newValue) {
               var tempFrame: CGRect = frame
               tempFrame.origin.y    = newValue
               frame                 = tempFrame
           }
       }
       
       /// height
      public var height: CGFloat {
           get {
               return frame.size.height
           }
           set(newValue) {
               var tempFrame: CGRect = frame
               tempFrame.size.height = newValue
               frame                 = tempFrame
           }
       }
       
       /// width
       public var width: CGFloat {
           get {
               return frame.size.width
           }
           set(newValue) {
               var tempFrame: CGRect = frame
               tempFrame.size.width = newValue
               frame = tempFrame
           }
       }
       
       /// size
       public var size: CGSize {
           get {
               return frame.size
           }
           set(newValue) {
               var tempFrame: CGRect = frame
               tempFrame.size = newValue
               frame = tempFrame
           }
       }
       
       /// centerX
       public var centerX: CGFloat {
           get {
               return center.x
           }
           set(newValue) {
               var tempCenter: CGPoint = center
               tempCenter.x = newValue
               center = tempCenter
           }
       }
       
       /// centerY
       public var centerY: CGFloat {
           get {
               return center.y
           }
           set(newValue) {
               var tempCenter: CGPoint = center
               tempCenter.y = newValue
               center = tempCenter;
           }
       }
       
}
