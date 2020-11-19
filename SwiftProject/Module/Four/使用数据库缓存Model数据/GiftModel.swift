//
//  GiftModel.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/11/14.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import HandyJSON
import KakaJSON
import WCDBSwift


//使用KakaJSON: 遵从Convertible 协议
struct GiftModel: Convertible {
    var uid: Int = 0
    var name: String = ""
    var animationFileURL: String = ""
    //    ....
}

//使用HandyJSON: 遵从HandyJSON 协议
struct GiftModel22: HandyJSON {
    var uid: Int?
    var name: String?
    var animationFileURL: String?
}


//使用WCDBSwif：遵从TableCodable 协议
extension GiftModel: TableCodable {
    
    enum CodingKeys: String, CodingTableKey {
        
        typealias Root = GiftModel
        
        //List the properties which should be bound to table
        case uid
        case name
        case animationFileURL
        //    ....
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                .uid: ColumnConstraintBinding(isUnique: true)
            ]
        }
    }
}

