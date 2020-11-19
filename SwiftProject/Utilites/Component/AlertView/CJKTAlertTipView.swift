//
//  CJKTAlertTipView.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/5/13.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import Foundation

/*
        1.自定义view
        2.继承自uiview
        3.重写初始化方法
        4.重写布局方法
 
     override init(frame: CGRect) {
            super.init(frame: frame)
             setupSubviews()
         }
     //xib
     required init?(coder aDecoder: NSCoder) {
             super.init(coder: aDecoder)
             setupSubviews()
         }
    
     override func layoutSubviews() {
     }
     
**/
class CJKTAlertTipView: UIView {
    
    // MARK: - datas
    public var style = AlertViewStyle() {
        didSet {

            titleL.font = UIFont.boldSystemFont(ofSize: style.titleLFont)
            titleL.textColor = style.titleLColor
            
            if titleL.text?.isEmpty ?? true {
                messageL.font = UIFont.systemFont(ofSize: style.titleLFont)
            }else {
                messageL.font = UIFont.systemFont(ofSize: style.messageLFont)
            }
            messageL.textColor = style.messageLColor


            doneBtn.setTitleColor(style.doneBtnTextColor, for: .normal)
            doneBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: style.doneBtnTextFont)
            doneBtn.setBackgroundImage(UIImage(color: style.doneBtnNormalBgColor),
                                       for: .normal)
            doneBtn.setBackgroundImage(UIImage(color: style.doneBtnHighlightedBgColor),
                                       for: .highlighted)

            cancelBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: style.cancelBtnTextFont)

            cancelBtn.setTitleColor(style.cancelBtnTextColor, for: .normal)
            cancelBtn.setBackgroundImage(UIImage(color: style.cancelBtnNormalBgColor),
            for: .normal)
        }
    }
    
    

    // MARK: - lazy subviews
    public lazy var whiteBgV: UIView  = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = style.cornerRadius
        view.clipsToBounds = true
        return view
    }()
    

    private lazy var titleL: UILabel = {
       let titleL = UILabel()
       titleL.textAlignment = .center
       titleL.lineBreakMode = NSLineBreakMode.byWordWrapping
       titleL.numberOfLines = 0
       titleL.sizeToFit()
       return titleL
    }()
    private lazy var messageL: UILabel = {
       let messageL = UILabel()
       messageL.numberOfLines = 0
       messageL.lineBreakMode = NSLineBreakMode.byWordWrapping
       messageL.textAlignment = .center
       messageL.sizeToFit()
       return messageL
    }()

    public lazy var cancelBtn: UIButton = {
       let cancelBtn = UIButton()
       cancelBtn.layer.cornerRadius = style.cornerRadius
       cancelBtn.clipsToBounds = true
       return cancelBtn
    }()

           
    public lazy var doneBtn: UIButton = {
        let doneBtn = UIButton()
        //        doneBtn.backgroundColor =  UIColor.darkText
        doneBtn.layer.cornerRadius = style.cornerRadius
        doneBtn.clipsToBounds = true
        return doneBtn
    }()
    public var doneBtnClick: (() -> Void)?
    public var cancelBtnClick: (() -> Void)?
    var title: String?
    var message: String?
    var doneBtnTitle: String?
    var cancelBtnTitle: String?
     
    // MARK: - leftStyle
    deinit {
        print("deinit")
    }

//    public convenience init(title: String, message: String, doneBtnTitle: String, cancelBtnTitle: String = "取消") {
//        self.init(frame: CGRect(x: 0, y: 0, width: 265, height: 0))
//        self.initialise(title: title, message: message, doneBtnTitle: doneBtnTitle, cancelBtnTitle: cancelBtnTitle)
//    }

//    public override init(frame: CGRect) {
//        style = AlertViewStyle()
//        super.init(frame: frame)
//        initViews()
//    }

//    public required init?(coder aDecoder: NSCoder) {
//        style = AlertViewStyle()
//        super.init(coder: aDecoder)
//        initViews()
//    }

    
    

       
//    private func initialise(title: String, message: String, doneBtnTitle: String, cancelBtnTitle: String = "取消") {
//
//        titleL.text = title
//        doneBtn.setTitle(doneBtnTitle, for: UIControl.State.normal)
//        cancelBtn.setTitle(cancelBtnTitle, for: UIControl.State.normal)
//
//        messageL.text = message
//
//        cancelBtn.addTarget(self, action: #selector(didCancelBtnTapped), for: UIControl.Event.touchUpInside)
//        doneBtn.addTarget(self, action: #selector(didDoneBtnTappad), for: UIControl.Event.touchUpInside)
//
//        let hasCancel = !cancelBtnTitle.isEmpty
//        hasCancel ? setupTextAlert(!title.isEmpty) : setupNoCancelTextAlert(!title.isEmpty)
//
//    }
    

    //code
//    override init(frame: CGRect) {
////           self.title = title
////           self.message = message
////           self.doneBtnTitle = doneBtnTitle
////           self.cancelBtnTitle = cancelBtnTitle
//           super.init(frame: frame)
//            setupSubviews()
//        }
    //xib
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupSubviews()
        }
    func setupSubviews(){
        
        setupTextAlert(true)
        
    }
    
    
    override func layoutSubviews() {
//         self.frame = CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
    
    
    
    func show(){
        self.whiteBgV.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.whiteBgV.alpha = 1
         })
        
        kkeyWindow?.rootViewController!.view.addSubview(self)
    }
    
    func dismiss(){
         self.whiteBgV.isHidden = true
        UIView.animate(withDuration: 0.3, animations: {
           self.whiteBgV.alpha = 0
        }) { (completed) in
           self.removeFromSuperview()
        }
    
    }
    
    // MARK: - events

    @objc public func didDoneBtnTappad() {
        print("doneBtn isTappad,get btn use getdoneBtn()")
        doneBtnClick?()
    }

    // dismiss the alert view
    @objc public func didCancelBtnTapped() {
        cancelBtnClick?()
    }


    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("al touchesBegan")
    }

}

// MARK: - textAlert
extension CJKTAlertTipView {

    fileprivate func setupTextAlert(_ hasTitle: Bool = true) {

        self.addSubview(whiteBgV)
        whiteBgV.addSubview(titleL)
        whiteBgV.addSubview(messageL)
        whiteBgV.addSubview(doneBtn)
        whiteBgV.addSubview(cancelBtn)

        whiteBgV.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(0)
            make.width.equalTo(265)
        }

        titleL.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }

        messageL.snp.makeConstraints { (make) in
            let top: CGFloat = hasTitle ? 60 : 40
            let bottom: CGFloat = hasTitle ? 70 : 84
            make.edges.equalTo(UIEdgeInsets(top: top, left: 20, bottom: bottom, right: 20))
        }

        doneBtn.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.right.bottom.equalTo(0)
            make.width.equalToSuperview().multipliedBy(0.5)
        }

        cancelBtn.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.bottom.width.height.equalTo(doneBtn)
        }
        doneBtn.clipsToBounds = false
        cancelBtn.clipsToBounds = false
    }


    fileprivate func setupNoCancelTextAlert(_ hasTitle: Bool = true) {
        
        self.addSubview(whiteBgV)
        whiteBgV.addSubview(titleL)
        whiteBgV.addSubview(messageL)
        whiteBgV.addSubview(doneBtn)
        whiteBgV.addSubview(cancelBtn)

        whiteBgV.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(0)
            make.width.equalTo(265)
        }

        titleL.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }

        messageL.snp.makeConstraints { (make) in

            let top: CGFloat = hasTitle ? 60 : 40
            let bottom: CGFloat = hasTitle ? 80 : 96
            make.edges.equalTo(UIEdgeInsets(top: top, left: 20, bottom: bottom, right: 20))
        }

        doneBtn.snp.makeConstraints { (make) in

            make.height.equalTo(36)
            make.bottom.equalTo(-20)
            make.left.equalTo(22.5)
            make.right.equalTo(-22.5)
        }
    }
    
    
}



// MARK: - show /dismiss
extension CJKTAlertTipView {
     
    
}


///样式类
public struct AlertViewStyle {
    public var backgroundViewAlpha: CGFloat = 0.6
    public var dialogViewCornerRadius: CGFloat = 5
    
    public var titleLFont: CGFloat = 18
    public var titleLColor = UIColor.hexString(hexString: "#333333")
    public var messageLFont: CGFloat = 15
    public var messageLColor = UIColor.hexString(hexString: "#333333")
    public var textViewFont: CGFloat = 15
    public var textViewBorderColor = UIColor.hexString(hexString: "#F07D8A")
    public var textViewTextCorlr = UIColor.hexString(hexString: "#333333")
    
    public var cancelBtnTextColor = UIColor.hexString(hexString: "#999999")
    public var cancelBtnTextFont: CGFloat = 16
    public var cancelBtnNormalBgColor = UIColor.hexString(hexString: "#EEEFF1")
//    public var cancelBtnHighlightedBgColor = UIColor.c192451
    
    public var doneBtnTextColor = UIColor.white
    public var doneBtnTextFont: CGFloat = 16
    public var doneBtnNormalBgColor = UIColor.hexString(hexString: "#F07D8A")
    public var doneBtnHighlightedBgColor = UIColor.hexString(hexString: "#F07D8A")
    
    public var cornerRadius: CGFloat = 3
    
    public init() {}
}
