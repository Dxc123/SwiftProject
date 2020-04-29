//
//  CJKTFourViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class CJKTFourViewController: CJKTBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.barStyle(.clear)
        navigationItem.title = "我的"
        
    }
    
    override func configNavigationBar() {
            super.configNavigationBar()
            navigationController?.barStyle(.clear)
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
