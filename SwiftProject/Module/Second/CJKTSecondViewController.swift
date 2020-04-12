//
//  CJKTSecondViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
class CJKTSecondViewController: CJKTBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    private func loadData() {
//        CJKTMoyaManager.request(CJKTAPI.cateList) { (result) in
//
//               }
        
//        CJKTMoyaManager.request(CJKTAPI.cateList, model: CateListModel.self) { (returnData) in
////            CJKTLog("returnData = \(String(describing: returnData))")
//        }
        
       
        CJKTMoyaAPIProvider2.request(CJKTAPI.cateList) { (result) in
             if case let .success(response) = result {
                
        //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                CJKTLog("json = \(json)")
//                if let mappedObject = JSONDeserializer<CateListModel>.deserializeFrom(json: json.description) {
//                        self.homevipData = mappedObject
//                        self.focusImages = mappedObject.focusImages?.data
//                        self.categoryList = mappedObject.categoryContents?.list
//                 }
                }
           
        }
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
