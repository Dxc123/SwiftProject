//
//  MyTableViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/6/9.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class MyTableViewController: CJKTBaseViewController {
    lazy var tableView: UITableView = {
        let cw = UITableView.init(frame: CGRect.zero, style: .grouped)
        cw.showsVerticalScrollIndicator = false
//        cw.backgroundColor = UIColor.lightGray
        cw.delegate = self
        cw.dataSource = self
        cw.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        cw.register(MyTableViewCell.self, forCellReuseIdentifier: "MyTableViewCell")
        cw.tableFooterView = UIView.init()
        return cw
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = RGB(245, 245, 245)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
            make.top.equalTo(view.snp.top).offset(kNavBarHeight+20)
            make.top.bottom.equalToSuperview()
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
extension MyTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",for: indexPath) //as! MyTableViewCell
            cell.textLabel?.text = "1111"
            //圆角半径
            let cornerRadius:CGFloat = 15.0
            
            //下面为设置圆角操作（通过遮罩实现）
            let sectionCount = tableView.numberOfRows(inSection: indexPath.section)
            let shapeLayer = CAShapeLayer()
            cell.layer.mask = nil
            //当前分区有多行数据时
            if sectionCount > 1 {
                switch indexPath.row {
                //如果是第一行,左上、右上角为圆角
                case 0:
                    var bounds = cell.bounds
                    bounds.origin.y += 1.0  //这样每一组首行顶部分割线不显示
                    let bezierPath = UIBezierPath(roundedRect: bounds,
                                                  byRoundingCorners: [.topLeft,.topRight],
                                                  cornerRadii: CGSize(width: cornerRadius,height: cornerRadius))
                    shapeLayer.path = bezierPath.cgPath
                    cell.layer.mask = shapeLayer
                //如果是最后一行,左下、右下角为圆角
                case sectionCount - 1:
                    var bounds = cell.bounds
                    bounds.size.height -= 1.0  //这样每一组尾行底部分割线不显示
                    let bezierPath = UIBezierPath(roundedRect: bounds,
                                                  byRoundingCorners: [.bottomLeft,.bottomRight],
                                                  cornerRadii: CGSize(width: cornerRadius,height: cornerRadius))
                    shapeLayer.path = bezierPath.cgPath
                    cell.layer.mask = shapeLayer
                default:
                    break
                }
            }
                //当前分区只有一行行数据时
            else {
                //四个角都为圆角（同样设置偏移隐藏首、尾分隔线）
                let bezierPath = UIBezierPath(roundedRect:
                    cell.bounds.insetBy(dx: 0.0, dy: 2.0),
                                              cornerRadius: cornerRadius)
                shapeLayer.path = bezierPath.cgPath
                cell.layer.mask = shapeLayer
            }
            return cell
            
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 0))
        headerView.backgroundColor = UIColor.white
        return headerView
    }
}

