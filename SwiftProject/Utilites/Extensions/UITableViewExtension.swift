//
//  UITableViewExtension.swift
//  SwiftProject
//
//  Created by daixingchuang on 2021/6/23.
//  Copyright © 2021 Dxc_iOS. All rights reserved.
//

import Foundation
public extension UITableView {
    
    /**滚动到第一行*/
    func scrollToFirst(scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard numberOfSections > 0 else { return }
        guard numberOfRows(inSection: 0) > 0 else { return }
        let indexPath = IndexPath(item: 0, section: 0)
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
    /**滚动到最后一行*/
    func scrollToLast(scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard numberOfSections > 0 else { return }
        let lastSection = numberOfSections - 1
        guard numberOfRows(inSection: 0) > 0 else { return }
        let lastIndexPath = IndexPath(item: numberOfRows(inSection: lastSection)-1, section: lastSection)
        scrollToRow(at: lastIndexPath, at: scrollPosition, animated: animated)
    }
}
