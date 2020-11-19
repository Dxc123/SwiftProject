//
//  CustomEmptyView.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/9/18.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//
//自定义空数据试图
import UIKit
import SnapKit

class CustomEmptyView: UIView {
    var tapClosure: (() -> Void)?
    lazy var titleLab: UILabel = {
        let nl = UILabel.init()
        nl.text = "No data"
        nl.textColor = UIColor.gray
        nl.font = UIFont.systemFont(ofSize: 16)
        nl.textAlignment = .center
        nl.numberOfLines = 0
        return nl
    }()
    lazy var subtitleLab: UILabel = {
        let nl = UILabel.init()
        nl.text = "请点击试一试"
        nl.textColor = UIColor.gray
        nl.font = UIFont.systemFont(ofSize: 16)
        nl.textAlignment = .center
        nl.numberOfLines = 0
        return nl
    }()
    lazy var iconImgV: UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .scaleAspectFit
        img.image = kIMAGE("table_view_empty")
        return img
    }()
    lazy var tapButon: UIButton = {
        let sn = UIButton(type: .custom)
        sn.frame = CGRect.zero
        sn.backgroundColor = UIColor.clear.withAlphaComponent(1)
        sn.setTitle("点击", for: .normal)
        sn.setTitleColor(.gray, for: .normal)
        sn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        sn.addTarget(self, action:#selector(tapButon(_:)), for: .touchUpInside)
        return sn
    }()
   
    @objc func tapButon(_ button: UIButton){
    guard let tapClosure = tapClosure else { return }
    tapClosure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configUI(){
        self.addSubview(iconImgV)
        iconImgV.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-30)
//            make.height.equalTo(20)
        }
        self.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(iconImgV.snp.bottom).offset(30)
            make.height.equalTo(20)
        }
        self.addSubview(subtitleLab)
        subtitleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        self.addSubview(tapButon)
        tapButon.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(subtitleLab.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
        tapButon.layer.contents = 15
        tapButon.layer.masksToBounds = true
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
