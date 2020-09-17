//
//  CollectionViewModel.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/6/9.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class CollectionViewModel: NSObject {
    var name : String
    var picture : String
    init(name: String, picture: String) {
        self.name = name
        self.picture = picture
    }
}
