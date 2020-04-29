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



//gank.io


struct GrilModel: HandyJSON {
    var page: Int = 0
    var page_count: Int = 0
    var status: Int = 0
    var total_counts: Int = 0
    var data: [GrilListModel]?
    
}

struct GrilListModel: HandyJSON {
    var title: String?
    var likeCounts: Int = 0
    var desc: String?
    var url: String?
    
}
/**
"data": [],
"page": 1,
"page_count": 7,
"status": 100,
"total_counts": 68
*/
/**
 {
   "stars" : 1,
   "category" : "Girl",
   "title" : "第68期",
   "url" : "http:\/\/gank.io\/images\/4817628a6762410895f814079a6690a1",
   "likeCounts" : 0,
   "author" : "鸢媛",
   "createdAt" : "2020-04-27 08:00:00",
   "desc" : "相似的人适合玩闹\/互补的人才能终老。 ​​​​",
   "_id" : "5e958faf808d6d2fe6b56ecb",
   "views" : 52,
   "type" : "Girl",
   "publishedAt" : "2020-04-27 08:00:00",
   "images" : [
     "http:\/\/gank.io\/images\/4817628a6762410895f814079a6690a1"
   ]
 },
 */
