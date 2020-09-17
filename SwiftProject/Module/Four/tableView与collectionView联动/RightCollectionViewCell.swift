//
//  RightCollectionViewCell.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/6/9.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class RightCollectionViewCell: CJKTBaseCollectionViewCell {
    var titleLabel = UILabel.init()
    var pictureView = UIImageView.init()
    override func configUI() {
        
        titleLabel.frame = CGRect.init(x: 2, y: frame.size.width,
                                       width: frame.size.width - 4, height: 20)
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        
        pictureView.frame = CGRect(x: 8, y: 8, width: frame.size.width - 16,
                                   height: frame.size.width - 16)
        pictureView.contentMode = .scaleAspectFit
        contentView.addSubview(pictureView)
    }
     //设置数据
    var model: CollectionViewModel? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.name
            pictureView.image = UIImage(named: model.picture)
        }
    }
    //设置数据
    func setData(_ model : CollectionViewModel) {
        titleLabel.text = model.name
        pictureView.image = UIImage(named: model.picture)
    }
     
}

