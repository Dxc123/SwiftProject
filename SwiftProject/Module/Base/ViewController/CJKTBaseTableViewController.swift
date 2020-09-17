//
//  CJKTBaseTableViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/6/9.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift
class CJKTBaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }

    open func configUI() {}
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }

  
}
extension CJKTBaseTableViewController: EmptyDataSetSource,EmptyDataSetDelegate{
//    func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView?{
//
//    }
//
}
