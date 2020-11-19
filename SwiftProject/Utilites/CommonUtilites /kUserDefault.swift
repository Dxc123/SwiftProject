//
//  kUserDefaults2.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/11/8.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import Foundation
class kUserDefault: NSObject {
    
// +----------------------------------------------------------------------
// | set方法
// +----------------------------------------------------------------------
   class  func setkey(_ value: Any?, key: String){
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
   class func setBool(_ value: Bool, key: String){
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
// +----------------------------------------------------------------------
// | get方法
// +----------------------------------------------------------------------

   class func getKey(_ key: String) ->Any?{
       return UserDefaults.standard.object(forKey: key)
        
    }
    
   class func getBool(_ key: String) ->Bool{
       return UserDefaults.standard.bool(forKey: key)
        
    }
    

   class func getArray(_ key: String) ->[Any]?{
          return UserDefaults.standard.array(forKey: key)
           
       }

   class func getDictionary(_ key: String) ->[String : Any]?{
        return UserDefaults.standard.dictionary(forKey: key)
    }
    
}
