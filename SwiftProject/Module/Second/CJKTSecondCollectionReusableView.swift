//
//  CJKTSecondCollectionReusableView.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/13.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
// 声明Block
typealias moreActionClosure = ()->Void
typealias selectIndexClosure = (_ index: Int) -> Void

// delegate
protocol CJKTSecondCollectionReusableViewDelegate: NSObjectProtocol {
    func didselectHead(_ head: CJKTSecondCollectionReusableView,_ index: Int)
}

class CJKTSecondCollectionReusableView: CJKTBaseCollectionReusableView {

    weak var delegate: CJKTSecondCollectionReusableViewDelegate?
    var selectIndexClosure: selectIndexClosure?
    
    lazy var moreButton: UIButton = {
           let mn = UIButton(type: .system)
           mn.setTitle("•••", for: .normal)
           mn.setTitleColor(UIColor.lightGray, for: .normal)
           mn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mn.addTarget(self, action: #selector(moreAction(_:)), for: .touchUpInside)
           return mn
       }()
    
    @objc func moreAction(_ button: UIButton) {
        delegate?.didselectHead(self, button.tag)
        
        selectIndexClosure!(button.tag)
    }
    
    
    
    override func configUI() {
           
           addSubview(moreButton)
           moreButton.snp.makeConstraints {
               $0.top.right.bottom.equalToSuperview()
               $0.width.equalTo(40)
           }
       }
    
    
}
