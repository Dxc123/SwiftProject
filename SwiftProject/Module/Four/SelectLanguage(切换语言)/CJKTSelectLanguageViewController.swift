//
//  CJKTSelectLanguageViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/11/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD
import SwiftyAttributes
class CJKTSelectLanguageViewController: CJKTBaseViewController {
   public var defaultSelectIndex: NSInteger?
    lazy var titles: [String] = {
           return ["English",
                   "Arabic",
                   "Indonesia",
                   "Hindi",
                   "Turkish",
                   "Chinese"
           ]
       }()
    lazy var tableView: UITableView = {
        let tab = UITableView.init(frame: CGRect.zero, style: .plain)
        tab.backgroundColor = UIColor.white
        tab.delegate = self
        tab.dataSource = self
        tab.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tab.register(selectLanguageCell.self, forCellReuseIdentifier: "selectLanguageCell")
        tab.tableFooterView = UIView.init()
        return tab
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSelectIndex = 0
        self.title = "Language"
        navigationController?.isNavigationBarHidden = false
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        tableView.selectRow(at: IndexPath.init(row: getIndex(), section: 0), animated: true, scrollPosition: .top)
    }
    
    func getIndex() -> Int{
        if let userLanguage = UserDefaults.standard.value(forKey: kUserLanguage) as? String   {
            var index: Int = 0
            if userLanguage.hasPrefix("en") {
                index = 0
            }else if userLanguage.hasPrefix("ar") {
                index = 1
            }else if userLanguage.hasPrefix("id") {
                index = 2
            }else if userLanguage.hasPrefix("tr") {
                index = 3
            }else if userLanguage.hasPrefix("hi") {
                index = 4
            }else if userLanguage.hasPrefix("zh") {
                index = 5
            }
            return  index
          }
         return  0
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
extension CJKTSelectLanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "selectLanguageCell",for: indexPath) as! selectLanguageCell
            cell.titleLab.text = titles[indexPath.row]

//            if (tableView.delegate?.responds(to: Selector.init(("didSelectRowAt:"))))! {
//                tableView.delegate?.tableView?(self.tableView, didSelectRowAt: NSIndexPath.init(row: defaultSelectIndex!, section: 0) as IndexPath)
//              }
            return cell
            
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        kLog("点击了 \(indexPath.row)")
        seletLanguageAction(index: indexPath.row)
    }
    
    func seletLanguageAction(index: Int) {
        
      if index == 0 {//英语
         LocalizationManger.shareManger.setUserLanguage(language: "en")

      }else if index == 1{//阿拉伯
        LocalizationManger.shareManger.setUserLanguage(language: "ar")

      }
      else if index == 2 {// 印尼
        LocalizationManger.shareManger.setUserLanguage(language: "id")
      }
      else if index == 3 {//印度
         LocalizationManger.shareManger.setUserLanguage(language: "hi")
        
      }
      else if index == 4 {//土耳其
         LocalizationManger.shareManger.setUserLanguage(language: "tr")
      }else{
        LocalizationManger.shareManger.setUserLanguage(language: "zh-Hans")
      }
        APPConfig.setAPPDirection()
        UserDefaults.standard.set(true, forKey: kIsSetLanguage)
        UserDefaults.standard.synchronize()
        
//            重新设置rootViewController

        let tabVC = CJKTBaseTableViewController()
     
        kHUD.showLoadingHud(message: "Setting Language...")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1, execute: {
            UIView.animate(withDuration: 1.5, animations: {
                kHUD.hideHud()
                kkeyWindow?.rootViewController =  tabVC
            })

          })
        //切换语言，发送通知(刷新需要改变的 UI布局)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ChangedUserLanguageNotification.rawValue), object: nil)
        
   }

}




////////////////////////////
class selectLanguageCell: UITableViewCell {
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.textColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
        lab.font = UIFont.boldSystemFont(ofSize: 15)
        lab.textAlignment = .natural
        lab.numberOfLines = 0
        return lab
    }()
    lazy var iconImgV: UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .scaleAspectFit
        img.image = kIMAGE("icon_opinionsFalse")
        return img
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {
        contentView.addSubview(titleLab)
        contentView.addSubview(iconImgV)
        titleLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(150)
        }
        iconImgV.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            titleLab.textColor = #colorLiteral(red: 1, green: 0.3450980392, blue: 0.3450980392, alpha: 1)
            iconImgV.image = kIMAGE("icon_opinionsTrue")
        }else {
            titleLab.textColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
            iconImgV.image = kIMAGE("icon_opinionsFalse")
        }
    }
}
