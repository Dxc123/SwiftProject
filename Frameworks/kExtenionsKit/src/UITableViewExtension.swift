//
//  UITableViewExtension.swift
//  SwiftProject
//
//  Created by daixingchuang on 2021/6/23.
//  Copyright © 2021 Dxc_iOS. All rights reserved.
//(Swift版本扩展)前缀 sf

import Foundation
import UIKit
public extension UITableView {
    /**注册UITableViewCell*/
    func sf_register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }
    /**nib注册UITableViewCell*/
    func sf_register<T: UITableViewCell>(nib: UINib?, withCellClass name: T.Type) {
        register(nib, forCellReuseIdentifier: String(describing: name))
    }
    /**nib注册UITableViewCell*/
    func sf_register<T: UITableViewCell>(nibName: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: nibName)
        var bundle: Bundle?

        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }

        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }

    

    /**复用UITableViewCell*/
    func sf_dequeueReusableCell<T: UITableViewCell>(cellName: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: cellName)) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: cellName)), make sure the cell is registered with table view")
        }
        return cell
    }
    /**复用UITableViewCell*/
    func sf_dequeueReusableCell<T: UITableViewCell>(cellName: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: cellName), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: cellName)), make sure the cell is registered with table view")
        }
        return cell
    }
    
    
    /**注册UITableViewHeaderFooterView*/
    func sf_register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }
    /**nib注册UITableViewHeaderFooterView*/
    func sf_register<T: UITableViewHeaderFooterView>(nib: UINib?, withHeaderFooterViewClass name: T.Type) {
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }
    /**复用UITableViewHeaderFooterView*/
    func sf_dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(className: T.Type) -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: className)) as? T else {
            fatalError("Couldn't find UITableViewHeaderFooterView for \(String(describing: className)), make sure the view is registered with table view")
        }
        return headerFooterView
    }
    
    /**滚动到第一行*/
    func sf_scrollToFirst(scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard numberOfSections > 0 else { return }
        guard numberOfRows(inSection: 0) > 0 else { return }
        let indexPath = IndexPath(item: 0, section: 0)
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
    /**滚动到最后一行*/
    func sf_scrollToLast(scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard numberOfSections > 0 else { return }
        let lastSection = numberOfSections - 1
        guard numberOfRows(inSection: 0) > 0 else { return }
        let lastIndexPath = IndexPath(item: numberOfRows(inSection: lastSection)-1, section: lastSection)
        scrollToRow(at: lastIndexPath, at: scrollPosition, animated: animated)
    }
}
