//
//  CJKTSecondViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import PKHUD
import JXPhotoBrowser
import SwiftyJSON
import HandyJSON
class CJKTSecondViewController: CJKTBaseViewController{
   var page = 1
   var count = 10
   var grilListlArry = [GrilListModel?]()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cw = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        cw.backgroundColor = UIColor.white
        cw.delegate = self
        cw.dataSource = self
        cw.alwaysBounceVertical = true
        cw.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        cw.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        cw.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "footer")
        cw.register(cellType: CJKTSecondCollectionCell.self)
        cw.register(supplementaryViewType: CJKTSecondCollectionReusableView.self, ofKind: UICollectionView.elementKindSectionHeader)
        cw.register(supplementaryViewType: CJKTSecondCollectionReusableView.self, ofKind: UICollectionView.elementKindSectionFooter)
        cw.uempty = CJKTEmptyView.init(tapClosure: {
            self.loadData(moreData: false)
        })
        cw.uHead = CJKTRefreshNormalHeader.init(refreshingBlock: {
            self.loadData(moreData: false)
        })
        cw.uFoot  = CJKTRefreshNormalFooter.init(refreshingBlock: {
            self.loadData(moreData: true)
        })
        return cw
        
    }()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.barStyle(.theme)
        navigationItem.title = "分类"
        view.addSubview(self.collectionView)
       self.collectionView.snp.makeConstraints{
//            $0.edges.equalTo(view.snp.edges)
        $0.left.right.bottom.equalToSuperview()
        $0.top.equalTo(view.snp.top).offset(0)
        }
        
        loadData(moreData: false)
        
     }
    
    func loadData(moreData: Bool) -> Void{
        if moreData == true {
           CJKTLog("true")
           self.page = self.page + 1
        }else{
            CJKTLog("false")
           self.page = 1
        }
        
            HUD.show(.labeledProgress(title: nil, subtitle: "加载中。。。"))
            CJKTMoyaAPIProvider3.request(.girl(page: self.page, count: self.count)) { (result) in
                HUD.hide()
    
                if case let .success(result) = result {
                let data = try? result.mapJSON()
                let json = JSON(data!)
    
                    
                    let dataArr = JSONDeserializer<GrilListModel>.deserializeModelArrayFrom(json: json["data"].description)
        
                    if moreData == false {//未上拉加载
                        self.grilListlArry.append(contentsOf: dataArr!)

                        if dataArr!.count>0 {
                            self.collectionView.uHead.endRefreshing()
                            self.collectionView.uFoot.endRefreshing()
                            self.collectionView.uFoot = CJKTRefreshNormalFooter.init(refreshingBlock: {
                                self.loadData(moreData: true)
                            })
                        }
                    }else{//上拉加载
                        if dataArr!.count>0 {

                            self.grilListlArry.append(contentsOf: dataArr!)
                        }else {
                             self.collectionView.uFoot.endRefreshing()
                        }
                    }
                    
                    self.collectionView.reloadData();//刷新
                    self.collectionView.uHead.endRefreshing()
                    self.collectionView.uFoot.endRefreshing()

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


extension CJKTSecondViewController:UICollectionViewDelegateFlowLayout, UICollectionViewDelegate ,UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.grilListlArry.count;
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CJKTSecondCollectionCell", for: indexPath) as!CJKTSecondCollectionCell
        
//        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CJKTSecondCollectionCell.self)
//        cell.backgroundColor = UIColor.red
        cell.model = self.grilListlArry[indexPath.row]
        
        return cell
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        CJKTLog("点击\(indexPath.row)")
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CJKTSecondCollectionCell", for: indexPath) as!CJKTSecondCollectionCell
//        let model = self.grilListlArry[indexPath.row] as  GrilListModel?
//
//        let vc = CJKTPhoneViewController()
//        vc.imgUrl = model?.url
//        vc.titleStr = model?.title
//        navigationController?.pushViewController(vc, animated: true)
         let images = ["image1","image2","image3"]
        //进入图片全屏展示
        let previewVC = CJKTPhotoBrowseViewController.init(images: images, index: 0)
        self.navigationController?.pushViewController(previewVC, animated: true)
        
    }
    // return: item的大小
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
          
         return CGSize(width: (SCREEN_WIDTH/2-10), height: 200)
           
       }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
    }

   //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 10
    }

    //最小列间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 5
    }
    
    
    
      //返回header的大小
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
        {
            return CGSize(width: SCREEN_WIDTH, height: 0)
            }
    //    返回Footer的大小
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
             return CGSize(width: SCREEN_WIDTH, height: 0)
        }

        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
        {
           
            
            if (kind as String) == UICollectionView.elementKindSectionHeader  {
                //头部
//                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath)
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: CJKTSecondCollectionReusableView.self)
                header.backgroundColor = UIColor.yellow
//                header.selectIndexClosure
                return header
            }else
            {
                //底部
//                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer", for: indexPath)
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, for: indexPath, viewType: CJKTSecondCollectionReusableView.self)
                footer.backgroundColor = UIColor.blue
                return footer
            }
        }
    
    

}



