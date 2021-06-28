//
//  CJKTUesRSwiftViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/11/8.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class CJKTUesRSwiftViewController: CJKTBaseViewController {
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.gray
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.textAlignment = .center
        lab.numberOfLines = 0
        return lab
    }()
    private lazy var clickedBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect.zero
        btn.backgroundColor = UIColor.clear.withAlphaComponent(1)
        btn.setTitle("妹子", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action:#selector(btnAction(_:)), for: .touchUpInside)
        return btn
    }()
   @objc func btnAction(_ button: UIButton){
    }
    private lazy var starBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect.init(x: 10, y: 100, width: 50, height: 50)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//       R.swift-优雅地引用项目资源
//        1、 图片-images
       
        let img = R.image.add_friends_banner
//        2.文件-Files
        
        let endVoice = Bundle.main.path(forResource: "endVoice", ofType: "wav")
        let endVoice222 = R.file.endVoiceWav

//        3.Localized strings
//        let click = NSLocalizedString("welcome.message", comment: "")
        let click22 = R.string.infoPlist.welcomeMessage.key
        titleLab.frame = CGRect.init(x: 100, y: 200, width: 200, height: 40)
        view.addSubview(titleLab)
        titleLab.text = click22
        
        
        
//        4.Nib
//        let customViewNib = UINib(nibName: "CustomView", bundle: nil)
//        let customViewNib = R.nib.customView()
        UserDefaults.standard.set(2, forKey: "key")
        UserDefaults.standard.synchronize()
        let valu: Int =  UserDefaults.standard.object(forKey: "key") as! Int
        kLog("valu  = \(valu)")
        
        kUserDefault.setkey(22, key: "key222")
        kLog("valu22  = \(String(describing: kUserDefault.getKey( "key222")))")
//        Date.sf_getDay(<#T##self: Date##Date#>)
//        Date.sf_getMilliSeconds
//        kPostNoti(<#T##name: NSNotification.Name##NSNotification.Name#>, <#T##object: Any?##Any?#>)
//        kUserDefaultsGetKey(<#T##key: String##String#>)
        
//        view.addSubview(starBtn)
//        starBtn.asStarFavoriteButton(pointSize: 16, weight: .semibold, scale: .default, fillColor: .red)
        
        
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
