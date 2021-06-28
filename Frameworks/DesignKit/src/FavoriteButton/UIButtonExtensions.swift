//
//  UIButtonExtensions.swift
//  DesignKit
//
//  Created by daixingchuang on 2021/6/25.
//iOS 系统内置的 SF Symbols 图标

import Foundation
import UIKit

public extension UIButton {
    //星星按钮
    func asStarFavoriteButton(pointSize: CGFloat = 18, weight: UIImage.SymbolWeight = .semibold, scale: UIImage.SymbolScale = .default, fillColor: UIColor = UIColor(hex: 0xf1c40f)) {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight, scale: scale)
        let starImage = UIImage(systemName: "star", withConfiguration: symbolConfiguration)
        setImage(starImage, for: .normal)

        let starFillImage = UIImage(systemName: "star.fill", withConfiguration: symbolConfiguration)
        setImage(starFillImage, for: .selected)

        tintColor = fillColor
        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
    }
    //心形按钮
    func asHeartFavoriteButton(pointSize: CGFloat = 18, weight: UIImage.SymbolWeight = .semibold, scale: UIImage.SymbolScale = .default, fillColor: UIColor = UIColor(hex: 0xe74c3c)) {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight, scale: scale)
        let heartImage = UIImage(systemName: "heart", withConfiguration: symbolConfiguration)
        setImage(heartImage, for: .normal)

        let heartFillImage = UIImage(systemName: "heart.fill", withConfiguration: symbolConfiguration)
        setImage(heartFillImage, for: .selected)

        tintColor = fillColor
        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
    }
}

private extension UIButton {
    @objc
    private func touchUpInside(sender: UIButton) {
        isSelected = !isSelected
    }
}
