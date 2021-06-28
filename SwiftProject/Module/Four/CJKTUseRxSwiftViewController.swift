//
//  CJKTUseRxSwiftViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2021/6/24.
//  Copyright © 2021 Dxc_iOS. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
extension Notification.Name  {
    static let kName = "Name"
}
class CJKTUseRxSwiftViewController: CJKTBaseViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.rx.notification(<#T##name: Notification.Name?##Notification.Name?#>)
        
 
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
