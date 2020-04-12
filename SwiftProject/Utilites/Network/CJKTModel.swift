//
//  CJKT.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/11.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import HandyJSON
//数据格式
//{
//"code": 1,
//"data": {
//"stateCode": 1,
//"message": "成功",
//"returnData": {}
//}
//}

//最外层Model
struct ResponseData<T: HandyJSON>: HandyJSON {
    var code: Int = 0
    var data: ReturnData<T>?
}

struct ReturnData<T: HandyJSON>: HandyJSON {
    var message:String?
    var returnData: T?
    var stateCode: Int = 0
}


//分类
struct CateListModel: HandyJSON {
    var recommendSearch: String?
    var rankingList:[RankingModel]?
    var topList:[TopModel]?
}

struct TopModel: HandyJSON {
    var sortId: Int = 0
    var sortName: String?
    var cover: String?
    var extra: TopExtra?
    var uiWeight: Int = 0
}

struct TopExtra: HandyJSON {
    var title: String?
    var tabList: [TabModel]?
}

struct TabModel: HandyJSON {
    var argName: String?
    var argValue: Int = 0
    var argCon: Int = 0
    var tabTitle: String?
}

struct RankingModel: HandyJSON {
    var argCon: Int = 0
    var argName: String?
    var argValue: Int = 0
    var canEdit: Bool = false
    var cover: String?
    var isLike: Bool = false
    var sortId: Int = 0
    var sortName: String?
    var title: String?
    var subTitle: String?
    var rankingType: Int = 0
}

