//
//  SnapKitExtension.swift
//  CartoonSwift
//
//  Created by Mac on 2019/8/9.
//  Copyright © 2019 rz. All rights reserved.
//

import Foundation
import SnapKit

//MARK: SnapKit
extension ConstraintView {
    /**解决iphoneX以后的底部和顶部安全距离*/
    var cjkt_snp: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}

/**
 
 make.edges.equalTo(self.view.cjkt_snp.edges)
 */
