//
//  LoginManager.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/11/16.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class LoginManager: NSObject {
//    MARK:-- 登录成功后，创建WCDB数据库
     class func createDateBase() {
        WCDBManager.shared.createDatabase()
    }

}
