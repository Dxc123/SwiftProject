//
//  CJKTBaseModel.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import HandyJSON
//封装的基础model类
//自定义的model继承此model即可省去了每次都要引入 “import HandyJSON” ，以及每次都要实现“required init() {}”方法，子类如果要自定义解析规则，重写mapping方法即可

// 使用HandyJSON：Model定义时要声明服从HandyJSON协议,实现一个空的init方法


class CJKTBaseModel: HandyJSON {
    required init(){}
    func mapping(mapper: HelpingMapper) {
        //自定义解析规则，日期数字颜色，如果要指定解析格式，子类实现重写此方法即可
        //        mapper <<<
        //            date <-- CustomDateFormatTransform(formatString: "yyyy-MM-dd")
        //
        //        mapper <<<
        //            decimal <-- NSDecimalNumberTransform()
        //
        //        mapper <<<
        //            url <-- URLTransform(shouldEncodeURLString: false)
        //
        //        mapper <<<
        //            data <-- DataTransform()
        //
        //        mapper <<<
        //            color <-- HexColorTransform()

    }
}



