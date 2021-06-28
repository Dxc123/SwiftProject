//
//  CJKTFourViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import Reusable
class CJKTFourViewController: CJKTBaseViewController {
    var dataArr = [Any]()
    var classNameArr = [Any]()
    lazy var tableview: UITableView = {
        let cw = UITableView.init(frame: CGRect.zero, style: .plain)
        cw.backgroundColor = UIColor.white
        cw.delegate = self
        cw.dataSource = self
        cw.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        cw.tableFooterView = UIView.init()
        return cw
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.barStyle(.theme)
        navigationItem.title = "我的"
        self.view.addSubview(self.tableview)
        self.tableview.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(kNavBarHeight)
            make.left.right.bottom.equalToSuperview()
        }
        self.dataArr = [
        "两个tableView间联动",
        "tableView与CollectionView联动",
        "TabView分组圆角效果",
         "R.swift-优雅地引用项目资源",
         "app内切换语言",
         "使用数据库缓存Model数据",
         "JSON数据模型转换",
         "自定义弹窗View封装",
         "RxSwift使用示例"
            
        ]
        self.classNameArr = [
        "TwoTablevVewController",//"两个tableView间联动",
        "TabviewAndCollectionViewController",//"tableView与CollectionView联动",
        "MyTableViewController",//"TabView分组圆角效果",
        "CJKTUesRSwiftViewController",//"R.swift-优雅地引用项目资源",
        "CJKTSelectLanguageViewController",// "app内切换语言",
        "CJKTSaveModelDataViewController",//"使用数据库缓存Model数据",
        "CJKTJSONViewController",//"JSON数据模型转换",
        "CJKTCustomAlertViewViewController",// "自定义弹窗View封装"
        "CJKTUseRxSwiftViewController"
        ]
        
        
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

extension CJKTFourViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = (self.dataArr[indexPath.row] as! String)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        NSString *className = self.classNames[indexPath.section];
//           Class class = NSClassFromString(className);
//           if (class) {
//               UIViewController *ctrl = class.new;
//               ctrl.title = self.classNames[indexPath.section];
//
//               [self.navigationController pushViewController:ctrl animated:YES];
//           }
//swift 中NSClassFromString的使用：
//        在swift中 NSClassFromString的参数不只是一个单独的类字符串,而是一个完整的包名加类名组成的字符串,也就是包类名字符串.也就是说需要在类名的前面加上你的工程名字
        var className = kTool.getAPPName()
        className.append(".")
        className.append(self.classNameArr[indexPath.row] as! String)
        guard NSClassFromString(className as String)! is UIViewController.Type  else{
            NSLog("无法转换成UITableViewController")
            return
        }
        let aClass = NSClassFromString(className) as! UIViewController.Type
        let vc = aClass.init()
        vc.title = self.dataArr[indexPath.row] as? String
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
