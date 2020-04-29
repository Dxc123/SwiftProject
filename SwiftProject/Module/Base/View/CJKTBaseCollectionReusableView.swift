//
//  CJKTBaseCollectionReusableView.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/12.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import Reusable
import SnapKit
import Kingfisher
import SwiftyJSON
import HandyJSON
import PKHUD
class CJKTBaseCollectionReusableView: UICollectionReusableView, Reusable {
    override init(frame: CGRect) {
       super.init(frame: frame)
       configUI()
    }

    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }

    open func configUI() {}
}
