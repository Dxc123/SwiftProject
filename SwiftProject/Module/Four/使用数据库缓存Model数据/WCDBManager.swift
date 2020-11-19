//
//  WCDBManager.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/11/13.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import Foundation
import WCDBSwift


enum DBTable: String {
    case loginUser = "loginUserData"
    case gift = "giftData"
    //   .......
}

struct WCDBManager {
    static let shared = WCDBManager()
    
    private let databaseFileName = "my.database"
    
    private let pathToDatabase: String
    fileprivate var database: Database
    
    init() {
        
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        pathToDatabase = documentsDirectory + "/\(databaseFileName)"
//        创建名称为my.database的数据库
        database = Database(withPath: pathToDatabase)
    }
    
    // MARK：--创建对应存储表
    func createDatabase() {
        WCDBManager.shared.createDatabase(table: .loginUser, type: LoginUserModel.self)
        WCDBManager.shared.createDatabase(table: .gift, type: GiftModel.self)
//        .......
        print("开启数据库成功")
    }
        
 //    MARK: 创建对应类型的表
    func createDatabase<T: TableDecodable>(table: DBTable, type: T.Type) {
        
        do {
            try database.create(table: table.rawValue, of: type)
        } catch {
            print(error)
        }
    }
//    MARK: 保存一个object对象
    func insert<T: TableEncodable>(object: T, for table: DBTable, canReplace: Bool = false) {
    
        do {

            if canReplace {
               try database.insertOrReplace(objects: object, intoTable: table.rawValue)
            } else {
                try database.insert(objects: object, intoTable: table.rawValue)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
 //    MARK: 保存一个object数组
    func insert<T: TableEncodable>(objects: [T], for table: DBTable, canReplace: Bool = false) {
        
        do {
            if canReplace {
                try database.insertOrReplace(objects: objects, intoTable: table.rawValue)
            } else {
                try database.insert(objects: objects, intoTable: table.rawValue)
            }
        } catch {
            print("DB insert error: " + error.localizedDescription)
        }
    }
// MARK:-- 删除某个表
    func delete(for table: DBTable, condition: Condition?) {
        do {
            try database.delete(fromTable: table.rawValue, where: condition)
        } catch {
            print(error.localizedDescription)
        }
    }
// MARK:-- 更新某个表的数据
    func update<T: TableEncodable>(object: T, for table: DBTable, properties: PropertyConvertible, condtion: Condition?) {
        do {
            try database.update(table: table.rawValue, on: properties, with: object, where: condtion)
        } catch {
            print(error.localizedDescription)
        }
    }
// MARK:--  getObject数据
    func getObject<T: TableDecodable>(for table: DBTable, type: T.Type, condition: Condition?) -> T? {
        
        do {
            let object: T? = try database.getObject(fromTable: table.rawValue, where: condition)
            return object
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
 // MARK:--  get数组数据
    func getObjects<T: TableDecodable>(for table: DBTable, condition: Condition?) -> [T] {
        do {
            let objects: [T] = try database.getObjects(fromTable: table.rawValue, where: condition)
            return objects
        } catch {
            print("DB get objects error: " + error.localizedDescription )
            return []
        }
    }
    
    
    
    func insertDataArr<T: TableEncodable>(object: [T], for table: DBTable, canReplace: Bool = false) {
    
        do {
            if canReplace {
               try database.insertOrReplace(objects: object, intoTable: table.rawValue)
            } else {
                try database.insert(objects: object, intoTable: table.rawValue)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Close database
    func closeDatabase() {
            database.close()
        }
}



// +----------------------------------------------------------------------
// 登录后保存登录者信息
// +----------------------------------------------------------------------
extension WCDBManager {
    //MARK:--setter登录者信息
    func addLoginUser(model: LoginUserModel) {
        insert(object: model, for: .loginUser, canReplace: true)
    }
    //MARK:--getter登录者信息
    func getLoginUserInfo() -> LoginUserModel? {
         getObject(for: .loginUser, type: LoginUserModel.self, condition: nil)
    }

    //MARK:--delete登录者信息
    func deleteLoginUserInfo() {
        delete(for: .loginUser, condition: nil)
    }
}

// +----------------------------------------------------------------------
// 保存/删除登礼物数组信息
// +----------------------------------------------------------------------
extension WCDBManager {

    func addgiftDatas(model: [GiftModel]) {
//        insertDataArr(object: giftData, for: .giftData)
        insert(objects: model, for: .gift)
    }

    func removeGiftsData() {
        delete(for: .gift, condition: nil)
    }

    func getGiftsData() -> [GiftModel] {
        return getObjects(for: .gift, condition: nil)
    }

}
