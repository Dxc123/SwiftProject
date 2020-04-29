//
//  CJKTHomeTableViewCell.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/27.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class CJKTHomeTableViewCell: CJKTBaseTableViewCell {
    lazy var iconImgV: UIImageView = {
        let img = UIImageView.init()
        img.image = UIImage.init(named: "normal_placeholder_h")
        img.contentMode = .scaleAspectFit
        return img
    }()
     lazy var nickNameLabel: UILabel = {
        let nl = UILabel.init()
           nl.textColor = UIColor.gray
           nl.font = UIFont.systemFont(ofSize: 15)
           nl.textAlignment = .center
//           nl.backgroundColor = UIColor.red
           return nl
       }()
    private lazy var clickedButon: UIButton = {
        let sn = UIButton(type: .custom)
        sn.frame = CGRect.zero
        sn.backgroundColor = UIColor.clear.withAlphaComponent(1)
        sn.setTitle("", for: .normal)
        sn.setTitleColor(.gray, for: .normal)
        sn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
//        sn.setImage(UIImage(named: "nav_search")?.withRenderingMode(.alwaysOriginal), for: .normal)
//        sn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
//        sn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
//         sn.layer.cornerRadius = 15
        sn.addTarget(self, action:#selector(searchAction), for: .touchUpInside)
        return sn
    }()
    override func configUI() {
        contentView.addSubview(iconImgV)
        iconImgV.snp.makeConstraints{
            $0.left.top.equalToSuperview().offset(10)
            $0.width.height.equalTo(100)
        }
        
        contentView.addSubview(nickNameLabel)
        nickNameLabel.snp.makeConstraints {
            $0.left.equalTo(iconImgV.snp.left).offset(0)
            $0.top.equalTo(iconImgV.snp.bottom)
            $0.width.equalTo(100)
            $0.height.equalTo(20)
        }
    }

    
    @objc func searchAction(){
        
    }
    
    var model: GrilListModel? {
        didSet {
            guard let model = model else { return }
            iconImgV.kf.setImage(with: URL(string: model.url!),
                                 placeholder: UIImage.init(named: "normal_placeholder_h"), options:[.transition(.fade(0.2))])
            nickNameLabel.text = model.title
            
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
