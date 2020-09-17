//
//  CJKTBaseTableViewCell.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/12.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import Foundation
import Reusable
import SnapKit
import Kingfisher
import SwiftyJSON
import HandyJSON
import PKHUD

import Then
class CJKTBaseTableViewCell: UITableViewCell ,Reusable{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       selectionStyle = .none
       configUI()
    }

    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }

    open func configUI() {}


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //在底部绘制1像素的线条
          override func draw(_ rect: CGRect) {
              //获取绘图上下文
              guard let context = UIGraphicsGetCurrentContext() else {
                  return
              }
              //线宽
              let lineWidth = 1 / UIScreen.main.scale
              //线偏移量
              let lineAdjustOffset = 1 / UIScreen.main.scale / 2
              //创建一个矩形，它的所有边都内缩固定的偏移量
              let drawingRect = self.bounds.insetBy(dx: lineAdjustOffset, dy: lineAdjustOffset)
              //创建并设置路径
              let path = CGMutablePath()
              path.move(to: CGPoint(x: 0, y: drawingRect.maxY))
              path.addLine(to: CGPoint(x: self.bounds.width, y: drawingRect.maxY))
              //添加路径到图形上下文
              context.addPath(path)
              //设置笔触颜色
              context.setStrokeColor(RGB(225, 225, 225).cgColor)
              //设置笔触宽度
              context.setLineWidth(lineWidth)
              //绘制路径
              context.strokePath()
          }

}
