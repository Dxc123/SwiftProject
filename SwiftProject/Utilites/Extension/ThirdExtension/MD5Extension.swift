//
//  MD5Extension.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/6/8.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import CommonCrypto

//extension String {
////    MD5加密
//    func md5() -> String {
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//
//        CC_MD5(str!, strLen, result)
//
//        let hash = NSMutableString()
//        for i in 0 ..< digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        result.deinitialize()
//
//        return String(format: hash as String)
//    }
//}
