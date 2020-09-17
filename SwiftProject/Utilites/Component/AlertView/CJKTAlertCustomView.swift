//
//  CJKTAlertCustomView.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/5/13.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
//
//class CJKTAlertCustomView: UIView {
//
//    /*
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
//    */
//
//}


/// 自定义弹框
open class AlertCustomView<Base: UIView>: UIView, AlertProtocol {
     
    /// 自定义的组件
    open var base: Base {
        get { return customView }
        set { customView = newValue }
    }
    
    // MARK: - datas
    public var appearFrom: AppearFrom = .right
    public var clearBackground = Bool()
    
    public var closeBtnClick: (() -> Void)?
    
    // MARK: - views
    public var backgroundView = UIView()
    public var dialogView = UIView()
    // 自定义的View
    fileprivate var customView: Base = Base()
    /// 是否隐藏close
    private var isHiddenClose: Bool = true
    private var closeBtn: UIButton! // 关闭
    
    // MARK: - leftStyle
    deinit {
        print("alertType deinit")
    }
    
    fileprivate override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
        latoutUI()
    }
    
    public convenience init(_ customView: Base, _ isHiddenClose: Bool = true) {
        
        self.init(frame: UIScreen.main.bounds)
        self.customView = customView
        self.isHiddenClose = isHiddenClose
        initViews()
        latoutUI()
    }
    
    // MARK: - events
    
    // dismiss the alert view
    @objc public func didcloseBtnTapped() {
        dismiss(animated: true)
        closeBtnClick?()
    }
    
    @objc func backgroundViewTap() {
        print("backgroundViewTap")
    }
    
    fileprivate func latoutUI() {
        let cf = base.frame
        
        backgroundView.frame = frame
        addSubview(backgroundView)
        
        addSubview(dialogView)
        dialogView.addSubview(customView)
        dialogView.addSubview(closeBtn)
        
        dialogView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        customView.snp.makeConstraints { (make) in
            make.size.equalTo(cf.size).priority(.low)
            
            let bottom: CGFloat = isHiddenClose ? 0 : 54.5
            make.edges.equalTo(UIEdgeInsets(top: cf.origin.y, left: cf.origin.x, bottom: bottom, right: 0 ))
        }
        
        closeBtn.snp.makeConstraints { (make) in
            make.bottom.centerX.equalToSuperview()
            make.width.height.equalTo(44)
        }
        
    }
    
    // MARK: - initViews
    public func initViews() {
        
        backgroundView = {
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.black
            return backgroundView
        }()
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(backgroundViewTap))

        backgroundView.addGestureRecognizer(tap)
        
        closeBtn = {
            let closeBtn = UIButton()
            closeBtn.setImage(UIImage(named: "close"), for: .normal)
            return closeBtn
        }()
        
        closeBtn.isHidden = isHiddenClose
        closeBtn.addTarget(self, action: #selector(didcloseBtnTapped), for: UIControl.Event.touchUpInside)
        
    }
}
