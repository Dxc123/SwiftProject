//
//  CJKTTabBarController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class CJKTTabBarController: UITabBarController {
    var indexFlag = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isTranslucent = false
        let homeVC = CJKTHomeViewController()
        addChildViewController(homeVC,
        title: "首页",
        image: UIImage(named: "tab_home"),
        selectedImage: UIImage(named: "tab_home_S"))
        /// 分类
        let secondVC = CJKTSecondViewController()
        addChildViewController(secondVC,
                               title: "分类",
                               image: UIImage(named: "tab_class"),
                               selectedImage: UIImage(named: "tab_class_S"))
        /// 书架
        let thirdVC = CJKTThirdViewController()
        addChildViewController(thirdVC,
                               title: "书架",
                               image: UIImage(named: "tab_book"),
                               selectedImage: UIImage(named: "tab_book_S"))
        
        
        /// 我的
        let mineVC = CJKTFourViewController()
        addChildViewController(mineVC,
                               title: "我的",
                               image: UIImage(named: "tab_mine"),
                               selectedImage: UIImage(named: "tab_mine_S"))
//        let loginVC = kLoginViewController()
//        addChildViewController(loginVC,
//                               title: "登录",
//                               image: UIImage(named: "tab_mine"),
//                               selectedImage: UIImage(named: "tab_mine_S"))
//        
        
    }
    

    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
           
           childController.title = title
           childController.tabBarItem = UITabBarItem(title: nil,
                                                     image: image?.withRenderingMode(.alwaysOriginal),
                                                     selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
           
           if UIDevice.current.userInterfaceIdiom == .phone {
               childController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
           }
           addChild(CJKTNavigationController(rootViewController: childController))
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

extension CJKTTabBarController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
    
    
     override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            if let index = tabBar.items?.firstIndex(of: item) {
                if indexFlag != index {
                    animatonwithIndex(index: index)
                }
            }
        }
    
        private func animatonwithIndex(index: Int){
            var arrViews = [UIView]()
    //        遍历tabbar子视图拿到可点击的item放入数组
            for tabBarButton in tabBar.subviews {
                if tabBarButton.isKind(of: NSClassFromString("UITabBarButton")!) {
                    arrViews.append(tabBarButton)
                }
            }
            
            // 缩放动画
            let animation = CABasicAnimation.init(keyPath: "transform.scale")
    //        动画函数
            animation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeInEaseOut)
            animation.duration = 0.1
            animation.repeatCount = 1
            animation.autoreverses = true//执行完复位
            animation.fromValue = NSNumber.init(value: 0.7)
            animation.toValue = NSNumber.init(value: 1.1)
            arrViews[index].layer.add(animation, forKey: nil)
            indexFlag = index
        }
}
