//
//  CJKTHomeViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import ParallaxHeader
import SnapKit
import Then
import HandyJSON
import SwiftyJSON
class CJKTHomeViewController: CJKTBaseViewController {
//    var girlStr:String = ""
//    var userId: Int = 0
//    var dataArr: Array = [String]()
//    var studentDic = [String: String]()
//    var studentDic2: Dictionary <String,String> = [:]
//    var baseModel: CJKTBaseModel?
//    var baseModel2 = [CJKTBaseModel]()
//
    var page = 1
    var count = 10
    var grilListlArry = [GrilListModel?]()
//    var dataArr = [Any]()
    
    lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .grouped)
        tw.backgroundColor = UIColor.white
        tw.delegate = self
        tw.dataSource = self
        tw.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tw.register(cellType: CJKTHomeTableViewCell.self)
        tw.uempty = CJKTEmptyView.init(tapClosure: {
            self.loadData(moreData: false)
        })
        tw.uHead = CJKTRefreshNormalHeader.init(refreshingBlock: {
            self.loadData(moreData: false)
        })
        tw.uFoot  = CJKTRefreshNormalFooter.init(refreshingBlock: {
            self.loadData(moreData: true)
        })
        return tw
    }()
    private lazy var head: UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 200))
        view.backgroundColor = UIColor.red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.cjkt_snp.edges).priority(.low)
            $0.top.equalToSuperview()
        }
//        tableView.parallaxHeader.view = head
//        tableView.parallaxHeader.height = 200
//        tableView.parallaxHeader.minimumHeight = 10//CGFloat(kNavBarHeight)
//        tableView.parallaxHeader.mode = .fill
    
       
       
        loadData(moreData: false)
    }
    
    func loadData(moreData: Bool) -> Void{
        
//        var parameters = [
//            "page":1,
//            "count":20,
//            ] as [String : Any]
        
//         parameters = appendBaseParamaters(parameters: parameters)//拼接基本参数
        if moreData == true {
            CJKTLog("true")
            self.page = self.page + 1
        }else{
             CJKTLog("false")
            self.page = 1
        }
       
        
        CJKTMoyaAPIProvider3.request(.girl(page: self.page, count: self.count)) { (result) in
//            CJKTLog("result = \(result)")
//            self.tableView.uHead.endRefreshing()
            
            if case let .success(result) = result {
            let data = try? result.mapJSON()
            let json = JSON(data!)
//              CJKTLog("json = \(json)")
//                if let grilModel = JSONDeserializer<GrilModel>.deserializeFrom(json: json.description){
//
//                    CJKTLog("page_count = \(grilModel.page_count)")
//                }
//
//               if let grilListModel =  JSONDeserializer<GrilListModel>.deserializeModelArrayFrom(json: json["data"].description){
//
//                CJKTLog("grilModelArry.count = \(grilListModel.count)")
//                  self.grilListlArry = grilListModel
//                }
                
                let dataArr = JSONDeserializer<GrilListModel>.deserializeModelArrayFrom(json: json["data"].description)
    
                if moreData == false {//未上拉加载
                    self.grilListlArry.append(contentsOf: dataArr!)
//                    self.page = 1
                    if dataArr!.count>0 {
                        self.tableView.uHead.endRefreshing()
                        self.tableView.uFoot.endRefreshing()
                        self.tableView.uFoot = CJKTRefreshNormalFooter.init(refreshingBlock: {
                            self.loadData(moreData: true)
                        })
                    }
                }else{//上拉加载
                    
//                    self.grilListlArry.append(contentsOf: dataArr!)
                    
                    if dataArr!.count>0 {
//                        self.page+=1;
                        self.grilListlArry.append(contentsOf: dataArr!)
                    }else {
                         self.tableView.uFoot.endRefreshing()
                    }
                }
                
                self.tableView.reloadData();//刷新
                self.tableView.uHead.endRefreshing()
                self.tableView.uFoot.endRefreshing()

            }else{
                CJKTLog("Error = \(result.error?.errorDescription)")
                
                
            }
        }
        
        
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

extension CJKTHomeViewController: UITableViewDelegate,UITableViewDataSource{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= -(scrollView.parallaxHeader.minimumHeight) {
//            navigationController?.barStyle(.theme)
            navigationItem.title = "我的MM"
        } else {
//           navigationController?.barStyle(.clear)
            navigationItem.title = "你的MM"
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.grilListlArry.count//5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CJKTHomeTableViewCell.self)
        cell.model = self.grilListlArry[indexPath.row] //as! GrilListModel;

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        CJKTLog("点击了\(indexPath.row)")
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
