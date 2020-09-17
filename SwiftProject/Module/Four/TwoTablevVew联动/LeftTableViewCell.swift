//
//  LeftTableViewCell.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/6/9.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class LeftTableViewCell: CJKTBaseTableViewCell {
    var titleLabel = UILabel()
    var leftTag = UIView()
    override func configUI() {
        titleLabel.frame = CGRect(x: 15, y: 0, width: 60, height: 55)
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = RGB(74, 74, 74)
        titleLabel.highlightedTextColor = RGB(236, 112, 67)
        contentView.addSubview(titleLabel)
        
        leftTag.frame = CGRect(x: 0, y: 20, width: 5, height: 15)
        leftTag.backgroundColor = RGB(236, 112, 67)
        contentView.addSubview(leftTag)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = selected ? RGB(254, 254, 254)
            : RGB(246, 246, 246)
        isHighlighted = selected
        titleLabel.isHighlighted = selected
        leftTag.isHidden = !selected
    }

}
