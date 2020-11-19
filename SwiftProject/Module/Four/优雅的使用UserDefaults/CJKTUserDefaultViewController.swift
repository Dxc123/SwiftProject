//
//  CJKTUserDefaultViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/11/13.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
class CJKTUserDefaultViewController: CJKTBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

// 使用SwiftyUserDefaults
//        set
         Defaults[\.username] = "小明"
//        get
        
        let username = Defaults[\.username]
        kLog("username= \(String(describing: username))")
        
//        修改
        Defaults[\.launchCount] += 1
        kLog("username= \(String(describing: Defaults[\.launchCount]))")
        
//        使用和修改类型化数组
//        Defaults[\.libraries].append("SwiftyUserDefaults")
//        Defaults[\.libraries][0] += " 2.0"
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK:-- 定义要储存的Key
extension DefaultsKeys {
    var username: DefaultsKey<String?> { .init("username") }
    var launchCount: DefaultsKey<Int> { .init("launchCount", defaultValue: 0) }
//    var libraries: DefaultsKey<[String]> { .init("libraries") }
    var color: DefaultsKey<String?> { .init("color",defaultValue: "") }
}
