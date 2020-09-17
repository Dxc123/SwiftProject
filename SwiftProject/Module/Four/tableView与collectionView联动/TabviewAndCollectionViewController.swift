//
//  TabviewAndCollectionViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/6/9.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class TabviewAndCollectionViewController: CJKTBaseViewController {
       var tableViewData = [String]()
       var collectionViewData = [[CollectionViewModel]]()
       var collectionViewIsScrollDown = true
       var collectionViewLastOffsetY : CGFloat = 0.0
        
    lazy var tableView: UITableView = {
        let cw = UITableView.init(frame: CGRect.zero, style: .plain)
        cw.backgroundColor = UIColor.white
        cw.delegate = self
        cw.dataSource = self
        cw.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        cw.register(LeftTableViewCell.self, forCellReuseIdentifier: "LeftTableViewCell")
        cw.tableFooterView = UIView.init()
        return cw
        
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        // layout.scrollDirection = .horizontal////横向滚动
         layout.sectionHeadersPinToVisibleBounds = true//分组头悬停
        let cw = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        cw.backgroundColor = UIColor.white
        cw.delegate = self
        cw.dataSource = self
        cw.alwaysBounceVertical = true
        cw.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        cw.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        cw.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "footer")
        cw.register(cellType: RightCollectionViewCell.self)
        cw.register(supplementaryViewType: RightCollectionViewHeader.self, ofKind: UICollectionView.elementKindSectionHeader)
        return cw
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化左侧表格数据
        for i in 1..<15 {
            self.tableViewData.append("分类\(i)")
        }
        
        //初始化右侧表格数据
        for _ in tableViewData {
            var models = [CollectionViewModel]()
            for i in 1..<6 {
                models.append(CollectionViewModel(name: "型号\(i)", picture: "image3"))
            }
            self.collectionViewData.append(models)
        }
        
        view.addSubview(tableView)
        view.addSubview(collectionView)
        tableView.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.top.equalTo(self.view.snp.top)
            make.width.equalTo(80)
        }
        collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(tableView.snp.right).offset(0)
            make.bottom.equalToSuperview()
            make.top.equalTo(self.view.snp.top)
            make.width.equalTo(SCREEN_WIDTH-80)
        }
        //左侧表格默认选中第一项
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true,scrollPosition: .none)
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
extension TabviewAndCollectionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftTableViewCell",for: indexPath) as! LeftTableViewCell
            cell.titleLabel.text = tableViewData[indexPath.row]
            return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         //右侧collection自动滚动到对应的分区
        collectionViewScrollToTop(section: indexPath.row, animated: true)
        //左侧tableView将该单元格滚动到顶部
        tableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0),
                                  at: .top, animated: true)
    }
    func collectionViewScrollToTop(section: Int, animated: Bool) {
        let headerRect = collectionViewHeaderFrame(section: section)
        let topOfHeader = CGPoint(x: 0, y: headerRect.origin.y
            - collectionView.contentInset.top)
        collectionView.setContentOffset(topOfHeader, animated: animated)
    }
     func collectionViewHeaderFrame(section: Int) -> CGRect {
         let indexPath = IndexPath(item: 0, section: section)
         let attributes = collectionView.collectionViewLayout
             .layoutAttributesForSupplementaryView(ofKind:
                 UICollectionView.elementKindSectionHeader, at: indexPath)
         guard let frameForFirstCell = attributes?.frame else {
             return .zero
         }
         return frameForFirstCell;
     }
}

extension TabviewAndCollectionViewController:UICollectionViewDelegateFlowLayout, UICollectionViewDelegate ,UICollectionViewDataSource  {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tableViewData.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return collectionViewData[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            "RightCollectionViewCell", for: indexPath) as! RightCollectionViewCell
        let model = collectionViewData[indexPath.section][indexPath.row]
        cell.model = model
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // return: item的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: (SCREEN_WIDTH - 120)/3, height: 80)
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
        return CGSize(width: SCREEN_WIDTH, height: 30)
    }
    //    返回Footer的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        if (kind as String) == UICollectionView.elementKindSectionHeader  {
            //返回头部
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: RightCollectionViewHeader.self)
            header.titleLabel.text = tableViewData[indexPath.section]
            return header
        }
        else{
            //返回底部
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer", for: indexPath)
            footer.backgroundColor = UIColor.blue
            return footer
        }
    }
    
    //分区头即将要显示时调用
    func collectionView(_ collectionView: UICollectionView,
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String, at indexPath: IndexPath) {
        //如果是由用户手动滑动屏幕造成的向上滚动，那么左侧表格自动选中该分区对应的分类
        if !collectionViewIsScrollDown
            && (collectionView.isDragging || collectionView.isDecelerating) {
            tableView.selectRow(at: IndexPath(row: indexPath.section, section: 0),animated: true, scrollPosition: .top)
        }
    }
     
    //分区头即将要消失时调用
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplayingSupplementaryView view: UICollectionReusableView,
                        forElementOfKind elementKind: String, at indexPath: IndexPath) {
        //如果是由用户手动滑动屏幕造成的向下滚动，那么左侧表格自动选中该分区对应的下一个分区的分类
        if collectionViewIsScrollDown
            && (collectionView.isDragging || collectionView.isDecelerating) {
            tableView.selectRow(at: IndexPath(row: indexPath.section + 1, section: 0),animated: true, scrollPosition: .top)
        }
    }
     
    //视图滚动时触发（主要用于记录当前collectionView是向上还是向下滚动）
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView == scrollView {
            collectionViewIsScrollDown = collectionViewLastOffsetY
                < scrollView.contentOffset.y
            collectionViewLastOffsetY = scrollView.contentOffset.y
        }
    }
    
    
}

