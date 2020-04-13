//
//  CJKTSecondViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON
import HandyJSON
class CJKTSecondViewController: CJKTBaseViewController{
   
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
        return cw
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadData()
    }
    
    override func configUI() {
        view.addSubview(self.collectionView)
           self.collectionView.snp.makeConstraints{
//            $0.edges.equalTo(view.snp.edges)
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(view.snp.top).offset(kTabBarHeight)
            
        }
       }
    private func loadData() {
//        CJKTMoyaManager.request(CJKTAPI.cateList) { (result) in
//
//               }
        
//        CJKTMoyaManager.request(CJKTAPI.cateList, model: CateListModel.self) { (returnData) in
//            CJKTLog("returnData = \(String(describing: returnData))")
//        }
        
       
        CJKTMoyaAPIProvider2.request(CJKTAPI.cateList) { (result) in
             if case let .success(response) = result {
                
        //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
//                CJKTLog("json = \(json)")
                let  dic = json["data"]["returnData"]["rankingList"]
                CJKTLog("dic = \(dic)")
                
                if let mappedObject = JSONDeserializer<CateListModel>.deserializeFrom(json: json.description) {
//                        self.homevipData = mappedObject
//                        self.focusImages = mappedObject.focusImages?.data
//                        self.categoryList = mappedObject.categoryContents?.list
                 }
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
        return 6;
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CJKTSecondCollectionCell", for: indexPath) as!CJKTSecondCollectionCell
        
//        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CJKTSecondCollectionCell.self)
        cell.backgroundColor = UIColor.red
        
        return cell
       }
    
    
    // return: item的大小
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
          
         return CGSize(width: (SCREEN_WIDTH - 20)/2, height: 80)
           
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
        return 10
    }
    
    
    
      //返回header的大小
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
        {
            return CGSize(width: SCREEN_WIDTH, height: 50)
            }
    //    返回Footer的大小
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
             return CGSize(width: SCREEN_WIDTH, height: 50)
        }

        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
        {
           
            
            if (kind as String) == UICollectionView.elementKindSectionHeader  {
                //返回头部
//                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath)
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: CJKTSecondCollectionReusableView.self)
                header.backgroundColor = UIColor.yellow
                return header
            }else
            {
                //返回底部
//                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer", for: indexPath)
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, for: indexPath, viewType: CJKTSecondCollectionReusableView.self)
                footer.backgroundColor = UIColor.blue
                return footer
            }
        }
}



