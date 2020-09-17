//
//  CJKTLoginViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/27.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import Toast_Swift
class CJKTLoginViewController: CJKTBaseViewController {
    lazy var iconImgV: UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .scaleAspectFit
        img.image = IMAGE("login_pic01")
        return img
    }()
    lazy var phoneTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "请输入手机号"
        tf.textColor = UIColor.black
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.borderStyle = .none
        tf.clearButtonMode = .whileEditing
        tf.backgroundColor = RGB(245, 245, 245)
        tf.layer.cornerRadius = 25
        tf.layer.masksToBounds = true
        tf.keyboardType = .numberPad
        return tf
    }()
    lazy var codeTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "请输入验证码111111"
        tf.textColor = UIColor.black
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.borderStyle = .none
        tf.clearButtonMode = .whileEditing
        tf.backgroundColor = RGB(245, 245, 245)
        tf.layer.cornerRadius = 25
        tf.layer.masksToBounds = true
        tf.keyboardType = .numberPad
        return tf
    }()
    private lazy var nextButon: UIButton = {
        let sn = UIButton(type: .custom)
        sn.frame = CGRect.zero
        sn.backgroundColor = UIColor.clear.withAlphaComponent(1)
        sn.setTitle("登录", for: .normal)
        sn.setTitleColor(.white, for: .normal)
        sn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sn.addTarget(self, action:#selector(searchAction(_:)), for: .touchUpInside)
        sn.backgroundColor = UIColor.hexString(hexString: "#625AFF")
        sn.layer.cornerRadius = 25
        sn.layer.masksToBounds = true
        return sn
    }()
    
    private lazy var nickNameLabel: UILabel = {
        let nl = UILabel.init().then { (lab) in
            lab.textColor = UIColor.gray
            lab.font = UIFont.systemFont(ofSize: 13)
            lab.textAlignment = .center;
        }
        return nl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI(){
        self.view.addSubview(self.iconImgV)
        self.iconImgV.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(kNavBarHeight)
            make.centerX.equalToSuperview()
        }
        self.view.addSubview(self.phoneTF)
        self.phoneTF.snp.makeConstraints { (make) in
            make.top.equalTo(self.iconImgV.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 250, height: 50))
        }
        self.view.addSubview(self.codeTF)
        self.codeTF.snp.makeConstraints { (make) in
            make.top.equalTo(self.phoneTF.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 250, height: 50))
        }
        self.view.addSubview(self.nextButon)
        self.nextButon.snp.makeConstraints { (make) in
            make.top.equalTo(self.codeTF.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 250, height: 50))
        }
        
    }
    @objc func searchAction(_ button: UIButton){
        let text: String = self.phoneTF.text!
        let codetext: String = self.codeTF.text!
        guard text.isEmpty == false else {
            self.view.makeToast("请输入正确的手机号")
            return
        }
        if !text.isMobilePhone() {
            self.view.makeToast("请输入正确的手机号")
        }else if codetext.isEmpty {
            self.view.makeToast("请输入验证码")
        }else{
             loadData()
        }
    }
    
    func loadData(){
        let parameters = [
            "phone":self.phoneTF.text!,
            "code":self.codeTF.text!,
            "code_type":"Login",
            ] as [String : Any]
        
        CJKTMoyaAPIProvider.request(.logIn_code(dict: parameters)) { (result) in
            
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
