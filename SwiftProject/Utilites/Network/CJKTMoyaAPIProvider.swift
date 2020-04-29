//
//  CJKTMoyaAPIProvider.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/12.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import Foundation
import Moya
import HandyJSON
import MBProgressHUD

//HUD插件
let loadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = topVC else { return }
    switch type {
    case .began://("显示loading")
        MBProgressHUD.hide(for: vc.view, animated: false)
        MBProgressHUD.showAdded(to: vc.view, animated: true)
    case .ended://("隐藏loading")
        MBProgressHUD.hide(for: vc.view, animated: true)
    }
}

//日志插件
let loggerPlugin = NetworkLoggerPlugin(verbose: true, responseDataFormatter:JSONResponseDataFormatter)

//设置超时
let timeoutClosures = {(endpoint: Endpoint, closure: MoyaProvider<CJKTAPI>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}





//定义一个全局变量MoyaProvider

let CJKTMoyaAPIProvider = MoyaProvider<CJKTAPI>(requestClosure: timeoutClosures, plugins: [loadingPlugin,loggerPlugin])

let CJKTMoyaAPIProvider1 = MoyaProvider<CJKTAPI>(requestClosure: timeoutClosures, plugins: [loadingPlugin])

let CJKTMoyaAPIProvider2 = MoyaProvider<CJKTAPI>(requestClosure: timeoutClosures)

let CJKTMoyaAPIProvider3 = MoyaProvider<CJKTAPI>(requestClosure: timeoutClosure, manager: AlamofireManager(), plugins: [LoadingPlugin,LoggerPlugin])



// MARK: - private 格式化JSONResponseData

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
//        JSONSerialization.WritingOptions.prettyPrinted 
//        生成的json字符串是带换行和缩进的，更加易读
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}


// MARK: - https免证书实现以及校验证书部分
 public func AlamofireManager() -> Manager {
//    let configuration = URLSessionConfiguration.default
//    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//    //获取本地证书
//    let path: String = Bundle.main.path(forResource: "证书名", ofType: "cer")!
//    let certificateData = try? Data(contentsOf: URL(fileURLWithPath: path)) as CFData
//    let certificate = SecCertificateCreateWithData(nil, certificateData!)
//    let certificates :[SecCertificate] = [certificate!]
//
//    let policies: [String: ServerTrustPolicy] = [
//        "域名" : .pinCertificates(certificates: certificates, validateCertificateChain: true, validateHost: true)
//    ]
//    let manager = Alamofire.SessionManager(configuration: configuration,serverTrustPolicyManager: ServerTrustPolicyManager(policies: policies))
//    return manager
    
    let manager: Manager = MoyaProvider<MultiTarget>.defaultAlamofireManager()
    manager.delegate.sessionDidReceiveChallenge = {
            session,challenge in
            return    (URLSession.AuthChallengeDisposition.useCredential,URLCredential(trust:challenge.protectionSpace.serverTrust!))
    }
    return manager
}



//字典拼接基础参数(如token,手机版本信息)（选用）
func appendBaseParamaters(parameters:[String:Any]) -> [String:Any] {
    
    var result:[String:Any] = parameters
    for (key,value) in Moya_Baseparameters {
        result[key] = value
         }
//    for (key,value) in parameters {
//           result?[key] = value
//        }
    return result
}


//获取设备信息
//ios版本
let systemVersion : String = UIDevice.current.systemVersion// e.g. @"4.0"
//设备udid
//let identifierNumber  = UIDevice.current.identifierForVendor//UUID
//设备uuid
let uuid = UIDevice.current.identifierForVendor!.uuidString
//设备名称
let deviceName : String = UIDevice.current.name// e.g. @"iOS"
//系统名称
let systemName : String = UIDevice.current.systemName
//设备型号
let model = UIDevice.current.model//e.g. @"iPhone", @"iPod touch"
//设备区域化型号如A1533
let localizedModel = UIDevice.current.localizedModel

//获取app当前版本号
let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String



let Moya_Baseparameters = [
//"xt": Int32(Date().timeIntervalSince1970),//当前时间
"idfa": uuid,

    ] as [String : Any]



