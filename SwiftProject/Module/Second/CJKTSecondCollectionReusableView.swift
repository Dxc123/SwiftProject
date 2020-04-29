//
//  CJKTSecondCollectionReusableView.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/13.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

typealias MoreActionClosure = ()->Void
typealias SelectIndexClosure = (_ index: Int) -> Void
protocol CJKTSecondCollectionReusableViewDelegate: class {
    func comicCHead(_ head: CJKTSecondCollectionReusableView, moreAction button: UIButton)
}

class CJKTSecondCollectionReusableView: CJKTBaseCollectionReusableView {
//    delegate
    weak var delegate: CJKTSecondCollectionReusableViewDelegate?
//closure
    var moreActionClosure: MoreActionClosure?
    var selectIndexClosure: SelectIndexClosure?
    
        lazy var moreButton: UIButton = {
               let mn = UIButton(type: .system)
               mn.setTitle("•••", for: .normal)
               mn.setTitleColor(UIColor.lightGray, for: .normal)
               mn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
               mn.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
               return mn
           }()
    
    @objc func moreAction(button: UIButton) {
        delegate?.comicCHead(self, moreAction: button)
        
        guard let closure = moreActionClosure else { return }
        closure()
        guard let closure2 = selectIndexClosure else { return }
        closure2(button.tag)
    }
    
    func moreActionClosure(_ closure: MoreActionClosure?) {
        moreActionClosure = closure
    }
    
    
    override func configUI() {
           
           addSubview(moreButton)
           moreButton.snp.makeConstraints {
               $0.top.right.bottom.equalToSuperview()
               $0.width.equalTo(40)
           }
       }
    
    
}
