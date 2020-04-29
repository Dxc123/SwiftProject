//
//  CJKTSecondCollectionCell.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/13.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class CJKTSecondCollectionCell: CJKTBaseCollectionViewCell {
    lazy var iconImgV: UIImageView = {
        let img = UIImageView.init()
//        img.contentMode = .scaleAspectFit
        return img
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.textAlignment = .center
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = .black
        lab.numberOfLines = 0
        return lab
    }()
    
    override func configUI() {
        layer.cornerRadius = 5
        layer.borderWidth = 1;
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.masksToBounds = true
        

        contentView.addSubview(iconImgV)
        iconImgV.snp.makeConstraints{
            $0.left.right.top.equalToSuperview().offset(0)
            $0.height.equalTo(180)
        }
        
        contentView.addSubview(titleLab)
        titleLab.snp.makeConstraints {
            $0.left.equalTo(iconImgV.snp.left).offset(0)
            $0.top.equalTo(iconImgV.snp.bottom)
            $0.width.equalTo(100)
            $0.height.equalTo(20)
        }
      
    }
    
    
//    model赋值
    var model: GrilListModel? {
        
        didSet{
            guard let model = model else {return}
            iconImgV.kf.setImage(with: URL(string: model.url!),
                                 placeholder: UIImage.init(named: "normal_placeholder_h"), options:[.transition(.fade(0.2))])
            titleLab.text = model.title

        }
    }
    
    
    
}
