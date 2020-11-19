//
//  CJKTEmptyView.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/12.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

//class CJKTEmptyView: NSObject {
//
//}
extension UIScrollView {
    
    private struct AssociatedKeys {
        static var uemptyKey: Void?
    }
    
    var uempty: CJKTEmptyView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.uemptyKey) as? CJKTEmptyView
        }
        set {
            self.emptyDataSetDelegate = newValue
            self.emptyDataSetSource = newValue
           objc_setAssociatedObject(self, &AssociatedKeys.uemptyKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

class CJKTEmptyView: EmptyDataSetSource, EmptyDataSetDelegate {
    
    var image: UIImage?
    var allowShow: Bool = false
    var verticalOffset: CGFloat = 0

    private var tapClosure: (() -> Void)?
    
    init(image: UIImage? = UIImage(named: "nodata"), verticalOffset: CGFloat = 0, tapClosure: (() -> Void)?) {
        self.image = image
        self.verticalOffset = verticalOffset
        self.tapClosure = tapClosure
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return verticalOffset
    }
    
    internal func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return image
    }
    
    internal func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return allowShow
    }
    
    internal func emptyDataSet(_ scrollView: UIScrollView, didTapView view: UIView) {
        guard let tapClosure = tapClosure else { return }
        tapClosure()
    }
}




