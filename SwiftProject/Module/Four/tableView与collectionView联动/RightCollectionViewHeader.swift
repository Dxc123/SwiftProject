//
//  RightCollectionViewHeader.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/6/9.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class RightCollectionViewHeader: CJKTBaseCollectionReusableView {
    var titleLabel = UILabel.init()
    override func configUI() {
        backgroundColor = UIColor.white
        titleLabel.frame = CGRect(x: 15, y: 0, width: 200, height: 30)
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        addSubview(titleLabel)
    }
}
