//
//  CJKTCustomAlertViewViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/11/16.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class CJKTCustomAlertViewViewController: CJKTBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let popView  =  CustomPopView.init(showPopType: .bottom)
        popView.showView(view: kkeyWindow!)
                
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
