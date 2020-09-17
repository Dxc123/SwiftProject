//
//  MyTableViewCell.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/6/9.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var frame = newValue
            frame.origin.x += 15
            frame.size.width -= 2 * 15
            super.frame = frame
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
