//
//  LoginUserModel.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/11/13.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import Foundation
//import SwiftyJSON
import HandyJSON
import KakaJSON
import WCDBSwift


//使用KakaJSON: 遵从Convertible 协议
struct LoginUserModel: Convertible {
    var uid: Int  = 0
    var gender: Int = 0
    var nickname: String = ""
    var portrait: String = ""
    //    ....
}

////使用WCDBSwif：遵从TableCodable 协议
extension LoginUserModel: TableCodable {
    
    enum CodingKeys: String, CodingTableKey {

        typealias Root = LoginUserModel

        //List the properties which should be bound to table
        case uid
        case nickname
        case portrait
        //    ....
        static let objectRelationalMapping = TableBinding(CodingKeys.self)

        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                .uid: ColumnConstraintBinding(isUnique: true)
            ]
        }
    }
}



//使用HandyJSON: 遵从HandyJSON 协议
//class UserModel22: HandyJSON {
//    var uid: Int?
//    var gender: Int?
//    var nickname: Int?
//    var portrait: String?
//    required init() {}
//}
