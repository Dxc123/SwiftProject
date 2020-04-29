//
//  CJKTJsonUtil.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import HandyJSON


class CJKTJsonUtil: NSObject {
    /**
        *  Json转对象
        */
       static func jsonToModel(_ jsonStr:String,_ modelType:HandyJSON.Type) ->CJKTBaseModel {
           if jsonStr == "" || jsonStr.count == 0 {
               #if DEBUG
                   print("jsonoModel:字符串为空")
               #endif
               return CJKTBaseModel()
           }
           return modelType.deserialize(from: jsonStr)  as! CJKTBaseModel
           
       }
       
       /**
        *  Json转数组对象
        */
       static func jsonArrayToModel(_ jsonArrayStr:String, _ modelType:HandyJSON.Type) ->[CJKTBaseModel] {
           if jsonArrayStr == "" || jsonArrayStr.count == 0 {
               #if DEBUG
                   print("jsonToModelArray:字符串为空")
               #endif
               return []
           }
           var modelArray:[CJKTBaseModel] = []
           let data = jsonArrayStr.data(using: String.Encoding.utf8)
           let peoplesArray = try! JSONSerialization.jsonObject(with:data!, options: JSONSerialization.ReadingOptions()) as? [AnyObject]
           for people in peoplesArray! {
               modelArray.append(dictionaryToModel(people as! [String : Any], modelType))
           }
           return modelArray
           
       }
    /**
     *  字典转对象
     */
    static func dictionaryToModel(_ dictionStr:[String:Any],_ modelType:HandyJSON.Type) -> CJKTBaseModel {
        if dictionStr.count == 0 {
            #if DEBUG
                print("dictionaryToModel:字符串为空")
            #endif
            return CJKTBaseModel()
        }
        return modelType.deserialize(from: dictionStr) as! CJKTBaseModel
    }
    
    /**
     *  对象转JSON
     */
    static func modelToJson(_ model:CJKTBaseModel?) -> String {
        if model == nil {
            #if DEBUG
                print("modelToJson:model为空")
            #endif
             return ""
        }
        return (model?.toJSONString())!
    }
    
    /**
     *  对象转字典
     */
    static func modelToDictionary(_ model:CJKTBaseModel?) -> [String:Any] {
        if model == nil {
            #if DEBUG
                print("modelToJson:model为空")
            #endif
            return [:]
        }
        return (model?.toJSON())!
    }
    

}
