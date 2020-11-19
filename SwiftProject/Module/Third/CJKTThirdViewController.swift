//
//  CJKTThirdViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import BonMot
import PKHUD
import SwiftyAttributes
class CJKTThirdViewController: CJKTBaseViewController {
    lazy var titleLabel: UILabel = {
        let nl = UILabel.init()
        nl.textColor = UIColor.gray
        nl.font = UIFont.systemFont(ofSize: 13)
        nl.textAlignment = .center;
        nl.numberOfLines = 0
        return nl
    }()
    
//    用UIStackView管理的红绿蓝三个view
    private lazy var stackView: UIStackView = {
        let stackView  = UIStackView.init(arrangedSubviews: [redView, greenView, blueView])
        // item间距
        stackView.spacing = 30
        // 水平方向布局
        stackView.axis = .horizontal
        // 底部对齐
        stackView.alignment = .bottom
        // 等间距
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var redView: UIView = {
        let redView = UIView()
        redView.backgroundColor = .red
        redView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40, height: 40))
        }
        return redView
    }()
    
    private lazy var greenView: UIView = {
        let greenView = UIView()
        greenView.backgroundColor = .green
        greenView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 30, height: 30))
        }
        return greenView
    }()
    
    private lazy var blueView: UIView = {
        let blueView = UIView()
        blueView.backgroundColor = .blue
        blueView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 50, height: 50))
        }
        return blueView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.barStyle(.theme)
        navigationItem.title = "书架"
        
        
//BonMot
       let quote = """
            I used to love correcting people’s grammar until \
            I realized what I loved more was having friends.
            -Mara Wilson
            """

        let style = StringStyle(
            .font(UIFont(name: "AmericanTypewriter", size: 17)!),
            .lineHeightMultiple(1.2),//行高
            .color(.darkGray),//颜色
            .underline(.single, UIColor.red)//下划线
            
        )

        let attributedString = quote.styled(with: style)

        
//  SwiftyAttributes示例
        
        let fancyString11 = "Hello World!".withTextColor(.blue).withUnderlineStyle(.single)
        
        let fancyString22 = "Hello World!".withAttributes([
            .backgroundColor(.magenta),
            .strokeColor(.orange),
            .strokeWidth(1),
            .baselineOffset(5.2)
        ])
        let fancyString33 = "Hello".withFont(.systemFont(ofSize: 12)).withUnderlineStyle(.single) + " World!".withFont(.systemFont(ofSize: 18)).withTextColor(.blue) + " World!".withFont(.systemFont(ofSize: 28)).withTextColor(.red)
        
        
        titleLabel.frame = CGRect.init(x: 10, y: 80, width: SCREEN_WIDTH-20, height: 200)
        view.addSubview(titleLabel)
        titleLabel.attributedText = fancyString33
//        attributedString
        
        
        view.addSubview(stackView)
        // 不设置宽度，让它宽度自适应
        stackView.snp.makeConstraints { (make) in
           make.top.equalTo(200)
           make.right.equalToSuperview().offset(-20)
           make.height.equalTo(50)
         }

        
        
        let searchBar = UISearchBar.init(frame: CGRect.init(x: 30, y: 300, width: 200, height: 44))
        view.addSubview(searchBar)
        searchBar.barTintColor = UIColor.red

        searchBar.textField.placeholder = "11111"
        searchBar.textField.font = UIFont.systemFont(ofSize: 22)
        searchBar.textField.textColor = UIColor.red
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // remove或者隐藏，stackView都会重新布局
        greenView.isHidden = true
   
//        var stringArray = ["Bob", "Bobby", "SangJoon"]
//        var intArray = [1, 3, 4, 5, 6]
//        var doubleArray = [1.0, 2.0, 3.0]
//        
//        printElementFromArray(a: stringArray)
        
//        HUDTool.showToast(title: "啊哈哈")
//        HUDTool.showToastActivity()
//        kDispatchAfter(2) {
//            HUDTool.hideToastActivity()
//        }
        
//       let customEmptyView = CustomEmptyView.init(frame: CGRect.init(x: SCREEN_WIDTH/2, y: SCREEN_WIDTH/2, width: SCREEN_WIDTH, height: SCREEN_HEIGHT/2))
//        customEmptyView.tapClosure = {
//            kLog("刷新")
//        }
//        customEmptyView.snp.makeConstraints { (make) in
//            make.height.equalTo(SCREEN_HEIGHT/2+150)
//        }
//        view.addSubview(customEmptyView)
    
        
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
