//
//  CJKTThirdViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit
import BonMot
class CJKTThirdViewController: CJKTBaseViewController {
    lazy var titleLabel: UILabel = {
        let nl = UILabel.init()
        nl.textColor = UIColor.gray
        nl.font = UIFont.systemFont(ofSize: 13)
        nl.textAlignment = .center;
        nl.numberOfLines = 0
        return nl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.barStyle(.theme)
        navigationItem.title = "书架"
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

//        let attributes = style.attributes
        
        
        
        titleLabel.frame = CGRect.init(x: 10, y: 100, width: SCREEN_WIDTH-20, height: 200)
        view.addSubview(titleLabel)
        titleLabel.attributedText = attributedString
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
