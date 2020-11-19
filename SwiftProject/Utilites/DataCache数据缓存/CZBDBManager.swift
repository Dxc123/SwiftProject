//
//  CZBDBManager.swift
//  CZBDataPersistence
//
//  Created by 边智峰 on 2018/11/8.
//  Copyright © 2018 边智峰. All rights reserved.
//https://github.com/bianzhifeng/CZBDataStorge
//WCDB数据库存储
import Foundation
import WCDBSwift

internal class DBManager {
    
    /// database路径
    private static let databasePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    /// 命名空间
    private static let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
    
    ///单例
    internal static let shared = DBManager()
    private init() { }
    
    /// 创建/获取数据库
    internal static func creatDatabase(name: String) -> Database {
        let database = Database(withPath: databasePath + "/" + namespace + "/" + name + ".db")
        return database
    }
}

extension DBManager {
    
    /// 插入操作
    ///
    /// - Parameters:
    ///   - object: 要插入的对象
    ///   - propertyConvertibleList: 部分插入? 例如 Sample.Properties.identifier
    ///   - databaseName: 用来获取或创建 database
    /// - Returns: 是否成功
    internal func insert<Object: TableCodable>(
        with objects: [Object],
        on propertyConvertibleList: [PropertyConvertible]? = nil,
        with databaseName: String) -> Bool {
        
        let database = DBManager.creatDatabase(name: databaseName)
        
        do {
            try database.create(table: "\(Object.self)",
                of: Object.self)
            try database.insert(objects: objects,
                                on: propertyConvertibleList,
                                intoTable: "\(Object.self)")
            return true
        } catch let error {
            print(error)
            return false
        }
    }
    
    /// 插入操作(如果已经存在那么替换)
    ///
    /// - Parameters:
    ///   - object: 要插入的对象
    ///   - propertyConvertibleList: 部分插入? 例如 Sample.Properties.identifier
    ///   - databaseName: 用来获取或创建 database
    /// - Returns: 是否成功
    internal func insertOrReplace<Object: TableCodable>(
        with objects: [Object],
        on propertyConvertibleList: [PropertyConvertible]? = nil,
        with databaseName: String) -> Bool {
        
        let database = DBManager.creatDatabase(name: databaseName)
        do {
            try database.create(table: "\(Object.self)",
                of: Object.self)
            try database.insertOrReplace(objects: objects,
                                         on: propertyConvertibleList,
                                         intoTable: "\(Object.self)")
            return true
        } catch let error {
            print(error)
            return false
        }
    }
    
    /// 删除操作 如只设置表名 表示需要删除整个表的数据,当时不会删除表本身
    ///
    /// - Parameters:
    ///   - databaseName: 用来获取或创建 database
    ///   - tableName: 表名
    ///   - condition: 符合删除的条件
    ///   - orderList: 排序的方式
    ///   - limit: 删除的个数
    ///   - offset: 从第几个开始删除
    ///   - Returns: 是否删除成功
    internal func delete(with databaseName: String,
                         from tableName: String,
                         where condition: Condition? = nil,
                         orderBy orderList: [OrderBy]? = nil,
                         limit: Limit? = nil,
                         offset: Offset? = nil) -> Bool {
        
        let database = DBManager.creatDatabase(name: databaseName)
        do {
            try database.delete(fromTable: tableName,
                                where: condition,
                                orderBy: orderList,
                                limit: limit,
                                offset: offset)
            return true
        } catch let error {
            print(error)
            return false
        }
    }
    
    /// 删除表
    ///
    /// - Parameters:
    ///   - databaseName: 用来获取或创建 database
    ///   - tableName: 要删除的表名
    /// - Returns: 是否成功
    internal static func deleteTable(with databaseName: String,
                                     from tableName: String) -> Bool {
        
        let database = creatDatabase(name: databaseName)
        do {
            try database.drop(table: tableName)
            return true
        } catch let error {
            print(error)
            return false
        }
    }
    
    /// 删除数据库
    ///
    /// - Parameter databaseName: 数据库名称
    /// - Returns: 是否删除成功
    internal static func deleteDatabase(with databaseName: String) -> Bool {
        do {
            try FileManager.default.removeItem(atPath: databasePath + "/" + namespace + "/" + databaseName + ".db")
            return true
        } catch  {
            return false
        }
    }
    
    /// 更新操作
    ///
    /// - Parameters:
    ///   - databaseName: 用来获取database
    ///   - tableName: 表名
    ///   - propertyConvertibleList: 要修改的字段
    ///   - object: 根据这个object得内容修改
    ///   - condition: 符合修改的条件
    ///   - orderList: 排序方式
    ///   - limit: 删除的个数
    ///   - offset: 从第几个开始删除
    /// - Returns: 是否更新成功
    internal func update<Object: TableCodable>(
        with databaseName: String,
        from tableName: String,
        on propertyConvertibleList: [PropertyConvertible],
        with object: Object,
        where condition: Condition? = nil,
        orderBy orderList: [OrderBy]? = nil,
        limit: Limit? = nil,
        offset: Offset? = nil) -> Bool {
        
        let database = DBManager.creatDatabase(name: databaseName)
        do {
            try database.update(table: tableName,
                                on: propertyConvertibleList.isEmpty ? Object.Properties.all : propertyConvertibleList,
                                with: object,
                                where: condition,
                                orderBy: orderList,
                                limit: limit,
                                offset: offset)
            return true
        } catch let error {
            print(error)
            return false
        }
    }
    
    /// 获取数据
    ///
    /// - Parameters:
    ///   - databaseName: 用来获取database
    ///   - tableName: 表名
    ///   - propertyConvertibleList: 构成部分获取的方式 要获取的字段
    ///   - condition: 符合获取的条件
    ///   - orderList: 排序方式
    ///   - limit: 获取的个数
    ///   - offset: 从第几个开始获取
    /// - Returns: 结果
    internal func get<Object: TableCodable>(
        with databaseName: String,
        from tableName: String,
        on propertyConvertibleList: [PropertyConvertible] = [],
        where condition: Condition? = nil,
        orderBy orderList: [OrderBy]? = nil,
        limit: Limit? = nil,
        offset: Offset? = nil) -> [Object]? {
        
        let database = DBManager.creatDatabase(name: databaseName)
        
        let object: [Object]? = try? database.getObjects(
            on: propertyConvertibleList.isEmpty ? Object.Properties.all : propertyConvertibleList,
            fromTable: tableName,
            where: condition,
            orderBy: orderList,
            limit: limit,
            offset: offset)
        return object
        
    }
    
    /// 获取value
    ///
    /// - Parameters:
    ///   - databaseName: 用来获取database
    ///   - tableName: 表名
    ///   - propertyConvertible: 获取哪个字段?
    ///   - condition: 符合获取的条件
    ///   - orderList: 排序方式
    ///   - limit: 获取的个数
    ///   - offset: 从第几个开始获取
    /// - Returns: 结果
    internal func getValue(with databaseName: String,
                           from tableName: String,
                           on propertyConvertible: ColumnResultConvertible,
                           where condition: Condition? = nil,
                           orderBy orderList: [OrderBy]? = nil,
                           limit: Limit? = nil,
                           offset: Offset? = nil) -> FundamentalValue? {
        let database = DBManager.creatDatabase(name: databaseName)
        let value = try? database.getValue(on: propertyConvertible,
                                           fromTable: tableName,
                                           where: condition,
                                           orderBy: orderList,
                                           limit: limit,
                                           offset: offset)
        return value
    }
    
    
    /// 开启事务
    ///
    /// - Parameters:
    ///   - databaseName: 数据库名称
    ///   - transaction: 事务执行模块
    internal static func run(with databaseName: String, transaction: () -> Void) {
        let database = creatDatabase(name: databaseName)
        try? database.run(transaction: transaction)
    }
    
    /// 数据库设置密码
    ///
    /// - Parameters:
    ///   - databaseName: 数据库名称
    ///   - optionalKey: 密码
    internal static func setCipher(with databaseName: String, key optionalKey: Data?) {
        let database = creatDatabase(name: databaseName)
        database.setCipher(key: optionalKey)
    }
}
/**
 使Model直接操作数据库:
 
 class SampleTest: CZBDbManagerProtocol, TableCodable {

     var identifier: Int? = nil
     var description: String? = nil
     var offset: Int = 0
     var debugDescription: String? = nil

     enum CodingKeys: String, CodingTableKey {
         typealias Root = SampleTest
     static let objectRelationalMapping =
         TableBinding(CodingKeys.self)
         case identifier = "id"
         case description
         case offset = "db_offset"
     }
 }
1. 插入一条数据
 注: 如想监听插入是否成功, 可接收返回值 true为成功 false 为失败.

 let sample = SampleTest()
 sample.identifier = 10
 sample.description = "这是一个测试用例"
 sample.offset = 2
 //把sample插入到数据库中
 sample.insert()
a. 插入一条数据(如已存在会被替换):
 sample.insertOrReplace()
 
 b.批量插入:
 数组直接调用insert()执行批量插入操作, 需要数组中的Element遵守CZBDbManagerProtocol协议才能使用批量插入方法.

 例:
 [SampleTest(), SampleTest()].insert()
 批量插入(如已存在会被替换):
 [SampleTest(), SampleTest()].insertOrReplace()
 
 2.删除操作
 参数注释: where: 判断语句 删除符合规定条件的结果 orderBy: 把符合条件的结果按照identifier降序排列 limit: 删除几行 offset: 从第几行开始删除 Returns: 是否删除成功

 这个函数做了什么呢? 获取SampleTest表中description为"这是一个测试用例"的数据集, 按identifier降序排列后的从第2行开始删除10条数据.

 SampleTest.delete(where:
 SampleTest.Properties.description.like("这是一个测试用例"),
 orderBy: [SampleTest.Properties.identifier.asOrder(by: .descending)],
 limit: 10,
 offset: 1)
 当然, 如果你只想删除表下边的所有数据你可以直接执行delete()

 SampleTest.delete()
 
 删除表
 Returns: 是否删除成功
 SampleTest.deleteTable()
 删除数据库
 Returns: 是否删除成功

 SampleTest.deleteDatabase()
 
 */





