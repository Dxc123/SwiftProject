//
//  TwoTablevVewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/6/9.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class TwoTablevVewController: CJKTBaseViewController {
    var leftTableData = [String]()
    var rightTableData = [[RightTableModel]]()
    var rightTableIsScrollDown = true
    var rightTableLastOffsetY : CGFloat = 0.0
    lazy var leftTableview: UITableView = {
        let cw = UITableView.init(frame: CGRect.zero, style: .plain)
        cw.backgroundColor = UIColor.white
        cw.delegate = self
        cw.dataSource = self
        cw.register(LeftTableViewCell.self, forCellReuseIdentifier: "leftTableViewCell")
//        cw.tableFooterView = UIView.init()
        return cw
        
    }()
    lazy var rightTableview: UITableView = {
        let cw = UITableView.init(frame: CGRect.zero, style: .plain)
        cw.backgroundColor = UIColor.white
        cw.delegate = self
        cw.dataSource = self
        cw.register(RightTableViewCell.self, forCellReuseIdentifier: "rightTableViewCell")
//        cw.tableFooterView = UIView.init()
        return cw
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI(){
        //初始化左侧表格数据
        for i in 1..<15 {
            self.leftTableData.append("分类\(i)")
        }
        
        //初始化右侧表格数据
        for leftItem in leftTableData {
            var models = [RightTableModel]()
            for i in 1..<5 {
                models.append(RightTableModel(name: "\(leftItem) - 外卖菜品\(i)",
                    picture: "image", price: Float(i)))
            }
            self.rightTableData.append(models)
        }
        
        
        self.view.addSubview(self.leftTableview)
        self.view.addSubview(self.rightTableview)
        self.leftTableview.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.top.equalTo(self.view.snp.top)
            make.width.equalTo(80)
        }
        self.rightTableview.snp.makeConstraints { (make) in
            make.left.equalTo(self.leftTableview.snp.right).offset(0)
            make.bottom.equalToSuperview()
            make.top.equalTo(self.view.snp.top)
            make.width.equalTo(SCREEN_WIDTH-80)
        }
        //左侧表格默认选中第一项
        self.leftTableview.selectRow(at: IndexPath(row: 0, section: 0), animated: true,scrollPosition: .none)
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

extension TwoTablevVewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if leftTableview == tableView {
            return 1
        } else {
            return leftTableData.count
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.leftTableview == tableView {
            return leftTableData.count
        } else {
            return rightTableData[section].count
        }
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
           -> UITableViewCell {
           if leftTableview == tableView {
               let cell = tableView.dequeueReusableCell(withIdentifier: "leftTableViewCell",for: indexPath) as! LeftTableViewCell
               cell.titleLabel.text = leftTableData[indexPath.row]
               return cell
           } else {
               let cell = tableView.dequeueReusableCell(withIdentifier: "rightTableViewCell",for: indexPath) as! RightTableViewCell
               let model = rightTableData[indexPath.section][indexPath.row]
               cell.model = model
               return cell
           }
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           if leftTableview == tableView {
               return 0
           }
           return 30
       }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           if leftTableview == tableView {
               return nil
           }
           let headerView = RightTableViewHeader(frame: CGRect(x: 0, y: 0,
                                               width: UIScreen.main.bounds.width, height: 30))
           headerView.titleLabel.text = leftTableData[section]
           return headerView
       }
     //分区头即将要显示时
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView,forSection section: Int) {
           //如果是右侧表格，且是是由用户手动滑动屏幕造成的向上滚动
           //那么左侧表格自动选中该分区对应的分类
           if (rightTableview == tableView)
               && !rightTableIsScrollDown
               && (rightTableview.isDragging || rightTableview.isDecelerating) {
               leftTableview.selectRow(at: IndexPath(row: section, section: 0),
                                       animated: true, scrollPosition: .top)
           }
       }
        
    //分区头即将要消失时
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView,forSection section: Int) {
           //如果是右侧表格，且是是由用户手动滑动屏幕造成的向下滚动
           //那么左侧表格自动选中该分区对应的下一个分区的分类
           if (rightTableview == tableView)
               && rightTableIsScrollDown
               && (rightTableview.isDragging || rightTableview.isDecelerating) {
               leftTableview.selectRow(at: IndexPath(row: section + 1, section: 0),animated: true, scrollPosition: .top)
           }
       }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if leftTableview == tableView {
            //右侧表格自动滚动到对应的分区
            rightTableview.scrollToRow(at: IndexPath(row: 0, section: indexPath.row), at: .top, animated: true)
            //左侧表格将该单元格滚动到顶部
            leftTableview.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: .top, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView = scrollView as! UITableView
        if rightTableview == tableView {
            rightTableIsScrollDown = rightTableLastOffsetY < scrollView.contentOffset.y
            rightTableLastOffsetY = scrollView.contentOffset.y
        }
    }
}
