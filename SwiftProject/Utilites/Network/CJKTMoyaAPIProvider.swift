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





// MARK: - private 格式化JSONResponseData

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}
