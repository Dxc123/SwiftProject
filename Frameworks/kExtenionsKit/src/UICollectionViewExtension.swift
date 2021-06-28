//
//  UICollectionViewExtension.swift
//  SwiftProject
//
//  Created by daixingchuang on 2021/6/23.
//  Copyright © 2021 Dxc_iOS. All rights reserved.
//(Swift版本扩展)前缀 sf

import Foundation
import UIKit
public extension UICollectionView{
    /**注册UICollectionViewCell*/
    func sf_register<T: UICollectionViewCell>(cellName: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: cellName))
    }
    /**注册UICollectionViewCell*/
    func sf_register<T: UICollectionViewCell>(nib: UINib?, cellName: T.Type) {
        register(nib, forCellWithReuseIdentifier: String(describing: cellName))
    }
    /**注册UICollectionViewCell*/
    func sf_register<T: UICollectionViewCell>(nibName: T.Type,bundleClass: AnyClass? = nil) {
        let identifier = String(describing: nibName)
        var bundle: Bundle?

        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }

        register(UINib(nibName: identifier, bundle: bundle), forCellWithReuseIdentifier: identifier)
    }

    /**复用UICollectionViewCell*/
    func sf_dequeueReusableCell<T: UICollectionViewCell>(cellName: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: cellName), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell for \(String(describing: cellName)), make sure the cell is registered with collection view")
        }
        return cell
    }
    /**复用UICollectionReusableView*/
    func sf_dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, className: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: className), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionReusableView for \(String(describing: className)), make sure the view is registered with collection view")
        }
        return cell
    }
}
