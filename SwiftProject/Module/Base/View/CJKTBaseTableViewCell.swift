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

}
