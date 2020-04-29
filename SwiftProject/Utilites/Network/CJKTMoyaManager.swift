//
//  CJKTMoyaConfig.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/11.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import Foundation
import Moya
import HandyJSON
import MBProgressHUD



//HUD插件
let LoadingPlugin = NetworkActivityPlugin { (type, target) in
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
let LoggerPlugin = NetworkLoggerPlugin(verbose: true, responseDataFormatter:JSONResponseDataFormatter)


//设置超时
let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<CJKTAPI>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

//定义一个全局变量MoyaProvider
let CJKTMoyaProvider = MoyaProvider<CJKTAPI>(requestClosure: timeoutClosure)
let CJKTMoyaProvider2 = MoyaProvider<CJKTAPI>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])

let CJKTMoyaManager = MoyaProvider<CJKTAPI>(requestClosure: timeoutClosure, plugins: [LoadingPlugin,LoggerPlugin])

let CJKTMoyaManager2 = MoyaProvider<CJKTAPI>(requestClosure: timeoutClosure, manager: defaultAlamofireManager(), plugins: [LoadingPlugin,LoggerPlugin])

//#if DEBUG
//
//#endif



extension MoyaProvider {
    @discardableResult
    open func request<T: HandyJSON>(_ target: Target,
                                    model: T.Type,
                                    completion: ((_ returnData: T?) -> Void)?) -> Cancellable? {
        
        return request(target, completion: { (result) in
            guard let completion = completion else { return }
            guard let returnData = try? result.value?.mapModel(ResponseData<T>.self) else {
                completion(nil)
                return
            }
            
            
            
            completion(returnData.data?.returnData)
        })
    }
}


extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        
        let jsonString = String(data: data, encoding: .utf8)
//        print("requestURL = \(String(describing: request?.url))"+"\(String(describing: request?.httpBody))");
        
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        
        return model
    }
}



// MARK: - private 格式化JSONResponseData

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
         //JSONSerialization.WritingOptions.prettyPrinted 是输出JSON时的格式更容易查看。
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}


// MARK: - https免证书实现以及校验证书部分
 public func defaultAlamofireManager() -> Manager {
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
