//
//  CJKTAPI.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/11.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import Moya
//接口列表和不同的接口的一些配置

//创建一个API的枚举，枚举值是接口名， 并创建遵守TargetType协议的extention

/// 定义基础域名
let u17_baseURL  = "http://app.u17.com/v3/appV3_3/ios/phone"
let gank_baseURL = "https://gank.io/api/v2"
//
// page/1/count/10
enum CJKTAPI {
    case cateList//u17 分类列表
    case textAPi2(para1: String,para2: String)
    case textAPi3(dict: [String: Any])//传入参数字典
//
    case girl(page: Int,count: Int)//获取妹纸列表
   
    
}

extension CJKTAPI: TargetType{
///   设置baseURL
    var baseURL: URL {
//        return URL.init(string: "")
        switch self {
        case .cateList:
            return URL.init(string:u17_baseURL)!
        case .girl:
        return URL.init(string:gank_baseURL)!
        default:
            return URL.init(string:(u17_baseURL))!
        }
    }
    
    
///   设置不同接口的路径
    var path: String {
         switch self {
                case .cateList:
                    return "sort/mobileCateList"
                case .textAPi2(let para1, let para2):
                    return "\(para1)/news/latest/(\(para2)"
                case .textAPi3:
                    return "4/news/latest"
            
                case .girl(page: let page, count: let count):
//                    https://gank.io/api/v2/data/category/Girl/type/Girl/page/1/count/10
                return "data/category/Girl/type/Girl/page/\(page)/count/\(count)"
            
            }

       
    }
/// 请求方式 get post
    var method: Moya.Method {
         switch self {
               case .cateList:
                   return .post
               default:
                   return .get
               }
    }
    
///  这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
    var sampleData: Data {
         return "".data(using: String.Encoding.utf8)!
    }
///  该条请API求的方式,把参数之类的传进来
    var task: Task {
        var parmeters: [String : Any] = [:]
         switch self {
               case .textAPi2(let email, let password):
                    parmeters["email"] = email
                    parmeters["password"] = password
                
               case let .textAPi3(parametersDict):
                   return .requestParameters(parameters: parametersDict, encoding: URLEncoding.default)
            
               default: break
            
               }
               return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
/// 设置请求头header
    var headers: [String : String]? {
//        return ["Content-Type":"application/x-www-form-urlencoded"]
        return nil
    }
    
    
}
