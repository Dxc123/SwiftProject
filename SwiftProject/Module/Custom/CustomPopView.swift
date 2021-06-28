//
//  CustomPopView.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/9/18.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//
//自定义弹窗模板
import UIKit
import SnapKit
let containerH: CGFloat = 300.0
let containerW: CGFloat = 280.0
//显示与消失类型
enum showPopType {
    case center//中间显示（消失也是）
    case bottom//底部显示（消失也是）
}
class CustomPopView: UIView {
    open var containershowPopType: showPopType?
    open var selectIndex: NSInteger?
    private lazy  var  containerView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        return view
    }()
   
   open lazy var nickNameLabel: UILabel = {
        let nl = UILabel.init()
        nl.text = "UILabel"
        nl.textColor = UIColor.gray
        nl.font = UIFont.systemFont(ofSize: 16)
        nl.textAlignment = .center
        nl.numberOfLines = 0
        return nl
    }()
    lazy var tableView: UITableView = {
        let cw = UITableView.init(frame: CGRect.zero, style: .plain)
        cw.backgroundColor = UIColor.white
        cw.delegate = self
        cw.dataSource = self
        cw.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        cw.register(CJKTSelecteCell.self, forCellReuseIdentifier: "CJKTSelecteCell")
        cw.tableFooterView = UIView.init()
        return cw
        
    }()

//    override init(frame: CGRect) {
//        super.init(frame: UIScreen.main.bounds)
//        self.backgroundColor = UIColor.black.withAlphaComponent(0.5);
//        setupUI()
//    }
   //传入参数的 init方法（自定义构造函数）
   public init(showPopType: showPopType){
        self.containershowPopType = showPopType
        super.init(frame:  UIScreen.main.bounds)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5);
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func setupUI(){
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapACtion))
        tap.delegate = self
        self.addGestureRecognizer(tap)
        selectIndex = 0
        //containerView
        if self.containershowPopType == .center  {
            containerView.layer.cornerRadius = 6
            containerView.layer.masksToBounds = true
            containerView.frame = CGRect.init(x: (SCREEN_WIDTH-containerW)/2, y: (SCREEN_HEIGHT-containerH)/2, width: containerW, height: containerH)
        }else if self.containershowPopType == .bottom {
//            containerView.layer.cornerRadius = 6
//            containerView.layer.masksToBounds = true
             containerView.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: containerH)
        }
        self.addSubview(containerView)
        //nickNameLabel
        containerView.addSubview(nickNameLabel)
            nickNameLabel.snp.makeConstraints({ (make) in
            make.leading.equalTo(containerView.snp.leading).offset(50)
            make.trailing.equalTo(containerView.snp.trailing).offset(-50)
            make.height.equalTo(30)
            make.top.equalTo(containerView.snp.top).offset(10)
        })
    //tableView
         containerView.addSubview(tableView)
         tableView.snp.makeConstraints({ (make) in
             make.leading.equalTo(containerView.snp.leading).offset(20)
             make.trailing.equalTo(containerView.snp.trailing).offset(-20)
             make.height.equalTo(150)
             make.top.equalTo(nickNameLabel.snp.bottom).offset(10)
         })
    
   

    }
    @objc func tapACtion(){
        if self.containershowPopType == .center  {
            hideView()
        }else{
            hideToBomottm()
        }
        
    }

//    MARK:-- 显示
    open func showView(view: UIView){
         view.addSubview(self)
        if self.containershowPopType == .center {
            showViewFormCenter()
        }else{
            showFormBotoom()
        }
    }
//    MARK:-- 从中间显示
    private func showViewFormCenter(){
             ////    缩放显示（小->大）
           self.alpha = 0
           self.containerView.alpha = 0
           containerView.transform = CGAffineTransform.init(scaleX: 0, y: 0)
           UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1, options: .beginFromCurrentState, animations: {
               self.alpha = 1
               self.containerView.alpha = 1
               self.containerView.transform = CGAffineTransform.identity
               
           }) { (isFinshed) in
                self.containerView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
           }
       }

    

//    MARK:-- 显示从底部显示
     private func showFormBotoom(){
        self.alpha = 0
        self.containerView.alpha = 0
        self.containerView.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: containerH)
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1, options: .beginFromCurrentState, animations: {
            self.alpha = 1
            self.containerView.alpha = 1
            self.containerView.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT-containerH-kSafeAreaBottomHeight, width: SCREEN_WIDTH, height: containerH)
        }) { (isFinshed) in
             self.containerView.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT-containerH-kSafeAreaBottomHeight, width: SCREEN_WIDTH, height: containerH)
        }
    }
    
    //    MARK:-- 隐藏
    open func hideView(){
        self.containerView.alpha = 1
        self.alpha = 1
        containerView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1, options: .beginFromCurrentState, animations: {
           self.containerView.alpha = 0
           self.alpha = 0
           self.containerView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
           
        }) { (isFinshed) in
             self.containerView.transform = CGAffineTransform.init(scaleX: 0, y: 0)
              self.removeFromSuperview()
        }
    }
    
   //    MARK:--  向底部消失
    open func hideToBomottm(){
           self.containerView.alpha = 1
           self.alpha = 1
           self.containerView.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT-containerH-kSafeAreaBottomHeight, width: SCREEN_WIDTH, height: containerH)
           UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1, options: .beginFromCurrentState, animations: {
              self.containerView.alpha = 0
              self.alpha = 0
              self.containerView.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: containerH)
              
           }) { (isFinshed) in
                self.containerView.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: containerH)
                 self.removeFromSuperview()
           }
       }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension CustomPopView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CJKTSelecteCell",for: indexPath) as! CJKTSelecteCell
           
            ////    默认选中第一个
            //      if (kIsStrEmpty(self.defaultselectIndex)) {
            //               if ([self.tableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            //                 [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            //               }
            //
            //      }else{
            //               if ([self.tableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            //                 [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:[self.defaultselectIndex integerValue]]];
            //               }
            //
            //      }
            
            if (tableView.delegate?.responds(to: Selector.init(("didSelectRowAt:"))))! {
               tableView.delegate?.tableView?(self.tableView, didSelectRowAt: NSIndexPath.init(row: selectIndex!, section: 0) as IndexPath)
            }
            
            
            
            
            return cell
            
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let head = UIView.init()
        head.backgroundColor = UIColor.clear
        return head
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView.init()
        footer.backgroundColor = UIColor.clear
        return footer
    }
    
    //重写补全不足线的方法

    private func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if cell.responds(to: #selector(setter: self.layoutMargins)){
            cell.layoutMargins = UIEdgeInsets.zero
         }
       
        if  cell.responds(to: #selector(setter: UITableViewCell.separatorInset)){
            cell.separatorInset = UIEdgeInsets.zero
        }

    }

}

extension CustomPopView: UIGestureRecognizerDelegate{
//    解决手势冲突
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool{
        /**
         //     判断当前点击的位置是否处于 某个view 内
         */
        let point = gestureRecognizer.location(in: self.containerView)
        let isExst:Bool = self.containerView.bounds.contains(point)
        return !isExst
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        /**
         判断某个 view 是否接收手势
         */
//        print("点击的 = \(touch.view.self!)")
        let str =  String(describing: touch.view.self!) as NSString
        if str.isEqual(to: "UITableViewCellContentView") {
            return false
        }
        return true
        
    }
    
}


class CJKTSelecteCell: UITableViewCell {
    lazy var titleLab: UILabel = {
        let nl = UILabel.init()
        nl.text = "UILabel"
        nl.textColor = UIColor.gray
        nl.font = UIFont.systemFont(ofSize: 16)
        nl.textAlignment = .center
        nl.numberOfLines = 0
        return nl
    }()
    lazy var iconImgV: UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .scaleAspectFit
        return img
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {
        contentView.addSubview(titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.centerY.equalTo(contentView.snp.centerY).offset(0)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        contentView.addSubview(iconImgV)
        self.iconImgV.snp.makeConstraints { (make) in
            make.trailing.equalTo(contentView.snp.trailing).offset(-30)
            make.centerY.equalTo(contentView.snp.centerY).offset(0)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            self.iconImgV.image = kIMAGE("zan_sel")
        }else{
            self.iconImgV.image = kIMAGE("zan_nor")
        }
    }
}
